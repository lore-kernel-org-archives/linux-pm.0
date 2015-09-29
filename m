From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH] PM / Domains: Remove in_progress counter from struct
 generic_pm_domain
Date: Tue, 29 Sep 2015 08:56:41 -0600
Message-ID: <20150929145641.GH19183@linaro.org>
References: <1443532357-3157-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35232 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756544AbbI2O4o (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Sep 2015 10:56:44 -0400
Received: by pacfv12 with SMTP id fv12so8731042pac.2
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2015 07:56:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1443532357-3157-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

On Tue, Sep 29 2015 at 07:12 -0600, Ulf Hansson wrote:
>Commit ba2bbfbf6307 ("PM / Domains: Remove intermediate states..") changed
>the power off sequence (pm_genpd_poweroff()), which from locking point of
>view means the genpd mutex is held throughout the sequence.
>
>The above change means the in_progress counter can't be updated while
>pm_genpd_poweroff() is executing, which allows us to remove the counter.
>
>Instead we inform pm_genpd_poweroff() via a bool parameter, to indicate
>whether we call it from the scheduled work or from the ->runtime_suspend()
>callback, since that all that matters.
>
>Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Lina Iyer <lina.iyer@linaro.org>
>---
> drivers/base/power/domain.c | 12 +++++-------
> include/linux/pm_domain.h   |  1 -
> 2 files changed, 5 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>index cf4950d..c785f2e 100644
>--- a/drivers/base/power/domain.c
>+++ b/drivers/base/power/domain.c
>@@ -315,11 +315,12 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
> /**
>  * pm_genpd_poweroff - Remove power from a given PM domain.
>  * @genpd: PM domain to power down.
>+ * @is_async: PM domain is powered down from a scheduled work
>  *
>  * If all of the @genpd's devices have been suspended and all of its subdomains
>  * have been powered down, remove power from @genpd.
>  */
>-static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
>+static int pm_genpd_poweroff(struct generic_pm_domain *genpd, bool is_async)
> {
> 	struct pm_domain_data *pdd;
> 	struct gpd_link *link;
>@@ -351,7 +352,7 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
> 			not_suspended++;
> 	}
>
>-	if (not_suspended > genpd->in_progress)
>+	if (not_suspended > 1 || (not_suspended == 1 && is_async))
> 		return -EBUSY;
>
> 	if (genpd->gov && genpd->gov->power_down_ok) {
>@@ -399,7 +400,7 @@ static void genpd_power_off_work_fn(struct work_struct *work)
> 	genpd = container_of(work, struct generic_pm_domain, power_off_work);
>
> 	mutex_lock(&genpd->lock);
>-	pm_genpd_poweroff(genpd);
>+	pm_genpd_poweroff(genpd, true);
> 	mutex_unlock(&genpd->lock);
> }
>
>@@ -445,9 +446,7 @@ static int pm_genpd_runtime_suspend(struct device *dev)
> 		return 0;
>
> 	mutex_lock(&genpd->lock);
>-	genpd->in_progress++;
>-	pm_genpd_poweroff(genpd);
>-	genpd->in_progress--;
>+	pm_genpd_poweroff(genpd, false);
> 	mutex_unlock(&genpd->lock);
>
> 	return 0;
>@@ -1462,7 +1461,6 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
> 	mutex_init(&genpd->lock);
> 	genpd->gov = gov;
> 	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
>-	genpd->in_progress = 0;
> 	atomic_set(&genpd->sd_count, 0);
> 	genpd->status = is_off ? GPD_STATE_POWER_OFF : GPD_STATE_ACTIVE;
> 	genpd->device_count = 0;
>diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>index 384b1d1..0eaa730 100644
>--- a/include/linux/pm_domain.h
>+++ b/include/linux/pm_domain.h
>@@ -47,7 +47,6 @@ struct generic_pm_domain {
> 	struct dev_power_governor *gov;
> 	struct work_struct power_off_work;
> 	const char *name;
>-	unsigned int in_progress;	/* Number of devices being suspended now */
> 	atomic_t sd_count;	/* Number of subdomains with power "on" */
> 	enum gpd_status status;	/* Current state of the domain */
> 	unsigned int device_count;	/* Number of devices */
>-- 
>1.9.1
>
