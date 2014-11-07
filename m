From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH] PM / Domains: Fix initial default state of the
 need_restore flag
Date: Fri, 07 Nov 2014 19:52:39 +0100
Message-ID: <545D14F7.9060309@samsung.com>
References: <1415366847-4807-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47099 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbaKGSwv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Nov 2014 13:52:51 -0500
In-reply-to: <1415366847-4807-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron Lu <aaron.lu@intel.com>

On 07/11/14 14:27, Ulf Hansson wrote:
[...]
> To handle things more properly in the generic PM domain, let's change
> the default initial value of the need_restore flag to reflect that the
> state is unknown. As soon as some of the runtime PM callbacks gets
> invoked, update the initial value accordingly.
> 
> Moreover, since the generic PM domain is verifying that all device's
> are both runtime PM enabled and suspended, using pm_runtime_suspended()
> while pm_genpd_poweroff() is invoked from the scheduled work, we can be
> sure of that the PM domain won't be powering off while having active
> devices.
> 
> Do note that, the generic PM domain can still only know about active
> devices which has been activated through invoking its runtime PM resume
> callback. In other words, buses/drivers using pm_runtime_set_active()
> during ->probe() will still suffer from a race condition, potentially
> probing a device without having its PM domain being powered. That issue
> will have to be solved using a different approach.
> 
> This a log from the boot regression for Exynos5, which is being fixed in
> this patch.
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 308 at ../drivers/clk/clk.c:851 clk_disable+0x24/0x30()
> Modules linked in:
> CPU: 0 PID: 308 Comm: kworker/0:1 Not tainted 3.18.0-rc3-00569-gbd9449f-dirty #10
> Workqueue: pm pm_runtime_work
> [<c0013c64>] (unwind_backtrace) from [<c0010dec>] (show_stack+0x10/0x14)
> [<c0010dec>] (show_stack) from [<c03ee4cc>] (dump_stack+0x70/0xbc)
> [<c03ee4cc>] (dump_stack) from [<c0020d34>] (warn_slowpath_common+0x64/0x88)
> [<c0020d34>] (warn_slowpath_common) from [<c0020d74>] (warn_slowpath_null+0x1c/0x24)
> [<c0020d74>] (warn_slowpath_null) from [<c03107b0>] (clk_disable+0x24/0x30)
> [<c03107b0>] (clk_disable) from [<c02cc834>] (gsc_runtime_suspend+0x128/0x160)
> [<c02cc834>] (gsc_runtime_suspend) from [<c0249024>] (pm_generic_runtime_suspend+0x2c/0x38)
> [<c0249024>] (pm_generic_runtime_suspend) from [<c024f44c>] (pm_genpd_default_save_state+0x2c/0x8c)
> [<c024f44c>] (pm_genpd_default_save_state) from [<c024ff2c>] (pm_genpd_poweroff+0x224/0x3ec)
> [<c024ff2c>] (pm_genpd_poweroff) from [<c02501b4>] (pm_genpd_runtime_suspend+0x9c/0xcc)
> [<c02501b4>] (pm_genpd_runtime_suspend) from [<c024a4f8>] (__rpm_callback+0x2c/0x60)
> [<c024a4f8>] (__rpm_callback) from [<c024a54c>] (rpm_callback+0x20/0x74)
> [<c024a54c>] (rpm_callback) from [<c024a930>] (rpm_suspend+0xd4/0x43c)
> [<c024a930>] (rpm_suspend) from [<c024bbcc>] (pm_runtime_work+0x80/0x90)
> [<c024bbcc>] (pm_runtime_work) from [<c0032a9c>] (process_one_work+0x12c/0x314)
> [<c0032a9c>] (process_one_work) from [<c0032cf4>] (worker_thread+0x3c/0x4b0)
> [<c0032cf4>] (worker_thread) from [<c003747c>] (kthread+0xcc/0xe8)
> [<c003747c>] (kthread) from [<c000e738>] (ret_from_fork+0x14/0x3c)
> ---[ end trace 40cd58bcd6988f12 ]---
> 
> Fixes: a4a8c2c4962bb655 (ARM: exynos: Move to generic PM domain DT bindings)
> Reported-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> This patch is intended as fix for 3.18 rc[n] due to the regression for Exynos
> SOCs.
> 
> I would also like to call for help in getting this thoroughly tested.
> 
> I have tested this on Arndale Dual, Exynos 5250. According the log attached in
> the commit message as well.

Thanks Ulf, I've tested this patch on top of v3.18-rc3 on Exynos4412 Trats2
board and it seems the unbalanced runtime_suspend() call issue is gone.

> I have tested this on UX500, which support for the generic PM domain is about
> to be queued for 3.19. Since UX500 uses the AMBA bus/drivers, which uses
> pm_runtime_set_active() instead of pm_runtime_get_sync() during ->probe(), I
> could also verify that this behavior is maintained.

I had some issues with such configuration, after modifying the drivers to
call pm_runtime_set_active() (instead of pm_runtime_get_sync()) in probe().
It looked like there is some access to the hardware with corresponding
power domain disabled. Couldn't debug it in reasonable time due to system
hanging, will try to get back to this on Wednesday.

> Finally I have also tested this patchset on UX500 and using the below patchset
> to make sure the approach is suitable long term wise as well.
> [PATCH v3 0/9] PM / Domains: Fix race conditions during boot
> http://www.spinics.net/lists/arm-kernel/msg369409.html

And with that additional patch series and the drivers modified everything
seemed to work too.

The patch looks good to me as a fix for v3.18, if others don't report
regressions feel free to add my:

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
(On Exynos4412 Trats2 board)
Tested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

-- 
Regards,
Sylwester
