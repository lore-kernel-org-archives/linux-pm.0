From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] PM / Domains: Skip latency measurements if timekeeping is suspended
Date: Wed, 18 Mar 2015 17:25:46 +0100
Message-ID: <1426695946-21705-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

The PM Domain code uses ktime_get() to perform various latency
measurements.  However, if ktime_get() is called while timekeeping is
suspended, the following warning is printed:

    WARNING: CPU: 0 PID: 1340 at kernel/time/timekeeping.c:576 ktime_get+0x30/0xf4()

This happens when resuming the PM Domain that contains the clock events
source. Chain of operations is:

    timekeeping_resume()
    {
        clockevents_resume()
            sh_cmt_clock_event_resume()
                pm_genpd_syscore_poweron()
                    pm_genpd_sync_poweron()
                        genpd_power_on()
                            ktime_get(), but timekeeping_suspended == 1
        ...
        timekeeping_suspended = 0;
    }

Skip all latency measurements if timekeeping is suspended to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
I'm not sure if this is needed for all latency measurements.
So far I only encountered it while powering-on a clock domain during
resume from s2ram.
---
 drivers/base/power/domain.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 45937f88e77c8889..ab2398cfcebb7732 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -18,6 +18,7 @@
 #include <linux/sched.h>
 #include <linux/suspend.h>
 #include <linux/export.h>
+#include <linux/timekeeping.h>
 
 #define GENPD_DEV_CALLBACK(genpd, type, callback, dev)		\
 ({								\
@@ -33,16 +34,24 @@
 
 #define GENPD_DEV_TIMED_CALLBACK(genpd, type, callback, dev, field, name)	\
 ({										\
-	ktime_t __start = ktime_get();						\
-	type __retval = GENPD_DEV_CALLBACK(genpd, type, callback, dev);		\
-	s64 __elapsed = ktime_to_ns(ktime_sub(ktime_get(), __start));		\
-	struct gpd_timing_data *__td = &dev_gpd_data(dev)->td;			\
-	if (!__retval && __elapsed > __td->field) {				\
-		__td->field = __elapsed;					\
-		dev_dbg(dev, name " latency exceeded, new value %lld ns\n",	\
-			__elapsed);						\
-		genpd->max_off_time_changed = true;				\
-		__td->constraint_changed = true;				\
+	type __retval;								\
+	if (unlikely(timekeeping_suspended)) {					\
+		dev_dbg(dev, "Skipping %s timings\n", #callback);		\
+		__retval = GENPD_DEV_CALLBACK(genpd, type, callback, dev);	\
+	} else {								\
+		ktime_t __start = ktime_get();					\
+		type __ret = GENPD_DEV_CALLBACK(genpd, type, callback, dev);	\
+		s64 __elapsed = ktime_to_ns(ktime_sub(ktime_get(), __start));	\
+		struct gpd_timing_data *__td = &dev_gpd_data(dev)->td;		\
+		if (!__ret && __elapsed > __td->field) {			\
+			__td->field = __elapsed;				\
+			dev_dbg(dev,						\
+				name " latency exceeded, new value %lld ns\n",	\
+				__elapsed);					\
+			genpd->max_off_time_changed = true;			\
+			__td->constraint_changed = true;			\
+		}								\
+		__retval = __ret;						\
 	}									\
 	__retval;								\
 })
@@ -161,6 +170,11 @@ static int genpd_power_on(struct generic_pm_domain *genpd)
 	if (!genpd->power_on)
 		return 0;
 
+	if (unlikely(timekeeping_suspended)) {
+		pr_debug("%s: Skipping %s timings\n", genpd->name, "power_on");
+		return genpd->power_on(genpd);
+	}
+
 	time_start = ktime_get();
 	ret = genpd->power_on(genpd);
 	if (ret)
@@ -188,6 +202,11 @@ static int genpd_power_off(struct generic_pm_domain *genpd)
 	if (!genpd->power_off)
 		return 0;
 
+	if (unlikely(timekeeping_suspended)) {
+		pr_debug("%s: Skipping %s timings\n", genpd->name, "power_off");
+		return genpd->power_off(genpd);
+	}
+
 	time_start = ktime_get();
 	ret = genpd->power_off(genpd);
 	if (ret == -EBUSY)
-- 
1.9.1

