Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DEB4E77FD;
	Wed, 14 Oct 2026 12:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980513; cv=none; b=MvjPJKPuH04Yw5AGLkU55rE7Z+BG5WP4XRDcPeSf9I/IA7E/ffSlhbUohc0b4fSlgxOdvDXjrzMXv/3t6MlxzMuvep3O/RMe0K/uIjJ/KukRALG5oUM0N/AN95vJOEkAqO9pQRLwWNAwdKJxcM2DDxqjhqjiWmw1UMpnOlUW3+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980513; c=relaxed/simple;
	bh=UcUjq/8ToXUIwQ5/SLR1xiXAzCmtVVGEiZ+SwFlCDac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N3LWi3XOvneSgOvQM1lO1hm+f1JQ6scheytcpz4Sl3ZQueOSSF3J/lrVm5uq79qSyJwfY0GoIMH0dcsb58JEpYJZhpHK+pgDvenDNKzEl4/ofoywDeXYCnBoOEiStiJcM+nHtRZuD+OdGofPcai3jIXnN+4UHtCDRBhUQ5SO1Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRWnlcXC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRWnlcXC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200C11F00893;
	Wed, 14 Oct 2026 12:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791980510;
	bh=7TcByaLz7UEr/AVpjt8s6DymuSjCt4p9P7xeqTR3vUU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RRWnlcXCVJMCBc4vp9nF85GWSErIGZwSJmc4mUvBWKy2DRr9pjLzImA4hewcew6/6
	 7IvvXXD4NUBJ2vPx/I96Tr5+2+XwbLpcatq2a/9b+CUuNNDx9BoxfGcos188QoSgFq
	 tXymt2DZdhLCqryANVSXz1b390SLwlARmIMYjkTOsDV4eMp1oMguF/IJBqfmI98972
	 48pwRxT8o2GOWqr+0CYPtVA/bTnBwe9NmPv3HY3W9k+8VeRomL0G/6F4P8gE6GLZi5
	 D8j7m+wezuxY0LbojCd8+zXYrN4np4hSfi0yCI/ARXX2Ec20TNss/rUEyIJ14CWl1A
	 oTR+WnpaUgalQ==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 14 Oct 2026 14:19:09 +0200
Subject: [PATCH RFC 09/16] clk: qcom: clk-alpha-pll: Add DVFS (un)prepare
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-topic-qc_clk_dvfs-v1-9-3041b788e9f7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791980431; l=19734;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=2WMR+BY0Z3R0+QxO89Uea2UrN3CMd8aAypkb+tIP2LQ=;
 b=qABmNTBZdPDox5TFemtCUq/KbWnNkh4B6RaizY2n4V2uZJToU9zlm7QOsqERZ1MYBQCtMy0f+
 TmQjLuGJLn2DHkCCSN1DOL76C89385WUbsfEMCH6bTmXe/T6HmXVpiF
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Alpha PLLs have strict power requirements for a given frequency.
Ensure they can be accounted for with the new clk-dvfs (un)prepare
operations.

Assisted-by: LLM
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/clk/qcom/clk-alpha-pll.c | 232 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 223 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 60173b076cc5..5dc6b1adc929 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -11,6 +11,7 @@
 #include <linux/delay.h>
 
 #include "clk-alpha-pll.h"
+#include "clk-dvfs.h"
 #include "common.h"
 
 #define PLL_MODE(p)		((p)->offset + 0x0)
@@ -1182,6 +1183,10 @@ clk_trion_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 }
 
 const struct clk_ops clk_alpha_pll_fixed_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.enable = clk_alpha_pll_enable,
 	.disable = clk_alpha_pll_disable,
 	.is_enabled = clk_alpha_pll_is_enabled,
@@ -1190,6 +1195,10 @@ const struct clk_ops clk_alpha_pll_fixed_ops = {
 EXPORT_SYMBOL_GPL(clk_alpha_pll_fixed_ops);
 
 const struct clk_ops clk_alpha_pll_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.enable = clk_alpha_pll_enable,
 	.disable = clk_alpha_pll_disable,
 	.is_enabled = clk_alpha_pll_is_enabled,
@@ -1200,6 +1209,10 @@ const struct clk_ops clk_alpha_pll_ops = {
 EXPORT_SYMBOL_GPL(clk_alpha_pll_ops);
 
 const struct clk_ops clk_alpha_pll_huayra_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.enable = clk_alpha_pll_enable,
 	.disable = clk_alpha_pll_disable,
 	.is_enabled = clk_alpha_pll_is_enabled,
@@ -1210,6 +1223,10 @@ const struct clk_ops clk_alpha_pll_huayra_ops = {
 EXPORT_SYMBOL_GPL(clk_alpha_pll_huayra_ops);
 
 const struct clk_ops clk_alpha_pll_hwfsm_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.enable = clk_alpha_pll_hwfsm_enable,
 	.disable = clk_alpha_pll_hwfsm_disable,
 	.is_enabled = clk_alpha_pll_hwfsm_is_enabled,
@@ -1220,6 +1237,10 @@ const struct clk_ops clk_alpha_pll_hwfsm_ops = {
 EXPORT_SYMBOL_GPL(clk_alpha_pll_hwfsm_ops);
 
 const struct clk_ops clk_alpha_pll_fixed_trion_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.enable = clk_trion_pll_enable,
 	.disable = clk_trion_pll_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
@@ -1310,6 +1331,10 @@ static int clk_alpha_pll_postdiv_set_rate(struct clk_hw *hw, unsigned long rate,
 }
 
 const struct clk_ops clk_alpha_pll_postdiv_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.recalc_rate = clk_alpha_pll_postdiv_recalc_rate,
 	.determine_rate = clk_alpha_pll_postdiv_determine_rate,
 	.set_rate = clk_alpha_pll_postdiv_set_rate,
@@ -1317,6 +1342,10 @@ const struct clk_ops clk_alpha_pll_postdiv_ops = {
 EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_ops);
 
 const struct clk_ops clk_alpha_pll_postdiv_ro_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.determine_rate = clk_alpha_pll_postdiv_ro_determine_rate,
 	.recalc_rate = clk_alpha_pll_postdiv_recalc_rate,
 };
@@ -1500,7 +1529,7 @@ static int alpha_pll_fabia_set_rate(struct clk_hw *hw, unsigned long rate,
 	return __clk_alpha_pll_update_latch(pll);
 }
 
-static int alpha_pll_fabia_prepare(struct clk_hw *hw)
+static int __alpha_pll_fabia_prepare(struct clk_hw *hw)
 {
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
 	const struct pll_vco *vco;
@@ -1555,8 +1584,26 @@ static int alpha_pll_fabia_prepare(struct clk_hw *hw)
 	return 0;
 }
 
+static int alpha_pll_fabia_prepare(struct clk_hw *hw)
+{
+	int ret;
+
+	ret = qcom_clk_dvfs_prepare(hw);
+	if (ret)
+		return ret;
+
+	ret = __alpha_pll_fabia_prepare(hw);
+	if (ret)
+		qcom_clk_dvfs_unprepare(hw);
+
+	return ret;
+}
+
 const struct clk_ops clk_alpha_pll_fabia_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
 	.prepare = alpha_pll_fabia_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.enable = alpha_pll_fabia_enable,
 	.disable = alpha_pll_fabia_disable,
 	.is_enabled = clk_alpha_pll_is_enabled,
@@ -1567,6 +1614,10 @@ const struct clk_ops clk_alpha_pll_fabia_ops = {
 EXPORT_SYMBOL_GPL(clk_alpha_pll_fabia_ops);
 
 const struct clk_ops clk_alpha_pll_fixed_fabia_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.enable = alpha_pll_fabia_enable,
 	.disable = alpha_pll_fabia_disable,
 	.is_enabled = clk_alpha_pll_is_enabled,
@@ -1653,6 +1704,10 @@ clk_trion_pll_postdiv_set_rate(struct clk_hw *hw, unsigned long rate,
 }
 
 const struct clk_ops clk_alpha_pll_postdiv_trion_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.recalc_rate = clk_trion_pll_postdiv_recalc_rate,
 	.determine_rate = clk_trion_pll_postdiv_determine_rate,
 	.set_rate = clk_trion_pll_postdiv_set_rate,
@@ -1699,6 +1754,10 @@ static int clk_alpha_pll_postdiv_fabia_set_rate(struct clk_hw *hw,
 }
 
 const struct clk_ops clk_alpha_pll_postdiv_fabia_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.recalc_rate = clk_alpha_pll_postdiv_fabia_recalc_rate,
 	.determine_rate = clk_alpha_pll_postdiv_fabia_determine_rate,
 	.set_rate = clk_alpha_pll_postdiv_fabia_set_rate,
@@ -1785,12 +1844,32 @@ static int __alpha_pll_trion_prepare(struct clk_hw *hw, u32 pcal_done)
 
 static int alpha_pll_trion_prepare(struct clk_hw *hw)
 {
-	return __alpha_pll_trion_prepare(hw, TRION_PCAL_DONE);
+	int ret;
+
+	ret = qcom_clk_dvfs_prepare(hw);
+	if (ret)
+		return ret;
+
+	ret = __alpha_pll_trion_prepare(hw, TRION_PCAL_DONE);
+	if (ret)
+		qcom_clk_dvfs_unprepare(hw);
+
+	return ret;
 }
 
 static int alpha_pll_lucid_prepare(struct clk_hw *hw)
 {
-	return __alpha_pll_trion_prepare(hw, LUCID_PCAL_DONE);
+	int ret;
+
+	ret = qcom_clk_dvfs_prepare(hw);
+	if (ret)
+		return ret;
+
+	ret = __alpha_pll_trion_prepare(hw, LUCID_PCAL_DONE);
+	if (ret)
+		qcom_clk_dvfs_unprepare(hw);
+
+	return ret;
 }
 
 static int __alpha_pll_trion_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -1847,7 +1926,10 @@ static int alpha_pll_trion_set_rate(struct clk_hw *hw, unsigned long rate,
 }
 
 const struct clk_ops clk_alpha_pll_trion_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
 	.prepare = alpha_pll_trion_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.enable = clk_trion_pll_enable,
 	.disable = clk_trion_pll_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
@@ -1858,7 +1940,10 @@ const struct clk_ops clk_alpha_pll_trion_ops = {
 EXPORT_SYMBOL_GPL(clk_alpha_pll_trion_ops);
 
 const struct clk_ops clk_alpha_pll_lucid_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
 	.prepare = alpha_pll_lucid_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.enable = clk_trion_pll_enable,
 	.disable = clk_trion_pll_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
@@ -1869,6 +1954,10 @@ const struct clk_ops clk_alpha_pll_lucid_ops = {
 EXPORT_SYMBOL_GPL(clk_alpha_pll_lucid_ops);
 
 const struct clk_ops clk_alpha_pll_postdiv_lucid_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.recalc_rate = clk_alpha_pll_postdiv_fabia_recalc_rate,
 	.determine_rate = clk_alpha_pll_postdiv_fabia_determine_rate,
 	.set_rate = clk_alpha_pll_postdiv_fabia_set_rate,
@@ -1918,6 +2007,10 @@ static int clk_alpha_pll_agera_set_rate(struct clk_hw *hw, unsigned long rate,
 }
 
 const struct clk_ops clk_alpha_pll_agera_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.enable = clk_alpha_pll_enable,
 	.disable = clk_alpha_pll_disable,
 	.is_enabled = clk_alpha_pll_is_enabled,
@@ -2054,7 +2147,7 @@ static void alpha_pll_lucid_5lpe_disable(struct clk_hw *hw)
  * The Lucid 5LPE PLL requires a power-on self-calibration which happens
  * when the PLL comes out of reset. Calibrate in case it is not completed.
  */
-static int alpha_pll_lucid_5lpe_prepare(struct clk_hw *hw)
+static int __alpha_pll_lucid_5lpe_prepare(struct clk_hw *hw)
 {
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
 	struct clk_hw *p;
@@ -2079,6 +2172,21 @@ static int alpha_pll_lucid_5lpe_prepare(struct clk_hw *hw)
 	return 0;
 }
 
+static int alpha_pll_lucid_5lpe_prepare(struct clk_hw *hw)
+{
+	int ret;
+
+	ret = qcom_clk_dvfs_prepare(hw);
+	if (ret)
+		return ret;
+
+	ret = __alpha_pll_lucid_5lpe_prepare(hw);
+	if (ret)
+		qcom_clk_dvfs_unprepare(hw);
+
+	return ret;
+}
+
 static int alpha_pll_lucid_5lpe_set_rate(struct clk_hw *hw, unsigned long rate,
 					 unsigned long prate)
 {
@@ -2133,7 +2241,10 @@ static int clk_lucid_5lpe_pll_postdiv_set_rate(struct clk_hw *hw, unsigned long
 }
 
 const struct clk_ops clk_alpha_pll_lucid_5lpe_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
 	.prepare = alpha_pll_lucid_5lpe_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.enable = alpha_pll_lucid_5lpe_enable,
 	.disable = alpha_pll_lucid_5lpe_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
@@ -2144,6 +2255,10 @@ const struct clk_ops clk_alpha_pll_lucid_5lpe_ops = {
 EXPORT_SYMBOL_GPL(clk_alpha_pll_lucid_5lpe_ops);
 
 const struct clk_ops clk_alpha_pll_fixed_lucid_5lpe_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.enable = alpha_pll_lucid_5lpe_enable,
 	.disable = alpha_pll_lucid_5lpe_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
@@ -2153,6 +2268,10 @@ const struct clk_ops clk_alpha_pll_fixed_lucid_5lpe_ops = {
 EXPORT_SYMBOL_GPL(clk_alpha_pll_fixed_lucid_5lpe_ops);
 
 const struct clk_ops clk_alpha_pll_postdiv_lucid_5lpe_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.recalc_rate = clk_alpha_pll_postdiv_fabia_recalc_rate,
 	.determine_rate = clk_alpha_pll_postdiv_fabia_determine_rate,
 	.set_rate = clk_lucid_5lpe_pll_postdiv_set_rate,
@@ -2319,6 +2438,10 @@ static int clk_zonda_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 }
 
 const struct clk_ops clk_alpha_pll_zonda_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.enable = clk_zonda_pll_enable,
 	.disable = clk_zonda_pll_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
@@ -2520,7 +2643,17 @@ static void alpha_pll_lucid_evo_disable(struct clk_hw *hw)
 
 static int alpha_pll_lucid_evo_prepare(struct clk_hw *hw)
 {
-	return _alpha_pll_lucid_evo_prepare(hw, false);
+	int ret;
+
+	ret = qcom_clk_dvfs_prepare(hw);
+	if (ret)
+		return ret;
+
+	ret = _alpha_pll_lucid_evo_prepare(hw, false);
+	if (ret)
+		qcom_clk_dvfs_unprepare(hw);
+
+	return ret;
 }
 
 static void alpha_pll_reset_lucid_evo_disable(struct clk_hw *hw)
@@ -2530,7 +2663,17 @@ static void alpha_pll_reset_lucid_evo_disable(struct clk_hw *hw)
 
 static int alpha_pll_reset_lucid_evo_prepare(struct clk_hw *hw)
 {
-	return _alpha_pll_lucid_evo_prepare(hw, true);
+	int ret;
+
+	ret = qcom_clk_dvfs_prepare(hw);
+	if (ret)
+		return ret;
+
+	ret = _alpha_pll_lucid_evo_prepare(hw, true);
+	if (ret)
+		qcom_clk_dvfs_unprepare(hw);
+
+	return ret;
 }
 
 static unsigned long alpha_pll_lucid_evo_recalc_rate(struct clk_hw *hw,
@@ -2557,6 +2700,10 @@ static int clk_lucid_evo_pll_postdiv_set_rate(struct clk_hw *hw, unsigned long r
 }
 
 const struct clk_ops clk_alpha_pll_fixed_lucid_evo_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.enable = alpha_pll_lucid_evo_enable,
 	.disable = alpha_pll_lucid_evo_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
@@ -2566,6 +2713,10 @@ const struct clk_ops clk_alpha_pll_fixed_lucid_evo_ops = {
 EXPORT_SYMBOL_GPL(clk_alpha_pll_fixed_lucid_evo_ops);
 
 const struct clk_ops clk_alpha_pll_postdiv_lucid_evo_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.recalc_rate = clk_alpha_pll_postdiv_fabia_recalc_rate,
 	.determine_rate = clk_alpha_pll_postdiv_fabia_determine_rate,
 	.set_rate = clk_lucid_evo_pll_postdiv_set_rate,
@@ -2573,7 +2724,10 @@ const struct clk_ops clk_alpha_pll_postdiv_lucid_evo_ops = {
 EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_lucid_evo_ops);
 
 const struct clk_ops clk_alpha_pll_lucid_evo_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
 	.prepare = alpha_pll_lucid_evo_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.enable = alpha_pll_lucid_evo_enable,
 	.disable = alpha_pll_lucid_evo_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
@@ -2584,7 +2738,10 @@ const struct clk_ops clk_alpha_pll_lucid_evo_ops = {
 EXPORT_SYMBOL_GPL(clk_alpha_pll_lucid_evo_ops);
 
 const struct clk_ops clk_alpha_pll_reset_lucid_evo_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
 	.prepare = alpha_pll_reset_lucid_evo_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.enable = alpha_pll_lucid_evo_enable,
 	.disable = alpha_pll_reset_lucid_evo_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
@@ -2594,7 +2751,7 @@ const struct clk_ops clk_alpha_pll_reset_lucid_evo_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_reset_lucid_evo_ops);
 
-static int alpha_pll_pongo_elu_prepare(struct clk_hw *hw)
+static int __alpha_pll_pongo_elu_prepare(struct clk_hw *hw)
 {
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
 	struct regmap *regmap = pll->clkr.regmap;
@@ -2624,6 +2781,21 @@ static int alpha_pll_pongo_elu_prepare(struct clk_hw *hw)
 	return 0;
 }
 
+static int alpha_pll_pongo_elu_prepare(struct clk_hw *hw)
+{
+	int ret;
+
+	ret = qcom_clk_dvfs_prepare(hw);
+	if (ret)
+		return ret;
+
+	ret = __alpha_pll_pongo_elu_prepare(hw);
+	if (ret)
+		qcom_clk_dvfs_unprepare(hw);
+
+	return ret;
+}
+
 static int alpha_pll_pongo_elu_enable(struct clk_hw *hw)
 {
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
@@ -2687,7 +2859,10 @@ static unsigned long alpha_pll_pongo_elu_recalc_rate(struct clk_hw *hw,
 }
 
 const struct clk_ops clk_alpha_pll_pongo_elu_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
 	.prepare = alpha_pll_pongo_elu_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.enable = alpha_pll_pongo_elu_enable,
 	.disable = alpha_pll_pongo_elu_disable,
 	.recalc_rate = alpha_pll_pongo_elu_recalc_rate,
@@ -2786,6 +2961,10 @@ static int clk_rivian_evo_pll_determine_rate(struct clk_hw *hw,
 }
 
 const struct clk_ops clk_alpha_pll_rivian_evo_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.enable = alpha_pll_lucid_5lpe_enable,
 	.disable = alpha_pll_lucid_5lpe_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
@@ -2899,6 +3078,10 @@ static int clk_alpha_pll_stromer_set_rate(struct clk_hw *hw, unsigned long rate,
 }
 
 const struct clk_ops clk_alpha_pll_stromer_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.enable = clk_alpha_pll_enable,
 	.disable = clk_alpha_pll_disable,
 	.is_enabled = clk_alpha_pll_is_enabled,
@@ -2964,9 +3147,32 @@ static int clk_alpha_pll_stromer_plus_set_rate(struct clk_hw *hw,
 	return 0;
 }
 
+static int clk_alpha_pll_stromer_plus_prepare(struct clk_hw *hw)
+{
+	int ret;
+
+	ret = qcom_clk_dvfs_prepare(hw);
+	if (ret)
+		return ret;
+
+	ret = clk_alpha_pll_enable(hw);
+	if (ret)
+		qcom_clk_dvfs_unprepare(hw);
+
+	return ret;
+}
+
+static void clk_alpha_pll_stromer_plus_unprepare(struct clk_hw *hw)
+{
+	clk_alpha_pll_disable(hw);
+	qcom_clk_dvfs_unprepare(hw);
+}
+
 const struct clk_ops clk_alpha_pll_stromer_plus_ops = {
-	.prepare = clk_alpha_pll_enable,
-	.unprepare = clk_alpha_pll_disable,
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = clk_alpha_pll_stromer_plus_prepare,
+	.unprepare = clk_alpha_pll_stromer_plus_unprepare,
 	.is_enabled = clk_alpha_pll_is_enabled,
 	.recalc_rate = clk_alpha_pll_recalc_rate,
 	.determine_rate = clk_alpha_pll_stromer_determine_rate,
@@ -2995,6 +3201,10 @@ void clk_regera_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
 EXPORT_SYMBOL_GPL(clk_regera_pll_configure);
 
 const struct clk_ops clk_alpha_pll_regera_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.enable = clk_zonda_pll_enable,
 	.disable = clk_zonda_pll_disable,
 	.is_enabled = clk_alpha_pll_is_enabled,
@@ -3202,6 +3412,10 @@ static int clk_alpha_pll_slew_enable(struct clk_hw *hw)
 }
 
 const struct clk_ops clk_alpha_pll_slew_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.enable = clk_alpha_pll_slew_enable,
 	.disable = clk_alpha_pll_disable,
 	.recalc_rate = clk_alpha_pll_recalc_rate,

-- 
2.56.0

