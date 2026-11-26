Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669133;
	b=a+DE5J1FhLh+XW776yB0XiPK/m+BawGFQqCPUFKpPY52jvrgQU6cmTFGe1B3xQnejHbX
	 3vw8Bo0wxsQdW7iYCM4bHEjUxNnmvQWqiuD7xYzLtyZjvGVzKLwXJWAyD9Rj/oKWkLQSU
	 8Qu+nwwAb/XkdKY1+/t/jAHSUzW/uVP2M/iVLsmUpgep6XfENpeF6zo2qSh7MqSw5YIbT
	 2PwzyZvuGUIN+ktROfX5uc63A/iNRhzvMcjM5ytBpPgM9IXbZv7RIVm1CD+uOSQr75KSK
	 v8csfpNlJ10SDCH2EBGnjY5OxmJUF/Ht8nB4at1qgoB7ZSmNqsTT0ArbWkZqGkPeO4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=+MWBTNYSRWjg4nAw8/hdhIdqDgN2Nzlt5vynJ2DjOQQ=;
	b=zdGaP4sDptRoQU601Pn/GmWkVEEwawa269HjfkLrlEqC82Ko5qP3wmH8LmSpKlq0V060
	 8Pb2FbvT+BlKOdlPDRwGPgJO1B9IFhSREjrFNxd9GAZME+oORbjLAGB+Y3a6M7cp4w/G/
	 K2gqHj1ydcUqIE9UxMiQ1K91n2huo/fipL4mdWBhjGDmj4jvYwkfrm8LPk55xfCT7HtHs
	 muEb6sqfjM9EWc5a4jXHUuTkhYiAT1U2tO3aRPgUwpM7Z8bQd8mMdRDLa9OsLx/027nuo
	 k8UuM0YbqPaY38Jy0/hhy3Wg341EYtQtxLkzln2x7qkliQnvfHMNR6iU+jUTXIc0l2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RLFgUwIl;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBA3606A323
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 04:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFBA3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RLFgUwIl
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-38190551625so12942196eec.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 20:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795669131; x=1796273931; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+MWBTNYSRWjg4nAw8/hdhIdqDgN2Nzlt5vynJ2DjOQQ=;
        b=RLFgUwIlz0g0MjaqUyAsLzSqvkJ1xLt6pNRY4OtdtTDSlvM9yWhwOMqlv82swf/spR
         cpN8y0G74ukIXQVmdxMFTvwiAVDQpXEb4h0UvDTgh24cJTLOD7b2+v/rs/d7CXIycJLD
         6/Msy39eq6ajkqsqV38tDFS8MpwW+dQxPz1xrQ8Dc8ur4k7630y1efc5HB0HdHJ7OxZo
         g/ivpWJyMYJJJJ1i+qOAkTDlHlCdrB7MClyIVaIO7z5NLZl8Eu6yrksd3gzIVVAwSJpm
         CfXShRM450RzeD/OuhH+/53DkoIF9c4PQI68XlBu+thZ9SMj1Z0ZZoe83miPr9iKsH76
         CfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795669131; x=1796273931;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+MWBTNYSRWjg4nAw8/hdhIdqDgN2Nzlt5vynJ2DjOQQ=;
        b=ShOEMf6Nxo5ySdh3VGXQqdIsiI8PvSPs08naIK1CmApj4s+cATfrk68g4Ty+Yxsun6
         JfYb/KeRBDoKl+qiQtv28zCujyVNaWxS6jzZ5Kwao47UtRTuTeMBm1NXTn/049VoLPHC
         kxWWx7WgJ8MbUSCgSoM3KXBicUq0M9dvzC27/a+EIcnNjgQTvTqpzXZSTtGOLH/pjPCk
         YJXI5d7iEEzNgN6D2z9b3v2JBDqjHPLNsA1NJRoonfYdXIvT4YR+uKumNBfFzhWYhV33
         JPLZvlPm5TG26ohutxnX/q5U8qa9qEYVkyCxG1mmFqiaFY+NBDzD38969FmvTLiQs/vo
         tD9A==
X-Forwarded-Encrypted: i=1; AL+hErFpu5DwnDYygNkVcMNm/uWS/KcTeBq6oHv0lvgBHVF0edTQfYc2NTjTQT/bgS0+b4xxIEttrSzxIQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+B/NCgZB93PbXTmSLAGfH9G/S1Z5oczHN9U35e4ksYP3GqC59I
	gKBL+ZbCm0dHi06Kl5p7b1hWjET9w/b+uq/UuzvCyaD6WeFrEjmvhQMa
X-Gm-Gg: AZFdTZfj0A4gjKDwv3BvvR3dyMh9F5SIHV+5rZLZOEBoOj2IyyumAyQ5a/WwV4XawJm
	07qgqv7HnxR8byePJU7+Y1o0Ak/qN7lCvebQfTP+RYDY6QKX29GVDpPEaExYJhPlk7dceU1SMvO
	PT9QJdSM8Yp2MpdKVnmxuFe7aF/56SK0YDTb4VgeaOkPHxzx+e0xBlz/6MKlcl/BLD0KeaS+LeI
	NV8QXpzb8m7GErNboRcZmQFpmp3wcchchjXWdqftIIWfK/Ne5W5C31lau5kUr8XCodJR6UEZ1YV
	S2lOKViTq/cyxwali8Vlb8+x2NPkdJiYTASsRzJPy+4f0lvhw4iebA6W+3XHdaGNP+ZxPGY04dQ
	OE669SMi2ri8T/Enjs/85ATJr4GUGBmpzsAr05pCr/OxUxUKuAjCxBRG5UVlt+5L6Ek/2qmpEpT
	0Jki3Au3BIpnwx4pFhWVMJdzzYAlpoV+bsZuHcqeSJjTgOjcsLCJpkATKrdwZ7eUXMOUf77wmC+
	V/owOv+KQ9f6HG22E9wckZ6hp1dmz5Z3xgnJNtapqt5Md/JVekMB7EDsugiWOvKXOVgTyEXTuqm
	Oamkz5Xg/N1RCvnf5mgPeayg1Zn+6HFF8b5p1Qfk0vlimNoyFUZ8i/TWxr5X3AlFi+KaC/r3Bpg
	8/KswMTk=
X-Received: by 2002:a05:7300:601e:b0:386:1e2e:ce0a with SMTP id 5a478bee46e88-3861e2ed1bcmr19606973eec.27.1795669130976;
        Wed, 25 Nov 2026 20:58:50 -0800 (PST)
Received: from Sobhana.localdomain ([152.59.222.211])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e96bdsm54800362eec.7.2026.11.25.20.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 20:58:50 -0800 (PST)
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Thu, 26 Nov 2026 04:58:08 +0000
Subject: [PATCH RESEND v15 3/8] thermal/qcom/lmh: Switch to match data for
 SoC CPU-to-node mappings
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
Message-Id: <20261126-sm7250-v15-3-492014ec0a52@gmail.com>
References: <20261126-sm7250-v15-0-492014ec0a52@gmail.com>
In-Reply-To: <20261126-sm7250-v15-0-492014ec0a52@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Taniya Das <taniya.das@oss.qualcomm.com>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Sreeshankar K <sreeshankar0910@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795669088; l=4181;
 i=sreeshankar0910@gmail.com; s=20261029; h=from:subject:message-id;
 bh=4OXsCzvDxUDZzUq7vC0F7ppwML+xpv9VHox1Zc+zKA4=;
 b=iheqhOtdpQh/0n3iRRubDWuH146ojwlMj03gsY5OjYOhXTj1+XoFKhFe+wELpJighk7dT3Yao
 Hv0TPWTNrXDDS0mPVo8AdoPKojWBGrDV40/iwV7M6wZYIT5nTOAQJTP
X-Developer-Key: i=sreeshankar0910@gmail.com; a=ed25519;
 pk=CGSHduvtn2hwLCNRXRc9s/fh6X8PH/zNdp08zC8hOuQ=

lmh_probe() hardcodes the mapping of logical CPU IDs to LMh
hardware cluster node IDs: CPU 0 maps to LMH_CLUSTER0_NODE_ID, and CPU 4
maps to LMH_CLUSTER1_NODE_ID.

This assumption only holds true for 4+4 big.LITTLE architectures like
SDM845 and SM8150. On platforms with asymmetric cluster layouts, such as
the 6+2 topology on SM7250 where the big cluster starts at logical CPU 6,
lmh_probe() fails with -EINVAL. Consequently, the second LMh node does
not register its interrupt domain, which in turn causes dependent drivers
like qcom-cpufreq-hw to fail or indefinitely defer probing via fw_devlink.

Address this by introducing a SoC descriptor structure (struct lmh_soc_data)
and an explicit mapping table (struct lmh_node_map) associated with of_device_id
match data. This encapsulates both the algorithm enable flags and the CPU-to-node
mappings per compatible string.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
---
 drivers/thermal/qcom/lmh.c | 63 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index 6bfe25021..de3fe64c3 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -94,19 +94,53 @@ static const struct irq_domain_ops lmh_irq_ops = {
 	.xlate = irq_domain_xlate_onecell,
 };
 
+struct lmh_soc_map {
+	int cpu_id;
+	u32 node_id;
+};
+
+struct lmh_soc_data {
+	unsigned int flags;
+	const struct lmh_soc_map *map;
+	size_t num_nodes;
+};
+
+static const struct lmh_soc_map sdm845_map[] = {
+	{ .cpu_id = 0, .node_id = LMH_CLUSTER0_NODE_ID },
+	{ .cpu_id = 4, .node_id = LMH_CLUSTER1_NODE_ID },
+};
+
+static const struct lmh_soc_data sdm845_data = {
+	.map = sdm845_map,
+	.num_nodes = ARRAY_SIZE(sdm845_map),
+	.flags = LMH_ENABLE_ALGOS,
+};
+
+static const struct lmh_soc_data sm8150_data = {
+	.map = sdm845_map,
+	.num_nodes = ARRAY_SIZE(sdm845_map),
+};
+
 static int lmh_probe(struct platform_device *pdev)
 {
+	const struct lmh_soc_data *soc_data;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct device_node *cpu_node;
 	struct lmh_hw_data *lmh_data;
 	int temp_low, temp_high, temp_arm, cpu_id, ret;
 	unsigned int enable_alg;
+	bool found = false;
 	u32 node_id;
+	int i;
 
 	if (!qcom_scm_is_available())
 		return -EPROBE_DEFER;
 
+	soc_data = of_device_get_match_data(dev);
+	if (!soc_data)
+		return -EINVAL;
+
 	lmh_data = devm_kzalloc_obj(dev, *lmh_data);
 	if (!lmh_data)
 		return -ENOMEM;
@@ -139,24 +173,23 @@ static int lmh_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/*
-	 * Only sdm845 has lmh hardware currently enabled from hlos. If this is needed
-	 * for other platforms, revisit this to check if the <cpu-id, node-id> should be part
-	 * of a dt match table.
-	 */
-	if (cpu_id == 0) {
-		node_id = LMH_CLUSTER0_NODE_ID;
-	} else if (cpu_id == 4) {
-		node_id = LMH_CLUSTER1_NODE_ID;
-	} else {
-		dev_err(dev, "Wrong CPU id associated with LMh node\n");
+	for (i = 0; i < soc_data->num_nodes; i++) {
+		if (cpu_id == soc_data->map[i].cpu_id) {
+			node_id = soc_data->map[i].node_id;
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		dev_err(dev, "Wrong CPU id %d associated with LMh node\n", cpu_id);
 		return -EINVAL;
 	}
 
 	if (!qcom_scm_lmh_dcvsh_available())
 		return -EINVAL;
 
-	enable_alg = (uintptr_t)of_device_get_match_data(dev);
+	enable_alg = soc_data->flags;
 
 	if (enable_alg) {
 		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_CRNT, LMH_ALGO_MODE_ENABLE, 1,
@@ -231,9 +264,9 @@ static int lmh_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id lmh_table[] = {
-	{ .compatible = "qcom,sc8180x-lmh", },
-	{ .compatible = "qcom,sdm845-lmh", .data = (void *)LMH_ENABLE_ALGOS},
-	{ .compatible = "qcom,sm8150-lmh", },
+	{ .compatible = "qcom,sc8180x-lmh", .data = &sm8150_data },
+	{ .compatible = "qcom,sdm845-lmh", .data = &sdm845_data },
+	{ .compatible = "qcom,sm8150-lmh", .data = &sm8150_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, lmh_table);

-- 
2.43.0

