From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 1/6] cpufreq / OPP: allow allocation of extra table entries in
 freq_table
Date: Fri, 10 Apr 2015 19:58:57 +0200
Message-ID: <1428688742-15578-2-git-send-email-b.zolnierkie@samsung.com>
References: <1428688742-15578-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:14116 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbbDJR7m (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Apr 2015 13:59:42 -0400
In-reply-to: <1428688742-15578-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com

Prefix dev_pm_opp_init_cpufreq_table() with "__" and add a wrapper
for it to keep current users unchanged.  Then add an extra_opps
parameter to __dev_pm_opp_init_cpufreq_table() to allow allocation of
extra table entries in freq_table.

This patch is a preparation for adding 'boost' mode frequencies
support to cpufreq-dt driver.

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/cpufreq/cpufreq_opp.c |   18 ++++++++++++++----
 include/linux/cpufreq.h       |    3 +++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_opp.c b/drivers/cpufreq/cpufreq_opp.c
index 773bcde..773164b 100644
--- a/drivers/cpufreq/cpufreq_opp.c
+++ b/drivers/cpufreq/cpufreq_opp.c
@@ -21,9 +21,10 @@
 #include <linux/slab.h>
 
 /**
- * dev_pm_opp_init_cpufreq_table() - create a cpufreq table for a device
+ * __dev_pm_opp_init_cpufreq_table() - create a cpufreq table for a device
  * @dev:	device for which we do this operation
  * @table:	Cpufreq table returned back to caller
+ * @extra_opps:	Number of extra table entries to allocate
  *
  * Generate a cpufreq table for a provided device- this assumes that the
  * opp list is already initialized and ready for usage.
@@ -44,8 +45,9 @@
  * structures, we use RCU read lock inside this function. As a result, users of
  * this function DONOT need to use explicit locks for invoking.
  */
-int dev_pm_opp_init_cpufreq_table(struct device *dev,
-				  struct cpufreq_frequency_table **table)
+int __dev_pm_opp_init_cpufreq_table(struct device *dev,
+				    struct cpufreq_frequency_table **table,
+				    unsigned int extra_opps)
 {
 	struct dev_pm_opp *opp;
 	struct cpufreq_frequency_table *freq_table = NULL;
@@ -60,7 +62,8 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
 		goto out;
 	}
 
-	freq_table = kcalloc((max_opps + 1), sizeof(*freq_table), GFP_ATOMIC);
+	freq_table = kcalloc((max_opps + extra_opps + 1), sizeof(*freq_table),
+			     GFP_ATOMIC);
 	if (!freq_table) {
 		ret = -ENOMEM;
 		goto out;
@@ -89,6 +92,13 @@ out:
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(__dev_pm_opp_init_cpufreq_table);
+
+int dev_pm_opp_init_cpufreq_table(struct device *dev,
+				  struct cpufreq_frequency_table **table)
+{
+	return __dev_pm_opp_init_cpufreq_table(dev, table, 0);
+}
 EXPORT_SYMBOL_GPL(dev_pm_opp_init_cpufreq_table);
 
 /**
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 2ee4888..e46feed 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -505,6 +505,9 @@ struct cpufreq_frequency_table {
 };
 
 #if defined(CONFIG_CPU_FREQ) && defined(CONFIG_PM_OPP)
+int __dev_pm_opp_init_cpufreq_table(struct device *dev,
+				    struct cpufreq_frequency_table **table,
+				    unsigned int extra_opps);
 int dev_pm_opp_init_cpufreq_table(struct device *dev,
 				  struct cpufreq_frequency_table **table);
 void dev_pm_opp_free_cpufreq_table(struct device *dev,
-- 
1.7.9.5

