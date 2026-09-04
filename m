Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACED4FECDB
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536557; cv=none; b=FaskAMnGxpOZZ7FPCuFd50b4JmZLCNMESxfLve9ljX7FXu/jiZdqeVH1oQCt5IyqoCe1wZ5EwbrgRMugxW4Hzk9WmiBVCLs7c7aMTiglDvYcMen0YOOWVT1aFrHNqLDwP9+Jc/DeNzIgSNu9zeMYvsNi4NgMVfkZbuxZIEdiBGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536557; c=relaxed/simple;
	bh=v+n+nmdFdnTVbNIb0TxN7WMBm2mqsLqLg3eHOpRK3EY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hk9wvZtLbMJNWGzWaKRR4ChnAv69cBM9SSrxP81zeXhcCz4MtVUCA3GxliUCyV+JmpTGGvb4ndAN0KVseS9+9CDBhyOA2hvVp8pB6zrCpGjxItHW5NUeetGvOzfnA17VKNO26occtf3a3XhopaM1BhMiSKDJHFUt0vWT34J8O4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a2GDmqUb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hl0ADRbb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a2GDmqUb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hl0ADRbb"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684EiYXf3190577
	for <linux-pm@vger.kernel.org>; Fri, 4 Sep 2026 15:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rJpihxR8z/RckkhTvBE3C58BSaU7qi/UDpmaSYSphAU=; b=a2GDmqUbUYlfiQ28
	syEw97CMlDNJ4iCtBqfFLCVtd0PsCRa25LknCzyN3oQR8wZblfNI7ssPV+Nd9Ea8
	fCNjAi1KufL8Yxx0I+MUfsA1LzkC/cT+1GA24CSCjB0tAzjy0PtWKH4b2QJqCZNW
	lW5Trmt90lG/Gb8BojHHcnjxd9H/wuF0B34kUI1BAjq3JkypTRTWQFLy1d+iWXn7
	d/E4bU1sgyWQBkzl7e9HJlyfezxw0Dv3kqXgP0RA1hPPXwVl20uB63aaSRA3JVo2
	OBgsU3ZAnlbxjRCkKx4QOXRFZn7xpIrZKAoCHNyNiiISW1xtllU8gzvCEjd3daBB
	odYoTA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg010g8s3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 15:42:28 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-930b571432fso185677085a.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788536548; x=1789141348; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rJpihxR8z/RckkhTvBE3C58BSaU7qi/UDpmaSYSphAU=;
        b=hl0ADRbbvESClIk8f21MTRihuSDpZjncSZar1C4k3sunhYimt3QAVM3jkDbjtDD/1o
         ACtDQpuAGUKJdaPx3f9/t6KQPt0HpTCpXjWveZuV1Ka2QzE4dTXqOKQC97XgUp32IOvW
         C2GP1TYELMmBkttq9ANw6J1CjIt10ppgWR3jOk2unhH3lVpqnzX+mB0m5KBLnNOPYD2m
         q9u+tUpWdLljM2X2xuXfg3nHZ3z2GA01E9huSy+orpWn/KBvNeEFzIClyS9R669t7uR5
         wojTOOXLIFZyxyEfTZa21n0XLpUVnRXRyLeMDQ+eZqEiaDoFIhBdVLElZ0CKXHvkH7x/
         htvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536548; x=1789141348;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rJpihxR8z/RckkhTvBE3C58BSaU7qi/UDpmaSYSphAU=;
        b=pAKi4uTc28jHGYcQCz0QbdI2RLjC+5CPm8PfI2u1d2pgmXaEvUZg9i9wtX5qbPHQLp
         hNea04eD1pAJVYaPTedb6a7Gq69eeLQvRMPzFhvXTBdrGg+PPN0TObXKbOO8B3xesidM
         DWgFFqQgFYrOO5gMYXIM0iWHNdH6D/xO9WAbk5T2fIXIJTAPtPUB183pn7XQi26myj4p
         hR53omVkeo9+0kX5L8gOOXnsXU7WxCsMntoxvbaumZocalFRMe0S78Msp51CP80cPGiz
         N29WXfYgwlBTzvGHY814nadibigMgSWX9I4pDJLaJGlIisHVoLoUVol/QO8FjEXHK/ta
         084w==
X-Forwarded-Encrypted: i=1; AKwUvBxcqyEhA6h/1g+VasoMtEVwlUBlX3sRCKzVbs2gSBtl1ZL/LlqOAee8gCT2EDDBDzf7MWFWoUazlQ==@vger.kernel.org
X-Gm-Message-State: AFuF++l/a1nLIIEvIektnO2ajO2J33nkptcu8ziXQcStU+4KnHtyJxt7
	JJF+GD5xVvG7a7UnIM33/93ZvRZFnWAoCIMb0u/MF3AOQznpQxVsiLLQKU9Lo3dDVNPwMPW3pQ/
	xjDAfTAGLDrc7HuzX04gG81ZhJsp+JF6Z4aZorG3yHhOxhUzbubSHdjlABtJmUg==
X-Gm-Gg: AYBFou2XGtGMdORNfcOEkBvJdZ6J8gmLyXo/paPVYZHasly9P7KK012UXOaCifZLdcx
	6CXNIdLxz/UBIM2ZMGCrQNcKSmX1wwzjwrkanPGHo33v9SS2TP89GEOJxItSO5HZQGagvqmt/dy
	kbDZO+TBYLcIHZHfrNtCURlgTL7HkIPFsD0wu/fR+isbm0qHZ+2sPc+rS8YErkMuN9omzPp7ND+
	0tSQI/rAJmCeaq9XrRI1QcCKfl27DSl7p72V02u3YlxY6HZA5n8FjqaI3yCKCCJJqM8m6xDxGDE
	cb1DNn2fauGb6Xf+XNi7m+XAbuw56R8Yi2g8b1MriqEnq0AlRk9JjgwRoUWqyYjoE9RHM5Qaewa
	WxvCR+hkhqjrQqUI3ldWcAxZtWwk5plXOOcluB0nhyGEdMnwZ9e25x4rkiU26AR/5kUb3+EQPjb
	c8Q27pbD9KYvVctQCi2j3QNjAseKjbV5j49o669EV8FCCdACPQUeU=
X-Received: by 2002:a05:620a:2713:b0:939:72cb:bae7 with SMTP id af79cd13be357-93972cbbeafmr868827185a.30.1788536547647;
        Fri, 04 Sep 2026 08:42:27 -0700 (PDT)
X-Received: by 2002:a05:620a:2713:b0:939:72cb:bae7 with SMTP id af79cd13be357-93972cbbeafmr868822885a.30.1788536547161;
        Fri, 04 Sep 2026 08:42:27 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:e90a:787f:72ea:b218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5533ffbsm160668505e9.3.2026.09.04.08.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:42:26 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 04 Sep 2026 17:42:19 +0200
Subject: [PATCH v6 04/11] power: sequencing: pcie-m2: Report power
 controllability
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-monza-wireless-v6-4-d8c5042b3efd@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX5oxkv3ji3gQw
 d1s7pyeEQLKpKvSOWTYxQreDLvX/5fRTfRC8jlw29RFHItH9B+D+9TcX7X1D2l0CtnBzp9TC2kr
 LBjfxYGXe3Tvm0tsZeIw6axylgW8m/3VJBK6+6KeUPVu7QOJZh+HF6hYRy5T3/bd7NPn9T2EfIv
 2dd3P6wlHAO8jpmm9hXFOgexbRA4oah7zel+XEWmVBeYjNvue2fHRdc4mLX+hVyEH8MoLdO2SY5
 QRdoZbciGKL88kxn18pBZJuefLyMIKGuAXpW7VJ9vUCJyvDk79kX7XG5kkdPiP4lXBj3dTomrAL
 gpoiVL+A5q88TFLBqVkox77uxUAJTxGZXSAnQU4q6itsrJeJ8/y7ierReeFb8OP5zabC2ICMRHU
 bh/aPLwEaIhgpV1noN0fumVw5Gwxer9E/cWgGx7hOUVrF6yqwTWMQxoraum5gH9GM5zq0HM/eKz
 NiZsX8rtM+Orz/DZCog==
X-Authority-Analysis: v=2.4 cv=YNavDxGx c=1 sm=1 tr=0 ts=6a9ae6e4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=Wval_j7vKiRkorSqWqkA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 9StZUsgkbv_EYEfLwkfyg2kP0ScNWj7a
X-Proofpoint-GUID: 9StZUsgkbv_EYEfLwkfyg2kP0ScNWj7a
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX+NXJStBFVAN8
 i1wk0okw6RMaBOKrWeMZRoHCp+MEkXJ4H3U1dY57kxeBSugrYwFQt6eWeqN3CSVkMKiWg43Miwh
 XGzg9A9Ma4QumP69o/UsGEh8V1mVHdY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040143

The M.2 Key E connector gates/resets its functions through the
W_DISABLE1# (PCIe/WiFi) and W_DISABLE2# (Bluetooth) signals.
When a signal is not routed to a host GPIO, the corresponding
enable/disable callbacks are no-ops, so the consumer cannot gate
or reset that function on its own.

Implement the .is_controllable() callback on the "uart" and "pcie"
targets so that consumers can query this per instance (based on the
runtime presence of the W_DISABLE2#/W_DISABLE1# GPIOs) via
pwrseq_is_controllable().

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index de9848a9a9f19dba6d2e9d756c3d30f6648738ed..bee1aa0e077db139a52d307890053492b4513db2 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -83,6 +83,18 @@ static int pwrseq_pci_m2_e_uart_disable(struct pwrseq_device *pwrseq)
 	return gpiod_set_value_cansleep(ctx->w_disable2_gpio, 1);
 }
 
+static bool pwrseq_pci_m2_e_uart_is_controllable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	/*
+	 * The UART enable is driven through the W_DISABLE2# line. When it is not
+	 * wired up on this connector the enable/disable callbacks are no-ops, so
+	 * the host cannot gate the Bluetooth function on its own.
+	 */
+	return !!ctx->w_disable2_gpio;
+}
+
 static const struct pwrseq_unit_data pwrseq_pcie_m2_e_uart_unit_data = {
 	.name = "uart-enable",
 	.deps = pwrseq_pcie_m2_unit_deps,
@@ -104,6 +116,18 @@ static int pwrseq_pci_m2_e_pcie_disable(struct pwrseq_device *pwrseq)
 	return gpiod_set_value_cansleep(ctx->w_disable1_gpio, 1);
 }
 
+static bool pwrseq_pci_m2_e_pcie_is_controllable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	/*
+	 * The PCIe/WiFi enable is driven through the W_DISABLE1# line. When it
+	 * is not wired up on this connector the enable/disable callbacks are
+	 * no-ops, so the host cannot gate the PCIe/WiFi function on its own.
+	 */
+	return !!ctx->w_disable1_gpio;
+}
+
 static const struct pwrseq_unit_data pwrseq_pcie_m2_e_pcie_unit_data = {
 	.name = "pcie-enable",
 	.deps = pwrseq_pcie_m2_unit_deps,
@@ -132,12 +156,14 @@ static const struct pwrseq_target_data pwrseq_pcie_m2_e_uart_target_data = {
 	.name = "uart",
 	.unit = &pwrseq_pcie_m2_e_uart_unit_data,
 	.post_enable = pwrseq_pcie_m2_e_pwup_delay,
+	.is_controllable = pwrseq_pci_m2_e_uart_is_controllable,
 };
 
 static const struct pwrseq_target_data pwrseq_pcie_m2_e_pcie_target_data = {
 	.name = "pcie",
 	.unit = &pwrseq_pcie_m2_e_pcie_unit_data,
 	.post_enable = pwrseq_pcie_m2_e_pwup_delay,
+	.is_controllable = pwrseq_pci_m2_e_pcie_is_controllable,
 };
 
 static const struct pwrseq_target_data pwrseq_pcie_m2_m_pcie_target_data = {

-- 
2.34.1

