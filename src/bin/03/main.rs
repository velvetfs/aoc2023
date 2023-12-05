extern crate regex;

use std::collections::{HashMap, HashSet, VecDeque};
use regex::Regex;

fn main() {
    // let re = Regex::new(r"(\d+)+").unwrap();
    // let text = "123 abc 456 def 789";
    //
    // for m in re.find_iter(text) {
    //     println!("Matched {:?} at position {:?}..{:?}", &m.as_str(), m.start(), m.end());
    // }
    let idxs_to_check = vec![1, 2, 3];
    for num in idxs_to_check {
        println!("{}", num);
    }
}

fn part2() {
    let my_str = get_my_str();
    let lines = my_str.split("\n");
    let mut number_dicts = VecDeque::new();
    let mut star_idxs_lists = VecDeque::new();
    let mut visited_num_sets = VecDeque::new();
    let mut found_nums_maps = VecDeque::new();
    let mut line_num = 0;

    for line in lines {
        let mut visited_nums = HashSet::new();
        let found_num_map = HashMap::new();
        let num_re = regex::Regex::new(r"(\d+)+").unwrap();
        let mut number_dict = HashMap::new();
        for m in num_re.find_iter(line) {
            let num = m.as_str().parse::<usize>().unwrap();
            let mut val_map = HashMap::new();
            val_map.insert("val", num);
            number_dict.insert(m.start(), val_map);
            if !number_dict.contains_key(&(m.end() - 1)) {
                let mut pointer_map = HashMap::new();
                pointer_map.insert("pointer", m.start());
                number_dict.insert(m.end() - 1, pointer_map);
            }
        }
        number_dicts.push_back(number_dict);
        let star_re = regex::Regex::new(r"\*").unwrap();
        let mut star_idxs = Vec::new();
        for m in star_re.find_iter(line) {
            star_idxs.push(m.start());
        }
        star_idxs_lists.push_back(star_idxs);

        for star_idxs_list in &star_idxs_lists {
            for star_idx in star_idxs_list {
                let idxs_to_check = vec![0.max(star_idx - 1), *star_idx, (line.len() - 1).min(star_idx + 1)];
                for number_dict in &number_dicts {
                    for idx in idxs_to_check.clone() {
                        if number_dict.contains_key(&idx) {
                            let word_start_idx = *number_dict.get(&idx).unwrap().get("pointer").unwrap_or(&idx);
                            let word_tuple = (line_num, word_start_idx);
                            if !visited_nums.contains(&word_tuple) {
                                visited_nums.insert(word_tuple);
                                let mut found_num_map = HashMap::new();
                                let star_tup = (line_num, star_idx);
                                if !found_num_map.contains_key(&star_tup) {
                                    found_num_map.insert(star_tup, Vec::new());
                                }
                                found_num_map.get(&star_tup).unwrap().push(*number_dict.get(&idx).unwrap().get("val").unwrap());
                            }
                        }
                    }
                    if line_num == 3 {
                        line_num = 0;
                    } else {
                        line_num += 1
                    }
                }
            }
        }
        visited_num_sets.push_back(visited_nums);
        found_nums_maps.push_back(found_num_map);
        if
    }
}


fn get_my_str() -> String {
    return r#"................458...689.556..3............197......582........720.........................515..352..286.........670.741.....895.626.......
    ...910.743..........................13..........................*.............775...956........@.........*................971.-.............
    ....*......406.507.97..846..............968+.........253........730...574............#....308......*.....798..............*.......894.......
    ....555...............*......%...............980.+43..=..239..........*......495................638.111.........*490...124...*........576...
    .............807......176.....820...=.........*.........@................144*...........324..............82..745............775.............
    ...509.../..../...85/......9.........574....744....586....../..796................763...............................759............#........
    .....*...541...................930%................*.....831............494...44........799.....................870*.......834.215.675......
    .....23..................391.........17.......500..329.................+.....*......................431.....................-...........19..
    ........................#.............*.704+./..................................152............=61....................668..............*....
    ........894....334.............766.817.........302.-367.663......670.....+..........628..............592..................652......130..885.
    ....228...........*...183..................169*...........*...............836..........*...230............45.....$....200....#.......&......
    .......*........920..*....&........................865........60...=..........901-.....766.*...815..........*....410...*...............227..
    .....#.623..........183...28.....460....861......./............*....151....................759...*......341..84......928....906..470........
    ..148........636................*........&....376...387=......187............741.308.............413.......................*.......*........
    ...............-.158........362..220.......+.........................$..553..*.....%...........*.........359=......373....706.518$..274.....
    .....688..279........441......+........320..596.............../.#...989...*....%.....108....139.216...........-...*.........................
    ......*......*399.......*.506.........*....................282..344......610...462..%...............876.....287...230......$.......#633.....
    ...221...111.........235....*...%377.319.............503.......................................402...+...=...............224.............980
    ............*.............992...........................*..........945.891.................312*........747...........-......................
    .........350.........................147....957.314.183.483...........*.....................................613#.....880.........$177.......
    .....................146*409..........*.....................-................392......892.....981...246.437......790........................
    ......440..@860...............205*421..791.................652...456..$........................-....*.......565...%......140....511.........
    .......*.............762.........................513.....#........*...596..656*.....959............292.476..............*........*..........
    .....276.............&...167....108.819...............845.........950..........577.*..........533.........+...........323.......12..........
    .........................*.......*...*.......348...........570.........998..........308..........*.765.......................76......558.897
    ............530....992....512...560...755......*..569.........#...................%.....461...896.....&...813......763..............*.......
    424..........+....*.....*.....@...............922.....................445.99......88.......................=...803....*..14.440....139..349.
    ...*............155..417.911.383.........434.......+...345.763..279...#.....*6...................................&.814....*..#..............
    ...147.............................762...+........856..*....*....#..#............82..%.........=.......*................619.................
    .......#668..........88.....................-..........448.710......25.427........&.740....*...44.608.809........%..................119.....
    ..................*........&....../........86.....724.....................*...924..........240....$.......935..945.....545.641.......@......
    .....578.......565.749...342....338..................*786...305.....315..627.+........924.............+.....................................
    ........*135.................@......786.........911........*......*..............193.@...........862..337.......879.......992..681.598...207
    ..........................646..........*105.......*......682...683.53.849..750...*.......+......*...............*...787*..........*.........
    ............899......230.....................792...779....................@......918..955...731..233...........496..................109.....
    ...905.........*.......*....../...550*675...*..........652..........$581.......................*..........................$.....204...*.....
    ....*...146.171........162.944.............613...34.........563.321......648.................278.....69............519.....558.+.....573....
    ..134....*.........260............815*20..............286....*.....*....*.....100...261.....................=850....*.......................
    ......872.........+.....................................*..971..669....733...$.........*..........610............983..801=..........153.....
    601.........484@.........109..........317..............424............................298.........*...976.....*.............................
    ...*....................*............*....316.201...........935*................................22...&.......137...336.....557........4.....
    ..745.........286.....989..........582.......*..................277...795..........335.................................520*............*....
    .............=....&.............85..................=...19...................281+..@.............940.+970....318.................281..216...
    ................361................178../.........725.......*.........548..................*190...*..........$.....%.....&..........*.......
    ..57*......131*.........436*375.....#...168..............305.435........*...........674..........245....$.......$...404.270......812..707...
    .....440.......318.525.........................*.........................540....799...*................344...432.......................*....
    ............$......*....526...730..142......927.785............................&.....509.......45................849*.......276......993....
    ..362*541...187....393........../...........................365...........442.................*....105....*..........256....................
    ........................568.......&.98.........+.=427./718..*......500#......#............692.547.&....753........=.........................
    .........652@...........*.......836.&........333...........144.................*...33....#..................593.540.....968..822.....450....
    ..............518....442............................521.............884.303.85.483................594.......*..........@......*.......*.....
    .......278......*........674..............844...435*.................*..-...&.............837......*.....333..#849..........607.......177...
    .........&.......302........*........*519....*...............270....174....................*......579................66#..........425.......
    ..............*......*......205...833.........672...............*........269.440...771.....446.................=.*...............*..........
    .134.527.....14...910.845.....................................113..-....*......*..*..........................579.171.........287..828.......
    ....*.....................726.942..83..........264.752..............188.765..359...182................380..............-.....*...........734
    ..........................*........#.............$.........322..............................*...........$....@830.....989.246...&...........
    .....*260..452.325.................................................246...................466.915..............................-..417....&558
    ..961........%...........#....203*690..659..@.....424*..............*.............*.................797.363...$813...........340............
    ........................260................608........565.......@....856.......576.159.....691..23.....*................*562.........373....
    ......235.962..311-................*....#......218...........129............@..............@......*354................33................*...
    649..*....&..........140......910..613.544..........420.............903*....825...............................139.819............595........
    .....349......318.....$..746...*.............264......$..&...607........879................................+.....*...............&..........
    ...........$......259....*......609.............*.......619.....*.............#...68.45*...560*723..........171....12=....277.........563...
    ...39...428.......*.......551...................962...=..........620........776....*.......................................*..626.......*...
    ...&..............370.#.......*807..103...820.........842...562*.................646..48....%..412...........684*754....143..*..............
    ............866.......77...225.............&......152...........241.........628=........*.462....%.926........................990..439......
    .352.............................&615........633+...*............................996..388..........*...516..............107%..........*743..
    ....*...............970.......%...................564........................99..../........*790..239.*......94....688......................
    .211.....342+.........*....521...............788...............+........839............+.265...........486................637......+...@....
    .....................82..............187...#....*731..230.......50...................480.......8.................................507....660.
    ...103..762*436.523*.......................250.........*...#...................................*...518.916...........................$......
    ...*................439....553....................479.466.553............699#..3.$...........695.......*....................=.......923.714.
    ..867.+971....45...........*..........669.....885................605.272......#...175...836...........15...................257..144.........
    ............................579.......#.............................*.....877..........*.......330........141=..............................
    .................................881......98..400.517....................*....453......509........*..................................879....
    ....99.........300.882.....670....*............*...................712.119...*................473..290...630..........510......@.....*......
    .../.....979...../....*959..+.....189........123...........402......&......394....329...........%.........*.......208*.......583...785...113
    ...................&............*........402......369..521........................*........314.............7.............564................
    ...............555.430.......630.854........%..........+......676...........980+.........................................*...............849
    ...........531..=.......................*......139............-..........................5..969=....338.........464.......508.......843.....
    .............*.......118.............999.915.....*.&.....................755.........501*.............-....2.........766........3......*792.
    ...............@706..&...258.#501.............442...469..........332.327.*....@..............................*..........*...661..*..........
    ...955.....900......................#.....986..............705%.*.....-..884..290...177*531........632......802...936..39.....$...952.......
    ..........@...........483........553..544..#......920............340.............................../.................*.................396..
    ...149................*..............#................446....405.......555...........................98....313........834.#.....%...../.....
    ....*...409...266...29.......283..............=................*........*............%830....748....*......*..............457...592.........
    ...310.*......./....................*......138...197..........169...308.387..923............*........598....50...980........................
    ........178.............236......865.134...........*.436..772...................%..688.&.....850.66.........................796*897....679..
    ................170.......=.784..........$463...871..*.....*...338.........16........*.876.......*....................368*..........#...*...
    ...........270.....*682.......+.....................129..802....*...505......*822.834.........575.....309....@.577........6......926..632...
    .....448.....@...*................105..960.480..................293.*....................598......$...*....686....*..759....13..............
    .........535...507.........@.........@....*............390..........42.........919....-........928..584.............%........*..............
    ....12#.................661.....535.............397........................*.....*.....788...................936....................314.....
    ................................./.........417......528..492.......202..654.143.476.73.....796........282....*........317..............-....
    .....511....................396.............*.............#.........................%.............&........861........*....919..954.........
    ......*............704*853........396.772...407.....499......$.....393.....-317.648..........262.72..............482.418.....-.......661*466
    ...387...300...................+....=../........688*........895.2...*................/........*.......25.......................268..........
    ............+................253.........16.......................665.......936..451.222..299.498.....*......*669.....652........*.218......
    .................49....43..........567...*............%...226.........188.....*...$.........*......510....717.....$53..*......474....*......
    ...........#..........................#...906...206..479...#.............*.599.............598.........................904..&.....808.......
    .........876...............295..................-.................998...34.........=348........499.81...........@..........681..............
    ....452........407.350.......*..@971................721............*....................129..-...#.............508....744...................
    .......*17.....*.......739.136........................%.........635.........310.487....*.....746.....964.....+...........*.....639..........
    ...........314..471.............................768.................640.......=.../..387.............*....420.............975...-..230...533
    ..............*.......389.........&.372........%.......537.....799.....*.................678....661...531......460..................-.......
    ............97.........=....180.943...*...=.......................*....424..................#.....*...........*..............$..............
    ...803..............................529....264...............$...810..........810..................183......429...730*52.709..896..696*481..
    ......*82.570-............$.......%...................754...528..........+399....*893.....176*............................%.................
    ........................731.......679...........110*.....*........749.........................325.803*.....130..................+.820*541...
    ......739*.....707..........@577......4....210......21.396..........*..........822.930................689......250.749.774...539............
    ..........113.........................*......-..477.........112.....881......$....*.....$....$...........................*..................
    .....+...............................809..........*........................459.......496...354....979...231....31.....-..541...168...708....
    .....954..........642...267........*.....453......812...993............................../.......*........*..........267..........-....@....
    .............9.........$.........307......*...364.........*..266.757/...800......805*197.453...758.617.....390................329...........
    ..............*954...................*...358..*..........859...*........*....848...................*.....-...............+....*...43.671....
    .........107........596...*.......941........555.....378......824.348...207.....*....469/..352*..........474...........961.848...*......*...
    ............*......*....659..............+86........*.............%...........898..............307...............824.............735...584..
    ....540....734...463...........374..............204.........633*......................................627.......%.......%...%...............
    ....*................727..606............752.......+............522........@.............187&...$..89.+................311.384..............
    .........368*901...................120........308......783..................361................901..........770.163.............348...278...
    .........................10..874....*...................*................................826.......*440.=.....#.*...631...........*.........
    ..........145...........*.......*..665..567....&.........486.........%869......679........*.....369......195....890.*...4........100........
    ......664....@...314.....49....859.....%.......8.............971..........905.....&......595........................742...............340...
    ........*................................852........120.......*....80....*...................823.....%.........476.........893..............
    ........748.178.50*479........863....=.$..............*...........*....808...495...305......*.....684...47............./......*634..........
    .....#........*.........&.....$.....83..674.571....575...........756...............*....*....546........-.....*124...199.758................
    ...346..937..70.........569..................@.........12....=...............-...742....694................405...........*.......$..........
    ...................................617...........958....*.778........540+.293.............................................502.834.....537...
    ...#.......47................908....*..............*.622.......................980.390#......785.104....................-...................
    ....261....*.......756..............555...%......893...............810..........-........804...*...$.942........739..773....................
    .........390...765.......655......&......497.........885.....2.....$.................89../....636......*.862.......%................717.....
    .......2........*...897....@....354..+...........959...*....@......................@........*.......576..@.............698..................
    ...............307..../.$.............100..........*...324....*.821....377..........939..134.625.......................*....................
    .........................556.....................63........307...$.....*......=.....................462.....427.........822............681..
    ....................+........................................................864..........8.....550*............665...........#...956..*....
    .780.......864.......435......811....760.................452.........................................&..886......*...........792..@.....245.
    ....*.........../............*..............661%.213........=.........310/.726.....739...791...387.123............924...............281.....
    ..139..........45......#...316....=................*..........678*..........*..@10..*......*..*.........*...61-......................*......
    .....................815.........786................186...........640......388.......415....4..36.....894.........................303........"#.to_string();
}