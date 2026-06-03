Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400764657FB
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485990; cv=none; b=EFKt+jkhOTowV45xx8p5FKraxtnFWZa8XSuoWsft4GWk9114Z3TuWZpEJjmUQ2yjsENFqaJxnrwdgA/ClMdQN7DyJEltSmRTz54BBLrK3l8MTsrKM8hMPA+QiFLXpexWykbkv4JPjj6JQiyhzLWZCLxsNdvcJuJ50sJPwoetogU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485990; c=relaxed/simple;
	bh=PVw3Afa18eTteU7MbnxPaIJ5xPkN0RyF8DKAzlYuhfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sRb4hx0B7V/O91tdnVPeFmwbRBuBGc7C2lsVmz+Ft9Y1I6whcSnRw9ChdGV75tgFwZKrqwGgBq+/O6IXD2mwkijdc0st2rZMMnu8JZ631ZkM2iEPzDkUNnBEjM4xMmdGVQJhDVfJLzx9EEsSxAEgWSXBW82G6S0uZP6rCFByoJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HZf4Kq6U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G4yQZeoI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HZf4Kq6U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G4yQZeoI"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6536RSNh1200262
	for <linux-pm@vger.kernel.org>; Wed, 3 Jun 2026 11:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1C4N5T38gImYpF1rGgzh327+DSXhT8qjbYdTa66Ap70=; b=HZf4Kq6UiTgJjYOf
	YRGgtG/dBZKZNdyZViEhDjRKR0saXq5viJxRcrRawcVVCa7YAj9a5cBYuvDCTut3
	dB9teF3qQVbG5ENwP04XxftN81ErCmYwmG7dmNavqNKjZBTRwcrxL0Q+PxldecZq
	tX5EmVBtrTpPh8kF+GLgnlwg8t9JXiZIqXQDfCZXEKDIz3CHtLh7d+VD7f9MlTq7
	IK7jM8qRAo7W49ANEvfQuFf7KnSN/G64QKPF7waQH/L86/THJuFvhvEV8pRd+7Pe
	qgxBcmliIhOk7bQkzFkhShJfbnJufX6y0uxWYVVNaXCjTJ9+GE32pree5emGXKxH
	Vxs2Yg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejckw1sb6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 11:26:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0c32faa62so65921635ad.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 04:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780485986; x=1781090786; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1C4N5T38gImYpF1rGgzh327+DSXhT8qjbYdTa66Ap70=;
        b=G4yQZeoIraCDp+2V2Qucto+aCER+D/spBvTYtXgOGwqb1N+Fqz2lwKD0+pf4VYp+kT
         h9NBtum+KCb2+pId5qAivHtvJmmtDwbrHIIiDVlXEnw6hQDQ/jGQ0iGDCpiAnPDTsKE6
         Xxynah/IgFy26AWo8EjVC+oDmjSVk1tSXLBliSMmXA30KUwhoMkqBoNhk1Ma66wh/QOo
         PJSRj++O5Ie3hy8pTUDKv6o9sak5wKFm1YSLDES77ShjCTWn9OJl5cNxfg5f1cH3/rEn
         TK+mRGMa4YoeEcJmx65qaumt4ita7gFdC2r9IiqYjMxNhYFRkXE8XKYWNtFtr6dsGHIj
         CAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780485986; x=1781090786;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1C4N5T38gImYpF1rGgzh327+DSXhT8qjbYdTa66Ap70=;
        b=bvpQIu3VBibb1U8orqtH7yuC3uB7rakruoTbqbCTfT7t9eK6i7ch5wtkVsdcAyfkWP
         r4kppQhAOFm4IVYC0Hmj3cT94o+rabWRdrTQDtFhfuURZn/AWiFDcWPCT3dLDfHaTHxE
         xV4mciXhc5v8v3OoWP80dWPz6Oydolwfr9D1IkVhcmuaAhTLf0KW0ZZXsdsbZ3rZMEBC
         gufABN/KiL5dGhBGL6bXM2nW1GC40CPsmQgeE8j3ddU/f2XVjhNodaT+wS4pWitW/Vug
         IFgUPOHrC2W6eT466vX41n17NXy1aMlEIJB+2+2dNJYTuN3fTsz2BayRLHDNIikdkaci
         gEig==
X-Forwarded-Encrypted: i=1; AFNElJ/lY6iu4sEEHEDtqwAOiEY6tK7CDhbyZZY9eJPSGl/YtfZIbVSEeq3DsqeQ1vu9S4hXUmHC6rlKMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYdlfq/VihKbqwERJc/qCUtSzXFxERmHZv76XEDsSVDmG/aOi7
	eWtkRoJMMOgI373qCiZDh5Zz2AnrsvZhoFqnxoXYJVbLzfgiVO50E9Odj7owbWkbCj8oxKyT1dx
	ei/hI+CgMwcpIZlxR9JNJYFZkiJaOMdwlIdkO8vy7JXFQ6He+8jBc6nUabzXjzw==
X-Gm-Gg: Acq92OHKbJ8Ez3QSstrW1CK0BCI/zbj9pDGBdCAWtogKfNcyhfPLJHlIR3sHP00qjYU
	RgnXzeSFdLkUeLStRooyNFT06UkE75j/kHLdY2vw1NLlAq4HIVRP0NsRhwmp4bP0C62obGrSThv
	RMCJtQ0DXRRKiiL29Zi0tkh4WFTKcGbijLKZfw3p6Wu2P1ZCM8fwulpPHUaCt3SxuOIWFHYjErM
	cNCRWf1+9fRwzEtaWV4mST+oJs3YRAvLiNHxCL3bl3wKw7u7S2eR1OzwRn+umpWB7WZRYm5KFVq
	nbWQ2lc/yejoBVgyl6hEPwxj8u0KH1YWWZBr9/5X0ALIf0FgvP7v9ksQ1Xk0IdPTl7oNtmLqosU
	nBwL2j6xbFXouW+kdxagchEdWZ0xt6cHTTxTp0P7mBWt/BAHtgy2aCDc=
X-Received: by 2002:a17:903:2443:b0:2bc:8f62:990b with SMTP id d9443c01a7336-2c1644dd3a8mr29617575ad.41.1780485986220;
        Wed, 03 Jun 2026 04:26:26 -0700 (PDT)
X-Received: by 2002:a17:903:2443:b0:2bc:8f62:990b with SMTP id d9443c01a7336-2c1644dd3a8mr29617285ad.41.1780485985800;
        Wed, 03 Jun 2026 04:26:25 -0700 (PDT)
Received: from [169.254.0.2] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e0ecsm22704275ad.45.2026.06.03.04.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 04:26:25 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 11:26:13 +0000
Subject: [PATCH v3 2/2] interconnect: qcom: Add EPSS L3 scaling support for
 Shikra SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-shikra_epss_l3-v3-2-3c2e0b796e78@oss.qualcomm.com>
References: <20260603-shikra_epss_l3-v3-0-3c2e0b796e78@oss.qualcomm.com>
In-Reply-To: <20260603-shikra_epss_l3-v3-0-3c2e0b796e78@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Proofpoint-ORIG-GUID: c0vm3ugTyyIoUHYrymDSLyFMI4QXYabE
X-Authority-Analysis: v=2.4 cv=edUNubEH c=1 sm=1 tr=0 ts=6a200f63 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Fbz4Wi_67QZ2LtXvWa0A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEwOSBTYWx0ZWRfX/FpfeT4AQX6n
 sdYRaIYJi4qlV4CMdhtHLiPo6MQosAtBzj8MEOM8ewfAjDe97ztlfeZN1s1aBPm9w1GrVqGvzAy
 BcNUZe7BFHHCU44UZpH0fIhB3AE0E8ubXjeZuir+YTQpWPHW/xW1uxdtVIlsib1lWX6PURE8tyO
 dNcPKxreqTIgs/IHrWJGq0XWLNJQPIsAXeL7AABA6DW9tGNNguusd1tZkQ/pmDCa+U9ArjeK5CI
 XaQN4oBNnkTJ844ESnLVdsOanuSgifTEtY4xfCjlGkqAH/zvRa4syoZ2q1OZgV59Ny6aBiGAGlc
 pyCxG8BHiBDj+tgKe+/hklLQSWLG1S4lHwY8BO0Tf/858NAcRqdZFDEiGNSLzvLNdWnjAcBnNPt
 QLP9NvwuM2bC9HESoTlcblSGKYbFL3oLim6Xu5JJM3Z1wBtiu8E3SFVOnUCWYdOQp8EVzCs5yuX
 Ht9zgxXLEnj8tGTHTQA==
X-Proofpoint-GUID: c0vm3ugTyyIoUHYrymDSLyFMI4QXYabE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030109

Add Epoch Subsystem (EPSS) L3 interconnect provider support on
Qualcomm Shikra SoC.

The EPSS L3 block on Shikra SoC is similar to existing Qualcomm EPSS/OSM
L3 providers, but supports only up to 12 frequency lookup table entries.
Reading beyond the supported LUT entries can expose incorrect frequencies.
Add shikra-specific EPSS descriptor shikra_epss_l3_perf_state that reuses
existing EPSS configuration with appropriate LUT entries limit.

Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
 drivers/interconnect/qcom/osm-l3.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index b33f00da1880..ecad636b53e0 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -60,6 +60,7 @@ struct qcom_osm_l3_desc {
 	unsigned int lut_row_size;
 	unsigned int reg_freq_lut;
 	unsigned int reg_perf_state;
+	unsigned int lut_max_entries;
 };
 
 #define DEFINE_QNODE(_name, _buswidth)					\
@@ -90,6 +91,7 @@ static const struct qcom_osm_l3_desc osm_l3 = {
 	.lut_row_size = OSM_LUT_ROW_SIZE,
 	.reg_freq_lut = OSM_REG_FREQ_LUT,
 	.reg_perf_state = OSM_REG_PERF_STATE,
+	.lut_max_entries = LUT_MAX_ENTRIES,
 };
 
 static const struct qcom_osm_l3_desc epss_l3_perf_state = {
@@ -98,6 +100,16 @@ static const struct qcom_osm_l3_desc epss_l3_perf_state = {
 	.lut_row_size = EPSS_LUT_ROW_SIZE,
 	.reg_freq_lut = EPSS_REG_FREQ_LUT,
 	.reg_perf_state = EPSS_REG_PERF_STATE,
+	.lut_max_entries = LUT_MAX_ENTRIES,
+};
+
+static const struct qcom_osm_l3_desc shikra_epss_l3_perf_state = {
+	.nodes = epss_l3_nodes,
+	.num_nodes = ARRAY_SIZE(epss_l3_nodes),
+	.lut_row_size = EPSS_LUT_ROW_SIZE,
+	.reg_freq_lut = EPSS_REG_FREQ_LUT,
+	.reg_perf_state = EPSS_REG_PERF_STATE,
+	.lut_max_entries = 12,
 };
 
 static const struct qcom_osm_l3_desc epss_l3_l3_vote = {
@@ -106,6 +118,7 @@ static const struct qcom_osm_l3_desc epss_l3_l3_vote = {
 	.lut_row_size = EPSS_LUT_ROW_SIZE,
 	.reg_freq_lut = EPSS_REG_FREQ_LUT,
 	.reg_perf_state = EPSS_REG_L3_VOTE,
+	.lut_max_entries = LUT_MAX_ENTRIES,
 };
 
 static int qcom_osm_l3_set(struct icc_node *src, struct icc_node *dst)
@@ -189,7 +202,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 
 	qp->reg_perf_state = desc->reg_perf_state;
 
-	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
+	for (i = 0; i < desc->lut_max_entries; i++) {
 		info = readl_relaxed(qp->base + desc->reg_freq_lut +
 				     i * desc->lut_row_size);
 		src = FIELD_GET(LUT_SRC, info);
@@ -272,6 +285,7 @@ static const struct of_device_id osm_l3_of_match[] = {
 	{ .compatible = "qcom,sc7180-osm-l3", .data = &osm_l3 },
 	{ .compatible = "qcom,sc7280-epss-l3", .data = &epss_l3_perf_state },
 	{ .compatible = "qcom,sdm845-osm-l3", .data = &osm_l3 },
+	{ .compatible = "qcom,shikra-epss-l3", .data = &shikra_epss_l3_perf_state },
 	{ .compatible = "qcom,sm8150-osm-l3", .data = &osm_l3 },
 	{ .compatible = "qcom,sc8180x-osm-l3", .data = &osm_l3 },
 	{ .compatible = "qcom,sm8250-epss-l3", .data = &epss_l3_perf_state },

-- 
2.43.0

