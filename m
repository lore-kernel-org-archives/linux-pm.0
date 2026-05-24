Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9CA30B521
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779645832; cv=none; b=Nt+NRWL5kizi/7I3dCWTQeVZB3jbqNaAbqk0zMXCn6Y57NGoxMhdSZaVEHR+MdzsmZk3uZmWkuXv+ubo9PCoNV5X4lUzpkbTvKfepT+sbDDzT2epZoxNDTOLkdMI0Mzwlpdnw2uW4ZcI5vgwpBjlw0OFHT+En/Oq1s/Q1Cuduh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779645832; c=relaxed/simple;
	bh=z69l8drcA4M56Gf1zLixXLJj1ip1Y7pboQfzhQCxh5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YGc95gm697KrtRxh5OhqQD8E61ZLKvMUKHVp3/dtFzj3jocYn5A5TBg6sP5k+tXxrl6cMivVi2izSi/70BEUVk33rNS1fZUjYcHSOH5k5CcMSv/en125091Gv9cC7CGbrAhmthJWKmYVJ7c1+K6ekVM1iscqPyO5mNX3mEJd8dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AmFHrJqb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JMu+g4xF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AmFHrJqb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JMu+g4xF"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64OFnGiN2075515
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 18:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WCrdaOfRAGHcT8CmjZ8/GuKkLdsPMB3TN1gi/Yl7+QQ=; b=AmFHrJqbHPX+yIvW
	IDjcmpbrg3zikfQHMI4RPfSnKkArB6WRwcA0swXJuj5a+170fdAHSW0Xwe8yoWE1
	xTMrs5ReGWEeOBVnh2sNMO/cIdN7+bjngIsrbsOuT0/5k9VNlr3/go6YVJ2Hp4ay
	n07hOjoGrGww43XRCBaaIoUCY3Z8GoUteqXFthB92FrzuNEwkCIZD2wPcQ/fq2Ry
	ag4uX401rueVH+qasglSEXltgYgd34gkXZAYKO4YnVT4SXGSllHbKTxIrHXEFotB
	AFFglg8C3cd8R88GWQpk5VnObe1z7qQOuDEPKOPRHRRkdpEHs2MDORYrf1S/We3j
	DTKonA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb50fumx1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 18:03:50 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3663d5e9bf4so8655240a91.1
        for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 11:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779645830; x=1780250630; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WCrdaOfRAGHcT8CmjZ8/GuKkLdsPMB3TN1gi/Yl7+QQ=;
        b=JMu+g4xFds0bw1Xzjwx5VCGWbVbi9A4uUHXyESxSjKRdJeGvaV/mxOpACI7Nivxjq6
         KAslNC25LwNBCC36lazM/W/PNRZ6LyeejAH5/W3FXaPMmFC+g3ukb5KOr9TfnNhKX7Sh
         wPw/Ki3PG0yyCqwkYHDlGtZyIw1gdzL5mKEOpPlA+mv5Z0wE9dKt0Q5Ix4HEtPuCFMRJ
         aUI0Yqk4PRx9C/mQZsxhM2hNxabRe1Whl3GbzxyCbFampvKvQaIFknP0SyZ6x2v1hlA5
         Sgc4AHO+NArzvB4P6AsouxWSTNvvfeJIHP2f+4YgDgXtojtNikd8UD8xc4VOUHff3V6N
         eExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779645830; x=1780250630;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WCrdaOfRAGHcT8CmjZ8/GuKkLdsPMB3TN1gi/Yl7+QQ=;
        b=dJ/S34QjEbrWB6EncxqqTeVhJ/cvC+KPn6Sr2ciBIVo9lwBhu2B6joJcc1ofPsQtgx
         msWNIQ1yBAmWFnTW5FW9jln3all04HoDQmTHeJwa3O3GzPXzAI4pkwx4/56I9VPpnWHR
         z5mUuQ3RhiBtCvyfbaokzpve8ikvmTn2K/4rePVngNgYjX8xsOnqqOSzNO65i6N1R+VB
         2nQDxxIIadwX0zDY+usFBInfxyAm9j6d7WZEeI3f0xhjACO4LvcFubPaUKnaYfqZhzv4
         36N8lgPsr7Ghhau/gHOaVrPFSPsd1NteSNZqNkug6RqiexcoIbQ6sGo+KC07x4lzV44L
         Tprw==
X-Forwarded-Encrypted: i=1; AFNElJ+zCykhMQqlpsGt/2DcugGzNgjz1xlesu+ag4r5w5q+OOTLDf5idh5VZvSUMZHpjXLOJsVypdpluw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr7l1R/NA0Jbzw7X1231ra/McIrPJ0hX51ng4RceY6GLECW0no
	R0S1HD9xyYupO7uXjkrLNySxU6oqkCHl5bEbEzE/I2zov0st+JV3H17Du43G8ahYmiIcb0Z5/9g
	kbWqfaPDqrN+2rfarH6Hz1ePIhRJSbwAqAwVuOtTgA0XVnB/Pbwv9QTfoumDnLA==
X-Gm-Gg: Acq92OHDuVF/8RkaXRG0tSHb0fGkHOX9n46ZtcS2dHI1XF//sWH8aHYDwdt0eMX1J8U
	F1oReRIEWfJzzSmsIok1hClpzYRnh/VpbcurG59xhaNuzOz5iHHEd2bLcwe7AbUBnD0lc4VW1pL
	jZUzvqe0Nao/Zgy9gB1EftKCjQGfM3j5UZ763i1+zKFPCZVLFYVu9Gkc2GJ99nUM99naDqf37wr
	P19oTGLgX67qGIOvyGAhkbc45V1r1eUTlmSiK7T8+IgmpEUveaALvulSmzmZOMuHZoybeeTZ0JZ
	/CTpuH0BAHfZJiYqiZTXRTLYNNRb2PjuJrXeE++WtLCwFVHLuPIDkHZnAlfXycEI8WneaFkGPtY
	Ji20r5G8YDSg/Tl8CgQeRfdcYQubxAMCTVrRLaEfGYO3H
X-Received: by 2002:a17:90b:56ce:b0:36a:cace:a4b6 with SMTP id 98e67ed59e1d1-36acacea4d5mr2431945a91.9.1779645829595;
        Sun, 24 May 2026 11:03:49 -0700 (PDT)
X-Received: by 2002:a17:90b:56ce:b0:36a:cace:a4b6 with SMTP id 98e67ed59e1d1-36acacea4d5mr2431922a91.9.1779645829116;
        Sun, 24 May 2026 11:03:49 -0700 (PDT)
Received: from [169.254.0.3] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a726348e2sm7252659a91.2.2026.05.24.11.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 11:03:48 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Date: Sun, 24 May 2026 18:03:36 +0000
Subject: [PATCH 2/2] interconnect: qcom: Add EPSS L3 scaling support for
 Shikra SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-shikra_epss_l3-v1-2-b1528a436134@oss.qualcomm.com>
References: <20260524-shikra_epss_l3-v1-0-b1528a436134@oss.qualcomm.com>
In-Reply-To: <20260524-shikra_epss_l3-v1-0-b1528a436134@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE4MSBTYWx0ZWRfX16rkGiDYOTea
 aAP2OtB64ZLgc6EYK8qCtgKhoaIERZSwnNnl+luXciJPMUIWSbX3bRtVZGuDb79wFwXo+ctE9Yu
 cy7sBsV3gZ8Akqk5l3VHO6Rz2Xa4DONqgeD2su4HOanIgvd1S2lZXN5XuIHGdueyTTSlHNjhODs
 MMd0F4pSrV7ptF4CwFvOnUBazHU0TqSX5QMt9Crygar8DDUgt3RnmgSVbEAFPrE9sk2ZCByFBxj
 PCMY3O3wFeiFicMVlAyGnG1I706bAC10jvrUPeVZG+49kePAxxRhMTxoc5d6tjrwqPxA80ENuj7
 tDmiOEkAV+2jLeTmLIOcoVYBembx7Nfnm9nfTXSvBa5hbJIbXyx9wBN8Cy3dsp6+kYuoVoNtnhX
 dMkNpAvYt9llaz2FoyXmptwdcRPTtG9e/RJYtGck6SDau/YWuYA4qYgZijMhsnOwg+gAFrPs6AR
 I50f6J6eIDI2sCFfdmw==
X-Proofpoint-ORIG-GUID: BPliWym1g3S748Nd4fbVx2vacmw5L500
X-Authority-Analysis: v=2.4 cv=UdBhjqSN c=1 sm=1 tr=0 ts=6a133d86 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Fbz4Wi_67QZ2LtXvWa0A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: BPliWym1g3S748Nd4fbVx2vacmw5L500
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605240181

Add Epoch Subsystem (EPSS) L3 interconnect provider support on
Qualcomm Shikra SoC.

The EPSS L3 block on Shikra SoC is similar to existing Qualcomm EPSS/OSM
L3 providers, but supports only up to 12 frequency lookup table entries.
Reading beyond the supported LUT entries can expose incorrect frequencies.
Add shikra-specific EPSS descriptor shikra_epss_l3_perf_state that reuses
existing EPSS configuration with appropriate LUT entries limit.

Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
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

