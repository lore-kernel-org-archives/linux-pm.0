From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH V3] PM / Domains: Remove intermediate states from the power off sequence
Date: Mon, 15 Jun 2015 16:49:16 -0700
Message-ID: <7ha8w01qir.fsf@deeprootsystems.com>
References: <1434020737-13354-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36832 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbbFOXtT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 19:49:19 -0400
Received: by pdjm12 with SMTP id m12so753678pdj.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 16:49:19 -0700 (PDT)
In-Reply-To: <1434020737-13354-1-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Thu, 11 Jun 2015 13:05:37 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Axel Haslam <ahaslam+renesas@baylibre.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> Genpd's ->runtime_suspend() (assigned to pm_genpd_runtime_suspend())
> doesn't immediately walk the hierarchy of ->runtime_suspend() callbacks.
> Instead, pm_genpd_runtime_suspend() calls pm_genpd_poweroff() which
> postpones that until *all* the devices in the genpd are runtime suspended.
>
> When pm_genpd_poweroff() discovers that the last device in the genpd is
> about to be runtime suspended, it calls __pm_genpd_save_device() for *all*
> the devices in the genpd sequentially. Furthermore,
> __pm_genpd_save_device() invokes the ->start() callback, walks the
> hierarchy of the ->runtime_suspend() callbacks and invokes the ->stop()
> callback. This causes a "thundering herd" problem.
>
> Let's address this issue by having pm_genpd_runtime_suspend() immediately
> walk the hierarchy of the ->runtime_suspend() callbacks, instead of
> postponing that to the power off sequence via pm_genpd_poweroff(). If the
> selected ->runtime_suspend() callback doesn't return an error code, call
> pm_genpd_poweroff() to see if it's feasible to also power off the PM
> domain.
>
> Adopting this change enables us to simplify parts of the code in genpd,
> for example the locking mechanism. Additionally, it gives some positive
> side effects, as described below.
>
> i)
> One device's ->runtime_resume() latency is no longer affected by other
> devices' latencies in a genpd.
>
> The complexity genpd has to support the option to abort the power off
> sequence suffers from latency issues. More precisely, a device that is
> requested to be runtime resumed, may end up waiting for
> __pm_genpd_save_device() to complete its operations for *another* device.
> That's because pm_genpd_poweroff() can't confirm an abort request while it
> waits for __pm_genpd_save_device() to return.
>
> As this patch removes the intermediate states in pm_genpd_poweroff() while
> powering off the PM domain, we no longer need the ability to abort that
> sequence.
>
> ii)
> Make pm_runtime[_status]_suspended() reliable when used with genpd.
>
> Until the last device in a genpd becomes idle, pm_genpd_runtime_suspend()
> will return 0 without actually walking the hierarchy of the
> ->runtime_suspend() callbacks. However, by returning 0 the runtime PM core
> considers the device as runtime_suspended, so
> pm_runtime[_status]_suspended() will return true, even though the device
> isn't (yet) runtime suspended.
>
> After this patch, since pm_genpd_runtime_suspend() immediately walks the
> hierarchy of the ->runtime_suspend() callbacks,
> pm_runtime[_status]_suspended() will accurately reflect the status of the
> device.
>
> iii)
> Enable fine-grained PM through runtime PM callbacks in drivers/subsystems.
>
> There are currently cases were drivers/subsystems implements runtime PM
> callbacks to deploy fine-grained PM (e.g. gate clocks, move pinctrl to
> power-save state, etc.). While using the genpd, pm_genpd_runtime_suspend()
> postpones invoking these callbacks until *all* the devices in the genpd
> are runtime suspended. In essence, one runtime resumed device prevents
> fine-grained PM for other devices within the same genpd.
>
> After this patch, since pm_genpd_runtime_suspend() immediately walks the
> hierarchy of the ->runtime_suspend() callbacks, fine-grained PM is enabled
> throughout all the levels of runtime PM callbacks.
>
> Unfortunately this patch also comes with a drawback, as described in the
> summary below.
>
> Driver's/subsystem's runtime PM callbacks may be invoked even when the
> genpd hasn't actually powered off the PM domain, potentially introducing
> unnecessary latency.
>
> However, in most cases, saving/restoring register contexts for devices are
> typically fast operations or can be optimized in device specific ways
> (e.g. shadow copies of register contents in memory, device-specific checks
> to see if context has been lost before restoring context, etc.).
>
> Still, in some cases the driver/subsystem may suffer from latency if
> runtime PM is used in a very fine-grained manner (e.g. for each IO request
> or xfer). To prevent that extra overhead, the driver/subsystem may deploy
> the runtime PM autosuspend feature.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Really like the updated changelog.  Very well described, and IMO you
make a very strong case for this change, which I completely agree is the
right way to go forward.  IMO, it greatly simplifies understanding this
code as well.

I have some minor nits below, but overall really like this approach and
would like to see this hit -next early in the v4.3 cycle so it gets good
test exposure.

I know Lina has been testing this (or an earlier version) on qcom
hardware so would be nice to get a tested-by from her, and would also be
nice to see if Geert has a chance to take this for a spin on his Renesas
hardware and anyone can take this for a spin on Exynos.

[...]

> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 2327613..2e03f68 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -133,41 +133,6 @@ static void genpd_sd_counter_inc(struct generic_pm_domain *genpd)
>  	smp_mb__after_atomic();
>  }
>  
> -static void genpd_acquire_lock(struct generic_pm_domain *genpd)
> -{
> -	DEFINE_WAIT(wait);
> -
> -	mutex_lock(&genpd->lock);
> -	/*
> -	 * Wait for the domain to transition into either the active,
> -	 * or the power off state.
> -	 */
> -	for (;;) {
> -		prepare_to_wait(&genpd->status_wait_queue, &wait,
> -				TASK_UNINTERRUPTIBLE);
> -		if (genpd->status == GPD_STATE_ACTIVE
> -		    || genpd->status == GPD_STATE_POWER_OFF)
> -			break;
> -		mutex_unlock(&genpd->lock);
> -
> -		schedule();
> -
> -		mutex_lock(&genpd->lock);
> -	}
> -	finish_wait(&genpd->status_wait_queue, &wait);
> -}
> -
> -static void genpd_release_lock(struct generic_pm_domain *genpd)
> -{
> -	mutex_unlock(&genpd->lock);
> -}
> -
> -static void genpd_set_active(struct generic_pm_domain *genpd)
> -{
> -	if (genpd->resume_count == 0)
> -		genpd->status = GPD_STATE_ACTIVE;
> -}

Minor nit: I think you should leave these 3 helpers and just simplify
them.  It will make the changes below easier to read as well.

Also, for the locking, Lina will be adding these locking functions back
anyways, so let's just avoid the extra churn.

Otherwise, I think this version is looking really good.

With the above tweaks, feel free to add 

Reviewed-by: Kevin Hilman <khilman@linaro.org>

Kevin
