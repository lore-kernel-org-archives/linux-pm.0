Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8F0376BCC
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 16:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218727; cv=none; b=eLyLLaEJbDF8HeJeUV4Hpt4EptUP9RJhTfL9yNkWhqW9UwoV0yoYQBo7kxdlLR64M/dsRPFLXiHeo1RoI0Gje5c2DlVn5LaZ/AQq5XrAuqrziVCVL8zTWVsewJB7dEBdUVAT3Mm2wmpBNmFgJolGdBjRW2lpZjdPLLAhIEOUTY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218727; c=relaxed/simple;
	bh=+a2PwVdZXIN3LhIMygJSk6N3n7PMH7uL5OC0qbZNTaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rEZETTJz8bwNnH3adhxMKPaERPweY7rxVzHw+vowliJoeS+e/BPFyY8pgR8XOE++i1/DNjIMlP65AaDERBHN2KIaDYyxa8rM1f4fVntG85H2fl5K/ZMwBHcYuyCZdyD0XLKxz8cV5DW97ex3rVH8slYag32Us1JblyfqlP3dIzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GYgQrQs5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XhaOaOVi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GYgQrQs5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XhaOaOVi"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDJnQP2734537
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 16:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bxz9ivOcsV3K3IoCDrb+Cf/SPwDvUEWG7a6NEPjdfs4=; b=GYgQrQs5ChdhQ7ok
	ReS1TaxAQ007HtFnLTqhwEoCVtxQ379eB+DhXh9+EyB3WcpPU8tjWydTQzd+WbsY
	oiOz6wf9BlGenF6QpKTBp8JUVF9NoDGQqQuTd9c0WQtE7aytueC2hYjZ0TSxsMfp
	Ozzxle9TRnByuUSVxKviwTCqzC5K7FDVPlYrgiBBroOrgoyzJSTp+ap8dP39G3TU
	1NXC+PRyxXiNTIHaT4LNz6d0jqJEx+ls3OwkWOlfWekpRFvkJDXWnT0BgQp5AcFC
	Jy4dP07WLACoVYkYxhQXOHrsm/d7UTtWSYKzoVrsdCwFil2gdAEukVqJpbl477qr
	6UfDZw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fevkv1ufx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 16:18:35 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c0e702df8so73410071cf.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 09:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784218714; x=1784823514; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bxz9ivOcsV3K3IoCDrb+Cf/SPwDvUEWG7a6NEPjdfs4=;
        b=XhaOaOVirVTmHSvtqz1CtenSVKzu9MKFKJOlak7pC1aQuBWiY8JEzSNFz2I6pdZRMA
         BicfDiZOQrPhRjuP4qQgjvCMT9hji/FFUAUJDIGf7pebbtZk2/2lLkoAI7++cWDabl54
         EPkSd9aNGVVQjHjeITWQJSDHFGinJBoDMu43IakV35rHclbNOQWGKBKXDm+++TKNnHdE
         iEciAzKMi2CbV7dtZ8SX9ptwJVztoZxrbhEJcDuwRWxVCHK5mZCKsyO7AYf4gGkjohgU
         gPtd1bYH+48PncyWGUWluMUNNxIxl/WeNgfkT3v9oTj+1ncXmRzfwtBa26+1//JVO81U
         biTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218714; x=1784823514;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bxz9ivOcsV3K3IoCDrb+Cf/SPwDvUEWG7a6NEPjdfs4=;
        b=Qkl0TEP69fdA9mD1ECvzfOGyd3je1N9WsUMIY6K6gHfpZabp8wbuAdGwdlJaC/f3Cm
         XaE9s46tqIZwaPXGEtj1aJtReHHFuS7hS+OE8D70HaqxTwYcz1T2ahjy3ln08Rif/RPG
         FZ0s3FZqF6ekcsZIj9gcd487uCVFhGU8+pmOYCZsowPh7MpeqJx/hReY3PU+c0BZ6lJg
         2Th13NKwc44VXOpqgvry2tiH+p8U4lc6TVp6uHO1dZEBhe4WJkGsZC+FGT2KXFFpSRVB
         LIraX6YQgNjgfYSNsQyGjENKu7bk5u1h2P4TZAoCMk9q5VkFPHJchIYwX1CoEAfGvRiS
         duHA==
X-Forwarded-Encrypted: i=1; AHgh+RrN7WmohATocF5Vkpm8MqTUFl+puiNA+bja5gxWhrCjPEmGvIR8dG0GJ+kBGrkASOVqzJUr4BWH8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDR0CMkQl4y5W/6dYkfwCouszPs+yQPK+lm0mn3JHHro1AzF3S
	qqxFZY3JFSC3AYfnFPwpwF0RXZ0yYuXyUjE9vgUgYeXpiA/Ma/hOo/6r7fihgtwPHCkWtMGspWS
	DkMs8qbGCkBtcM+gzqoCoTYojj2raypaz7sxEsTvm+v/OlmhtASOV/qoMvPh6aA==
X-Gm-Gg: AfdE7ckhedXeioV21v8FdMis96qjz/QmjU0ajr51VJod8qtk/rXFtsnFv+NXDYsbvJl
	TgHk7vhUVhtBsYQHpupg+P3LvxDIiRnX5fIubdK4rA8sGI74S7iHiZiJQYHKIg+ZddOYZO/OOhV
	4IoKd6xGayR2jPIGqUkWygEQXitQkZNR54THuWBuK65kDcxueW6kZMeNuiDLY0/QrIVCUkI24gt
	oZRTbaPjrAZtNQxb+1GgHlwrrkCcGszJJWskXK8Ve68pLs5o5qIsvSh6m1ZMH4/zZRTNxt0EyTQ
	1SOCNXSorwlP/0AxCB/3rSDofAz4/6/RbDInH5reDgyvqz59xV7TqKUTJUXDqfRRkNAQ3r6FEw+
	N0swuYq7f3xW5Xw2ZlBCIR0rYmd47K6/PL+PqsFhd5vCgWS1SBYfWgEF+wxE/Jys9bDsBlnwhaL
	wOZbT2PhZhdu4/UmeAak3S39XPkGPiqEeV1q9vtmCdrpMgtkZX1nU=
X-Received: by 2002:ac8:7f13:0:b0:51c:7b12:5fde with SMTP id d75a77b69052e-51e42497dc8mr115018431cf.74.1784218714315;
        Thu, 16 Jul 2026 09:18:34 -0700 (PDT)
X-Received: by 2002:ac8:7f13:0:b0:51c:7b12:5fde with SMTP id d75a77b69052e-51e42497dc8mr115016901cf.74.1784218712393;
        Thu, 16 Jul 2026 09:18:32 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bdddsm257262866b.48.2026.07.16.09.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:18:31 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 18:18:22 +0200
Subject: [PATCH v4 05/11] power: sequencing: qcom-wcn: Report power
 controllability
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-monza-wireless-v4-5-9b02e6f549d7@oss.qualcomm.com>
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
In-Reply-To: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfX84WHysd8P29x
 UN1euVq/KkpidWOUE+h24BLo3BbHmnpeJ6pxflM5yv0zBNbYdRsc8nBEeAyG+jY4HbOUCZOTpHF
 urP3YyxKbpJLr1TqG9b/MowVwhNHzpezW3rSBqYnOH/6kxmxYdZGYtLn247d8XsMWMClXqh7zyG
 c4c/Ct/eyVKrS4kZOzJUK6Xa/JLfyJvOnfNQmXn7bV8RRbeKTtT/dqZUHmZoQ3ORLWJGS0NbwgW
 Da199iCREqkSlV4bUYw6AwiPyLE8HUr6ntU1EqEpnvwwl+2vJEGl4bs4vhDUVCQp8JaJbyFt0HK
 /mFgAu/WvBD3JYiM94xhiFI7yIIHQN2UhOJTY5HrjPUvy7IlWQQTzAg611hBpl7RDWXs41MdNCt
 n5/j8xAZlXfpNgtatYMTHG/AGNipwdPgtS+HZNPyaUeAx6I97VGiv37iAblXdu6WlSmFKmXowpF
 C/Gh5b26eH2oK+sWXsA==
X-Authority-Analysis: v=2.4 cv=WrEb99fv c=1 sm=1 tr=0 ts=6a59045b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=QWuo0IUDA92h_ITipQ8A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: itU_Bsc_O4pQaAVV05lwhbi6dJsPzI2B
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfX9omgFiW0fKQU
 9RBl7TcjlA06Dgkb+aL8xMgz3h/RcqS/9nyW7oBvnrIPS8nSSibMtgJoU6GQi8zWWElp5JJ788Y
 6S+L2v9IsLn+mDkDQPpyTWttl0WxhOM=
X-Proofpoint-ORIG-GUID: itU_Bsc_O4pQaAVV05lwhbi6dJsPzI2B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160166

The "bluetooth" and "wlan" targets drive the BT_EN and WLAN_EN GPIOs to
gate the respective functions. These GPIOs are optional, on some boards
they are hardwired to an always-on pull-up and not routed to a host GPIO.
In that case the corresponding enable/disable callbacks are no-ops, so the
consumer cannot gate or reset that function on its own.

Implement the .is_controllable() callback on the "bluetooth" and "wlan"
targets so that consumers can query this via the pwrseq API.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index b55b4317e21b626e050e022648147770ca7f386e..19b51c94653b7f8e7e1f5a2fe906c0cc1cd46aa8 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -184,6 +184,19 @@ static int pwrseq_qcom_wcn_bt_disable(struct pwrseq_device *pwrseq)
 	return 0;
 }
 
+static bool pwrseq_qcom_wcn_bt_is_controllable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	/*
+	 * The Bluetooth enable is driven through the BT_EN GPIO. When it is not
+	 * wired up (e.g. hardwired to an always-on pull-up), the enable/disable
+	 * callbacks are no-ops, so the host cannot gate the Bluetooth function
+	 * on its own.
+	 */
+	return !!ctx->bt_gpio;
+}
+
 static const struct pwrseq_unit_data pwrseq_qcom_wcn_bt_unit_data = {
 	.name = "bluetooth-enable",
 	.deps = pwrseq_qcom_wcn_unit_deps,
@@ -218,6 +231,19 @@ static int pwrseq_qcom_wcn_wlan_disable(struct pwrseq_device *pwrseq)
 	return 0;
 }
 
+static bool pwrseq_qcom_wcn_wlan_is_controllable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	/*
+	 * The WLAN enable is driven through the WLAN_EN GPIO. When it is not
+	 * wired up (e.g. hardwired to an always-on pull-up), the enable/disable
+	 * callbacks are no-ops, so the host cannot gate the WLAN function on
+	 * its own.
+	 */
+	return !!ctx->wlan_gpio;
+}
+
 static const struct pwrseq_unit_data pwrseq_qcom_wcn_wlan_unit_data = {
 	.name = "wlan-enable",
 	.deps = pwrseq_qcom_wcn_unit_deps,
@@ -258,12 +284,14 @@ static const struct pwrseq_target_data pwrseq_qcom_wcn_bt_target_data = {
 	.name = "bluetooth",
 	.unit = &pwrseq_qcom_wcn_bt_unit_data,
 	.post_enable = pwrseq_qcom_wcn_pwup_delay,
+	.is_controllable = pwrseq_qcom_wcn_bt_is_controllable,
 };
 
 static const struct pwrseq_target_data pwrseq_qcom_wcn_wlan_target_data = {
 	.name = "wlan",
 	.unit = &pwrseq_qcom_wcn_wlan_unit_data,
 	.post_enable = pwrseq_qcom_wcn_pwup_delay,
+	.is_controllable = pwrseq_qcom_wcn_wlan_is_controllable,
 };
 
 /* There are no separate BT and WLAN enablement pins */
@@ -281,12 +309,14 @@ static const struct pwrseq_target_data pwrseq_qcom_wcn6855_bt_target_data = {
 	.name = "bluetooth",
 	.unit = &pwrseq_qcom_wcn6855_bt_unit_data,
 	.post_enable = pwrseq_qcom_wcn6855_xo_clk_deassert,
+	.is_controllable = pwrseq_qcom_wcn_bt_is_controllable,
 };
 
 static const struct pwrseq_target_data pwrseq_qcom_wcn6855_wlan_target_data = {
 	.name = "wlan",
 	.unit = &pwrseq_qcom_wcn6855_wlan_unit_data,
 	.post_enable = pwrseq_qcom_wcn6855_xo_clk_deassert,
+	.is_controllable = pwrseq_qcom_wcn_wlan_is_controllable,
 };
 
 static const struct pwrseq_target_data *pwrseq_qcom_wcn_targets[] = {

-- 
2.34.1

