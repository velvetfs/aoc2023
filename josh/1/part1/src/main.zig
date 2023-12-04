const std = @import("std");
const is_digit = std.ascii.isDigit;

pub fn main() !void {
    const startTime = std.time.milliTimestamp();
    var file = try std.fs.cwd().openFile("input.txt", .{});
    defer file.close();

    const stdout = std.io.getStdOut().writer();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    var buf: [1024]u8 = undefined;
    var total: u16 = 0;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        var first_digit: u8 = undefined;
        var last_digit: u8 = undefined;

        for (line) |c| {
            if (is_digit(c)) {
                first_digit = c;
                break;
            }
        }
        var i: usize = line.len;
        while (i > 0) {
            i -= 1;
            if (is_digit(line[i])) {
                last_digit = line[i];
                break;
            }
        }

        const num: u8 = (first_digit - '0') * 10 + (last_digit - '0');

        total += num;
    }
    try stdout.print("Total: {d}\n", .{total});
    const endTime = std.time.milliTimestamp();
    const duration = endTime - startTime;
    std.debug.print("Execution time: {} ms\n", .{duration});
}

