Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECAC3B2FFB
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536562; cv=none; b=rCfQqnEGZeQfPlQgxfCZwwWLg/ZAcJVCNP1OaeDajPwW9PCsL2eK/LBTvu3Y5HJQGgnhpnm1BHt/rOofHZ2afPhabvbX+3XJmTNbGWpImyjnCPAbPvdVnhaP4tTYa+qzcsUafVyHWQNN6Ie6FbC0tdAzF+X4VD/m/IP7kgRqvgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536562; c=relaxed/simple;
	bh=DketuHJTJ2AlfYdQleqI6+O28Z0Vk44wfCYCPKymfKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bo/SwGSt9qqGbrX2HrSA7bBtABD9y4CYJC3eg3b1VlHhAh8wOJSUECxU9YOZyWQx4sGt7qSZuVoQ2hfubITOWESNq3jE8OHdZR/gxRj9tMwllADwQxQKv4LRg+LOUKjavMMY4SuNrSUgy8ZgX5lR43gDZVLwyNFe6sy8PjrRJEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GbRXD4v9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MuKMUSHT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GbRXD4v9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MuKMUSHT"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684EiawZ3190607
	for <linux-pm@vger.kernel.org>; Fri, 4 Sep 2026 15:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yApsV8ek6sm1DDA8uG/ESAfoNPZgj9MCFK73tfFdH0A=; b=GbRXD4v9A27QZCV0
	IePXKo7wnG3hRuINtPA+y7vQ4hAhufw1eSbZGR8ApfMIJOGvE/CNtQZjUAoQrikR
	esR+cBp2gROES1vue+m9bq2TVfENRNJFfeVniBzvdefPPjvXH+vhH9fMNkueKtfw
	/GqAELUGXHt0/FKBf59Um+ddN1swEdGT92yG3FPap9uw3kjmdNZA6NTgMktDKxCi
	8uye4/AJfDuO0MX7ktD/bFQiqHMUiv9hDGPkpEiqm5zvS8zF29iLskzj96I00M9W
	mQntvqqOUAm9wQcltweDatgMRhJaB+0ZjsT6Mrxw7UI38ZHyWXJElG74sgTnSmJH
	CaPpzA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg010g8s7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 15:42:30 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-73883529f72so957480137.3
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788536549; x=1789141349; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yApsV8ek6sm1DDA8uG/ESAfoNPZgj9MCFK73tfFdH0A=;
        b=MuKMUSHT5ndCJdn1lpnW6Hop6zfnVCiw1NhWkqSTHI4OytO1Fb0PsCpmysQT26StXN
         4uKMGaXv7tDlHUT05y28m5er/bqGcUEnZj317WxenJteINl2Bz9L0lNzw+jIT1eik4Ut
         ndJ0qHdZgjetXcIVtCNAJQhfeZANoHWYmgpKDgz5FGFV/AV3FCaA5TEvst0xyc4Qqbha
         oynerrTuPo/6rf09bmZK9062SW+B21aO+ATpL46chbqN2ChM8vezcqLm5xqqjdLVUt7N
         SUpjZ2Bz9DzMnbDmJf+CWsYdCYYbrP3Us86AN7nw1/bWYT84FViwn36g0UOLI/HMlHar
         NmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536549; x=1789141349;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yApsV8ek6sm1DDA8uG/ESAfoNPZgj9MCFK73tfFdH0A=;
        b=M7icgSwPHGkN4PO1U/tBvFT3jqvIZHjwzy4ujwNo3Oqk1fy/6xrgce+sLx7sJlaiY5
         v0pFRv/t3fv6mjgk/VKzelsm2eGemmdvjLkcq3xzFaMjnfc8VC1KJEoSOdhM9n+dfN59
         ascQGOnlZwjgAIq+AT7uY5zt3LuhL2ePpAujtr1xIWNaI03HSjVwp93839dqxe1QEOb5
         bEBac+xQrzW4VKrpZX8myd5CSPW2XNmZngKmu/zn+UUwrDJEIGHTMmInC/HC3+apnZqv
         tcKy3Aj45JvuQcAliBvt/Rmg/CwUc8hisl14NhKPOxJE+25dFDzSuvW0ksZbk7KHrPm+
         iGLA==
X-Forwarded-Encrypted: i=1; AKwUvBxbENB8pFrmoF+AV7CUWDQfCkgrWFU4/m6DuAMmsbAGyGSQgKHvgGi4zPjwq3Khb7ArKEBz+VXIJg==@vger.kernel.org
X-Gm-Message-State: AFuF++koPkxZr+S5sHakVtyJ8cMuhSvYTI0vdrfmVxOfxRzuk65vZvkQ
	Khq7GR8AEnUER0p1GoP6ZEsQHE/qzMBh/d63RXgqUIsnAek3YxKoD3UTjAgiXJlLPtb3S5r5JUj
	icxR++4S6/2eKuBRmZodafEMSR+CqjzlJunF6D62l6XhG5Ekca84VzxFH2C4BGQ==
X-Gm-Gg: AYBFou1f+PDtKQf4yUCZuQfRZ1uMUJoZh3EVMNbHq5bNhsNllHnjjU7XQW681eZQxhR
	CXMUAMaFyy5rPauLMV9CcpzJFzJ2yUJi5RaiEPhFXe3GDkDdDY4tKPCVeWnkxJYVj/XJ/HqLVew
	4Mn9OkuB9Yl93rlslwmoEDsjZK7T53C/hCf1Er4XMhorbHnq0hdymtqJx8kqx1p/iB292b5+Kmu
	PVC4KmerUE4U5OXCH94D4xs1Zm7JkJAbjiSpIMnit+2o6pnZJVXHivVhQ5EL0utH1z+lfp5qUNL
	RFynayrWwNFUYI07A/xdbsiT47Ua0jElF2ca8Y3f9CT9pZak9Vam7RalH6YXaviQkyJZLPs//1N
	0+gun2fOe49pEpjn9ebbwTTTcb8D/9h0C1tUb0t0Dherv2gEtqUT1PVA4ST0nZHkpBwJaK+pXTQ
	Egci32H2ayu7/UmBK2Nposh4bA9vXkyKJR6e8hFU9bMmu34VgdSDA=
X-Received: by 2002:a05:6102:80a3:b0:77d:9fe9:1716 with SMTP id ada2fe7eead31-78a4a6e83e9mr3371664137.2.1788536549433;
        Fri, 04 Sep 2026 08:42:29 -0700 (PDT)
X-Received: by 2002:a05:6102:80a3:b0:77d:9fe9:1716 with SMTP id ada2fe7eead31-78a4a6e83e9mr3371628137.2.1788536548990;
        Fri, 04 Sep 2026 08:42:28 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:e90a:787f:72ea:b218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5533ffbsm160668505e9.3.2026.09.04.08.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:42:28 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 04 Sep 2026 17:42:20 +0200
Subject: [PATCH v6 05/11] power: sequencing: qcom-wcn: Report power
 controllability
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-monza-wireless-v6-5-d8c5042b3efd@oss.qualcomm.com>
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
In-Reply-To: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX6i0N6TUKycb7
 dshJI7Q1IzgovrFcrFLt6rQbc8oQa3gZ4u1zcf3X6LwRifjH8MxysMCGKCzthH9MM24TFZ5wTpG
 LYeqVlLfDgvbsWzmeaSGegrXT3U9ikQhpzbiBw5wJdm1+lhe1xhvc9JkjEBOhtB+z+hzMuxQpdq
 arK5ilz2ks+0g5jKu/S1weFXWIqxBG/EOhySkKI62K1cm/Rm+38CA9aBbvGm0SKVe11NTdnbLHo
 xlc2zTHB6ESklJjVjCbwSLwFEiY1Sb5s7VHg10OlJKKGbM3vEL62s5cjtvKXJDGtlW6Q2edXd7P
 02JhytaygzQ9SZdsIbIiHUv0cGJ5tCbtE7MBaAGQGkTv2JIvX+bmDc812X3PldwlYIJ2MhLwXiL
 VqFcSSoB3gZ9Nsg4xg88A68XyY6zSm4sJCCB0/DmsWPeCoymIwHP4jtMHojjZHt6pGFRlW8pvhe
 dPXMIO+gXI4AD5+YO2g==
X-Authority-Analysis: v=2.4 cv=YNavDxGx c=1 sm=1 tr=0 ts=6a9ae6e6 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=QWuo0IUDA92h_ITipQ8A:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: tTgVQ6rdqQygcHc1EmIcl3D7Qoji4LgS
X-Proofpoint-GUID: tTgVQ6rdqQygcHc1EmIcl3D7Qoji4LgS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfXzEaY4m/svqyx
 6p3ExdS+m06o5q2V81RFWH4cXiJUtm7YTTakEfjOML9FPqhcr6Q9Sg1Y60z0tT/P/16bB69AwMq
 B90LY8KXiF/IRXoBknlloFN2yNPJaE4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040143

The "bluetooth" and "wlan" targets drive the BT_EN and WLAN_EN GPIOs to
gate the respective functions. These GPIOs are optional, on some boards
they are hardwired to an always-on pull-up and not routed to a host GPIO.
In that case the corresponding enable/disable callbacks are no-ops, so the
consumer cannot gate or reset that function on its own.

Implement the .is_controllable() callback on the "bluetooth" and "wlan"
targets so that consumers can query this via the pwrseq API.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index d41793e1fcd94e6d9073023498e111720af2c0ac..7f88a29b2c33bba5b1bc8e625f7bad26321fb1a4 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -183,6 +183,19 @@ static int pwrseq_qcom_wcn_bt_disable(struct pwrseq_device *pwrseq)
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
@@ -217,6 +230,19 @@ static int pwrseq_qcom_wcn_wlan_disable(struct pwrseq_device *pwrseq)
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
@@ -257,12 +283,14 @@ static const struct pwrseq_target_data pwrseq_qcom_wcn_bt_target_data = {
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
@@ -280,12 +308,14 @@ static const struct pwrseq_target_data pwrseq_qcom_wcn6855_bt_target_data = {
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

