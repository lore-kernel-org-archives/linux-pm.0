From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] PM / Domains: Fix initial default state of the
 need_restore flag
Date: Fri, 7 Nov 2014 13:57:51 -0800
Message-ID: <20141107215751.GA4439@dtor-ws>
References: <1415366847-4807-1-git-send-email-ulf.hansson@linaro.org>
 <7hr3xerdw6.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:60716 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbaKGV54 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Nov 2014 16:57:56 -0500
Content-Disposition: inline
In-Reply-To: <7hr3xerdw6.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron Lu <aaron.lu@intel.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>

On Fri, Nov 07, 2014 at 11:47:53AM -0800, Kevin Hilman wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
> 
> > The initial state of the device's need_restore flag should'nt depend on
> > the current state of the PM domain. For example it should be perfectly
> > valid to attach an inactive device to a powered PM domain.
> >
> > The pm_genpd_dev_need_restore() API allow us to update the need_restore
> > flag to somewhat cope with such scenarios. Typically that should have
> > been done from drivers/buses ->probe() since it's those that put the
> > requirements on the value of the need_restore flag.
> >
> > Until recently, the Exynos SOCs were the only user of the
> > pm_genpd_dev_need_restore() API, though invoking it from a centralized
> > location while adding devices to their PM domains.
> >
> > Due to that Exynos now have swithed to the generic OF-based PM domain
> > look-up, it's no longer possible to invoke the API from a centralized
> > location. The reason is because devices are now added to their PM
> > domains during the probe sequence.
> >
> > Commit "ARM: exynos: Move to generic PM domain DT bindings"
> > did the switch for Exynos to the generic OF-based PM domain look-up,
> > but it also removed the call to pm_genpd_dev_need_restore(). This
> > caused a regression for some of the Exynos drivers.
> >
> > To handle things more properly in the generic PM domain, let's change
> > the default initial value of the need_restore flag to reflect that the
> > state is unknown. As soon as some of the runtime PM callbacks gets
> > invoked, update the initial value accordingly.
> >
> > Moreover, since the generic PM domain is verifying that all device's
> > are both runtime PM enabled and suspended, using pm_runtime_suspended()
> > while pm_genpd_poweroff() is invoked from the scheduled work, we can be
> > sure of that the PM domain won't be powering off while having active
> > devices.
> >
> > Do note that, the generic PM domain can still only know about active
> > devices which has been activated through invoking its runtime PM resume
> > callback. In other words, buses/drivers using pm_runtime_set_active()
> > during ->probe() will still suffer from a race condition, potentially
> > probing a device without having its PM domain being powered. That issue
> > will have to be solved using a different approach.
> >
> > This a log from the boot regression for Exynos5, which is being fixed in
> > this patch.
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 308 at ../drivers/clk/clk.c:851 clk_disable+0x24/0x30()
> > Modules linked in:
> > CPU: 0 PID: 308 Comm: kworker/0:1 Not tainted 3.18.0-rc3-00569-gbd9449f-dirty #10
> > Workqueue: pm pm_runtime_work
> > [<c0013c64>] (unwind_backtrace) from [<c0010dec>] (show_stack+0x10/0x14)
> > [<c0010dec>] (show_stack) from [<c03ee4cc>] (dump_stack+0x70/0xbc)
> > [<c03ee4cc>] (dump_stack) from [<c0020d34>] (warn_slowpath_common+0x64/0x88)
> > [<c0020d34>] (warn_slowpath_common) from [<c0020d74>] (warn_slowpath_null+0x1c/0x24)
> > [<c0020d74>] (warn_slowpath_null) from [<c03107b0>] (clk_disable+0x24/0x30)
> > [<c03107b0>] (clk_disable) from [<c02cc834>] (gsc_runtime_suspend+0x128/0x160)
> > [<c02cc834>] (gsc_runtime_suspend) from [<c0249024>] (pm_generic_runtime_suspend+0x2c/0x38)
> > [<c0249024>] (pm_generic_runtime_suspend) from [<c024f44c>] (pm_genpd_default_save_state+0x2c/0x8c)
> > [<c024f44c>] (pm_genpd_default_save_state) from [<c024ff2c>] (pm_genpd_poweroff+0x224/0x3ec)
> > [<c024ff2c>] (pm_genpd_poweroff) from [<c02501b4>] (pm_genpd_runtime_suspend+0x9c/0xcc)
> > [<c02501b4>] (pm_genpd_runtime_suspend) from [<c024a4f8>] (__rpm_callback+0x2c/0x60)
> > [<c024a4f8>] (__rpm_callback) from [<c024a54c>] (rpm_callback+0x20/0x74)
> > [<c024a54c>] (rpm_callback) from [<c024a930>] (rpm_suspend+0xd4/0x43c)
> > [<c024a930>] (rpm_suspend) from [<c024bbcc>] (pm_runtime_work+0x80/0x90)
> > [<c024bbcc>] (pm_runtime_work) from [<c0032a9c>] (process_one_work+0x12c/0x314)
> > [<c0032a9c>] (process_one_work) from [<c0032cf4>] (worker_thread+0x3c/0x4b0)
> > [<c0032cf4>] (worker_thread) from [<c003747c>] (kthread+0xcc/0xe8)
> > [<c003747c>] (kthread) from [<c000e738>] (ret_from_fork+0x14/0x3c)
> > ---[ end trace 40cd58bcd6988f12 ]---
> >
> > Fixes: a4a8c2c4962bb655 (ARM: exynos: Move to generic PM domain DT bindings)
> > Reported-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Reviewed-by: Kevin Hilman <khilman@linaro.org>
> 
> And looks like we need this for v3.18-rc since it does fix the
> regression.

I guess we do need it for 3.18, but when we are talking about 3.19,
before we make any more changes can we outline how power domains are
supposed to work?

1. How do we attach a device to power domain? Right now it seems that
individual buses are responsible for attaching their devices to power
domains. Should we move it into driver core (device_pm_add?) so that
device starts its life in its proper power domain?

2. When do we power up the devices (and the domains)? Right now devices
in ACPI power domain are powered when they are attached to the power
domain (which coincides with probing), but generic power domains do not
do that. Can we add a separate API to explicitly power up the device (and
its domain if it is powered down) and do it again, either in device core
or in individual buses. This way, regardless of runtime PM or not, we
will have devices powered on when driver tries to bind to them. If
binding fails we can power down the device.

I've heard there is a concern about power domain bouncing up and down
during probing. Is it really a concern? Would not we run into the same
issues past booting up with aggressive PM policy? Anyway, we could
probably work around this by refusing to actually power down the domains
until we are done booting, similarly to who genpd_poweroff_unused works.

Thanks.

-- 
Dmitry
