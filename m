Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D335483BFF
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 16:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787848729; cv=none; b=LS9Seok6SBXkYSNDHDMMY34O9Q+dOSDeKlEKwDHbaySoQuSJMrib0iQzSDEIZgJoDr8bXO26svrxJpJIh+rYrO5Nr0xUSAsyEOwSlIomvwje751Xfc5j2YOavVWjosdwT8GOdt2+w2YkQsXYUPIML45T9X7xjhU6zQP17lW9TUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787848729; c=relaxed/simple;
	bh=k/DT6AgKWqS6ku+QAjOs6ZqZtSg8uMTVP2+zB+uhR9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ncE3NXSZNrWmAts0gQIauDIHdZMz6sbAKX+xrnrPUfUESjSlvIFSuE2ht8mfu2N20FykaqGxLL0d7wLXTavOD59g1AXQUQWQFu1pf51QzJfoD2/XraojLDghonHFV5lGqisl4rvPA2eC1Rn/XZ+uz9n+CSyoE2P5Nn7XcxeyCnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eRQcJWgy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V0iI5C3A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eRQcJWgy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V0iI5C3A"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RFbpSv3921247
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 16:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pHKTpe8pp9JpvuVxGFlRJsbq12DvNmufk1YkffXJuU0=; b=eRQcJWgyQYtV2xZI
	yHR4BID99i5hoQ8obVhpLKRNZ9dqwYwyFIT+sYdFhKvut/L/mrFeU6BAuAs6w6TG
	ujzo6Al9eBiewii2QWAEu13fAvoQPikO+7B34R4ZuBySNRVbeDbV5Os7/Ok9wzg+
	orzpoizxIJ0XohxllZZdWQ5gUENp5knYfKE8hyi41PsBLUtjdVsPG+U6EIl/vgAw
	11JylrytQlKR9AiuHbYESXdKW4E16yShf/8IRoRLtA4bDFsKT1PZ6kO1Z05qMf66
	yBqRkMCgKVJuNs9xDZMfbv4XbFOgbDuvSOLglCwPScmOsYgK7zwnNF7E3E7m8eC2
	/nKwFA==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gaphw0nm4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 16:38:47 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4b1bd347d5fso167952b6e.3
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 09:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787848726; x=1788453526; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pHKTpe8pp9JpvuVxGFlRJsbq12DvNmufk1YkffXJuU0=;
        b=V0iI5C3AP0Tpw/TfnvzXBDTxuFzNo6ecHRs1w3j9IzDIAJLbQ+JR9CxhYnaKQlw2q8
         xgIiNsG2H4U3fJ6ePi1VLbO18KFK4f1FUxCP31HI/c2XOQADpPA/gId2hyLalH8NHyVj
         Dw+ytybIzFTQeYTnzPLkEKGgKgJ+MkmYDcfim69pYDR2Hq7C5EKS4b1TTiqzOMozPLEq
         KAxJRAEA+3yErX0mh9eJaG7SaBbe+4yvOVaNBJrlKqG8azy7mxezx1R3Ni5gIO6X3wgS
         UhCwErGI+fHDw/mZm3n8TvIY0q3Nu0kRU9yfMBtBaTXTs0MlwECgxjxcU+e6UbRFki4i
         aSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787848726; x=1788453526;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pHKTpe8pp9JpvuVxGFlRJsbq12DvNmufk1YkffXJuU0=;
        b=fx86CEzN04c3LrhMZQDXYifG3GmlJqq5H3DJdAI1Re5hco51lGI4pzKG/cBFRDSkSj
         UHZCOLE5PdUSkufMR/aGw2sbt05rBS+0KFxvq4vzZmbEVvV56x+e/ODnH8tuObFyMrEW
         JI0+yeOIQF0rciHRAy35gX4slmr3w4PIx8ZPnddxYYImv/qAfFqY9Y6YjoZxlaklNUDx
         geKIPox2tQi5sK15vs4Mz0RtRsh39qqKHUP5Qv1UxgjLoWWG9koxJaefYB0KwTHF/FLN
         sKj3bwes23K8/icSvCiSytl62wPAIJbhIEvrgXru95LTE5+EbDbSzhTdo4n9DEfvhPlG
         /aPw==
X-Forwarded-Encrypted: i=1; AHgh+RrNJsahYVwsB6/ylCU/HleRKDvWrs3q/LT9zb5DatJ3WjBb4zzm9VyJ+J1Xqh6RhxIO/S4E1YZp6Q==@vger.kernel.org
X-Gm-Message-State: AFuF++lI3cpDnvAiCq5aR4sKa6P21xYiFYMKHSbwmDewfjeC3dqZEm+d
	m0pPqhMCQro2L1D2ErRMXiHaAhHkp5XHQX0ijNdM4Rasea4fGqx+kECAi+tJ2qyUWJwCTy3IOu9
	khpcO/b6+sYxSsETzERhDORtlrOA0/hHtmQeehdHLPB/0ohH8DlhEfpxxxzLjGQ==
X-Gm-Gg: AR+sD11vi/Qa7dB8t4KZGoqr4WcKQvIkXHsLV2WmGws5MCXKGnGLY5YKptDgmthAIxt
	xzhOqUmOelQwfoUPsc+AGeiSeIfhA/d1P/Q4B9pI1UHqos8QHhdTMD6E7TyiSKfQxobEFsqiZ+z
	0jiR7F5OCRTyxtPE8ijiAR/E4AvuiC0wL8kYixSiYm+nTKkqnLUPlwvuOVXomFxwL5HxCo2wd4H
	rEGbpg6mH68Q4d4WX8WairEkgy1eEiRQR2HZbnnmc2DKsKh2gsT4eOnYdYtIMBtW+aRKl3ixPw6
	opkgtieaBtNnq+4WLZY8nIc1uq6ZgUNdJ8g75fpbqbryjfeH5LhOKGVtdloGaq5XMbZJO32Xjff
	5X8LoeCFgxOjnYE8XA9lk62AJW+1TmVNgzpyV68+sEKPxPbttKneJdBmIYK4BQVVdzI7YqBUyam
	37kG5bXvxPERZZwuOtFIjohwo=
X-Received: by 2002:a05:6820:2917:b0:6b1:afca:5c7a with SMTP id 006d021491bc7-6b1afca5cf0mr9495087eaf.28.1787848726599;
        Thu, 27 Aug 2026 09:38:46 -0700 (PDT)
X-Received: by 2002:a05:6820:2917:b0:6b1:afca:5c7a with SMTP id 006d021491bc7-6b1afca5cf0mr9495017eaf.28.1787848726154;
        Thu, 27 Aug 2026 09:38:46 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1a24bce78sm4253171eaf.3.2026.08.27.09.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:38:45 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 22:08:04 +0530
Subject: [PATCH v4 03/15] pmdomain: qcom: rpmhpd: Add power domains for
 Kuno
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-kuno-soc-support-v4-3-dd34f235fc1a@oss.qualcomm.com>
References: <20260827-kuno-soc-support-v4-0-dd34f235fc1a@oss.qualcomm.com>
In-Reply-To: <20260827-kuno-soc-support-v4-0-dd34f235fc1a@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787848688; l=1801;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=k/DT6AgKWqS6ku+QAjOs6ZqZtSg8uMTVP2+zB+uhR9k=;
 b=WcRc3XN0592xfhq/gEJAYqLJiKdvU41z4BnWHFvcpibh3Ovwl88G3nYrLj5UB4VBR25kKg0K4
 /fCTuWsK1QFDOsWOQSOb4Z8mLT5MmzKqrkUZC8OayHdKlLMwXecetSc
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-GUID: IHwISQUwhzNBv-fs5YfShQPxsgyirq3l
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE0MCBTYWx0ZWRfXz9+Ars+TWU69
 h90EyfTbaFX2U3o5q0n4czs1EXizEOYGPdoFHj6YWVUpSV6nvc1oQ+Y/XznqYVSbq8ksIL8JBOT
 uvnloE1L6rsqY8czNYaiYN06oFZR26g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE0MCBTYWx0ZWRfX6DhDOa+volzq
 nDqu8OGr0dERBM2PNM4+Y6oPus84j13ULNB8eCZ8Vdz0UtjNbM5lNSE53brbypPGXrVbOdxEVhu
 UikqoH/d1vbYOKG9BX6VH3v0YfPW8GVWyQgymYv/Puo+tLiIxsXQCtqEZhGITaUBsFSqTuA25GM
 +f2+PrEBeWvceXo83f8IOMuXxVfZMRava1aEnVDWLlT4sdk/6OWLe/mymNVIOVYJQuKTPduV1tE
 I62vWMzGT1/aCdeuOOIjg1R1exu37rppfmD54QqFYrJkM0hSzHUEA2ITnoxDOEyLN9ZaR8NCmwO
 9wCic/urf1acYWKGW6KtaYzhqIA0X19oGGDSxr4k7WCtGtZ9F1zbs1gBEymNIsurdLbKgYurpEV
 5CG7OAOR+Pj5WH6FXEFBkd+Go4kZ39vduGrziEvSS0YAlK8WeNjf8e1IwjYfslze8s2gVfdMqkA
 UjcwVVYQO9Mhb7AYYTw==
X-Proofpoint-ORIG-GUID: IHwISQUwhzNBv-fs5YfShQPxsgyirq3l
X-Authority-Analysis: v=2.4 cv=E8b9Y6dl c=1 sm=1 tr=0 ts=6a906817 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=1FmER_HI0FvT1hCPThAA:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270140

Add the RPMh power-domain data for the Qualcomm Kuno SoC to enable the
new qcom,kuno-rpmhpd compatible to expose RPMh power domains. Kuno
exposes CX, MX and MXC domains (including always-on variants).

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index 90743275942d..725ce802f683 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -681,6 +681,21 @@ static const struct rpmhpd_desc kaanapali_desc = {
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
@@ -885,6 +900,7 @@ static const struct of_device_id rpmhpd_match_table[] = {
 	{ .compatible = "qcom,glymur-rpmhpd", .data = &glymur_desc },
 	{ .compatible = "qcom,hawi-rpmhpd", .data = &hawi_desc },
 	{ .compatible = "qcom,kaanapali-rpmhpd", .data = &kaanapali_desc },
+	{ .compatible = "qcom,kuno-rpmhpd", .data = &kuno_desc },
 	{ .compatible = "qcom,milos-rpmhpd", .data = &milos_desc },
 	{ .compatible = "qcom,nord-rpmhpd", .data = &nord_desc },
 	{ .compatible = "qcom,qcs615-rpmhpd", .data = &qcs615_desc },

-- 
2.43.0

