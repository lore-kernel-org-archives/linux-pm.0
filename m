Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128913ACA40
	for <linux-pm@vger.kernel.org>; Sun,  9 Aug 2026 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786260533; cv=none; b=QybJbFjFNpKpfXKWt6R2CWJycALlxK19PjY/FadkVpVYdYwAOjk61qLjG/awaa22hKvGAP42rQ/RpPxoSsFxJt96iXdTlNJfZq66CUCypTKbfAIHb2Tr2pVRBWO/AuB1U6rc9uRhKV155sW3AF3Jbp5/XlorslorYdqjHuIZHGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786260533; c=relaxed/simple;
	bh=qBbpul6s9t2MbFs1zwamIHKG/8j9ePWvWCDaqei2M8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dn8rdQ/zPqG6AZLJeQLOPGhXqt5aASM8mH96wxDUFWcea3ag4tQEH55gfKNmhFBKOia2UE2BLoHPncIVU6kLRFkTxUuRR+nJZ1NXzYO1F0P/8zTqmgnRXCOJKjEO44ftlsfG2vB6XcdIF5py48HgFUL4YTJO3Wg19jogcMOyjKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bhs73IrE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K8EZ5zt9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bhs73IrE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K8EZ5zt9"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6795cHe51172246
	for <linux-pm@vger.kernel.org>; Sun, 9 Aug 2026 07:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CFsKeMVfxJH4s1PT8XPWbbRiwFRVNAEwOPJka6wI7cI=; b=bhs73IrEF/zuAdtI
	iJ56ag24mgVwVPmxbMPiMj9HvFygDXn3u5zBFxMdaVqeFShu7c/4dxs7JXzZ7qWN
	Hs2q2TrYOHL8c0+6HH/VOSHEW35pHdyBbdDONwoTqnzXYuLIFogqQMrSqnzHaWA5
	gE26rfsOupwZHRRZVngDfBstt6LP6YcAnRhXkdmB6xOJuFyQJ2D+mp2wOKOcT9kv
	a4BlWNtjAw8v7l5gkxOzhMlH8q8yn7SDpyq/Hsg/YeBIg0m+e09pDCe8CY+UqHsG
	6FTq7yDS+Z07Fspau0mES4cyJCNRradB66Q1GYzlG3kjZmDmKXkujjpun4qwQfhN
	vpksqw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwwmgtcgt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 07:28:49 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb6dd278512so629681a12.3
        for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 00:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786260528; x=1786865328; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CFsKeMVfxJH4s1PT8XPWbbRiwFRVNAEwOPJka6wI7cI=;
        b=K8EZ5zt9hTnOH6PTWUgyGQHPD9H407Ul99NP1pkcN7UDDpsXENAqcbcyCb3H1sZig/
         gobR3xouie6VMIksgbm4DoEnE8ULatQe/KnrL3L0dOGmMcyBx5gcvPToVGrAj4cXy9/I
         bE00Q0uBd90j6QdFsVLb6zTYcrvX/u9OILZbWvF+LmvCVu+hFBEEw7wrrfn9We4LDzMa
         co+ELk3+cES0Vc1SFNlNv0f19KEwrp057SyW6Duf1ryxx2VG13G65f2bFzpa2AnwhrBy
         ID86oQtMjZCk0+7UwaW4qg56SXfJUUJG2tF+nrp97uqwA0nlffk8cLRTrETbfLoTlXZe
         AntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786260528; x=1786865328;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CFsKeMVfxJH4s1PT8XPWbbRiwFRVNAEwOPJka6wI7cI=;
        b=Kw1dLZ9FuVUYBScuea67FhbcadAhAaK6I4OBiVavIkulU7T+XQ3yWc68lCTx6yb3yM
         3/rhvgbaLOwvy7g8t7xc5L7qgXffouOIUuZfvDLpNHpAFdl9hU9Ar6aDQuSxUis9Wq5C
         3GN72RCGJjX+SIQa4uK8dElbcEfnVTRfbC0FLRTRPt/Z+1qinUMkvZTg60n/gpRW2Fdb
         V1XVyDOlnVgU6YxDPNZtRPNpP2vDwxEMnrGhGeXQdZ0aaMRHcHc791vFneijLB1dQqTZ
         kyfC8aFQMJglKkN9xIoQ4aATu+GpPSIDWVtKLuSQnV/G7ZUyB02glKltSuc8QO9Xmor5
         kflw==
X-Forwarded-Encrypted: i=1; AHgh+RpvIaJx/P4Y49rnIB5BfoAXtHVv17UnQGQdVueXm9bH8ybtW1gsQktRexHnN8k0figb/A++VMSjVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ7LNCgNqt/H0WXKDcjZizHq5Puei+8vOeUHdo1wgHEaN2S5WD
	G1OJh3NoOiRy58HKX48jBh61vEM/5URubptaFhVxQ6WktixYwosqf/MGtaq/9ZWTL4SvV8EIZm5
	bCdfAYBobAh3wGeZLlTmcgGll5DxNMKl3uy+ED/7/ZCKaffd4wG4QUS2UpGEvjQ==
X-Gm-Gg: AR+sD11gWeYD1PqJWMSb22rsOA52lJZki6qP7DmQ6fAND8e1LZqdb8nsRiwN5arqjYo
	yh5ZGkoZB0zQC6zhs/62/Jbj+M+knrpYJDlQfL96m0sQaSaKWFH4jxfIgeER41tzuPhw5bFWifs
	aObRCvVDJJHkpunfI8yONYlnWMQ1xetwwvUFJZUQBAp/F9C+01+SKiy33s7fgLM6Fl2AAJmOPOb
	n9Ucvpn98V6043UMgAQw1y8fNQhuN3VzhR6wBahXG6DuekC0QVt5zLAvsihaHRDA4lBjPim9UCI
	PIn+MYMz97A69C5nqWyZmSk70L7iRo0LytinjVJLUAU+VlIi6e7ni7YFz/5S1k1YGgmOGyJDEzD
	tnqDYMc69SG7nUupvBLW+ZznX2mZ+tASXm/LXjuMZ07tvUzUTQnzs6vFzh4Mep7/GIgU32bskBh
	QJzyCHI9exnAE0nRp7fvNDwnE=
X-Received: by 2002:a05:6a20:6a0e:b0:3bf:9b61:f7ae with SMTP id adf61e73a8af0-3cbadb35cfbmr20225815637.14.1786260527985;
        Sun, 09 Aug 2026 00:28:47 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a0e:b0:3bf:9b61:f7ae with SMTP id adf61e73a8af0-3cbadb35cfbmr20225764637.14.1786260527334;
        Sun, 09 Aug 2026 00:28:47 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019b4eabsm22655630c88.6.2026.08.09.00.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 00:28:46 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 12:57:10 +0530
Subject: [PATCH 11/15] clk: qcom: Add Global Clock Controller driver for
 Kuno
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-kuno-soc-support-v1-11-5e0ede4a0c72@oss.qualcomm.com>
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
In-Reply-To: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786260433; l=42261;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=qBbpul6s9t2MbFs1zwamIHKG/8j9ePWvWCDaqei2M8g=;
 b=Kj/3rLvAOaPMQnRyKMka14k6E18pVPVGtBVNhoFyMN8daIp/jpq7f/rfONHl164slJRbPQuKl
 5VxXGcis1v7AVuCn12bp6Y7SEf/32/MHVJhByU2p2r+biFRyZvumUOP
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDA2MyBTYWx0ZWRfX4OjxS2/QUP26
 TlzNvrJp7BPAfRb7JBWlfocSjxDJRc6T1j9CatqIkd65DPe6vquz5GQ5k381g4+8VVZ/m8WEfT8
 XKxSYQkqkX2eLtgQp9p0Aia57kYj+6c=
X-Authority-Analysis: v=2.4 cv=HodG3UTS c=1 sm=1 tr=0 ts=6a782c31 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=ZgBb9yyxTKKX1Ld8kL8A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: n2QmXs8m0QF8qUmn_kavc7fe1t1I51lC
X-Proofpoint-GUID: n2QmXs8m0QF8qUmn_kavc7fe1t1I51lC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDA2MyBTYWx0ZWRfX8hirqRKOYfdI
 0i81y4JvdOuEhl/nzdrEEsMOHAmDe5saORcK71Iq3ej/4K4qxcezLxR8EVZiZCKsjC1Vxb3mbUb
 yiylScVIOs5jKxxnje4OGaXrLiyU7xnnjx1NHd3MFokViZcKgai4++SJCWcD4tljPazhIBbRgAx
 mJ0Q7FrrBOiRX1L3ichWCbNdDCxm1ygwIb5c1HrT0Zb5vCumCb8rWRYps1dSTvJ+e3YO9qY3kzF
 4ZuLn0Ol5i5frbfE0e9SGoMFtEvaDkEkSbn5AaVxNxV1e9gUoT4g6saTBIwByosK8UGOWoqZw5D
 jxTEl2PRHdB0lqDpueHPAUdaLpcOpU5Zrol082O30EPjCBBH5GWi73z5zdnPdfGaftnr9qEfT9c
 l587m1DOSLELd2fmEAM5C7dmD6V29O1vkrHohZz9a7vdZbAnHcHayhFkJKoyiiDS1plBctxaTnP
 Snor7zhM3Zl2v7R+RPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090063

Add the global clock controller (GCC) driver for the Qualcomm Kuno SoC,
providing the PLLs, root clock generators, gate/branch clocks and resets
used by the peripheral devices such as UART, SPI, I2C, USB, SD, PCIe and
Ethernet.

Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig    |   10 +
 drivers/clk/qcom/Makefile   |    1 +
 drivers/clk/qcom/gcc-kuno.c | 1438 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1449 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 63f271aff177..2ea6a56c46cf 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -181,6 +181,16 @@ config CLK_KAANAPALI_VIDEOCC
 	  Say Y if you want to support video devices and functionality such as
 	  video encode/decode.
 
+config CLK_KUNO_GCC
+	tristate "Kuno Global Clock Controller"
+	depends on ARM || COMPILE_TEST
+	default ARCH_QCOM
+	help
+	  Support for the global clock controller (GCC) on Kuno devices.
+	  Say Y if you want to use peripheral devices such as UART, SPI,
+	  I2C, USB, SD, PCIe and Ethernet on the Kuno SoC. This clock
+	  controller supplies the clocks and resets to those peripherals.
+
 config CLK_NORD_GCC
 	tristate "Nord Global Clock Controller"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index fff069da16de..78815e1f9c8c 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_CLK_KAANAPALI_GCC) += gcc-kaanapali.o
 obj-$(CONFIG_CLK_KAANAPALI_GPUCC) += gpucc-kaanapali.o gxclkctl-kaanapali.o
 obj-$(CONFIG_CLK_KAANAPALI_TCSRCC) += tcsrcc-kaanapali.o
 obj-$(CONFIG_CLK_KAANAPALI_VIDEOCC) += videocc-kaanapali.o
+obj-$(CONFIG_CLK_KUNO_GCC) += gcc-kuno.o
 obj-$(CONFIG_CLK_NORD_GCC) += gcc-nord.o negcc-nord.o nwgcc-nord.o segcc-nord.o
 obj-$(CONFIG_CLK_NORD_TCSRCC) += tcsrcc-nord.o
 obj-$(CONFIG_CLK_SHIKRA_GCC) += gcc-shikra.o
diff --git a/drivers/clk/qcom/gcc-kuno.c b/drivers/clk/qcom/gcc-kuno.c
new file mode 100644
index 000000000000..36f6bd4444ae
--- /dev/null
+++ b/drivers/clk/qcom/gcc-kuno.c
@@ -0,0 +1,1438 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,kuno-gcc.h>
+
+#include "clk-alpha-pll.h"
+#include "clk-branch.h"
+#include "clk-rcg.h"
+#include "clk-regmap.h"
+#include "clk-regmap-divider.h"
+#include "clk-regmap-mux.h"
+#include "clk-regmap-phy-mux.h"
+#include "common.h"
+#include "reset.h"
+
+/* Need to match the order of clocks in DT binding */
+enum {
+	DT_BI_TCXO,
+	DT_BI_TCXO_AO,
+	DT_SLEEP_CLK,
+	DT_PCIE_PIPE_CLK,
+};
+
+enum {
+	P_BI_TCXO,
+	P_GPLL0_OUT_EVEN,
+	P_GPLL0_OUT_MAIN,
+	P_GPLL2_OUT_MAIN,
+	P_GPLL3_OUT_MAIN,
+	P_GPLL4_OUT_EVEN,
+	P_GPLL4_OUT_MAIN,
+	P_SLEEP_CLK,
+};
+
+static struct clk_alpha_pll gpll0 = {
+	.offset = 0x0,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
+	.clkr = {
+		.enable_reg = 0x7d000,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gpll0",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fixed_lucid_evo_ops,
+		},
+	},
+};
+
+static const struct clk_div_table post_div_table_gpll0_out_even[] = {
+	{ 0x1, 2 },
+	{ }
+};
+
+static struct clk_alpha_pll_postdiv gpll0_out_even = {
+	.offset = 0x0,
+	.post_div_shift = 10,
+	.post_div_table = post_div_table_gpll0_out_even,
+	.num_post_div = ARRAY_SIZE(post_div_table_gpll0_out_even),
+	.width = 4,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gpll0_out_even",
+		.parent_hws = (const struct clk_hw*[]){
+			&gpll0.clkr.hw,
+		},
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_postdiv_lucid_evo_ops,
+	},
+};
+
+static struct clk_alpha_pll gpll2 = {
+	.offset = 0x2000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
+	.clkr = {
+		.enable_reg = 0x7d000,
+		.enable_mask = BIT(2),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gpll2",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fixed_lucid_evo_ops,
+		},
+	},
+};
+
+static struct clk_alpha_pll gpll3 = {
+	.offset = 0x3000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
+	.clkr = {
+		.enable_reg = 0x7d000,
+		.enable_mask = BIT(3),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gpll3",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fixed_lucid_evo_ops,
+		},
+	},
+};
+
+static struct clk_alpha_pll gpll4 = {
+	.offset = 0x4000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
+	.clkr = {
+		.enable_reg = 0x7d000,
+		.enable_mask = BIT(4),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gpll4",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fixed_lucid_evo_ops,
+		},
+	},
+};
+
+static const struct clk_div_table post_div_table_gpll4_out_even[] = {
+	{ 0x1, 2 },
+	{ }
+};
+
+static struct clk_alpha_pll_postdiv gpll4_out_even = {
+	.offset = 0x4000,
+	.post_div_shift = 10,
+	.post_div_table = post_div_table_gpll4_out_even,
+	.num_post_div = ARRAY_SIZE(post_div_table_gpll4_out_even),
+	.width = 4,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gpll4_out_even",
+		.parent_hws = (const struct clk_hw*[]){
+			&gpll4.clkr.hw,
+		},
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_postdiv_lucid_evo_ops,
+	},
+};
+
+static const struct parent_map gcc_parent_map_0[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GPLL0_OUT_MAIN, 1 },
+	{ P_GPLL4_OUT_EVEN, 2 },
+	{ P_GPLL0_OUT_EVEN, 6 },
+};
+
+static const struct clk_parent_data gcc_parent_data_0[] = {
+	{ .index = DT_BI_TCXO },
+	{ .hw = &gpll0.clkr.hw },
+	{ .hw = &gpll4_out_even.clkr.hw },
+	{ .hw = &gpll0_out_even.clkr.hw },
+};
+
+static const struct parent_map gcc_parent_map_1[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GPLL0_OUT_MAIN, 1 },
+	{ P_GPLL0_OUT_EVEN, 6 },
+};
+
+static const struct clk_parent_data gcc_parent_data_1[] = {
+	{ .index = DT_BI_TCXO },
+	{ .hw = &gpll0.clkr.hw },
+	{ .hw = &gpll0_out_even.clkr.hw },
+};
+
+static const struct parent_map gcc_parent_map_2[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GPLL0_OUT_MAIN, 1 },
+	{ P_GPLL4_OUT_EVEN, 2 },
+	{ P_SLEEP_CLK, 5 },
+	{ P_GPLL0_OUT_EVEN, 6 },
+};
+
+static const struct clk_parent_data gcc_parent_data_2[] = {
+	{ .index = DT_BI_TCXO },
+	{ .hw = &gpll0.clkr.hw },
+	{ .hw = &gpll4_out_even.clkr.hw },
+	{ .index = DT_SLEEP_CLK },
+	{ .hw = &gpll0_out_even.clkr.hw },
+};
+
+static const struct parent_map gcc_parent_map_3[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GPLL0_OUT_MAIN, 1 },
+	{ P_GPLL4_OUT_EVEN, 2 },
+	{ P_GPLL4_OUT_MAIN, 3 },
+	{ P_GPLL2_OUT_MAIN, 4 },
+	{ P_GPLL3_OUT_MAIN, 5 },
+	{ P_GPLL0_OUT_EVEN, 6 },
+};
+
+static const struct clk_parent_data gcc_parent_data_3[] = {
+	{ .index = DT_BI_TCXO },
+	{ .hw = &gpll0.clkr.hw },
+	{ .hw = &gpll4_out_even.clkr.hw },
+	{ .hw = &gpll4.clkr.hw },
+	{ .hw = &gpll2.clkr.hw },
+	{ .hw = &gpll3.clkr.hw },
+	{ .hw = &gpll0_out_even.clkr.hw },
+};
+
+static const struct parent_map gcc_parent_map_4[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_SLEEP_CLK, 5 },
+};
+
+static const struct clk_parent_data gcc_parent_data_4[] = {
+	{ .index = DT_BI_TCXO },
+	{ .index = DT_SLEEP_CLK },
+};
+
+static const struct parent_map gcc_parent_map_5[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GPLL0_OUT_MAIN, 1 },
+	{ P_SLEEP_CLK, 5 },
+};
+
+static const struct clk_parent_data gcc_parent_data_5[] = {
+	{ .index = DT_BI_TCXO },
+	{ .hw = &gpll0.clkr.hw },
+	{ .index = DT_SLEEP_CLK },
+};
+
+static const struct parent_map gcc_parent_map_6[] = {
+	{ P_BI_TCXO, 2 },
+};
+
+static struct clk_regmap_mux gcc_pcie_aux_clk_src = {
+	.reg = 0x5308c,
+	.shift = 0,
+	.width = 2,
+	.parent_map = gcc_parent_map_6,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_pcie_aux_clk_src",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_pcie_pipe_clk_src = {
+	.reg = 0x53070,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_pcie_pipe_clk_src",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_PCIE_PIPE_CLK,
+			},
+			.num_parents = 1,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static const struct freq_tbl ftbl_gcc_emac0_phy_aux_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_emac0_phy_aux_clk_src = {
+	.cmd_rcgr = 0x7102c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_5,
+	.freq_tbl = ftbl_gcc_emac0_phy_aux_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_emac0_phy_aux_clk_src",
+		.parent_data = gcc_parent_data_5,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_5),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gcc_emac0_ptp_clk_src[] = {
+	F(62500000, P_GPLL4_OUT_EVEN, 4, 0, 0),
+	F(75000000, P_GPLL0_OUT_EVEN, 4, 0, 0),
+	F(125000000, P_GPLL2_OUT_MAIN, 4, 0, 0),
+	F(230400000, P_GPLL3_OUT_MAIN, 3.5, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_emac0_ptp_clk_src = {
+	.cmd_rcgr = 0x71064,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_3,
+	.freq_tbl = ftbl_gcc_emac0_ptp_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_emac0_ptp_clk_src",
+		.parent_data = gcc_parent_data_3,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_3),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gcc_emac0_rgmii_clk_src[] = {
+	F(41666667, P_GPLL4_OUT_EVEN, 6, 0, 0),
+	F(50000000, P_GPLL0_OUT_EVEN, 6, 0, 0),
+	F(125000000, P_GPLL2_OUT_MAIN, 4, 0, 0),
+	F(250000000, P_GPLL2_OUT_MAIN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_emac0_rgmii_clk_src = {
+	.cmd_rcgr = 0x7104c,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_3,
+	.freq_tbl = ftbl_gcc_emac0_rgmii_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_emac0_rgmii_clk_src",
+		.parent_data = gcc_parent_data_3,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_3),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gcc_gp1_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(41666667, P_GPLL4_OUT_EVEN, 6, 0, 0),
+	F(50000000, P_GPLL0_OUT_EVEN, 6, 0, 0),
+	F(100000000, P_GPLL0_OUT_MAIN, 6, 0, 0),
+	F(200000000, P_GPLL0_OUT_MAIN, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_gp1_clk_src = {
+	.cmd_rcgr = 0x47004,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_2,
+	.freq_tbl = ftbl_gcc_gp1_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_gp1_clk_src",
+		.parent_data = gcc_parent_data_2,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 gcc_gp2_clk_src = {
+	.cmd_rcgr = 0x48004,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_2,
+	.freq_tbl = ftbl_gcc_gp1_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_gp2_clk_src",
+		.parent_data = gcc_parent_data_2,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 gcc_gp3_clk_src = {
+	.cmd_rcgr = 0x49004,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_2,
+	.freq_tbl = ftbl_gcc_gp1_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_gp3_clk_src",
+		.parent_data = gcc_parent_data_2,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 gcc_pcie_aux_phy_clk_src = {
+	.cmd_rcgr = 0x53074,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_4,
+	.freq_tbl = ftbl_gcc_emac0_phy_aux_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_pcie_aux_phy_clk_src",
+		.parent_data = gcc_parent_data_4,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gcc_pcie_rchng_phy_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(83333333, P_GPLL4_OUT_EVEN, 3, 0, 0),
+	F(100000000, P_GPLL0_OUT_EVEN, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_pcie_rchng_phy_clk_src = {
+	.cmd_rcgr = 0x53038,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_2,
+	.freq_tbl = ftbl_gcc_pcie_rchng_phy_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_pcie_rchng_phy_clk_src",
+		.parent_data = gcc_parent_data_2,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gcc_pdm2_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(60000000, P_GPLL0_OUT_MAIN, 10, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_pdm2_clk_src = {
+	.cmd_rcgr = 0x34010,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_1,
+	.freq_tbl = ftbl_gcc_pdm2_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_pdm2_clk_src",
+		.parent_data = gcc_parent_data_1,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
+	F(7372800, P_GPLL0_OUT_EVEN, 1, 384, 15625),
+	F(14745600, P_GPLL0_OUT_EVEN, 1, 768, 15625),
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(29491200, P_GPLL0_OUT_EVEN, 1, 1536, 15625),
+	F(32000000, P_GPLL0_OUT_EVEN, 1, 8, 75),
+	F(48000000, P_GPLL0_OUT_EVEN, 1, 4, 25),
+	F(62500000, P_GPLL4_OUT_EVEN, 4, 0, 0),
+	F(64000000, P_GPLL0_OUT_EVEN, 1, 16, 75),
+	F(75000000, P_GPLL0_OUT_EVEN, 4, 0, 0),
+	F(80000000, P_GPLL0_OUT_EVEN, 1, 4, 15),
+	F(96000000, P_GPLL0_OUT_EVEN, 1, 8, 25),
+	F(100000000, P_GPLL0_OUT_MAIN, 6, 0, 0),
+	{ }
+};
+
+static struct clk_init_data gcc_qupv3_wrap0_s0_clk_src_init = {
+	.name = "gcc_qupv3_wrap0_s0_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.ops = &clk_rcg2_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap0_s0_clk_src = {
+	.cmd_rcgr = 0x6c004,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap0_s0_clk_src_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap0_s1_clk_src_init = {
+	.name = "gcc_qupv3_wrap0_s1_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.ops = &clk_rcg2_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap0_s1_clk_src = {
+	.cmd_rcgr = 0x6c13c,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap0_s1_clk_src_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap0_s2_clk_src_init = {
+	.name = "gcc_qupv3_wrap0_s2_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.ops = &clk_rcg2_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap0_s2_clk_src = {
+	.cmd_rcgr = 0x6c274,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap0_s2_clk_src_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap0_s3_clk_src_init = {
+	.name = "gcc_qupv3_wrap0_s3_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.ops = &clk_rcg2_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap0_s3_clk_src = {
+	.cmd_rcgr = 0x6c3ac,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap0_s3_clk_src_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap0_s4_clk_src_init = {
+	.name = "gcc_qupv3_wrap0_s4_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.ops = &clk_rcg2_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap0_s4_clk_src = {
+	.cmd_rcgr = 0x6c4e4,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap0_s4_clk_src_init,
+};
+
+static const struct freq_tbl ftbl_gcc_sdcc4_apps_clk_src[] = {
+	F(400000, P_BI_TCXO, 12, 1, 4),
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(25000000, P_GPLL0_OUT_EVEN, 12, 1, 1),
+	F(50000000, P_GPLL0_OUT_EVEN, 6, 0, 0),
+	F(83333333, P_GPLL4_OUT_EVEN, 3, 0, 0),
+	F(100000000, P_GPLL0_OUT_EVEN, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_sdcc4_apps_clk_src = {
+	.cmd_rcgr = 0x6a01c,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_sdcc4_apps_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_sdcc4_apps_clk_src",
+		.parent_data = gcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gcc_usb20_master_clk_src[] = {
+	F(50000000, P_GPLL4_OUT_EVEN, 5, 0, 0),
+	F(60000000, P_GPLL0_OUT_EVEN, 5, 0, 0),
+	F(120000000, P_GPLL0_OUT_MAIN, 5, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_usb20_master_clk_src = {
+	.cmd_rcgr = 0x27048,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_usb20_master_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_usb20_master_clk_src",
+		.parent_data = gcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 gcc_usb20_mock_utmi_clk_src = {
+	.cmd_rcgr = 0x2702c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_1,
+	.freq_tbl = ftbl_gcc_emac0_phy_aux_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "gcc_usb20_mock_utmi_clk_src",
+		.parent_data = gcc_parent_data_1,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_regmap_div gcc_usb20_mock_utmi_postdiv_clk_src = {
+	.reg = 0x27044,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_usb20_mock_utmi_postdiv_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&gcc_usb20_mock_utmi_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_branch gcc_boot_rom_ahb_clk = {
+	.halt_reg = 0x37004,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x37004,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x7d008,
+		.enable_mask = BIT(26),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_boot_rom_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_emac0_axi_clk = {
+	.halt_reg = 0x71018,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x71018,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x71018,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_emac0_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_emac0_phy_aux_clk = {
+	.halt_reg = 0x71028,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x71028,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_emac0_phy_aux_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_emac0_phy_aux_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_emac0_ptp_clk = {
+	.halt_reg = 0x71044,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x71044,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_emac0_ptp_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_emac0_ptp_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_emac0_rgmii_clk = {
+	.halt_reg = 0x71048,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x71048,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_emac0_rgmii_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_emac0_rgmii_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_emac0_slv_ahb_clk = {
+	.halt_reg = 0x71024,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x71024,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x71024,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_emac0_slv_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_emac_0_clkref_en = {
+	.halt_reg = 0x94004,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x94004,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_emac_0_clkref_en",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_gp1_clk = {
+	.halt_reg = 0x47000,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x47000,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_gp1_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_gp1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_gp2_clk = {
+	.halt_reg = 0x48000,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x48000,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_gp2_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_gp2_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_gp3_clk = {
+	.halt_reg = 0x49000,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x49000,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_gp3_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_gp3_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie_0_clkref_en = {
+	.halt_reg = 0x94000,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x94000,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_pcie_0_clkref_en",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie_aux_clk = {
+	.halt_reg = 0x53054,
+	.halt_check = BRANCH_HALT_DELAY,
+	.hwcg_reg = 0x53054,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x7d010,
+		.enable_mask = BIT(15),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_pcie_aux_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_pcie_aux_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie_cfg_ahb_clk = {
+	.halt_reg = 0x53034,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x53034,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x7d010,
+		.enable_mask = BIT(13),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_pcie_cfg_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie_mstr_axi_clk = {
+	.halt_reg = 0x53028,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x53028,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x7d010,
+		.enable_mask = BIT(12),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_pcie_mstr_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie_pipe_clk = {
+	.halt_reg = 0x53064,
+	.halt_check = BRANCH_HALT_DELAY,
+	.hwcg_reg = 0x53064,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x7d010,
+		.enable_mask = BIT(17),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_pcie_pipe_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_pcie_pipe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie_rchng_phy_clk = {
+	.halt_reg = 0x53050,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x53050,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x7d010,
+		.enable_mask = BIT(14),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_pcie_rchng_phy_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_pcie_rchng_phy_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie_sleep_clk = {
+	.halt_reg = 0x53060,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x53060,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x7d010,
+		.enable_mask = BIT(16),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_pcie_sleep_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_pcie_aux_phy_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie_slv_axi_clk = {
+	.halt_reg = 0x5301c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x7d010,
+		.enable_mask = BIT(11),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_pcie_slv_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie_slv_q2a_axi_clk = {
+	.halt_reg = 0x53018,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x53018,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x7d010,
+		.enable_mask = BIT(10),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_pcie_slv_q2a_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pdm2_clk = {
+	.halt_reg = 0x3400c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3400c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_pdm2_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_pdm2_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pdm_ahb_clk = {
+	.halt_reg = 0x34004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x34004,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_pdm_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pdm_xo4_clk = {
+	.halt_reg = 0x34008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x34008,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_pdm_xo4_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap0_core_2x_clk = {
+	.halt_reg = 0x2d018,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x7d008,
+		.enable_mask = BIT(15),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap0_core_2x_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap0_core_clk = {
+	.halt_reg = 0x2d008,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x7d008,
+		.enable_mask = BIT(14),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap0_core_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap0_s0_clk = {
+	.halt_reg = 0x6c130,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x7d008,
+		.enable_mask = BIT(16),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap0_s0_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_qupv3_wrap0_s0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap0_s1_clk = {
+	.halt_reg = 0x6c268,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x7d008,
+		.enable_mask = BIT(17),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap0_s1_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_qupv3_wrap0_s1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap0_s2_clk = {
+	.halt_reg = 0x6c3a0,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x7d008,
+		.enable_mask = BIT(18),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap0_s2_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_qupv3_wrap0_s2_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap0_s3_clk = {
+	.halt_reg = 0x6c4d8,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x7d008,
+		.enable_mask = BIT(19),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap0_s3_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_qupv3_wrap0_s3_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap0_s4_clk = {
+	.halt_reg = 0x6c610,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x7d008,
+		.enable_mask = BIT(20),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap0_s4_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_qupv3_wrap0_s4_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap_0_m_ahb_clk = {
+	.halt_reg = 0x2d000,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x2d000,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x7d008,
+		.enable_mask = BIT(12),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap_0_m_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap_0_s_ahb_clk = {
+	.halt_reg = 0x2d004,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x2d004,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x7d008,
+		.enable_mask = BIT(13),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_qupv3_wrap_0_s_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_sdcc4_ahb_clk = {
+	.halt_reg = 0x6a010,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x6a010,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_sdcc4_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_sdcc4_apps_clk = {
+	.halt_reg = 0x6a004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x6a004,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_sdcc4_apps_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_sdcc4_apps_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_snoc_cnoc_usb3_clk = {
+	.halt_reg = 0x27060,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x27060,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x27060,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_snoc_cnoc_usb3_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_usb20_master_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_sys_noc_usb_sf_axi_clk = {
+	.halt_reg = 0x27064,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x27064,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x27064,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_sys_noc_usb_sf_axi_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_usb20_master_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb20_master_clk = {
+	.halt_reg = 0x27018,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x27018,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_usb20_master_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_usb20_master_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb20_mock_utmi_clk = {
+	.halt_reg = 0x27028,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x27028,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_usb20_mock_utmi_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_usb20_mock_utmi_postdiv_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb20_sleep_clk = {
+	.halt_reg = 0x27024,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x27024,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_usb20_sleep_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb2_clkref_en = {
+	.halt_reg = 0x94008,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x94008,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_usb2_clkref_en",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb3_prim_clkref_en = {
+	.halt_reg = 0x9400c,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x9400c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_usb3_prim_clkref_en",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb_phy_cfg_ahb2phy_clk = {
+	.halt_reg = 0x29004,
+	.halt_check = BRANCH_HALT,
+	.hwcg_reg = 0x29004,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x29004,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "gcc_usb_phy_cfg_ahb2phy_clk",
+			.ops = &clk_branch2_aon_ops,
+		},
+	},
+};
+
+static struct clk_regmap *gcc_kuno_clocks[] = {
+	[GCC_BOOT_ROM_AHB_CLK] = &gcc_boot_rom_ahb_clk.clkr,
+	[GCC_EMAC0_AXI_CLK] = &gcc_emac0_axi_clk.clkr,
+	[GCC_EMAC0_PHY_AUX_CLK] = &gcc_emac0_phy_aux_clk.clkr,
+	[GCC_EMAC0_PHY_AUX_CLK_SRC] = &gcc_emac0_phy_aux_clk_src.clkr,
+	[GCC_EMAC0_PTP_CLK] = &gcc_emac0_ptp_clk.clkr,
+	[GCC_EMAC0_PTP_CLK_SRC] = &gcc_emac0_ptp_clk_src.clkr,
+	[GCC_EMAC0_RGMII_CLK] = &gcc_emac0_rgmii_clk.clkr,
+	[GCC_EMAC0_RGMII_CLK_SRC] = &gcc_emac0_rgmii_clk_src.clkr,
+	[GCC_EMAC0_SLV_AHB_CLK] = &gcc_emac0_slv_ahb_clk.clkr,
+	[GCC_EMAC_0_CLKREF_EN] = &gcc_emac_0_clkref_en.clkr,
+	[GCC_GP1_CLK] = &gcc_gp1_clk.clkr,
+	[GCC_GP1_CLK_SRC] = &gcc_gp1_clk_src.clkr,
+	[GCC_GP2_CLK] = &gcc_gp2_clk.clkr,
+	[GCC_GP2_CLK_SRC] = &gcc_gp2_clk_src.clkr,
+	[GCC_GP3_CLK] = &gcc_gp3_clk.clkr,
+	[GCC_GP3_CLK_SRC] = &gcc_gp3_clk_src.clkr,
+	[GCC_PCIE_0_CLKREF_EN] = &gcc_pcie_0_clkref_en.clkr,
+	[GCC_PCIE_AUX_CLK] = &gcc_pcie_aux_clk.clkr,
+	[GCC_PCIE_AUX_CLK_SRC] = &gcc_pcie_aux_clk_src.clkr,
+	[GCC_PCIE_AUX_PHY_CLK_SRC] = &gcc_pcie_aux_phy_clk_src.clkr,
+	[GCC_PCIE_CFG_AHB_CLK] = &gcc_pcie_cfg_ahb_clk.clkr,
+	[GCC_PCIE_MSTR_AXI_CLK] = &gcc_pcie_mstr_axi_clk.clkr,
+	[GCC_PCIE_PIPE_CLK] = &gcc_pcie_pipe_clk.clkr,
+	[GCC_PCIE_PIPE_CLK_SRC] = &gcc_pcie_pipe_clk_src.clkr,
+	[GCC_PCIE_RCHNG_PHY_CLK] = &gcc_pcie_rchng_phy_clk.clkr,
+	[GCC_PCIE_RCHNG_PHY_CLK_SRC] = &gcc_pcie_rchng_phy_clk_src.clkr,
+	[GCC_PCIE_SLEEP_CLK] = &gcc_pcie_sleep_clk.clkr,
+	[GCC_PCIE_SLV_AXI_CLK] = &gcc_pcie_slv_axi_clk.clkr,
+	[GCC_PCIE_SLV_Q2A_AXI_CLK] = &gcc_pcie_slv_q2a_axi_clk.clkr,
+	[GCC_PDM2_CLK] = &gcc_pdm2_clk.clkr,
+	[GCC_PDM2_CLK_SRC] = &gcc_pdm2_clk_src.clkr,
+	[GCC_PDM_AHB_CLK] = &gcc_pdm_ahb_clk.clkr,
+	[GCC_PDM_XO4_CLK] = &gcc_pdm_xo4_clk.clkr,
+	[GCC_QUPV3_WRAP0_CORE_2X_CLK] = &gcc_qupv3_wrap0_core_2x_clk.clkr,
+	[GCC_QUPV3_WRAP0_CORE_CLK] = &gcc_qupv3_wrap0_core_clk.clkr,
+	[GCC_QUPV3_WRAP0_S0_CLK] = &gcc_qupv3_wrap0_s0_clk.clkr,
+	[GCC_QUPV3_WRAP0_S0_CLK_SRC] = &gcc_qupv3_wrap0_s0_clk_src.clkr,
+	[GCC_QUPV3_WRAP0_S1_CLK] = &gcc_qupv3_wrap0_s1_clk.clkr,
+	[GCC_QUPV3_WRAP0_S1_CLK_SRC] = &gcc_qupv3_wrap0_s1_clk_src.clkr,
+	[GCC_QUPV3_WRAP0_S2_CLK] = &gcc_qupv3_wrap0_s2_clk.clkr,
+	[GCC_QUPV3_WRAP0_S2_CLK_SRC] = &gcc_qupv3_wrap0_s2_clk_src.clkr,
+	[GCC_QUPV3_WRAP0_S3_CLK] = &gcc_qupv3_wrap0_s3_clk.clkr,
+	[GCC_QUPV3_WRAP0_S3_CLK_SRC] = &gcc_qupv3_wrap0_s3_clk_src.clkr,
+	[GCC_QUPV3_WRAP0_S4_CLK] = &gcc_qupv3_wrap0_s4_clk.clkr,
+	[GCC_QUPV3_WRAP0_S4_CLK_SRC] = &gcc_qupv3_wrap0_s4_clk_src.clkr,
+	[GCC_QUPV3_WRAP_0_M_AHB_CLK] = &gcc_qupv3_wrap_0_m_ahb_clk.clkr,
+	[GCC_QUPV3_WRAP_0_S_AHB_CLK] = &gcc_qupv3_wrap_0_s_ahb_clk.clkr,
+	[GCC_SDCC4_AHB_CLK] = &gcc_sdcc4_ahb_clk.clkr,
+	[GCC_SDCC4_APPS_CLK] = &gcc_sdcc4_apps_clk.clkr,
+	[GCC_SDCC4_APPS_CLK_SRC] = &gcc_sdcc4_apps_clk_src.clkr,
+	[GCC_SNOC_CNOC_USB3_CLK] = &gcc_snoc_cnoc_usb3_clk.clkr,
+	[GCC_SYS_NOC_USB_SF_AXI_CLK] = &gcc_sys_noc_usb_sf_axi_clk.clkr,
+	[GCC_USB20_MASTER_CLK] = &gcc_usb20_master_clk.clkr,
+	[GCC_USB20_MASTER_CLK_SRC] = &gcc_usb20_master_clk_src.clkr,
+	[GCC_USB20_MOCK_UTMI_CLK] = &gcc_usb20_mock_utmi_clk.clkr,
+	[GCC_USB20_MOCK_UTMI_CLK_SRC] = &gcc_usb20_mock_utmi_clk_src.clkr,
+	[GCC_USB20_MOCK_UTMI_POSTDIV_CLK_SRC] = &gcc_usb20_mock_utmi_postdiv_clk_src.clkr,
+	[GCC_USB20_SLEEP_CLK] = &gcc_usb20_sleep_clk.clkr,
+	[GCC_USB2_CLKREF_EN] = &gcc_usb2_clkref_en.clkr,
+	[GCC_USB3_PRIM_CLKREF_EN] = &gcc_usb3_prim_clkref_en.clkr,
+	[GCC_USB_PHY_CFG_AHB2PHY_CLK] = &gcc_usb_phy_cfg_ahb2phy_clk.clkr,
+	[GPLL0] = &gpll0.clkr,
+	[GPLL0_OUT_EVEN] = &gpll0_out_even.clkr,
+	[GPLL2] = &gpll2.clkr,
+	[GPLL3] = &gpll3.clkr,
+	[GPLL4] = &gpll4.clkr,
+	[GPLL4_OUT_EVEN] = &gpll4_out_even.clkr,
+};
+
+static const struct qcom_reset_map gcc_kuno_resets[] = {
+	[GCC_EMAC0_BCR] = { 0x71000 },
+	[GCC_PCIE_BCR] = { 0x53000 },
+	[GCC_PCIE_LINK_DOWN_BCR] = { 0x87000 },
+	[GCC_PCIE_NOCSR_COM_PHY_BCR] = { 0x88008 },
+	[GCC_PCIE_PHY_BCR] = { 0x54000 },
+	[GCC_PCIE_PHY_CFG_AHB_BCR] = { 0x88000 },
+	[GCC_PCIE_PHY_COM_BCR] = { 0x88004 },
+	[GCC_PCIE_PHY_NOCSR_COM_PHY_BCR] = { 0x8800c },
+	[GCC_PDM_BCR] = { 0x34000 },
+	[GCC_QUPV3_WRAPPER_0_BCR] = { 0x6c000 },
+	[GCC_QUSB2PHY_BCR] = { 0x2a000 },
+	[GCC_SDCC4_BCR] = { 0x6a000 },
+	[GCC_TCSR_PCIE_BCR] = { 0x84000 },
+	[GCC_USB20_BCR] = { 0x27000 },
+	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x29000 },
+};
+
+static const struct clk_rcg_dfs_data gcc_dfs_clocks[] = {
+	DEFINE_RCG_DFS(gcc_qupv3_wrap0_s0_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap0_s1_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap0_s2_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap0_s3_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap0_s4_clk_src),
+};
+
+static const struct regmap_config gcc_kuno_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x1f41f0,
+	.fast_io = true,
+};
+
+static const u32 gcc_kuno_critical_cbcrs[] = {
+	0x3e004, /* GCC_AHB_PCIE_LINK_CLK */
+	0x3e008, /* GCC_XO_PCIE_LINK_CLK */
+};
+
+static const struct qcom_cc_driver_data gcc_kuno_driver_data = {
+	.dfs_rcgs = gcc_dfs_clocks,
+	.num_dfs_rcgs = ARRAY_SIZE(gcc_dfs_clocks),
+	.clk_cbcrs = gcc_kuno_critical_cbcrs,
+	.num_clk_cbcrs = ARRAY_SIZE(gcc_kuno_critical_cbcrs),
+};
+
+static const struct qcom_cc_desc gcc_kuno_desc = {
+	.config = &gcc_kuno_regmap_config,
+	.clks = gcc_kuno_clocks,
+	.num_clks = ARRAY_SIZE(gcc_kuno_clocks),
+	.resets = gcc_kuno_resets,
+	.num_resets = ARRAY_SIZE(gcc_kuno_resets),
+	.use_rpm = true,
+	.driver_data = &gcc_kuno_driver_data,
+};
+
+static const struct of_device_id gcc_kuno_match_table[] = {
+	{ .compatible = "qcom,kuno-gcc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, gcc_kuno_match_table);
+
+static int gcc_kuno_probe(struct platform_device *pdev)
+{
+	return qcom_cc_probe(pdev, &gcc_kuno_desc);
+}
+
+static struct platform_driver gcc_kuno_driver = {
+	.probe = gcc_kuno_probe,
+	.driver = {
+		.name = "gcc-kuno",
+		.of_match_table = gcc_kuno_match_table,
+	},
+};
+
+static int __init gcc_kuno_init(void)
+{
+	return platform_driver_register(&gcc_kuno_driver);
+}
+subsys_initcall(gcc_kuno_init);
+
+static void __exit gcc_kuno_exit(void)
+{
+	platform_driver_unregister(&gcc_kuno_driver);
+}
+module_exit(gcc_kuno_exit);
+
+MODULE_DESCRIPTION("QTI GCC Kuno Driver");
+MODULE_LICENSE("GPL");

-- 
2.43.0

