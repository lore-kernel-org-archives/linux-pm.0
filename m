Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F013DCD98
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779790755; cv=none; b=mdD3n3+wt3qu3Vdkxxuo5eBxqaOin6x+cyfvcOjRUj0Orszdr9cCRZGyT5TXBvpSS9/o0VEmrNXoo1TpXFgdc3tkTz3neFJOVEr00q1nBIwBJ1vtYBuD6frXK+JJcPc+LgMejrdXZw4ke0m9tYU1RcBXkYXCjb6+Zo3OQzEe9Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779790755; c=relaxed/simple;
	bh=KMog7D1zSTb8wnRR6eVYIq9bcVDVinAsuMOUfZaTXa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j+N97O6uCYCr1H550zkbnlAZ7/hv9Y9lTeR6da8m939oqMJL7fbY1J4z2S5DTRNHHPqATZoFXLYp8ctidcyWwFtZi1M4d6dZMHlRJfd0ppkzqWw0kVcH+cBuGeOI+kEXi94AA2aVAcxdBH0RGAiFz60/WgQSN2e7gd0arI+uGzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pnmsWBJ4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C+tOicET; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pnmsWBJ4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C+tOicET"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q7xoMH725834
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 10:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HK4haDG9Zw0Swz2Z7gX/R9iwSWL5VczHkBfklVCM2EE=; b=pnmsWBJ41qk5TWH8
	jQVHcqAMDVispRExzQX0iHCAN7AoZFvSNhabcUnLIiznO3ENhMrxYxS01yvk+N4n
	TH2SKQdFvDbz8vYrCm1crDucbg6YURsCxOunJ0zJuXXW12sdcjKm7JvPn8zQoNmp
	/YtqBBQcsLd9k1G/Ub1+baSg7n+/dG2v/9uRe1g3IV09kq4sROx/fcGMjoQkx5bT
	3QNlUvMRKesZ2U6BmC+FgAMLmjqvoqfUkRxATPqPafpNeI/qpYiHZ4r+XnL6mHzo
	Nys0Q2xQDgomwqBsnUwBPWmzxE6/WTEr1X8yeVZcZ0OZJMzgVHcjRzVH/4ENwTln
	Tmfxbw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecnhs3x0r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 10:19:12 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ba3245a43dso115960075ad.0
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 03:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779790752; x=1780395552; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HK4haDG9Zw0Swz2Z7gX/R9iwSWL5VczHkBfklVCM2EE=;
        b=C+tOicETUunii1v9VxpxhYU+Cyn7ISMGN3nf0D4x5HjSmDKLMb+ETLwVP1R85dCCrg
         fTMtBcLMmp3qQ31BieQeoXHw25J7lUu77Y4LsWRTxS3wmDBNwQt7ICkGRlzeF+E70XYA
         Ng75O24i/Caev8UVkYJNlB9DHJZGQSAAvnHd0HdEdPWg1K2ClRpQFimG1uW6/8G1oeZj
         xt0BlVDDDZxCoNJ58vBb+uLqhk4ebeqnSd4TBrq+4m9JiOIOA3mSaVVp3sxMn+QEsp2c
         v+RczqinevkeeFuGk6lVw0bO7EV9PJMkrxXjdjfXhZtsDZFGw+5F/koMRSSbuEsPdvsT
         RcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779790752; x=1780395552;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HK4haDG9Zw0Swz2Z7gX/R9iwSWL5VczHkBfklVCM2EE=;
        b=KXyLyMNblvXxMudeDcuNZmY5IVLk1nOQwkrMUN8wb5UZvHBD/5q0NBFq50n/H74x9q
         xjQUeQY3+Gv3nTG6AH2KqF3zaNwDic5Xpqz4JEDg7Yy1GGI1nBdpjQXbtJhCzskwweKM
         ahDd0m6yN3RS0KkO5qAgxz/VyaI9aoxrCQ2HgHBkm1/VN6Bf/5Z4QfN5qOBr2ib+epfg
         /VOTCfafYGH6ZErVmATPwpHey+OxX+WWc/NbPiGleoEf77EOVv4d9Dm8ZqCTZTvDe253
         qA6+jl0H9L4t5TTBuvkhvSStYw2u/Ot3yFL/Yc0q2MDXGsqrCk0gi5oEB6za+ZzkbKOS
         AdHQ==
X-Forwarded-Encrypted: i=1; AFNElJ8oNXIxGF8MsrnUYz+ui1oEPcSyboxpCY4iLce0Q1XcgWa7ZsfqPqHPOY3ypkfDW4prkubKOPXmSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOzhJMg4XrAjFZKKuY3W0ArQCcagfS/QzFjMTamw1n91vOfjhx
	cZmUHxehobFmy/JkOi2+dXVYKKJOxve5MAHTGIF9BESlzCj/gi03+CxIZHQhvNB50yYbx7owfON
	0KUZVogPPqlmP0b254yD3hWWyd/aroDJqpMiC9+pTuQVJDN5CJ17yKZMvfk9oWw==
X-Gm-Gg: Acq92OEykkRlkLQA9s7z2TXKqe47mBvAAIRuX4BPy50BcKUAkfuj44VeTd3GevKY+8h
	MWajnoAcKOTH+d0SvAyYqOKUliPNhs+BXyyeKTX6qvrr6+CapwM+5iloANUAqRy750ZlSeHYQJI
	y2GVtU+fQtLQmpKkUcAgk10hEquxxu02+kelQ7dx7vCXzjN5aYH62JpnPLBV64dSToYQeQMTJbj
	szsrYU0ATq28thlF6bq1Gi+HUU94lm2TdZw7ThZ4sOk5tiBOH8nK84M/MHwjvfzcUeQNJwphXI2
	90RJaxQDjaa7Ax5wQvqWl9+hcuh+N94lRAdEUE0Psg0wkIrJgX7cnkEE8tlzJ0V4CD1HiIBHvTq
	EkFFeHnL/Nls0MrSaTJF8Sw2Q3Pn+hl1QRKz7LRWMVPPS7jyEIldrc4M=
X-Received: by 2002:a17:903:2f05:b0:2be:1eb1:eaf7 with SMTP id d9443c01a7336-2beb05b5f70mr210314155ad.24.1779790751855;
        Tue, 26 May 2026 03:19:11 -0700 (PDT)
X-Received: by 2002:a17:903:2f05:b0:2be:1eb1:eaf7 with SMTP id d9443c01a7336-2beb05b5f70mr210313735ad.24.1779790751362;
        Tue, 26 May 2026 03:19:11 -0700 (PDT)
Received: from hu-priyjain-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56f4343sm159941105ad.36.2026.05.26.03.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 03:19:11 -0700 (PDT)
From: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
Date: Tue, 26 May 2026 15:48:37 +0530
Subject: [PATCH 2/2] thermal: qcom: tsens: Disable wakeup interrupt setup
 on automotive targets
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-tsens_interrupt_wake_control-v1-2-6adcd75555b9@oss.qualcomm.com>
References: <20260526-tsens_interrupt_wake_control-v1-0-6adcd75555b9@oss.qualcomm.com>
In-Reply-To: <20260526-tsens_interrupt_wake_control-v1-0-6adcd75555b9@oss.qualcomm.com>
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779790740; l=3513;
 i=priyansh.jain@oss.qualcomm.com; s=20260515; h=from:subject:message-id;
 bh=KMog7D1zSTb8wnRR6eVYIq9bcVDVinAsuMOUfZaTXa4=;
 b=IErSAVzT/vxwTzZ2wtnW20AlPPBuxWakHuH0Ssd+W/qSR0d4lX6e/Y/tnc8l6ns3FzjFm25Xs
 pNgnhkboH7eBa+NIc3yEyrlowEIZ1FVt2o+2VNcEUk84vcUCplC7aVH
X-Developer-Key: i=priyansh.jain@oss.qualcomm.com; a=ed25519;
 pk=xe57jjgIoTuNHN/Dp00kZl1mAJjmROaH7JV9sRxEoEQ=
X-Authority-Analysis: v=2.4 cv=Vd3H+lp9 c=1 sm=1 tr=0 ts=6a1573a1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=PJyjg1ohnCiW5JLUlNMA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: gSwSEMcZUuvPFBev_Lp58PiHV4Mol_ff
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA4OCBTYWx0ZWRfX8vwRhy44Zqgy
 RD8e4DddZ4M6YUjowCx00NitbSaaVkGs5kgp2BGV7cXBqPL/oGxmawqeWzC+0O9IEKARTtMJ5nm
 nbO7+3eGiSxf3TdX4SFolW7lZ/BkBZwspvWvDlXBwWBPjPPCz4hViGa3/eRsGiV+36Jh+Ml+nYY
 5HznU/SP/ozTkVPcbzZZ/aEWLD6rIj/Z47XcDQP+cG+A7Qqda9NAnNGAGQeOKXevLpY6lm2HHl6
 HrwX8xXfmt6MWi0AitU/WrNtu+ppGRkbyBXxLku61M9Ixav9rowv1uEysJRdjJKvp/VWb8uLMyW
 TZLD4uUc1wvjRGm45wOC6Y4meswYcl9vnsjNroJKeaZp7h2a2RbbEL/nDBT8vUgWspCMsWs9CU9
 myICNozobyb9NN1TxO30v/DEwYfIQppbNRx4DD6EHok9j5GCShGPtogbJZzyQ6lFFDtGZR6ntbP
 hOK4ei/49B/nBEt5B+w==
X-Proofpoint-ORIG-GUID: gSwSEMcZUuvPFBev_Lp58PiHV4Mol_ff
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260088

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
index d5d880a2aa08..71ab62e927db 100644
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
@@ -1387,7 +1393,7 @@ static int tsens_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	device_init_wakeup(dev, true);
+	device_init_wakeup(dev, !data->no_irq_wake);
 
 	if (!priv->ops || !priv->ops->init || !priv->ops->get_temp)
 		return -EINVAL;
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 83a8f3580ed0..f4bb5ee9a2a8 100644
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

