const std = @import("std");
const is_digit = std.ascii.isDigit;

pub fn main() !void {
    const startTime = std.time.milliTimestamp();
    var file = try std.fs.cwd().openFile("input.txt", .{});
    defer file.close();

    const stdout = std.io.getStdOut().writer();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    const ALPHA_NUMBERS: [9][]const u8 = [_][]const u8{ "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" };

    var buf: [1024]u8 = undefined;
    const total: u16 = 0;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        var first_digit: u8 = undefined;
        const last_digit: u8 = undefined;
        _ = last_digit;

        var buffer: [256]u8 = undefined;
        var stream = std.io.fixedBufferStream(&buffer);
        var writer = stream.writer();
        var bytes_written: u64 = 0;

        var gpa = std.heap.GeneralPurposeAllocator(.{}){};
        const allocator = gpa.allocator();
        var possible_solution = std.StringHashMap(bool).init(allocator);
        var line_position: u8 = 0;

        for (line) |c| {
            if (is_digit(c)) {
                first_digit = c;
                break;
            } else {
                var count: u8 = 0;
                var some_true: bool = false;
                const u8toarr = &[_]u8{c};
                bytes_written += writer.write(u8toarr) catch unreachable;
                for (ALPHA_NUMBERS) |str| {
                    count = count + 1;
                    try stdout.print("c, str: {c} {c}\n", .{ c, str[bytes_written] });
                    if (c == str[bytes_written]) {
                        possible_solution.put(str, true) catch unreachable;
                        some_true = true;
                        try stdout.print("str.len, bytes_written: {d} {d}\n", .{ str.len, bytes_written });
                        if (str.len == bytes_written) {
                            first_digit = count + 1;
                            break;
                        }
                    } else {
                        possible_solution.put(str, false) catch unreachable;
                    }
                }
                if (first_digit > 0) {
                    break;
                }
                if (!some_true) {
                    buffer = undefined;
                    possible_solution.clearAndFree();
                    bytes_written = 0;
                }
            }
            line_position = line_position + 1;
        }
        try stdout.print("First digit: {d}\n", .{first_digit});

    }
    try stdout.print("Total: {d}\n", .{total});
    const endTime = std.time.milliTimestamp();
    const duration = endTime - startTime;
    std.debug.print("Execution time: {} ms\n", .{duration});
}
