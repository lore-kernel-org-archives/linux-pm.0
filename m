Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9591F331EC5
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 06:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789971646; cv=none; b=fmRBayS/nrR8PW5wC4T530IM3R5t/ekd0I/q7n7w0kipkeTP6SblTC7bzDMxcEX7S8FhfSGmg++8a6S1cFYj+QFLp4iaVdL+oLoZX2Clk3oO99wu8ghxMm8T0gY46+xxiENffcOL74upXKpLz6kyi05kKmCthSeA2KY4UxAdEWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789971646; c=relaxed/simple;
	bh=RUL7inyPVfMEDIdTmDPbTdi75bTvJjeuqLU+fEENxjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u/VWsrx31BJboul/bhVR1G5SN6LhxrAP/vy+YQxpdiymYgsnnav2bOdtFi64ZrsFoLCu7AYrqTin7NF0lq7H0YUnl98CmG43q5EVrGS04iRMjYf8d7e6MVJWrC0dV6BRqrTYSgFQ+WWhdgVa6jH6NSK4iJlL40otpvWpsf2Tdn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T34hDf+j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LlBjWFCY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T34hDf+j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LlBjWFCY"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L3ZewD3490929
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 06:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LDoqZrmU3C3bo0NhJ54zUh0/kmQH/pV2aeGmRzr4Zt8=; b=T34hDf+jP9P/ZCz0
	bhbJQC2Mxsi0e3PoP6Jtuqwr3Ue9cwQ22MzHQvb8BeriEUnBV5z9FANQUHLfZHp5
	EoooTHF/V07VBbXgf2IH82y/chc4RP3Usyef13bbOqo+HFG3mqbwIwFgDRwJGjnl
	1GFKrydgXlGmKyUoNvvIjLyJwG/AEjyBn/IiziyjGjYCidqwA2eWTQIQjB2rtmhb
	bqFe8vszG172gonOS00TwCQBWNn3b/M6mwKE0IOf2aUDXoxV7si/P37R6JKmu2cK
	w5JZ4+AESeZutt7dIiyanrGQxcgXpcCunAxymQziDrRZZECe0w9h7mAph2/hgS88
	PwC0qg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gskp9vv8u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 06:20:43 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc73895c7d5so1803869a12.1
        for <linux-pm@vger.kernel.org>; Sun, 20 Sep 2026 23:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789971643; x=1790576443; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LDoqZrmU3C3bo0NhJ54zUh0/kmQH/pV2aeGmRzr4Zt8=;
        b=LlBjWFCYPwa0KALVt5jwhZDfy2kVC7Foig3KG0w+NAi3H/nNzPloZ5iBlqhUAH8pBb
         /BqOOGQAf8guuhFDs1Vu72sZlLHgwOS8aobDyVoyhZkR1F5pHF223ydrHkfyJ+Syfq0y
         ouX9fXtBrovyhcjlwyDpj9kiY8756AHMUCWe5kYOQHjtIrF0U3p9clkiJNf3l9EDWF6K
         j0Atpx+5HKC3pVs91U58zKsUzBTeOtdsSOUZOVSozsKuP7Zb9NkyJn+Sqzx3mqFZ00xV
         jHUkP/VTomxAekWaDNMtvUESf7KIkv4oGZOZySfNaoEvknw6OuF3YagNOwtqe7m4jN6/
         48Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789971643; x=1790576443;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LDoqZrmU3C3bo0NhJ54zUh0/kmQH/pV2aeGmRzr4Zt8=;
        b=Bmk2pXX6E/Y1vrky0/8rg88E0ydel/BsTctoK3GAjuLKyY6/lVLgd45KdC7vrLUxHs
         vDQBmRIJCt0oGgcAeACPXjt6FPqtEE4rfjebKkO/HLm7THoqBHBEzJX+yWJmMoG16cU+
         9uIcphY0xAXRDKkPqRZLTtuo33moco/Cr40qqo02TM6FZggjWEsFKcOf2YlUWMD5gI46
         jMXXmbYH7t05cg3SuO/FstSD2VGNRByl86BsR6xe+cziJb4QwaQIpBJHuY7AXml6LPVt
         vlzWQrf4oZjjHs9zWt3x/491iu9zrY5JbRYy9Obl5HdjLqMcEJ34xR8Yx61o8Mbo6zEP
         rSlA==
X-Forwarded-Encrypted: i=1; AKwUvBzyLpRyBhIffJlivMavJgJ7xebL9u7RJvEgcFq71DEOUHrkdFMIOeJoLGnzG6VOv647g0DXXQCiWQ==@vger.kernel.org
X-Gm-Message-State: AFuF++l2Bum36uIkZ9kkOESqG6FDllzxTfmuvGxQo14cW47bCEveK4pn
	x66TtJO8BX4lA75Nz9eqS8uzOUaEsqvdhROD2RVZtrDOnW7ZQ6fNM7xwJqJYFrqQ//iqBrmdcSr
	AIFc85FwKEipmPXWItw0HuyJCyxEeWZyJauAzcbOu5fKahedjItlfjym9B8K/wg==
X-Gm-Gg: AYBFou0Yix1ERwZhC3Zv+6vhAb7nS14WBO827EnqUCD+oWijDz8uTf2M7oXrui8wPYf
	SpW1FcB4rqAj88g+ll3hPBZ7lz7CB0ApwIVaRDA09Bh0Do2an+5vQouW56uSvBrCUfZA9JiM8Ut
	VsNsC6wAnnESOA6yaLKPDx5r6ZH9JPVBROWOAMQcq5hhdRQswWWQIWF4HjnAr/1HCGBWDr4S3IA
	wELGhx1xAC4B+l1DzOytJ9APo7aOVfvVz1Kp4Ysux3mdic6jh7MElOyO+Bt+druhGQu0hies2VP
	ZfoGNEsZruAzkVHPz03KST8Cy4byisWrInIxtazDSHZbjtkbJ4cUoDY6X2MnTNzkZKTbjXIBehW
	apL26hReGr7PKOsNPVbB5CCwzq5RiOigylaykwFAuf2enSFtqLnkQcuuAG1qke4I+n1T8sRX4lZ
	XkLcK3Cd9XhpwfyDYQaoJSYUNnfs1u1xzGdw==
X-Received: by 2002:a05:6a21:596:b0:3b3:216b:2743 with SMTP id adf61e73a8af0-3dd8c3f19acmr18925095637.4.1789971643298;
        Sun, 20 Sep 2026 23:20:43 -0700 (PDT)
X-Received: by 2002:a05:6a21:596:b0:3b3:216b:2743 with SMTP id adf61e73a8af0-3dd8c3f19acmr18925047637.4.1789971642854;
        Sun, 20 Sep 2026 23:20:42 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331d3f2csm14091444eec.28.2026.09.20.23.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 23:20:42 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 11:49:41 +0530
Subject: [PATCH 08/11] clk: qcom: gcc-ipq5424: add the MEMNOC clocks needed
 for the NSS block
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-ipq_clk_changes-v1-8-d242e3d49648@oss.qualcomm.com>
References: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
In-Reply-To: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: en9zpXFvlC7OqRQ8oLqE1QC6A30tXp9N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDA4OSBTYWx0ZWRfX1VEfKTIuDwJs
 Hsifjk9O6yfCqfVKCxBB6rdUG5tHZLLrGGyuNmKQ0cdQy3wxnA4E2lGgeHXcdT73Z9oU9EHFNVe
 yYFZQXXATTGhGv8Y5sOOH4g/T0yQgpMwYhX34sAqPNlt0DaPuKPEAMZqzqE5TExKgk5HpJI8RQD
 PXyEPqoYFZZlfMaCEhMbJYSw6dzExIGOGds/73oEn/c+trjFST/WIxqGpRGHWzoGJUDpOMrurCi
 HnREmcRvK+5VcaDh7GVN5d+vX1kBardyfxiOJXCtFM+XavoRT/mGIyPTZiuBirlwlaCx+G88KvA
 iYqzKfY9H20XBwXyRTQ4pnbeT8D9TMtcrmtVI6xcaPy1itw6hPVrTAliV/ARpwKx5h9o04tsOWd
 qSZJ4mIcJe0bZFQUwgVAVrUS4qJNWHfBYEVdr4SMupA4Z0Oa36T1jDbwZ59T6Wa0j323MnSvA6l
 gH94B2mqkwp6gz//l+w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDA4OSBTYWx0ZWRfX8JHllGH07VXY
 XOVdVQrWzawB6O5ZzNhcz6SphC3xJn7VexpaXGRR8WlU1oLU86k1jQvz1MQx/+1zShIJ0jk2E9/
 nbRUCOZ3l/VHIj+9k/8tijhmmSzUCDg=
X-Authority-Analysis: v=2.4 cv=BKAmP1QG c=1 sm=1 tr=0 ts=6ab0ccbb cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=GGYtgJ29c02LjanIf4UA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: en9zpXFvlC7OqRQ8oLqE1QC6A30tXp9N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210089

Add gcc_nssnoc_memnoc_clk and gcc_nssnoc_memnoc_1_clk to the GCC driver
to enable the NSSNOC-to-GEMNOC path for the NSS block and expose them as
ICC clocks.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 drivers/clk/qcom/gcc-ipq5424.c | 93 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq5424.c b/drivers/clk/qcom/gcc-ipq5424.c
index 3ddd4b3aedea..34d1157155e5 100644
--- a/drivers/clk/qcom/gcc-ipq5424.c
+++ b/drivers/clk/qcom/gcc-ipq5424.c
@@ -34,6 +34,7 @@ enum {
 	DT_PCIE30_PHY2_PIPE_CLK,
 	DT_PCIE30_PHY3_PIPE_CLK,
 	DT_USB_PCIE_WRAPPER_PIPE_CLK,
+	DT_CMN_PLL_NSS_375M_CLK,
 };
 
 enum {
@@ -47,6 +48,7 @@ enum {
 	P_SLEEP_CLK,
 	P_XO,
 	P_USB3PHY_0_PIPE,
+	P_NSS_CMN_CLK,
 };
 
 static const struct clk_parent_data gcc_parent_data_xo = { .index = DT_XO };
@@ -291,6 +293,20 @@ static const struct clk_parent_data gcc_parent_data_11[] = {
 	{ .hw = &gpll2.clkr.hw },
 };
 
+static const struct parent_map gcc_parent_map_12[] = {
+	{ P_XO, 0 },
+	{ P_NSS_CMN_CLK, 1 },
+	{ P_GPLL0_OUT_AUX, 2 },
+	{ P_GPLL2_OUT_AUX, 3 },
+};
+
+static const struct clk_parent_data gcc_parent_data_12[] = {
+	{ .index = DT_XO },
+	{ .index = DT_CMN_PLL_NSS_375M_CLK },
+	{ .hw = &gpll0.clkr.hw },
+	{ .hw = &gpll2.clkr.hw },
+};
+
 static const struct freq_tbl ftbl_gcc_adss_pwm_clk_src[] = {
 	F(24000000, P_XO, 1, 0, 0),
 	F(100000000, P_GPLL0_OUT_MAIN, 8, 0, 0),
@@ -1108,6 +1124,41 @@ static struct clk_regmap_div gcc_usb1_mock_utmi_div_clk_src = {
 	},
 };
 
+static const struct freq_tbl ftbl_gcc_nssnoc_memnoc_bfdcd_clk_src[] = {
+	F(375000000, P_NSS_CMN_CLK, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_nssnoc_memnoc_bfdcd_clk_src = {
+	.cmd_rcgr = 0x17004,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_12,
+	.freq_tbl = ftbl_gcc_nssnoc_memnoc_bfdcd_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_nssnoc_memnoc_bfdcd_clk_src",
+		.parent_data = gcc_parent_data_12,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_12),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_regmap_div gcc_nssnoc_memnoc_div_clk_src = {
+	.reg = 0x1700c,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_nssnoc_memnoc_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]) {
+			&gcc_nssnoc_memnoc_bfdcd_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+
 static struct clk_branch gcc_adss_pwm_clk = {
 	.halt_reg = 0x1c00c,
 	.halt_check = BRANCH_HALT,
@@ -2793,6 +2844,42 @@ static struct clk_branch gcc_pcie3_rchng_clk = {
 	},
 };
 
+static struct clk_branch gcc_nssnoc_memnoc_clk = {
+	.halt_reg = 0x17024,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x17024,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_nssnoc_memnoc_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_nssnoc_memnoc_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_nssnoc_memnoc_1_clk = {
+	.halt_reg = 0x17084,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x17084,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_nssnoc_memnoc_1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_nssnoc_memnoc_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_regmap *gcc_ipq5424_clocks[] = {
 	[GCC_ADSS_PWM_CLK] = &gcc_adss_pwm_clk.clkr,
 	[GCC_ADSS_PWM_CLK_SRC] = &gcc_adss_pwm_clk_src.clkr,
@@ -2938,6 +3025,10 @@ static struct clk_regmap *gcc_ipq5424_clocks[] = {
 	[GPLL2_OUT_MAIN] = &gpll2_out_main.clkr,
 	[GPLL4] = &gpll4.clkr,
 	[GPLL0_OUT_AUX] = &gpll0_out_aux.clkr,
+	[GCC_NSSNOC_MEMNOC_BFDCD_CLK_SRC] = &gcc_nssnoc_memnoc_bfdcd_clk_src.clkr,
+	[GCC_NSSNOC_MEMNOC_DIV_CLK_SRC] = &gcc_nssnoc_memnoc_div_clk_src.clkr,
+	[GCC_NSSNOC_MEMNOC_CLK] = &gcc_nssnoc_memnoc_clk.clkr,
+	[GCC_NSSNOC_MEMNOC_1_CLK] = &gcc_nssnoc_memnoc_1_clk.clkr,
 };
 
 static const struct qcom_reset_map gcc_ipq5424_resets[] = {
@@ -3264,6 +3355,8 @@ static const struct qcom_icc_hws_data icc_ipq5424_hws[] = {
 	{ MASTER_NSSNOC_ATB, SLAVE_NSSNOC_ATB, GCC_NSSNOC_ATB_CLK },
 	{ MASTER_CNOC_LPASS_CFG, SLAVE_CNOC_LPASS_CFG, GCC_CNOC_LPASS_CFG_CLK },
 	{ MASTER_SNOC_LPASS, SLAVE_SNOC_LPASS, GCC_SNOC_LPASS_CLK },
+	{ MASTER_NSSNOC_MEMNOC, SLAVE_NSSNOC_MEMNOC, GCC_NSSNOC_MEMNOC_CLK },
+	{ MASTER_NSSNOC_MEMNOC_1, SLAVE_NSSNOC_MEMNOC_1, GCC_NSSNOC_MEMNOC_1_CLK },
 };
 
 static const struct of_device_id gcc_ipq5424_match_table[] = {

-- 
2.34.1

