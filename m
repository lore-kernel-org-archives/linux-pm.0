From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH RESEND] power: genpd: fix lockdep issue for all subdomains
Date: Sun, 24 Jan 2016 02:21:46 +0100
Message-ID: <2908677.zkL13xpsuk@vostro.rjw.lan>
References: <CAPDyKFpcckcRqHGR-J-nb9+O3yTjU4k4KyLqNwKT2M4RvTgq7w@mail.gmail.com> <1453281222-19055-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61596 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753301AbcAXBU6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 23 Jan 2016 20:20:58 -0500
In-Reply-To: <1453281222-19055-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Anand Moon <linux.amoon@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Kurtz <djkurtz@chromium.org>, Nicolas Boichat <drinkcat@chromium.org>

On Wednesday, January 20, 2016 10:13:42 AM Marek Szyprowski wrote:
> During genpd_poweron, genpd->lock is acquired recursively for each
> parent (master) domain, which are separate objects. This confuses
> lockdep, which considers every operation on genpd->lock as being done on
> the same lock class. This leads to the following false positive warning:
> 
> =============================================
> [ INFO: possible recursive locking detected ]
> 4.4.0-rc4-xu3s #32 Not tainted
> ---------------------------------------------
> swapper/0/1 is trying to acquire lock:
>  (&genpd->lock){+.+...}, at: [<c0361550>] __genpd_poweron+0x64/0x108
> 
> but task is already holding lock:
>  (&genpd->lock){+.+...}, at: [<c0361af8>] genpd_dev_pm_attach+0x168/0x1b8
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&genpd->lock);
>   lock(&genpd->lock);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> 3 locks held by swapper/0/1:
>  #0:  (&dev->mutex){......}, at: [<c0350910>] __driver_attach+0x48/0x98
>  #1:  (&dev->mutex){......}, at: [<c0350920>] __driver_attach+0x58/0x98
>  #2:  (&genpd->lock){+.+...}, at: [<c0361af8>] genpd_dev_pm_attach+0x168/0x1b8
> 
> stack backtrace:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.4.0-rc4-xu3s #32
> Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [<c0016c98>] (unwind_backtrace) from [<c00139c4>] (show_stack+0x10/0x14)
> [<c00139c4>] (show_stack) from [<c0270df0>] (dump_stack+0x84/0xc4)
> [<c0270df0>] (dump_stack) from [<c00780b8>] (__lock_acquire+0x1f88/0x215c)
> [<c00780b8>] (__lock_acquire) from [<c007886c>] (lock_acquire+0xa4/0xd0)
> [<c007886c>] (lock_acquire) from [<c0641f2c>] (mutex_lock_nested+0x70/0x4d4)
> [<c0641f2c>] (mutex_lock_nested) from [<c0361550>] (__genpd_poweron+0x64/0x108)
> [<c0361550>] (__genpd_poweron) from [<c0361b00>] (genpd_dev_pm_attach+0x170/0x1b8)
> [<c0361b00>] (genpd_dev_pm_attach) from [<c03520a8>] (platform_drv_probe+0x2c/0xac)
> [<c03520a8>] (platform_drv_probe) from [<c03507d4>] (driver_probe_device+0x208/0x2fc)
> [<c03507d4>] (driver_probe_device) from [<c035095c>] (__driver_attach+0x94/0x98)
> [<c035095c>] (__driver_attach) from [<c034ec14>] (bus_for_each_dev+0x68/0x9c)
> [<c034ec14>] (bus_for_each_dev) from [<c034fec8>] (bus_add_driver+0x1a0/0x218)
> [<c034fec8>] (bus_add_driver) from [<c035115c>] (driver_register+0x78/0xf8)
> [<c035115c>] (driver_register) from [<c0338488>] (exynos_drm_register_drivers+0x28/0x74)
> [<c0338488>] (exynos_drm_register_drivers) from [<c0338594>] (exynos_drm_init+0x6c/0xc4)
> [<c0338594>] (exynos_drm_init) from [<c00097f4>] (do_one_initcall+0x90/0x1dc)
> [<c00097f4>] (do_one_initcall) from [<c0895e08>] (kernel_init_freeable+0x158/0x1f8)
> [<c0895e08>] (kernel_init_freeable) from [<c063ecac>] (kernel_init+0x8/0xe8)
> [<c063ecac>] (kernel_init) from [<c000f7d0>] (ret_from_fork+0x14/0x24)
> 
> This patch replaces mutex_lock with mutex_lock_nested() and uses
> recursion depth to annotate each genpd->lock operation with separate
> lockdep subclass.
> 
> Reported-by: Anand Moon <linux.amoon@gmail.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> Tested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied (with a minor subject change), thanks!

Rafael

