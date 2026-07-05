Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00B22F7F12
	for <linux-pm@vger.kernel.org>; Sun,  5 Jul 2026 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783270463; cv=none; b=Ul6LNAI9PGirji9x9dXA/Q6TNygzI6AZBXYwtf1fX+9kN1qhZQSP5PgQ9YLO18XrAPDdAW73pw6C/D2tEXTfD/VFLr+FHilCKRQU3JRSfDtHRQzE+0uwlIvpbvL0XaoeEPLQNEvQx1XubDgKswMFFN2VIwiSwyhjIQuZOJlHcLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783270463; c=relaxed/simple;
	bh=goLxOeIHIgfoLKTpZSuskmH2vf7z+LIBglVRN7QnIwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nw9/w+DfuspGxZEIut/0h8YNC/ocZzOm8GjIEW2+UuAZ+RRWoEqG/i9YQ0cnyX6E4AnmXxv4kY6O1Dm5qGonDiypePoEo4Zy3fc164b8911NdiWrS6spi/N/2O/HUTJo5E4L0tkRjFFC5x9iX02lGGRrve0skjc5aOVhSyL3DNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l3H0kDzT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kX0Rsoh8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l3H0kDzT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kX0Rsoh8"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6655fDfP672433
	for <linux-pm@vger.kernel.org>; Sun, 5 Jul 2026 16:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EORU7/2/xHP2h9aNqThCS6cHlFvWyRUWhoJIuNcLyKM=; b=l3H0kDzTOwDeH/Ba
	p8oYBp7BhsYxG+Y3aZ7pwPk5PpiUdgXUVRGdIYj2COJ52as0ouInvZNm+5ZK0QJq
	ZydSmJxsF/DC1Zg95Pf6efJWccLuz10oRt4fVRzU2HSeX06lUND3QcNo7nLYKnFd
	d4qoW/9d6OaOR0PMkIHDbYpMALojuM3lHJaNq0Jh5mY9sJUkddQl64Q4dXC+t03P
	DeZUH5BB6r8omPcbL3khYU78zvQG0lEv+v6oInyCShOrodJ1rhHE8MZmAr8nrGvh
	KXsEXMNmiIm4ARN0DCplP+ErukfO/jG3+hxv1hMENF22jUqNyY0s5C1MBZaY5D/h
	3qkjzw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ubgjw3k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 05 Jul 2026 16:54:20 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-380a638fb5bso2139024a91.0
        for <linux-pm@vger.kernel.org>; Sun, 05 Jul 2026 09:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783270460; x=1783875260; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EORU7/2/xHP2h9aNqThCS6cHlFvWyRUWhoJIuNcLyKM=;
        b=kX0Rsoh894Vx7FmcZymsHRm+4mlwNRe45L8PWgv2aZdEsKrHFiYqPQKZLrG8s7Xoda
         ILtluJJckm5CWIPSEbsIFkUtzvTOwS1BMP2e2dGIy/C07Pbjll/B4Py5m49wt0p9h3lJ
         NOtPNro6UAredobp6ANP4RP2nDQf99QTb6p1MICUow7O4fD7GlzyF9PC/KFIRl9rsvar
         gwhLA18cOLnzKEVdxmzDMdbzaiuGYOwcQegHyvRlINgje7gTkLIWdxwPAuL8E2ztlZSp
         8V9LQLDZqWluLNu+n8McHfPcKn83nODf2sbVpVDp1DHza3d1Od0R6j+bRH1HdinebKs5
         yDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783270460; x=1783875260;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EORU7/2/xHP2h9aNqThCS6cHlFvWyRUWhoJIuNcLyKM=;
        b=qwGhvfj4wfUpbHpbCtTpUF2G9aIM6wOzs3BLigYWHxyyNW+E6LaI2Q4+tWT20Qa/wR
         g2prKqzUgGlgQsG8KeSHZKX+zX1WFQ5GFKf52E4+Z+CAofw6D+QKF0CsMoEM8Vgv+aXO
         1OHadf0o8uhvJ8EcdCiwJviyH9dzBX8liQX6owynNbYbvdgun8BO1A3CUs0QTRT+65hK
         2TKNyuM35BGtZXIYH1s+J33qHiRlKAbiizvMzD2VHln8bQ/JE3ilof7V55dK+29ktlxW
         Ft1LjbqJmAKLQRjhPVA5ZLZ0GTPdZdq1soKx5wbznbtCPcosXnKBBGbo2+Al4HebEY7F
         k9kg==
X-Forwarded-Encrypted: i=1; AHgh+RoGfvKjdaZs7+r5ym4vHYu6hEbI7G1EJNh9zYDSGNa3GjNXLJLZ6cB5ZxzOQ0DFisOb64hqwfRFyg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrd4A0jaQidrqRgc/Owwp3j5O/8DCiE2eDjCNZErsEmK/0T6fA
	Yuqh2j9jPkGLDem78UXBwN0IZw14HTAQ80o2S6Y8BQY8vBkvU1mZmFNTvwIj+ax/LanZh0N+g1X
	7yQF6ilkEBXU/XAMbp7l0nh7oibnP8ENV6O6+CV2tJ1Xi5V37e1W8HW4NsnL9YQ==
X-Gm-Gg: AfdE7clks7GslwBvRHcQSOegxEy2LtE7PIA3Z07Nh/hCaIiuRlP8yKo4SUXFyVuK8dz
	CDZI5K2Cl8ujNlxemqXteUlE0N/WJ0RmGLnBtBNyTQTPcZ/JTHNN7D2k+MywxwO9Zug9c8nOKjx
	bF3PUkMhDCEdTPz+XulL2y+SIs8DnN7NL4DqP0fiv2QX7ct03+C70AUr+XwlIBhsHszLbOIg6s7
	sxAwT7JPQwGQZ8BlD6UQ6op1UBMeZbDkTNqp6SJ5t7njVIgf9RojgIthSIJy0Pbp/Op6cozCmrz
	pGRwIHKcVuWfd6zpO0ihyN8LwcH6uSQjLZJ0hOc3rCzQfKLVUsKRu0gaz2fNbWHtXnbfyqRkepO
	ZpyZfNshXBrMX0Cti5/iViiCY9ms9qA==
X-Received: by 2002:a17:90b:3909:b0:381:528a:808c with SMTP id 98e67ed59e1d1-38280aa611dmr6592248a91.12.1783270460043;
        Sun, 05 Jul 2026 09:54:20 -0700 (PDT)
X-Received: by 2002:a17:90b:3909:b0:381:528a:808c with SMTP id 98e67ed59e1d1-38280aa611dmr6592225a91.12.1783270459492;
        Sun, 05 Jul 2026 09:54:19 -0700 (PDT)
Received: from [10.213.109.130] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f3a9341e0sm38253593eec.12.2026.07.05.09.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 09:54:19 -0700 (PDT)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 22:23:33 +0530
Subject: [PATCH v3 1/3] iio: adc: qcom-spmi-adc5-gen3: Share SDAM0 IRQ with
 ADC_TM auxiliary driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-gen3_adc_tm-v3-1-ac62f387dbce@oss.qualcomm.com>
References: <20260705-gen3_adc_tm-v3-0-ac62f387dbce@oss.qualcomm.com>
In-Reply-To: <20260705-gen3_adc_tm-v3-0-ac62f387dbce@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783270447; l=6250;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=goLxOeIHIgfoLKTpZSuskmH2vf7z+LIBglVRN7QnIwA=;
 b=y6yo7C2821T7hk+4oVe/1OBPl9nGgZy5xs59SB7cQb7yoqxfV+6ZerF7m5Heq6WPQL4zo7q+e
 wuHU8fN1vWRBGHTrhZYT0AcDPSb28zfHibSOjJID1yYWIj4sINV/zLt
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDE4MCBTYWx0ZWRfX3fA5/HehdlZX
 oCoIxm5MS4ggeW4+UMoVNIruFT+q2u/OQMFj8Vn4MbyX1Km+erAxjUnQLdL5HAY1MNmx2UM9OQq
 FzA1W7MW1pt1pKgefbWthxwecO2B9sM=
X-Proofpoint-ORIG-GUID: pz4mzFuDnpBNrwy1BEYNVqEZdeH6R4dy
X-Proofpoint-GUID: pz4mzFuDnpBNrwy1BEYNVqEZdeH6R4dy
X-Authority-Analysis: v=2.4 cv=FJwrAeos c=1 sm=1 tr=0 ts=6a4a8c3c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=g_6YNVtFXVELDihYPjMA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDE4MCBTYWx0ZWRfXytVWVbaSWWhJ
 v0dxEUrkcqQggmraeUkhFtRhI9/EdmCjGFz9g5JbZKsjhNgpmlm1KBT7k45A6cDjnGQ19eYMrZz
 yUuYf+npcpJOwhNZM5+N1Z3jnEedBmcdxa6n15m5UduQfWe//H6PHrqeJMd3/3trHtuvbkrVXLD
 V0dqmAvVrmgcC6qEqGqgfVuSVnOYDCoHQQM4oNbmm58CXffY5FgiPsZwq2UmH7IYjvs22UuSlBw
 r+SJ798/SXKuDNIoyTHYUkxK2MkJjrH4hUj+o/4CHRLOdZDMXkZaYXaghC6FMMKWH7tXUvQ6FUd
 KF7wI6C8EhXSDKZfjOvNVO87J6AwN4wuDIMLMszCe0oC0tQRE8uCigfTo3eFOBziYNOUT77JjwK
 /x1mu7JrCsLsR1agWy7ymjKnHpk1gnf/PJbPqOjgH2wC7OUt2b5nnIHr0MaEMsfTX2/fDlq2lsy
 0qzoP/YAe7z+bA3nzwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050180

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
index 48c793b18d11..c1962312afcd 100644
--- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
+++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
@@ -56,9 +56,6 @@ struct adc5_channel_prop {
  *	requests from multiple clients.
  * @data: software configuration data.
  * @n_tm_channels: number of ADC channels used for TM measurements.
- * @handler: TM callback to be called for threshold violation interrupt
- *	on first SDAM.
- * @tm_aux: pointer to auxiliary TM device.
  */
 struct adc5_chip {
 	struct device *dev;
@@ -70,8 +67,6 @@ struct adc5_chip {
 	struct mutex lock;
 	const struct adc5_data *data;
 	unsigned int n_tm_channels;
-	void (*handler)(struct auxiliary_device *tm_aux);
-	struct auxiliary_device *tm_aux;
 };
 
 int adc5_gen3_read(struct adc5_device_data *adc, unsigned int sdam_index,
@@ -287,23 +282,21 @@ static irqreturn_t adc5_gen3_isr(int irq, void *dev_id)
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
@@ -316,30 +309,13 @@ static irqreturn_t adc5_gen3_isr(int irq, void *dev_id)
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
 
@@ -684,8 +660,6 @@ static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
 	if (ret)
 		return ret;
 
-	adc->tm_aux = &aux_device->aux_dev;
-
 	return 0;
 }
 
@@ -741,16 +715,6 @@ int adc5_gen3_therm_code_to_temp(struct device *dev,
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
@@ -817,10 +781,17 @@ static int adc5_gen3_probe(struct platform_device *pdev)
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
 		return dev_err_probe(dev, ret,
 				     "Failed to request SDAM%d irq\n",
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

