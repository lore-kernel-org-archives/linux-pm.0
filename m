Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399F454CF69;
	Tue, 29 Sep 2026 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790706547; cv=none; b=YCtv+OqdpHGlSwquEXJrTpe/Z27fkoj39tOtdG3S9euxVY7BxMppjGXaVcWmmOKRSLccBdtbdUytb6QXiRHPCNzJymveJjJD+DxRDRR8/T+YEyZt4k+CQ3wcqNCXcnzrivox1Rfze/kz0jytHfFDd8XkydOigXf6qp3J2F41b28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790706547; c=relaxed/simple;
	bh=E08EmZqj+7SJGDa5d2FXqN8Ur6cIxJrbWl6Z3TSjPmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bu/ovLzzNp82QT4OG+KMXaeb+96W46jtHZtk1ozC3nYs7wdDfaxt0i0VkX1cgeRvZXrcYB06Q/N8XMG25Zl36F2XMe7VISfs/TThFwOtAmxwLj/rOi15R4wqNYzun77w8/e3IGmxO7ayrcrBwk7FDva2CFG9MI7W6oXHW3w/TfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=oxJIbMXI; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=lRnn0EpT; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="oxJIbMXI";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="lRnn0EpT"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1790706528; bh=S9o7ScQfkfSzLz17lK4NdKG
	74KRbwYSWMnVJGKXD7HA=; b=oxJIbMXIo77wMpY7hM4dkmTiRfersrolHnIZD4db+lvbPHXqRJ
	3gqNIMO/hMGCvJrFm2vgTuQvjsof7Yo4zDiOdbuu7gdmz1ySnN3YyVzgcWeKeXr5U7czsTYzFTm
	oBExZyqp7fscunmW9dkhU5ioAo8jMlQjdsGkdt0i42JaT+noXZNOIanK29OK1+jQSE/CbrocTRM
	fSDugVSvvgHKqOZDrjm0iELiQlF79B2Rgbt8cV/C1nayBcSSTkrH2VNKQl1ss0+k/vMRX9J1oPv
	A0xvEmtvp5VaFtExN10u11+Klmy16OJXvuZv04+xSreeekj+BVHvaWDubJgiqLbtFGA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1790706528; bh=S9o7ScQfkfSzLz17lK4NdKG
	74KRbwYSWMnVJGKXD7HA=; b=lRnn0EpTk6qSvjBFzmwCEum8ZLZ6XV5PMZxvBLvN9CQF2OcSC0
	7npsq47mthlPamg1nrpUaf14gjKOYQDm9aDg==;
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Tue, 29 Sep 2026 20:28:31 +0200
Subject: [PATCH v2 2/6] pmdomain: qcom: rpmpd: Split SDM632 pm domains from
 MSM8953
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260929-sdm632-rpmpd-v2-2-97ef8858161b@mainlining.org>
References: <20260929-sdm632-rpmpd-v2-0-97ef8858161b@mainlining.org>
In-Reply-To: <20260929-sdm632-rpmpd-v2-0-97ef8858161b@mainlining.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Stephan Gerhold <stephan@gerhold.net>, Ulf Hansson <ulfh@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790706517; l=2562;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=E08EmZqj+7SJGDa5d2FXqN8Ur6cIxJrbWl6Z3TSjPmY=;
 b=A/NJjHR8sIwZnYdHS7JdnvX09wQtDMZ0h6P+Xs4UxDLtM2FLMJXpgmNJ44dvdxFVLiTNEkedK
 ptIxoc+R6aaCr25tgg2Q5jthteKW/aoroDu+QScsYnIBRtlUFXm/qQq
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Remove modem related pm domains from MSM8953 rpmpd because MSM8953 MSS
is using mss-supply as regulator.
Split SDM632 rpmpd from MSM8953 because SDM632 MSS is using mss-supply
as pm domain.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 drivers/pmdomain/qcom/rpmpd.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/pmdomain/qcom/rpmpd.c b/drivers/pmdomain/qcom/rpmpd.c
index 5f55fc791131..c37a79d6bc43 100644
--- a/drivers/pmdomain/qcom/rpmpd.c
+++ b/drivers/pmdomain/qcom/rpmpd.c
@@ -503,19 +503,8 @@ static struct rpmpd md_s1a_corner_ao = {
 	.key = KEY_CORNER,
 };
 
-static struct rpmpd md_s1a_lvl_ao;
 static struct rpmpd md_s1a_lvl = {
 	.pd = { .name = "md", },
-	.peer = &md_s1a_lvl_ao,
-	.res_type = RPMPD_SMPA,
-	.res_id = 1,
-	.key = KEY_LEVEL,
-};
-
-static struct rpmpd md_s1a_lvl_ao = {
-	.pd = { .name = "md_ao", },
-	.peer = &md_s1a_lvl,
-	.active_only = true,
 	.res_type = RPMPD_SMPA,
 	.res_id = 1,
 	.key = KEY_LEVEL,
@@ -703,8 +692,6 @@ static const struct rpmpd_desc msm8917_desc = {
 };
 
 static struct rpmpd *msm8953_rpmpds[] = {
-	[MSM8953_VDDMD] =	&md_s1a_lvl,
-	[MSM8953_VDDMD_AO] =	&md_s1a_lvl_ao,
 	[MSM8953_VDDCX] =	&cx_s2a_lvl,
 	[MSM8953_VDDCX_AO] =	&cx_s2a_lvl_ao,
 	[MSM8953_VDDCX_VFL] =	&cx_s2a_vfl,
@@ -844,6 +831,21 @@ static const struct rpmpd_desc qm215_desc = {
 	.max_state = RPM_SMD_LEVEL_TURBO,
 };
 
+static struct rpmpd *sdm632_rpmpds[] = {
+	[RPMPD_VDDMD] =		&md_s1a_lvl,
+	[RPMPD_VDDCX] =		&cx_s2a_lvl,
+	[RPMPD_VDDCX_AO] =	&cx_s2a_lvl_ao,
+	[RPMPD_VDDCX_VFL] =	&cx_s2a_vfl,
+	[RPMPD_VDDMX] =		&mx_s7a_lvl,
+	[RPMPD_VDDMX_AO] =	&mx_s7a_lvl_ao,
+};
+
+static const struct rpmpd_desc sdm632_desc = {
+	.rpmpds = sdm632_rpmpds,
+	.num_pds = ARRAY_SIZE(sdm632_rpmpds),
+	.max_state = RPM_SMD_LEVEL_TURBO,
+};
+
 static struct rpmpd *sdm660_rpmpds[] = {
 	[RPMPD_VDDCX] =		&cx_rwcx0_lvl,
 	[RPMPD_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
@@ -954,6 +956,7 @@ static const struct of_device_id rpmpd_match_table[] = {
 	{ .compatible = "qcom,qcm2290-rpmpd", .data = &qcm2290_desc },
 	{ .compatible = "qcom,qcs404-rpmpd", .data = &qcs404_desc },
 	{ .compatible = "qcom,qm215-rpmpd", .data = &qm215_desc },
+	{ .compatible = "qcom,sdm632-rpmpd", .data = &sdm632_desc },
 	{ .compatible = "qcom,sdm660-rpmpd", .data = &sdm660_desc },
 	{ .compatible = "qcom,shikra-rpmpd", .data = &shikra_desc },
 	{ .compatible = "qcom,sm6115-rpmpd", .data = &sm6115_desc },

-- 
2.55.0

