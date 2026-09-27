Received: from outbound.ci.icloud.com (ci-2003b-snip4-8.eps.apple.com [57.103.91.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C88F2FD1CA
	for <linux-pm@vger.kernel.org>; Sun, 27 Sep 2026 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.91.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790520968; cv=none; b=toYZR+YzKLNbiTvKwnc2V26y+BZeg0x+st6tGyDhVljVWLp3fvR3Eun1yWCwLUE6Oql5UMDxDm9LFKdLvXQ6TAPRsboo6N1trVvv1AOhaknwdxgfzCP8yj5pgpHyEEoWhNbHZB1DiekzocLBpWVM6irMFKhYlZOUr93lRiLXMfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790520968; c=relaxed/simple;
	bh=RknUto/Ke92aNp/GKaE1OApDOTooX5mROVE6CCgCfz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EmPng1qe3CSrWRFYj9gWur3m5Ki5yV2FOb86h9nxwk7NxtJoW+qPH/5PvihI61Z1S5LNZzH8bPqTdDoR0DiQfbAsXnZ01darLJ4vJI98muzTYlaDVLG2KXYgLK1jJVgFkRUFIdC7+Q97AXV8OpUN9yYMtAiZcWtH6leDuBN3aPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=rQnDXkdA; arc=none smtp.client-ip=57.103.91.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="rQnDXkdA"
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-7 (Postfix) with ESMTPS id 54A66180060A;
	Sun, 27 Sep 2026 14:56:00 +0000 (UTC)
X-ICL-RepId: 01a0e35d-a50a-7fc7-9edb-3f90319b3995
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQhPAEMGXAVeC1YBXwFLVxQEDloDVA5cBBcbXwJCH1sVSzhaDlsERxQXG1wAFw1WTVAbXwJCDxwTVhUTH1RWA0gZEFYBWFZdBU0aXBhZDxwTUFZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1QG18CQg8cE1YVEwBeDw9MC0gBWwdSAEcITAZYBFMcQgpLBlkPRgZdTxFdDlIFRl5aFFwYQwJXAnkRUAFYHlZeWhdeUxcfSwBcRVoOWwRHFA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1790520963; x=1793112963; bh=MAut5IltjfVwMEAj0UZBB/L822Xsn2hU0qj03knXC+I=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=rQnDXkdAOJKS1MXBzMTZDw0OjgUTeyqm+GptPAcjs/EDZmQMEN3AmDniDTgZLIlcZ9syy2KCWHc6C0Z/hJBmw5FPKyUx/X8gQXOiJLk4LXWSrlw1cZrE3v/8frC1P6pI2O/BAaJ+oOsatAb6vny38kUlw8sYT/j8g3UcAtigOW9pg7EerL8B6SQlzwTQ7S/pJJaXTToeep5l1awvOfsPG3qjLxravnBDEmyKChmPSWDJzibU7awDSJEh4gJhSCNg4sZ/4gJgB4ChGrB5+DzVL72j6JcGDhP0x4GS6KoOHH0wxiByXXnUxZD4PPHG6rJkcBRT2ZaHZncNIdGFLCBnyg==
Received: from bigre.tail98293.ts.net (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-7 (Postfix) with ESMTPSA id EE6C518001BB;
	Sun, 27 Sep 2026 14:55:58 +0000 (UTC)
From: Vincent Cloutier <vincent.cloutier@icloud.com>
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	daniel.baluta@nxp.com,
	shawnguo@kernel.org,
	agx@sigxcpu.org,
	angus@akkea.ca,
	Vincent Cloutier <vincent@cloutier.co>
Subject: [PATCH v1 3/4] power: supply: bq25890: Add input voltage limit
Date: Sun, 27 Sep 2026 10:55:37 -0400
Message-ID: <20260927145538.233548-4-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260927145538.233548-1-vincent.cloutier@icloud.com>
References: <20260927145538.233548-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=d6v4CBjE c=1 sm=1 tr=0 ts=6ab92e82
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10
 a=5j__JWfIoqoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=CrHkPnLHL-1v8ukjNXAA:9
X-Proofpoint-GUID: uOnhdEiy9fP_bs1hYuL9E9R0Bb5Lilkh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA1OSBTYWx0ZWRfX59jGLZMWNluT
 m6EnobpqFEBE8q5eSHV8LiNOeXwCedanUWgTTJjP9kPCiZ8hNlnJcLZ97oF20mgKBUoTrmzQpHI
 95PrTxmVHsJZteS/MbaiCQCTln+qNvaRVITgCocx4/I5H0PMaY9WrA9hONkfvK+aUx8x35sSMbN
 6JbkE/d9/gRO40cz4hGNcusaWnv9gq9elB0eVg1NEcrFHvmVZC/+oEGQIyAicv3pzW562drPYru
 BLlEt/gejYko88n46xVxEy6eq5Hj3MAXYqrUeL3rZNOJJrxJsxhR2lFfME9lZYnxtDm1TOl6VOr
 I7WCKQa8XezU9uQiVRzISpjgCb5ZWzSWGm0nV3YSGg51yp41DVMPkPCedqDers=
X-Proofpoint-ORIG-GUID: uOnhdEiy9fP_bs1hYuL9E9R0Bb5Lilkh
X-JNJ: AAAAAAABIpnGXC4J8ZevAQpaIz9RiTNanlqd/8pCXRaZ92A+sBSfvn5MK3x6oxhFr7WRsCa90gKGvufuZuB6D6QMGy8ZnjpVCfaZGE/+UsOee1OMj7/fUh6C/3AeUSOuYGrqmMprCF2wU0NtoBevc0q/pJ67so0rCgTekw8pDNSmsPlkNGDIr2+xQeSsRajzsMGz2trPIhQguf0o+CJdYIxuAo09vYxmqOR8xIaBnDDh1nfP3mHGL8kUOzYTymyqzyyQTXQqko8fVRG9LjzEWXfIVT50Lys4uidYcz3jhNssPDHB15wD08SzTWEWuHpogrHvoue//vcyMnO7Te7xB5/iGgSD7Qqy+J8Z853ZQeYXTseyszZy2R+ctc77Bp7zhxAj2ro5XayqscXaKw34trUcnPvZzEBQAcc1UuqUnI4ljMFKnB3ISltS2RR2tBEhNV3WRzz6zzQZzl43yt3Km8Z21YGwJ+ug+qU9BbXT/mejespevqW18OvCp261NqbTAmfZWte7rxM3hwAVVCefGQ88UAayqCmp1TabIUE9v40n5GCjtibUoInJlmHT0/X3C0VTtxjxO00Po+AMpcHmUKXnln1SocQgr9yHNoSpviWseOsIiIJbI80FEvXYcq8OcAVmZJwGcxEzbFdk3XGADYfc/jVA2WEjFQgZ0Fr6jBtyoR+5OGc+iprx4prXZldv2J/O0wAEldPxtO4sGzxU7u9Vw3bF/YzmgvCGIn1DEpJInzsHuKl3zLO0Udv+HYydxw21hE0JV0W6gQWu26efoqjQwi8mdKRthe2y74GF+JsHnPYWydsWrEtVn020HK+Y5Yr84agvjT161x2tinMkjkMzzh4jmJh6Oi7J0R5A33fp/ndvgBr81Wzh5hcv+5a3VC4j7Of2sjOPhOz2mugrVfFdS3Z1jbSfILqEixNySI+q+sNHMspZst6/l+U=

From: Vincent Cloutier <vincent@cloutier.co>

The BQ25890 family supports an absolute input voltage dynamic power
management threshold. Read input-voltage-limit-microvolt from firmware,
enable absolute VINDPM, and then program the requested threshold. Only
program and restore VINDPM when this property is parsed. Without it,
retain the existing VINDPM behavior.

As with the other initialization properties, linux,read-back-settings
bypasses parsing this property. Do not read back VINDPM into the requested
settings, so a firmware-configured absolute threshold does not implicitly
enable restoration.

The BQ25896 resets FORCE_VINDPM and VINDPM when an input source is
inserted. Source detection and VINDPM threshold selection generate
separate interrupts, so compare the fields with the requested values on
every online state refresh before returning for unchanged charger state.
Restore them only when they differ to avoid an interrupt loop. Report a
successful restoration as a handled interrupt even when the tracked state
is unchanged, without sending a redundant power-supply change notification.

Repeat the comparison during resume because an input insertion while
suspended may not leave a visible offline-to-online transition.

The BQ25896-specific restoration path has not been tested on hardware.

Assisted-by: OpenCode:gpt-5.6-sol
Assisted-by: OpenCode:gpt-6-astra
Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
---
 drivers/power/supply/bq25890_charger.c | 74 +++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 741a45cc5f35..71d6cf179667 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -88,6 +88,8 @@ struct bq25890_init_data {
 	u8 boosti;	/* boost current limit		*/
 	u8 boostf;	/* boost frequency		*/
 	u8 ilim_en;	/* enable ILIM pin		*/
+	bool force_vindpm; /* explicit absolute VINDPM request */
+	u8 vindpm;	/* absolute VINDPM threshold	*/
 	u8 treg;	/* thermal regulation threshold */
 	u8 rbatcomp;	/* IBAT sense resistor value    */
 	u8 vclamp;	/* IBAT compensation voltage limit */
@@ -284,6 +286,7 @@ enum bq25890_table_ids {
 	TBL_VBUSV,
 	TBL_VBATCOMP,
 	TBL_RBATCOMP,
+	TBL_VINDPM,
 
 	/* lookup tables */
 	TBL_TREG,
@@ -351,6 +354,7 @@ static const union {
 	[TBL_VBUSV] =	 { .rt = {2600000, 15300000, 100000} },	 /* uV */
 	[TBL_VBATCOMP] = { .rt = {0,         224000, 32000} },	 /* uV */
 	[TBL_RBATCOMP] = { .rt = {0,         140000, 20000} },	 /* uOhm */
+	[TBL_VINDPM] =   { .rt = {2600000, 15300000, 100000} },	 /* uV */
 
 	/* lookup tables */
 	[TBL_TREG] =	{ .lt = {bq25890_treg_tbl, BQ25890_TREG_TBL_SIZE} },
@@ -814,18 +818,67 @@ static int bq25890_get_chip_state(struct bq25890_device *bq,
 	return 0;
 }
 
+static int bq25890_set_vindpm(struct bq25890_device *bq)
+{
+	int ret;
+
+	if (!bq->init_data.force_vindpm)
+		return 0;
+
+	ret = bq25890_field_write(bq, F_FORCE_VINDPM, 1);
+	if (ret < 0)
+		return ret;
+
+	return bq25890_field_write(bq, F_VINDPM, bq->init_data.vindpm);
+}
+
+/* Return 1 if restored, 0 if unchanged, or a negative error. */
+static int bq25890_restore_vindpm(struct bq25890_device *bq)
+{
+	int force, vindpm, ret;
+
+	if (!bq->init_data.force_vindpm || bq->chip_version != BQ25896)
+		return 0;
+
+	force = bq25890_field_read(bq, F_FORCE_VINDPM);
+	if (force < 0)
+		return force;
+
+	vindpm = bq25890_field_read(bq, F_VINDPM);
+	if (vindpm < 0)
+		return vindpm;
+
+	if (force && vindpm == bq->init_data.vindpm)
+		return 0;
+
+	ret = bq25890_set_vindpm(bq);
+	if (ret < 0)
+		return ret;
+
+	return 1;
+}
+
 static irqreturn_t __bq25890_handle_irq(struct bq25890_device *bq)
 {
 	bool adc_conv_rate, new_adc_conv_rate;
 	struct bq25890_state new_state;
+	irqreturn_t irq_ret = IRQ_NONE;
 	int ret;
 
 	ret = bq25890_get_chip_state(bq, &new_state);
 	if (ret < 0)
 		return IRQ_NONE;
 
+	if (new_state.online) {
+		ret = bq25890_restore_vindpm(bq);
+		if (ret < 0)
+			goto error;
+		if (ret > 0)
+			irq_ret = IRQ_HANDLED;
+	}
+
 	if (!memcmp(&bq->state, &new_state, sizeof(new_state)))
-		return IRQ_NONE;
+		return irq_ret;
 
 	/*
 	 * Restore HiZ bit in case it was set by user. The chip does not retain
@@ -932,6 +985,9 @@ static int bq25890_rw_init_data(struct bq25890_device *bq)
 		}
 	}
 
+	if (write)
+		return bq25890_set_vindpm(bq);
+
 	return 0;
 }
 
@@ -1386,6 +1442,18 @@ static int bq25890_fw_read_u32_props(struct bq25890_device *bq)
 						       props[i].tbl_id);
 	}
 
+	if (device_property_present(bq->dev,
+				    "input-voltage-limit-microvolt")) {
+		ret = device_property_read_u32(bq->dev,
+					       "input-voltage-limit-microvolt",
+					       &property);
+		if (ret < 0)
+			return ret;
+
+		init->vindpm = bq25890_find_idx(property, TBL_VINDPM);
+		init->force_vindpm = true;
+	}
+
 	return 0;
 }
 
@@ -1609,6 +1677,10 @@ static int bq25890_resume(struct device *dev)
 
 	/* Re-enable ADC only if charger is plugged in. */
 	if (bq->state.online) {
+		ret = bq25890_restore_vindpm(bq);
+		if (ret < 0)
+			goto unlock;
+
 		ret = bq25890_field_write(bq, F_CONV_RATE, 1);
 		if (ret < 0)
 			goto unlock;
-- 
2.55.0

