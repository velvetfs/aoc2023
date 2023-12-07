fn main() {
    let input = r#"Time:        48     98     90     83
Distance:   390   1103   1112   1360"#;
//     let input = r#"Time:      7  15   30
// Distance:  9  40  200"#;
    part2(input);
}

fn part1(input: &str) {
    let mut lines = input.lines();
    let times = lines.next().unwrap().split(":").nth(1).unwrap().trim().split_whitespace().map(|x| x.parse::<u32>().unwrap()).collect::<Vec<u32>>();
    let distances = lines.next().unwrap().split(":").nth(1).unwrap().trim().split_whitespace().map(|x| x.parse::<u32>().unwrap()).collect::<Vec<u32>>();
    let time_distance_pairs = times.iter().zip(distances.iter()).collect::<Vec<(&u32, &u32)>>();
    let mut answer = 1;
    for (time, distance) in time_distance_pairs {
        let mut num_solutions = 0;
        for x in 0..=*time {
            if (x * (time - x)) > *distance {
                num_solutions += 1;
            }
        }
        answer *= num_solutions;
    }
    println!("answer: {}", answer)
}

fn part2(input: &str) {
    let mut lines = input.lines();
    let time = lines.next().unwrap().split(":").nth(1).unwrap().replace(" ", "").trim().parse::<f64>().unwrap();
    let distance = lines.next().unwrap().split(":").nth(1).unwrap().replace(" ", "").trim().parse::<f64>().unwrap();

    let a: f64 = -1.0;
    let b = time;
    let c = -distance;
    let x = (-b + (b * b - 4.0 * a * c).sqrt()) / (2.0 * a);
    let lowest = x.ceil();
    let middle = (time / 2.0).floor();
    let answer = 2.0 * ((middle - lowest) + 1.0).floor();
    println!("answer: {}", answer)
}