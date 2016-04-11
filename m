From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH/RFC v2] gpio: rcar: Add Runtime PM handling for interrupts
Date: Mon, 11 Apr 2016 19:26:09 +0300
Message-ID: <8178382.Z7YODHSRMC@avalon>
References: <1455811590-15836-1-git-send-email-geert+renesas@glider.be> <CACRpkdZ2zzP5u4uJDzsnks7ywrp3ddBt+YfxthJ+5mT-ECYLpg@mail.gmail.com> <56C703AC.4040803@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <56C703AC.4040803@arm.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Thomas Gleixner <tglx@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Wolfram Sang <wsa@the-dreams.de>, Grygorii Strashko <grygorii.strashko@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday 19 Feb 2016 11:59:40 Marc Zyngier wrote:
> On 19/02/16 09:18, Linus Walleij wrote:
> > Top-quoting so everyone on the new To:-line gets the context.
> > 
> > I definately need an indication from an irqchip maintainer like tglx or
> > Marc Z before I merge this. Also, as in reply to the previous letter,
> > coordinate efforts with Jon Hunters similar problem space.
> 
> Seems pretty straightforward to me.
>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Too straightforward to be correct :-/

[    6.232681] BUG: sleeping function called from invalid context at /home/laurent/src/iob/renesas/linux/drivers/base/power/runtime.c:955
[    6.244795] in_atomic(): 1, irqs_disabled(): 128, pid: 658, name: udevd
[    6.251429] CPU: 3 PID: 658 Comm: udevd Tainted: P                4.6.0-rc3 #756
[    6.258844] Hardware name: Generic R8A7790 (Flattened Device Tree)
[    6.265036] Backtrace: 
[    6.267535] [<c0014c98>] (dump_backtrace) from [<c0014fb0>] (show_stack+0x20/0x24)
[    6.275124]  r6:00000000 r5:00000000 r4:60000093 r3:00000000
[    6.280850] [<c0014f90>] (show_stack) from [<c01f614c>] (dump_stack+0x8c/0xac)
[    6.288105] [<c01f60c0>] (dump_stack) from [<c00510c8>] (___might_sleep+0x100/0x158)
[    6.295863]  r5:000003bb r4:c06ca340
[    6.299474] [<c0050fc8>] (___might_sleep) from [<c005118c>] (__might_sleep+0x6c/0xa8)
[    6.307317]  r4:c05b6a24
[    6.309880] [<c0051120>] (__might_sleep) from [<c02d971c>] (__pm_runtime_resume+0x98/0xa0)
[    6.318159]  r6:000000dc r5:00000004 r4:ea280010
[    6.322831] [<c02d9684>] (__pm_runtime_resume) from [<c02282c8>] (gpio_rcar_irq_request_resources+0x2c/0x34)
[    6.332674]  r7:00000000 r6:000000dc r5:e95b3c00 r4:e99f3c00
[    6.338397] [<c022829c>] (gpio_rcar_irq_request_resources) from [<c0077a88>] (__setup_irq+0x24c/0x5dc)
[    6.347724] [<c007783c>] (__setup_irq) from [<c0077ff4>] (request_threaded_irq+0xdc/0x180)
[    6.356004]  r10:bf0aabc8 r9:000000dc r8:e9bc3000 r7:c0075be8 r6:e99f3c00 r5:00002003
[    6.363905]  r4:e95b3c00
[    6.366466] [<c0077f18>] (request_threaded_irq) from [<c007a758>] (devm_request_threaded_irq+0x6c/0xac)
[    6.375874]  r10:ea2db810 r9:ea2db810 r8:00000000 r7:bf0aabc8 r6:000000dc r5:e9bc3000
[    6.383773]  r4:e95b3b50 r3:00002003
[    6.387410] [<c007a6ec>] (devm_request_threaded_irq) from [<bf0aab9c>] (mmc_gpiod_request_cd_irq+0xa4/0xd0 [mmc_core])
[    6.398121]  r10:ea2db800 r8:e9bc3000 r7:e9bed598 r6:000000dc r5:e9bed524 r4:e9bc3000
[    6.406065] [<bf0aaaf8>] (mmc_gpiod_request_cd_irq [mmc_core]) from [<bf09f3bc>] (mmc_start_host+0x70/0x90 [mmc_core])
[    6.416779]  r6:e9bc3300 r5:00000000 r4:e9bc3000
[    6.421476] [<bf09f34c>] (mmc_start_host [mmc_core]) from [<bf0a061c>] (mmc_add_host+0x54/0x78 [mmc_core])
[    6.431146]  r4:e9bc3000 r3:00000001
[    6.434782] [<bf0a05c8>] (mmc_add_host [mmc_core]) from [<bf134b3c>] (tmio_mmc_host_probe+0x3ac/0x450 [tmio_mmc_core])
[    6.445498]  r5:ffffffe0 r4:00000000
[    6.449119] [<bf134790>] (tmio_mmc_host_probe [tmio_mmc_core]) from [<bf1501e8>] (sh_mobile_sdhi_probe+0x198/0x414 [sh_mobile_sdhi])
[    6.461051]  r10:bf150d04 r9:e9bed598 r8:00000001 r7:ea2db810 r6:ea2db800 r5:e9bc3300
[    6.468958]  r4:e9bed590
[    6.471532] [<bf150050>] (sh_mobile_sdhi_probe [sh_mobile_sdhi]) from [<c02cf220>] (platform_drv_probe+0x60/0xc0)
[    6.481811]  r10:00000011 r9:00000000 r8:bf151464 r7:bf151464 r6:fffffdfb r5:ea2db810
[    6.489712]  r4:00000000
[    6.492271] [<c02cf1c0>] (platform_drv_probe) from [<c02ccf80>] (driver_probe_device+0x224/0x440)
[    6.501156]  r7:c06c45f8 r6:c08e2b44 r5:c08e2b3c r4:ea2db810
[    6.506878] [<c02ccd5c>] (driver_probe_device) from [<c02cd2a0>] (__driver_attach+0x104/0x128)
[    6.515508]  r10:00000000 r9:bf1514c0 r8:c06c4520 r7:00000000 r6:bf151464 r5:ea2db810
[    6.523411]  r4:ea2db844
[    6.525965] [<c02cd19c>] (__driver_attach) from [<c02cae04>] (bus_for_each_dev+0x64/0x98)
[    6.534156]  r6:c02cd19c r5:bf151464 r4:00000000 r3:00000000
[    6.539874] [<c02cada0>] (bus_for_each_dev) from [<c02cc5e4>] (driver_attach+0x2c/0x30)
[    6.547895]  r6:c06ace08 r5:ea294c80 r4:bf151464
[    6.552561] [<c02cc5b8>] (driver_attach) from [<c02cc264>] (bus_add_driver+0x18c/0x268)
[    6.560586] [<c02cc0d8>] (bus_add_driver) from [<c02cdf90>] (driver_register+0x88/0x104)
[    6.568691]  r8:bf153000 r7:00000001 r6:e9ba7a40 r5:c067cfc8 r4:bf151464
[    6.575464] [<c02cdf08>] (driver_register) from [<c02cef80>] (__platform_driver_register+0x50/0x54)
[    6.584523]  r5:c067cfc8 r4:c067cfc8
[    6.588141] [<c02cef30>] (__platform_driver_register) from [<bf153018>] (sh_mobile_sdhi_driver_init+0x18/0x24 [sh_mobile_sdhi])
[    6.599654] [<bf153000>] (sh_mobile_sdhi_driver_init [sh_mobile_sdhi]) from [<c000a884>] (do_one_initcall+0xc0/0x200)
[    6.610292] [<c000a7c4>] (do_one_initcall) from [<c00ccd28>] (do_init_module+0x70/0x1dc)
[    6.618398]  r10:000005fa r9:bf1514c0 r8:c00a1f28 r7:00000001 r6:e94f3fc0 r5:00000001
[    6.626299]  r4:bf1514c0
[    6.628860] [<c00cccb8>] (do_init_module) from [<c00a5368>] (load_module+0x19c8/0x2164)
[    6.636878]  r7:00000001 r6:e955ec00 r5:00000001 r4:e9b73f3c
[    6.642603] [<c00a39a0>] (load_module) from [<c00a5d38>] (SyS_finit_module+0xb0/0xe0)
[    6.650447]  r10:00000000 r9:e9b72000 r8:b6f75330 r7:00000009 r6:00000000 r5:00000000
[    6.658342]  r4:7fffffff
[    6.660901] [<c00a5c88>] (SyS_finit_module) from [<c0011940>] (ret_fast_syscall+0x0/0x34)
[    6.669093]  r8:c0011ae4 r7:0000017b r6:00000000 r5:00000000 r4:00020000

The .irq_request_resources() handler is called with a spinlock held, it thus
can't call the synchronous version of the PM runtime functions.

-- 
Regards,

Laurent Pinchart
