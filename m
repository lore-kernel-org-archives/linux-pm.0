Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A19C3E3142
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778765804; cv=none; b=LI6M79kK4hM9tgxNbh4MYQmVa3u9gJeF9/HrIb+9ZeqLS0AVShctlILPGuj0zbmcD14qV6+YMsn+e5AasBrSxk7zXvKc5u9bTdG8oL8Mrd8tFINnyWaMv5b1qW6O7TErXAudTldDLRX/Lf0tkWeP7vTjwWiRZiJlr+wjLOavuKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778765804; c=relaxed/simple;
	bh=vW09mPGHEFBOAlpegnp8Dob8GfGLJ/tfxP4gmr3uAJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kS6wkmSEgt4EMM6HChv+qplT7HvgrDcy/Kxstw03udbd9jxjzMhgOpdKBeKDsUQ9xGS3ovomC2rkqYPTPZ2rqXZ04qGQgAzQU6zVx7g5N+3fF6rEd8RYuSn9HKNPHfU7ddDbH9SP2sfuvhncNcstL4WSCEJzgKv/OX10rrExfhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jN5uf7LU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QSw6CvO2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jN5uf7LU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QSw6CvO2"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EBeRVV3891053
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 13:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bEgeuV426iIHfMfTY+CEsXsWDY04sg4kubwVqpryfwg=; b=jN5uf7LUZIQhYGXE
	qGJdpbP3s54nELpryQGdN+31BvCCDaaDw3FHQfeTmEtJ/mBkQv+Ga/g1+0bky49N
	+JqTBXByhROTsn1DP1UT9uW4XP7N+5yiX+wWBUl964sQa30RujUC3JbiRAyhb2D/
	px3QmP7eH1+PswRZbyf2lKuWczcKKdmsEiT9d2sIDSw6bVX76XL4sOHOt1APMc1i
	XYQgkOaP1z8PvHdr19ZqiKFEeHPCcbjHJrPxmAR5JXXzFyfUpEVXhYZe+YjsKNuT
	TRQEBw2zBClkhVfNuxLByPQp3a6DUpRmIV65gJgNni6R6D/xYoTF0NKXLC7PiSUO
	a1E/vA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4v4tv68r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 13:36:41 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-6313cb80e7eso7149798137.2
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 06:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778765801; x=1779370601; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bEgeuV426iIHfMfTY+CEsXsWDY04sg4kubwVqpryfwg=;
        b=QSw6CvO2ZMvAsyMr7lLMPLJjKE9PCWrMSf/URYp4MMouzYBqIdlSu54fEoOyTW7mlo
         mOziijX43aJQUPgwwU74dLXlIgnrSPeew7zF8KwLRw77MPpi3o6H/r5BPIzNwYG7j3zA
         K4S4ONI9DntjFkBRZvwIz2bk67FXMpoOjLtRkVKGVPYeUcfRHezy1sY7Hre2WOceD1z2
         sHDkJkzEqjVSWuy6816ApAf6niLiS8NXUQrIXILXk3FyQ0u8lJrhPqdxL3a+5rqJqZ3R
         23fpu5s6wCpQSysBuVjNC68woH5qwBAHuPo9JrQPEwUBkBq0ejz8qgPbDAPzeL9kmOKR
         0x+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778765801; x=1779370601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bEgeuV426iIHfMfTY+CEsXsWDY04sg4kubwVqpryfwg=;
        b=fPRdz3set9o5Dj7g/M9mJ4xOwM1t9vkHPm4X0V6nKV+JL6sHt0A7tjDs+w7cCQLdbk
         TV4ZkbdngKfFwc2QdJMWQtcELtp1rYuYGZDOIZqTvK0DoNxRk5SQwivAmVWzTDvbkerJ
         Eg2px77UAQOOTRW8vm2R8CMowAuYpuTVLddtO9W2bzHHUzh90rXB8yw961fiUYxB4U3b
         OU6ckYpKY2ocCKhH/zmTAH9721kla6OSkl2/2xD20qf+vDek0PfaIvEWD69NdQ8Mfhac
         OAg2h58VC8ITQ508fnS2h4nmG1kvBkJQOOcJABCLbdm3aMd07OijWMU8in34hEIcKwxR
         qu2Q==
X-Forwarded-Encrypted: i=1; AFNElJ+uuaKJeCsGazROkgoTg4D+8ZKp8Y3oDZVr7kEOclemTJqqNP5QrTplaGyrN5Hxtu3C6X064Ud35A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yww/xJh3Cs1FZBfc2Y9z/HGow9d81vcmxKHAKiUf4rW25bv5n92
	pfhrL+oQNgensN/Ivrt59Rfmi3WRo+jS8sjhjV5dMLxOFOBcp2egAGngapUV3JGiLAWO/i61Ts7
	Okb67+LK6f9FkLPGtM8ED2BSWays+uTMIriRDOJsEFQnQvAS5RINoqMkUiAcPJA==
X-Gm-Gg: Acq92OHjSU0ycXFiNicCfHgKu1klNegXpcPhyRcQYuH2ZMrj/vyVkO/cJldlc+13znk
	1mHdMBPWDfAUuo6IQpucFyJ9vP8utlK5dYwpUT82BIUnC3vskb74qja5CFUZM9cO90ZnHSY3G3u
	MaFauZ8sNNWot2z5Ge5v73UUOQNzsv9pSBigFW52NymaC3XG+pBUrJNJ6yk/G+LYnxEHKcz+9aW
	sMv03LgJVQ5lXYAZr/3Fq0omCPfyQvGeNF5NO612ygDvGZMlhVOrAytjXR16e4LaHkCIJwRJr4B
	Qn06zCFoImuIXc0Ms325jSk5sGe/qiuxWzzD+czXWXQxyxYYUXPoD2/f2Gev7zrPU9inKFgxcmb
	fW5jESXRmAjc+zd/VMCO8AkAlm3RgUQ==
X-Received: by 2002:a05:6102:441e:b0:62f:5908:648a with SMTP id ada2fe7eead31-63776679ab2mr4192922137.28.1778765800446;
        Thu, 14 May 2026 06:36:40 -0700 (PDT)
X-Received: by 2002:a05:6102:441e:b0:62f:5908:648a with SMTP id ada2fe7eead31-63776679ab2mr4192852137.28.1778765799664;
        Thu, 14 May 2026 06:36:39 -0700 (PDT)
Received: from hackbox.lan ([86.121.170.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec39ff1sm7382462f8f.10.2026.05.14.06.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 06:36:38 -0700 (PDT)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Thu, 14 May 2026 16:36:24 +0300
Subject: [PATCH v2 2/2] interconnect: qcom: eliza: Add SDCC1 slave node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-eliza-interconnect-add-missing-sdcc1-slave-node-v2-2-13c03bc890cb@oss.qualcomm.com>
References: <20260514-eliza-interconnect-add-missing-sdcc1-slave-node-v2-0-13c03bc890cb@oss.qualcomm.com>
In-Reply-To: <20260514-eliza-interconnect-add-missing-sdcc1-slave-node-v2-0-13c03bc890cb@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-bc6c4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2579;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=vW09mPGHEFBOAlpegnp8Dob8GfGLJ/tfxP4gmr3uAJg=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBqBc/fbILFD886PPfxqzv9rNFi++dDLcxaNa88F
 wGC9cQ0XW2JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCagXP3wAKCRAbX0TJAJUV
 VgW5EACOQespkkkNWu0elWTq1T0z2g1q5iKgfco3K71Xvm6DX1ToJCJFFdtYdZFRylHDvBALjaT
 WxvaLeyS2pbwW85KYoj77dPlLGvIquKUYEipE3ry1Gkf6r19ti4rdJkhSRnNuA3Bz5hXXfqFkSc
 GTTBQ9lweq6P5ZZ6CA7PnflGZkIl5S4z/kZyhopuRYO805OoPPDdpbIMVqhcbYyP60eSSUF5yu+
 M2yP+1nXvaTjb7lZQHl141yKOCQ0tsWXiLVe1lSvUECDxHdE9UpJqjLkrDnO6IjxfzoxyvS0cj4
 ziy/BxMec5W0iJD/FuWIvgkMp/hoH1xbldSlXNqNR0StmiFJTtFmCNYiUYrs7zViWBXoMT3Kxlg
 2ZDlx7qgKrZdj8hM1xNy/HEwqh+pqWeItsQ4Vb+iX1hK0zSeaIQmGJ10tPaQ7n7uuHlgKS04wAG
 WHOTB55l5Ez8m9kZyjSS4+rxM98c1AoawvXdraApLIJFVxwYcN0LsRybmqWQWn+JMhN7UfglTUS
 1MixYK7/qcEmfWzntaQ0Ynv//iUxv5dSsm7ZDn9WVkakE5BUmKsWyceRuhxCZqaXlwrZE92fSo3
 lrDSi7vUjsBwHMjsbcfDoCiU+YzqLBU3rxM/SZc+M+YDVst+A7Pm15tLhdpp4Ug5YtESKUbPi20
 ybh6BuHmyJdXwfQ==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Authority-Analysis: v=2.4 cv=XIIAjwhE c=1 sm=1 tr=0 ts=6a05cfe9 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=NtgjAHhJo3Q0P2g9Zl9R/g==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=bhY4RTjvg2rligDOO-YA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDEzNyBTYWx0ZWRfX4LqtQo+rfbP0
 I1bbwM/ti1YEiv9RHYnuyUAQTlVoatKi76ysaDsvJyz50VIPBZ/c4Pt/ID3fbG2q0cXcpseDLAu
 gDGD0Dnb2Vh+nkoyV6pLM9e6ecbfvYKuHmRJfP1/QyBw6TfZt3fgW8tdKetdfb4infTwol634Gu
 ykNSfMumisoZBEnLbYcAMQiDOfvahALzBVt1Zk+DgeMq6Hc4gcBBfHVP3p3h0s9v9Z2sXS0XvDx
 xddvS4CdlJifwEKLsdYKQMjmBZuzcrQIwbzv5Gj6qtDkLF9QBdce79j/ME3crQqoMg/4iSwdujp
 Onaef8v+SAk1jujJgJ+dTNNgLI38q19p+378maDNxVHmyEnk1KYUVltv6iwg7++qpqFdBTmUdCL
 F8IfZUIzEsmCKm0mV3sjodSgYtq/YgYyHoq7+xxsk9avXN7D1nfMtg2I/q0TLsWVGfqjyHZLuDL
 q9+CI14i0RlFVfqtTfg==
X-Proofpoint-ORIG-GUID: UdL0eJocSkmw6LdgGKYh26r7hotAjYyC
X-Proofpoint-GUID: UdL0eJocSkmw6LdgGKYh26r7hotAjYyC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140137

The Eliza interconnect provider is missing the SDCC1 CNOC CFG slave
node. Add qhs_sdc1 to the provider node table so SDCC1 interconnect
paths can resolve to a provider node.

Hook qhs_sdc1 up to qsm_cfg and CN0, and bump the corresponding
qsm_cfg.num_links and bcm_cn0.num_nodes counts.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 drivers/interconnect/qcom/eliza.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/qcom/eliza.c b/drivers/interconnect/qcom/eliza.c
index a4f7903f0524..891e4e6e8ba8 100644
--- a/drivers/interconnect/qcom/eliza.c
+++ b/drivers/interconnect/qcom/eliza.c
@@ -127,6 +127,12 @@ static struct qcom_icc_node qhs_qup2 = {
 	.buswidth = 4,
 };
 
+static struct qcom_icc_node qhs_sdc1 = {
+	.name = "qhs_sdc1",
+	.channels = 1,
+	.buswidth = 4,
+};
+
 static struct qcom_icc_node qhs_sdc2 = {
 	.name = "qhs_sdc2",
 	.channels = 1,
@@ -383,7 +389,7 @@ static struct qcom_icc_node qsm_cfg = {
 	.name = "qsm_cfg",
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 29,
+	.num_links = 30,
 	.link_nodes = { &qhs_ahb2phy0, &qhs_ahb2phy1,
 			&qhs_camera_cfg, &qhs_clk_ctl,
 			&qhs_crypto0_cfg, &qhs_display_cfg,
@@ -392,7 +398,7 @@ static struct qcom_icc_node qsm_cfg = {
 			&qhs_mss_cfg, &qhs_pcie_0_cfg,
 			&qhs_prng, &qhs_qdss_cfg,
 			&qhs_qspi, &qhs_qup1,
-			&qhs_qup2, &qhs_sdc2,
+			&qhs_qup2, &qhs_sdc1, &qhs_sdc2,
 			&qhs_tcsr, &qhs_tlmm,
 			&qhs_ufs_mem_cfg, &qhs_usb3_0,
 			&qhs_venus_cfg, &qhs_vsense_ctrl_cfg,
@@ -1111,7 +1117,7 @@ static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
 	.enable_mask = BIT(0),
 	.keepalive = true,
-	.num_nodes = 43,
+	.num_nodes = 44,
 	.nodes = { &qsm_cfg, &qhs_ahb2phy0,
 		   &qhs_ahb2phy1, &qhs_camera_cfg,
 		   &qhs_clk_ctl, &qhs_crypto0_cfg,
@@ -1119,7 +1125,7 @@ static struct qcom_icc_bcm bcm_cn0 = {
 		   &qhs_i3c_ibi1_cfg, &qhs_imem_cfg,
 		   &qhs_mss_cfg, &qhs_pcie_0_cfg,
 		   &qhs_prng, &qhs_qdss_cfg,
-		   &qhs_qspi, &qhs_sdc2,
+		   &qhs_qspi, &qhs_sdc1, &qhs_sdc2,
 		   &qhs_tcsr, &qhs_tlmm,
 		   &qhs_ufs_mem_cfg, &qhs_usb3_0,
 		   &qhs_venus_cfg, &qhs_vsense_ctrl_cfg,
@@ -1321,6 +1327,7 @@ static struct qcom_icc_node * const cnoc_cfg_nodes[] = {
 	[SLAVE_QSPI_0] = &qhs_qspi,
 	[SLAVE_QUP_1] = &qhs_qup1,
 	[SLAVE_QUP_2] = &qhs_qup2,
+	[SLAVE_SDCC_1] = &qhs_sdc1,
 	[SLAVE_SDCC_2] = &qhs_sdc2,
 	[SLAVE_TCSR] = &qhs_tcsr,
 	[SLAVE_TLMM] = &qhs_tlmm,

-- 
2.54.0

