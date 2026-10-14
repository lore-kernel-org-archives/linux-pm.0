Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1EF185B48;
	Wed, 14 Oct 2026 12:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980544; cv=none; b=T83a0kYic3Ks6yibWNNJxbLftWRiV/+055od6Mqv7Jn2+umKT2a4QmHL8uyjwW1cGs6X197UDmdZbTiXn9r9osoYuoJs5l1dPLKz3PspqjVeJcE7/Dx8FCGLI716R7v6XJb4BizJgmIovkyP8FiwK31aCPymNXwWfv//Yw+9XCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980544; c=relaxed/simple;
	bh=/5CVs+TWsKpVrBWZ+LXruP7eNgf6eZQ3vXX6QakG2So=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VXV/a1EbdzhqHNgfSdCHhWKatxfUA+ke0ArZASLnb9MGJDNSdoOuXpMiuhMxcbhCsB274ZGAJ4P7IzewCTZWpzWgMf3yIUb0fFHr+IC5GVynjKtCQm2kS9Lh7qAyqmAPXn8yvSm4UBLjq1cXd2SlUTqBcioYYMOM3PLszYK3GrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfHKqH0r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfHKqH0r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CFB1F00893;
	Wed, 14 Oct 2026 12:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791980543;
	bh=emDdlIvl+E2h6UbK+wCLPvQ3FpPFNbs4n+sRDqmltyk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cfHKqH0rry/XH/9BImp7O2Nsc4IizZ7yJ2no3vzdK6JiMFCuRjizMza+SuOrVqEXC
	 WmKQE6PqjITu/1TRFshlEmpuGhADrkf1YoAzqwJc7v4VjacV/ugvlX04KNxXO/7sNL
	 NXfPmJkITYSdLnGv28wToDAbNynTKUqDE1XElsnaR+hF1VfFwklIpImL/xBlTrrl1/
	 O9dVW5hIx5XT7JtlLRAh1rNw1eJDb/vt/d8ws5wsNvdO7EjimZMLzL0sJ8eULeAhLU
	 00XfRfode8xPLDMczuO63QBRsNCxQGc6ruE6zoV8G6aBnjuTrQittltAqZcp4Gr+3s
	 vs0dtt/86F6PA==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 14 Oct 2026 14:19:13 +0200
Subject: [PATCH DNM RFC 13/16] arm64: dts: qcom: sm8650: Describe clock
 controller power rails
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-topic-qc_clk_dvfs-v1-13-3041b788e9f7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791980431; l=2088;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=1AErwMLx79lB/8RK9yN4ddf3P30hHkN3Gpbj1xK8odo=;
 b=S49YtHGhBOL15UG2XCkO5lftlW9Lq26MDYTexYtPIpp6Hi1Tb+Gd9NWFYtKSixSgNKlQ9EGrJ
 NRNuN9BvSZtAHpmuxxHNm1OmcUGkDx/vjohvdAr/N3fMtaNWV1EyiVA
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

The SM8650 clock-controller nodes omit rails needed by their clocks and
PLLs. Without those connections, the clock-owned DVFS implementation
cannot attach its voters to all required domains and controller probe
can fail before any clocks are registered.

Fixes: d2350377997f ("arm64: dts: qcom: add initial SM8650 dtsi")
Assisted-by: LLM
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 86fbb0fd6472..0847cfb35954 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -2017,8 +2017,9 @@ gcc: clock-controller@100000 {
 				 <&ufs_mem_phy 1>,
 				 <&ufs_mem_phy 2>,
 				 <&usb_dp_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
-
-			power-domains = <&rpmhpd RPMHPD_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_CX_AO>,
+					<&rpmhpd RPMHPD_MX>;
 
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -4364,6 +4365,10 @@ gpucc: clock-controller@3d90000 {
 			clocks = <&bi_tcxo_div2>,
 				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
 				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
+			power-domains = <&rpmhpd RPMHPD_MX>,
+					<&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MXC>,
+					<&rpmhpd RPMHPD_GFX>;
 
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -5639,7 +5644,8 @@ camcc: clock-controller@ade0000 {
 				 <&bi_tcxo_ao_div2>,
 				 <&sleep_clk>;
 			power-domains = <&rpmhpd RPMHPD_MMCX>,
-					<&rpmhpd RPMHPD_MXC>;
+					<&rpmhpd RPMHPD_MXC>,
+					<&rpmhpd RPMHPD_MX>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
@@ -6049,8 +6055,8 @@ dispcc: clock-controller@af00000 {
 				 <0>, /* dp3 */
 				 <0>;
 
-			power-domains = <&rpmhpd RPMHPD_MMCX>;
-			required-opps = <&rpmhpd_opp_low_svs>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>,
+					<&rpmhpd RPMHPD_MX>;
 
 			#clock-cells = <1>;
 			#reset-cells = <1>;

-- 
2.56.0

