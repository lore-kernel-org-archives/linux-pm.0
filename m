From: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: [PATCH 1/5] pm: domains: quieten down generic pm domains
Date: Sun, 27 Apr 2014 14:28:50 +0100
Message-ID: <E1WeP8U-0000Ug-RQ@rmk-PC.arm.linux.org.uk>
References: <20140427132312.GC26756@n2100.arm.linux.org.uk>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140427132312.GC26756-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
---
 drivers/base/power/domain.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index bfb8955c406c..ea91ea0e137b 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -42,7 +42,7 @@
 	struct gpd_timing_data *__td = &dev_gpd_data(dev)->td;			\
 	if (!__retval && __elapsed > __td->field) {				\
 		__td->field = __elapsed;					\
-		dev_warn(dev, name " latency exceeded, new value %lld ns\n",	\
+		dev_dbg(dev, name " latency exceeded, new value %lld ns\n",	\
 			__elapsed);						\
 		genpd->max_off_time_changed = true;				\
 		__td->constraint_changed = true;				\
@@ -242,7 +242,7 @@ static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
 			genpd->max_off_time_changed = true;
 			genpd_recalc_cpu_exit_latency(genpd);
 			if (genpd->name)
-				pr_warning("%s: Power-on latency exceeded, "
+				pr_debug("%s: Power-on latency exceeded, "
 					"new value %lld ns\n", genpd->name,
 					elapsed_ns);
 		}
@@ -566,7 +566,7 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
 			genpd->power_off_latency_ns = elapsed_ns;
 			genpd->max_off_time_changed = true;
 			if (genpd->name)
-				pr_warning("%s: Power-off latency exceeded, "
+				pr_debug("%s: Power-off latency exceeded, "
 					"new value %lld ns\n", genpd->name,
 					elapsed_ns);
 		}
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
