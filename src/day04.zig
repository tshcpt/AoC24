const std = @import("std");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;

const util = @import("util.zig");
const gpa = util.gpa;

const data = @embedFile("data/day04.txt");
const small = @embedFile("data/day04small.txt");

pub fn main() !void {
    const process = data;

    var wordsearch = List([]const u8).init(gpa);
    defer _ = wordsearch.deinit();

    var lines = tokenizeSca(u8, process, '\n');
    while (lines.next()) |line| {
        try wordsearch.append(line);
    }
    //var part1sum = 0;
    var downs: u32 = 0;
    var ups: u32 = 0;
    var rights: u32 = 0;
    var lefts: u32 = 0;
    var rightups: u32 = 0;
    var rightdowns: u32 = 0;
    var leftups: u32 = 0;
    var leftdowns: u32 = 0;
    var masmas: u32 = 0;
    var massam: u32 = 0;
    var samsam: u32 = 0;
    var sammas: u32 = 0;
    for (0..wordsearch.items.len) |i| {
        for (0..wordsearch.items[i].len) |j| {
            if (is_xmas_right(wordsearch, i, j)) rights += 1;
            if (is_xmas_left(wordsearch, i, j)) lefts += 1;
            if (is_xmas_up(wordsearch, i, j)) ups += 1;
            if (is_xmas_down(wordsearch, i, j)) downs += 1;
            if (is_xmas_rightup(wordsearch, i, j)) rightups += 1;
            if (is_xmas_rightdown(wordsearch, i, j)) rightdowns += 1;
            if (is_xmas_leftup(wordsearch, i, j)) leftups += 1;
            if (is_xmas_leftdown(wordsearch, i, j)) leftdowns += 1;
        }
    }
    for (0..wordsearch.items.len - 2) |i| {
        for (0..wordsearch.items[i].len - 2) |j| {
            if (is_masmas(wordsearch, i, j)) masmas += 1;
            if (is_massam(wordsearch, i, j)) massam += 1;
            if (is_samsam(wordsearch, i, j)) samsam += 1;
            if (is_sammas(wordsearch, i, j)) sammas += 1;
        }
    }
    print("part 1:{d}\n", .{rights + lefts + ups + downs + rightups + rightdowns + leftups + leftdowns});
    print("part 2:{d}\n", .{masmas + massam + samsam + sammas});
}
fn is_xmas_right(ws: List([]const u8), i: usize, j: usize) bool {
    return (j < ws.items[i].len - 3) and
        (ws.items[i][j] == 'X' and
        ws.items[i][j + 1] == 'M' and
        ws.items[i][j + 2] == 'A' and
        ws.items[i][j + 3] == 'S');
}
fn is_xmas_left(ws: List([]const u8), i: usize, j: usize) bool {
    return (j > 2) and
        (ws.items[i][j] == 'X' and
        ws.items[i][j - 1] == 'M' and
        ws.items[i][j - 2] == 'A' and
        ws.items[i][j - 3] == 'S');
}
fn is_xmas_down(ws: List([]const u8), i: usize, j: usize) bool {
    return (i < ws.items.len - 3) and
        (ws.items[i][j] == 'X' and
        ws.items[i + 1][j] == 'M' and
        ws.items[i + 2][j] == 'A' and
        ws.items[i + 3][j] == 'S');
}
fn is_xmas_up(ws: List([]const u8), i: usize, j: usize) bool {
    return (i > 2) and
        (ws.items[i][j] == 'X' and
        ws.items[i - 1][j] == 'M' and
        ws.items[i - 2][j] == 'A' and
        ws.items[i - 3][j] == 'S');
}
fn is_xmas_rightup(ws: List([]const u8), i: usize, j: usize) bool {
    return (i > 2 and j < ws.items[i].len - 3) and
        (ws.items[i][j] == 'X' and
        ws.items[i - 1][j + 1] == 'M' and
        ws.items[i - 2][j + 2] == 'A' and
        ws.items[i - 3][j + 3] == 'S');
}
fn is_xmas_leftup(ws: List([]const u8), i: usize, j: usize) bool {
    return (i > 2 and j > 2) and
        (ws.items[i][j] == 'X' and
        ws.items[i - 1][j - 1] == 'M' and
        ws.items[i - 2][j - 2] == 'A' and
        ws.items[i - 3][j - 3] == 'S');
}
fn is_xmas_rightdown(ws: List([]const u8), i: usize, j: usize) bool {
    return (i < ws.items.len - 3 and j < ws.items[i].len - 3) and
        (ws.items[i][j] == 'X' and
        ws.items[i + 1][j + 1] == 'M' and
        ws.items[i + 2][j + 2] == 'A' and
        ws.items[i + 3][j + 3] == 'S');
}
fn is_xmas_leftdown(ws: List([]const u8), i: usize, j: usize) bool {
    return (i < ws.items.len - 3 and j > 2) and
        (ws.items[i][j] == 'X' and
        ws.items[i + 1][j - 1] == 'M' and
        ws.items[i + 2][j - 2] == 'A' and
        ws.items[i + 3][j - 3] == 'S');
}
fn is_masmas(ws: List([]const u8), i: usize, j: usize) bool {
    return (ws.items[i][j] == 'M' and
        ws.items[i + 1][j + 1] == 'A' and
        ws.items[i + 2][j + 2] == 'S' and
        ws.items[i + 2][j] == 'M' and
        ws.items[i][j + 2] == 'S');
}
fn is_massam(ws: List([]const u8), i: usize, j: usize) bool {
    return (ws.items[i][j] == 'M' and
        ws.items[i + 1][j + 1] == 'A' and
        ws.items[i + 2][j + 2] == 'S' and
        ws.items[i + 2][j] == 'S' and
        ws.items[i][j + 2] == 'M');
}
fn is_samsam(ws: List([]const u8), i: usize, j: usize) bool {
    return (ws.items[i][j] == 'S' and
        ws.items[i + 1][j + 1] == 'A' and
        ws.items[i + 2][j + 2] == 'M' and
        ws.items[i + 2][j] == 'S' and
        ws.items[i][j + 2] == 'M');
}
fn is_sammas(ws: List([]const u8), i: usize, j: usize) bool {
    return (ws.items[i][j] == 'S' and
        ws.items[i + 1][j + 1] == 'A' and
        ws.items[i + 2][j + 2] == 'M' and
        ws.items[i + 2][j] == 'M' and
        ws.items[i][j + 2] == 'S');
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
