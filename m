Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B168377EDD
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 06:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780295896; cv=none; b=plwksZLD3BxmkFghB9xvT91lbyqZ409nw7dNA7v76RWlHQlzjOd3Nk0vg9GBJZ2Nq8ScZ3E9gUSdde3AHC6TH7asGXCPFzozXOG3uzlaT7ZOnyct2u+/y3v8Twdl4UHr+mEMy3AsEhoAS0dm69eNgyMYoNz5JLR4+G/teQ/Ydjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780295896; c=relaxed/simple;
	bh=MKOSKfy5HVKspOCH3nNHGWVz9K6OmlhyitqwNsphRo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hXxTeDkEvR0iPok5dA7Im+Dc+wyIAWHsxNkRRRnyGkHbVJ7UD3cknwEk/xOewDUFJmMg1bTEpSJWygmXkN8CuRQ2+e70fzaHsEg3df6FDroN6phcAyaSVCx5y5b1zVLWcwWNTN62romYV5g/tGz0LEJwy1Sh/6RtI079xOO/B0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fo1bvltx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LzPBv5rr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fo1bvltx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LzPBv5rr"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6511Gj7c772872
	for <linux-pm@vger.kernel.org>; Mon, 1 Jun 2026 06:38:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q+ZAvj5oFG/y4ZUnZyUxx7ksRw8f9xhtX9EZCxAOa6A=; b=fo1bvltxnWVYxHTK
	pcSArR0Vgty+pXAO/s1H/DeFLPs9z7JYv6IzJtoQbAi0hvFPkYOSVC65f2FhnzmY
	oXYhvfd1m8l9t50Q7iAmgmEQXhcCNup1YI/ZdA9TYvSJNVmRoldPcWxe28UL6L5W
	yz+8P7VkdANxeMHuuF4H4WXQWZd/QaFwW4ycPv9yQaxMqfngG5jT1wvuYaXqmrHl
	4RhAFsWikQ0a2xdDSxUvUtYzbQb3QUyamtmPe9Y4JEL8ggwmVuCvDpG0zd0wA4cu
	0bbFX8oVAzeyy7wh85dsStGDhEDnukOyaFuwE3iQRKefQYTLR3nrwpFXNbzw6XAc
	yViOdQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efxy7wcj8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 06:38:14 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8422b544a4bso1028799b3a.3
        for <linux-pm@vger.kernel.org>; Sun, 31 May 2026 23:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780295894; x=1780900694; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+ZAvj5oFG/y4ZUnZyUxx7ksRw8f9xhtX9EZCxAOa6A=;
        b=LzPBv5rrrF8VguoSPuuIznLlHEm4372ToruMeXQmyOUvX35ZnpsR9LcE8tttfttu97
         tohD24vpkYiDmTMVtiKp2IM23kbLJQWJcqBDUQFVoxwm+c0gKjnS6PyEGR9rMGuGAYC7
         aqK8ZWf+3IrrObjyd1wJIJuLTtoPRdkI6cuNP7g5nmNhKi8aZKsXZ0Q8n6VKX/hYrDtl
         hppi4FAkIUr3WWxyllIMmQ9C2rTVwjmhuMM9+mLLnSGWb9KYV6Ulm5oiyg4xnsYBGbR2
         EiGn4kUR1n76AsvWdZ0ODIBHbl2LP2oUbBqi0XtOCsXYPWTm6vZSBHZfdrKEBbtQ7f04
         qQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780295894; x=1780900694;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q+ZAvj5oFG/y4ZUnZyUxx7ksRw8f9xhtX9EZCxAOa6A=;
        b=oF1sfICWCS8+PKiOfvX9MyJ4FEv7kjsJoSBJCYhT8cTquBOGI5mkhp+2atdu6yjFqe
         5z+pfaFGVhwq+QJUub3lebc2cR+/oMLD8GS3cbfOVNJ0+DSp6hNPmb4TXwIetLROsEcD
         H04WfwbPdzBTgGZiBxQ7rqpS6VRi0J7wXLhfSRX4NvTDFX4kw7OsYSgjNGRwYQ4cYyS2
         /EhpCmCjz4sqaBrWGtvTHGV8jJ3M55RpqALKZyH36mvBCRxa8Rg4LDO8ZasTZFyidyYW
         FECkzH1B/3WPaFz6iY+YSFm6rAj1zd248JvTgLrGPO/X8eaiWtkf7NLVRSCXY1X2RqwS
         Ktpw==
X-Forwarded-Encrypted: i=1; AFNElJ+bS3ipKj9nvfWAGp0MzlebqGHqt+7vT+wg3N0ePCNDvuShyEUrRTyZnP3XEIrDu0YBZ89KxG6ytg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yycz8SmbvMBTpqznlnf4Nb0Md6hX2TVO9gTN+vTvi2YeGYdBsbP
	rsuzvATxy1tHVh6UoQ2c+8uPKuVDz3BCOVIHaIrBUZKQk1NkVqVb2MWQVpgNpZ6juB0H6/3PGfz
	Kn3d0MJJJhAVaCfoyK+505YGnBWexEKOYFPyKRBBr0ZuOcUx7FJ+XUqxP+Au9Wg==
X-Gm-Gg: Acq92OEqfF5hLxy7ZsghdWQ7665YcSLXiGX5VbJ/oM8Vd2L1ejyDe95E53Au52upjRF
	DStNmCnsLOHwfGDgY1A072HF7SulQ92mBK5tDdK++n8aZk+YbzYC36pLuiUr5z5iakpUPHLCecG
	pU16IhQp4B1Vr+MCM36D4LJk3q9hE9Z6Z1qS7ipMX/Z1eq136FVeFFk0bEsXdnJxzxECEpbGAxt
	JG96T+pQEYs4Kb4i3VCOfmYYNbvLMhe/pHouElclMgM8YlBIEfM+puQ7x10BpCOMvd3B3Vccw0U
	R92acDBaqgveAiRHDXCoiFyFMltpPk0wy/h9PQNfrLs0UQn2Nk79EdPD3xN8+mZp3Wi9m0Rd1as
	CzYrzaSN0tN0JTEz4bB/5iwzeBgG68YC9mSIC9OE3atf/PFoOKF1i0mgNveDcEbI1mQ==
X-Received: by 2002:a05:6a00:2186:b0:82f:1b1b:e166 with SMTP id d2e1a72fcca58-84225490c67mr9382052b3a.33.1780295894047;
        Sun, 31 May 2026 23:38:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:2186:b0:82f:1b1b:e166 with SMTP id d2e1a72fcca58-84225490c67mr9382027b3a.33.1780295893597;
        Sun, 31 May 2026 23:38:13 -0700 (PDT)
Received: from hu-priyjain-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214c9252bsm9321358b3a.39.2026.05.31.23.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 23:38:13 -0700 (PDT)
From: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 12:07:57 +0530
Subject: [PATCH v2 2/2] thermal: qcom: tsens: Disable wakeup interrupt
 setup on automotive targets
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-tsens_interrupt_wake_control-v2-2-ce9570946abd@oss.qualcomm.com>
References: <20260601-tsens_interrupt_wake_control-v2-0-ce9570946abd@oss.qualcomm.com>
In-Reply-To: <20260601-tsens_interrupt_wake_control-v2-0-ce9570946abd@oss.qualcomm.com>
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780295882; l=3513;
 i=priyansh.jain@oss.qualcomm.com; s=20260515; h=from:subject:message-id;
 bh=MKOSKfy5HVKspOCH3nNHGWVz9K6OmlhyitqwNsphRo8=;
 b=t22Pgs2NN0JJK/dfiohdEJGJBmzt/RmIaKXEW/bqpEyFcV/SGVIQFmimoAg3k/5Bnyi/zrPWe
 mTylDvkmCGdBum7wMBxPAAy+IHQVCIXl0YyyblwNFXa7EOFbFR/ayTh
X-Developer-Key: i=priyansh.jain@oss.qualcomm.com; a=ed25519;
 pk=xe57jjgIoTuNHN/Dp00kZl1mAJjmROaH7JV9sRxEoEQ=
X-Authority-Analysis: v=2.4 cv=POg/P/qC c=1 sm=1 tr=0 ts=6a1d28d6 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=PJyjg1ohnCiW5JLUlNMA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA2NCBTYWx0ZWRfX5dwSrzcSpeA3
 +O7JR/ZFScWYFdiH2/NgvywjOy9j2/3/i9BIFLhblrraL82+/V2OWYpZ4ynf8m6/XWKVt+rqjsp
 /fpNwQ5dXNnVl+dAdHu1oZpQlLL3gLgg8+MA0pqvapMWBDBJaZTMkb4105eeNkfV6JYWI0cFFus
 2ThcbuamUIgIS6syBeY2q+C2qd22pxepJsU3OZXxaSQaT7v3D2Cc7TLFeZwryxyBCtmEg1tqGG+
 ayAa4IMWZy5vgggbbff/2hH4uLO0NnBS2EwSepY0nnwj2zx+9rKk8tXQA5BoDnZxyVjwKk1pRf7
 FddHo2AX5U0uEmQ19AfbHFU7zfI9gnPX0Q2qqCZ1Aw86L3h/MPeZzCFjA4gHqtX3KZaD2BW+ZiP
 XI08+B6/Y6F1z1rbCMrDIiaJXnUtEug9TjDvoGRUfhnH8NgDnCmB/0qKU9YofjSuLPAyOMqtTV+
 iNGHZsTCwCrrXJkSvJA==
X-Proofpoint-ORIG-GUID: hhxiu-8OKINfQUOWkYMi-lTZ-jrppPuO
X-Proofpoint-GUID: hhxiu-8OKINfQUOWkYMi-lTZ-jrppPuO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010064

Add a no_irq_wake flag to struct tsens_plat_data to allow platforms
to control whether TSENS interrupts should be configured as wakeup
sources.

Create a new data_automotive structure and add compatible strings for
automotive TSENS variants (SA8775P, SA8255P) with wakeup interrupts
disabled.

Automotive platforms can enter a low-power parking suspend state where the
application processors and thermal mitigation paths are not active. In this
state, waking the system due to TSENS threshold interrupts does not enable
useful thermal action, but it does repeatedly break suspend residency and
increase battery drain.

Allow these automotive variants to keep TSENS monitoring enabled during
normal runtime while opting out of TSENS wakeup interrupts during suspend,
so the system can remain in low power until ignition/resume.

Signed-off-by: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
---
 drivers/thermal/qcom/tsens-v2.c | 8 ++++++++
 drivers/thermal/qcom/tsens.c    | 8 +++++++-
 drivers/thermal/qcom/tsens.h    | 5 +++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index e06f8e5802e8..2ee117aa91ba 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -306,3 +306,11 @@ struct tsens_plat_data data_8996 = {
 	.feat		= &tsens_v2_feat,
 	.fields	= tsens_v2_regfields,
 };
+
+/* Do not enable wakeup capable interrupts for automotive platforms */
+struct tsens_plat_data data_automotive_v2 = {
+	.ops		= &ops_generic_v2,
+	.feat		= &tsens_v2_feat,
+	.fields		= tsens_v2_regfields,
+	.no_irq_wake = true,
+};
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 5210985b3767..6237e000640b 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1169,6 +1169,12 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,tsens-v2",
 		.data = &data_tsens_v2,
+	}, {
+		.compatible = "qcom,sa8775p-tsens",
+		.data = &data_automotive_v2,
+	}, {
+		.compatible = "qcom,sa8255p-tsens",
+		.data = &data_automotive_v2,
 	},
 	{}
 };
@@ -1381,7 +1387,7 @@ static int tsens_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	device_init_wakeup(dev, true);
+	device_init_wakeup(dev, !data->no_irq_wake);
 
 	if (!priv->ops || !priv->ops->init || !priv->ops->get_temp)
 		return -EINVAL;
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 5e2da4e0d51b..d20d514bf8ce 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -531,6 +531,7 @@ struct tsens_features {
  * @hw_ids: Subset of sensors ids supported by platform, if not the first n
  * @feat: features of the IP
  * @fields: bitfield locations
+ * @no_irq_wake: if set, TSENS interrupts will not be configured as wakeup sources
  */
 struct tsens_plat_data {
 	const u32		num_sensors;
@@ -538,6 +539,7 @@ struct tsens_plat_data {
 	unsigned int		*hw_ids;
 	struct tsens_features	*feat;
 	const struct reg_field		*fields;
+	bool		no_irq_wake;
 };
 
 /**
@@ -675,4 +677,7 @@ extern const struct tsens_plat_data data_ipq5018;
 extern struct tsens_plat_data data_8996, data_ipq8074, data_tsens_v2;
 extern const struct tsens_plat_data data_ipq5332, data_ipq5424;
 
+/* TSENS automotive targets */
+extern struct tsens_plat_data data_automotive_v2;
+
 #endif /* __QCOM_TSENS_H__ */

-- 
2.43.0

