Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8A5377010
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 06:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780295894; cv=none; b=rUrTHzprtXc04UMUrZEhlQi8I1y2tbfunWo8Gl1JBk3uy0H22CySyKoOXBuA6acI/3hvjFz3G2uEGuvlmt3BodzUY/agOUVY9zlc10eVRy2nvmPi5LLiN5eZJBrhQVVraJaZgQoHyAI7awm8PjTu8mWJBdP8uFDlVy64A/u/H9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780295894; c=relaxed/simple;
	bh=Y0JrFTV5T0FffiMthuYxPMnO5mjs0Hi/IfUnmNg51OE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KRsS6hLi/+7VgBhjZHc5eK7kH2BFk0EoBj3HsnspjJ3Cp+zVbvQ71OPGByyz4UYq50K41OGMIVjOK99ycoYQvLz0Ehd+FsOFS+13C00/3JteGqpINy3c5qDV4TkWh3K9LWLX65aJ5KnT4DJ8UHuiXJFS96q/Hn6MgZJxrOzuw/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kn99TrSV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kvdk5GRb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kn99TrSV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kvdk5GRb"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6516bJch1183146
	for <linux-pm@vger.kernel.org>; Mon, 1 Jun 2026 06:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CxZPef7xjYmwBeDaOPNB0KkqX4i6Nl78lGfvpZ8AaMU=; b=Kn99TrSVqxqpFWY4
	V6anuhg0bpzlUKNNPGCPY2uKERLi3rOG1GYkDt/laOfifDrIewDIxL6anESW5//S
	oqq235RzKbzLQD8f2fdBuvdcGIUpvrczus47otEuKotYO0pld+aSCoi6dql38fdo
	TaSa25IS3RwY89bP4aDL6xN3eKhWoBOf1wnLTVCT20zws+VXSCXQmaOxQJsRax8n
	JDlzmXwnrDHm1PUFVOfViKc9XkrBMqqjWXuBlhWV8xedFScOSVWz/GrkHgAf1y36
	Ed1SzYIBCN9fD6TO9xTPE3/2W5EBJaCuDsSXDz5V0u0th6XX6MxDbdxBQBQaWy4b
	VOMC5A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efr41e45d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 06:38:11 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8423efbfb61so719977b3a.0
        for <linux-pm@vger.kernel.org>; Sun, 31 May 2026 23:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780295891; x=1780900691; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CxZPef7xjYmwBeDaOPNB0KkqX4i6Nl78lGfvpZ8AaMU=;
        b=kvdk5GRb89b0kJY75C8mx7UROo81deAvP+A4UQL2iHXeQcTR9mhiASUpSZY6OeToZp
         pzRYBO704pStd/sx/uBWqWmydFWYszzx4yZnuP9XfR7iat8We/AwsE4gLtl1hjxoCxb4
         XWvIDsn9yqEyR1YZ2UMaRPBhuNHVvQV1oa/15cM23uQd66YaQ8TMfDTF60m1rCS0xG55
         U76CCIpFzpuwaFngmRT/1neegdnwFmVlYuXVOAnlLUnDICyt7NtWNIC2jGk1b5geT4Uk
         va6ZDCBCzpRyniUT9eJDEnCmU+hdETb/iUyYofox+4A65mdVcqYDo/C5+ydI4sArsSl/
         qGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780295891; x=1780900691;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CxZPef7xjYmwBeDaOPNB0KkqX4i6Nl78lGfvpZ8AaMU=;
        b=Oa10icaoiyuZ7OxRu45D1LFOApNDiMzs/8F+TTwh+E//XIfYHkNBb9IeECO2YZowB0
         3kixZPV2zGmjtZtKwDOgrIjdUUpRzuL4tJZjbEGGenteUzNHXy3u4wv/ZLz5+PiQH7xM
         Y/DH0IqEoLgbjOiT1EPamkdLPfGJn+2HXUSE1GWvhqstt1UK557X6Zo1xReonizOz4GY
         S7nXsHZL1HcGtALJvKUsvg3RehbpxuFHOVOSN7MP2NIwc3+/9No3sviduKCah2dGInz1
         iYvjeBWzsH0Ic6/urFr8HKeGrKk+QqeNRqslg+LNadcClQqpNHlR59mT6XV6XMhM0w7g
         ZFxA==
X-Forwarded-Encrypted: i=1; AFNElJ8R6eAgR8z2u/mMJHn6Wl+0J6RIYkLMQ//9C61wW0/QJ6RmvfV6ue4Rf2oeXzvs4KoqcvUWrnhGQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTUlYFj1M8FHdW9DFt5G1+cmSQMsh1o5tWZzPg7zQJ5fXiKhdg
	A6Tmzy9U6a58n6sT1+j57NqmiNyNSSba3hXoC5CQghP6dK1hDEeV5PADMhpFOOYWgowqxE5sCgu
	0qUyaidl6lUyEueeyl7a3n+Q3QIpPbTCtjFuCP1cVQ2djZciPpGqlPIMG08pnHA==
X-Gm-Gg: Acq92OF//Dr0aRgL2XbYOMId0YZiRRlFcTkIR/J9QLeCsH0+L/Irto1XQ9OKphJWC/i
	UVpj9WTqKpFwXGHmPGbDkgku0D9BdiyS1d/pKh9SKYTNRU5ZMZnv3yCTdqs/0QmONgssLe6XFjT
	CZJEMusR9z/4ROjOMxLdPjJjENo2UfYYw3wbRPizzXfiZaCGkgqtfIBwUcxeAmAynHGhWHueiQy
	recGYPLdaem0/J/B1dfzMA0vQbFP8ANW8hn0f3iynxWKWPA4Esyod2UQ4a7CkL11KKjIVk/UgYM
	igUUfJbSMiv+EdTQGhk3iNVRNvnH/mdW0Dg110tbapmQ3pFXKzSorHylPlJzOnzQSzLzLduP2/D
	faSjpJbKoUmBOkAuMFJYJS/M+LSwzOVqj6U4lgPgAnjML75aRdteq9Mt9Ya/MF0nIUg==
X-Received: by 2002:a05:6a00:908a:b0:837:e9cc:d46e with SMTP id d2e1a72fcca58-842253ed743mr8613001b3a.21.1780295890583;
        Sun, 31 May 2026 23:38:10 -0700 (PDT)
X-Received: by 2002:a05:6a00:908a:b0:837:e9cc:d46e with SMTP id d2e1a72fcca58-842253ed743mr8612972b3a.21.1780295890057;
        Sun, 31 May 2026 23:38:10 -0700 (PDT)
Received: from hu-priyjain-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214c9252bsm9321358b3a.39.2026.05.31.23.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 23:38:09 -0700 (PDT)
From: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 12:07:56 +0530
Subject: [PATCH v2 1/2] thermal: qcom: tsens: switch wake IRQ handling to
 PM callbacks
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-tsens_interrupt_wake_control-v2-1-ce9570946abd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780295882; l=6214;
 i=priyansh.jain@oss.qualcomm.com; s=20260515; h=from:subject:message-id;
 bh=Y0JrFTV5T0FffiMthuYxPMnO5mjs0Hi/IfUnmNg51OE=;
 b=+RGFVW+oPzJbQpCxrIOFCGwa4Inv02vOLnFFKXCdx0pmy1EaO6ms0vyl7/9LOxPzZqtM/vdBs
 mnNGU1VqYHDDrK3dUwcpGY43G8LpswzxFSaR8sKZqXP248UhQcS36mJ
X-Developer-Key: i=priyansh.jain@oss.qualcomm.com; a=ed25519;
 pk=xe57jjgIoTuNHN/Dp00kZl1mAJjmROaH7JV9sRxEoEQ=
X-Authority-Analysis: v=2.4 cv=fOEJG5ae c=1 sm=1 tr=0 ts=6a1d28d3 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Y1N8Ec-qMYIBCvTlKQUA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: 2rMOnSUzmNIDSqZD8jjd51I-6n3zB4kY
X-Proofpoint-GUID: 2rMOnSUzmNIDSqZD8jjd51I-6n3zB4kY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA2NCBTYWx0ZWRfXzHvS/UGGHkmH
 FVQudkUpAQ4yT1eu2W7cByZG7UchqouE3KtLPOpdhLYS2l5pmu5/tEX7kGvuTTL48QJllb2LvZX
 svfzYiXkfhIDxjWwhdXTuyjSkSrKDtyxrU2cHjEDduB/cVst6QN8AJSnI3TiNjVZoIfwFitUlZE
 aojblMRIGz7Rwmu7i6AS3GItTAe4+fJ7wPgyTcHvTSLVwUZCuJvkHYu00jVTzrkxa4w7ytfkPrA
 uK+iZYcRiV+wemhiy/6z75nC+1EPAqbDDinfjb8hMp0Jnsj8JQxq20oPM6KdUoI/yzE+IjoT+qr
 fcIpnxXVuAQuYm8g5lsWR0KUJeA+YvA+gAcsL3lIFZUs54zA+/nF7KRz1NSbm0VTj5Hn2Xl2Ekg
 a7QgaOEJUe4bFipCPPyXWO+ClbasafbKe/2iRnG2lLeN1L0Eb7lvZ5wdjAaEusjjDPNHO14oVLb
 /SX0nz0cwyREj3bn2KQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010064

This change improves power management by using the standardized PM
framework for wake IRQ handling.

Move wake IRQ control to the PM suspend/resume path:
- store uplow/critical IRQ numbers in struct tsens_priv
- enable wake IRQs in tsens_suspend_common() when wakeup is allowed
- disable wake IRQs in tsens_resume_common()
- mark the device wakeup-capable during probe

This aligns TSENS wake behavior with suspend flow and avoids keeping
wake IRQs permanently enabled during runtime.

Signed-off-by: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
---
 drivers/thermal/qcom/tsens-v2.c |  1 -
 drivers/thermal/qcom/tsens.c    | 64 +++++++++++++++++++++++++++++++++--------
 drivers/thermal/qcom/tsens.h    | 18 +++++++++++-
 3 files changed, 69 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 8d9698ea3ec4..e06f8e5802e8 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -263,7 +263,6 @@ static int __init init_tsens_v2_no_rpm(struct tsens_priv *priv)
 static const struct tsens_ops ops_generic_v2 = {
 	.init		= init_common,
 	.get_temp	= get_temp_tsens_valid,
-	.resume		= tsens_resume_common,
 };
 
 struct tsens_plat_data data_tsens_v2 = {
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index a2422ebee816..5210985b3767 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1086,22 +1086,30 @@ static int tsens_get_temp(struct thermal_zone_device *tz, int *temp)
 
 static int  __maybe_unused tsens_suspend(struct device *dev)
 {
+	int ret = 0;
 	struct tsens_priv *priv = dev_get_drvdata(dev);
 
-	if (priv->ops && priv->ops->suspend)
-		return priv->ops->suspend(priv);
+	if (priv->ops && priv->ops->suspend) {
+		ret = priv->ops->suspend(priv);
+		if (ret)
+			return ret;
+	}
 
-	return 0;
+	return tsens_suspend_common(priv);
 }
 
 static int __maybe_unused tsens_resume(struct device *dev)
 {
+	int ret = 0;
 	struct tsens_priv *priv = dev_get_drvdata(dev);
 
-	if (priv->ops && priv->ops->resume)
-		return priv->ops->resume(priv);
+	if (priv->ops && priv->ops->resume) {
+		ret = priv->ops->resume(priv);
+		if (ret)
+			return ret;
+	}
 
-	return 0;
+	return tsens_resume_common(priv);
 }
 
 static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
@@ -1172,7 +1180,7 @@ static const struct thermal_zone_device_ops tsens_of_ops = {
 };
 
 static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
-			      irq_handler_t thread_fn)
+			      irq_handler_t thread_fn, int *irq_num)
 {
 	struct platform_device *pdev;
 	int ret, irq;
@@ -1205,7 +1213,7 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
 			dev_err(&pdev->dev, "%s: failed to get irq\n",
 				__func__);
 		else
-			enable_irq_wake(irq);
+			*irq_num = irq;
 	}
 
 	put_device(&pdev->dev);
@@ -1232,11 +1240,38 @@ static int tsens_reinit(struct tsens_priv *priv)
 	return 0;
 }
 
+int tsens_suspend_common(struct tsens_priv *priv)
+{
+	if (!device_may_wakeup(priv->dev))
+		return 0;
+
+	if (priv->feat->combo_int)
+		enable_irq_wake(priv->combined_irq);
+	else {
+		enable_irq_wake(priv->uplow_irq);
+		if (priv->feat->crit_int)
+			enable_irq_wake(priv->crit_irq);
+	}
+
+	return 0;
+}
+
 int tsens_resume_common(struct tsens_priv *priv)
 {
 	if (pm_suspend_target_state == PM_SUSPEND_MEM)
 		tsens_reinit(priv);
 
+	if (!device_may_wakeup(priv->dev))
+		return 0;
+
+	if (priv->feat->combo_int)
+		disable_irq_wake(priv->combined_irq);
+	else {
+		disable_irq_wake(priv->uplow_irq);
+		if (priv->feat->crit_int)
+			disable_irq_wake(priv->crit_irq);
+	}
+
 	return 0;
 }
 
@@ -1276,15 +1311,18 @@ static int tsens_register(struct tsens_priv *priv)
 
 	if (priv->feat->combo_int) {
 		ret = tsens_register_irq(priv, "combined",
-					 tsens_combined_irq_thread);
+					 tsens_combined_irq_thread,  &priv->combined_irq);
 	} else {
-		ret = tsens_register_irq(priv, "uplow", tsens_irq_thread);
+		ret = tsens_register_irq(priv, "uplow", tsens_irq_thread,
+					 &priv->uplow_irq);
 		if (ret < 0)
 			return ret;
 
-		if (priv->feat->crit_int)
+		if (priv->feat->crit_int) {
 			ret = tsens_register_irq(priv, "critical",
-						 tsens_critical_irq_thread);
+						 tsens_critical_irq_thread,
+						 &priv->crit_irq);
+		}
 	}
 
 	return ret;
@@ -1343,6 +1381,8 @@ static int tsens_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
+	device_init_wakeup(dev, true);
+
 	if (!priv->ops || !priv->ops->init || !priv->ops->get_temp)
 		return -EINVAL;
 
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 2a7afa4c899b..5e2da4e0d51b 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -567,6 +567,9 @@ struct tsens_context {
  * @ops: pointer to list of callbacks supported by this device
  * @debug_root: pointer to debugfs dentry for all tsens
  * @debug: pointer to debugfs dentry for tsens controller
+ * @uplow_irq: IRQ number for uplow (upper/lower) threshold interrupts
+ * @crit_irq: IRQ number for critical threshold interrupts
+ * @combined_irq: IRQ number for combined threshold interrupts
  * @sensor: list of sensors attached to this device
  */
 struct tsens_priv {
@@ -588,6 +591,10 @@ struct tsens_priv {
 	struct dentry			*debug_root;
 	struct dentry			*debug;
 
+	int				uplow_irq;
+	int				crit_irq;
+	int				combined_irq;
+
 	struct tsens_sensor		sensor[] __counted_by(num_sensors);
 };
 
@@ -639,8 +646,17 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp);
 int get_temp_common(const struct tsens_sensor *s, int *temp);
 #ifdef CONFIG_SUSPEND
 int tsens_resume_common(struct tsens_priv *priv);
+int tsens_suspend_common(struct tsens_priv *priv);
 #else
-#define tsens_resume_common            NULL
+static inline int tsens_resume_common(struct tsens_priv *priv)
+{
+	return 0;
+}
+
+static inline int tsens_suspend_common(struct tsens_priv *priv)
+{
+	return 0;
+}
 #endif
 
 /* TSENS target */

-- 
2.43.0

