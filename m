From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3] PM / Domains: Avoid infinite loops in attach/detach code
Date: Fri, 26 Jun 2015 11:14:14 +0200
Message-ID: <1435310054-15585-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

If pm_genpd_{add,remove}_device() keeps on failing with -EAGAIN, we end
up with an infinite loop in genpd_dev_pm_{at,de}tach().

This may happen due to a genpd.prepared_count imbalance.  This is a bug
elsewhere, but it will result in a system lock up, possibly during
reboot of an otherwise functioning system.

To avoid this, put a limit on the maximum number of loop iterations,
using an exponential back-off mechanism.  If the limit is reached, the
operation will just fail.  An error message is already printed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Increase maximum timeout to ca. 250 ms (delay time only, i.e. not
    including actual processing time),
  - use mdelay() instead of udelay(), as the former is limited to 2 ms,
  - Use exponential back-off, busy waiting for 1 to 128 ms in each
    iteration, up to 255 ms in total,

v2:
  - Add missing declaration of "i" in genpd_dev_pm_attach().
---
 drivers/base/power/domain.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index cdd547bd67df8218..0ee43c1056e045bd 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -6,6 +6,7 @@
  * This file is released under the GPLv2.
  */
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
@@ -19,6 +20,8 @@
 #include <linux/suspend.h>
 #include <linux/export.h>
 
+#define GENPD_RETRY_MAX_MS	250		/* Approximate */
+
 #define GENPD_DEV_CALLBACK(genpd, type, callback, dev)		\
 ({								\
 	type (*__routine)(struct device *__d); 			\
@@ -2131,6 +2134,7 @@ EXPORT_SYMBOL_GPL(of_genpd_get_from_provider);
 static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 {
 	struct generic_pm_domain *pd;
+	unsigned int i;
 	int ret = 0;
 
 	pd = pm_genpd_lookup_dev(dev);
@@ -2139,10 +2143,12 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 
 	dev_dbg(dev, "removing from PM domain %s\n", pd->name);
 
-	while (1) {
+	for (i = 1; i < GENPD_RETRY_MAX_MS; i <<= 1) {
 		ret = pm_genpd_remove_device(pd, dev);
 		if (ret != -EAGAIN)
 			break;
+
+		mdelay(i);
 		cond_resched();
 	}
 
@@ -2183,6 +2189,7 @@ int genpd_dev_pm_attach(struct device *dev)
 {
 	struct of_phandle_args pd_args;
 	struct generic_pm_domain *pd;
+	unsigned int i;
 	int ret;
 
 	if (!dev->of_node)
@@ -2218,10 +2225,12 @@ int genpd_dev_pm_attach(struct device *dev)
 
 	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
 
-	while (1) {
+	for (i = 1; i < GENPD_RETRY_MAX_MS; i <<= 1) {
 		ret = pm_genpd_add_device(pd, dev);
 		if (ret != -EAGAIN)
 			break;
+
+		mdelay(i);
 		cond_resched();
 	}
 
-- 
1.9.1

