From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 00/03] irqchip: renesas-irqc: Fine grained Runtime PM support
Date: Tue, 21 Apr 2015 19:56:30 +0200
Message-ID: <CAMuHMdXo+VbhwqKvmdUgL_Udjc9eBgJ4ER4pwJJFUfFisR-TSg@mail.gmail.com>
References: <20150421150115.14288.88519.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:32971 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058AbbDUR4b (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Apr 2015 13:56:31 -0400
In-Reply-To: <20150421150115.14288.88519.sendpatchset@little-apple>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Thomas Gleixner <tglx@linutronix.de>

Hi Magnus,

On Tue, Apr 21, 2015 at 5:01 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> irqchip: renesas-irqc: Fine grained Runtime PM support
>
> [PATCH/RFC 01/03] irqchip: renesas-irqc: Add irq_enable() and irq_disable()
> [PATCH/RFC 02/03] irqchip: renesas-irqc: Add fine grained Runtime PM code
> [PATCH/RFC 03/03] irqchip: renesas-irqc: Rely on Runtime PM for wakeup

Thanks for your patches!

> These patches attempt to convert the IRQC driver from using a mix of clock
> framework and Runtime PM into only using Runtime PM and doing that in a
> more fine grained way than before. With these patches in place, if there
> is no interrupt used then the clock and/or power domain will not be used.
>
> Basic operation is that With these patches applied ->irq_enable() will
> perform Runtime PM 'get sync' and ->irq_disable() simply performs
> Runtime PM 'put'. The trigger mode callback is assumed to happen at any
> time so there is a get/put wrapper there.
>
> Unless I'm misunderstanding the IRQ core code this means that the IRQC
> struct device will be in Runtime PM 'get sync' state after someone has
> started using an interrupt.

I'm afraid you can't call pm_runtime_get_sync() from these methods, as
they may be called from interrupt context.
BTW, I ran into similar issues with rcar-gpio, when trying to improve its
Runtime PM handling (still have to finish my WIP).

On r8a73a4/ape6evm, I now get during boot:

-----8<-----
=================================
[ INFO: inconsistent lock state ]
4.0.0-ape6evm-10563-g8b333096057b3c10 #213 Not tainted
---------------------------------
inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
swapper/0/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
 (&irq_desc_lock_class){?.+...}, at: [<c0088a34>] handle_fasteoi_irq+0x18/0x190
{HARDIRQ-ON-W} state was registered at:
  [<c041cf80>] _raw_spin_unlock_irq+0x24/0x2c
  [<c028a748>] __rpm_callback+0x50/0x60
  [<c028a778>] rpm_callback+0x20/0x80
  [<c028af24>] rpm_resume+0x3a4/0x5ec
  [<c028bc10>] __pm_runtime_resume+0x4c/0x64
  [<c024241c>] irqc_irq_set_type+0x34/0x9c
  [<c0086dc8>] __irq_set_trigger+0x54/0x11c
  [<c00883fc>] irq_set_irq_type+0x34/0x5c
  [<c008ad6c>] irq_create_of_mapping+0x114/0x168
  [<c02d6f5c>] irq_of_parse_and_map+0x24/0x2c
  [<c02d6f7c>] of_irq_to_resource+0x18/0xb8
  [<c02d7120>] of_irq_to_resource_table+0x3c/0x54
  [<c02d4c74>] of_device_alloc+0x104/0x170
  [<c02d4d28>] of_platform_device_create_pdata+0x48/0xac
  [<c02d4e20>] of_platform_bus_create+0x94/0x130
  [<c02d520c>] of_platform_populate+0x180/0x1c4
  [<c0242778>] simple_pm_bus_probe+0x30/0x38
  [<c028431c>] platform_drv_probe+0x44/0xa4
  [<c0282d10>] driver_probe_device+0x178/0x2bc
  [<c0282f2c>] __driver_attach+0x94/0x98
  [<c028143c>] bus_for_each_dev+0x6c/0xa0
  [<c0281dcc>] bus_add_driver+0x140/0x1e8
  [<c02837dc>] driver_register+0x78/0xf8
  [<c0540d40>] do_one_initcall+0x118/0x1c8
  [<c0540f34>] kernel_init_freeable+0x144/0x1e4
  [<c04148cc>] kernel_init+0x8/0xe8
  [<c0010210>] ret_from_fork+0x14/0x24
irq event stamp: 2304
hardirqs last  enabled at (2301): [<c0010c38>] arch_cpu_idle+0x20/0x3c
hardirqs last disabled at (2302): [<c0014734>] __irq_svc+0x34/0x5c
softirqs last  enabled at (2304): [<c002fa54>] irq_enter+0x68/0x84
softirqs last disabled at (2303): [<c002fa40>] irq_enter+0x54/0x84

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&irq_desc_lock_class);
  <Interrupt>
    lock(&irq_desc_lock_class);

 *** DEADLOCK ***

no locks held by swapper/0/0.

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted
4.0.0-ape6evm-10563-g8b333096057b3c10 #213
Hardware name: Generic R8A73A4 (Flattened Device Tree)
[<c0017280>] (unwind_backtrace) from [<c0013b90>] (show_stack+0x10/0x14)
[<c0013b90>] (show_stack) from [<c0417450>] (dump_stack+0x88/0x98)
[<c0417450>] (dump_stack) from [<c007007c>] (print_usage_bug+0x22c/0x2d8)
[<c007007c>] (print_usage_bug) from [<c007032c>] (mark_lock+0x204/0x768)
[<c007032c>] (mark_lock) from [<c0072b58>] (__lock_acquire+0xa1c/0x215c)
[<c0072b58>] (__lock_acquire) from [<c0074bf0>] (lock_acquire+0xac/0x12c)
[<c0074bf0>] (lock_acquire) from [<c041cdf0>] (_raw_spin_lock+0x30/0x40)
[<c041cdf0>] (_raw_spin_lock) from [<c0088a34>] (handle_fasteoi_irq+0x18/0x190)
[<c0088a34>] (handle_fasteoi_irq) from [<c0085394>]
(generic_handle_irq+0x2c/0x3c)
[<c0085394>] (generic_handle_irq) from [<c0085400>]
(__handle_domain_irq+0x5c/0xb4)
[<c0085400>] (__handle_domain_irq) from [<c000a3e4>] (gic_handle_irq+0x24/0x5c)
[<c000a3e4>] (gic_handle_irq) from [<c0014744>] (__irq_svc+0x44/0x5c)
Exception stack(0xc0583f58 to 0xc0583fa0)
3f40:                                                       00000001 00000001
3f60: 00000000 c05887a8 c0582000 c05854fc c0585400 c05d6624 c0585498 c057d3c4
3f80: c041f220 00000000 01000000 c0583fa0 c0070a74 c0010c3c 20000113 ffffffff
[<c0014744>] (__irq_svc) from [<c0010c3c>] (arch_cpu_idle+0x24/0x3c)
[<c0010c3c>] (arch_cpu_idle) from [<c0068fb8>] (cpu_startup_entry+0x170/0x280)
[<c0068fb8>] (cpu_startup_entry) from [<c0540c1c>] (start_kernel+0x358/0x364)
[<c0540c1c>] (start_kernel) from [<4000807c>] (0x4000807c)
----->8-----

> As for wakeup support, based on IRQ_WAKEUP_STATE being toggled in
> irq_set_irq_wake() together with the irqd_is_wakeup_set() usage in
> suspend_device_irqs() it looks like interrupts used for wakeup will
> stay enabled once we use Runtime PM in ->irq_enable() and ->irq_disable()
> and because of that the clock operations and custom ->irq_set_wake()
> should not be necessary.
>
> I have boot tested this with some simple PHY link state change IRQs
> on a Koelsch board, but I have not tried Suspend-to-RAM yet with wakeup
> support. It would be useful to test this with Suspend-to-RAM on APE6EVM.

Unfortunately pm_runtime_get_sync() doesn't protect against s2ram.
pm_clk_suspend() will be called anyway, disabling the clock if it wasn't
enabled explicitly. That's why I incremented the clock's enable count manually
when wake-up is enabled.

During the suspend phase, it does:

-----8<-----
sh_mobile_sdhi ee120000.sd: pm_clk_resume()
sh_mobile_sdhi ee120000.sd: pm_clk_suspend()
sh_mobile_sdhi ee120000.sd: pm_clk_resume()
PM: Syncing filesystems ...
done.
PM: Preparing system for mem sleep
Freezing user space processes ... (elapsed 0.001 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
PM: Entering mem sleep
i2c-sh_mobile e60b0000.i2c: pm_clk_resume()
MSTP iic5 ON
sh-dma-engine e6700020.dma-controller: pm_clk_resume()
MSTP dmac ON
sh_mobile_sdhi ee120000.sd: pm_clk_suspend()
sh_mobile_sdhi ee100000.sd: pm_clk_suspend()
PM: suspend of devices complete after 24.016 msecs
PM: late suspend of devices complete after 7.605 msecs
sh-dma-engine e6700020.dma-controller: pm_clk_suspend()
MSTP dmac OFF
simple-pm-bus fec10000.bus: pm_clk_suspend()
sh_mmcif ee200000.mmc: pm_clk_suspend()
MSTP mmcif0 OFF
sh_mobile_sdhi ee120000.sd: pm_clk_suspend()
sh_mobile_sdhi ee100000.sd: pm_clk_suspend()
sh-sci e6c40000.serial: pm_clk_suspend()
rcar_thermal e61f0000.thermal: pm_clk_suspend()
MSTP thermal OFF
sh-pfc e6050000.pfc: pm_clk_suspend()
renesas_irqc e61c0200.interrupt-controller: pm_clk_suspend()
renesas_irqc e61c0000.interrupt-controller: pm_clk_suspend()
MSTP irqc OFF
----->8-----

Woops, wake-up by IRQC won't work anymore as the IRQC clock is now disabled.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
