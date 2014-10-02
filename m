From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v2 1/4] PM / Domains: Remove pm_genpd_dev_need_restore() API
Date: Thu, 02 Oct 2014 14:00:05 +0200
Message-ID: <542D3E45.5020908@samsung.com>
References: <1412174494-15346-1-git-send-email-ulf.hansson@linaro.org>
 <1412174494-15346-2-git-send-email-ulf.hansson@linaro.org>
 <542C2D9F.8060005@samsung.com>
 <CAPDyKFq+9G+n3qaj+Ls9i4sOi_BdOGzk5SypDzEMZJwAJMa97Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:41306 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbaJBMA2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Oct 2014 08:00:28 -0400
In-reply-to: <CAPDyKFq+9G+n3qaj+Ls9i4sOi_BdOGzk5SypDzEMZJwAJMa97Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun

Hello Ulf,

On 02/10/14 11:09, Ulf Hansson wrote:
> On 1 October 2014 18:36, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>> On 01/10/14 16:41, Ulf Hansson wrote:
>>> There are currently no users of this API, let's remove it.
> 
> Hi Sylwester,
> 
> Thanks for your reply!
> 
>> The sad fact is that removal of pm_genpd_dev_need_restore() calls
>> from arch/arm/mach-exynos/pm_domains.c introduces regressions in
>> multiple exynos drivers (I'm sure it breaks media drivers).
> 
> The fact that you need pm_genpd_dev_need_restore() is really worrying.
> That indicates that exynos are suffering from this race condition I am
> trying to fix in this patchset.
> 
>> I think before doing such changes all relevant drivers should be
>> updated first. I need to take a closer look again, but it seems
>> after dropping the pm_genpd_dev_need_restore() calls, client
>> driver's runtime_resume() callback is not being called in response
>> to first pm_runtime_get(_sync) call, even if a device is runtime
>> pm active.

Sorry, I meant to say "inactive" here.

> Why would runtime PM callbacks be invoked when the device are runtime
> PM active? That's prevented by the runtime PM core and is the expected
> behaviour.
> 
> pm_genpd_dev_need_restore() is not the solution, besides that it gives
> you the option to lie about device's runtime PM state to genpd. Thus,
> if you are really lucky, that might workaround your issues. :-)

Might be, nevertheless so far it more or less worked for us. At least
I'm sure without it everything breaks right away.

> I will happily help out in fixing drivers for exynos. Would be nice if
> you could provide me with a list of which driver/subsystems that seems
> broken. HW, wise I have a exynos 5250 and exynos 5422 on my desk, so
> those I can test.

For exynos5 I would check exynos-gsc and s5p-mfc (see kernel logs below).
I could take care of other, exynos4 drivers. But I believe the fix 
belongs in the PM core, I doubt we can solve in the driver a problem 
which only occurs to one instance (first probed) of a device from a set 
of devices in the power domain.

>> More details can be found in commit ebc35c726298ba3fdebba316a
>> 'ARM: EXYNOS: register devices in 'need_restore' state for pm_domains'.
>>
>> The above only happens when devices are added to an inactive power
>> domain, then I guess patch 2/4 is also an attempt to address this
>> issue ?
> 
> Yes.
> 
> I would really appreciate if you could run a test with the complete
> patchset and see if that resolves the issues.

Sure, is there a git tree I could fetch all the relevant patches from ?
I'm not sure what the base tree for this series, I could only apply
first 2 patches from this thread, on top of the generic OF PM domain
patches. And that didn't solve issues which are seen in the logs below.

Nevertheless, as Rafael pointed out, enabling all power domains 
unconditionally seems a step backwards. It would be nice to have 
resolved the race in a away the power domains remain in state left 
by the firmware and are being enabled only before any client device 
actually needs it.

                              
=====================================================================

[    2.301092] ------------[ cut here ]------------
[    2.305581] WARNING: CPU: 1 PID: 25 at drivers/clk/clk.c:889 clk_disable+0x24/0x30()
[    2.313288] Modules linked in:[    2.315985] s5p-fimc-md soc:camera: clk provider not registered
[    2.322055] 
[    2.323711] CPU: 1 PID: 25 Comm: kworker/1:0 Tainted: G        W     3.16.1-00612-gb8fe420-dirty #11731
[    2.333087] Workqueue: pm pm_runtime_work
[    2.337098] [<c0016548>] (unwind_backtrace) from [<c00129c4>] (show_stack+0x10/0x14)
[    2.344810] [<c00129c4>] (show_stack) from [<c0651264>] (dump_stack+0x80/0xcc)
[    2.352013] [<c0651264>] (dump_stack) from [<c00269e0>] (warn_slowpath_common+0x68/0x8c)
[    2.360082] [<c00269e0>] (warn_slowpath_common) from [<c0026a20>] (warn_slowpath_null+0x1c/0x24)
[    2.368849] [<c0026a20>] (warn_slowpath_null) from [<c0481190>] (clk_disable+0x24/0x30)
[    2.376838] [<c0481190>] (clk_disable) from [<c0415298>] (fimc_runtime_suspend+0x60/0x98)
[    2.384998] [<c0415298>] (fimc_runtime_suspend) from [<c0308edc>] (pm_generic_runtime_suspend+0x2c/0x38)
[    2.394459] [<c0308edc>] (pm_generic_runtime_suspend) from [<c03125a0>] (pm_genpd_default_save_state+0x50/0xb0)
[    2.404524] [<c03125a0>] (pm_genpd_default_save_state) from [<c0311ab8>] (pm_genpd_poweroff+0x22c/0x448)
[    2.413984] [<c0311ab8>] (pm_genpd_poweroff) from [<c0311d9c>] (pm_genpd_runtime_suspend+0xa4/0xf0)
[    2.423012] [<c0311d9c>] (pm_genpd_runtime_suspend) from [<c030a5b8>] (__rpm_callback+0x2c/0x60)
[    2.431779] [<c030a5b8>] (__rpm_callback) from [<c030a60c>] (rpm_callback+0x20/0x74)
[    2.439503] [<c030a60c>] (rpm_callback) from [<c030a9f4>] (rpm_suspend+0xd8/0x538)
[    2.447053] [<c030a9f4>] (rpm_suspend) from [<c030c084>] (pm_runtime_work+0x80/0x90)
[    2.454783] [<c030c084>] (pm_runtime_work) from [<c003dfec>] (process_one_work+0x124/0x420)
[    2.463113] [<c003dfec>] (process_one_work) from [<c003e354>] (worker_thread+0x38/0x568)
[    2.471185] [<c003e354>] (worker_thread) from [<c00442f8>] (kthread+0xcc/0xe8)
[    2.478390] [<c00442f8>] (kthread) from [<c000f208>] (ret_from_fork+0x14/0x2c)
[    2.485588] ---[ end trace 436d73983b61c827 ]---
[    2.490701] Unable to handle kernel NULL pointer dereference at virtual address 0000011c
[    2.498288] pgd = c0004000
[    2.500983] [0000011c] *pgd=00000000
[    2.504514] Internal error: Oops: 805 [#1] PREEMPT SMP ARM
[    2.509978] Modules linked in:
[    2.513022] CPU: 3 PID: 763 Comm: kworker/3:1 Tainted: G        W     3.16.1-00612-gb8fe420-dirty #11731
[    2.522482] Workqueue: pm pm_runtime_work
[    2.526471] task: ee19b840 ti: ed918000 task.ti: ed918000
[    2.531860] PC is at s5p_mfc_runtime_suspend+0xc/0x14
[    2.536892] LR is at pm_generic_runtime_suspend+0x2c/0x38
[    2.542270] pc : [<c04229a4>]    lr : [<c0308edc>]    psr: a0000113
[    2.542270] sp : ed919e20  ip : 00000000  fp : ed918000
[    2.553725] r10: 00000000  r9 : ee31988c  r8 : ee319884
[    2.558933] r7 : ee1686c0  r6 : ee319810  r5 : 00000001  r4 : ee3d3a10
[    2.565443] r3 : 00000000  r2 : 00000000  r1 : 0000030a  r0 : 00000000
[    2.571955] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    2.579245] Control: 10c53c7d  Table: 4000404a  DAC: 00000015
[    2.584974] Process kworker/3:1 (pid: 763, stack limit = 0xed918240)
[    2.591310] Stack: (0xed919e20 to 0xed91a000)
[    2.595654] 9e20: ee3d3a10 c03125a0 80231d55 c0311ab8 c0a140c0 0000000a 80231d55 00000000
[    2.603813] 9e40: 80231d55 00000000 80230b6d ee319810 ee31988c 00000000 c0a140c0 00000000
[    2.611971] 9e60: c0a140c0 0000000a ee3d3c10 c0311d9c ee3d3c10 ee3d3c74 c0311cf8 c030a5b8
[    2.620130] 9e80: ee3d3c10 00000000 00000008 c030a60c ee3d3cb8 00000000 00000008 c030a9f4
[    2.628289] 9ea0: 00000000 ed918000 00000000 c0a10840 ee3d3c10 ee3d3c74 00000000 ed918000
[    2.636449] 9ec0: 00000002 ee3d3cb8 ee3d3c74 eeb493d4 ed918000 eeb493c0 00000000 eeb4d100
[    2.644608] 9ee0: 00000000 c030c084 c030c004 ee2bb280 ee3d3cb8 c003dfec c0a0e2c0 ee1abecc
[    2.652767] 9f00: 00000001 ee1abed8 00000000 ee2bb280 eeb493c0 eeb493d4 ed918000 ed918000
[    2.660926] 9f20: 00000008 ee2bb298 eeb493c0 c003e354 c003e31c ed918000 00000000 00000000
[    2.669085] 9f40: 00000000 edb41180 00000000 ee2bb280 c003e31c 00000000 00000000 00000000
[    2.677245] 9f60: 00000000 c00442f8 00000000 00000000 ed919f9c ee2bb280 00000000 00000000
[    2.685404] 9f80: ed919f80 ed919f80 00000000 00000000 ed919f90 ed919f90 ed919fac edb41180
[    2.693563] 9fa0: c004422c 00000000 00000000 c000f208 00000000 00000000 00000000 00000000
[    2.701722] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    2.709882] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 ffffffff ffffffff
[    2.718050] [<c04229a4>] (s5p_mfc_runtime_suspend) from [<c0308edc>] (pm_generic_runtime_suspend+0x2c/0x38)
[    2.727770] [<c0308edc>] (pm_generic_runtime_suspend) from [<c03125a0>] (pm_genpd_default_save_state+0x50/0xb0)
[    2.737836] [<c03125a0>] (pm_genpd_default_save_state) from [<c0311ab8>] (pm_genpd_poweroff+0x22c/0x448)
[    2.747295] [<c0311ab8>] (pm_genpd_poweroff) from [<c0311d9c>] (pm_genpd_runtime_suspend+0xa4/0xf0)
[    2.756325] [<c0311d9c>] (pm_genpd_runtime_suspend) from [<c030a5b8>] (__rpm_callback+0x2c/0x60)
[    2.765090] [<c030a5b8>] (__rpm_callback) from [<c030a60c>] (rpm_callback+0x20/0x74)
[    2.772815] [<c030a60c>] (rpm_callback) from [<c030a9f4>] (rpm_suspend+0xd8/0x538)
[    2.780365] [<c030a9f4>] (rpm_suspend) from [<c030c084>] (pm_runtime_work+0x80/0x90)
[    2.788092] [<c030c084>] (pm_runtime_work) from [<c003dfec>] (process_one_work+0x124/0x420)
[    2.796424] [<c003dfec>] (process_one_work) from [<c003e354>] (worker_thread+0x38/0x568)
[    2.804496] [<c003e354>] (worker_thread) from [<c00442f8>] (kthread+0xcc/0xe8)
[    2.811702] [<c00442f8>] (kthread) from [<c000f208>] (ret_from_fork+0x14/0x2c)
[    2.818903] Code: e12fff1e e5902058 e3a03000 e1a00003 (e582311c) 
[    2.825018] ---[ end trace 436d73983b61c828 ]---



And here with printks in fimc-core.c and fimc-capture.c (in probe(), /dev/video 
open() and release() callbacks) to track device PM state:

[    2.263449] cam-power-domain: Power-on latency exceeded, new value 141375 ns
[    2.269257] exynos4-fimc 11800000.fimc: fimc_probe():1028: active: 0, suspended: 1
[    2.276933] exynos4-fimc 11810000.fimc: fimc_probe():1028: active: 0, suspended: 1
[    2.290555] s5p-fimc-md: Registered fimc.0.m2m as /dev/video0
[    2.296284] s5p-fimc-md: Registered fimc.0.capture as /dev/video1
[    2.302320] s5p-fimc-md: Registered fimc.1.m2m as /dev/video2
[    2.308042] s5p-fimc-md: Registered fimc.1.capture as /dev/video3
[    2.313970] exynos4-fimc 11800000.fimc: fimc_runtime_resume():1053: active: 0, suspended: 0
[    2.322320] exynos4-fimc 11810000.fimc: fimc_runtime_suspend():1073: active: 0, suspended: 1
[    2.330674] ------------[ cut here ]------------
[    2.341165] WARNING: CPU: 0 PID: 450 at drivers/clk/clk.c:889 clk_disable+0x24/0x30()
[    2.348963] Modules linked in:
[    2.352008] CPU: 0 PID: 450 Comm: kworker/0:1 Tainted: G        W     3.16.1-00612-gb8fe420-dirty #11735
[    2.361469] Workqueue: pm pm_runtime_work
[    2.365482] [<c0016548>] (unwind_backtrace) from [<c00129c4>] (show_stack+0x10/0x14)
[    2.373192] [<c00129c4>] (show_stack) from [<c06516b0>] (dump_stack+0x80/0xcc)
[    2.380395] [<c06516b0>] (dump_stack) from [<c00269e0>] (warn_slowpath_common+0x68/0x8c)
[    2.388464] [<c00269e0>] (warn_slowpath_common) from [<c0026a20>] (warn_slowpath_null+0x1c/0x24)
[    2.397232] [<c0026a20>] (warn_slowpath_null) from [<c04815dc>] (clk_disable+0x24/0x30)
[    2.405222] [<c04815dc>] (clk_disable) from [<c0415560>] (fimc_runtime_suspend+0xa0/0xdc)
[    2.413382] [<c0415560>] (fimc_runtime_suspend) from [<c0308edc>] (pm_generic_runtime_suspend+0x2c/0x38)
[    2.422843] [<c0308edc>] (pm_generic_runtime_suspend) from [<c03125a0>] (pm_genpd_default_save_state+0x50/0xb0)
[    2.432907] [<c03125a0>] (pm_genpd_default_save_state) from [<c0311ab8>] (pm_genpd_poweroff+0x22c/0x448)
[    2.442367] [<c0311ab8>] (pm_genpd_poweroff) from [<c0311d9c>] (pm_genpd_runtime_suspend+0xa4/0xf0)
[    2.451395] [<c0311d9c>] (pm_genpd_runtime_suspend) from [<c030a5b8>] (__rpm_callback+0x2c/0x60)
[    2.460162] [<c030a5b8>] (__rpm_callback) from [<c030a60c>] (rpm_callback+0x20/0x74)
[    2.467886] [<c030a60c>] (rpm_callback) from [<c030a9f4>] (rpm_suspend+0xd8/0x538)
[    2.475437] [<c030a9f4>] (rpm_suspend) from [<c030c084>] (pm_runtime_work+0x80/0x90)
[    2.483166] [<c030c084>] (pm_runtime_work) from [<c003dfec>] (process_one_work+0x124/0x420)
[    2.491496] [<c003dfec>] (process_one_work) from [<c003e354>] (worker_thread+0x38/0x568)
[    2.499568] [<c003e354>] (worker_thread) from [<c00442f8>] (kthread+0xcc/0xe8)
[    2.506774] [<c00442f8>] (kthread) from [<c000f208>] (ret_from_fork+0x14/0x2c)
[    2.513972] ---[ end trace 52eeee3f62bd143d ]---
[    2.518632] exynos4-fimc 11800000.fimc: fimc_runtime_suspend():1073: active: 0, suspended: 0
[    2.518724] s5p-mfc 13400000.codec: registered sysmmu controller for left subdevice
[    2.519335] exynos-sysmmu 13620000.sysmmu: Enabled
[    2.519378] Unable to handle kernel NULL pointer dereference at virtual address 0000011c
[    2.519382] pgd = c0004000
[    2.519387] [0000011c] *pgd=00000000
[    2.519394] Internal error: Oops: 805 [#1] PREEMPT SMP ARM
[    2.519400] Modules linked in:
[    2.519408] CPU: 1 PID: 25 Comm: kworker/1:0 Tainted: G        W     3.16.1-00612-gb8fe420-dirty #11735
[    2.519417] Workqueue: pm pm_runtime_work
[    2.519422] task: ee0dabc0 ti: ee0ee000 task.ti: ee0ee000
[    2.519434] PC is at s5p_mfc_runtime_suspend+0xc/0x14
[    2.519442] LR is at pm_generic_runtime_suspend+0x2c/0x38
[    2.519449] pc : [<c0422df0>]    lr : [<c0308edc>]    psr: a0000113
[    2.519449] sp : ee0efe20  ip : 00000000  fp : ee0ee000
[    2.519452] r10: 00000000  r9 : ee17d88c  r8 : ee17d884
[    2.519457] r7 : ed876cc0  r6 : ee17d810  r5 : 00000001  r4 : ed80ba10
[    2.519460] r3 : 00000000  r2 : 00000000  r1 : 0000035a  r0 : 00000000
[    2.519466] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    2.519471] Control: 10c53c7d  Table: 4000404a  DAC: 00000015
[    2.519475] Process kworker/1:0 (pid: 25, stack limit = 0xee0ee240)
[    2.519480] Stack: (0xee0efe20 to 0xee0f0000)
[    2.519488] fe20: ed80ba10 c03125a0 8304b081 c0311ab8 c0a140c0 0000000a 8304b081 00000000
[    2.519496] fe40: 8304b081 00000000 83049f6a ee17d810 ee17d88c 00000000 c0a140c0 00000000
[    2.519504] fe60: c0a140c0 0000000a ed80bc10 c0311d9c ed80bc10 ed80bc74 c0311cf8 c030a5b8
[    2.519511] fe80: ed80bc10 00000000 00000008 c030a60c ed80bcb8 00000000 00000008 c030a9f4
[    2.519518] fea0: 00000000 ee0ee000 00000000 c0a10840 ed80bc10 ed80bc74 00000000 ee0ee000
[    2.519525] fec0: 00000002 ed80bcb8 ed80bc74 eeb393d4 ee0ee000 eeb393c0 00000000 eeb3d100
[    2.519532] fee0: 00000000 c030c084 c030c004 ee05ae00 ed80bcb8 c003dfec ee0eff2c c0052e6c
[    2.519540] ff00: 00000001 eeb39840 eeb393d4 ee05ae00 eeb393c0 eeb393d4 ee0ee000 ee0ee000
[    2.519547] ff20: 00000008 ee05ae18 eeb393c0 c003e354 eeb393c0 ee0ee000 eeb39524 eeb39408
[    2.519554] ff40: c003e31c ee06a540 00000000 ee05ae00 c003e31c 00000000 00000000 00000000
[    2.519561] ff60: 00000000 c00442f8 00000000 00000000 ee0eff9c ee05ae00 00000000 00000000
[    2.519568] ff80: ee0eff80 ee0eff80 00000000 00000000 ee0eff90 ee0eff90 ee0effac ee06a540
[    2.519575] ffa0: c004422c 00000000 00000000 c000f208 00000000 00000000 00000000 00000000
[    2.519581] ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    2.519588] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000 ffffffff ffffffff
[    2.519603] [<c0422df0>] (s5p_mfc_runtime_suspend) from [<c0308edc>] (pm_generic_runtime_suspend+0x2c/0x38)
[    2.519617] [<c0308edc>] (pm_generic_runtime_suspend) from [<c03125a0>] (pm_genpd_default_save_state+0x50/0xb0)
[    2.519629] [<c03125a0>] (pm_genpd_default_save_state) from [<c0311ab8>] (pm_genpd_poweroff+0x22c/0x448)
[    2.519639] [<c0311ab8>] (pm_genpd_poweroff) from [<c0311d9c>] (pm_genpd_runtime_suspend+0xa4/0xf0)
[    2.519651] [<c0311d9c>] (pm_genpd_runtime_suspend) from [<c030a5b8>] (__rpm_callback+0x2c/0x60)
[    2.519662] [<c030a5b8>] (__rpm_callback) from [<c030a60c>] (rpm_callback+0x20/0x74)
[    2.519672] [<c030a60c>] (rpm_callback) from [<c030a9f4>] (rpm_suspend+0xd8/0x538)
[    2.519681] [<c030a9f4>] (rpm_suspend) from [<c030c084>] (pm_runtime_work+0x80/0x90)
[    2.519692] [<c030c084>] (pm_runtime_work) from [<c003dfec>] (process_one_work+0x124/0x420)
[    2.519701] [<c003dfec>] (process_one_work) from [<c003e354>] (worker_thread+0x38/0x568)
[    2.519710] [<c003e354>] (worker_thread) from [<c00442f8>] (kthread+0xcc/0xe8)
[    2.519720] [<c00442f8>] (kthread) from [<c000f208>] (ret_from_fork+0x14/0x2c)
[    2.519729] Code: e12fff1e e5902058 e3a03000 e1a00003 (e582311c) 
[    2.519735] ---[ end trace 52eeee3f62bd143e ]---

Note there is only one call to fimc_runtime_resume() for 11800000.fimc device 
and fimc_runtime_resume() call for both 11800000.fimc and 11810000.fimc.

--
Thanks,
Sylwester
