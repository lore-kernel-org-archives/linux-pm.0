Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794807268;
	b=11HDWilF+sZDB3zc/iZmIAVgIuiKuomtJT8HaQgvuzqGh/YI05FtQ6Oh/sbJJyGlWRqx
	 TU5Ev7g3MbTFp9Us7P9hmA2A+FRjAvpDuD2IRY88yJfrQBNuyjwMcj9gErzEQks4YpKp+
	 KMXt1HoBAKURJvBNVK0cQXaMWpKbxRyxEJLdBw91BYHvfRLgORR/xl6hcKcTYh2SB8YjL
	 +aLZcdpZwcdDHkgTJamys/n86aVymfcVrQ9tGQUVBnBlAysfIc3xN3KOVPzPFfnTNcOIH
	 bkJ/mRNLT1sDKEsjZmV7mixSnlEOIMty3Hnr5X66FROkKMarPdGXjDMgaYpMrnliLLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794807268;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=2fL6zbaASk684qx6VKumcp/fIHqrXs9oL5KQ1XlMF/s=;
	b=25AsFNm7Strs97QK1Ld2hKY4KQjzmbY3QRJXlf3K5NwrDQ5+usr2mV/QRu0it7GEIz8F
	 jdO/gPSH9LSbsdEo7806K41z82hBjXVC/GOqxJvfW01aCbjBcwGQ564O7XtRWfIwvBvhm
	 CyxB+OAuY27SLC9TndSZqOwhA7d1ywcvn2Pf+OWIr3o8W36OIFrjixGdv7KnB2NtNuyyJ
	 ubVLJLfREcIH4diZlFSMPCgt2SyyqDvCgyIt1DorUQ+A5PZ59aTIgoGwXBtWejXPWJfHt
	 rM/0VPJeMMUBiuMH1xBCJu6gGWUxro2kTJJ4/h67n9vXBgWXcKrHFk8joKlBAmRXb/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FuMpofNt;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82165606A332
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 05:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82165606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FuMpofNt
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3704d30b84fso3549272eec.1
        for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 21:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794807268; x=1795412068; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2fL6zbaASk684qx6VKumcp/fIHqrXs9oL5KQ1XlMF/s=;
        b=FuMpofNtUp+eiRfRkKbt6dnoH12nORN94fUQ5/v2aVBAtnHLnDtgUMPJtudVJaSZjn
         bsEHMxEXQhkaQX5b0T7whLiKqR6rKvJ60HVT7x+V9xKDk+T3dePfhz5YqeTDkOzQN3E5
         bLCEr44FgTk9taMzhVCNThsC467LYVaHy5rFQK2qrKlYVcOZGl7OYVgOyEEgsLbrXntk
         Hrufw0vbYvHt8HVcr7HoYYD7goFTIoyERvIPpe5wzA4kSokxtCYVs0PhKl+oGx6dVd3K
         riaT5MTwj/5WQ0aNMZuJx+bni+nzuDtAyxoqLGocgNYe/UbDrVi4mlTaSpPH1PY338+o
         Qc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794807268; x=1795412068;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2fL6zbaASk684qx6VKumcp/fIHqrXs9oL5KQ1XlMF/s=;
        b=JOzTyKL1TVDixPcsW+BYBCRcikBD0KA7Ow1AlGg5z5WCQOFkKljKBXacMWfaBOmrDa
         ft2lubHfk8nFHu8rgM3l4V8lwv5NkZHCBnF/IdZh7hj81+L6MFRe8/6XX6gVTRKAu4r2
         QVU4cPZ4F2Uvw/tsc20ZP6NuySqp0IGJSJ4c1keZMbi+I0luIBSf9XNLb1dbFkmTf6q+
         tO1ujI4l20fVNxSJkWrEgy6jASbv65wsIXR1pSP6HclaS9/flJ+ZF/dNGoKXtmL2K4YL
         fEM3z910KHraDKTBttdaq7IFKO2Zb/eQHrud9BKzj1KBAknSG4l0NGG0nfRKCNqKwW7r
         mDWg==
X-Forwarded-Encrypted: i=1; AL+hErE1cpCa7tV/LS2XXsFUOHBP3aKqWvZc/nnR4Bv5ANBgoDZkO6vjwBFPfDIg/wMhJD+6JSCW8da8Sw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8SQa7VYN7VrVkDbD1Q0CsfcvDMJYATZjotzbtOwWtg/mcRRnH/
	J3Sl42RSrq5H4dkFSymG0wwEQ7visnyhs81EChx/yFWhoT0dmcIVMzv/
X-Gm-Gg: AYBFou2pKYGUm1sfsp1OOl0gtfEST5SAVdcLwRwA9D0K9uEmmzB0jregropz4B2XNj+
	aANhUVoxs/SK5hhefngTDzgPhOhhJYjd5o8V1JqXdcIytty2d4gqAzYYKOdnb6RW2bdg5YDNlpN
	IKSCMNSRDbMoItKlbbqhYYg+652bG1xT0bHG5vjjAgKvMOJpcVLRQN0RbRj+lxwTW3iS4Hc5yQw
	RVp/DIERaykW9FEV/TrQ2BexsosZ2w2D3Sml63gYJkQTbPHXRe2rEfiyTu1Dtw9faUk/ZmXuTRj
	b+ySVmAjTcFkD2ZL919P/puKawBFMfgu2jPLDcQ1CuzQoH5jvAnTzpP+QyS/GC34MiEuR/nEAqs
	RF2K3alpBUrDv06irT4lsU83lpTiQ3OZcM+rjJMKn/OOCoLCWI1Ey7qw/9Isn07wjI9jRyiToVP
	EG9w7i/D1RbD2NUQ4FUdw/CTt9XejFf5i1GIPGW8VRxBHAKfG3t6ImOOtRv1LU5GSUBW6Fc4V4b
	o5o1CwaztyV+K8n6bH4OXAKBzGInLX6ATY82OKsSWmwGajsvRypY/L34UPIUKkXIk6Kjm/ODI96
	3oBnH6+Niz88ed986o9ZPPrh9BtQXgyE1jdS6PKAhHLFn6On/wAlZmyW8XfhMx/Xxlc6nLsu9Hh
	m3ju5
X-Received: by 2002:a05:701b:4516:20b0:19a:e0eb:6916 with SMTP id a92af1059eb24-1b50310592amr8163491c88.42.1794807267615;
        Sun, 15 Nov 2026 21:34:27 -0800 (PST)
Received: from Sobhana.localdomain ([157.51.206.8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031468b7sm33463380c88.5.2026.11.15.21.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 21:34:27 -0800 (PST)
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Mon, 16 Nov 2026 05:33:47 +0000
Subject: [PATCH v15 3/8] thermal/qcom/lmh: Switch to match data for SoC
 CPU-to-node mappings
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
Message-Id: <20261116-sm7250-v15-3-6acbb232fef8@gmail.com>
References: <20261116-sm7250-v15-0-6acbb232fef8@gmail.com>
In-Reply-To: <20261116-sm7250-v15-0-6acbb232fef8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794807228; l=4188;
 i=sreeshankar0910@gmail.com; s=20261029; h=from:subject:message-id;
 bh=bZHb2T2DvlEG6nhD1/DLPHwdE/GdBSsox2cJaGJ4pKw=;
 b=kw22MPin7eMqG9dZ6eGd+PAQWS7wBeVL7HKcVaAUHWuZI4BHDoRXntvUpOH9ep83HfeSukHdZ
 zHEJTs+uq+SDBTgqqBkCApBX/iJ6UYR+y4c4wAuSNmewqsgaKjue24/
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

Address this by introducing a SoC descriptor structure (struct qcom_lmh_soc_data)
and an explicit mapping table (struct qcom_lmh_node_map) associated with of_device_id
match data. This encapsulates both the algorithm enable flags and the CPU-to-node
mappings per compatible string.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
---
 drivers/thermal/qcom/lmh.c | 63 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index 6bfe25021..9d66d75d8 100644
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
+	uintptr_t flags;
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

