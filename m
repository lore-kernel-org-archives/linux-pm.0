From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v8 12/13] clk: qcom: gdsc: Enable an RCG before turing on the gdsc
Date: Thu,  6 Aug 2015 16:07:53 +0530
Message-ID: <1438857474-20262-13-git-send-email-rnayak@codeaurora.org>
References: <1438857474-20262-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1438857474-20262-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Some gdsc instances require a certain root clock (RCG) to be turned on
*before* the power domain itself can be turned on. Handle this as part
of the gdsc enable/disable callbacks.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/gcc-msm8916.c |  1 +
 drivers/clk/qcom/gdsc.c        | 14 ++++++++++++--
 drivers/clk/qcom/gdsc.h        |  4 ++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-msm8916.c b/drivers/clk/qcom/gcc-msm8916.c
index 10ba745..bb34345 100644
--- a/drivers/clk/qcom/gcc-msm8916.c
+++ b/drivers/clk/qcom/gcc-msm8916.c
@@ -2601,6 +2601,7 @@ static struct gdsc oxili_gdsc = {
 		.name = "oxili",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.root_clock = GFX3D_CLK_SRC,
 };
 
 static struct clk_regmap *gcc_msm8916_clocks[] = {
diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index ec1dfb5..20965fc 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -131,6 +131,9 @@ static int gdsc_enable(struct generic_pm_domain *domain)
 	if (sc->pwrsts == PWRSTS_ON)
 		return gdsc_deassert_reset(sc);
 
+	if (sc->root_clk)
+		clk_prepare_enable(sc->root_clk);
+
 	ret = gdsc_toggle_logic(sc, true);
 	if (ret)
 		return ret;
@@ -152,6 +155,7 @@ static int gdsc_enable(struct generic_pm_domain *domain)
 
 static int gdsc_disable(struct generic_pm_domain *domain)
 {
+	int ret;
 	struct gdsc *sc = domain_to_gdsc(domain);
 
 	if (sc->pwrsts == PWRSTS_ON)
@@ -160,7 +164,12 @@ static int gdsc_disable(struct generic_pm_domain *domain)
 	if (sc->pwrsts & PWRSTS_OFF)
 		gdsc_clear_mem_on(sc);
 
-	return gdsc_toggle_logic(sc, false);
+	ret = gdsc_toggle_logic(sc, false);
+
+	if (sc->root_clk)
+		clk_disable_unprepare(sc->root_clk);
+
+	return ret;
 }
 
 static inline bool match(unsigned int id, unsigned int *ids, unsigned int count)
@@ -200,7 +209,8 @@ static int gdsc_attach(struct generic_pm_domain *domain, struct device *dev)
 			sc->clks[j] = of_clk_get_from_provider(&clkspec);
 			pm_clk_add_clk(dev, sc->clks[j]);
 			j++;
-		}
+		} else if (clkspec.args[0] == sc->root_clock)
+			sc->root_clk = of_clk_get_from_provider(&clkspec);
 		i++;
 	}
 	return 0;
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index 2fdb332..0b958a6 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -42,6 +42,8 @@ struct reset_controller_dev;
  * @clocks: ids of clocks associated with the gdsc
  * @clock_count: number of @clocks
  * @clks: clock pointers to gdsc clocks
+ * @root_clock: id of the root clock to be enabled
+ * @root_clk: root clk pointer
  */
 struct gdsc {
 	struct generic_pm_domain	pd;
@@ -56,6 +58,8 @@ struct gdsc {
 	unsigned int			*clocks;
 	unsigned int			clock_count;
 	struct clk			**clks;
+	unsigned int			root_clock;
+	struct clk			*root_clk;
 };
 
 #ifdef CONFIG_QCOM_GDSC
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
