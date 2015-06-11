From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / Domains: Try power off masters in error path of __pm_genpd_poweron()
Date: Thu, 11 Jun 2015 13:51:51 +0200
Message-ID: <1434023511-4263-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:35155 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbbFKLwC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jun 2015 07:52:02 -0400
Received: by labko7 with SMTP id ko7so3107495lab.2
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2015 04:52:00 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Axel Haslam <ahaslam+renesas@baylibre.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org

While powering up a genpd, its domain masters are first being powered up.
In the error path of __pm_genpd_poweron(), we didn't care to try power off
these domain masters. Let's deal with that to avoid leaving unused PM
domains powered.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 2327613..32dcb80 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -235,6 +235,18 @@ static int genpd_power_off(struct generic_pm_domain *genpd)
 }
 
 /**
+ * genpd_queue_power_off_work - Queue up the execution of pm_genpd_poweroff().
+ * @genpd: PM domait to power off.
+ *
+ * Queue up the execution of pm_genpd_poweroff() unless it's already been done
+ * before.
+ */
+static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
+{
+	queue_work(pm_wq, &genpd->power_off_work);
+}
+
+/**
  * __pm_genpd_poweron - Restore power to a given PM domain and its masters.
  * @genpd: PM domain to power up.
  *
@@ -315,8 +327,12 @@ static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
 	return 0;
 
  err:
-	list_for_each_entry_continue_reverse(link, &genpd->slave_links, slave_node)
+	list_for_each_entry_continue_reverse(link,
+					&genpd->slave_links,
+					slave_node) {
 		genpd_sd_counter_dec(link->master);
+		genpd_queue_power_off_work(link->master);
+	}
 
 	return ret;
 }
@@ -490,18 +506,6 @@ static bool genpd_abort_poweroff(struct generic_pm_domain *genpd)
 }
 
 /**
- * genpd_queue_power_off_work - Queue up the execution of pm_genpd_poweroff().
- * @genpd: PM domait to power off.
- *
- * Queue up the execution of pm_genpd_poweroff() unless it's already been done
- * before.
- */
-static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
-{
-	queue_work(pm_wq, &genpd->power_off_work);
-}
-
-/**
  * pm_genpd_poweroff - Remove power from a given PM domain.
  * @genpd: PM domain to power down.
  *
-- 
1.9.1

