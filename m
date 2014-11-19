From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/3] PM / Domains: Initial PM clock support for genpd
Date: Wed, 19 Nov 2014 15:00:36 +0100
Message-ID: <1416405638-18812-2-git-send-email-ulf.hansson@linaro.org>
References: <1416405638-18812-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:61066 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbaKSOAv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Nov 2014 09:00:51 -0500
Received: by mail-lb0-f177.google.com with SMTP id z12so512638lbi.8
        for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2014 06:00:49 -0800 (PST)
In-Reply-To: <1416405638-18812-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>

It's quite common for PM domains to use PM clocks. Typically from SOC
specific code, the per device PM clock list is created and
pm_clk_suspend|resume() are invoked to handle clock gating/ungating.

A step towards consolidation is to integrate PM clock support into
genpd, which is what this patch does.

In this initial step, the calls to the pm_clk_suspend|resume() are
handled within genpd, but the per device PM clock list still needs to
be created from SOC specific code. It seems reasonable to have gendp to
handle that as well, but that left to future patches to address.

It's not every users of genpd that are keen on using PM clocks thus we
need to provide this a configuration option for genpd. Therefore let's
add flag field in the genpd struct to keep this information and define
a new PM_DOMAIN_PM_CLK bit can then be set at initialization.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 7 +++++++
 include/linux/pm_domain.h   | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 3989eb6..42e328c 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -12,6 +12,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_qos.h>
+#include <linux/pm_clock.h>
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/sched.h>
@@ -1948,6 +1949,12 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->domain.ops.complete = pm_genpd_complete;
 	genpd->dev_ops.save_state = pm_genpd_default_save_state;
 	genpd->dev_ops.restore_state = pm_genpd_default_restore_state;
+
+	if (genpd->flags & PM_DOMAIN_PM_CLK) {
+		genpd->dev_ops.stop = pm_clk_suspend;
+		genpd->dev_ops.start = pm_clk_suspend;
+	}
+
 	mutex_lock(&gpd_list_lock);
 	list_add(&genpd->gpd_list_node, &gpd_list);
 	mutex_unlock(&gpd_list_lock);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 9d254e2..44c6931 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -14,6 +14,7 @@
 #include <linux/pm.h>
 #include <linux/err.h>
 #include <linux/of.h>
+#include <linux/bitops.h>
 #include <linux/notifier.h>
 #include <linux/cpuidle.h>
 
@@ -76,6 +77,8 @@ struct generic_pm_domain {
 			  struct device *dev);
 	void (*detach_dev)(struct generic_pm_domain *domain,
 			   struct device *dev);
+	unsigned int flags;		/* Bit field of configs for genpd */
+#define PM_DOMAIN_PM_CLK	BIT(0)	/* PM domain use PM clk */
 };
 
 static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
-- 
1.9.1

