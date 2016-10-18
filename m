From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH V3] PM / Runtime: Defer resuming of the device in pm_runtime_force_resume()
Date: Tue, 18 Oct 2016 15:50:53 +0200
Message-ID: <CAMuHMdW8D9WbsYw0H38Lq0WcRya1Hx8LM_XKPVO3pYcZAcojxQ@mail.gmail.com>
References: <1476370734-23168-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:33921 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755244AbcJRNuy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Oct 2016 09:50:54 -0400
Received: by mail-it0-f68.google.com with SMTP id e203so5373743itc.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Oct 2016 06:50:54 -0700 (PDT)
In-Reply-To: <1476370734-23168-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>

Hi Ulf,

On Thu, Oct 13, 2016 at 4:58 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> When the pm_runtime_force_suspend|resume() helpers were invented, we still
> had CONFIG_PM_RUNTIME and CONFIG_PM_SLEEP as separate Kconfig options.
>
> To make sure these helpers worked for all combinations and without
> introducing too much of complexity, the device was always resumed in
> pm_runtime_force_resume().
>
> More precisely, when CONFIG_PM_SLEEP was set and CONFIG_PM_RUNTIME was
> unset, we needed to resume the device as the subsystem/driver couldn't
> rely on using runtime PM to do it.
>
> As the CONFIG_PM_RUNTIME option was merged into CONFIG_PM a while ago, it
> removed this combination, of using CONFIG_PM_SLEEP without the earlier
> CONFIG_PM_RUNTIME.
>
> For this reason we can now rely on the subsystem/driver to use runtime PM
> to resume the device, instead of forcing that to be done in all cases. In
> other words, let's defer the runtime resume to a later point when it's
> actually needed.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v3:
>         - Updated to take care of parent-child relations.
>         - Improved comment in the code and updated text in a function header
>         to better describe the changes.

Thanks for the update!

> This patch has earlier been sent standalone, but also as a part of series. In
> the end it turned out the solution needed some improvement to take care of
> parent-child relations, as reported by Geert [1].
>
> Geert, I would really appreciate if you could help out testing to make sure the
> reported issue is fixed.

Unfortunately it doesn't help. Still fails on both r8a73a4/ape6evm and
sh73a0/kzm9g.

First log (with some debugging) is:

[  455.004744] PM: Syncing filesystems ... [  455.011339] done.
[  455.013278] PM: Preparing system for sleep (mem)
[  455.029505] Freezing user space processes ... (elapsed 0.002 seconds) done.
[  455.039014] Freezing remaining freezable tasks ... (elapsed 0.002
seconds) done.
[  455.048691] PM: Suspending system (mem)
[  455.074914] PM: suspend of devices complete after 14.545 msecs
[  455.088095] PM: late suspend of devices complete after 7.338 msecs
[  455.100999] rmobile_pd_power_down: a3sp
[  455.105079] PM: noirq suspend of devices complete after 10.802 msecs
[  455.111515] Disabling non-boot CPUs ...
[  455.115389] Suspended for 5.486 seconds
[  455.116189] rmobile_pd_power_up: a3sp
[  455.181331] PM: noirq resume of devices complete after 65.698 msecs
[  455.194384] PM: early resume of devices complete after 6.162 msecs
[  455.202701] Unhandled fault: imprecise external abort (0x1406) at 0x00000000
[  455.209742] pgd = ee684000
[  455.212446] [00000000] *pgd=7fc35835
[  455.216042] Internal error: : 1406 [#1] SMP ARM
[  455.220577] CPU: 0 PID: 1128 Comm: s2ram Not tainted
4.9.0-rc1-ape6evm-00630-g98d02f8b47e9ad17-dirty #463
[  455.230128] Hardware name: Generic R8A73A4 (Flattened Device Tree)
[  455.236300] task: ee44a740 task.stack: ee5d4000
[  455.240842] PC is at smsc911x_resume+0x6c/0xbc
[  455.245280] LR is at smsc911x_resume+0x6c/0xbc
[  455.249720] pc : [<c02e2ce4>]    lr : [<c02e2ce4>]    psr: 200d0093
[  455.249720] sp : ee5d5d70  ip : 4302710e  fp : c0e35420
[  455.261179] r10: 200d0013  r9 : c056dbe5  r8 : c05861f8
[  455.266396] r7 : ee866600  r6 : ee866000  r5 : 00000064  r4 : ee866648
[  455.272914] r3 : f08c5000  r2 : 00000000  r1 : f08c5084  r0 : 00000000
[  455.279434] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment none
[  455.286645] Control: 10c5387d  Table: 6e68406a  DAC: 00000051
[  455.292382] Process s2ram (pid: 1128, stack limit = 0xee5d4210)
[  455.298293] Stack: (0xee5d5d70 to 0xee5d6000)
[  455.302647] 5d60:                                     ee86a810
c065b8ca c066a840 c06093ec
[  455.310814] 5d80: c066a82c c056dbe5 c02c6f48 c02d11a8 c02d208c
ee86a810 00000000 00000000
[  455.318981] 5da0: 00000000 00000000 ee44a740 00000001 ee86a810
00000010 ee86a844 00000000
[  455.327148] 5dc0: ee86a810 c06093ec c0e35420 c02d21a0 ee86a8c0
c0e35420 c066a818 00000010
[  455.335316] 5de0: c065573c c02d23a0 fc08817d 00000069 fb4c1b05
c066c224 00000000 c066c224
[  455.343483] 5e00: fc08817d 00000069 fb4c1b05 00000010 00000003
c066a818 c0df99a8 c061cdc6
[  455.351650] 5e20: c066a818 c066a818 c06093ec c02d269c 00000000
c0083824 c05497f9 c05497da
[  455.359817] 5e40: c061cdc6 c0df99b4 c05497c9 c008dbbc c0549792
ee5d5e74 ee5d5e74 c061cdc6
[  455.367984] 5e60: c066a818 c06093ec 00000003 c05497da c061cdc6
c0df99b4 c05497c9 c00845a4
[  455.376150] 5e80: 00000000 c01a3214 00000000 00000008 00000001
00000003 00000003 ee49f840
[  455.384317] 5ea0: 00000004 c0543e99 c0df99b4 00000000 00000000
c0082058 00000004 00000004
[  455.392484] 5ec0: eeb75240 ee49f840 ee5d5f88 eeb7524c 00000051
c01a325c 00000000 00000000
[  455.400652] 5ee0: 00000004 c01a30d0 ee446a80 ee5d5f88 000ce408
c000fce4 ee5d4000 c01392d8
[  455.408819] 5f00: eebb023c c007b588 00000001 c061cde4 eebb023c
c0097968 c0097920 c0097cac
[  455.416985] 5f20: d0632d2c eebb00b4 00000000 c013c970 00000001
00000000 c0139520 00000000
[  455.425152] 5f40: 00000000 00000004 ee446a80 00000004 ee446a80
ee5d5f88 000ce408 c0139534
[  455.433320] 5f60: ee446a80 000ce408 00000004 ee446a80 ee446a80
00000004 000ce408 c000fce4
[  455.441486] 5f80: ee5d4000 c0139680 00000000 00000000 00000004
00000004 000ce408 b6f25b50
[  455.449653] 5fa0: 00000004 c000fb40 00000004 000ce408 00000001
000ce408 00000004 00000000
[  455.457820] 5fc0: 00000004 000ce408 b6f25b50 00000004 00000004
00000000 000c5758 00000000
[  455.465987] 5fe0: 00000000 bef2b754 b6e88c65 b6ec3e56 40010030
00000001 2b14070c 1a0d2022
[  455.474169] [<c02e2ce4>] (smsc911x_resume) from [<c02d11a8>]
(dpm_run_callback+0x118/0x33c)
[  455.482515] [<c02d11a8>] (dpm_run_callback) from [<c02d21a0>]
(device_resume+0x164/0x1a8)
[  455.490685] [<c02d21a0>] (device_resume) from [<c02d23a0>]
(dpm_resume+0x1bc/0x4ac)
[  455.498335] [<c02d23a0>] (dpm_resume) from [<c02d269c>]
(dpm_resume_end+0xc/0x18)
[  455.505818] [<c02d269c>] (dpm_resume_end) from [<c0083824>]
(suspend_devices_and_enter+0x734/0xc28)
[  455.514856] [<c0083824>] (suspend_devices_and_enter) from
[<c00845a4>] (pm_suspend+0x88c/0xa24)
[  455.523546] [<c00845a4>] (pm_suspend) from [<c0082058>]
(state_store+0xa0/0xbc)
[  455.530856] [<c0082058>] (state_store) from [<c01a325c>]
(kernfs_fop_write+0x18c/0x1c8)
[  455.538857] [<c01a325c>] (kernfs_fop_write) from [<c01392d8>]
(__vfs_write+0x20/0x108)
[  455.546765] [<c01392d8>] (__vfs_write) from [<c0139534>]
(vfs_write+0xb8/0x144)
[  455.554068] [<c0139534>] (vfs_write) from [<c0139680>] (SyS_write+0x40/0x80)
[  455.561115] [<c0139680>] (SyS_write) from [<c000fb40>]
(ret_fast_syscall+0x0/0x1c)
[  455.568676] Code: e5933000 e1a0a000 e1a00007 e12fff33 (e1a0100a)
[  455.574769] ---[ end trace b00ed34052fc8444 ]---

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
