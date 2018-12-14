From: Nick Fan <Nick.Fan@mediatek.com>
Subject: [RFC PATCH] [RESEND] opp: Add API for getting voltage from supplies
Date: Fri, 14 Dec 2018 17:17:42 +0800
Message-ID: <1544779062-8276-1-git-send-email-Nick.Fan@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <vireshk@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, tfiga@chromium.org, Chiawen.Lee@mediatek.com, erin.lo@mediatek.com, Nick Fan <Nick.Fan@mediatek.com>
List-Id: linux-pm@vger.kernel.org

[Resending because the previous attempt did not reach the mailing lists.]

This new API is needed for a downstream GPU driver, but posting it as an RFC to make sure that we implement it in a potentially upstreamable way or in case someone needs it for an upstream user later.

Add API to get voltage for multiple supplies from opp table

Signed-off-by: Nick Fan <Nick.Fan@mediatek.com>
---
 drivers/opp/core.c     | 28 ++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  3 +++
 2 files changed, 31 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 2c2df4e..ee73546 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -113,6 +113,34 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_voltage);
 
 /**
+ * dev_pm_opp_get_voltage_supply() - Gets the voltage corresponding to an opp
+ * with index
+ * @opp:        opp for which voltage has to be returned for
+ * @index:      index to specify the returned supplies
+ *
+ * Return: voltage in micro volt corresponding to the opp with index, else
+ * return 0
+ *
+ * This is useful for devices with multiple power supplies.
+ */
+unsigned long dev_pm_opp_get_voltage_supply(struct dev_pm_opp *opp,
+					    unsigned int index)
+{
+	if (IS_ERR_OR_NULL(opp)) {
+		pr_err("%s: Invalid parameters\n", __func__);
+		return 0;
+	}
+
+	if (index >= opp->opp_table->regulator_count) {
+		pr_err("%s: Invalid supply index: %u\n", __func__, index);
+		return 0;
+	}
+
+	return opp->supplies[index].u_volt;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_voltage_supply);
+
+/**
  * dev_pm_opp_get_freq() - Gets the frequency corresponding to an available opp
  * @opp:	opp for which frequency has to be returned for
  *
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 5d399eee..2f1c2a8 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -84,6 +84,9 @@ struct dev_pm_set_opp_data {
 
 unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
 
+unsigned long dev_pm_opp_get_voltage_supply(struct dev_pm_opp *opp,
+					    unsigned int index);
+
 unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
 
 bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp);
-- 
1.9.1
