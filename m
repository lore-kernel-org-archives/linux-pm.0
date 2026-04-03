Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78789267B05
	for <linux-pm@vger.kernel.org>; Fri,  3 Apr 2026 00:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775176581; cv=none; b=TdASAqzx4RdKPTX10/Q/DbuSOtBLclnH9vrVgIJIYgM3DJUuq4iB93zoRFUkS9Nubgyd+rGZjR/C8ZBidxiC36y69zTY/HZ0ayDbbEooamuGkcZTqbTtxSqdLbxdyL0+TjQBeRDdK2Zbts+hREmX9GY7lMskaLSTK5XY1CDRxvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775176581; c=relaxed/simple;
	bh=DRT2gIEqEs+RAsIvgPMQRwWOyVMEY7rMCZ4VlFwdz1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j6c6XHgAjMayV88VtG7LAoCvkzWJzH5ukEK6pHR8A6fwEfZsih50XSThzSW1C7rkE178UOYNw4KL46Poq02XF+pW+g15OtYKqUdYFz+nKt3cIr19Cg+l57MyHE9Bj9UA+K7NQkqbTJISrHocbQxmI9gWdKo4kSC7WdTEtt2rKuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yc42GMmm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fe99twii; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yc42GMmm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fe99twii"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632I2Ewm3772540
	for <linux-pm@vger.kernel.org>; Fri, 3 Apr 2026 00:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zivnovxSu9T37vh7fCot6swCASthFxgNrxcW8uiHS4I=; b=Yc42GMmmTzaKkNeI
	6U9kvCP20m5K6sXNuPCO4cH51sjTNnXzbteWLb3rBZMZvaeFDnTHXjVeaNhNbiSn
	zkaf5MT7yYT6/S4chbq5XtjhsFmcr+RuSlXlM2++VlYOaSDZXvRQUF5rnBb4F/Nx
	9kPxHFuVE4k5Gj4VECyadn3JU2gaEAIDmQ6MPS4Qd0W7Zez4zNaGlQF2/KYqdJa9
	Qti+ctqSrZILpRmhYwwfSsOUX5+Uqf1OKGBpM+qV6c8wra2tzu/kKy7qEjd0FZfQ
	6pXolpth2YfD6G1eWdfWTOGl1E/6Dv4MudO3iRAJrviNpdJZ6QAYHiKM5TrrrywH
	BvhWrw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9wcs1023-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 03 Apr 2026 00:36:18 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2c5b48baf75so1045499eec.0
        for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2026 17:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775176577; x=1775781377; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zivnovxSu9T37vh7fCot6swCASthFxgNrxcW8uiHS4I=;
        b=Fe99twii92Kn6QaSPWstvE3oAY8/nbez0Pkchb2vOTj9WeiL+1bEskBnpCjQYnLJwV
         iaacFDpIJ6eTvEz0PhiTD6zkFAxpRx2PN9Fg/pD+YU1fLaKi4s3CzBZZOV6z5YRqaB6s
         7ta4yYVo0lMszb5cwn7zMT3t/OxiRQnykph78p3nU1JGWTpiODKZRP9pBFCNyTuis+89
         Cv+6N5pFaLpnR8zYyHSm+oDEWdr3Tj+S1Ss9nlEO6chELVSKzmzfsIzKNrgxewrCvRla
         343fRaeJtQxLKmzoei+Hbgk2i9dgyd+ukN6UtWky4qILfI6otB0UYdzLcP6L/M5AGH66
         S5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775176577; x=1775781377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zivnovxSu9T37vh7fCot6swCASthFxgNrxcW8uiHS4I=;
        b=gllxCx0CvS2YX4URcvcFaGiUMi8TL/ivc9x/nYCRJNZHRZ36pIz/Ibj02NyTRbvE1q
         SeUwVqSVObHS28BbXhUZN6pC2ACxC7Ov1IQunzLVhRuqKJQb/dJ8FaJCl3raQG/If8jH
         2Nqe5usBrDzZTO/6et3iXHVaPJJYOfD4NYGPa5roeOj0K2bTp5086NjzYs/KkH/Pue6H
         xDslugvX9SRr7TdGAFuMNnAre2/nQhlLfq6lOoeOp7CHqfPe8BNFJwHsF2TVd37QfmZX
         RxvqYDDW3O/FaDYvUdxpYnif4G0ysnjXdBl6DFlrm5sEpyTMfa7OvGd58UL05caOo38Y
         4HiA==
X-Forwarded-Encrypted: i=1; AJvYcCXJdhDzUB81ofjqhty+YpDOEZcL3yg4afeXI7u52gJvNLGWT8scHqHiGkhkdXjbCTwQSEvAdhLL3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YybtZ4Hts0XSJy+DmxbKf75l01NWqs1867nBm6OZcl0NjgqEPjD
	KdqGDe4YSFlwELOTFu/2e12QTr9HRUlEX8wUQwNuds0fEXuXyjXAH/E4jyw7g6tctWGdkESyQiQ
	mU2UlRI6bYwcvxN2KvwceAB6g+elzzX3XroBtZDpfURcp99pl3+Nqxv3fo074pA==
X-Gm-Gg: ATEYQzzVvmTA5WDaV5d3B587t7E8xBkq8+7+5oD95542mKqXh8QDgPrvgB03rh71viN
	M2QB70nloMaZsXSYhlR7n8rN+oRUZNp9JffZA3kJo09bLLd06l16loznqITz5LyPVD8DcMvPbaR
	U3ZGFCaxAwkqpNkqXqkWflbAfrbqhafs8GkMFjGknxTMO5cuPwiBZGF5TMqf9zVLoxwI8tzKOGX
	1E0GdxS+s5szDugbuO69LXgmNvpKjubti2UcEDK/3v5Pm84GUItzzmeWNl+ITiWdDvnw5ZaXwSi
	DpiPkIcAxw1E8d+J2nUtjWPuFvZihaVMnbug+mWD1ECX6PafGFkUcLv0h944c1kTGIB7vJJiqVy
	fElJWFsBX3DtiUmKB24WG7RwlKwdl7IiCAxU7mgtoZrpp0Xxcggud8XX5FpHbsGS//45tbpbBCw
	==
X-Received: by 2002:a05:7022:221c:b0:128:d438:cad with SMTP id a92af1059eb24-12bfb74c7ecmr646173c88.18.1775176577425;
        Thu, 02 Apr 2026 17:36:17 -0700 (PDT)
X-Received: by 2002:a05:7022:221c:b0:128:d438:cad with SMTP id a92af1059eb24-12bfb74c7ecmr646148c88.18.1775176576915;
        Thu, 02 Apr 2026 17:36:16 -0700 (PDT)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bed93f861sm6290550c88.0.2026.04.02.17.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 17:36:16 -0700 (PDT)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Date: Thu, 02 Apr 2026 17:35:22 -0700
Subject: [PATCH v2 2/2] pmdomain: qcom: rpmhpd: Add power domains for Hawi
 SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-haw-rpmhpd-v2-2-2bce0767f2ca@oss.qualcomm.com>
References: <20260402-haw-rpmhpd-v2-0-2bce0767f2ca@oss.qualcomm.com>
In-Reply-To: <20260402-haw-rpmhpd-v2-0-2bce0767f2ca@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel@oss.qualcomm.com, Fenglin Wu <fenglin.wu@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-17187
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775176574; l=2519;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=DRT2gIEqEs+RAsIvgPMQRwWOyVMEY7rMCZ4VlFwdz1I=;
 b=/Me+lrh5aFjWOFlNIOkr9UVd2ZwEogonrnK/9OFGRG56CyynREsMhJlMa7cHVPnVXPUO6mEMO
 JCbVaDvISNVBcCnQ/tgpEv/VlZVyO9QsdkxUNoc6WC842w3Euxb+7nP
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Proofpoint-ORIG-GUID: p6fCyDuLqvzHedYgnmNE4xceiu75GfIR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDAwMyBTYWx0ZWRfX7F3OnKsQxdzz
 0YZ364+RaxPj+0vxiZaCEm5PPP5fF6oA3Awk6a0L3f4hkl4xJDNFUbrJpXsPuLtF8lwe4trC7wL
 CJl1+tWXiGSC661PFvlIV6pN0dPZ+6ZxyFCbswcsxLw2FTy7HQmc0AuPQHnG9k4PlIYVwL8JFkb
 54aY2x5AixRbjyPoS3WeFXdkt0PgdQLoIfsa0QxXoZ6KGFH7hET6U8GtEUJDVzBymNVTRsXhDNF
 r6Uk4qbzsCw4GSOvS4Fa5eOjPu8QYbk/901NHx0w5JsSUrjTNoShb2Y1P6Rr/NmBRRunvMqnb6r
 3aFtgnYV0Iqsv7+h1iTw8q+kNi3kY3pQcbX+mNW2kdocR3wVBwp3VGE1l3ZUKQwpwyWLh7YnATc
 b136rs4b0OCV2kCPDwzr4j0hXpYkKv+i95XbL9T7HavmOqcgCZVWbrRqvyEaab9VzMNZbIbv0gh
 NEvurXz2A/Zxxr5NfaA==
X-Authority-Analysis: v=2.4 cv=ZuPg6t7G c=1 sm=1 tr=0 ts=69cf0b82 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=dVseYE-P37VojbQfzSsA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: p6fCyDuLqvzHedYgnmNE4xceiu75GfIR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604030003

Add the RPMh power domains required for the Hawi SoC. This includes
new definitions for domains supplying specific hardware components:
- DCX: supplies VDD_DISP
- GBX: supplies VDD_GFX_BX

Reviewed-by: Taniya Das <taniya.das@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index 19849703be4a..f5ae2a63765d 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -102,11 +102,21 @@ static struct rpmhpd cx_ao_w_mx_parent = {
 	.res_name = "cx.lvl",
 };
 
+static struct rpmhpd dcx = {
+	.pd = { .name = "dcx", },
+	.res_name = "dcx.lvl",
+};
+
 static struct rpmhpd ebi = {
 	.pd = { .name = "ebi", },
 	.res_name = "ebi.lvl",
 };
 
+static struct rpmhpd gbx = {
+	.pd = { .name = "gbx", },
+	.res_name = "gbx.lvl",
+};
+
 static struct rpmhpd gfx = {
 	.pd = { .name = "gfx", },
 	.res_name = "gfx.lvl",
@@ -622,6 +632,33 @@ static const struct rpmhpd_desc kaanapali_desc = {
 	.num_pds = ARRAY_SIZE(kaanapali_rpmhpds),
 };
 
+/* Hawi RPMH powerdomains */
+static struct rpmhpd *hawi_rpmhpds[] = {
+	[RPMHPD_CX] = &cx,
+	[RPMHPD_CX_AO] = &cx_ao,
+	[RPMHPD_DCX] = &dcx,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GBX] = &gbx,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_GMXC] = &gmxc,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MMCX] = &mmcx,
+	[RPMHPD_MMCX_AO] = &mmcx_ao,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_MXC] = &mxc,
+	[RPMHPD_MXC_AO] = &mxc_ao,
+	[RPMHPD_MSS] = &mss,
+	[RPMHPD_NSP] = &nsp,
+	[RPMHPD_NSP2] = &nsp2,
+};
+
+static const struct rpmhpd_desc hawi_desc = {
+	.rpmhpds = hawi_rpmhpds,
+	.num_pds = ARRAY_SIZE(hawi_rpmhpds),
+};
+
 /* QDU1000/QRU1000 RPMH powerdomains */
 static struct rpmhpd *qdu1000_rpmhpds[] = {
 	[QDU1000_CX] = &cx,
@@ -796,6 +833,7 @@ static const struct rpmhpd_desc qcs615_desc = {
 
 static const struct of_device_id rpmhpd_match_table[] = {
 	{ .compatible = "qcom,glymur-rpmhpd", .data = &glymur_desc },
+	{ .compatible = "qcom,hawi-rpmhpd", .data = &hawi_desc },
 	{ .compatible = "qcom,kaanapali-rpmhpd", .data = &kaanapali_desc },
 	{ .compatible = "qcom,milos-rpmhpd", .data = &milos_desc },
 	{ .compatible = "qcom,qcs615-rpmhpd", .data = &qcs615_desc },

-- 
2.43.0

