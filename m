Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C001553A897;
	Thu,  1 Oct 2026 22:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790894370; cv=none; b=qF1/uapqG4xzaaz74TOPbKV0vvTq7MjDVRnT7SW2sM1+qpzw19ag37kB5jTk0Kstj6sVGnCG0I9WTDyr0W1JTy9PV3dbsJ08nbIvn7FxcDTnn/W5fM4jTbmSHeb/LTCW/dHSd6A/EVCAT9QrKsg71YnSG1Bn+X1ADGfkLy1FVNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790894370; c=relaxed/simple;
	bh=k2ve9LUY268MZQ1u8RQTTwA9UBykr9y3Q6hKUz/3Hq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CrvvgwTSCw2Woe4j3ARtO2iLJX4k3CMz7HSPuCOQGB7f8flPN8lDTNgbIToFAqlLC2d59isNTX96fFO2qQcIdz/cSoGE1tkSWMQDfIAzL0/yXjaf4hJJGcIWgngivlNxzLIls43mtNQFB7Athumc7cH2yjuIoawDPtaIUWSfnGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=pl8FVpK8; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=wlIzbNP0; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="pl8FVpK8";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="wlIzbNP0"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1790894353; bh=qH8qtAvJt6QBAaVW7+RemNL
	LbkyXjP6yIK8kxrITcAE=; b=pl8FVpK8NleKwQaoR7eoQxDkNpWpJzYNwX2fTSB7Uv59y/2CAf
	9C+4xTMxjrr6FHoK352uySyaufZ/5ERnkOaRo/+Pin3NnJRsRebgVp2g0Bxq624VNKjo49bUba/
	cMkvaWJwAP1SL4d6jT78B/JlH6vlgFoE+xmAVpqdONSZ0XkYHKXQ1CdW0La07lzg3n8Fo0cgqIs
	ns11gjsJoA7VqTckkgQLGILc+QVS+86O0Rg6uX9CLeOozy4JjhxLD0k0B5aYBcEGPx4wGrJrlL7
	shIi/o8/xcC9LkXMIOxTTC4ChC4rtvGId+c9pcWQPOtpD/4pMDFyn3FpFsAZkHZU74w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1790894353; bh=qH8qtAvJt6QBAaVW7+RemNL
	LbkyXjP6yIK8kxrITcAE=; b=wlIzbNP0VypHJVk4EtJmjR0hJcnYOSbMK30vtlT604kSaILw3O
	/ayz630/emtOsHq4kQ1PJIE1Wdcgtg+XMFDA==;
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Fri, 02 Oct 2026 00:38:34 +0200
Subject: [PATCH v3 6/7] remoteproc: qcom_q6v5_mss: Add SDM632 MSS
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-sdm632-rpmpd-v3-6-95c47d0f26cf@mainlining.org>
References: <20261002-sdm632-rpmpd-v3-0-95c47d0f26cf@mainlining.org>
In-Reply-To: <20261002-sdm632-rpmpd-v3-0-95c47d0f26cf@mainlining.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Stephan Gerhold <stephan@gerhold.net>, Ulf Hansson <ulfh@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790894346; l=3313;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=k2ve9LUY268MZQ1u8RQTTwA9UBykr9y3Q6hKUz/3Hq4=;
 b=QA2ybEKXnMS4IouRyfOhlylms5jU/Ev4lQ6zvFnS9KLDj04s3Jlaom7B/OCn/S0mvsIssVBsJ
 2sxtSv4Gw7aAme0V2mwIqWCAp/UdeOc2R9IvDUPracupcyf7SsPI4RT
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Add support for SDM632 mss, it is very similar to MSM8953 mss only
difference SDM632 is using mss-supply as pm domain.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 47 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 8f6312213e1a..79510cbfcb8f 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -273,6 +273,7 @@ enum {
 	MSS_MSM8998,
 	MSS_SC7180,
 	MSS_SC7280,
+	MSS_SDM632,
 	MSS_SDM660,
 	MSS_SDM845,
 };
@@ -762,6 +763,7 @@ static int q6v5proc_reset(struct q6v5 *qproc)
 		   qproc->version == MSS_MSM8953 ||
 		   qproc->version == MSS_MSM8996 ||
 		   qproc->version == MSS_MSM8998 ||
+		   qproc->version == MSS_SDM632 ||
 		   qproc->version == MSS_SDM660) {
 
 		/* Override the ACC value if required */
@@ -772,7 +774,8 @@ static int q6v5proc_reset(struct q6v5 *qproc)
 			writel(QDSP6SS_ACC_OVERRIDE_VAL_9607,
 			       qproc->reg_base + QDSP6SS_STRAP_ACC);
 		else if (qproc->version != MSS_MSM8909 &&
-			 qproc->version != MSS_MSM8953)
+			 qproc->version != MSS_MSM8953 &&
+			 qproc->version != MSS_SDM632)
 			writel(QDSP6SS_ACC_OVERRIDE_VAL,
 			       qproc->reg_base + QDSP6SS_STRAP_ACC);
 
@@ -832,7 +835,8 @@ static int q6v5proc_reset(struct q6v5 *qproc)
 			/* Turn on L1, L2, ETB and JU memories 1 at a time */
 			if (qproc->version == MSS_MSM8940 ||
 			    qproc->version == MSS_MSM8953 ||
-			    qproc->version == MSS_MSM8996) {
+			    qproc->version == MSS_MSM8996 ||
+			    qproc->version == MSS_SDM632) {
 				mem_pwr_ctl = QDSP6SS_MEM_PWR_CTL;
 				i = 19;
 				reverse = 0;
@@ -2316,6 +2320,44 @@ static const struct rproc_hexagon_res sc7280_mss = {
 	.ssctl_id = 0x12,
 };
 
+static const struct rproc_hexagon_res sdm632_mss = {
+	.hexagon_mba_image = "mba.mbn",
+	.proxy_supply = (struct qcom_mss_reg_res[]) {
+		{
+			.supply = "pll",
+			.uA = 100000,
+		},
+		{}
+	},
+	.proxy_clk_names = (char*[]){
+		"xo",
+		NULL
+	},
+	.active_clk_names = (char*[]){
+		"iface",
+		"bus",
+		"mem",
+		NULL
+	},
+	.proxy_pd_names = (char*[]) {
+		"cx",
+		"mx",
+		"mss",
+		NULL
+	},
+	.need_mem_protection = false,
+	.need_pas_mem_setup = true,
+	.has_alt_reset = false,
+	.has_mba_logs = false,
+	.has_spare_reg = false,
+	.has_qaccept_regs = false,
+	.has_ext_bhs_reg = false,
+	.has_ext_cntl_regs = false,
+	.has_vq6 = false,
+	.version = MSS_SDM632,
+	.ssctl_id = 0x12,
+};
+
 static const struct rproc_hexagon_res sdm660_mss = {
 	.hexagon_mba_image = "mba.mbn",
 	.proxy_clk_names = (char*[]){
@@ -2923,6 +2965,7 @@ static const struct of_device_id q6v5_of_match[] = {
 	{ .compatible = "qcom,msm8998-mss-pil", .data = &msm8998_mss },
 	{ .compatible = "qcom,sc7180-mss-pil", .data = &sc7180_mss },
 	{ .compatible = "qcom,sc7280-mss-pil", .data = &sc7280_mss },
+	{ .compatible = "qcom,sdm632-mss-pil", .data = &sdm632_mss},
 	{ .compatible = "qcom,sdm660-mss-pil", .data = &sdm660_mss },
 	{ .compatible = "qcom,sdm845-mss-pil", .data = &sdm845_mss },
 	{ },

-- 
2.56.0

