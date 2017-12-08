From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v4 10/12] clk: qcom: Add safe switch hook for krait mux clocks
Date: Fri,  8 Dec 2017 15:12:28 +0530
Message-ID: <1512726150-7204-11-git-send-email-sricharan@codeaurora.org>
References: <1512726150-7204-1-git-send-email-sricharan@codeaurora.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1512726150-7204-1-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

When the Hfplls are reprogrammed during the rate change,
the primary muxes which are sourced from the same hfpll
for higher frequencies, needs to be switched to the 'safe
secondary mux' as the parent for that small window. This
is done by registering a clk notifier for the muxes and
switching to the safe parent in the PRE_RATE_CHANGE notifier
and back to the original parent in the POST_RATE_CHANGE notifier.

Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/clk/qcom/clk-krait.c |  2 ++
 drivers/clk/qcom/clk-krait.h |  3 +++
 drivers/clk/qcom/krait-cc.c  | 56 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/drivers/clk/qcom/clk-krait.c b/drivers/clk/qcom/clk-krait.c
index 6099307..1627a6e 100644
--- a/drivers/clk/qcom/clk-krait.c
+++ b/drivers/clk/qcom/clk-krait.c
@@ -60,6 +60,8 @@ static int krait_mux_set_parent(struct clk_hw *hw, u8 index)
 	if (__clk_is_enabled(hw->clk))
 		__krait_mux_set_sel(mux, sel);
 
+	mux->reparent = true;
+
 	return 0;
 }
 
diff --git a/drivers/clk/qcom/clk-krait.h b/drivers/clk/qcom/clk-krait.h
index af89782..f9e1279 100644
--- a/drivers/clk/qcom/clk-krait.h
+++ b/drivers/clk/qcom/clk-krait.h
@@ -23,6 +23,9 @@ struct krait_mux_clk {
 	u32		shift;
 	u32		en_mask;
 	bool		lpl;
+	u8		safe_sel;
+	u8		old_index;
+	bool		reparent;
 
 	struct clk_hw	hw;
 	struct notifier_block   clk_nb;
diff --git a/drivers/clk/qcom/krait-cc.c b/drivers/clk/qcom/krait-cc.c
index f5ffb1a..ec899ad 100644
--- a/drivers/clk/qcom/krait-cc.c
+++ b/drivers/clk/qcom/krait-cc.c
@@ -35,6 +35,49 @@
 	0,
 };
 
+/*
+ * Notifier function for switching the muxes to safe parent
+ * while the hfpll is getting reprogrammed.
+ */
+static int krait_notifier_cb(struct notifier_block *nb,
+			     unsigned long event,
+			     void *data)
+{
+	int ret = 0;
+	struct krait_mux_clk *mux = container_of(nb, struct krait_mux_clk,
+						 clk_nb);
+	/* Switch to safe parent */
+	if (event == PRE_RATE_CHANGE) {
+		mux->old_index = krait_mux_clk_ops.get_parent(&mux->hw);
+		ret = krait_mux_clk_ops.set_parent(&mux->hw, mux->safe_sel);
+		mux->reparent = false;
+	/*
+	 * By the time POST_RATE_CHANGE notifier is called,
+	 * clk framework itself would have changed the parent for the new rate.
+	 * Only otherwise, put back to the old parent.
+	 */
+	} else if (event == POST_RATE_CHANGE) {
+		if (!mux->reparent)
+			ret = krait_mux_clk_ops.set_parent(&mux->hw,
+							   mux->old_index);
+	}
+
+	return notifier_from_errno(ret);
+}
+
+static int krait_notifier_register(struct device *dev, struct clk *clk,
+				   struct krait_mux_clk *mux)
+{
+	int ret = 0;
+
+	mux->clk_nb.notifier_call = krait_notifier_cb;
+	ret = clk_notifier_register(clk, &mux->clk_nb);
+	if (ret)
+		dev_err(dev, "failed to register clock notifier: %d\n", ret);
+
+	return ret;
+}
+
 static int
 krait_add_div(struct device *dev, int id, const char *s, unsigned int offset)
 {
@@ -79,6 +122,7 @@
 krait_add_sec_mux(struct device *dev, int id, const char *s,
 		  unsigned int offset, bool unique_aux)
 {
+	int ret;
 	struct krait_mux_clk *mux;
 	static const char *sec_mux_list[] = {
 		"acpu_aux",
@@ -102,6 +146,7 @@
 	mux->shift = 2;
 	mux->parent_map = sec_mux_map;
 	mux->hw.init = &init;
+	mux->safe_sel = 0;
 
 	init.name = kasprintf(GFP_KERNEL, "krait%s_sec_mux", s);
 	if (!init.name)
@@ -117,6 +162,11 @@
 
 	clk = devm_clk_register(dev, &mux->hw);
 
+	ret = krait_notifier_register(dev, clk, mux);
+	if (ret)
+		goto unique_aux;
+
+unique_aux:
 	if (unique_aux)
 		kfree(sec_mux_list[0]);
 err_aux:
@@ -128,6 +178,7 @@
 krait_add_pri_mux(struct device *dev, int id, const char *s,
 		  unsigned int offset)
 {
+	int ret;
 	struct krait_mux_clk *mux;
 	const char *p_names[3];
 	struct clk_init_data init = {
@@ -148,6 +199,7 @@
 	mux->lpl = id >= 0;
 	mux->parent_map = pri_mux_map;
 	mux->hw.init = &init;
+	mux->safe_sel = 2;
 
 	init.name = kasprintf(GFP_KERNEL, "krait%s_pri_mux", s);
 	if (!init.name)
@@ -173,6 +225,10 @@
 
 	clk = devm_clk_register(dev, &mux->hw);
 
+	ret = krait_notifier_register(dev, clk, mux);
+	if (ret)
+		goto err_p3;
+err_p3:
 	kfree(p_names[2]);
 err_p2:
 	kfree(p_names[1]);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
