Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794386565;
	b=1MDaeM9u2OvYgtG7dzWuMv2PgmFzGJ20OkC9gjNVgDu0G7vTurOR3i8fe4yQrFYZZm75
	 YUF0e8Jti1N1DPbdF111cD1Y4yCEKvVmopZLTJPOqKwrQwKo253fvyIU88Vd+qfxijvdU
	 G+zLCPqj8p5VHRWSKLzclZ6nlhOmru1+ii7JL4MIURgjs0jR5duXpGn/nfwzTTwgZDH9Q
	 qVmtmVbgYZzktB2xV8sWSrNbo/7VW3hlj0PwzIuROBCffSHnKLDuBMjo7ZwTYeIIvTLQE
	 zXqvGiHayuryZiui/vRK/HJ6es1zEt2vUZVabWAJgf/GtO+SCfd3kRyg2Olo93RxCcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794386565;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=caKD8K2XUp1y25/Ss8VDsXr99ruFvls35VJEqEvKLcI=;
	b=yuMXBWEKeffWghwpGE9Y+DvgDSHmXtnkC6frpkKwDkozRjN2+4lBDc5f6Yqv0LvOSlzP
	 JHucGf8kdktshiw8RfiPmjbO0pWBvnkAC4X/vDYvuVtE18vsbSDs9OMZfDvc/5nWzcJLP
	 ZHISDLlP48UlgKA6foSI4iG97Vfy2dC5MTbdzFLjLBghDTI+l4qOr7B6het0diSCiohK7
	 wvIzEsZ6Jm1J7NQCIy6ZN692bUmg7+uCOANBmaUZBliWjWso22ApYMOXHCgOKS44cCmUh
	 kkHtA6wIrAWib9g0Xnv1lazv4xoJKgkDq473y8qFdEaZy8+QzOE2UCRS5Lw9dXiAWWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Rec6yN0e;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dVGM+QhR;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9E7606A32E
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 08:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF9E7606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Rec6yN0e;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dVGM+QhR
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5Kgk0300701
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 08:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=caKD8K2XUp1y25/Ss8VDsX
	r99ruFvls35VJEqEvKLcI=; b=Rec6yN0e87PEOwVvEWwEvLsNMe8lpmhlpCqpvE
	ZZri7l9Z7cOkFM1U40I+NorpNHT1lsHPPlywK2Si0i1fTKpl3LfxNzxbwbjsMDlw
	1egtonUD4cg34wjkX8E2BNwadssXnvauhuflderm8ROGGMU9lmAxWqX5NzVgBvkx
	U8IbUmz16beFrTQWSO6E6JCrlb75YsM1qgzCOmxvIA4eiSk3LHRVuxslOQ5dgQEp
	NKmaU03U9aYDZiI4wqdZIzk3xpuwZRmLV5OOxho8IOgNH6sdrePgYbidja0wC/RE
	723tA6Ar5H//NuB8etpQaC6tEaUSsqLm5yr9kyLfQLqGB+hg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv7c5kbvu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 08:42:43 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3763bd79663so1117045eec.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 00:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794386563; x=1794991363; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=caKD8K2XUp1y25/Ss8VDsXr99ruFvls35VJEqEvKLcI=;
        b=dVGM+QhRUiROM+1IZ8Sku5VPqBtIMpxs878v9jhTH2oqA9cB7BZeVi5PhUpXQDM5UZ
         FTPb+El0GUCnCX76kENRZBqoz+vOBThmLzx1MDbvGULf7JZfYdPk19VFMAh8I9b2OQrC
         jyDoJb30FODx6hopjS0hJH7jTrTbk0lJo5dFzkrh/p1/SjzEfEt0wWYkxBo2vI4o3JUm
         AnRN4eB4EZlMd73JYYJhmFJNxI1r3c1dZRFExpOSkuCsQXLoq3OSvgZDxdyGC2Q7ON4v
         vTAxAjdgJTV+P7CtzFKR7FCkIMQWWOq1UUKBG67yIDoENhiRo42rD7SsbfPb+4XUOIq1
         pevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794386563; x=1794991363;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=caKD8K2XUp1y25/Ss8VDsXr99ruFvls35VJEqEvKLcI=;
        b=XJJt0NG6cK3zuIIrHzuOlsQ1etHCxuDU/H6cpc08W1B2yEUar4Z7Tdss537FG4K5wA
         v7fSCOCsacEfRBD1xBknUIEllaTuacFlBbibSuDnX72399bimK4FAyDf4FdWD7mpmB7c
         jPUYDx/cjpt7zJF3HLLPblp3aFEO9by7sRncJzFR75/wv7Gora53n6kqozFLAnm2DsL8
         EPVuqub58gaVJ+W/BAVuUIAs5cc38CdbFdaLrrSkvS4cfKVAAq5/r3GGWsRwsWfsdecb
         yZkm1k+ZqJ8rjGBGYHrJRjUQ1B39I2lRM1f4fvy3u6MrTcnWy72jpEVkuxEFdKqovAGn
         3vfg==
X-Forwarded-Encrypted: i=1; AL+hErHMBoNTryDBT6C7O+Ah8l/SP7y9TeCZkaK4YlWOHXuZFf9oc2K3PiXtiUJ4IJbwp5q7BYa2q63aTg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8u9+jlLEQ3eeU3xfaEAyeL98DncxA+KJCoXYvw5abLFSeEybkf
	dnQ4rZIbPXfm4F3MdH5qUg3Xy223xOgRny1k6IX0Q9vktrjwLRxRBnLO6W9jSmM8hC1H036kCNR
	OU5e8F1zYKIgCMkCVqpioVDs/l5wN+jybHSikZ23OMUUt1k4NGGBvubPe/JrYLA==
X-Gm-Gg: AYBFou07q2geNQRHZTjzGOvfpFXiB26UxY4rRQcK0xfHMuhypzfBHiG5phxZrNchlHJ
	Gh6F3f3MOd4NM84MwxHfpg7brmh8GF2PHuh8h5KY5nmWTproTzBaTSDVzFI21yrUV/bXXmD1Mb4
	5eQUlulppYDDbzoPMenKfm/VcLkTdB6uY+HC4ebItN5N1I9XQCXLocxr88htDn/B95omTiXmS32
	rYCEo+B4S2KomD2LQ6RYq7fTecxd3wRz4Bu980JKyoIABSSEhud7InrjwfBG/czt5DYdXYIl9Nq
	XZWYpsjru1UJf9xcA7N8PtQxz1CJnOsbKR1ywHSIdadMqewqVTFbNnCgCazPBJKaxUD7Pwz0axl
	PJpT2g6JhIDzMDwh/BeZJ8d4PKWh2e0rmYXdFrIiOOal/2//hpTdBAaU3tyh3RDbAB4g=
X-Received: by 2002:a05:693c:87d6:10b0:36e:c85c:3bbc with SMTP id 5a478bee46e88-37685c7a8fcmr2405514eec.12.1794386562575;
        Wed, 11 Nov 2026 00:42:42 -0800 (PST)
X-Received: by 2002:a05:693c:87d6:10b0:36e:c85c:3bbc with SMTP id 5a478bee46e88-37685c7a8fcmr2405472eec.12.1794386561715;
        Wed, 11 Nov 2026 00:42:41 -0800 (PST)
Received: from [10.213.109.130] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3766146551asm5935916eec.1.2026.11.11.00.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 00:42:40 -0800 (PST)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 14:12:01 +0530
Subject: [PATCH] thermal: qcom-spmi-adc-tm5-gen3: move hardirq actions into
 threaded handler
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-adctm5_gen3_hardirq_removal-v1-1-536ed503396c@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFgq9GoC/yXMQQqDMBBA0avIrBswak3pVYqEaTLVkRp1oiKId
 2/a/t3b/AMiCVOEe3aA0MaRx5CgLxm4DkNLin0yFHlR65RC75bhalsKpe1QPMtshYZxw7eqaoN
 VadDcSEM6TEIv3n/3R/N3XJ89ueW7hPP8AHePloF/AAAA
X-Change-ID: 20261111-adctm5_gen3_hardirq_removal-467a437a78e1
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kamal.wadhwa@oss.qualcomm.com,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794386555; l=4621;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=/VgbWEVvLV7IIi9813+uAXJpHlnNKj3SGal/MqgZqao=;
 b=S4MejmbHBPlwKkgHBsgY4SsrhFgMBa8twu+tU/QhLpmkMaPUbWccTZbnI2mTpRdNoVPH9NOty
 qp4XEeFA+RzDTRu4kChTK/0pRdftRwBJyU0ddQASJPKr2X5Rfb7IZAZ
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzNCBTYWx0ZWRfXytsgIFKEiwIu
 i2ZRnbu6UBN4Yk4Bfz2Kp7Q/0Awvq7aATPj4M3vHwq/h0EYzI9ezwLOn0YLCQ1Gdj5UOWZsYe3G
 paqoMe+Y0PDSfdpsjBH33NyNdJzXuF52oBxShC1GR+EMmg+dxV9fEuSyki/X3jw+AWS2ygGocmi
 iaj135z5T+qyV1FiiroF3+b03Icx0W0Eed7YVsbE4D52n7HpyjqZkezdFi7exiy+emjICBy2yuy
 r4HcmZk3nnr0lJpDVTV3XmW8ckQVQ7gttQ8+/L7U8TrwcVqGMD2BD5cvTtKha+pxWs5/NsKQ45M
 AuQwFt9ViRdYZhT2/aqTqiWAWliVcszD+qxTCQPaJLP31xHHybG92UI3KaRNs4UMNU4NNyB2Deq
 E7GQ5Czlg24hmt43hgkh8u44HZ3v8Y35QxdMDKGzTtzm6Qa93dFDaV7K06wkCbucFjZbwUJTM3l
 KvBHvKm5MzdlOUsX9oQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzNCBTYWx0ZWRfX/DDy6Lus5IjZ
 akjssApZIyX9Q8Dyr9DRPMrmqJkOkn3+Z1UavWBX6R6XljfxFr5jeBt2pORd5kKW9QK7JqTIAKu
 til3cgZ4aObhjW9du2TuHJW1NLQ7jpQ=
X-Proofpoint-ORIG-GUID: XJr4Bt-Q03ROHtr0QLp0UaJeFGIHqi2z
X-Authority-Analysis: v=2.4 cv=eq9KXYpX c=1 sm=1 tr=0 ts=6af42a83 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=zlfbmXi6rwQ6R9OsHyEA:9 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: XJr4Bt-Q03ROHtr0QLp0UaJeFGIHqi2z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1011
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110034

adc_tm5_probe() registers the ADC_TM interrupt with both a primary
handler and thread function (adctm5_gen3_isr/adctm5_gen3_isr_thread)
with IRQF_ONESHOT. The primary handler calls adc5_gen3_read(), which
takes the SPMI regmap's lock (a regular, non-raw spinlock) from hardirq
context. With CONFIG_PROVE_LOCKING enabled, this leads to a warning
about an attempt to take a lock in an invalid wait context:

  swapper/0/0 is trying to lock:
  ffff000b67201018
  (qcom_spmi_pmic:259:(&spmi_regmap_config)->lock){....}-{3:3}, at:
  regmap_lock_spinlock+0x20/0x40
  other info that might help us debug this:
  context-{2:2}
  locks held by swapper/0/0: 0, last CPU#0
  stack backtrace:

  CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.4.0-rc1 #1 PREEMPT(full)

  Call trace:
  check_wait_context.isra.0+0x2d8/0x380
  __lock_acquire+0x2ec/0x840
  lock_acquire.part.0+0xe0/0x250
  lock_acquire+0x8c/0x1e0
  _raw_spin_lock_irqsave+0x6c/0xd8
  regmap_lock_spinlock+0x20/0x40
  regmap_raw_read+0x88/0x328
  regmap_bulk_read+0x10c/0x340
  adc5_gen3_read+0x38/0x50 [qcom_spmi_adc5_gen3]
  adctm5_gen3_isr+0x90/0x130 [qcom_spmi_adc_tm5_gen3]

There is no requirement for any of the work done in the primary handler
to run in hardirq context. Drop the primary handler and move all the
actions in it to the threaded handler, which removes the invalid wait
context warning.

Reported-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Closes: https://lore.kernel.org/all/1cb6d902-73f3-4d65-96f4-4b3c5217253c@oss.qualcomm.com/
Fixes: 948ee3a74f35 ("thermal/drivers/qcom: add support for PMIC5 Gen3 ADC thermal monitoring")
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 41 +++++++--------------------
 1 file changed, 10 insertions(+), 31 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
index 910b241fa94d..996bfcfcac35 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
@@ -73,58 +73,38 @@ static int get_sdam_from_irq(struct adc_tm5_gen3_chip *adc_tm5, int irq)
 	return -ENOENT;
 }
 
-static irqreturn_t adctm5_gen3_isr(int irq, void *dev_id)
+static irqreturn_t adctm5_gen3_isr_thread(int irq, void *dev_id)
 {
 	struct adc_tm5_gen3_chip *adc_tm5 = dev_id;
-	int ret, sdam_num;
+	int sdam_index, ret;
 	u8 tm_status[2];
 	u8 status, val;
 
-	sdam_num = get_sdam_from_irq(adc_tm5, irq);
-	if (sdam_num < 0)
+	sdam_index = get_sdam_from_irq(adc_tm5, irq);
+	if (sdam_index < 0)
 		return IRQ_NONE;
 
-	ret = adc5_gen3_read(adc_tm5->dev_data, sdam_num, ADC5_GEN3_STATUS1,
+	ret = adc5_gen3_read(adc_tm5->dev_data, sdam_index, ADC5_GEN3_STATUS1,
 			     &status, sizeof(status));
 	if (ret)
 		return IRQ_NONE;
 
 	if (status & ADC5_GEN3_STATUS1_CONV_FAULT) {
 		val = ADC5_GEN3_CONV_ERR_CLR_REQ;
-		adc5_gen3_status_clear(adc_tm5->dev_data, sdam_num,
+		adc5_gen3_status_clear(adc_tm5->dev_data, sdam_index,
 				       ADC5_GEN3_CONV_ERR_CLR, &val, 1);
 		return IRQ_HANDLED;
 	}
 
-	ret = adc5_gen3_read(adc_tm5->dev_data, sdam_num, ADC5_GEN3_TM_HIGH_STS,
-			     tm_status, sizeof(tm_status));
-	if (ret)
-		return IRQ_NONE;
-
-	if (tm_status[0] || tm_status[1])
-		return IRQ_WAKE_THREAD;
-
-	return IRQ_NONE;
-}
-
-static irqreturn_t adctm5_gen3_isr_thread(int irq, void *dev_id)
-{
-	struct adc_tm5_gen3_chip *adc_tm5 = dev_id;
-	u8 tm_status[2];
-	int sdam_index;
-
-	sdam_index = get_sdam_from_irq(adc_tm5, irq);
-	if (sdam_index < 0)
-		return IRQ_NONE;
-
 	scoped_guard(adc5_gen3, adc_tm5) {
-		int ret;
-
 		ret = adc5_gen3_read(adc_tm5->dev_data, sdam_index, ADC5_GEN3_TM_HIGH_STS,
 				     tm_status, sizeof(tm_status));
 		if (ret)
 			return IRQ_NONE;
 
+		if (!(tm_status[0] || tm_status[1]))
+			return IRQ_NONE;
+
 		ret = adc5_gen3_status_clear(adc_tm5->dev_data, sdam_index,
 					     ADC5_GEN3_TM_HIGH_STS_CLR, tm_status,
 					     sizeof(tm_status));
@@ -405,8 +385,7 @@ static int adc_tm5_probe(struct auxiliary_device *aux_dev,
 
 		ret = devm_request_threaded_irq(dev,
 						adc_tm5->dev_data->base[i].irq,
-						adctm5_gen3_isr,
-						adctm5_gen3_isr_thread,
+						NULL, adctm5_gen3_isr_thread,
 						irq_flags,
 						adc_tm5->dev_data->base[i].irq_name,
 						adc_tm5);

---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261111-adctm5_gen3_hardirq_removal-467a437a78e1

Best regards,
--  
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>

