From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v6 07/13] clk: qcom: gdsc: Add support for ON only state
Date: Wed, 22 Jul 2015 12:41:03 +0530
Message-ID: <1437549069-29655-8-git-send-email-rnayak@codeaurora.org>
References: <1437549069-29655-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60383 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755889AbbGVHL4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jul 2015 03:11:56 -0400
In-Reply-To: <1437549069-29655-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>

Certain devices can have GDSCs' which support ON as the only state.
They can't be power collapsed to either hit RET or OFF.
The clients drivers for these GDSCs' however would expect the state
of the core to be reset following a GDSC disable and re-enable.
To do this assert/deassert reset lines every time the client
driver would request the GDSC to be powered on/off instead.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/common.c |  3 ++-
 drivers/clk/qcom/gdsc.c   | 33 ++++++++++++++++++++++++++++++++-
 drivers/clk/qcom/gdsc.h   | 11 ++++++++++-
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 2776679..72d15e6 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -124,7 +124,8 @@ int qcom_cc_really_probe(struct platform_device *pdev,
 		goto err_reset;
 
 	if (desc->gdscs && desc->num_gdscs) {
-		ret = gdsc_register(dev, desc->gdscs, desc->num_gdscs, regmap);
+		ret = gdsc_register(dev, desc->gdscs, desc->num_gdscs,
+				    &reset->rcdev, regmap);
 		if (ret)
 			goto err_pd;
 	}
diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 5cc2d63..52c16e3 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -82,6 +82,24 @@ static int gdsc_toggle_logic(struct gdsc *sc, bool en)
 	return -ETIMEDOUT;
 }
 
+static inline int gdsc_deassert_reset(struct gdsc *sc)
+{
+	int i;
+
+	for (i = 0; i < sc->reset_count; i++)
+		sc->rcdev->ops->deassert(sc->rcdev, sc->resets[i]);
+	return 0;
+}
+
+static inline int gdsc_assert_reset(struct gdsc *sc)
+{
+	int i;
+
+	for (i = 0; i < sc->reset_count; i++)
+		sc->rcdev->ops->assert(sc->rcdev, sc->resets[i]);
+	return 0;
+}
+
 static inline void gdsc_force_mem_on(struct gdsc *sc)
 {
 	int i;
@@ -105,6 +123,9 @@ static int gdsc_enable(struct generic_pm_domain *domain)
 	struct gdsc *sc = domain_to_gdsc(domain);
 	int ret;
 
+	if (sc->pwrsts == PWRSTS_ON)
+		return gdsc_deassert_reset(sc);
+
 	if (sc->root_clk)
 		clk_prepare_enable(sc->root_clk);
 
@@ -132,6 +153,9 @@ static int gdsc_disable(struct generic_pm_domain *domain)
 	int ret;
 	struct gdsc *sc = domain_to_gdsc(domain);
 
+	if (sc->pwrsts == PWRSTS_ON)
+		return gdsc_assert_reset(sc);
+
 	ret = gdsc_toggle_logic(sc, false);
 
 	if (sc->pwrsts & PWRSTS_OFF)
@@ -200,6 +224,12 @@ static int gdsc_init(struct gdsc *sc)
 	if (ret)
 		return ret;
 
+	/* Force gdsc ON if only ON state is supported */
+	if (sc->pwrsts == PWRSTS_ON)
+		ret = gdsc_toggle_logic(sc, true);
+		if (ret)
+			return ret;
+
 	on = gdsc_is_enabled(sc);
 	if (on < 0)
 		return on;
@@ -220,7 +250,7 @@ static int gdsc_init(struct gdsc *sc)
 }
 
 int gdsc_register(struct device *dev, struct gdsc **scs, size_t num,
-		  struct regmap *regmap)
+		  struct reset_controller_dev *rcdev, struct regmap *regmap)
 {
 	int i, ret;
 	struct genpd_onecell_data *data;
@@ -239,6 +269,7 @@ int gdsc_register(struct device *dev, struct gdsc **scs, size_t num,
 		if (!scs[i])
 			continue;
 		scs[i]->regmap = regmap;
+		scs[i]->rcdev = rcdev;
 		ret = gdsc_init(scs[i]);
 		if (ret)
 			return ret;
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index 87c4ace..0d1c4fb 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -17,6 +17,7 @@
 #include <linux/clk.h>
 #include <linux/pm_domain.h>
 #include <linux/regmap.h>
+#include <linux/reset-controller.h>
 
 /* Powerdomain allowable state bitfields */
 #define PWRSTS_OFF		BIT(0)
@@ -34,6 +35,9 @@
  * @root_clk: clk handle for the root clk
  * @cxcs: offsets of branch registers to toggle mem/periph bits in
  * @cxc_count: number of @cxcs
+ * @resets: ids of resets associated with this gdsc
+ * @reset_count: number of @resets
+ * @rcdev: reset controller
  * @pwrsts: Possible powerdomain power states
  */
 struct gdsc {
@@ -44,14 +48,19 @@ struct gdsc {
 	struct clk			*root_clk;
 	unsigned int			*cxcs;
 	unsigned int			cxc_count;
+	struct reset_controller_dev	*rcdev;
+	unsigned int			*resets;
+	unsigned int			reset_count;
 	const u8			pwrsts;
 };
 
 #ifdef CONFIG_QCOM_GDSC
-int gdsc_register(struct device *, struct gdsc **, size_t n, struct regmap *);
+int gdsc_register(struct device *, struct gdsc **, size_t n,
+		  struct reset_controller_dev *, struct regmap *);
 void gdsc_unregister(struct device *);
 #else
 static inline int gdsc_register(struct device *d, struct gdsc **g, size_t n,
+				struct reset_controller_dev *rcdev,
 				struct regmap *r)
 {
 	return -ENOSYS;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

