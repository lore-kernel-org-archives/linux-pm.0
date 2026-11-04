Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810856;
	b=Zla53BVM77W94kFSadDe1qvsKPIdT3TigCDIJOfL5ivGmhL0xT3BJZgTkNjDnNj/XJsN
	 VS5Y91G9vH91ZhNyX7O8NVdFTBgv9HFRVI1S4tpqRZ+egL2ZULI+OTNeu65NqacrGTeUx
	 75qlcJYpERaBOLfq9f1/ViSC6Ncl7uiw2aB8wCLH7gXf5izzlFvPG3ayheVK6lh++FHS/
	 8cvWCKwNHryKQkx7tgoJaA4pyLGCS6sRAh1YQA2M0H/kQo+WpVOKX9l+v5L2ejlGVDHFz
	 ebaUOqSTeKO6+AisWoLInEfPqDVB2OTefJjd+TtBcthPTojUrgByO1RQvAnY5w4Aojg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=8vSo5PyKnquWojnlUKNTbITLgcvow3SdQj1P0U2fTNA=;
	b=Or7+tSeajf7Heqp9mtim/4GmIv1TA97Lv9HrBFQ4Q6WsEIIlfERLgwQ3VXwN3db2zHjE
	 rtxHH2/bGluOHosRFRfv4Sv/mA/XALMTs5YddhylKDRZrZ8+ItiheUpnGiBKGCV9AlyBQ
	 J6JihEDvn4MiNyCOsrNgrHOyNb2pCP8QONr1ekXT9J7ma2ty0tbsbjgWZnS1vKQuujXvU
	 pJFN1JaqHZtMlSMwechfraumB/Rm8AvaEUmpKLX0wnQ4/mgAaGtIay0Mtt8XRCgK19joK
	 veTfr0Tk0YGp0W3WaAxcQK/xn1T2Jk8F4F2p9lj6+DLBo+kGzDvq9w/IC162QQsCdTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="jJUdT/Bm";
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C26606A331
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 16:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2C26606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jJUdT/Bm
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-15ea896ddc8so1598760c88.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 08:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793810855; x=1794415655; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8vSo5PyKnquWojnlUKNTbITLgcvow3SdQj1P0U2fTNA=;
        b=jJUdT/Bm5BSfggP/3oMzI7shF08QAY1a7CC1Y/0EE0NWAzgoC0hvdiGxFJFZDoaMpd
         WfKBaXOd/bllAL/Qo3P1GuN25EXCu11jNFNhwzMQtGVhfr2ukq1k9Ak8rsUe06FEdJPu
         Yd/5JTSJF0Es3UPj06F9a4a6FJHEMAw8S4bUb0E+M4nHv9TI61jpgfOoPs6dXeQgNRvX
         WF1F9RxGR8Wh6j0ASkmYPu140n16p3s7qlIVgF7Jb/CPxeO6oE0Wwm2dIodAbpO23nQT
         jkrexWypvudowL1U5BI6d252hDYryR1qHXUtBWbe7oLyu9Y5OpqVevFXBDFIKSGkO2cH
         GE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793810855; x=1794415655;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8vSo5PyKnquWojnlUKNTbITLgcvow3SdQj1P0U2fTNA=;
        b=OjRLcmai3uKDB0TM+XwQZBLsBTSGomfUwlH/DD1lNn+kbBmXbLKVcCPUlJNmm5uBS6
         nxWgokM+p3CrTGhz1n+wrr9wwicdyjLedKl4E/AHfhnH7eUtwjBFbOLKaeXi7Z2fDg8G
         7a+La3E9hv7M3OtBT6dnuqGJPfAVGvikgh1aB2tXnj0tYWRCZYqHBKalsncYrK1ZS7Vp
         BpT1apbHC3kmO/vOEw34U43Ppb6EvXY9D5K48o2wBOUt0qRVOy7xfNl9y1KKx/b0AafT
         qLmsaizSDGzsRyxrN2biWIDrod4lfBmP4y6K9TmbdTUgjsKL50SruzvCPXcqmsEM+CK+
         w3ZA==
X-Forwarded-Encrypted: i=1; AKwUvBwHEg4TaH54naUUr5IrVJdkwNF2jX7i2spHJ2p32yGQ4LkfLG76GInID9T637kxuKhZYod4rBEQmA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8gsjXOW6KEvpfddkB4RJ7EKrzVC67a/yNKOK3Nmgt/PamWqjKh
	npFboQNmJw4zf6cksXMg2EKP6mhcbVnM7XSCbgwgO6HJxv5he3YJ7tOP
X-Gm-Gg: AYBFou1yIOgxLpfKWBgl2lSfYVO1ZETRL/DHqCJ6C3ZVG2J8SPfqbu+lQr00TS7P+K1
	pJDPyKBjHvsZZQPn1YYUL9HxQd2HxdXBAuzflAwnEgAT6Ph1A0uTjOSPJdBDD9z51y47sNApBs2
	ssAum8fcRVHFHa1qWnkUY3zeGI3ziO9Gc1HE/KRmx2678dHxILK9HNAacgDFzKzTuOlJAXW7JYO
	zA3hGb433IdUm0LUkHF8hybiQka2nupf2zF06fxcQC+wkG2JNLYlaPZOL4WK01baLbKyEPOUugm
	AVdPYWqmiVHcxUpQ1C8GSCY6wLlhyMKu3BEl8MpXI1aecpm8z97gtvgbBDSOfqpdhZmsKndtP1+
	YZenZyk33gP4gvo4y3x6FiuI9zDOMWl5zJM7uTuvetkVlxFLP+jJYMva6ZzpqEVIxZrKphhVE9v
	bNBppwZMALCvAcGfLBK64xJSEaf6r/zJY/URfJ7km5rF7I+qwTDBYfMNXmS2i/e2dACs2/h0I8D
	hkuBamc0uP1QCFp0yavm9PVHxrRay46vj2DDbGw8Ff+cg6NxNwdCGwUjQiE2GAtiIjqMOFbyuLy
	oXxJv2zOZqL8NYWp5yvtm9CEGWS48h0tm+Z3ixKgPEuKEgXYypbdgcGErDCu/V5h9WlEhZ8tSOH
	iDOdEcwU=
X-Received: by 2002:a05:701b:4513:10b0:1b2:490b:6fdd with SMTP id a92af1059eb24-1b2490b7174mr2802961c88.24.1793810854626;
        Wed, 04 Nov 2026 08:47:34 -0800 (PST)
Received: from Sobhana.localdomain ([157.51.207.207])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c57430sm10839666c88.18.2026.11.04.08.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:47:34 -0800 (PST)
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Wed, 04 Nov 2026 16:46:37 +0000
Subject: [PATCH v13 5/8] thermal/qcom/lmh: Add support for Qualcomm SM7250
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
Message-Id: <20261104-master-v13-5-355b65c6f764@gmail.com>
References: <20261104-master-v13-0-355b65c6f764@gmail.com>
In-Reply-To: <20261104-master-v13-0-355b65c6f764@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793810796; l=1940;
 i=sreeshankar0910@gmail.com; s=20261029; h=from:subject:message-id;
 bh=CFhfNpAR/hsUoYP+FpbYSd22wi56uWW4Vnq2ksqBL70=;
 b=AHV5arLvLuQqAMLn4qDczJBTrUzBqyZHmum7vYKn9NSDkm/FNjxIHZSp/eoAIkIM4IVrypzxN
 KTUVsrytn6yAlacDB88TgXiRGdRNT7Cl5IXO6NA6AoS0kuPs8fkybxB
X-Developer-Key: i=sreeshankar0910@gmail.com; a=ed25519;
 pk=CGSHduvtn2hwLCNRXRc9s/fh6X8PH/zNdp08zC8hOuQ=

Qualcomm SM7250 features an asymmetric 6+2 core topology where the
Silver cluster consists of CPU 0 to CPU 5 and the Gold/Prime cluster
starts at logical CPU 6.

Add the SoC match data defining the CPU-to-node mapping (CPU 0 to
LMH_CLUSTER0_NODE_ID, and CPU 6 to LMH_CLUSTER1_NODE_ID), and register
the "qcom,sm7250-lmh" compatible string so both LMh cluster instances
can probe and register their respective DCVSh interrupt domains.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
---
 drivers/thermal/qcom/lmh.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index ef49ed1c6..ad6d34b8e 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -110,12 +110,22 @@ static const struct qcom_lmh_node_map sdm845_lmh_map[] = {
 	{ .cpu_id = 4, .node_id = LMH_CLUSTER1_NODE_ID },
 };
 
+static const struct qcom_lmh_node_map sm7250_lmh_map[] = {
+	{ .cpu_id = 0, .node_id = LMH_CLUSTER0_NODE_ID },
+	{ .cpu_id = 6, .node_id = LMH_CLUSTER1_NODE_ID },
+};
+
 static const struct qcom_lmh_soc_data sdm845_lmh_data = {
 	.map = sdm845_lmh_map,
 	.num_nodes = ARRAY_SIZE(sdm845_lmh_map),
 	.flags = LMH_ENABLE_ALGOS,
 };
 
+static const struct qcom_lmh_soc_data sm7250_lmh_data = {
+	.map = sm7250_lmh_map,
+	.num_nodes = ARRAY_SIZE(sm7250_lmh_map),
+};
+
 static const struct qcom_lmh_soc_data sm8150_lmh_data = {
 	.map = sdm845_lmh_map,
 	.num_nodes = ARRAY_SIZE(sdm845_lmh_map),
@@ -124,6 +134,7 @@ static const struct qcom_lmh_soc_data sm8150_lmh_data = {
 static const struct of_device_id lmh_table[] = {
 	{ .compatible = "qcom,sc8180x-lmh", .data = &sm8150_lmh_data },
 	{ .compatible = "qcom,sdm845-lmh", .data = &sdm845_lmh_data },
+	{ .compatible = "qcom,sm7250-lmh",  .data = &sm7250_lmh_data },
 	{ .compatible = "qcom,sm8150-lmh",  .data = &sm8150_lmh_data },
 	{}
 };

-- 
2.43.0

