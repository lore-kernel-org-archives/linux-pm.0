From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v7 06/13] clk: qcom: gdsc: Add support for Memory RET/OFF
Date: Tue, 28 Jul 2015 15:03:59 +0530
Message-ID: <1438076046-4706-7-git-send-email-rnayak@codeaurora.org>
References: <1438076046-4706-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1438076046-4706-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Along with the GDSC power switch, there is additional control
to either retain all memory (core and peripheral) within a given
powerdomain or to turn them off while the GDSC is powered down.
Add support for these by modelling a RET state where all
memory is retained and an OFF state where all memory gets turned
off.
The controls provided are granular enough to be able to support
various differnt levels of RET states, like a 'shallow RET' with all memory
retained and a 'deep RET' with some memory retained while some others
are lost. The current patch does not support this and considers
just one RET state where all memory is retained. Futher work, if
needed can support multiple different levels of RET state.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/gdsc.c | 33 +++++++++++++++++++++++++++++++++
 drivers/clk/qcom/gdsc.h | 13 +++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index b802ecf..162c0be 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -37,6 +37,9 @@
 #define EN_FEW_WAIT_VAL		(0x8 << 16)
 #define CLK_DIS_WAIT_VAL	(0x2 << 12)
 
+#define RETAIN_MEM		BIT(14)
+#define RETAIN_PERIPH		BIT(13)
+
 #define TIMEOUT_US		100
 
 #define domain_to_gdsc(domain) container_of(domain, struct gdsc, pd)
@@ -84,6 +87,24 @@ static int gdsc_toggle_logic(struct gdsc *sc, bool en)
 	return -ETIMEDOUT;
 }
 
+static inline void gdsc_force_mem_on(struct gdsc *sc)
+{
+	int i;
+	u32 mask = RETAIN_MEM | RETAIN_PERIPH;
+
+	for (i = 0; i < sc->cxc_count; i++)
+		regmap_update_bits(sc->regmap, sc->cxcs[i], mask, mask);
+}
+
+static inline void gdsc_clear_mem_on(struct gdsc *sc)
+{
+	int i;
+	u32 mask = RETAIN_MEM | RETAIN_PERIPH;
+
+	for (i = 0; i < sc->cxc_count; i++)
+		regmap_update_bits(sc->regmap, sc->cxcs[i], mask, 0);
+}
+
 static int gdsc_enable(struct generic_pm_domain *domain)
 {
 	struct gdsc *sc = domain_to_gdsc(domain);
@@ -95,6 +116,10 @@ static int gdsc_enable(struct generic_pm_domain *domain)
 	ret = gdsc_toggle_logic(sc, true);
 	if (ret)
 		return ret;
+
+	if (sc->pwrsts & PWRSTS_OFF)
+		gdsc_force_mem_on(sc);
+
 	/*
 	 * If clocks to this power domain were already on, they will take an
 	 * additional 4 clock cycles to re-enable after the power domain is
@@ -114,6 +139,9 @@ static int gdsc_disable(struct generic_pm_domain *domain)
 
 	ret = gdsc_toggle_logic(sc, false);
 
+	if (sc->pwrsts & PWRSTS_OFF)
+		gdsc_clear_mem_on(sc);
+
 	if (sc->root_clk)
 		clk_disable_unprepare(sc->root_clk);
 
@@ -188,6 +216,11 @@ static int gdsc_init(struct gdsc *sc)
 	if (on < 0)
 		return on;
 
+	if (on || (sc->pwrsts & PWRSTS_RET))
+		gdsc_force_mem_on(sc);
+	else
+		gdsc_clear_mem_on(sc);
+
 	sc->pd.power_off = gdsc_disable;
 	sc->pd.power_on = gdsc_enable;
 	sc->pd.attach_dev = gdsc_attach;
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index cbd95e4..01b2208 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -20,6 +20,13 @@
 struct clk;
 struct regmap;
 
+/* Powerdomain allowable state bitfields */
+#define PWRSTS_OFF		BIT(0)
+#define PWRSTS_RET		BIT(1)
+#define PWRSTS_ON		BIT(2)
+#define PWRSTS_OFF_ON		(PWRSTS_OFF | PWRSTS_ON)
+#define PWRSTS_RET_ON		(PWRSTS_RET | PWRSTS_ON)
+
 /**
  * struct gdsc - Globally Distributed Switch Controller
  * @pd: generic power domain
@@ -27,6 +34,9 @@ struct regmap;
  * @gdscr: gsdc control register
  * @root_con_id: root clock to be enabled
  * @root_clk: clk handle for the root clk
+ * @cxcs: offsets of branch registers to toggle mem/periph bits in
+ * @cxc_count: number of @cxcs
+ * @pwrsts: Possible powerdomain power states
  * @con_ids: List of clocks to be controlled for the gdsc
  */
 struct gdsc {
@@ -35,6 +45,9 @@ struct gdsc {
 	unsigned int			gdscr;
 	char				*root_con_id;
 	struct clk			*root_clk;
+	unsigned int			*cxcs;
+	unsigned int			cxc_count;
+	const u8			pwrsts;
 	const char			*con_ids[];
 };
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
