From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [RFC/PATCH V2] PM / Domains: Remove intermediate states from the
 power off sequence
Date: Wed, 3 Jun 2015 12:38:59 -0600
Message-ID: <20150603183859.GR32700@linaro.org>
References: <1432735844-21629-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36626 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755916AbbFCSjD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2015 14:39:03 -0400
Received: by pabqy3 with SMTP id qy3so12532933pab.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2015 11:39:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1432735844-21629-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Axel Haslam <ahaslam+renesas@baylibre.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org

On Wed, May 27 2015 at 08:11 -0600, Ulf Hansson wrote:
>Genpd's ->runtime_suspend() (assigned to pm_genpd_runtime_suspend())
>doesn't immediately walk the hierarchy of ->runtime_suspend() callbacks.
>Instead, pm_genpd_runtime_suspend() calls pm_genpd_poweroff() which
>postpones that until *all* the devices in the genpd are runtime suspended.
>
>When pm_genpd_poweroff() discovers that the last device in the genpd is
>about to be runtime suspended, it calls __pm_genpd_save_device() for *all*
>the devices in the genpd sequentially. Furthermore,
>__pm_genpd_save_device() invokes the ->start() callback, walks the
>hierarchy of the ->runtime_suspend() callbacks and invokes the ->stop()
>callback. This causes a "thundering herd" problem.
>
>Let's address this issue by having pm_genpd_runtime_suspend() immediately
>walk the hierarchy of the ->runtime_suspend() callbacks, instead of
>postponing that to the power off sequence via pm_genpd_poweroff(). If the
>selected ->runtime_suspend() callback doesn't return an error code, call
>pm_genpd_poweroff() to see if it's feasible to also power off the PM
>domain.
>
>Adopting this change enables us to simplify parts of the code in genpd,
>for example the locking mechanism. Additionally, it gives some positive
>side effects, as described below.
>
>i)
>One device's ->runtime_resume() latency is no longer affected by other
>devices' latencies in a genpd.
>
>The complexity genpd has to support the option to abort the power off
>sequence suffers from latency issues. More precisely, a device that is
>requested to be runtime resumed, may end up waiting for
>__pm_genpd_save_device() to complete its operations for *another* device.
>That's because pm_genpd_poweroff() can't confirm an abort request while it
>waits for __pm_genpd_save_device() to return.
>
>As this patch removes the intermediate states in pm_genpd_poweroff() while
>powering off the PM domain, we no longer need the ability to abort that
>sequence.
>
>ii)
>Make pm_runtime[_status]_suspended() reliable when used with genpd.
>
>Until the last device in a genpd becomes idle, pm_genpd_runtime_suspend()
>will return 0 without actually walking the hierarchy of the
>->runtime_suspend() callbacks. However, by returning 0 the runtime PM core
>considers the device as runtime_suspended, so
>pm_runtime[_status]_suspended() will return true, even though the device
>isn't (yet) runtime suspended.
>
>After this patch, since pm_genpd_runtime_suspend() immediately walks the
>hierarchy of the ->runtime_suspend() callbacks,
>pm_runtime[_status]_suspended() will accurately reflect the status of the
>device.
>
>iii)
>Enable fine-grained PM through runtime PM callbacks in drivers/subsystems.
>
>There are currently cases were drivers/subsystems implements runtime PM
>callbacks to deploy fine-grained PM (e.g. gate clocks, move pinctrl to
>power-save state, etc.). While using the genpd, pm_genpd_runtime_suspend()
>postpones invoking these callbacks until *all* the devices in the genpd
>are runtime suspended. In essence, one runtime resumed device prevents
>fine-grained PM for other devices within the same genpd.
>
>After this patch, since pm_genpd_runtime_suspend() immediately walks the
>hierarchy of the ->runtime_suspend() callbacks, fine-grained PM is enabled
>throughout all the levels of runtime PM callbacks.
>
>Unfortunately this patch also comes with a drawback, as described in the
>summary below.
>
>Driver's/subsystem's runtime PM callbacks may be invoked even when the
>genpd hasn't actually powered off the PM domain, potentially introducing
>unnecessary latency.
>
>However, in most cases, saving/restoring register contexts for devices are
>typically fast operations or can be optimized in device specific ways
>(e.g. shadow copies of register contents in memory, device-specific checks
>to see if context has been lost before restoring context, etc.).
>
>Still, in some cases the driver/subsystem may suffer from latency if
>runtime PM is used in a very fine-grained manner (e.g. for each IO request
>or xfer). To prevent that extra overhead, the driver/subsystem may deploy
>the runtime PM autosuspend feature.
>
>Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>---
>
>Changes in v2:
>	Updated the changelog and the commit message header.
>	Header for v1 was "PM / Domains: Minimize latencies by not delaying
>	save/restore".
>
>---

<...>

> static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
>-	__releases(&genpd->lock) __acquires(&genpd->lock)
> {
> 	struct gpd_link *link;
>-	DEFINE_WAIT(wait);
> 	int ret = 0;
>
>-	/* If the domain's master is being waited for, we have to wait too. */
>-	for (;;) {
>-		prepare_to_wait(&genpd->status_wait_queue, &wait,
>-				TASK_UNINTERRUPTIBLE);
>-		if (genpd->status != GPD_STATE_WAIT_MASTER)
>-			break;
>-		mutex_unlock(&genpd->lock);
>-
>-		schedule();
>-
>-		mutex_lock(&genpd->lock);
>-	}
>-	finish_wait(&genpd->status_wait_queue, &wait);
>-
> 	if (genpd->status == GPD_STATE_ACTIVE
> 	    || (genpd->prepared_count > 0 && genpd->suspend_power_off))
> 		return 0;
>
>-	if (genpd->status != GPD_STATE_POWER_OFF) {
>-		genpd_set_active(genpd);
>-		return 0;
>-	}
>-
> 	if (genpd->cpuidle_data) {
> 		cpuidle_pause_and_lock();
> 		genpd->cpuidle_data->idle_state->disabled = true;
>@@ -285,20 +229,8 @@ static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
> 	 */
> 	list_for_each_entry(link, &genpd->slave_links, slave_node) {
> 		genpd_sd_counter_inc(link->master);
>-		genpd->status = GPD_STATE_WAIT_MASTER;
>-
>-		mutex_unlock(&genpd->lock);
>
> 		ret = pm_genpd_poweron(link->master);
>-
>-		mutex_lock(&genpd->lock);
>-
>-		/*
>-		 * The "wait for parent" status is guaranteed not to change
>-		 * while the master is powering on.
>-		 */
>-		genpd->status = GPD_STATE_POWER_OFF;
>-		wake_up_all(&genpd->status_wait_queue);
> 		if (ret) {
> 			genpd_sd_counter_dec(link->master);
> 			goto err;
>@@ -310,14 +242,15 @@ static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
> 		goto err;
>
>  out:
>-	genpd_set_active(genpd);
>-
>+	genpd->status = GPD_STATE_ACTIVE;
> 	return 0;
>
>  err:
> 	list_for_each_entry_continue_reverse(link, &genpd->slave_links, slave_node)
> 		genpd_sd_counter_dec(link->master);
>
>+	/* In case we powered on a master, try to power it off again. */
>+	pm_genpd_poweroff_unused();
>
This is an expensive operation, it locks the list and for each domain
tries to power off the domain. You probably only need to traverse up the
hierarchy of this domain to ensure that the parents domains do not
remain unnecessarily powered on in this error clause.

Also, the function uses mutex_locks to lock the genpd list. In the
atomic genpd that I am proposing [1], we cannot call this function when
the domain power_on fails.

We probably need a function to recursively traverse the related domains
and power them down. Probably look at a different place to
opportunistically power down unused domains.

Thanks,
Lina

[1]. http://www.spinics.net/lists/arm-kernel/msg423430.html
