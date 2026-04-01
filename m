Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB717317162
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775034944; cv=none; b=a+M2T1XOWM6nqgRkKih9efrJzFFVZBtZBsb9XQvlp2Xc1JlGMNuFGiU0/0+kkRQULKSQpyhxqY48t8tSZ0mnG3KFVn8/BA8jvCjHhfJpykXbOa7sFQ7dcTDe+uSRGwIOaNrKl1rJYhzWMR/7mWrwPrPRx4gWHriHIIohf15mnwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775034944; c=relaxed/simple;
	bh=APuuIh7qWlz8tdIYOeZlKUL5qGMFu1PdIThmuY5MMbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gGToMrVXInfSGSZN+o/dtDzT2WJmkF7pnEOim0whGDDK516XiUqzqo40ogD6eQZXK7vNh7UoKHVkqZABjX7kfKsxFWlC7CR0tT9ArFC00mbyKQNdXsSATY/Cd2eZ0v9wvx4bVHETUj976X0J+8uukf1xMwqwpiw6PDO1hlwfvDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tu6ekNw6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iFJArWY5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tu6ekNw6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iFJArWY5"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6317ggBO3081367
	for <linux-pm@vger.kernel.org>; Wed, 1 Apr 2026 09:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	93pVvA59u5/k3Yn2i4LwAPIjV2KJULo+YG2xUrqVs94=; b=Tu6ekNw6Hj+qtbxK
	pIHNyG6yTzwKtf9F+w5nnfRyu1ih0YwC2VSgX+XIJSwR3LmsobJuj/4guy/3DlyD
	iYX7O7kCX4qvKg9r+dYNCX+nOIZVmdjNGn+S+XVn33kpYrG7NkTZfEcKcda/U6Q/
	1qMCUpEvrrYlb6ws3C5X+mlPLVePWxqllS46sgGhkAoO6VvJJdn5VR88bQlBHz9g
	ZxEzr48sLVUtULWKNt9qJ02UHJ/APV1qsOC165RTMsPTqFlYUutal6hrT6O/NlHb
	l8P7KcnOQ7cYuMp9J8Og6ehpimfhzYSxKyVayla78xlsbsncH+mZkF9ly2u8S68n
	J6oRGA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8kdku8ta-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 09:15:41 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-12721cd1a2aso7098207c88.1
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 02:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775034941; x=1775639741; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=93pVvA59u5/k3Yn2i4LwAPIjV2KJULo+YG2xUrqVs94=;
        b=iFJArWY5YM5Iq6bQR/BhtY84Sigg9Bej6yzL2ZOPqy0V9DUew4W+/s4eSKS4wwapBy
         6Z79+KMH5k64/1x8GmSDK15ods4QZJZi91BJvnjVMQ+SaeXbvx5pzlnMYV4HjBEsmTMP
         MhQyoSc5DeqozUNDN8fo6rUgsqu5YeYSl3Gvi2Oku2BRBEvXbyCM4EixDTa8oL2O9u2b
         fGnqpz2KGnYODe2IFj8F42kKDdtVK9o7zbr9zEgkMufOY8sgP9BtOmFaoSoG16jbTSr5
         KCj3bLawfX+tBWeGqWDj9tZUrSpIMXM9D8JXg0ORv99ndPAU7ZDp3I6x9kF7iRJByx2M
         pqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775034941; x=1775639741;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=93pVvA59u5/k3Yn2i4LwAPIjV2KJULo+YG2xUrqVs94=;
        b=BAXJTmxBn0UVYMeRL/R8O87zlZNBDrg66rlCbWj/8ALsZPBv317JVPJPZjteypwSl5
         doPIiwOsyTEQy17lkKJBYCW6G+5ZKuoxQeuI4csjW8hneefj5oKnmdyDtTHFzgk5Nqas
         oYyisoRUt9wLCL3QY0ZPy+y9G2VHDNKbV0x/Dd7BjkNPDsy7EGp2eLt8hr6soK302/1L
         eZ2CwbBRdWM2QmO7SG//oZpCY86AS+DGC75a9zP1iA2M4qfyySExRA+04h8/5C0LJLlV
         hkD8YrC4Pnrw5mnQvpNcmwf+p3T67CCoGAS7mlEJnzjOHdOEZOPWmzB9b/kq4JYisLHx
         Yx9w==
X-Forwarded-Encrypted: i=1; AJvYcCVSLbnRwI0qGg0tKKLD6D1u0oSwg9X7vnReiic0SYECiYZ69OoredCAeT38f7Zi6UtUYrAu0OxDwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQMa51HCk03dkUNAd+I6ubBHYvDrvFfJHRLj0chWBL50WjKs0p
	vTx+MRPPvu0VG9cn77yIJ00m5t3+cqAB0y0AQgv3fb8Q4/ooy/9PpgYES1JyV8DJF8k6euuvy6w
	RjwYnBdughKaiT4MEqYxH1/MVXWuLZ30QuveQM+WdhdxL7HIcPzapEKsjZHKBnw==
X-Gm-Gg: ATEYQzyQi9lt2sZ9yUkPP9TUgQCtlWT2/2ApWmDBaOjuIJ2VbYEJqjBr8ML9RwKtoyf
	KAWp8s351Dz7Hea+ze/Qx/C+t7GKISWYemwXvDJVX/U5EgUuG+EBCl8fYaLWerZH49xWtsQayCT
	MA4G+S7MEA/GWdoAesfuP9rRq/kkaZTA3ABV7BNCfgSFvj8ujecLtHxKRcomLop7pyxfAWbhhJH
	aQEGh9TAqazCD8kxacXbsD36SuM3rDF50FhcPB1kZ1sVbHhNHB5iX8wS2C/l9BV/zqJXN3hI1VA
	uqk4ggI3n8Yt15huuYr2X5GpOPW/bzm8iszR3UtUGok6MXOAxgAhCD9IPBFi+uFx3Jj5PN9LEvA
	U/QjOkCjeojq3pu7SFV4GU5NL1MappNC9p9YH92W3cpZmIJWe0Es2KK/98LonyMOLZ655slFLzQ
	==
X-Received: by 2002:a05:7022:e19:b0:11d:f440:b743 with SMTP id a92af1059eb24-12be642068fmr1496454c88.7.1775034941104;
        Wed, 01 Apr 2026 02:15:41 -0700 (PDT)
X-Received: by 2002:a05:7022:e19:b0:11d:f440:b743 with SMTP id a92af1059eb24-12be642068fmr1496427c88.7.1775034940546;
        Wed, 01 Apr 2026 02:15:40 -0700 (PDT)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97efb42sm18285025c88.7.2026.04.01.02.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 02:15:40 -0700 (PDT)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Date: Wed, 01 Apr 2026 02:15:31 -0700
Subject: [PATCH 3/3] pmdomain: qcom: rpmhpd: Add power domains for Hawi SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-haw-rpmhpd-v1-3-c830c79ed8f9@oss.qualcomm.com>
References: <20260401-haw-rpmhpd-v1-0-c830c79ed8f9@oss.qualcomm.com>
In-Reply-To: <20260401-haw-rpmhpd-v1-0-c830c79ed8f9@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel@oss.qualcomm.com, Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-17187
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775034936; l=2403;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=APuuIh7qWlz8tdIYOeZlKUL5qGMFu1PdIThmuY5MMbw=;
 b=1VIgSXBOtnXEnj2kWIdbj5kC4wpDRhhqKGZJhcLnrAnc2gAnOyN3I8Ti3VO72yOtzhidYUPS0
 CcwzSGGhc5sCgaPlYpMQybl2d9Igk98ClC0wzPmNPs6VL4bp1CIjk+o
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA4MSBTYWx0ZWRfX27qFdslDbnQZ
 qsbF8b3O3N8RQWyvUpZhYLVnSHLdQMbMjqZ0WNKqhIOnTN+q1gr6KPLLB5/Y9fiHLr4h0RxnGk1
 m/MPCMrWNk9feWrbSsfm9ryeBce7tB/mOI9USPz+GmwThXrX0VYRWxgqXUNqtWpXt+klDiuPwi/
 +AGsGG3OZE6Jj4ezbDdMpO9Yr0x1ToBOTewVMI/8pKFGhx66yJ4v4d+5mbBydlqGCVjGfO/Tw9D
 Lu+DjhBit81VSkqZryCjCNEVcPTTwPFagko36e6uYWgZxtLP1xt+Ex2F3+HQhVr6uv7ksvsunli
 viJieWBCClfPI774SCTUPgzJQgQ3WFipCGlbxRpE8E3AwdPiDOk4yENo0k5unk0YoiIDXNWdwj4
 GhPovOeXRPuurzUWpIN4iIfzuwQLlOyannCQ2B4PBcAJguYOiqE0KU7QWBVVmDvMaNd6sNaYN60
 nsGAYaHxAQRHcILhazw==
X-Proofpoint-GUID: PRznVNUVIJonPd3lMBvwmWgS5X6wTqYW
X-Authority-Analysis: v=2.4 cv=YsQChoYX c=1 sm=1 tr=0 ts=69cce23d cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=dVseYE-P37VojbQfzSsA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: PRznVNUVIJonPd3lMBvwmWgS5X6wTqYW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1011 impostorscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010081

Add the RPMh power domains required for the Hawi SoC. This includes
new definitions for domains supplying specific hardware components:
- DCX: supplies VDD_DISP
- GBX: supplies VDD_GFX_BX

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

