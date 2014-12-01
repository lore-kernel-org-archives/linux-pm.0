From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH V4 1/3] PM / Domains: Initial PM clock support for genpd
Date: Mon,  1 Dec 2014 12:50:21 +0100
Message-ID: <1417434623-31301-2-git-send-email-ulf.hansson@linaro.org>
References: <1417434623-31301-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1417434623-31301-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, Simon Horman <horms@verge.net.au>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

It's quite common for PM domains to use PM clocks. Typically from SOC
specific code, the per device PM clock list is created and
pm_clk_suspend|resume() are invoked to handle clock gating/ungating.

A step towards consolidation is to integrate PM clock support into
genpd, which is what this patch does.

In this initial step, the calls to the pm_clk_suspend|resume() are
handled within genpd, but the per device PM clock list still needs to
be created from SOC specific code. It seems reasonable to have gendp to
handle that as well, but that left to future patches to address.

It's not every users of genpd that are keen on using PM clocks, thus we
need to provide this a configuration option for genpd. Therefore let's
add flag field in the genpd struct to keep this information and define
a new GENDP_FLAG_PM_CLK bit for it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

Changes in v4:
	Rename define.

Changes in v3:
	Moved define out of struct definition.
	Don't use bitops.h
	Rename define to GENDP_PM_CLK.
	
Changes in v2:
	Set ->start() callback to pm_clk_resume() and fixed comment.

---
 drivers/base/power/domain.c | 7 +++++++
 include/linux/pm_domain.h   | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 735c473..6a103a3 100644
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
@@ -1928,6 +1929,12 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->domain.ops.complete = pm_genpd_complete;
 	genpd->dev_ops.save_state = pm_genpd_default_save_state;
 	genpd->dev_ops.restore_state = pm_genpd_default_restore_state;
+
+	if (genpd->flags & GENPD_FLAG_PM_CLK) {
+		genpd->dev_ops.stop = pm_clk_suspend;
+		genpd->dev_ops.start = pm_clk_resume;
+	}
+
 	mutex_lock(&gpd_list_lock);
 	list_add(&genpd->gpd_list_node, &gpd_list);
 	mutex_unlock(&gpd_list_lock);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 8cbd32e..6cd20d5 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -17,6 +17,9 @@
 #include <linux/notifier.h>
 #include <linux/cpuidle.h>
 
+/* Defines used for the flags field in the struct generic_pm_domain */
+#define GENPD_FLAG_PM_CLK	(1U << 0) /* PM domain uses PM clk */
+
 enum gpd_status {
 	GPD_STATE_ACTIVE = 0,	/* PM domain is active */
 	GPD_STATE_WAIT_MASTER,	/* PM domain's master is being waited for */
@@ -76,6 +79,7 @@ struct generic_pm_domain {
 			  struct device *dev);
 	void (*detach_dev)(struct generic_pm_domain *domain,
 			   struct device *dev);
+	unsigned int flags;		/* Bit field of configs for genpd */
 };
 
 static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
-- 
1.9.1
