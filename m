Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2A1347535
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 03:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776139194; cv=none; b=pTW2atA4kMTOTc6BeeCp9JdLJ4Cs56Fo15bP99FqkXMPKaZVMpp5unAsL4QNJCC6dANUq6SZ6E0Zg3dbUeOJb41lWn3BRRTWV/4Vlwkq31euxSQL7QKCT3nzWdyETS6oGVnBBBbVv6+EGdBmgTzenpWtRJXODIHcqqQ7tFY6+mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776139194; c=relaxed/simple;
	bh=x+LkWqy6XylTmTJQ8yU1ekofcbrjiotnrYxB9Bhs+f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzpD16ew/c41CkGxfdT5nh0Xjn7ITgX2maDQGwQ0CUlf1pRMo8uQ9u/hIjeezJcGYrBQ+/7yRc+luOyq519351lpZoozXwDImJKNGYAjQc2hBEZ7QVAOTej4wevDUnVfjkUXUDgHlvgj2TB4X38B56VtHUO4hzVXj7himkSrbUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M+hFq9+N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b9GsZCxg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M+hFq9+N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b9GsZCxg"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLENDO366050
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 03:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Bl3Ic3Mb/YW
	2B/brqGNBesrgAr2IILTx7LZLGKQE5ZI=; b=M+hFq9+Nwdvyrv7NwfNBM7mOVLl
	gtxa27XZB3lFUDF7c3U8Q8Hx4zsx1FB78mStzD2QiHUcrl+UMuL4mGQf8zTK5sHE
	iSfo4kxMi0DPN9uM0np5PtSaecjrst0x/2gZJcDRvVrs1Q55qBh81EZvhkX4NQie
	RMwAv2bOBxQmIVv8xzZzdjlAfFpCUj2aarf1xSu+5EAw5kYE3CLjKWG+U+sAmplV
	V4yhtMe7l61Frnma9nndfmHf4WWyr+wFStmMb/g2vWqepSXz+MDXB+tNFmajq0Jx
	t7aXBIabX8jV9sIXdtSaIA+3VsR8RBpKy7XihCDnZMgwNqw0kbmd7EBfwSg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh870rwq1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 03:59:50 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2d443c3b094so11407017eec.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2026 20:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776139190; x=1776743990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bl3Ic3Mb/YW2B/brqGNBesrgAr2IILTx7LZLGKQE5ZI=;
        b=b9GsZCxgHzSYgsAzVHEA7WK0V/mehHRf2vHFK/xS6Ij894E1/CTRMZzdOQMgoR6u/M
         +5U5hSjHi6LVMObf6KLrLsE77pXzx4z5usydSkkNCCMNQAZyk4zLVUg6meZYP1pZI5rp
         VLdZ0drjeaUW1M3BM/q2/YplTUbl3bAEAyesRWEAMYHz2GcUXEu/G+V3kbunv4uS2fDG
         eKrpggL0fvtzB1hGTlUnvi8rJ7aAldgRqaF3b4yVO0FDmwt5zk+DBTYXy/LwXS/5ST/6
         EHgDeU/PxaKLKqDwu8WiV+tcmC+nBJA9pHj9sT0IH/yu3tjtWhD5K3K5bq8TVgkZN47s
         v4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776139190; x=1776743990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bl3Ic3Mb/YW2B/brqGNBesrgAr2IILTx7LZLGKQE5ZI=;
        b=b8S4vScxWvtIqITJ73WS6czr9ivpLa1UYCS8zSOXuB/523keFD0uapqC7kErUnhqV1
         d4/dSluvB8CRSUA8r2KvUpkYlLv0fMiIiULi6Lot0D1gdh4DdbsSaxdxzdUdoukIqF1v
         TI0hufYPhtoNt0Teoz13AtqlXrKwvcbMP5gDy+ZX0Kp+BTgJzAMOu2vl9h70pZ2JtbUq
         0jXFnIzmIuOwgUeuK+qqPIy8osh9s/egZfZQk2DRkHPJrkCfs2+SwUAhNX3kCCDFgU8U
         3AJz07EP7B3r/tjg1qOpMnI9DkwGn3+IvzStid1GPlKGAbbYxAFpEQyxtbryTYTjH9Fv
         e56Q==
X-Forwarded-Encrypted: i=1; AFNElJ+OIye8+EcJh6xRKzaqhFH1FbSgX/97cj4CglsJNRT1gDsP9ItNOSlnNqOHHPZ6uOdPGRyoBrprmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuTCsXKG7gVJP0L9xhLHGuFevUjbA2qZKJYdNysvfeUaKpKxQS
	pHVSxj4RjVQMpoDhDrcW0DBuXMalaD0wikS0sNuHmTKBOc9cJHeu7d7/ClWf+qCIqV9p1kUy/u9
	G5t1LjSiYQ/bwge0o5x95opSilvgFyiCKrQBLqkWLQ1yba5mdcIADp81SJWuGVA==
X-Gm-Gg: AeBDievy/KL42TsZ6STPMFcFOdgFCudbkZJQ/+UYMk7FDrTnFg2tJaA9+HC3zjlgFXr
	0pGrxYk+7H8dpDNeJ5cFYvH61MTIBkGLeisJF1wAlSTKK4C2W/16T2Y3qzjq41u5dy2r7ID5ZXz
	J6YV2Lrr//N7vm0t7L57e43cVXHS5/g4v1rkr9oxY/mEyMc8Uk+pnq4SO9yQoRRGVRqImKkQ1im
	R02noWqHnDBF4KgdA/4TK9+qq2usLuxTx29uxQkjYEi6zJHpI1LDfseuccPc1rrl7XRKrinpd6Q
	Q0kh4wvPHuROl4pxyUJ31BZjcqHWEd4GfBnMC0srNG1D6MeJFmp3nLlKzZpadNme7of4asomwZ2
	iqjt1j6hjM1a7iaHcQ2qv8qtzGXwRZLVyMbdM9rMG3+mQQ1aFglHvepFWkrr+qPVbSKAD1E+WyD
	nAwHEECA==
X-Received: by 2002:a05:7300:7311:b0:2da:d4b4:c85a with SMTP id 5a478bee46e88-2dad4b4f25emr1482732eec.11.1776139190280;
        Mon, 13 Apr 2026 20:59:50 -0700 (PDT)
X-Received: by 2002:a05:7300:7311:b0:2da:d4b4:c85a with SMTP id 5a478bee46e88-2dad4b4f25emr1482702eec.11.1776139189708;
        Mon, 13 Apr 2026 20:59:49 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d80acca4c5sm13949983eec.19.2026.04.13.20.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 20:59:49 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH 3/3] pmdomain: qcom: rpmhpd: Add power domains for Nord SoC
Date: Tue, 14 Apr 2026 11:59:09 +0800
Message-ID: <20260414035909.652992-4-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414035909.652992-1-shengchao.guo@oss.qualcomm.com>
References: <20260414035909.652992-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=C9vZDwP+ c=1 sm=1 tr=0 ts=69ddbbb6 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=ZnOiI7GKHaE1sxxe5cYA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDAzNCBTYWx0ZWRfX5oBhWTpL5xEM
 02O4ta7GEEdmCHC8MJ2+bstRNQWDYNoX9KvY/2gvlll+C/EFTJCr3M50QqR5VvP2CBsGrmfTWvC
 Ar/Y2XtKa3S5c2uxRKt3g7vdf2Ni3wjDeM1Ud/+d+4eFzCPfW4QoR7/u46jOlUo3U5jyoUyTgpV
 mmUnUhFrNbW4y+X1krCwGZm6X/+EdCWB/jeOcNfYlIYtibpCKmL3UiME1nDUye/DXXt1Pxb273v
 9XvXU/glv7NeId6DyeJLDlX+ehYCV0APQ9JrkQrLYc3pGoxltZg9NyrkzND6MTYC+ARgDq0w9mp
 wiP7JM78dJKO+jHYOKYumGPM7j/A99+HnZoECgRzdVLb9A+7E/F1NDEBVZTZbuRMiaYB6Qs9rop
 THt6/L6oV/fOGbfp+f5DCkRH0EZk26jbbpo/klLT4GWXinHuAXHCQJIyviyES9CPPXhET68AQDo
 f1XxkKzwBor/G3DONsg==
X-Proofpoint-GUID: bd8NBdcOtGXJMK6b5AzeR4Jws8n_EeiO
X-Proofpoint-ORIG-GUID: bd8NBdcOtGXJMK6b5AzeR4Jws8n_EeiO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604140034

From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>

Add RPMh power domains required for Nord SoC.  This includes
new definitions for power domains supplying GFX1 and NSP3 subsystem.

Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index ba0cf4694435..63120e703923 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -122,6 +122,11 @@ static struct rpmhpd gfx = {
 	.res_name = "gfx.lvl",
 };
 
+static struct rpmhpd gfx1 = {
+	.pd = { .name = "gfx1", },
+	.res_name = "gfx1.lvl",
+};
+
 static struct rpmhpd lcx = {
 	.pd = { .name = "lcx", },
 	.res_name = "lcx.lvl",
@@ -217,6 +222,11 @@ static struct rpmhpd nsp2 = {
 	.res_name = "nsp2.lvl",
 };
 
+static struct rpmhpd nsp3 = {
+	.pd = { .name = "nsp3", },
+	.res_name = "nsp3.lvl",
+};
+
 static struct rpmhpd qphy = {
 	.pd = { .name = "qphy", },
 	.res_name = "qphy.lvl",
@@ -308,6 +318,30 @@ static const struct rpmhpd_desc sa8775p_desc = {
 	.num_pds = ARRAY_SIZE(sa8775p_rpmhpds),
 };
 
+/* Nord RPMH powerdomains */
+static struct rpmhpd *nord_rpmhpds[] = {
+	[RPMHPD_CX] = &cx,
+	[RPMHPD_CX_AO] = &cx_ao,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_GFX1] = &gfx1,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_MMCX] = &mmcx,
+	[RPMHPD_MMCX_AO] = &mmcx_ao,
+	[RPMHPD_MXC] = &mxc,
+	[RPMHPD_MXC_AO] = &mxc_ao,
+	[RPMHPD_NSP0] = &nsp0,
+	[RPMHPD_NSP1] = &nsp1,
+	[RPMHPD_NSP2] = &nsp2,
+	[RPMHPD_NSP3] = &nsp3,
+};
+
+static const struct rpmhpd_desc nord_desc = {
+	.rpmhpds = nord_rpmhpds,
+	.num_pds = ARRAY_SIZE(nord_rpmhpds),
+};
+
 /* SAR2130P RPMH powerdomains */
 static struct rpmhpd *sar2130p_rpmhpds[] = {
 	[RPMHPD_CX] = &cx,
@@ -856,6 +890,7 @@ static const struct of_device_id rpmhpd_match_table[] = {
 	{ .compatible = "qcom,hawi-rpmhpd", .data = &hawi_desc },
 	{ .compatible = "qcom,kaanapali-rpmhpd", .data = &kaanapali_desc },
 	{ .compatible = "qcom,milos-rpmhpd", .data = &milos_desc },
+	{ .compatible = "qcom,nord-rpmhpd", .data = &nord_desc },
 	{ .compatible = "qcom,qcs615-rpmhpd", .data = &qcs615_desc },
 	{ .compatible = "qcom,qcs8300-rpmhpd", .data = &qcs8300_desc },
 	{ .compatible = "qcom,qdu1000-rpmhpd", .data = &qdu1000_desc },
-- 
2.43.0

