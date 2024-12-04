const std = @import("std");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;

const util = @import("util.zig");
const gpa = util.gpa;

const data = @embedFile("data/day03.txt");
const small = @embedFile("data/day03small.txt");
const small2 = @embedFile("data/day03small2.txt");

pub fn main() !void {
    //part 1
    const process = "do()" ++ data;
    const sum = getMultSum(process);
    print("part 1: {d}\n", .{sum});

    var dosIter = tokenizeSeq(u8, process, "do()");
    var part2Sum: i32 = 0;
    while (dosIter.next()) |dosAndDonts| {
        var dontIter = tokenizeSeq(u8, dosAndDonts, "don't()");
        const dos = dontIter.next() orelse "";
        part2Sum += getMultSum(dos);
    }
    print("part 2: {d}\n", .{part2Sum});
}

fn getMultSum(processData: []const u8) i32 {
    var starts = tokenizeSeq(u8, processData, "mul(");
    var sum: i32 = 0;
    firstloop: while (starts.next()) |mul| {
        var ends = tokenizeSca(u8, mul, ')');
        const nums = ends.next();
        if (nums == null) {
            continue :firstloop;
        } else {
            var numsiter = tokenizeSca(u8, nums.?, ',');
            const op1s = numsiter.next() orelse "0";
            const op2s = numsiter.next() orelse "0";
            const op1: i32 = parseInt(i32, op1s, 10) catch continue :firstloop;
            const op2: i32 = parseInt(i32, op2s, 10) catch continue :firstloop;
            if (op1 >= 0 and op1 < 1000 and op2 >= 0 and op2 < 1000) {
                sum += op1 * op2;
            }
        }
    }
    return sum;
}
// Useful stdlib functions
const tokenizeAny = std.mem.tokenizeAny;
const tokenizeSeq = std.mem.tokenizeSequence;
const tokenizeSca = std.mem.tokenizeScalar;
const splitAny = std.mem.splitAny;
const splitSeq = std.mem.splitSequence;
const splitSca = std.mem.splitScalar;
const indexOf = std.mem.indexOfScalar;
const indexOfAny = std.mem.indexOfAny;
const indexOfStr = std.mem.indexOfPosLinear;
const lastIndexOf = std.mem.lastIndexOfScalar;
const lastIndexOfAny = std.mem.lastIndexOfAny;
const lastIndexOfStr = std.mem.lastIndexOfLinear;
const trim = std.mem.trim;
const sliceMin = std.mem.min;
const sliceMax = std.mem.max;

const parseInt = std.fmt.parseInt;
const parseFloat = std.fmt.parseFloat;

const print = std.debug.print;
const assert = std.debug.assert;

const sort = std.sort.block;
const asc = std.sort.asc;
const desc = std.sort.desc;

// Generated from template/template.zig.
// Run `zig build generate` to update.
// Only unmodified days will be updated.
