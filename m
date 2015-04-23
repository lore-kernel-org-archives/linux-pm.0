From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 00/03] irqchip: renesas-irqc: Fine grained Runtime PM support
Date: Thu, 23 Apr 2015 11:51:12 +0200
Message-ID: <CAMuHMdWN5E35e8CEzOKYRo4PXkzjMpxErg6akCOHKGtAf=D8tQ@mail.gmail.com>
References: <20150421150115.14288.88519.sendpatchset@little-apple>
	<CAMuHMdXo+VbhwqKvmdUgL_Udjc9eBgJ4ER4pwJJFUfFisR-TSg@mail.gmail.com>
	<CANqRtoSEGEjDcY-ZUrYv0anuYXOb4NkauC4zpTVOkZxzvJb7Ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CANqRtoSEGEjDcY-ZUrYv0anuYXOb4NkauC4zpTVOkZxzvJb7Ag@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

Hi Magnus,

On Thu, Apr 23, 2015 at 10:10 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Wed, Apr 22, 2015 at 2:56 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Tue, Apr 21, 2015 at 5:01 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> These patches attempt to convert the IRQC driver from using a mix of clock
>>> framework and Runtime PM into only using Runtime PM and doing that in a
>>> more fine grained way than before. With these patches in place, if there
>>> is no interrupt used then the clock and/or power domain will not be used.
>>>
>>> Basic operation is that With these patches applied ->irq_enable() will
>>> perform Runtime PM 'get sync' and ->irq_disable() simply performs
>>> Runtime PM 'put'. The trigger mode callback is assumed to happen at any
>>> time so there is a get/put wrapper there.
>>>
>>> Unless I'm misunderstanding the IRQ core code this means that the IRQC
>>> struct device will be in Runtime PM 'get sync' state after someone has
>>> started using an interrupt.
>>
>> I'm afraid you can't call pm_runtime_get_sync() from these methods, as
>> they may be called from interrupt context.
>
> Ouch. I know the clock framework has prepare/enable separated with
> context, but with the irqchip callbacks I suppose no such separation

It's not the clock operations, but the pm_runtime operations that cannot be
called from interrupt context.

> is made...? Maybe it makes more sense to do power management from the
> online/offline hooks?

Which online/offline hooks do you mean?

>> BTW, I ran into similar issues with rcar-gpio, when trying to improve its
>> Runtime PM handling (still have to finish my WIP).
>
> Yeah, the IRQC and GPIO interrupt bits should be pretty much the same.
> I considered IRQC to be a simpler test case, but I guess it is may be
> more complicated due to lack of wakeup sources.
>
>> On r8a73a4/ape6evm, I now get during boot:

[snip]

> Thanks, this looks troublesome. =) I can see it is on APE6EVM, but
> which patches are applied?

I can reproduce it on renesas-drivers-2015-04-20-v4.0 with just your 3 patches.
I was using my own .config.

With shmobile_defconfig + CONFIG_PROVE_LOCKING=y I see a different one:

[ INFO: inconsistent lock state ]
4.0.0-10356-g7156f022c08bb358 #231 Not tainted
---------------------------------
inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
swapper/0/1 [HC0[0]:SC0[0]:HE1:SE1] takes:
 (&irq_desc_lock_class){?.-...}, at: [<c006ef0c>] __irq_get_desc_lock+0x78/0x94
{IN-HARDIRQ-W} state was registered at:
  [<c0066bd4>] lock_acquire+0x74/0x94
  [<c04fb728>] _raw_spin_lock+0x34/0x44
  [<c0072330>] handle_fasteoi_irq+0x20/0x128
  [<c006ed1c>] generic_handle_irq+0x28/0x38
  [<c006edc0>] __handle_domain_irq+0x94/0xbc
  [<c000a408>] gic_handle_irq+0x40/0x64
  [<c00140c4>] __irq_svc+0x44/0x5c
  [<c04fb8a8>] _raw_spin_unlock_irqrestore+0x48/0x4c
  [<c005d35c>] prepare_to_wait_event+0xd8/0xe8
  [<c03434b4>] sh_mobile_i2c_xfer+0x338/0x4f4
  [<c033f22c>] __i2c_transfer+0x1d0/0x220
  [<c033f2f8>] i2c_transfer+0x7c/0xa0
  [<c02a0c80>] regmap_i2c_read+0x50/0x6c
  [<c029d8a8>] _regmap_raw_read+0x9c/0xd4
  [<c029d90c>] _regmap_bus_read+0x2c/0x58
  [<c029c738>] _regmap_read+0xa4/0xe0
  [<c029e604>] regmap_read+0x48/0x68
  [<c022dcbc>] max8973_dcdc_get_voltage_sel+0x28/0x5c
  [<c022728c>] regulator_attr_is_visible+0x90/0x238
  [<c013bdf0>] internal_create_group+0x13c/0x254
  [<c013bf20>] sysfs_create_group+0x18/0x1c
  [<c013c014>] sysfs_create_groups+0x3c/0x68
  [<c02885d0>] device_add+0x224/0x514
  [<c02888dc>] device_register+0x1c/0x20
  [<c022a9b4>] regulator_register+0x290/0xd0c
  [<c022c268>] devm_regulator_register+0x3c/0x78
  [<c022e200>] max8973_probe+0x3b8/0x430
  [<c033e1c4>] i2c_device_probe+0xf8/0x120
  [<c028a964>] driver_probe_device+0x100/0x268
  [<c028aafc>] __device_attach+0x30/0x4c
  [<c0289614>] bus_for_each_drv+0x8c/0x9c
  [<c028ac24>] device_attach+0x70/0x94
  [<c02897a8>] bus_probe_device+0x30/0xa4
  [<c02887a8>] device_add+0x3fc/0x514
  [<c02888dc>] device_register+0x1c/0x20
  [<c033e4d8>] i2c_new_device+0x12c/0x1a0
  [<c033e984>] i2c_register_adapter+0x2f0/0x408
  [<c033eccc>] i2c_add_adapter+0x90/0xa8
  [<c033ed00>] i2c_add_numbered_adapter+0x1c/0x28
  [<c0342ce4>] sh_mobile_i2c_probe+0x3c0/0x454
  [<c028bdc4>] platform_drv_probe+0x50/0xa0
  [<c028a964>] driver_probe_device+0x100/0x268
  [<c028ab90>] __driver_attach+0x78/0x9c
  [<c0289218>] bus_for_each_dev+0x74/0x98
  [<c028ac68>] driver_attach+0x20/0x28
  [<c02899f0>] bus_add_driver+0xdc/0x1c4
  [<c028b378>] driver_register+0xa4/0xe8
  [<c028c798>] __platform_driver_register+0x50/0x64
  [<c06a54c8>] sh_mobile_i2c_adap_init+0x18/0x20
  [<c0687dfc>] do_one_initcall+0x108/0x1bc
  [<c0687fcc>] kernel_init_freeable+0x11c/0x1e4
  [<c04f30d4>] kernel_init+0x10/0xec
  [<c000fcb0>] ret_from_fork+0x14/0x24
irq event stamp: 162248
hardirqs last  enabled at (162247): [<c04f9b04>]
__mutex_unlock_slowpath+0x174/0x198
hardirqs last disabled at (162248): [<c04fb75c>]
_raw_spin_lock_irqsave+0x24/0x58
softirqs last  enabled at (160452): [<c002bda0>] __do_softirq+0x204/0x29c
softirqs last disabled at (160443): [<c002c134>] irq_exit+0x8c/0x118

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&irq_desc_lock_class);
  <Interrupt>
    lock(&irq_desc_lock_class);

 *** DEADLOCK ***

3 locks held by swapper/0/1:
 #0:  (&dev->mutex){......}, at: [<c028ab54>] __driver_attach+0x3c/0x9c
 #1:  (&dev->mutex){......}, at: [<c028ab78>] __driver_attach+0x60/0x9c
 #2:  (&irq_desc_lock_class){?.-...}, at: [<c006ef0c>]
__irq_get_desc_lock+0x78/0x94

stack backtrace:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.0.0-10356-g7156f022c08bb358 #231
Hardware name: Generic R8A73A4 (Flattened Device Tree)
Backtrace:
[<c0013368>] (dump_backtrace) from [<c0013510>] (show_stack+0x18/0x1c)
 r6:c0ede83c r5:ee8433c0 r4:00000000 r3:00200140
[<c00134f8>] (show_stack) from [<c04f605c>] (dump_stack+0x78/0x94)
[<c04f5fe4>] (dump_stack) from [<c00629bc>] (print_usage_bug+0x254/0x2c4)
 r4:c08412f8 r3:00000002
[<c0062768>] (print_usage_bug) from [<c0062dd8>] (mark_lock+0x3ac/0x674)
 r9:c0061f18 r8:ee8433c0 r7:00001015 r6:ee843880 r5:00000002 r4:00000000
[<c0062a2c>] (mark_lock) from [<c0063108>] (mark_held_locks+0x68/0x84)
 r10:c06f6568 r9:00000018 r8:00000002 r7:00000003 r6:ee843880 r5:ee8433c0
 r4:00000002 r3:0000000c
[<c00630a0>] (mark_held_locks) from [<c0063280>]
(trace_hardirqs_on_caller+0x15c/0x1dc)
 r9:ee923ca0 r8:ee844000 r7:00000000 r6:c04fb8d8 r5:00000001 r4:ee8433c0
[<c0063124>] (trace_hardirqs_on_caller) from [<c0063314>]
(trace_hardirqs_on+0x14/0x18)
 r6:c0298cf8 r5:ee923c10 r4:ee923ca0 r3:ee8433c0
[<c0063300>] (trace_hardirqs_on) from [<c04fb8d8>]
(_raw_spin_unlock_irq+0x2c/0x34)
[<c04fb8ac>] (_raw_spin_unlock_irq) from [<c0292368>] (__rpm_callback+0x34/0x64)
 r4:ee923ca0 r3:00000000
[<c0292334>] (__rpm_callback) from [<c0292408>] (rpm_callback+0x70/0x88)
 r6:c06f64d8 r5:ee923c10 r4:ee923c10 r3:00000000
[<c0292398>] (rpm_callback) from [<c0292b28>] (rpm_resume+0x350/0x3fc)
 r5:00000000 r4:ee923c10
[<c02927d8>] (rpm_resume) from [<c0293390>] (__pm_runtime_resume+0x54/0x6c)
 r10:eeb7b280 r9:00000078 r8:00000004 r7:600001d3 r6:00000004 r5:ee923ca0
 r4:ee923c10
[<c029333c>] (__pm_runtime_resume) from [<c01f2d0c>]
(irqc_irq_set_type+0x38/0xa4)
 r7:ee923614 r6:00000002 r5:ee923400 r4:00000008
[<c01f2cd4>] (irqc_irq_set_type) from [<c00706c0>]
(__irq_set_trigger+0x68/0x118)
 r6:00000000 r5:ee933e00 r4:00000004 r3:c01f2cd4
[<c0070658>] (__irq_set_trigger) from [<c0071c74>] (irq_set_irq_type+0x40/0x60)
 r9:00000001 r8:00000000 r7:0000001c r6:00000078 r5:ee933e00 r4:00000004
[<c0071c34>] (irq_set_irq_type) from [<c0074374>]
(irq_create_of_mapping+0x144/0x15c)
 r6:eefe0970 r5:00000004 r4:00000078
[<c0074230>] (irq_create_of_mapping) from [<c03a218c>]
(irq_of_parse_and_map+0x2c/0x34)
 r5:00000001 r4:eeb7b29c
[<c03a2160>] (irq_of_parse_and_map) from [<c03a21b4>]
(of_irq_to_resource+0x20/0xb0)
[<c03a2194>] (of_irq_to_resource) from [<c03a2348>]
(of_irq_to_resource_table+0x38/0x4c)
 r8:eefe0970 r7:0000001c r6:eeb7b29c r5:00000001 r4:00000000
[<c03a2310>] (of_irq_to_resource_table) from [<c039fbf0>]
(of_device_alloc+0xd8/0x130)
 r8:0000001c r7:00000001 r6:eefe0970 r5:00000001 r4:eeb7a800 r3:00000000
[<c039fb18>] (of_device_alloc) from [<c039fc98>]
(of_platform_device_create_pdata+0x50/0xb4)
 r10:00000000 r9:00000001 r8:00000000 r7:ee944410 r6:00000000 r5:eefe09c0
 r4:eefe0970
[<c039fc48>] (of_platform_device_create_pdata) from [<c039fde8>]
(of_platform_bus_create+0xec/0x17c)
 r8:00000000 r7:00000000 r6:ee944410 r5:00000000 r4:eefe0970 r3:ee944410
[<c039fcfc>] (of_platform_bus_create) from [<c039ffd0>]
(of_platform_populate+0x70/0xac)
 r10:00000001 r9:ee944410 r8:00000000 r7:00000000 r6:eefe0970 r5:eefe0704
 r4:ee944410
[<c039ff60>] (of_platform_populate) from [<c01f3f48>]
(simple_pm_bus_probe+0x38/0x40)
 r10:00000000 r9:c06eb83c r8:00000000 r7:c0ee3100 r6:c06eb83c r5:eefe0704
 r4:ee944410
[<c01f3f10>] (simple_pm_bus_probe) from [<c028bdc4>]
(platform_drv_probe+0x50/0xa0)
 r5:ee944410 r4:00000000
[<c028bd74>] (platform_drv_probe) from [<c028a964>]
(driver_probe_device+0x100/0x268)
 r6:c0ee30ec r5:00000000 r4:ee944410 r3:c028bd74
[<c028a864>] (driver_probe_device) from [<c028ab90>] (__driver_attach+0x78/0x9c)
 r9:c0712000 r8:c06ba84c r7:c06f6700 r6:c06eb83c r5:ee944444 r4:ee944410
[<c028ab18>] (__driver_attach) from [<c0289218>] (bus_for_each_dev+0x74/0x98)
 r6:c028ab18 r5:c06eb83c r4:00000000 r3:00000001
[<c02891a4>] (bus_for_each_dev) from [<c028ac68>] (driver_attach+0x20/0x28)
 r6:ee82f140 r5:00000000 r4:c06eb83c
[<c028ac48>] (driver_attach) from [<c02899f0>] (bus_add_driver+0xdc/0x1c4)
[<c0289914>] (bus_add_driver) from [<c028b378>] (driver_register+0xa4/0xe8)
 r7:c06ba84c r6:00000000 r5:c069fed0 r4:c06eb83c
[<c028b2d4>] (driver_register) from [<c028c798>]
(__platform_driver_register+0x50/0x64)
 r5:c069fed0 r4:eeb7b580
[<c028c748>] (__platform_driver_register) from [<c069fee8>]
(simple_pm_bus_driver_init+0x18/0x20)
[<c069fed0>] (simple_pm_bus_driver_init) from [<c0687dfc>]
(do_one_initcall+0x108/0x1bc)
[<c0687cf4>] (do_one_initcall) from [<c0687fcc>]
(kernel_init_freeable+0x11c/0x1e4)
 r9:c0712000 r8:c0712000 r7:c06c3d40 r6:c06bb078 r5:000000b3 r4:00000006
[<c0687eb0>] (kernel_init_freeable) from [<c04f30d4>] (kernel_init+0x10/0xec)
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c04f30c4 r4:00000000
[<c04f30c4>] (kernel_init) from [<c000fcb0>] (ret_from_fork+0x14/0x24)
 r4:00000000 r3:00000000

> Is it possible to reproduce on R-Car Gen2 somehow?

Seems I had disabled CONFIG_PROVE_LOCKING in my koelsch .config, so I didn't
see it there.
But you're lucky ;-) With shmobile_defconfig + CONFIG_PROVE_LOCKING=y:

[ INFO: inconsistent lock state ]
4.0.0-10356-g7156f022c08bb358 #232 Not tainted
---------------------------------
inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
swapper/0/1 [HC1[1]:SC0[0]:HE0:SE1] takes:
 (&irq_desc_lock_class){?.+...}, at: [<c0072330>] handle_fasteoi_irq+0x20/0x128
{HARDIRQ-ON-W} state was registered at:
  [<c0063280>] trace_hardirqs_on_caller+0x15c/0x1dc
  [<c0063314>] trace_hardirqs_on+0x14/0x18
  [<c04fb8d8>] _raw_spin_unlock_irq+0x2c/0x34
  [<c0292368>] __rpm_callback+0x34/0x64
  [<c0292408>] rpm_callback+0x70/0x88
  [<c0292b28>] rpm_resume+0x350/0x3fc
  [<c0293390>] __pm_runtime_resume+0x54/0x6c
  [<c01f2d0c>] irqc_irq_set_type+0x38/0xa4
  [<c00706c0>] __irq_set_trigger+0x68/0x118
  [<c0071c74>] irq_set_irq_type+0x40/0x60
  [<c0074374>] irq_create_of_mapping+0x144/0x15c
  [<c03a2280>] of_irq_get+0x3c/0x44
  [<c033e104>] i2c_device_probe+0x38/0x120
  [<c028a964>] driver_probe_device+0x100/0x268
  [<c028ab90>] __driver_attach+0x78/0x9c
  [<c0289218>] bus_for_each_dev+0x74/0x98
  [<c028ac68>] driver_attach+0x20/0x28
  [<c02899f0>] bus_add_driver+0xdc/0x1c4
  [<c028b378>] driver_register+0xa4/0xe8
  [<c033ef78>] i2c_register_driver+0x48/0x7c
  [<c06a0e50>] da9210_regulator_driver_init+0x18/0x20
  [<c0687dfc>] do_one_initcall+0x108/0x1bc
  [<c0687fcc>] kernel_init_freeable+0x11c/0x1e4
  [<c04f30d4>] kernel_init+0x10/0xec
  [<c000fcb0>] ret_from_fork+0x14/0x24
irq event stamp: 223608
hardirqs last  enabled at (223607): [<c04fb8a4>]
_raw_spin_unlock_irqrestore+0x44/0x4c
hardirqs last disabled at (223608): [<c00140b4>] __irq_svc+0x34/0x5c
softirqs last  enabled at (214668): [<c002bda0>] __do_softirq+0x204/0x29c
softirqs last disabled at (214373): [<c002c134>] irq_exit+0x8c/0x118

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&irq_desc_lock_class);
  <Interrupt>
    lock(&irq_desc_lock_class);

 *** DEADLOCK ***

3 locks held by swapper/0/1:
 #0:  (&dev->mutex){......}, at: [<c028ab54>] __driver_attach+0x3c/0x9c
 #1:  (&dev->mutex){......}, at: [<c028ab78>] __driver_attach+0x60/0x9c
 #2:  (&map->mutex){+.+...}, at: [<c029c304>] regmap_lock_mutex+0x14/0x18

stack backtrace:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.0.0-10356-g7156f022c08bb358 #232
Hardware name: Generic R8A7791 (Flattened Device Tree)
Backtrace:
[<c0013368>] (dump_backtrace) from [<c0013510>] (show_stack+0x18/0x1c)
 r6:c0ede83c r5:ee0533c0 r4:00000000 r3:00200140
[<c00134f8>] (show_stack) from [<c04f605c>] (dump_stack+0x78/0x94)
[<c04f5fe4>] (dump_stack) from [<c00629bc>] (print_usage_bug+0x254/0x2c4)
 r4:c08412f8 r3:00000002
[<c0062768>] (print_usage_bug) from [<c0062dd8>] (mark_lock+0x3ac/0x674)
 r9:c0061e08 r8:ee0533c0 r7:00001045 r6:ee053898 r5:00000000 r4:00000002
[<c0062a2c>] (mark_lock) from [<c00650cc>] (__lock_acquire+0x83c/0x1b64)
 r10:ee055c04 r9:c08412f8 r8:ee0533c0 r7:00000003 r6:00000001 r5:00000019
 r4:ee1afb70 r3:00000001
[<c0064890>] (__lock_acquire) from [<c0066bd4>] (lock_acquire+0x74/0x94)
 r10:ee055c04 r9:00000001 r8:ee006000 r7:00000067 r6:00000001 r5:60000193
 r4:00000000
[<c0066b60>] (lock_acquire) from [<c04fb728>] (_raw_spin_lock+0x34/0x44)
 r6:ee1afb60 r5:c06eb520 r4:ee1afb60
[<c04fb6f4>] (_raw_spin_lock) from [<c0072330>] (handle_fasteoi_irq+0x20/0x128)
 r4:ee1afb00
[<c0072310>] (handle_fasteoi_irq) from [<c006ed1c>]
(generic_handle_irq+0x28/0x38)
 r6:c06c6e38 r5:00000000 r4:00000067 r3:c0072310
[<c006ecf4>] (generic_handle_irq) from [<c006edc0>]
(__handle_domain_irq+0x94/0xbc)
 r4:00000000 r3:00000178
[<c006ed2c>] (__handle_domain_irq) from [<c000a408>] (gic_handle_irq+0x40/0x64)
 r8:ed8fff74 r7:ee055ba4 r6:ee055b70 r5:c06cc784 r4:f0002000 r3:ee055b70
[<c000a3c8>] (gic_handle_irq) from [<c00140c4>] (__irq_svc+0x44/0x5c)
Exception stack(0xee055b70 to 0xee055bb8)
5b60:                                     00000001 00000110 00000000 ee0533c0
5b80: 60000113 ed8fff74 00000002 00000000 ed8fff74 00000001 ee055c04 ee055bcc
5ba0: ee055b60 ee055bb8 c0063108 c04fb8a8 20000113 ffffffff
 r6:ffffffff r5:20000113 r4:c04fb8a8 r3:ee0533c0
[<c04fb860>] (_raw_spin_unlock_irqrestore) from [<c005d35c>]
(prepare_to_wait_event+0xd8/0xe8)
 r5:ed8fff74 r4:ee055c04
[<c005d284>] (prepare_to_wait_event) from [<c03434b4>]
(sh_mobile_i2c_xfer+0x338/0x4f4)
 r6:ee055c9c r5:000001f4 r4:ed8ffc10 r3:00000000
[<c034317c>] (sh_mobile_i2c_xfer) from [<c033f22c>] (__i2c_transfer+0x1d0/0x220)
 r10:ffff8b09 r9:c06cc100 r8:00000001 r7:00000000 r6:c0ee5440 r5:ed8ffc18
 r4:ee055c9c
[<c033f05c>] (__i2c_transfer) from [<c033f2f8>] (i2c_transfer+0x7c/0xa0)
 r10:00000054 r9:ee3c9080 r8:ee3c9081 r7:ee055c9c r6:00000001 r5:ed8ffc28
 r4:ed8ffc18 r3:00000000
[<c033f27c>] (i2c_transfer) from [<c033f360>] (i2c_master_send+0x44/0x54)
 r7:ee3c9081 r6:00000001 r5:fffffdf4 r4:00000002
[<c033f31c>] (i2c_master_send) from [<c02a0d50>] (regmap_i2c_write+0x18/0x34)
 r4:00000002
[<c02a0d38>] (regmap_i2c_write) from [<c029dd8c>]
(_regmap_raw_write+0x454/0x534)
 r4:ed934200 r3:c02a0d38
[<c029d938>] (_regmap_raw_write) from [<c029dee4>]
(_regmap_bus_raw_write+0x78/0x90)
 r10:00000000 r9:c06ee170 r8:00000000 r7:ed934200 r6:ffffffff r5:00000054
 r4:ed934200
[<c029de6c>] (_regmap_bus_raw_write) from [<c029d5e4>] (_regmap_write+0x90/0x9c)
 r6:ffffffff r5:00000054 r4:ed934200 r3:c029de6c
[<c029d554>] (_regmap_write) from [<c029e1e8>] (regmap_write+0x48/0x68)
 r7:ed8ff400 r6:ffffffff r5:00000054 r4:ed934200
[<c029e1a0>] (regmap_write) from [<c022d34c>] (da9210_i2c_probe+0xb4/0x13c)
 r6:ed8ff420 r5:ee3c9110 r4:ed934200 r3:ee7c15a0
[<c022d298>] (da9210_i2c_probe) from [<c033e1c4>] (i2c_device_probe+0xf8/0x120)
 r8:ed8ff404 r7:c022d298 r6:ed8ff420 r5:c055496c r4:ed8ff400
[<c033e0cc>] (i2c_device_probe) from [<c028a964>]
(driver_probe_device+0x100/0x268)
 r8:00000000 r7:c0ee3100 r6:c0ee30ec r5:00000000 r4:ed8ff420 r3:c033e0cc
[<c028a864>] (driver_probe_device) from [<c028ab90>] (__driver_attach+0x78/0x9c)
 r9:c0712000 r8:c06ba84c r7:c06fe6a4 r6:c06ee170 r5:ed8ff454 r4:ed8ff420
[<c028ab18>] (__driver_attach) from [<c0289218>] (bus_for_each_dev+0x74/0x98)
 r6:c028ab18 r5:c06ee170 r4:00000000 r3:00000001
[<c02891a4>] (bus_for_each_dev) from [<c028ac68>] (driver_attach+0x20/0x28)
 r6:ee1fc940 r5:00000000 r4:c06ee170
[<c028ac48>] (driver_attach) from [<c02899f0>] (bus_add_driver+0xdc/0x1c4)
[<c0289914>] (bus_add_driver) from [<c028b378>] (driver_register+0xa4/0xe8)
 r7:c06ba84c r6:00000000 r5:c06a0e38 r4:c06ee170
[<c028b2d4>] (driver_register) from [<c033ef78>] (i2c_register_driver+0x48/0x7c)
 r5:c06a0e38 r4:c06ee154
[<c033ef30>] (i2c_register_driver) from [<c06a0e50>]
(da9210_regulator_driver_init+0x18/0x20)
 r5:c06a0e38 r4:ee3c9340
[<c06a0e38>] (da9210_regulator_driver_init) from [<c0687dfc>]
(do_one_initcall+0x108/0x1bc)
[<c0687cf4>] (do_one_initcall) from [<c0687fcc>]
(kernel_init_freeable+0x11c/0x1e4)
 r9:c0712000 r8:c0712000 r7:c06c3d78 r6:c06bb078 r5:000000b3 r4:00000006
[<c0687eb0>] (kernel_init_freeable) from [<c04f30d4>] (kernel_init+0x10/0xec)
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c04f30c4 r4:00000000
[<c04f30c4>] (kernel_init) from [<c000fcb0>] (ret_from_fork+0x14/0x24)
 r4:00000000 r3:00000000

>>> As for wakeup support, based on IRQ_WAKEUP_STATE being toggled in
>>> irq_set_irq_wake() together with the irqd_is_wakeup_set() usage in
>>> suspend_device_irqs() it looks like interrupts used for wakeup will
>>> stay enabled once we use Runtime PM in ->irq_enable() and ->irq_disable()
>>> and because of that the clock operations and custom ->irq_set_wake()
>>> should not be necessary.
>>>
>>> I have boot tested this with some simple PHY link state change IRQs
>>> on a Koelsch board, but I have not tried Suspend-to-RAM yet with wakeup
>>> support. It would be useful to test this with Suspend-to-RAM on APE6EVM.
>>
>> Unfortunately pm_runtime_get_sync() doesn't protect against s2ram.
>> pm_clk_suspend() will be called anyway, disabling the clock if it wasn't
>> enabled explicitly. That's why I incremented the clock's enable count manually
>> when wake-up is enabled.
>
> Can you please clarify what you mean about "enabled explicitly"? Just

"enabled in the driver using clk_enable(p->clk) (in irqc_irq_set_wake())".
As this increases the reference count, pm_clk_suspend() during suspend won't
disable the clock.

> enabling the clock may solve the issue for this particular driver, but
> as a general approach it seems to me that we probably need to control
> both power domain and clock. So PM domain handling must be necessary
> somehow I think.

Right...

Probably the IRQC driver needs to return -EBUSY in some callback, but we
have to be careful that this doesn't prevent the whole system from going
into suspend.

For current SoCs, it will work as-is, as the PM domains containing interrupt
and gpio controllers won't be powered down:
  - PFC (which provides gpio) is in the "always on" C5 power area on R-MoBile
    and SH-Mobile,
  - GPIO is always on on R-Car,
  - IRQC is in C4 on r8a73a4, but won't be powered down as the ARM subsystem
    is a child of C4.
  - intc-irqpin is in A4S on r8a7740/sh73a0, but ARM etc. is a child,
  - GIC is always on on R-Car.

(Note that on r8a73a4, the pfc is in the "always on" C5 power area, while
 its interrupt lines are tied to irqc[01], which is in the C4 power area and
 thus can be powered down? Doesn't seem to make sense, even
 considering another CPU core can be in charge, as irqc[01] is not specific
 to the ARM core)....

> Also, I honestly don't know what kind of special casing we need to do
> with the interrupt controller during Suspend-to-RAM. Ideally it would
> be nice if we could turn off all clocks / power domains that are not
> necessary for wakeup, but this seems quite similar to regular runtime
> operation IMO.

Given the above, for current SoCs no PM domains can be powered down.
So that leaves us with clocks only for saving some power.

> So the question is how to get runtime operation to work well...
>
>> During the suspend phase, it does:
>>
>> -----8<-----

[...]

>> renesas_irqc e61c0200.interrupt-controller: pm_clk_suspend()
>> renesas_irqc e61c0000.interrupt-controller: pm_clk_suspend()
>> MSTP irqc OFF
>> ----->8-----
>>
>> Woops, wake-up by IRQC won't work anymore as the IRQC clock is now disabled.
>
> So if there is any wakeup source needed shouldn't the Runtime PM
> device remain in "get" state?

No, Runtime PM is separate from system suspend: a device in "get" state
can still be suspended during system suspend.

It's similar with PM Domains: to prevent them from being powered down,
you need two precautions:
  - use pm_domain_always_on_gov (against runtime suspend),
  - let .power_off() return -EBUSY (against system suspend).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
