From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] PM / Domains: Avoid infinite loops in attach/detach code
Date: Mon, 22 Jun 2015 09:31:22 +0200
Message-ID: <1434958282-27376-1-git-send-email-geert+renesas@glider.be>
References: <1434622954-26747-3-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1434622954-26747-3-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <damm@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

If pm_genpd_{add,remove}_device() keeps on failing with -EAGAIN, we end
up with an infinite loop in genpd_dev_pm_{at,de}tach().

This may happen due to a genpd.prepared_count imbalance.  This is a bug
elsewhere, but it will result in a system lock up, possibly during
reboot of an otherwise functioning system.

To avoid this, put a limit on the maximum number of loop iterations,
including a simple back-off mechanism.  If the limit is reached, the
operation will just fail.  An error message is already printed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/base/power/domain.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index cdd547bd67df8218..60e0309dd8dd0264 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -6,6 +6,7 @@
  * This file is released under the GPLv2.
  */
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
@@ -19,6 +20,9 @@
 #include <linux/suspend.h>
 #include <linux/export.h>
 
+#define GENPD_RETRIES	20
+#define GENPD_DELAY_US	10
+
 #define GENPD_DEV_CALLBACK(genpd, type, callback, dev)		\
 ({								\
 	type (*__routine)(struct device *__d); 			\
@@ -2131,6 +2135,7 @@ EXPORT_SYMBOL_GPL(of_genpd_get_from_provider);
 static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 {
 	struct generic_pm_domain *pd;
+	unsigned int i;
 	int ret = 0;
 
 	pd = pm_genpd_lookup_dev(dev);
@@ -2139,10 +2144,13 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 
 	dev_dbg(dev, "removing from PM domain %s\n", pd->name);
 
-	while (1) {
+	for (i = 0; i < GENPD_RETRIES; i++) {
 		ret = pm_genpd_remove_device(pd, dev);
 		if (ret != -EAGAIN)
 			break;
+
+		if (i > GENPD_RETRIES / 2)
+			udelay(GENPD_DELAY_US);
 		cond_resched();
 	}
 
@@ -2183,6 +2191,7 @@ int genpd_dev_pm_attach(struct device *dev)
 {
 	struct of_phandle_args pd_args;
 	struct generic_pm_domain *pd;
+	unsigned int i;
 	int ret;
 
 	if (!dev->of_node)
@@ -2218,10 +2227,13 @@ int genpd_dev_pm_attach(struct device *dev)
 
 	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
 
-	while (1) {
+	for (i = 0; i < GENPD_RETRIES; i++) {
 		ret = pm_genpd_add_device(pd, dev);
 		if (ret != -EAGAIN)
 			break;
+
+		if (i > GENPD_RETRIES / 2)
+			udelay(GENPD_DELAY_US);
 		cond_resched();
 	}
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
