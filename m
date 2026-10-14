Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE20B4E73CC;
	Wed, 14 Oct 2026 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980519; cv=none; b=sCdGc/S+TgweTVMhHVBITDQqHgluDVHj0g5DXI2hhYs5LPaKiKbm8WC416gpdTDmYo2ZpNLHtdpSTdEwVrn7uUlR5O/S6yLFpvFSTaP4F7yVNg2tgekjZzZ2Xec8Kvb8Zg7wed+/FeoYP8Le9CilliDeDqqmxgzKcpeOch5BouQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980519; c=relaxed/simple;
	bh=8OMna/KLGjI0egQ5mOc3EaWbW4KBirffU+LVFR73S80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D77wZDiNyIVnDtbJxOCX4Jq37ynHjTe97A/EhsE2FlSqAUHT68G10wtCIEXnWyMAHyko0h14OIxR0K3WCtjcY7spPJh/lSrZ/Tul5Lq1sHouA72YTUkM3B4bqxE9Vx903c7KCLLAHwNICLISObi4ZWuxTKudTSFHOWs/W4IFUQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+0Ce3v4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+0Ce3v4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267D51F000FF;
	Wed, 14 Oct 2026 12:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791980517;
	bh=5V+2zRLYtk8mULwaRk7ZQHnulu8saTddbqYC1vASJiM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Y+0Ce3v4Zangc/YI2crn5kMk0QjEaaj5/3K5fKH4uE6WwSQthu7YDTKD1Usu6guwQ
	 zAZyyuBznifOyGt0ElEkXJkkUoU157TgylP8d4D62B0tYmq6SHFQ2kprc6MgA8mKN1
	 YEZFI7s118p3U0ftTcjAteVW8MP8u5s0PKf8ay/JZnf+yj8plRm9+GcYjMVr7U9AvS
	 Id1NMJ5K0tXCI3xWi8Hg0sfU5zn05DBq1+hi1Po5tN6WQKbODzxvecHVTuGhwSYF2l
	 MF2Tf0RtUn3BeqfEu2kvGN5zj7973jiPeOWSECrqyFh/FCoaPrY1f6RxW9vqe1WZIc
	 lBSFITeO7FNWA==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 14 Oct 2026 14:19:10 +0200
Subject: [PATCH RFC 10/16] clk: qcom: clk-alpha-pll: Vote for the PLL
 calibration frequency
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-topic-qc_clk_dvfs-v1-10-3041b788e9f7@oss.qualcomm.com>
References: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
In-Reply-To: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mike Tipton <mike.tipton@oss.qualcomm.com>, 
 Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791980431; l=8367;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=Ay0Zbi2cn4ekfRWSw8xzw+DH5Ff5Kj4IvCP4O2lqwk4=;
 b=IB+IYD8Mc4N8Btuo2b62IxdIWehE5yhkJpYmwO28vFcDl+kGSMUbs92QoaeUTJDDHEzujtIcE
 bbnweKMsX9UA+g0gz61fJRaJbFsHPRbRAciuTTkXCfLd5v9jUS1WsqM
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Lucid EVO class PLLs calibrate themselves the first time they are
prepared, running at (CAL_L * parent_rate) Hz. That is typically well
above the rate the PLL is later operated at, but the prepared vote only
covers the operating rate, so calibration can run without the rail
requirement for the frequency it actually uses.

Raise the vote to cover the calibration frequency while a PLL that still
needs calibration is brought up, and return to the operating rate once it
is done. Failing to drop the vote again leaves the higher one in place
until unprepare and is only reported.

Assisted-by: LLM
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/clk/qcom/clk-alpha-pll.c | 113 +++++++++++++++++++++++++++++----------
 drivers/clk/qcom/clk-dvfs.c      |   8 ++-
 drivers/clk/qcom/clk-dvfs.h      |   1 +
 3 files changed, 91 insertions(+), 31 deletions(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 5dc6b1adc929..f6e73e2fbe76 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2021, 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include <linux/bitfield.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/clk-provider.h>
@@ -369,6 +370,7 @@ EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
 #define LUCID_EVO_ENABLE_VOTE_RUN       BIT(25)
 #define LUCID_EVO_PLL_L_VAL_MASK        GENMASK(15, 0)
 #define LUCID_EVO_PLL_CAL_L_VAL_SHIFT	16
+#define LUCID_EVO_PLL_CAL_L_VAL_MASK	GENMASK(23, 16)
 #define LUCID_OLE_PLL_RINGOSC_CAL_L_VAL_SHIFT	24
 
 /* PONGO ELU PLL specific setting and offsets */
@@ -2577,7 +2579,7 @@ static int alpha_pll_lucid_evo_enable(struct clk_hw *hw)
 	return ret;
 }
 
-static void _alpha_pll_lucid_evo_disable(struct clk_hw *hw, bool reset)
+static int alpha_pll_lucid_evo_disable_checked(struct clk_hw *hw, bool reset)
 {
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
 	struct regmap *regmap = pll->clkr.regmap;
@@ -2586,29 +2588,45 @@ static void _alpha_pll_lucid_evo_disable(struct clk_hw *hw, bool reset)
 
 	ret = regmap_read(regmap, PLL_USER_CTL(pll), &val);
 	if (ret)
-		return;
+		return ret;
 
 	/* If in FSM mode, just unvote it */
 	if (val & LUCID_EVO_ENABLE_VOTE_RUN) {
-		clk_disable_regmap(hw);
-		return;
+		return regmap_update_bits(regmap, pll->clkr.enable_reg,
+					  pll->clkr.enable_mask,
+					  pll->clkr.enable_is_inverted ?
+					  pll->clkr.enable_mask : 0);
 	}
 
 	/* Disable the global PLL output */
 	ret = regmap_update_bits(regmap, PLL_MODE(pll), PLL_OUTCTRL, 0);
 	if (ret)
-		return;
+		return ret;
 
 	/* Disable the PLL outputs */
 	ret = regmap_update_bits(regmap, PLL_USER_CTL(pll), PLL_OUT_MASK, 0);
 	if (ret)
-		return;
+		return ret;
 
 	/* Place the PLL mode in STANDBY */
-	regmap_write(regmap, PLL_OPMODE(pll), PLL_STANDBY);
+	ret = regmap_write(regmap, PLL_OPMODE(pll), PLL_STANDBY);
+	if (ret)
+		return ret;
 
 	if (reset)
-		regmap_update_bits(regmap, PLL_MODE(pll), PLL_RESET_N, 0);
+		return regmap_update_bits(regmap, PLL_MODE(pll), PLL_RESET_N, 0);
+
+	return 0;
+}
+
+static void _alpha_pll_lucid_evo_disable(struct clk_hw *hw, bool reset)
+{
+	int ret;
+
+	ret = alpha_pll_lucid_evo_disable_checked(hw, reset);
+	if (ret)
+		pr_warn("%s: failed to disable PLL: %d\n",
+			clk_hw_get_name(hw), ret);
 }
 
 static int _alpha_pll_lucid_evo_prepare(struct clk_hw *hw, bool reset)
@@ -2616,10 +2634,12 @@ static int _alpha_pll_lucid_evo_prepare(struct clk_hw *hw, bool reset)
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
 	struct clk_hw *p;
 	u32 val = 0;
-	int ret;
+	int ret, cleanup_ret;
 
 	/* Return early if calibration is not needed. */
-	regmap_read(pll->clkr.regmap, PLL_MODE(pll), &val);
+	ret = regmap_read(pll->clkr.regmap, PLL_MODE(pll), &val);
+	if (ret)
+		return ret;
 	if (!(val & LUCID_EVO_PCAL_NOT_DONE))
 		return 0;
 
@@ -2628,12 +2648,9 @@ static int _alpha_pll_lucid_evo_prepare(struct clk_hw *hw, bool reset)
 		return -EINVAL;
 
 	ret = alpha_pll_lucid_evo_enable(hw);
-	if (ret)
-		return ret;
+	cleanup_ret = alpha_pll_lucid_evo_disable_checked(hw, reset);
 
-	_alpha_pll_lucid_evo_disable(hw, reset);
-
-	return 0;
+	return ret ?: cleanup_ret;
 }
 
 static void alpha_pll_lucid_evo_disable(struct clk_hw *hw)
@@ -2641,21 +2658,69 @@ static void alpha_pll_lucid_evo_disable(struct clk_hw *hw)
 	_alpha_pll_lucid_evo_disable(hw, false);
 }
 
-static int alpha_pll_lucid_evo_prepare(struct clk_hw *hw)
+/*
+ * Calibration runs at CAL_L * parent_rate, which may exceed the operating rate
+ * covered by the normal DVFS vote. Raise the vote temporarily to keep the
+ * hardware in-spec during that step.
+ */
+static int alpha_pll_lucid_evo_dvfs_prepare(struct clk_hw *hw, bool reset)
 {
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	unsigned long rate = clk_hw_get_rate(hw);
+	unsigned long cal_rate = 0;
+	struct clk_hw *p;
+	u32 val;
 	int ret;
 
 	ret = qcom_clk_dvfs_prepare(hw);
 	if (ret)
 		return ret;
 
-	ret = _alpha_pll_lucid_evo_prepare(hw, false);
+	ret = regmap_read(pll->clkr.regmap, PLL_MODE(pll), &val);
 	if (ret)
-		qcom_clk_dvfs_unprepare(hw);
+		goto err_unprepare;
 
+	if (val & LUCID_EVO_PCAL_NOT_DONE) {
+		p = clk_hw_get_parent(hw);
+		if (!p) {
+			ret = -EINVAL;
+			goto err_unprepare;
+		}
+
+		ret = regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &val);
+		if (ret)
+			goto err_unprepare;
+
+		cal_rate = (unsigned long)FIELD_GET(LUCID_EVO_PLL_CAL_L_VAL_MASK, val) *
+			   clk_hw_get_rate(p);
+	}
+
+	if (cal_rate > rate) {
+		ret = qcom_clk_dvfs_prepare_rate(hw, cal_rate);
+		if (ret)
+			goto err_unprepare;
+	}
+
+	ret = _alpha_pll_lucid_evo_prepare(hw, reset);
+	if (ret)
+		goto err_unprepare;
+
+	if (cal_rate > rate && qcom_clk_dvfs_prepare_rate(hw, rate))
+		pr_warn("%s: failed to drop calibration DVFS vote\n",
+			clk_hw_get_name(hw));
+
+	return 0;
+
+err_unprepare:
+	qcom_clk_dvfs_unprepare(hw);
 	return ret;
 }
 
+static int alpha_pll_lucid_evo_prepare(struct clk_hw *hw)
+{
+	return alpha_pll_lucid_evo_dvfs_prepare(hw, false);
+}
+
 static void alpha_pll_reset_lucid_evo_disable(struct clk_hw *hw)
 {
 	_alpha_pll_lucid_evo_disable(hw, true);
@@ -2663,17 +2728,7 @@ static void alpha_pll_reset_lucid_evo_disable(struct clk_hw *hw)
 
 static int alpha_pll_reset_lucid_evo_prepare(struct clk_hw *hw)
 {
-	int ret;
-
-	ret = qcom_clk_dvfs_prepare(hw);
-	if (ret)
-		return ret;
-
-	ret = _alpha_pll_lucid_evo_prepare(hw, true);
-	if (ret)
-		qcom_clk_dvfs_unprepare(hw);
-
-	return ret;
+	return alpha_pll_lucid_evo_dvfs_prepare(hw, true);
 }
 
 static unsigned long alpha_pll_lucid_evo_recalc_rate(struct clk_hw *hw,
diff --git a/drivers/clk/qcom/clk-dvfs.c b/drivers/clk/qcom/clk-dvfs.c
index 4af78eb0c78d..145ad57a48e4 100644
--- a/drivers/clk/qcom/clk-dvfs.c
+++ b/drivers/clk/qcom/clk-dvfs.c
@@ -244,10 +244,9 @@ static int qcom_clk_dvfs_remove_vote(struct qcom_clk_dvfs_rail_voter *rail_voter
 	return ret;
 }
 
-int qcom_clk_dvfs_prepare(struct clk_hw *hw)
+int qcom_clk_dvfs_prepare_rate(struct clk_hw *hw, unsigned long rate)
 {
 	struct qcom_clk_dvfs_clock *clock = to_clk_regmap(hw)->dvfs;
-	unsigned long rate = clk_hw_get_rate(hw);
 	unsigned int level;
 	size_t i;
 	int ret;
@@ -281,6 +280,11 @@ int qcom_clk_dvfs_prepare(struct clk_hw *hw)
 	return ret;
 }
 
+int qcom_clk_dvfs_prepare(struct clk_hw *hw)
+{
+	return qcom_clk_dvfs_prepare_rate(hw, clk_hw_get_rate(hw));
+}
+
 void qcom_clk_dvfs_unprepare(struct clk_hw *hw)
 {
 	struct qcom_clk_dvfs_clock *clock = to_clk_regmap(hw)->dvfs;
diff --git a/drivers/clk/qcom/clk-dvfs.h b/drivers/clk/qcom/clk-dvfs.h
index 48c7487614c1..bb8edd466818 100644
--- a/drivers/clk/qcom/clk-dvfs.h
+++ b/drivers/clk/qcom/clk-dvfs.h
@@ -28,6 +28,7 @@ int qcom_clk_dvfs_resource_release(struct clk_hw *hw,
 				 void *cookie,
 				 enum clk_resource_change_result result);
 int qcom_clk_dvfs_prepare(struct clk_hw *hw);
+int qcom_clk_dvfs_prepare_rate(struct clk_hw *hw, unsigned long rate);
 void qcom_clk_dvfs_unprepare(struct clk_hw *hw);
 
 int qcom_clk_dvfs_register(struct device *dev,

-- 
2.56.0

