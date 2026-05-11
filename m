Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E33925F7A9
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 07:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778483436; cv=none; b=g/lsrzsqLUx2cH4LXbGcBKfKB3lbsykrPZICkjcVE7ksrkB6oeujUORJ+Ud/P6tXKPTICWlHi7zkFKGsjahKf2ieOKDpByYsa6jqcSRHznYSlqji5YF/+viJt2DSKFpZdM+b4vatieeNNRWcPU6IyK/iOUqRlkkcErlTNpUAHkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778483436; c=relaxed/simple;
	bh=VLVpg27Lyq+MGOrxKQpN5kYrH2wV5P36mETGnfpo6Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IyB1HC7f+LtSvma180AFIA5nTuEIrfK19CrYJlVRhQLFG0b0UGeSAM93i5zRjBT6/3Ki9XuPoKYZhXI3d34K+OTodJwx5RUKbjCsaT4PZfYqwtJFSn8q7UB0FR4gjXAj1nnOGGGrsCGCx+z7O2gfneSgazQbjyL3T/I6LCfBEIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UvC/Ma2v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cxHcGQmn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UvC/Ma2v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cxHcGQmn"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B38usE2534305
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 07:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=lshARZavRy/jl7k+sudxw/52HO8R0au0eyu
	81zNJgbY=; b=UvC/Ma2vNb1YwDTqRT5EaOrjLLkHX32cAbmOmyzRvhHf2uveera
	KIyGtQpnFUCgr3O8UOiP6WFv0xjGhAJetWbI9HoAjkLxBZ8CD36MuLZcWENnCqs+
	8UpkYMPL62sLV2EO9ISjRmwjBp0tH9vVSXsAv3g/zFgZxwgux33aH8lo2+qS1xLs
	viBSfqpcGNFr2TjkCdouR96M8c4Md33QZNZ5b3uIICKPAA6o8HPdaaA4N7KL5OtA
	t5jZDgygHUpR4U+ZxDrgHjzV/5/mmEf5qwv0iR6n3E4YDiyTq4to+DOPrOZcMKYF
	zLYMnNm5DIiZfqa8w9QuRijnnJwn6HG1zBQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1uvsn2f8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 07:10:33 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-365fc4636bbso7828475a91.2
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 00:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778483433; x=1779088233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lshARZavRy/jl7k+sudxw/52HO8R0au0eyu81zNJgbY=;
        b=cxHcGQmnDMKIRFiMNRVHOBtXPMfviYM87h9t5sFOwzlEh3cQv8NEl8bEkb2z8Poxfg
         o/p36bydxQ6GM92wRzBnMNJgBMQd5ADcbFUglGMebZtJs8bQOaiiyb+EJ8d59iaVikQd
         iJAoLAYwLPuqGGA4ZSUX4+mnfppF2ntEit25885/1l0NEWixhzNzXumF39kSyAC0VhFd
         NYUvdlFbmaUj7iN7W8yqLeGA5lxPG6ain8Q4u0QgixOQGSyfYe2uII6FNSYUKJ1bGweT
         J8Xvd93i+d5tpAtgbjXvFUzDAVtHycIy6mLUd7tbk+3lvuMftW9KRO1SvjpvB1gkFSVb
         nw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778483433; x=1779088233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lshARZavRy/jl7k+sudxw/52HO8R0au0eyu81zNJgbY=;
        b=TgSab0P6/Vpl9Ny61f/2+v4U1d77edj8yygI6Bwcpk3IFj1sRRjqoPY1D8F46RS/8O
         czqHrPf+MYp0gQ9h2q8vGwiCe6qhA6nbHlXDy1A6jnJuhf0JZ+jbMEyxF5wXZS+A5ast
         l1qJrNEY8tzGtWGKZZirDHhf9BoCgFLE6YV+cntBXaG/nYn3b9zzQ7e+ujkEy+Arw73s
         hfmUm0TqzibIPoV+JJ6Zcv4EVjrD1HKNDkDFjcNnCehFGqTzdRpKymqYYhe5kq6j22vF
         y3s+NGP1tGKH37W4yxe2YnCodB6izYMiX3TPfrzcLEwDbOB+fPxXME7tDdYQEt1FMNl4
         /sdA==
X-Gm-Message-State: AOJu0Yz6dVwacz1VkoDWdaDpTeXLZt/FweS8EyPI1JT/y69/5bVdCVJN
	Z74LvdPfqWINKlLojM/dKklWQNvjgKJLSnRp9XWaMUuzkgr17PkK3G3wOHQNZLMiahPrwyDHNoX
	5TzSb88BZ4gjBSgBueIWpekBJ1ywSIdE21XOKtPe9EuRQcfHinlH8Q8wyaN0OBR5uUdfSOw==
X-Gm-Gg: Acq92OFSpXIbS22hFUOeX9XBkvB4S1IJqvaaOseg8mwJszKQJMiVNxH9w+y85EA7QYt
	swL2PJ+NlLIXqG+nOuKmuek0HBT7o5nIBEiJIvryB3JVJrv4p/SmN0NvFhEpYGIQH5+f4VQP1Lu
	06/pIE03Jg1iXCki89yVYwQl5e677G5xXB6BXSOBJMF9Gc/1eGpYiDPlQ4XRj7xl3v74qLkyGBT
	5fZ79P0zYh+TbYiPkLpvl5cuxyO66gmysQjt3iSmerrkfer8aS/v48RNQzkeHef+47D86sAmnNY
	/SFDeIJvfVPz1MFctZtiMClWo5bpqx18bDqMlA7Py/zToxKfBtN4Y+mDiqnAlJmWPjsr9OBkrJF
	/ktFgOvuhl5S7RCW0WW+QK08tHCGVr9NYXkXxblsIPe+ZAYPZE8lk96o=
X-Received: by 2002:a17:90b:3d4b:b0:368:341a:a925 with SMTP id 98e67ed59e1d1-368341ab057mr4403095a91.23.1778483432757;
        Mon, 11 May 2026 00:10:32 -0700 (PDT)
X-Received: by 2002:a17:90b:3d4b:b0:368:341a:a925 with SMTP id 98e67ed59e1d1-368341ab057mr4403035a91.23.1778483432008;
        Mon, 11 May 2026 00:10:32 -0700 (PDT)
Received: from hu-priyjain-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d687bedesm8295828a91.16.2026.05.11.00.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:10:31 -0700 (PDT)
From: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>
Subject: [PATCH v3] thermal: qcom: tsens: atomic temperature read with hardware-guided retries
Date: Mon, 11 May 2026 12:40:24 +0530
Message-ID: <20260511071024.3130247-1-priyansh.jain@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA3OCBTYWx0ZWRfX7e0vec7M7r+r
 PMmlgwKhSwFYWOlYYA64k3QG0wG+Tb5Hc231fRuShOuSssNJGow1vagz+wV3sLZbTbzEGoGH48/
 Ln6G5k/O2ut4MX6yWNi5KGNj4ikf3z2N2vsk68budKU9zrF/jnX5so99xRi0wCJaZmsrmSWKn8T
 PH2rsPL5jgmAkHkn7/BkcBBziPpTTvWaC8SbjsPXW3v2G6wLqkQR2l/Ny8ehOtDJf4U/H6G4oPU
 QMSEw9KOwNiuqji1lz+XnMET8VH+UGFr/WZrSVsCKfSG5DunDXzcn3HjqLBiw4GS0eGyJ3aqCqy
 r7wvz5hjFAxknRHtOC6cqKeh/95cT0nlsZDtvWbfA0fDk70ukDtGM503AiIJKn/eXVkPzVDm7Cr
 nCzqgwDA5oOVfrgrm3fKU3qNOFM/of168C4jcuaB/GLXp2FpMJKp9se02EQrXbutz6YRJg5EppE
 KXPN7Kq7BJJxD/wm5tQ==
X-Authority-Analysis: v=2.4 cv=dujrzVg4 c=1 sm=1 tr=0 ts=6a0180e9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=6pG74zlKLNrpVVWoZpsA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: sauhL-_VESvJ2L8uCX4J060X4mh3eScC
X-Proofpoint-GUID: sauhL-_VESvJ2L8uCX4J060X4mh3eScC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110078

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
windows. If none of the attempts observe a valid sample, a stable
fallback value must be returned: if the first and second samples match,
the second value is returned; otherwise, if the second and third
samples match, the third value is returned.

Update the TSENS sensor read logic to implement atomic sampling along
with the recommended retry-and-compare fallback behavior. This removes
the race window and ensures deterministic temperature values in
accordance with hardware requirements.

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

Signed-off-by: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
---
 drivers/thermal/qcom/tsens.c | 111 ++++++++++++++++++++++++-----------
 drivers/thermal/qcom/tsens.h |   1 +
 2 files changed, 78 insertions(+), 34 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index a2422ebee816..72583af7ddd6 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -315,10 +315,67 @@ static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
 	return degc;
 }
 
+/**
+ * tsens_read_temp - Retrieve temperature readings from the hardware.
+ * @s:     Pointer to sensor struct
+ * @field: Index into regmap_field array pointing to temperature data
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
+	u32 valid_bit = priv->rf[VALID_0 + s->hw_id] ? BIT(priv->fields[VALID_0].lsb) : 0;
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
+	return ret;
+}
+
 /**
  * tsens_hw_to_mC - Return sign-extended temperature in mCelsius.
  * @s:     Pointer to sensor struct
  * @field: Index into regmap_field array pointing to temperature data
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
@@ -514,8 +565,12 @@ static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
 					&d->crit_irq_mask);
 		if (ret)
 			return ret;
-
-		d->crit_thresh = tsens_hw_to_mC(s, CRIT_THRESH_0 + hw_id);
+		ret = regmap_field_read(priv->rf[CRIT_THRESH_0 + hw_id], &d->crit_thresh);
+		if (ret)
+			return ret;
+		d->crit_thresh = tsens_hw_to_mC(s, d->crit_thresh);
+		if (ret)
+			return ret;
 	} else {
 		/* No mask register on older TSENS */
 		d->up_irq_mask = 0;
@@ -524,9 +579,14 @@ static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
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
@@ -750,33 +810,16 @@ static void tsens_disable_irq(struct tsens_priv *priv)
 
 int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
 {
-	struct tsens_priv *priv = s->priv;
+	int ret;
 	int hw_id = s->hw_id;
 	u32 temp_idx = LAST_TEMP_0 + hw_id;
-	u32 valid_idx = VALID_0 + hw_id;
-	u32 valid;
-	int ret;
 
-	/* VER_0 doesn't have VALID bit */
-	if (tsens_version(priv) == VER_0)
-		goto get_temp;
+	ret = tsens_read_temp(s, temp_idx, temp);
 
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
+	if (!ret)
+		*temp = tsens_hw_to_mC(s, *temp);
 
-	return 0;
+		return ret;
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

