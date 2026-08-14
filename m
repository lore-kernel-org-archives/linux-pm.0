Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439A840961C
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692762; cv=none; b=Y7/HvLPD1GEF2KNfwZyyH0h5w2qdSJu6Xpxwa1Ppbx1lcDWdfn+7uKyHJUVjoh+Xq162dcENvmHT3nvW0suaTzGh7v8oiEKPbL4CEXhB3AQqHX+y7xjm+jkEwLhFoOTnwmfpds2TSdoC6bpO73JvJW0ydUPntoFjoXAtX3pcCyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692762; c=relaxed/simple;
	bh=KipaZ7f4mPPcv70WXg+eNoIM2CY2fZVm54MKxlYcJC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NRHDc6TnXfMilANMesQJflUn1LR9ULAYX84zmGHzvkQt6h5WsYxLP/pQdLy3mpCPSKd8AysNO9sxLyh8t6nN+qvCY3uZgrM8yXqPRkpBGxqTTGvkP1+YG1htdoXbK+jqJeTWHVXESWWn5WNy+mr1+pmyZDOupOfpIU6Y1GXX/ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RUyy9rIn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EDjPtrET; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RUyy9rIn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EDjPtrET"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E4R1Gl594393
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dXlEBzajiJxYfo/PgAtKHciD8wbm1lPVA6bGD/VsF2M=; b=RUyy9rInWyBciczu
	D83Nts2aJ8bcd+uFbYRw88Ee82h4Mmc1YQ3LEpAFFt6Exb8viEB+y71OWiUyyBu6
	yczX+WWLyn7lMFIqGzrBa5n+572VYSlJ+8jPUQTN9vdsxqGtQG2OGEhchTiwQKSS
	pd/YVSYZvGfGUJV2FhqBV4Mk2PoE8mGA5fPFraBXYupkuebaOUQW/6TjfS/zJ3XZ
	oHnjCLvcVNbHwqqakxlquledZ0429PxmB+8S21s1h8pD3j5exzxLk/ETmmpXX5kh
	oVMPXZcHmHs7+Hm6JlTPDKsVZZ3Z1h+ri1Q86B7ls0S4AIpu2jmK2flOXTWvI7bD
	dykCwA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1gy4u8da-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:32:29 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84f0d3ab2f4so505081b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 00:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786692748; x=1787297548; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dXlEBzajiJxYfo/PgAtKHciD8wbm1lPVA6bGD/VsF2M=;
        b=EDjPtrETUc+84NuoeS1Wo0r88mMvEkDBOGMqHHlyOEdiAP6W8Dh/sS+RFm0XAMFg/+
         Ip6pg80q8OeMivn5aIwfIwdc6f4BM8ZoxLT1FW4iVQF+7zGiw1IKLPhRrZOUUohhFMtK
         6N9pPcDWauXT6sKSqXTsL3vpZEvjCL+yK7QcACJvEwDk5cxdW8ze+JePL0/9rZ+GUr4X
         FaDsmgplW+4D1k6HDu6NPSOUaXKj16ynjYdOOk7LXgSRDDgQ3zsZZ6znzeC8aYTD3R0d
         TYWzn5YXrNCou7xBw2d3H71CJYa7DyVguP135tOrhDS4mw3c1SjJ2NBQ0aor3i/KxgnJ
         UYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786692748; x=1787297548;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dXlEBzajiJxYfo/PgAtKHciD8wbm1lPVA6bGD/VsF2M=;
        b=DFf1kLBivvUjv13iY/1VPX5Q33F0E/Xny4ID8EAGU5QGHhM9AN+cyN8v20U5wKfmQ8
         867bY03zx32vQSj27OivtprhgwAtWfVWsY+wboNwUfhNRYgxn+IpNQluAy9GM9IZXEfC
         5CRP5pU4njzEVWrLGOg6d2GIAu1v/PzxSuaW/bmMiuwJM9AacegBrjzfHxhu81p5o3dU
         OT+O2krPOGKRazeIVWOBD0bDgBArYxCPc6+A3jHIvAm7BIeHnsasPABMW2wUdmA1TD/5
         cn7wcfZFlSkuslANwjqoIJk5c76G7ZUzUjI3VCc2pJb3fw5I2/Tabg2Nv5fxAmv+kBOg
         pZHg==
X-Forwarded-Encrypted: i=1; AHgh+Rr9CTvvY+Vv7dJ/1TOERfuLIeit7I2i5TyVnP29MBEOJbyh0WaiL0uTOeMXqVnTG5gZqXHSN2L+jA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwH061XzKMbUmP65aUA6X9kKx9y2NQYr5+Of1dGHtwn6bqvbiEF
	1htDSeo+VVWMrAlQ9PTbdIiTh2CfZ0fap4UiI8Ze/BwUFM/3wjZz4tR190fhsCwP/Zs3JAUAHq5
	MY+7InCQkq01r6UFwjUv6ACSes3thAeY+NCSAbA4SnU9BqzxPpi0xA1jBANpWCg==
X-Gm-Gg: AR+sD11RgufGh0+/Jg1TtB266tcQdvtC5Gg96gljg2gU7uBff5CgSl91ru3EoHIL0S1
	yrRiIVaYqdT/J26HZ1hRpiQ0P1JqSVjy2//fikd4/qBVa2Aq/aALPPD9VbDUZ0ihQVZwhTKfIRG
	bvapQUKCTGfdkt/xYpT8oj3lZKIh4G1zT5j4Z5tcZxtZXftHyQLIBdiRRscXnAde6KXPy1HxXEJ
	upZLlqMyMpjgw7uDCP60SshtswteTy73jbgZXUFWZynzkYOykI8N8mSd2Jzic4pGcW27c8P7+Y4
	iEJN3WDIIngybKzu+3Zt6kYtSvosuNmj50LXKIZkeqADzkBHu3ucXXo42lP1Q5SksaLiqY7gg7G
	HLkpjKJ1u3NwkGGTcmUGNv4BP5waXFLm2DTCsWDEA9MkQ6Xn29eRLdrcW3kp+d3irNsSwoX9N/J
	QlRVvcYzwRWosMZdSQMp+TPVg=
X-Received: by 2002:a05:6a21:3401:b0:3c0:b766:751b with SMTP id adf61e73a8af0-3cc71e1b532mr4325564637.14.1786692748123;
        Fri, 14 Aug 2026 00:32:28 -0700 (PDT)
X-Received: by 2002:a05:6a21:3401:b0:3c0:b766:751b with SMTP id adf61e73a8af0-3cc71e1b532mr4325510637.14.1786692747710;
        Fri, 14 Aug 2026 00:32:27 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea804233sm1062280eec.26.2026.08.14.00.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:32:27 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 13:01:34 +0530
Subject: [PATCH v2 03/15] pmdomain: qcom: rpmhpd: Add power domains for
 Kuno
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-kuno-soc-support-v2-3-3079794f0f73@oss.qualcomm.com>
References: <20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com>
In-Reply-To: <20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786692713; l=1687;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=KipaZ7f4mPPcv70WXg+eNoIM2CY2fZVm54MKxlYcJC8=;
 b=IeMzgQyVvcMMtvAxfcExuQ5BmxImJ7KS7ifwcfX8fgmRZDKNbKcdDGODd9Nm/GVl5P3uZaieX
 DJJyOyg9fskB33y4FAgAar4Tgob+7ECF8an3TdKOdsyS7BEsEj/4J85
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-ORIG-GUID: TVTHVIognXr-2BCNKgBjXyugUPtbowDI
X-Authority-Analysis: v=2.4 cv=ZYAt8MVA c=1 sm=1 tr=0 ts=6a7ec48d cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=1FmER_HI0FvT1hCPThAA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfX9+mCRdEAATUx
 3gNfe4TaF6/UZsH8V6AfIhfA01DSI6pUv12lrq3B1rrqoph9MuEOyD38OMjhWRhF939RL6zfL2W
 jyJllO8HF5MeOsoBL2DS9wvMd0wnlAw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfXwkthz+26nlLn
 JcCiTYRkuAKeBL2YbLJXO2lj90eMHrP4tVdBEwa/YpF4mRP37jo+ffzY7TMdznW//H/TnXUAP6A
 RSI9FccHlnbMO9iG19nf3R5jTtqhd3bzwgvrdgCyw1MwvvHQTHczWFKtMM4vJANakAGk1Ukym9u
 S95pwjuEoEN+N635XXobcBq6DtyQ/uH5bzgN+sgk4Xh1+9kLNMBXEFs/ggsyyp24a8RfnTtfxqD
 58dFi4yvjlML/0I/s6ZtTofBdmFE3Q8yzuMbdz782u14F5wRqyqX6rwUyL3kcLMYReVg7TxCDcl
 HOeTNHHAPe51Negd+hbJH/BMrPC0jDCVcfIS8ckVzULedV5Y5ZcVStSlH+Sx/1bV+WjSzlY/mbo
 of6DLdUAtORuzY0a7n/qWBIvbJ7Pj2XCNbwZasPUpZ19SWarQ6jxGISNEDnIfRH0Cn/1FvmwjIQ
 jebaHYFJfB32ADorTJw==
X-Proofpoint-GUID: TVTHVIognXr-2BCNKgBjXyugUPtbowDI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140058

Add the RPMh power-domain data for the Qualcomm Kuno SoC to enable the
new qcom,kuno-rpmhpd compatible to expose RPMh power domains. Kuno
exposes CX, MX and MXC domains (including always-on variants).

Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index 96e4bd2f5a14..3c7755735dc9 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -685,6 +685,21 @@ static const struct rpmhpd_desc kaanapali_desc = {
 	.num_pds = ARRAY_SIZE(kaanapali_rpmhpds),
 };
 
+/* Kuno RPMH power domains */
+static struct rpmhpd *kuno_rpmhpds[] = {
+	[RPMHPD_CX] = &cx,
+	[RPMHPD_CX_AO] = &cx_ao,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_MXC] = &mxc,
+	[RPMHPD_MXC_AO] = &mxc_ao,
+};
+
+static const struct rpmhpd_desc kuno_desc = {
+	.rpmhpds = kuno_rpmhpds,
+	.num_pds = ARRAY_SIZE(kuno_rpmhpds),
+};
+
 /* Hawi RPMH powerdomains */
 static struct rpmhpd *hawi_rpmhpds[] = {
 	[RPMHPD_CX] = &cx,
@@ -889,6 +904,7 @@ static const struct of_device_id rpmhpd_match_table[] = {
 	{ .compatible = "qcom,glymur-rpmhpd", .data = &glymur_desc },
 	{ .compatible = "qcom,hawi-rpmhpd", .data = &hawi_desc },
 	{ .compatible = "qcom,kaanapali-rpmhpd", .data = &kaanapali_desc },
+	{ .compatible = "qcom,kuno-rpmhpd", .data = &kuno_desc },
 	{ .compatible = "qcom,milos-rpmhpd", .data = &milos_desc },
 	{ .compatible = "qcom,nord-rpmhpd", .data = &nord_desc },
 	{ .compatible = "qcom,qcs615-rpmhpd", .data = &qcs615_desc },

-- 
2.43.0

