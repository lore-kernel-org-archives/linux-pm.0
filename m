Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0DB40F75E
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784719654; cv=none; b=hgSsmU64CrqUNgVLUpUI2BCqezeaHI+O9fHsV8v7HxbbPeELniDBt+L9Ybe3ly5AHONup+iqWGpAb/wee8PnbVXkZO/jD51TbyNHkbOg6NxWPT93CVgBkmF6gmskbrDwrDZ/Y8FdV9W1T4xtWYQC/Q2dtK/OOHqYM3O/pzFBv68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784719654; c=relaxed/simple;
	bh=UbEeQs7YAIM3++NUeuGJ8hkcivfusRQlNMtLU/0bdV8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tM6EW6GwWGB5W2DCnOrYPhRn80mF8YF04LkfhD2dNAS4xnvqYeOiRn9gR3QtXwco3ObyBJxud2Ul3LbthwzNfUuvWZ7jN+AhwZGLNDjiOY0M62TR/XMImYT4oe1BvI42I9KtMK9yfUf2ToJroVUsba2CRUo1gGDpBSfsahCZUk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Br6+YfOJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FHc3bq4z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Br6+YfOJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FHc3bq4z"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M8x9uT140659
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 11:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BDu3S6oC3F7Hd75dAxTVWUVcOJ2c0rurN9IOs7Wqvvw=; b=Br6+YfOJSpYFTuce
	GzdN1ZyluCVNPOHDIbaMtYBzbci8uyklAz+xRWzvrUjVbK0eaxK3LfH8WBaa93+j
	RkrGk7VfFns/9znM+fGKvqX1jiavGpYSVnuLPSxHjSmJFgG2sCqikQivB1EEvN0d
	PgYq9dlxcbW1/xieXqVuGvMF1AgToaF5j2KWMut+aB37yAw7x5PDwNgJNQq/gayX
	F2sHmDjfv3xytP+cXaqz5l/wyYMZiueSuoxx9g0jRckRs6UKVMVR5jeXRXKohfoz
	q3I/LRkGk6l/Blhtvw3hp4PL1SbssQQNNQ4O8N5Pe5GfxtslDGFJ4oAcoy/6h+ch
	mWSOXA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjtn2rmav-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 11:27:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cca3673560so214855565ad.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 04:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784719646; x=1785324446; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BDu3S6oC3F7Hd75dAxTVWUVcOJ2c0rurN9IOs7Wqvvw=;
        b=FHc3bq4zEMclZoOYhwVrwySUFwvB5r4H95s6IzGwAuRiTiHweFq6wAazxi7cBiI3Mx
         MAo7BPU/PWA5pTlaieYArVYsSLaYZGtKJpU7aqYoH8ZY6vPJwatYuoPzAsThEyf1ZdpE
         6feXAlrJ3BGMsi5zvpM1ntLPY4IE8bVMzf8AD9TySdl3EAHG0YYBrWedQ7ZSYSxAJwBS
         x2fRYQDJMb5um9ocPZzZI6u7VblppNhXWlZw/SM3RxnhS39otixuYOtSEIMEW52t8FIZ
         LVsyuFCoQH777mRNrTmdqeTGBYWpZIN2DXziYhFE79314cVDKVIDmBJOmc7d/T68PIqc
         vGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784719646; x=1785324446;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BDu3S6oC3F7Hd75dAxTVWUVcOJ2c0rurN9IOs7Wqvvw=;
        b=bL3EhYE32oP6uZQDnBYqzrKnlh7IU8JBh5P3n5+t2sqSDogNpa4kfyf4+37egC7DP0
         w9hNXC5MG7IOguf7MHRlAMInsomltQPSfTD/u5jI4MKIhfnsN2UBHVsEoInGmSzquv3S
         hUyI1johua4UbNOMzSFDXyzVqo7mPPG/GHBvmp3oYKEvis6pBgwFPZTbcs/OXUIJ8k4H
         JiSh5/9HhxheoU1Cq3iN0voqMlNDKQj9ULZpSCMZWA/mKvm/zkZDwukZeX6BLM/PupMd
         QpOn7ofGSzSwuwO6alpNWt0kIOqoyxM/SEnwllDxUM8J4o9gI31Q6yr1hMh19qNhIMQU
         /xjg==
X-Forwarded-Encrypted: i=1; AHgh+Rrw+kcvTPZxCTAYay18mBHGsIrZKN9tJZq2Ad9iaRCbdE/L+bOqU7wC39HTwJN3Tx85Hjjs+cxSvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ7ychk6SNHMPQGWEO8+BbX0N1xZdi7qkSB2VGvsJ9W30UbkFZ
	XV6Gu5FINDYMd5QlYBLskOmY5eoSUWXvXROBn6SFGY36PofbCB6wl2NslfaWH24PDBkytguOp8p
	tXOQNVgJzm4hC69QqUcHow6yWY7qZKqcoSvxv0UPa37Bsn6CVvguB4TNk3YuEUw==
X-Gm-Gg: AR+sD11z+232ZtRluwl2DlXz+W/7k429FehLjOCEpNZhiNnkwP7OZ2CdtzwcKKbEvWF
	JRXOLy+BvjO19olcRX4ihKFQW+Cst5pbaAyf8GRdA95MD9xGS0N8Q0uEss2lxVPB4qqZYnu949N
	Q4xQol6V7WGJjt3TbQ9gLHsx+LKEE5APoVklJHNRYdrsao8UsL/sKOL5Y9dZzbEZhY9ntsIbQEU
	r90vONQGGcBNX2ydM4uINs9sSTvxUexneNgdrKJkBTrnFnho9oP49rtIXcMbFCZy1I0JTT4mNhN
	zrzOUp0QuLjdQcyLqNRc2GckTj1X/pI/YfYANHdLK0gOskcb1dQzkmdL883frj81Ws0ezcsj3pz
	+55l42ZaxyFKTzSiMXVw=
X-Received: by 2002:a17:903:3807:b0:2c2:bd7f:ccd4 with SMTP id d9443c01a7336-2cf349175f9mr234051845ad.21.1784719646245;
        Wed, 22 Jul 2026 04:27:26 -0700 (PDT)
X-Received: by 2002:a17:903:3807:b0:2c2:bd7f:ccd4 with SMTP id d9443c01a7336-2cf349175f9mr234051535ad.21.1784719645751;
        Wed, 22 Jul 2026 04:27:25 -0700 (PDT)
Received: from [10.213.109.130] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e65f3sm13143995ad.45.2026.07.22.04.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 04:27:25 -0700 (PDT)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 16:56:38 +0530
Subject: [PATCH v4 2/3] iio: adc: qcom-spmi-adc5-gen3: Share SDAM0 IRQ with
 ADC_TM auxiliary driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-gen3_adc_tm-v4-2-011981f756c8@oss.qualcomm.com>
References: <20260722-gen3_adc_tm-v4-0-011981f756c8@oss.qualcomm.com>
In-Reply-To: <20260722-gen3_adc_tm-v4-0-011981f756c8@oss.qualcomm.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784719625; l=6189;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=UbEeQs7YAIM3++NUeuGJ8hkcivfusRQlNMtLU/0bdV8=;
 b=wtas0JGLTwoQdAPF/HxRM9NifZV21RTKzGYLesFS05+HBUydx5RqzERk3XsN/1ldYTyreEmvL
 PDMceFttcj2BanWCrzhF9J1Vh88TqjoQo1qq059TBJKzmdLZAMwmmwn
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDExMSBTYWx0ZWRfX/Qj0yo2qhmt5
 k7c6dIX0wZX9Ve8240FJWXekHwICtiscQcWQ+DFMliN+kL06zA/xS9znP1QRZJUrq7VpTbKPpH7
 Z1TqJat/yAbytv5kswiYj+DJ/xexYrP4XP/jUKyzkUOXaZ3Wa4B+CwP4F+G+Bvb4/YkQR33QapT
 npHGlA3SojQar7OH5KgajJZ1Pc/Mj2SGK2X1S9cqoXRbSj6w5OZwKrNBi6GHNyr2Uh7P3QuTATu
 UG+4+ZYyfs4tLkx6FQw0YuVpcrpbbXlybncJln1/FFg0xlHK0qpeHnIFc+6CBme+rD4QpXBO5+R
 Y1U7EpzW4pgX8xMs0C2XhsLPrWuDSeLxGY1cKF7368Mm7+fbg7dmQoGzaRQmq+liw35wi9prZSC
 d9UDUhaHxhqep/boaF6ftfF67XWKZP//NSKCbv+G8veRY7KOs/amf79qKacxcFh+jBcFoaPRBs1
 R2tdQkoXGYPIM3QDthg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDExMSBTYWx0ZWRfX09bQ324yt6Yq
 ho6YNl+AhMzHNPR6HtKLob+Vjui8cy7OBTYOUUw3xiNMfCdLQfZUJkMnmtDx9Ty/R7P9wV6zAgp
 d5PEaSF5v0SZOYGY98VKaQjPWs645cs=
X-Proofpoint-GUID: du4djwu6IPDWgrWibcG8WZgUS_Jx5gNI
X-Proofpoint-ORIG-GUID: du4djwu6IPDWgrWibcG8WZgUS_Jx5gNI
X-Authority-Analysis: v=2.4 cv=T+28ifKQ c=1 sm=1 tr=0 ts=6a60a91f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=g_6YNVtFXVELDihYPjMA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220111

The SDAM0 IRQ can be triggered for both EOC (end of conversion) events for
immediate ADC reads done in this driver and for threshold violation events,
based on ADC_TM thresholds configured from the auxiliary ADC_TM driver on
TM channels on the first SDAM.

At present, this interrupt is handled only in the ISR in the main ADC driver.
When the ISR is triggered for an ADC_TM event, this driver notifies the ADC_TM
driver by calling a notifier callback exposed from it for this purpose.

To simplify the interrupt handling in both drivers, share the interrupt between
the drivers. With this, ADC_TM interrupts on SDAM0 will be handled directly in
the ADC_TM driver, so remove the notifier callback and all TM interrupt
handling in the main ADC ISR.

Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
 drivers/iio/adc/qcom-spmi-adc5-gen3.c         | 65 ++++++++-------------------
 include/linux/iio/adc/qcom-adc5-gen3-common.h |  2 -
 2 files changed, 18 insertions(+), 49 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
index 2eaebf6b34e8..c68c6c5f6aca 100644
--- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
+++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
@@ -55,9 +55,6 @@ struct adc5_channel_prop {
  *	requests from multiple clients.
  * @data: software configuration data.
  * @n_tm_channels: number of ADC channels used for TM measurements.
- * @handler: TM callback to be called for threshold violation interrupt
- *	on first SDAM.
- * @tm_aux: pointer to auxiliary TM device.
  */
 struct adc5_chip {
 	struct device *dev;
@@ -69,8 +66,6 @@ struct adc5_chip {
 	struct mutex lock;
 	const struct adc5_data *data;
 	unsigned int n_tm_channels;
-	void (*handler)(struct auxiliary_device *tm_aux);
-	struct auxiliary_device *tm_aux;
 };
 
 int adc5_gen3_read(struct adc5_device_data *adc, unsigned int sdam_index,
@@ -286,23 +281,21 @@ static irqreturn_t adc5_gen3_isr(int irq, void *dev_id)
 {
 	struct adc5_chip *adc = dev_id;
 	struct device *dev = adc->dev;
-	struct auxiliary_device *adev;
 	u8 status, eoc_status, val;
-	u8 tm_status[2];
 	int ret;
 
 	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
 			     ADC5_GEN3_STATUS1, &status, sizeof(status));
 	if (ret) {
 		dev_err(dev, "adc read status1 failed with %d\n", ret);
-		return IRQ_HANDLED;
+		return IRQ_NONE;
 	}
 
 	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
 			     ADC5_GEN3_EOC_STS, &eoc_status, sizeof(eoc_status));
 	if (ret) {
 		dev_err(dev, "adc read eoc status failed with %d\n", ret);
-		return IRQ_HANDLED;
+		return IRQ_NONE;
 	}
 
 	if (status & ADC5_GEN3_STATUS1_CONV_FAULT) {
@@ -315,30 +308,13 @@ static irqreturn_t adc5_gen3_isr(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
-	/* CHAN0 is the preconfigured channel for immediate conversion */
-	if (eoc_status & ADC5_GEN3_EOC_CHAN_0)
-		complete(&adc->complete);
-
-	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
-			     ADC5_GEN3_TM_HIGH_STS, tm_status, sizeof(tm_status));
-	if (ret) {
-		dev_err(dev, "adc read TM status failed with %d\n", ret);
-		return IRQ_HANDLED;
-	}
-
-	dev_dbg(dev, "Interrupt status:%#x, EOC status:%#x, high:%#x, low:%#x\n",
-		status, eoc_status, tm_status[0], tm_status[1]);
-
-	if (tm_status[0] || tm_status[1]) {
-		adev = adc->tm_aux;
-		if (!adev || !adev->dev.driver) {
-			dev_err(dev, "adc_tm auxiliary device not initialized\n");
-			return IRQ_HANDLED;
-		}
+	dev_dbg(dev, "Interrupt status:%#x, EOC status:%#x\n", status, eoc_status);
 
-		adc->handler(adev);
-	}
+	/* CHAN0 is the preconfigured channel for immediate conversion */
+	if (!(eoc_status & ADC5_GEN3_EOC_CHAN_0))
+		return IRQ_NONE;
 
+	complete(&adc->complete);
 	return IRQ_HANDLED;
 }
 
@@ -683,8 +659,6 @@ static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
 	if (ret)
 		return ret;
 
-	adc->tm_aux = &aux_device->aux_dev;
-
 	return 0;
 }
 
@@ -740,16 +714,6 @@ int adc5_gen3_therm_code_to_temp(struct device *dev,
 }
 EXPORT_SYMBOL_NS_GPL(adc5_gen3_therm_code_to_temp, "QCOM_SPMI_ADC5_GEN3");
 
-void adc5_gen3_register_tm_event_notifier(struct device *dev,
-					  void (*handler)(struct auxiliary_device *))
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
-	struct adc5_chip *adc = iio_priv(indio_dev);
-
-	adc->handler = handler;
-}
-EXPORT_SYMBOL_NS_GPL(adc5_gen3_register_tm_event_notifier, "QCOM_SPMI_ADC5_GEN3");
-
 static int adc5_gen3_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -816,10 +780,17 @@ static int adc5_gen3_probe(struct platform_device *pdev)
 			return -ENOMEM;
 	}
 
-	ret = devm_request_irq(dev, adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq,
-			       adc5_gen3_isr, 0,
-			       adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq_name,
-			       adc);
+	/*
+	 * This interrupt is shared with the ADC_TM auxiliary driver, which
+	 * is threaded and uses IRQF_ONESHOT. Since shared interrupts need
+	 * to agree on IRQF_ONESHOT configuration and there is a kernel
+	 * warning for using IRQF_ONESHOT with non-threaded interrupts,
+	 * make this also a threaded IRQ.
+	 */
+	ret = devm_request_threaded_irq(dev, adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq,
+					NULL, adc5_gen3_isr, IRQF_ONESHOT | IRQF_SHARED,
+					adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq_name,
+					adc);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/iio/adc/qcom-adc5-gen3-common.h b/include/linux/iio/adc/qcom-adc5-gen3-common.h
index 6303eaa6640b..39cbfcbdb101 100644
--- a/include/linux/iio/adc/qcom-adc5-gen3-common.h
+++ b/include/linux/iio/adc/qcom-adc5-gen3-common.h
@@ -205,7 +205,5 @@ int adc5_gen3_get_scaled_reading(struct device *dev,
 int adc5_gen3_therm_code_to_temp(struct device *dev,
 				 struct adc5_channel_common_prop *common_props,
 				 u16 code, int *val);
-void adc5_gen3_register_tm_event_notifier(struct device *dev,
-					  void (*handler)(struct auxiliary_device *));
 
 #endif /* QCOM_ADC5_GEN3_COMMON_H */

-- 
2.43.0

