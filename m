From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH 2/2] PM / Domains: Merge measurements for PM QoS device
 latencies
Date: Thu, 15 Oct 2015 15:18:10 -0600
Message-ID: <20151015211810.GK921@linaro.org>
References: <1444921339-22614-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33590 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053AbbJOVSO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2015 17:18:14 -0400
Received: by pabrc13 with SMTP id rc13so98129395pab.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2015 14:18:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1444921339-22614-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

On Thu, Oct 15 2015 at 09:02 -0600, Ulf Hansson wrote:
>Measure latency does by itself contribute to an increased latency, thus we
>should avoid it when it isn't needed.
>
>By merging the latency measurements for the ->save_state() and the
>->stop() callbacks, we get one measurement instead of two and we get one
>value to store instead of two. Let's also apply the likewise change for
>the ->start() and ->restore_state() callbacks.
>
We should consider (at some point in the future) to make time
measurements domain-optional. Not all domains need to measure enter and
exit latency at runtime and they may not be needed. For example, the
latency of CPU domains is usually known and would be different
depending on the state of the domain. Ofcourse, that would need a new
governor as well.

That aside, this consolidation is a good step.

>Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Lina Iyer <lina.iyer@linaro.org>

Thanks,
Lina

>---
> drivers/base/power/domain.c          | 99 +++++++++++++++++++-----------------
> drivers/base/power/domain_governor.c |  6 +--
> include/linux/pm_domain.h            |  6 +--
> 3 files changed, 55 insertions(+), 56 deletions(-)
>
>diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>index a1c3ec4..a7dfdf9 100644
>--- a/drivers/base/power/domain.c
>+++ b/drivers/base/power/domain.c
>@@ -34,22 +34,6 @@
> 	__ret;							\
> })
>
>-#define GENPD_DEV_TIMED_CALLBACK(genpd, type, callback, dev, field, name)	\
>-({										\
>-	ktime_t __start = ktime_get();						\
>-	type __retval = GENPD_DEV_CALLBACK(genpd, type, callback, dev);		\
>-	s64 __elapsed = ktime_to_ns(ktime_sub(ktime_get(), __start));		\
>-	struct gpd_timing_data *__td = &dev_gpd_data(dev)->td;			\
>-	if (!__retval && __elapsed > __td->field) {				\
>-		__td->field = __elapsed;					\
>-		dev_dbg(dev, name " latency exceeded, new value %lld ns\n",	\
>-			__elapsed);						\
>-		genpd->max_off_time_changed = true;				\
>-		__td->constraint_changed = true;				\
>-	}									\
>-	__retval;								\
>-})
>-
> static LIST_HEAD(gpd_list);
> static DEFINE_MUTEX(gpd_list_lock);
>
>@@ -90,24 +74,14 @@ static struct generic_pm_domain *dev_to_genpd(struct device *dev)
> 	return pd_to_genpd(dev->pm_domain);
> }
>
>-static int genpd_stop_dev(struct generic_pm_domain *genpd, struct device *dev,
>-			bool timed)
>+static int genpd_stop_dev(struct generic_pm_domain *genpd, struct device *dev)
> {
>-	if (!timed)
>-		return GENPD_DEV_CALLBACK(genpd, int, stop, dev);
>-
>-	return GENPD_DEV_TIMED_CALLBACK(genpd, int, stop, dev,
>-					stop_latency_ns, "stop");
>+	return GENPD_DEV_CALLBACK(genpd, int, stop, dev);
> }
>
>-static int genpd_start_dev(struct generic_pm_domain *genpd, struct device *dev,
>-			bool timed)
>+static int genpd_start_dev(struct generic_pm_domain *genpd, struct device *dev)
> {
>-	if (!timed)
>-		return GENPD_DEV_CALLBACK(genpd, int, start, dev);
>-
>-	return GENPD_DEV_TIMED_CALLBACK(genpd, int, start, dev,
>-					start_latency_ns, "start");
>+	return GENPD_DEV_CALLBACK(genpd, int, start, dev);
> }
>
> static bool genpd_sd_counter_dec(struct generic_pm_domain *genpd)
>@@ -263,19 +237,13 @@ static int genpd_poweron(struct generic_pm_domain *genpd)
>
> static int genpd_save_dev(struct generic_pm_domain *genpd, struct device *dev)
> {
>-	return GENPD_DEV_TIMED_CALLBACK(genpd, int, save_state, dev,
>-					save_state_latency_ns, "state save");
>+	return GENPD_DEV_CALLBACK(genpd, int, save_state, dev);
> }
>
> static int genpd_restore_dev(struct generic_pm_domain *genpd,
>-			struct device *dev, bool timed)
>+			struct device *dev)
> {
>-	if (!timed)
>-		return GENPD_DEV_CALLBACK(genpd, int, restore_state, dev);
>-
>-	return GENPD_DEV_TIMED_CALLBACK(genpd, int, restore_state, dev,
>-					restore_state_latency_ns,
>-					"state restore");
>+	return GENPD_DEV_CALLBACK(genpd, int, restore_state, dev);
> }
>
> static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
>@@ -422,6 +390,9 @@ static int pm_genpd_runtime_suspend(struct device *dev)
> {
> 	struct generic_pm_domain *genpd;
> 	bool (*stop_ok)(struct device *__dev);
>+	struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
>+	ktime_t time_start;
>+	s64 elapsed_ns;
> 	int ret;
>
> 	dev_dbg(dev, "%s()\n", __func__);
>@@ -434,16 +405,29 @@ static int pm_genpd_runtime_suspend(struct device *dev)
> 	if (stop_ok && !stop_ok(dev))
> 		return -EBUSY;
>
>+	/* Measure suspend latency. */
>+	time_start = ktime_get();
>+
> 	ret = genpd_save_dev(genpd, dev);
> 	if (ret)
> 		return ret;
>
>-	ret = genpd_stop_dev(genpd, dev, true);
>+	ret = genpd_stop_dev(genpd, dev);
> 	if (ret) {
>-		genpd_restore_dev(genpd, dev, true);
>+		genpd_restore_dev(genpd, dev);
> 		return ret;
> 	}
>
>+	/* Update suspend latency value if the measured time exceeds it. */
>+	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
>+	if (elapsed_ns > td->suspend_latency_ns) {
>+		td->suspend_latency_ns = elapsed_ns;
>+		dev_dbg(dev, "suspend latency exceeded, %lld ns\n",
>+			elapsed_ns);
>+		genpd->max_off_time_changed = true;
>+		td->constraint_changed = true;
>+	}
>+
> 	/*
> 	 * If power.irq_safe is set, this routine will be run with interrupts
> 	 * off, so it can't use mutexes.
>@@ -469,6 +453,9 @@ static int pm_genpd_runtime_suspend(struct device *dev)
> static int pm_genpd_runtime_resume(struct device *dev)
> {
> 	struct generic_pm_domain *genpd;
>+	struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
>+	ktime_t time_start;
>+	s64 elapsed_ns;
> 	int ret;
> 	bool timed = true;
>
>@@ -492,8 +479,24 @@ static int pm_genpd_runtime_resume(struct device *dev)
> 		return ret;
>
>  out:
>-	genpd_start_dev(genpd, dev, timed);
>-	genpd_restore_dev(genpd, dev, timed);
>+	/* Measure resume latency. */
>+	if (timed)
>+		time_start = ktime_get();
>+
>+	genpd_start_dev(genpd, dev);
>+	genpd_restore_dev(genpd, dev);
>+
>+	/* Update resume latency value if the measured time exceeds it. */
>+	if (timed) {
>+		elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
>+		if (elapsed_ns > td->resume_latency_ns) {
>+			td->resume_latency_ns = elapsed_ns;
>+			dev_dbg(dev, "resume latency exceeded, %lld ns\n",
>+				elapsed_ns);
>+			genpd->max_off_time_changed = true;
>+			td->constraint_changed = true;
>+		}
>+	}
>
> 	return 0;
> }
>@@ -783,7 +786,7 @@ static int pm_genpd_suspend_noirq(struct device *dev)
> 	    || (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev)))
> 		return 0;
>
>-	genpd_stop_dev(genpd, dev, false);
>+	genpd_stop_dev(genpd, dev);
>
> 	/*
> 	 * Since all of the "noirq" callbacks are executed sequentially, it is
>@@ -824,7 +827,7 @@ static int pm_genpd_resume_noirq(struct device *dev)
> 	pm_genpd_sync_poweron(genpd, true);
> 	genpd->suspended_count--;
>
>-	return genpd_start_dev(genpd, dev, false);
>+	return genpd_start_dev(genpd, dev);
> }
>
> /**
>@@ -932,7 +935,7 @@ static int pm_genpd_freeze_noirq(struct device *dev)
> 	if (IS_ERR(genpd))
> 		return -EINVAL;
>
>-	return genpd->suspend_power_off ? 0 : genpd_stop_dev(genpd, dev, false);
>+	return genpd->suspend_power_off ? 0 : genpd_stop_dev(genpd, dev);
> }
>
> /**
>@@ -953,7 +956,7 @@ static int pm_genpd_thaw_noirq(struct device *dev)
> 		return -EINVAL;
>
> 	return genpd->suspend_power_off ?
>-		0 : genpd_start_dev(genpd, dev, false);
>+		0 : genpd_start_dev(genpd, dev);
> }
>
> /**
>@@ -1047,7 +1050,7 @@ static int pm_genpd_restore_noirq(struct device *dev)
>
> 	pm_genpd_sync_poweron(genpd, true);
>
>-	return genpd_start_dev(genpd, dev, false);
>+	return genpd_start_dev(genpd, dev);
> }
>
> /**
>diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
>index 85e17ba..e60dd12 100644
>--- a/drivers/base/power/domain_governor.c
>+++ b/drivers/base/power/domain_governor.c
>@@ -77,10 +77,8 @@ static bool default_stop_ok(struct device *dev)
> 				      dev_update_qos_constraint);
>
> 	if (constraint_ns > 0) {
>-		constraint_ns -= td->save_state_latency_ns +
>-				td->stop_latency_ns +
>-				td->start_latency_ns +
>-				td->restore_state_latency_ns;
>+		constraint_ns -= td->suspend_latency_ns +
>+				td->resume_latency_ns;
> 		if (constraint_ns == 0)
> 			return false;
> 	}
>diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>index f4dd810..ba4ced3 100644
>--- a/include/linux/pm_domain.h
>+++ b/include/linux/pm_domain.h
>@@ -81,10 +81,8 @@ struct gpd_link {
> };
>
> struct gpd_timing_data {
>-	s64 stop_latency_ns;
>-	s64 start_latency_ns;
>-	s64 save_state_latency_ns;
>-	s64 restore_state_latency_ns;
>+	s64 suspend_latency_ns;
>+	s64 resume_latency_ns;
> 	s64 effective_constraint_ns;
> 	bool constraint_changed;
> 	bool cached_stop_ok;
>-- 
>1.9.1
>
