Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5125E3B1EE2
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778758614; cv=none; b=d6n4E0pUrkSobMkbUL6W/ECdca5GTVtbefpQCfYoAfjhNNOujFWXyU2yp0lL4s694VwINfT6vKDNKPHBqHqAPGUFpjo9itHFXT/7Lypc62uJWzRKuI6dFpDQFH6q7Co2OD/W1tB6A433XVnvMp5fbOX721kK9Jjn/Hvr7ZUw1bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778758614; c=relaxed/simple;
	bh=DG5RTzkKQb9dNd7h3PMz3Uho11h1YkmAiGNLFN6vKD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yn8KtQHvlDrYIppwa+7HbPACA+LoN6c2N0kCip4R5o+3DCVdtHPGzRigUvXqKt8d9bLe7Go6feOQh0/QfqK/3D3WwQA8LpM5nIGjXC8ZGC9zuU/JXaQCTmCz3Hf04UEiPuqx6OUMiYk9IKmW6hLuZbzdfLI+TOG/m9ERC3RhR5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WEGaNaHB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kOJvJQsu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WEGaNaHB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kOJvJQsu"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E9k8Jh1990775
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 11:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=qN16thgwwCwB2Rdns6XBfhr/Ra0hBXWE7M0
	kvmpsYQA=; b=WEGaNaHBFTPS1V9JNwpy/ptJJBgh+DuoaNWj6RbM8WdIIeRz+uM
	4Jtnz7ddnGcDbP+R+qdm1lmGSxl0ugNxDW5ruw6Hzez970JTlHvLal2JcJYAXMFU
	j5kJmCzguULAWfBlQsKFMSIOcvVcHKZbfk0LSCub663cUPKEUF1pRpbtee8O78Tw
	SrqekMkyKz8cjjvezzZBp57GE3TjMOgLsPouGErMHXig3MwOXVcKrwWikYsT9i86
	e2Sfhbj97qUkgDdII6I2WPXHwg2SYTepUXW7Y8AXQbpXjaY+GltILRjw+Zj+qw31
	TKbwygNng+6tGL9caTixTIPsgYz7NAktTjg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e513gaesj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 11:36:52 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bd6aeb3637so6333585ad.2
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 04:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778758612; x=1779363412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qN16thgwwCwB2Rdns6XBfhr/Ra0hBXWE7M0kvmpsYQA=;
        b=kOJvJQsuC/2soMqbdmJxSOd+VQQJZ1kf4I1qZ7Sg3+eJlI9a4XMLmncvKGmq5tP75J
         KmfG9tpXT6rKSmWl0Wy4Ebn19SRnRt+Sk6RemRmUQVtDPcZMqLNW94icWHh3Vu9vpbzL
         Ug2VnJ53/T5uMll1CuiHaqRU2EZGlQn4pjJIzoD/rIdZK+nDURx3Np7asHbSan9/nYM+
         Y7vpauN60c8jJxvd6u7qerKgMlG2S2wHgA8cXapkclNR2dzvf+FG31gFD031ac2kNEYy
         YVLpoCMslsXXb++kcYASNSkBAG0wQB8l1bgB0ltikdItWH7EhTcd5G+KGkkPZahEA7cB
         d6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778758612; x=1779363412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qN16thgwwCwB2Rdns6XBfhr/Ra0hBXWE7M0kvmpsYQA=;
        b=sNkHx4RPFHfRqHkAYtccwBeF0Q6C1JP0KVYtRNSrvkQ5c78vH9ywBGpAsvtca3tv2I
         C1eGRc+cZF4pdZEx/EX1nrf7zC0P8yj8OJwrL4/vY1s3H/rHcyLuhvML8QIrsJF8Pi5r
         T7chHR6Yp6sWgu3JCHzT7Q142G+pQWaQfBw2+C8gAuWEXsmg83HQN+7YpopzIfNtqDpn
         OkpigtYtwuCWvn5p0l+z3A/a0W/sNbjaTwLqGpFlr3kFT99Qn4CELEHU5Y8QfWgdOuTl
         MHyP6poNO+0YgqzesOssM8rpHHqHtcQO79WNqhHs2vfRg8W3IGFsB8dOfaU8ZhSEosf1
         b3jA==
X-Gm-Message-State: AOJu0Yw18f8VvQ4JLeCiizbtDKrKYXZXhIWv10aOCjdeo6MTS++a0CbP
	S7hXT5fRoqUX8c6dmx/Hr3rAeVL0i4LewLBRwSIxoX0UA+kKdlqzvOoyRntFAcr1d6jtGyobkcP
	ENtZc0S4L+iq9uuG7ll1SCq7PfvJELMHGmIOev12vDjcv14ptc3lX7ILaxl6EIMbLrgOZXQ==
X-Gm-Gg: Acq92OHLUKmpT66bEuZp5dEvnX4KbexmA7dlHFwdo2aVwiUOOq4aBrXExQ1InBISSLU
	qi2LPyqGd7784vMUZlZmFN3n0BSlEWIjM3+HAt65mbBE+Vg6fFbgLsliZV6xAn+Jlj7kvo7NG8G
	hOyI2TFWOL5uLStcHs7GLOreDTrynxiEb/n+E2zIcyD+3uK4WxancWaW7a/dr9tese/lvHsjRzF
	veZ04j8TMbYTFlMLlZANY+ohpHm4y60O2xDNOP+wDFVTy1fEXZALrv5tv03j/Tlizzdcx/9/vSt
	peVWtHD2le3zcK4Y6GQxKtBR6YOHrJjA42W8obRlSVFc1/KziWOC4qjpaz9CBOF0H/gcizem9CC
	aiKjta8ow0sRAVcf4PX2L4RZ71+QHBc8iOAnMnvCAc5vxi6q/G5RsZJo=
X-Received: by 2002:a17:903:320d:b0:2b9:6458:1a2c with SMTP id d9443c01a7336-2bd272b4403mr78742145ad.13.1778758611323;
        Thu, 14 May 2026 04:36:51 -0700 (PDT)
X-Received: by 2002:a17:903:320d:b0:2b9:6458:1a2c with SMTP id d9443c01a7336-2bd272b4403mr78741775ad.13.1778758610675;
        Thu, 14 May 2026 04:36:50 -0700 (PDT)
Received: from hu-priyjain-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05f27csm21756845ad.25.2026.05.14.04.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 04:36:50 -0700 (PDT)
From: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v5] thermal: qcom: tsens: atomic temperature read with hardware-guided retries
Date: Thu, 14 May 2026 17:06:43 +0530
Message-ID: <20260514113643.1954111-1-priyansh.jain@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDExNiBTYWx0ZWRfXyFaW573y+Fxd
 h0RcQRvt9c85SNzuxjpJ/1EtVe/hkpNiJMRe88VBIH32nWHeRO9MdtN4EUVO26pD/htmeFywRFr
 m7L6722G2Zbl4C5vvL7Aq9CyY1HZaeog43HOKekWVc3Vwn6VnkziC6XBPHIip3MJrDHNlWMXdnj
 W9+KGbK8DPKEmTfXq9URT8RJrBKb0RUwBnsg+a7xBT3EQKqxUk3m6zzEU6nNq8hVO3abCG+12Jj
 cO3XstQyHZPbkyGabOsGUhU+Gt4dQBNT4aPmWQy/WxUuqG2bzgaNjsjLCu6IMqFzq/f7GH3UVzk
 40UR+JtrJiKoorMJcyCRPXm/NMENfL20U+I1yTb9qOxJAttusCmN3aJdovaUmOyZfKD2jsVaQDD
 87xGHOO3r9mpZ0xENO4+lzYFnL1BGJJ6FMiMtP4Hmhsp9LrCCj/byuINH1/FcMlaqvmUb4rLW6h
 UgBfYQlsNVN0QdLVprg==
X-Proofpoint-ORIG-GUID: yqDRR7OB7Kkl1q3xHmgVYzNEc2o12sdL
X-Authority-Analysis: v=2.4 cv=Iba3n2qa c=1 sm=1 tr=0 ts=6a05b3d4 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=wJ5UwyVIi5aKMrvtPbQA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: yqDRR7OB7Kkl1q3xHmgVYzNEc2o12sdL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140116

The existing TSENS temperature read logic polls the valid bit and then
reads the temperature register. When temperature reads are triggered
at very short intervals, this can race with hardware updates and allow
the temperature field to be read while it is still being updated.

In this case, the valid bit may already be asserted even though the
temperature value is transitioning, resulting in an incorrect reading.

Hardware programming guidelines require the temperature value and the
valid bit to be sampled atomically in the same read transaction. A
reading is considered valid only if the valid bit is observed set in
that same sample.

The guidelines further specify that software should attempt the
temperature read up to three times to account for transient update
windows. If none of the attempts yields a valid sample, a stable fallback
value must be returned: if the first and second samples match, the second
value is returned;otherwise, if the second and third samples match, the
third value is returned;if neither pair matches, -EAGAIN is returned.

Update the TSENS sensor read logic to implement atomic sampling along
with the recommended retry-and-compare fallback behavior. This removes
the race window and ensures deterministic temperature values in
accordance with hardware requirements.

Signed-off-by: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

---
Changes in v5:
- Reformat multi-line comment to follow kernel style
- Add spacing for improved readability
- Minor code cleanup and variable declaration adjustment
- Link in v4: https://lore.kernel.org/all/20260513054412.911048-1-priyansh.jain@oss.qualcomm.com/

Changes in v4:
- Fix indentation issue based on review feedback
- Link to v3: https://lore.kernel.org/all/15e8fb71-1eb0-4440-a8cf-26f19f66b2bb@oss.qualcomm.com/

Changes in v3:
- Remove valid_bit, last_temp_mask, and last_temp_resolution fields from
  struct tsens_features in tsens.h
- Compute last_temp_mask, resolution, and valid_bit on-the-fly using
  regmap field definitions
- Remove field initializations from all platform data files
  (tsens-v0_1.c, tsens-v1.c, tsens-v2.c)
- Remove the initialization line in init_common() that was computing
  last_temp_mask
- Link to v2: https://lore.kernel.org/all/6e0081a3-a28b-49e5-825d-405cc157254f@oss.qualcomm.com/

Changes in v2:
- Reverted merging of the valid-bit and LAST_TEMP register field logic
  to preserve the regmap differences between TSENS versions
- Defined valid-bit support and last temperature resolution for all
  TSENS v1 and v2 feature structures
- Defined last temperature resolution for Tsens v0 feature structure
- Dropped tsens version checks in favor of valid-bit capability
- Computed masks from resolution to keep a single source of truth
- Minor code cleanups based on review feedback
- Link to v1: https://lore.kernel.org/all/c07fd488-a455-413f-b25f-9f9f1afda097@oss.qualcomm.com/
---
 drivers/thermal/qcom/tsens.c | 111 ++++++++++++++++++++++++-----------
 drivers/thermal/qcom/tsens.h |   1 +
 2 files changed, 78 insertions(+), 34 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index a2422ebee816..40f27c1a1cd5 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -316,9 +316,66 @@ static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
 }
 
 /**
- * tsens_hw_to_mC - Return sign-extended temperature in mCelsius.
+ * tsens_read_temp - Retrieve temperature readings from the hardware.
  * @s:     Pointer to sensor struct
  * @field: Index into regmap_field array pointing to temperature data
+ * @temp: temperature in deciCelsius to be read from hardware
+ *
+ * This function handles temperature returned in ADC code or deciCelsius
+ * depending on IP version.
+ *
+ * Return: 0 on success, a negative errno will be returned in error cases
+ */
+static int tsens_read_temp(const struct tsens_sensor *s, int field, int *temp)
+{
+	struct tsens_priv *priv = s->priv;
+	int temp_val[MAX_READ_RETRY] = {0};
+	u32 status;
+	int ret;
+	u32 last_temp_mask = GENMASK(priv->fields[LAST_TEMP_0].msb,
+					priv->fields[LAST_TEMP_0].lsb);
+	u32 valid_bit = priv->rf[VALID_0] ? BIT(priv->fields[VALID_0].lsb) : 0;
+
+	for (int i = 0; i < MAX_READ_RETRY; i++) {
+		ret = regmap_read(priv->tm_map, priv->fields[field].reg, &status);
+		if (ret)
+			return ret;
+
+		/* VER_0 doesn't have a VALID bit */
+		if (!valid_bit) {
+			*temp = status & last_temp_mask;
+			return 0;
+		}
+
+		temp_val[i] = status & last_temp_mask;
+
+		if (status & valid_bit) {
+			*temp = temp_val[i];
+			return 0;
+		}
+	}
+
+	/*
+	 * As per the HW guidelines, if none of the attempts observe a
+	 * valid sample, a stable fallback value must be returned. If the
+	 * first and second samples match, the second value is returned;
+	 * otherwise, if the second and third samples match, the third
+	 * value is returned.
+	 */
+	if (temp_val[0] == temp_val[1])
+		*temp = temp_val[1];
+	else if (temp_val[1] == temp_val[2])
+		*temp = temp_val[2];
+	else
+		return -EAGAIN;
+
+	return 0;
+}
+
+/**
+ * tsens_hw_to_mC - Return sign-extended temperature in mCelsius.
+ * @s:     Pointer to sensor struct
+ * @temp: temperature in milliCelsius to be read from hardware
  *
  * This function handles temperature returned in ADC code or deciCelsius
  * depending on IP version.
@@ -326,20 +383,14 @@ static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
  * Return: Temperature in milliCelsius on success, a negative errno will
  * be returned in error cases
  */
-static int tsens_hw_to_mC(const struct tsens_sensor *s, int field)
+static int tsens_hw_to_mC(const struct tsens_sensor *s, int temp)
 {
 	struct tsens_priv *priv = s->priv;
 	u32 resolution;
-	u32 temp = 0;
-	int ret;
 
 	resolution = priv->fields[LAST_TEMP_0].msb -
 		priv->fields[LAST_TEMP_0].lsb;
 
-	ret = regmap_field_read(priv->rf[field], &temp);
-	if (ret)
-		return ret;
-
 	/* Convert temperature from ADC code to milliCelsius */
 	if (priv->feat->adc)
 		return code_to_degc(temp, s) * 1000;
@@ -514,8 +565,10 @@ static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
 					&d->crit_irq_mask);
 		if (ret)
 			return ret;
-
-		d->crit_thresh = tsens_hw_to_mC(s, CRIT_THRESH_0 + hw_id);
+		ret = regmap_field_read(priv->rf[CRIT_THRESH_0 + hw_id], &d->crit_thresh);
+		if (ret)
+			return ret;
+		d->crit_thresh = tsens_hw_to_mC(s, d->crit_thresh);
 	} else {
 		/* No mask register on older TSENS */
 		d->up_irq_mask = 0;
@@ -525,8 +578,16 @@ static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
 		d->crit_thresh = 0;
 	}
 
-	d->up_thresh  = tsens_hw_to_mC(s, UP_THRESH_0 + hw_id);
-	d->low_thresh = tsens_hw_to_mC(s, LOW_THRESH_0 + hw_id);
+	ret = regmap_field_read(priv->rf[UP_THRESH_0 + hw_id], &d->up_thresh);
+	if (ret)
+		return ret;
+
+	d->up_thresh = tsens_hw_to_mC(s, d->up_thresh);
+	ret = regmap_field_read(priv->rf[LOW_THRESH_0 + hw_id], &d->low_thresh);
+	if (ret)
+		return ret;
+
+	d->low_thresh = tsens_hw_to_mC(s, d->low_thresh);
 
 	dev_dbg(priv->dev, "[%u] %s%s: status(%u|%u|%u) | clr(%u|%u|%u) | mask(%u|%u|%u)\n",
 		hw_id, __func__,
@@ -750,33 +811,15 @@ static void tsens_disable_irq(struct tsens_priv *priv)
 
 int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
 {
-	struct tsens_priv *priv = s->priv;
 	int hw_id = s->hw_id;
 	u32 temp_idx = LAST_TEMP_0 + hw_id;
-	u32 valid_idx = VALID_0 + hw_id;
-	u32 valid;
 	int ret;
 
-	/* VER_0 doesn't have VALID bit */
-	if (tsens_version(priv) == VER_0)
-		goto get_temp;
-
-	/* Valid bit is 0 for 6 AHB clock cycles.
-	 * At 19.2MHz, 1 AHB clock is ~60ns.
-	 * We should enter this loop very, very rarely.
-	 * Wait 1 us since it's the min of poll_timeout macro.
-	 * Old value was 400 ns.
-	 */
-	ret = regmap_field_read_poll_timeout(priv->rf[valid_idx], valid,
-					     valid, 1, 20 * USEC_PER_MSEC);
-	if (ret)
-		return ret;
-
-get_temp:
-	/* Valid bit is set, OK to read the temperature */
-	*temp = tsens_hw_to_mC(s, temp_idx);
+	ret = tsens_read_temp(s, temp_idx, temp);
+	if (!ret)
+		*temp = tsens_hw_to_mC(s, *temp);
 
-	return 0;
+	return ret;
 }
 
 int get_temp_common(const struct tsens_sensor *s, int *temp)
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 2a7afa4c899b..ab57ad88c3f7 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -21,6 +21,7 @@
 #define THRESHOLD_MIN_ADC_CODE	0x0
 
 #define MAX_SENSORS 16
+#define MAX_READ_RETRY 3
 
 #include <linux/interrupt.h>
 #include <linux/thermal.h>
-- 
2.43.0

