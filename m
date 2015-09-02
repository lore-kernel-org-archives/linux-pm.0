From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH V2] PM / Domains: Try power off masters in error path of __pm_genpd_poweron()
Date: Wed,  2 Sep 2015 10:16:13 +0200
Message-ID: <1441181773-21733-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:34215 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbbIBIQW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2015 04:16:22 -0400
Received: by lbbmp1 with SMTP id mp1so1549493lbb.1
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2015 01:16:20 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

While powering up a genpd, its domain masters are first being powered up.
In the error path of __pm_genpd_poweron(), we didn't care to try power off
these domain masters. Let's deal with that to avoid leaving unused PM
domains powered.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---

Changes in v2:
	Added Krzysztof's reviewed by tag.

---
 drivers/base/power/domain.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 4167201..62f7572 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -213,6 +213,18 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool timed)
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
@@ -259,8 +271,12 @@ static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
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
@@ -349,18 +365,6 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
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

