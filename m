Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AFF39BFFE;
	Fri, 27 Mar 2026 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642327; cv=none; b=iglzkseVBMDUpn9wglFLpH7biuP6AIdS5/dIfVyI7f29mudUan6FWABOxNcKEOH/+FbsJG8lJ2eVOmxOJUPSAVoJL9mLlSmhEg3Zw4bfv+5FESy3KESDT5nKE6jnzbRpYwIRV3/8LuogG7b2ysc/m9LiPB8q7tqMUpKElvGDnUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642327; c=relaxed/simple;
	bh=/FTUf8Q+4g72NdWe65PZDftW1cbnRaRwH2KwLe/mtvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KKjTkQcFkRtj/M65SVGRHS688c2yFlaYSupHP7sVqeYHQLtVVOl9FsLRqGeAfG8thfEF0i8QnEWsdI9iC6YTpePXqQ1dxuMRtV8moXWSoquh+exqJaapEwrhr/jUniX4oJW7dpx48XpDluiaIGyDuOJdmSm3B2LOfAs6EzEQ+V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=AtUJDoeV; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=cv0+SjA9; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="AtUJDoeV";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="cv0+SjA9"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1774642311; bh=N0E2bosbYF7P3B0HQI/5wGE
	4CJbd+dnrM8qdM+1xdV4=; b=AtUJDoeVIKNgrgxFLwZrAP4HTaGMDutgRMVnWW8j8m4THpyA6L
	VSU5JsfCkXbGfgLBZfwVmairm+MsBkfrpEv1Icl2XXo4AEFQq4IhLk2AXd8IQ+JtCFML6TLfTHy
	wMUvPd2AowpIo1QNQU1+4Z8f4oXACWN7X58vCUCXcGIcWJJQUIIIMC76zXkjVHoJBbJ8IU2nPdS
	q05i186eGv85DFYMLDFy+IJgXLUNfJLgvWN5xGeWVxagjESTK4mfXyofn9Qy2ly4vcSMKD2IZb/
	wctnlt4k4CVhx18LMp1SC9yRiYKKw7z+fbQX6+MdsHCKV7UO5WGr3WI5Y8tfuIPzqvA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1774642311; bh=N0E2bosbYF7P3B0HQI/5wGE
	4CJbd+dnrM8qdM+1xdV4=; b=cv0+SjA9bpsYNRTrOYZ0AQSyug3g3wpVVmviwMN4OXlty79yOD
	m3rtcsoy8zYZNMSNh09WvQ9n3a5wJv5s7jCQ==;
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Fri, 27 Mar 2026 21:11:48 +0100
Subject: [PATCH 6/7] remoteproc: qcom_q6v5_mss: Add SDM632 MSS
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260327-sdm632-rpmpd-v1-6-6098dc997d66@mainlining.org>
References: <20260327-sdm632-rpmpd-v1-0-6098dc997d66@mainlining.org>
In-Reply-To: <20260327-sdm632-rpmpd-v1-0-6098dc997d66@mainlining.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774642307; l=3277;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=/FTUf8Q+4g72NdWe65PZDftW1cbnRaRwH2KwLe/mtvw=;
 b=5BLARiDBRWE3fZOF3zv3Byz0cQx00BotpF0yREjpura84Q5H+TNdIMYHZfdudtY+HoiXZ2ppJ
 2X6l9YyNxy4DUMfpk08ovHSWjhR+3I7eYQGctNZDNMWMhsAO/c5uST/
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Add support for SDM632 mss, it is very similar to MSM8953 mss only
difference SDM632 is using mss-supply as pm domain.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 47 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 86edd826ede8..e63432184767 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -271,6 +271,7 @@ enum {
 	MSS_MSM8998,
 	MSS_SC7180,
 	MSS_SC7280,
+	MSS_SDM632,
 	MSS_SDM660,
 	MSS_SDM845,
 };
@@ -760,6 +761,7 @@ static int q6v5proc_reset(struct q6v5 *qproc)
 		   qproc->version == MSS_MSM8953 ||
 		   qproc->version == MSS_MSM8996 ||
 		   qproc->version == MSS_MSM8998 ||
+		   qproc->version == MSS_SDM632 ||
 		   qproc->version == MSS_SDM660) {
 
 		/* Override the ACC value if required */
@@ -770,7 +772,9 @@ static int q6v5proc_reset(struct q6v5 *qproc)
 			writel(QDSP6SS_ACC_OVERRIDE_VAL_9607,
 			       qproc->reg_base + QDSP6SS_STRAP_ACC);
 		else if (qproc->version != MSS_MSM8909 &&
-			 qproc->version != MSS_MSM8953)
+			 qproc->version != MSS_MSM8953 &&
+			 qproc->version != MSS_SDM632)
+			/* Override the ACC value if required */
 			writel(QDSP6SS_ACC_OVERRIDE_VAL,
 			       qproc->reg_base + QDSP6SS_STRAP_ACC);
 
@@ -830,7 +834,8 @@ static int q6v5proc_reset(struct q6v5 *qproc)
 			/* Turn on L1, L2, ETB and JU memories 1 at a time */
 			if (qproc->version == MSS_MSM8940 ||
 			    qproc->version == MSS_MSM8953 ||
-			    qproc->version == MSS_MSM8996) {
+			    qproc->version == MSS_MSM8996 ||
+			    qproc->version == MSS_SDM632) {
 				mem_pwr_ctl = QDSP6SS_MEM_PWR_CTL;
 				i = 19;
 				reverse = 0;
@@ -2303,6 +2308,43 @@ static const struct rproc_hexagon_res sc7280_mss = {
 	.version = MSS_SC7280,
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
+};
+
 static const struct rproc_hexagon_res sdm660_mss = {
 	.hexagon_mba_image = "mba.mbn",
 	.proxy_clk_names = (char*[]){
@@ -2896,6 +2938,7 @@ static const struct of_device_id q6v5_of_match[] = {
 	{ .compatible = "qcom,msm8998-mss-pil", .data = &msm8998_mss},
 	{ .compatible = "qcom,sc7180-mss-pil", .data = &sc7180_mss},
 	{ .compatible = "qcom,sc7280-mss-pil", .data = &sc7280_mss},
+	{ .compatible = "qcom,sdm632-mss-pil", .data = &sdm632_mss},
 	{ .compatible = "qcom,sdm660-mss-pil", .data = &sdm660_mss},
 	{ .compatible = "qcom,sdm845-mss-pil", .data = &sdm845_mss},
 	{ },

-- 
2.53.0

