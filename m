From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Corruption(?) if pm_genpd_add_device() fails
Date: Mon, 24 Aug 2015 16:57:37 +0200
Message-ID: <CAMuHMdW91NYMe3B9cqWn0+KK+OFWy6zu1MgouKxoe2GMXNW1Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:34501 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931AbbHXO5i (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2015 10:57:38 -0400
Received: by oiey141 with SMTP id y141so81651333oie.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2015 07:57:37 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>

Due to a typo in a dtsi file, a device couldn't be attached to its PM Domain,
causing the following error:

    ERROR: Bad of_node_put() on /soc/serial@e6540000
    CPU: 0 PID: 6 Comm: kworker/u2:0 Not tainted
4.2.0-rc7-salvatorx-05779-g5ba13738b6255e3c-dirty #25
    Hardware name: Renesas Salvator-X board based on r8a7795 (DT)
    Workqueue: deferwq deferred_probe_work_func
    Call trace:
    [<ffffffc000088e6c>] dump_backtrace+0x0/0x110
    [<ffffffc000088f8c>] show_stack+0x10/0x1c
    [<ffffffc000473d54>] dump_stack+0x80/0xa0
    [<ffffffc0003576f4>] of_node_release+0x30/0xa0
    [<ffffffc000220264>] kobject_release+0x58/0x78
    [<ffffffc0002202d8>] kobject_put+0x54/0x64
    [<ffffffc000356c44>] of_node_put+0x10/0x1c
    [<ffffffc00029f654>] genpd_dev_pm_attach+0x1a0/0x1f8
    [<ffffffc000295d54>] dev_pm_domain_attach+0x8/0x14
    [<ffffffc00029031c>] platform_drv_probe+0x34/0x9c
    [<ffffffc00028e944>] driver_probe_device+0xfc/0x25c

The call to of_node_put() in genpd_dev_pm_attach() does look legitimate to me.

As the target was a bit difficult to debug, I tried to reproduce it on
a different
board.


Initial try:

    of_clk_src_onecell_get: invalid clock index 31
    sh-sci e6e68000.serial: failed to add to PM domain cpg_clocks: -22

Failed, genpd_dev_pm_attach() returns -EPROBE_DEFER

    ...

First deferred probe retry:

    of_clk_src_onecell_get: invalid clock index 31
    sh-sci e6e68000.serial: failed to add to PM domain cpg_clocks: -22

Failed, genpd_dev_pm_attach() returns -EPROBE_DEFER

Second deferred probe retry:

    of_clk_src_onecell_get: invalid clock index 31
    sh-sci e6e68000.serial: failed to add to PM domain cpg_clocks: -22
    ERROR: Bad of_node_put() on /serial@e6e68000

Woops, this time of_node_put() has been called one time too much:

    CPU: 0 PID: 6 Comm: kworker/u4:0 Not tainted
4.2.0-rc7-koelsch-05508-gd7ba9d1e0b037c24-dirty #1643
    Hardware name: Generic R8A7791 (Flattened Device Tree)
    Workqueue: deferwq deferred_probe_work_func
    Backtrace:
    [<c00138b4>] (dump_backtrace) from [<c0013aac>] (show_stack+0x18/0x1c)
     r6:eecc3840 r5:ef1e8750 r4:00000000 r3:00000000
    [<c0013a94>] (show_stack) from [<c0459af0>] (dump_stack+0x78/0x94)
    [<c0459a78>] (dump_stack) from [<c0338130>] (of_node_release+0x30/0x98)
     r4:ef1e8710 r3:00000000
    [<c0338100>] (of_node_release) from [<c01f90dc>] (kobject_release+0x68/0x7c)
     r6:eecc3840 r5:ef1e8710 r4:ef1e872c r3:c0338100
    [<c01f9074>] (kobject_release) from [<c01f915c>] (kobject_put+0x6c/0x7c)
     r7:ee0438c0 r6:ee0438d8 r5:ee0438d8 r4:ef1e8710
    [<c01f90f0>] (kobject_put) from [<c0337850>] (of_node_put+0x1c/0x20)
     r4:ee0438d8
    [<c0337834>] (of_node_put) from [<c021cc48>]
(pinctrl_dt_free_maps+0x70/0x8c)
    [<c021cbd8>] (pinctrl_dt_free_maps) from [<c0219244>]
(pinctrl_free+0xcc/0xfc)
     r7:ee0438cc r6:ee0438cc r5:ee0438c0 r4:ee0438cc
    [<c0219178>] (pinctrl_free) from [<c021928c>] (pinctrl_release+0x18/0x1c)
     r10:eed39614 r9:00000000 r8:ee043940 r7:eed39410 r6:00000002 r5:eec71d60
     r4:ee043900
    [<c0219274>] (pinctrl_release) from [<c02192d0>] (pinctrl_put+0x40/0x44)
    [<c0219290>] (pinctrl_put) from [<c02192e8>]
(devm_pinctrl_release+0x14/0x18)
    [<c02192d4>] (devm_pinctrl_release) from [<c026e54c>]
(release_nodes+0x1b8/0x1e0)
    [<c026e394>] (release_nodes) from [<c026e640>]
(devres_release_all+0x4c/0x54)
     r10:00000001 r9:00000000 r8:0000000b r7:c065629c r6:c0e5b3bc r5:fffffdfb
     r4:eed39410
    [<c026e5f4>] (devres_release_all) from [<c026b044>]
(driver_probe_device+0x150/0x284)
     r4:eed39410 r3:c026c9c4
    [<c026aef4>] (driver_probe_device) from [<c026b2e4>]
(__device_attach_driver+0x8c/0x98)
     r8:eec3ca00 r7:eed39444 r6:eed39410 r5:eec71e20 r4:c065629c r3:00000000
    [<c026b258>] (__device_attach_driver) from [<c02696e4>]
(bus_for_each_drv+0x8c/0x9c)
     r6:c026b258 r5:eec71e20 r4:00000000 r3:00000001
    [<c0269658>] (bus_for_each_drv) from [<c026ae40>]
(__device_attach+0x9c/0x110)
     r6:00000001 r5:c0656fb0 r4:eed39410
    [<c026ada4>] (__device_attach) from [<c026b438>]
(device_initial_probe+0x14/0x18)
     r7:c0656cc4 r6:eed39410 r5:c0656fb0 r4:eed32aa0
    [<c026b424>] (device_initial_probe) from [<c026a500>]
(bus_probe_device+0x30/0x8c)
    [<c026a4d0>] (bus_probe_device) from [<c026a93c>]
(deferred_probe_work_func+0x68/0x90)
     r6:c0656c80 r5:eed39410 r4:eed32aa0 r3:000006f2
    [<c026a8d4>] (deferred_probe_work_func) from [<c0041984>]
(process_one_work+0x244/0x3e8)
     r7:eec71eb0 r6:c0656cfc r5:eec3bc00 r4:eec33840

of_node_put() was called from pinctrl_dt_free_maps().

    WARNING: CPU: 1 PID: 6 at include/linux/kref.h:47 kobject_get+0x84/0xa8()
    [<c0337810>] (of_node_get) from [<c021ccb0>] (pinctrl_dt_to_map+0x38/0x2ac)
     r4:ee058600 r3:eed39410
    [<c021cc78>] (pinctrl_dt_to_map) from [<c021a028>] (pinctrl_get+0x128/0x3c0)
     r10:00000001 r9:00000000 r8:0000000c r7:c0e40884 r6:eed39410 r5:c06512bc
     r4:ee058600
    [<c0219f00>] (pinctrl_get) from [<c021a2f0>] (devm_pinctrl_get+0x30/0x6c)
     r10:00000001 r9:00000000 r8:0000000c r7:c065629c r6:eed39410 r5:ee058650
     r4:ee058690
    [<c021a2c0>] (devm_pinctrl_get) from [<c0286058>]
(pinctrl_bind_pins+0x34/0xf0)
     r6:c0e5b3bc r5:eed39410 r4:ee058690 r3:eec6a0c0
    [<c0286024>] (pinctrl_bind_pins) from [<c026af7c>]
(driver_probe_device+0x88/0x284)
     r6:c0e5b3bc r5:eec71e20 r4:eed39410 r3:c0e5b3bc
    [<c026aef4>] (driver_probe_device) from [<c026b2e4>]
(__device_attach_driver+0x8c/0x98)
     r8:eec3ca00

More woops, I guess some memory got corrupted, as I got a crash during my first
try.

Third deferred probe retry:

    of_clk_src_onecell_get: invalid clock index 31
    sh-sci e6e68000.serial: failed to add to PM domain cpg_clocks: -22

Woops, again:

    ERROR: Bad of_node_put() on /serial@e6e68000
    CPU: 1 PID: 6 Comm: kworker/u4:0 Tainted: G        W
4.2.0-rc7-koelsch-05508-gd7ba9d1e0b037c24-dirty #1643
    Hardware name: Generic R8A7791 (Flattened Device Tree)
    Workqueue: deferwq deferred_probe_work_func
    Backtrace:
    [<c00138b4>] (dump_backtrace) from [<c0013aac>] (show_stack+0x18/0x1c)
     r6:eecc3840 r5:ef1e8750 r4:00000000 r3:00000000
    [<c0013a94>] (show_stack) from [<c0459af0>] (dump_stack+0x78/0x94)
    [<c0459a78>] (dump_stack) from [<c0338130>] (of_node_release+0x30/0x98)
     r4:ef1e8710 r3:00000000
    [<c0338100>] (of_node_release) from [<c01f90dc>] (kobject_release+0x68/0x7c)
     r6:eecc3840 r5:ef1e8710 r4:ef1e872c r3:c0338100
    [<c01f9074>] (kobject_release) from [<c01f915c>] (kobject_put+0x6c/0x7c)
     r7:00000008 r6:eec05400 r5:eed39410 r4:ef1e8710
    [<c01f90f0>] (kobject_put) from [<c0337850>] (of_node_put+0x1c/0x20)
     r4:ffffffea
    [<c0337834>] (of_node_put) from [<c027bb88>]
(genpd_dev_pm_attach+0x160/0x20c)
    [<c027ba28>] (genpd_dev_pm_attach) from [<c0272184>]
(dev_pm_domain_attach+0x10/0x14)
     r10:00000001 r9:00000000 r8:0000000c r7:c065629c r6:c065629c r5:eed39410
     r4:eed39410
    [<c0272174>] (dev_pm_domain_attach) from [<c026c9f8>]
(platform_drv_probe+0x34/0xa0)
    [<c026c9c4>] (platform_drv_probe) from [<c026b004>]
(driver_probe_device+0x110/0x284)
     r6:c0e5b3bc r5:00000000 r4:eed39410 r3:c026c9c4
    [<c026aef4>] (driver_probe_device) from [<c026b2e4>]
(__device_attach_driver+0x8c/0x98)
     r8:eec3ca00 r7:eed39444 r6:eed39410 r5:eec71e20 r4:c065629c r3:00000000
    [<c026b258>] (__device_attach_driver) from [<c02696e4>]
(bus_for_each_drv+0x8c/0x9c)
     r6:c026b258 r5:eec71e20 r4:00000000 r3:00000001
    [<c0269658>] (bus_for_each_drv) from [<c026ae40>]
(__device_attach+0x9c/0x110)
     r6:00000001 r5:c0656fb0 r4:eed39410
    [<c026ada4>] (__device_attach) from [<c026b438>]
(device_initial_probe+0x14/0x18)
     r7:c0656cc4 r6:eed39410 r5:c0656fb0 r4:eed32aa0
    [<c026b424>] (device_initial_probe) from [<c026a500>]
(bus_probe_device+0x30/0x8c)
    [<c026a4d0>] (bus_probe_device) from [<c026a93c>]
(deferred_probe_work_func+0x68/0x90)
     r6:c0656c80 r5:eed39410 r4:eed32aa0 r3:000006f8
    [<c026a8d4>] (deferred_probe_work_func) from [<c0041984>]
(process_one_work+0x244/0x3e8)
     r7:eec71eb0 r6:c0656cfc r5:eec3bc00 r4:eec33840

of_node_put() was called from genpd_dev_pm_attach().

I do not believe the bug is in pinctrl, as I saw the problem originally on a
platform where the affected device doesn't have pinctrl yet.
Also, the call to of_node_put() in genpd_dev_pm_attach() does look
legitimate to me.

Anyone with a clue?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
