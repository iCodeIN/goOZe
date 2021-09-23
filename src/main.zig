const std = @import("std");

extern const STACK_START: usize;

export fn _start() callconv(.Naked) void {
    asm volatile (
        "nop"
        :
        : [STACK_START]"{sp}"(&STACK_START)
    );

    main();
}

fn writeCallback(context: void, str: []const u8) !usize {
    const uart0 = @intToPtr(*volatile u8, 0x10000000);

    for (str) |c| {
        uart0.* = c;
    }

    return str.len;
}

fn main() void {
    const Writer = std.io.Writer(void, error{}, writeCallback);

    try std.fmt.format(Writer{ .context = {} }, "hello\r\n", .{});
}
