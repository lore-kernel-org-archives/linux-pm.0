Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ED03A6EEC
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 05:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651063; cv=none; b=r5jX35IBE4K1jY5x/F+ra7PyUN2JfscZkxWmJbXC9gV8USKjrXf9ES3ZtnDl8wxgeM/us+h18LI3E2KEySRVsRDHMyZYA+vCUChwO8/NaMHrPEcb15byP2VRNDfuMFpNur7/UtJiMlBuujjgf1R7mksFEnRp/i1Zpg3Va9PYzdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651063; c=relaxed/simple;
	bh=QYR1p7pypLumCe0co05V3H6BTY/NCkEsxKsFLeqVmwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sM3SpAJYrY9EcMPkxBoe54MsKG9GVxXtEqfYk6fhbwtHUgX4jU+z7L/54nC1ebfvl5AMfOqHyjtjcY/t78wsilIcADYccIgg+K/Ku8aNqxajqgJ1NuTyVO8IL6OhGzzhVTcqPJVM78iXKbHil4TdcdMiACURml9eGfmRK109qho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RIY9+Vco; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bOM99PC0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RIY9+Vco";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bOM99PC0"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D4pUx13595468
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 05:44:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=wuDaXbIHo9hWpRR2+1R1zu3ZeYVSiQmB2Zx
	wlTm5TYI=; b=RIY9+VcoABrzcLyannDKa/D/Q9EOtMMU3svFKy39a9kSALMUKUl
	a7Juf2rC4EQahRKKm0xM2JGLL+qdUOgokjuhQS5wqe4onJVIityVoG+hLBti//vx
	lyOeXA4rsniQsW4iuaWA9fywpi9smJ52iUs32Z/MqeYAWnzLJDzifrgjwB7Vm0WK
	oPIFnWmrnXBvKN3iMIuAH8fd6lX+JVMN3Im6xXjCB608PtZEYHcs1pZ54/KBZGPF
	w6jpkm51obGhXH7jo8/PWo++tBlmp1y5gYf29ebdNyuDTndqbdjrIwocY7T4+EjK
	JOcP/1Jp8odXRf2FI9eQ1Y7/CFiLBN0SY1w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e463djvw1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 05:44:21 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b99eb06178so137191915ad.2
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 22:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778651061; x=1779255861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wuDaXbIHo9hWpRR2+1R1zu3ZeYVSiQmB2ZxwlTm5TYI=;
        b=bOM99PC0ymklcMpe3HZh8pSD90Xy2djN0BaNMD78J6MtPx4NNfgHXmreyarxEUZxkB
         4Yz7/xkWupnEBFESrhBueDD+m3iHW9sYVn3xtJFpVCcfcXcfZ5ap2jKhMI3eSBLHLFRa
         j7qImOoKdCH8gfOYSsfet3F7NRTfmFZwdkLD+B7h7xyWNWWKoQzZrrCmDzPeL7sOE5jZ
         R6n1mBvKA45Vaw6BDlwNHE2DVXsXXeXB7o4jr9cl2vSYCLB8owqo9nlZy7MX823EGz37
         S+z/vs6KIOs9hyKeI0n1KnCi/0j180dpgNo0e67ljnC5aBtQFc4zS/qL8H81DGvT42CE
         BiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778651061; x=1779255861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuDaXbIHo9hWpRR2+1R1zu3ZeYVSiQmB2ZxwlTm5TYI=;
        b=fAcptPS0zjIt+jRF+3z4X0AhWsJGRJuu69EHJz46kRZNHqwQPA3YEWAGgpq3RNOYf3
         c7cldRUPx5F6iQ+KX0nBB7jqUmA0H0uMf+F7MpPHF64lkLBhONsfeVAzsOzMrmycCuNY
         tLpfCyI0AK/H9Sv3xbuK96IWQ6MGcd5Wh/Ux8fUahAwZKv29bYVXvrwAySJD3umKnCWD
         xPkD+8GW+Yhhk6rn8MaBTnB+6Fp6TmVdh1hs8VghAKbkbXqe9GL6CS2/ycwBdLA93QRa
         kyolzKW9zZRCdQ8mK0ADjGWPxnbJ/6loLmUSOkpvK3aAqsjjXL4cQcQ277+tFjX6GIJL
         8+YA==
X-Gm-Message-State: AOJu0YxKGuEfnAwCFJ9ny58jEBg0ecLOolrQqvqZF5hPKoYT11pLKHKJ
	bYjCdGVQ8WnZpxi5blR80BIFRArKEklJ/NIl4ONp+0x7qrCfTX+3rAqtrMVlabSlfhb5Eo4sXkP
	0vQaEQMcdjEV+O0JhtdY7kfB/w2BV/8VmD3TwBZWLN0ywtnPdsvY7bvPYsmkHcQ==
X-Gm-Gg: Acq92OGHD9swGdPKvNsKGxAgtq5oY4pS0RiWcB5A75ZrKyuKDSby2bGYv3/HBuZ7jxY
	hE4HOgG7jNldGJo6NvBYrUKGICC/HTdpYSWr/HQC9Kw4Sb1XEO1BKvxadpwQ3+cTLOThtaRfxyS
	qpWoOhmkPZ0CfylSWBS50LpLIuyKhENKoC0DPKBSSCoWi429Q1B/eD5I831SbODZnahRodhkdHJ
	XWN7tgieDqM+Um5Ls2eGZ9nepqbEpzI3rs1Xwtq2r3I5eFB6IybPHehUeX0RfBy5QAq/TOLHLP5
	E2aW48xZnoAfDWwMgJexFNiWH4xaJaBBhhp+Dsm37oM52eq8zVfKElAZ2IOinKiRN8Oq2yxhwhr
	yA9/JigXM+dWcwk7dywSItLntHrR8Qa9d1gE59sRRInYg6QUf4N9573Y=
X-Received: by 2002:a17:902:7204:b0:2bc:f2ae:e122 with SMTP id d9443c01a7336-2bd271436f6mr16634755ad.2.1778651060731;
        Tue, 12 May 2026 22:44:20 -0700 (PDT)
X-Received: by 2002:a17:902:7204:b0:2bc:f2ae:e122 with SMTP id d9443c01a7336-2bd271436f6mr16634315ad.2.1778651060112;
        Tue, 12 May 2026 22:44:20 -0700 (PDT)
Received: from hu-priyjain-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ebea72sm157235605ad.77.2026.05.12.22.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 22:44:19 -0700 (PDT)
From: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>
Subject: [PATCH v4] thermal: qcom: tsens: atomic temperature read with hardware-guided retries
Date: Wed, 13 May 2026 11:14:12 +0530
Message-ID: <20260513054412.911048-1-priyansh.jain@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uL03klIBW50-NMzhcJm4QK1DxdfFdbiS
X-Proofpoint-ORIG-GUID: uL03klIBW50-NMzhcJm4QK1DxdfFdbiS
X-Authority-Analysis: v=2.4 cv=aLTAb79m c=1 sm=1 tr=0 ts=6a040fb5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=58n1TqAxyoLoCYT524AA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA1NSBTYWx0ZWRfX8WHVVKTwzJ57
 xDWligiLvjh3zcOAXh1IeSmEqlqRgWNM7FhcRi13ZZ1rACXHGsbwMdZUHu38ycC7e78kmdY730c
 Xi7aYL2391awEvpvFh59V9cYAphY+SdggsSsNCMFaOpsICV9huK2R31WptmneVLrbpIr0sRQwRJ
 3j9u+4KeRoYAZ4WcOWneJHAxWITfg0bHcves9xTNMHbjV7Sj4yDYN8netf5Vsa+V0I1TGishC42
 c/Nq0Pvm6kWw+wuCTBWawLlLFNbyoZM6QxY91cKRVH6JyjRvUSKy6ByIrd4dZC1cu/JGRHpAi+C
 vx9eYQSl45LEP/c9Sh3tSQ9O50uaUk8sFI1nInTiRhMSeGu4wWAeNUc4pjhvIxsLCdXy2TqkdW5
 2V2cwEBCjgfQiknmne9Z2CJMCBE5sBDZkirPVldTcz8F0Fy/TDWuI2R9LbT96Nb9DE65NeEKElP
 kBqZIlGDaG7cHoJNLwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130055

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
value is returned; otherwise, if the second and third samples match, the
third value is returned; if neither pair matches, -EAGAIN is returned.

Update the TSENS sensor read logic to implement atomic sampling along
with the recommended retry-and-compare fallback behavior. This removes
the race window and ensures deterministic temperature values in
accordance with hardware requirements.

Signed-off-by: Priyansh Jain <priyansh.jain@oss.qualcomm.com>

---
Changes in v2:
- Reverted merging of the valid-bit and LAST_TEMP register field logic
  to preserve the regmap differences between TSENS versions
- Defined valid-bit support and last temperature resolution for all
  TSENS v1 and v2 feature structures
- Defined last temperature resolution for Tsens v0 feature structure
- Dropped tsens version checks in favor of valid-bit capability
- Computed masks from resolution to keep a single source of truth
- Minor code cleanups based on review feedback

Changes in v3:
- Remove valid_bit, last_temp_mask, and last_temp_resolution fields from
  struct tsens_features in tsens.h
- Compute last_temp_mask, resolution, and valid_bit on-the-fly using
  regmap field definitions
- Remove field initializations from all platform data files
  (tsens-v0_1.c, tsens-v1.c, tsens-v2.c)
- Remove the initialization line in init_common() that was computing
  last_temp_mask

Changes in v4:
- Fix indentation issue based on review feedback

---
 drivers/thermal/qcom/tsens.c | 110 ++++++++++++++++++++++++-----------
 drivers/thermal/qcom/tsens.h |   1 +
 2 files changed, 76 insertions(+), 35 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index a2422ebee816..b1b938312723 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -316,9 +316,65 @@ static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
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
+	u32 status = 0;
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
+		/* VER_0 doesn't have VALID bit */
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
+	/* As per the HW guidelines, if none of the attempts observe a
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
@@ -326,20 +382,14 @@ static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
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
@@ -514,8 +564,10 @@ static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
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
@@ -524,9 +576,14 @@ static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
 		d->crit_irq_mask = 0;
 		d->crit_thresh = 0;
 	}
-
-	d->up_thresh  = tsens_hw_to_mC(s, UP_THRESH_0 + hw_id);
-	d->low_thresh = tsens_hw_to_mC(s, LOW_THRESH_0 + hw_id);
+	ret = regmap_field_read(priv->rf[UP_THRESH_0 + hw_id], &d->up_thresh);
+	if (ret)
+		return ret;
+	d->up_thresh = tsens_hw_to_mC(s, d->up_thresh);
+	ret = regmap_field_read(priv->rf[LOW_THRESH_0 + hw_id], &d->low_thresh);
+	if (ret)
+		return ret;
+	d->low_thresh = tsens_hw_to_mC(s, d->low_thresh);
 
 	dev_dbg(priv->dev, "[%u] %s%s: status(%u|%u|%u) | clr(%u|%u|%u) | mask(%u|%u|%u)\n",
 		hw_id, __func__,
@@ -750,33 +807,16 @@ static void tsens_disable_irq(struct tsens_priv *priv)
 
 int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
 {
-	struct tsens_priv *priv = s->priv;
+	int ret;
 	int hw_id = s->hw_id;
 	u32 temp_idx = LAST_TEMP_0 + hw_id;
-	u32 valid_idx = VALID_0 + hw_id;
-	u32 valid;
-	int ret;
-
-	/* VER_0 doesn't have VALID bit */
-	if (tsens_version(priv) == VER_0)
-		goto get_temp;
 
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
+	ret = tsens_read_temp(s, temp_idx, temp);
 
-get_temp:
-	/* Valid bit is set, OK to read the temperature */
-	*temp = tsens_hw_to_mC(s, temp_idx);
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

