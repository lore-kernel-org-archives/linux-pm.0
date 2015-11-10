From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] staging: board: Set PM domain before probe
Date: Tue, 10 Nov 2015 14:43:47 +0100
Message-ID: <CAMuHMdVz1UuPLuC=qFOEUtw3zdjvWsn7-VvYAXbh8hWjJ4przg@mail.gmail.com>
References: <1445956046-4248-1-git-send-email-tomeu.vizoso@collabora.com>
	<CAMuHMdXTGDFwxrY3rcTaZMuFv-LJuC=uUoORLyrHuQGpcQPy9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXTGDFwxrY3rcTaZMuFv-LJuC=uUoORLyrHuQGpcQPy9g@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, driverdevel <devel@driverdev.osuosl.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Tomeu,

On Tue, Oct 27, 2015 at 3:55 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, Oct 27, 2015 at 3:27 PM, Tomeu Vizoso
> <tomeu.vizoso@collabora.com> wrote:
>> PM domains shouldn't be modified after a device is probed, so set it
>> before device registration to be sure of that.
>>
>> In the future the PM domain pointer will be set through a setter that
>> will WARN if the device has been probed already.
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>

This is now commit 2b18a0eb107677d4 ("staging: board: Set PM domain before
probe").

> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

I seem to have missed this introduces the following BUG on r8a7740/armadillo:

    BUG: spinlock lockup suspected on CPU#0, swapper/1
     lock: lcdc0_device+0xa0/0x258, .magic: 00000000, .owner:
<none>/-1, .owner_cpu: 0
    CPU: 0 PID: 1 Comm: swapper Tainted: G        W
4.3.0-armadillo-12036-gb7051e9de565aaa8-dirty #836
    Hardware name: Generic R8A7740 (Flattened Device Tree)
    [<c0014c20>] (unwind_backtrace) from [<c00127cc>] (show_stack+0x10/0x14)
    [<c00127cc>] (show_stack) from [<c0053fac>] (do_raw_spin_lock+0xd4/0x118)
    [<c0053fac>] (do_raw_spin_lock) from [<c022a298>]
(dev_pm_get_subsys_data+0x2c/0x9c)
    [<c022a298>] (dev_pm_get_subsys_data) from [<c0233bd4>]
(__pm_genpd_add_device+0x84/0x260)
    [<c0233bd4>] (__pm_genpd_add_device) from [<c05927bc>]
(board_staging_register_device+0xd4/0x110)
    [<c05927bc>] (board_staging_register_device) from [<c059281c>]
(board_staging_register_devices+0x24/0x2c)
    [<c059281c>] (board_staging_register_devices) from [<c0592850>]
(runtime_board_check+0x2c/0x40)
    [<c0592850>] (runtime_board_check) from [<c0009734>]
(do_one_initcall+0x100/0x1b8)
    [<c0009734>] (do_one_initcall) from [<c057bce4>]
(kernel_init_freeable+0xfc/0x1c0)
    [<c057bce4>] (kernel_init_freeable) from [<c03e121c>] (kernel_init+0x8/0xe4)
    [<c03e121c>] (kernel_init) from [<c000ebf0>] (ret_from_fork+0x14/0x24)

The boot just continues and the display still works, and I guess that's why I
didn't notice before; sorry for that.

__pm_genpd_add_device() is now called before platform_device_register(),
at which time "dev->power.lock" hasn't been initialized yet, as
device_initialize() is only called from platform_device_register().

I can kill the warning by #including "../../base/power/power.h" and calling
pm_runtime_early_init(&pdev->dev) before pm_genpd_add_device(), but that's
a bit hacky.

When the PM domain is added in some other way (e.g. based on the
"power-domains" property in DT), this is done through
dev_pm_domain_attach() -> genpd_dev_pm_attach() ->
pm_genpd_add_device(), which is called from platform_drv_probe(), i.e.
after the device was registered, but before a driver is bound.

Thoughts?

Thanks, and sorry again for not noticing before.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
