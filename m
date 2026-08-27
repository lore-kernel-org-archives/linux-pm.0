Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210444B0481
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853178; cv=none; b=r07tnayOGrpGfuXnPzE8ujHpAVI5rSs5ESf7wSfEriiLQt3tCGRxmUzit3kRy7xNq48i8WIjWZWl/jVBF6Llb/LLfOssTlWHcOxSwu6bdYiUtwIyuKbV3gmLA1xMqZ1r0mOp5kNfCq2tBcwuGNFUWd/0b8RdykajmeFDC8dPcyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853178; c=relaxed/simple;
	bh=4eneYjBTVm+QEs/DxK6sZdWcClFJMkkU9VCnVA/UjpM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q8kmN6zuHZ6GwnMG0KQioYCuMdsAqkju3s4ECtWF1nAEo5CCOTAw7IA5eNzQ6b8CZglJC7khTABDMBEo1ZQ/M7pCnWd583b0LV+PhqZHZOMVcj73g4f3Fmsh+jkrrRXZ7vhwdV0tzsJL1ujL2VAzxObP6K7Nf48zOmYsKuCY6fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EFCMsZ2b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K+645zkh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EFCMsZ2b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K+645zkh"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RHXvBs420129
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3BO6biX+wO4cDKtamvRB+gzh5ADD+Pa1K96ORZNYTF0=; b=EFCMsZ2bBH+aUwVE
	jFTrTwsak0XIpJRIElNXhoyEumLeIrhbDtbe3nzEPISCfjzbdXG8SG0mRYUFGoLy
	D8uwVg7PsK5nGGEQH8r4mCDrPpc+nK2/+I5y/xkt6aM8mQt/DKQLnLfz3ESJv/UX
	ggnzqHjPDgcVIakR478KbBgSzP0xbZCg0J9FxAIwSVY58Lv3DtSW1k6Cs5MS1kGj
	AV8Xa5nF65bnE9N9XDQ7MakSjMDtqoqGVruxL/N3JMwmdnCc2hlpex1oVTipUTqZ
	5zZBtsfCo5w34ZdehwY/qkBuat+bebpCwLgiBC2YZKvg85b4DHrUOITgx6cRWtSc
	SVL62A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gagjftmsd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:52:52 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d7293f13c6so1067225ad.2
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 10:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787853172; x=1788457972; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3BO6biX+wO4cDKtamvRB+gzh5ADD+Pa1K96ORZNYTF0=;
        b=K+645zkhk88Gc29Q+WCBzcOG/KzZRjrgk9a5bsPiN7p4C3yS3gsnzCWEn6p4Y6WYFF
         Ry+gNm+JALr4gfIUY/HIi0J0ONdwYjcLuh8ZoJLkBxgKkItt2KsJEBrzYjlyFHGXRfHw
         W/zOMdowQwPa1SVWz3hh6rP1eRTMcSSRG7tzMHzxtEYNgvf2GuHlpQXKour6rNKB/Aap
         DRl7DhaSi7lTKUIppzJ4nEArkn3XKB40sUSm6rGPeP5bSUiPjztWLtNxTV3YYZ1rm1Cw
         Hds/GM+lH5NZgYJ0/GMDm0oX4+h6CZo/mJ+JX6Eykc+qjT7jnxMN4jJVh34VeKkvPyIm
         e+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853172; x=1788457972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3BO6biX+wO4cDKtamvRB+gzh5ADD+Pa1K96ORZNYTF0=;
        b=bUHUMKK/j6vk/0OZoz31P+AMgMQjRn3Lvs16kkjK6tYy34ItAUGR1T+YR+LrbFKD+/
         HcQlLuR8kW6AOI2p5gsyQL7QfvHmEofXuddASiLmyNxL0wPkafVDaAdavgo1B498DVr5
         BqkBVcKMUWOA62rRGR1roZVdXolBakeq4cYvJXvpzcbidTIR70P7URC21M5uKHZCtYGX
         48kvl+MT5js0K7yx7B+qh54KtU0a8IhDFYxDRUPA8fcaZ5plNLNVgkds39Xdo1n7VqnC
         LM8XvxmqCJLF2eijr5nUwSPWVoaJv1cTN28IUV8Su3ZBBzuTrVbcaprao9jsaddCrzKp
         i4ag==
X-Forwarded-Encrypted: i=1; AHgh+RoHm5Mnx8f0o5CEWoB4NX91JAPtimPWcG9wdycrLHglMqK8rllpKkt1MmJINvii+8Y5h9G7j72JNg==@vger.kernel.org
X-Gm-Message-State: AFuF++lQEy8cx1ASSuaBWU6AyW/bGH4ZAfT7a84o9roQgTZv8JKLlvSc
	X0rD/hYzPFRxRt+O8h7fpm/vypPTjuzj5rW4+qI/+gt19AzOamNdIjIJz9R9UU3szxZoCMsZYJG
	RgfA38FLLWDufnz6URA9Xiv6Tq/17ghaFbRf1sUsx5kDFuuAbs0nMm3D10+MvGg==
X-Gm-Gg: AR+sD10A1r1sNlF3HufILQLvizNFsp7ZJ7ZZ2n0B+ibmuvAeZWVio56sAAs6fgLxbxA
	FJA6Qny2tqfYm79UZJmAD8UNtXm+ADWAdHNH+BSd6O9o2eeXwAjhjNtdEv+3esuO+m5m+yL4SYP
	/9ghFM01/dEcG+WK2OcmZjIWInVvD8VvWnIlf8/zVXulm1tAyOqyvtJG1nrCpad3e8D1zxlfI2w
	RpF/B9PJcppd96mx+7t47bx/Mj8Zp2lnmOZtakgDghn6OWMl9x+h9rIE+WvV/PGX9m1hL9Mlca0
	XyEYUxtDzPNGun9Tm6hj7yanu0qhkLVnU1hRSzjT5cQaWtsM96tu968rVS65qovC3YRdyD+RdGx
	2P3NYhbHNdM/w290+fqzH0sZpDr231vixi/JvQU0OC6z5BKckmEn3svfqZfGSZFhZBBcuaC4Yh/
	3/ue16JVnyn1vCDOMpqVXhVH4=
X-Received: by 2002:a17:902:e552:b0:2cf:8131:75e8 with SMTP id d9443c01a7336-2d74df5b062mr8048835ad.13.1787853171487;
        Thu, 27 Aug 2026 10:52:51 -0700 (PDT)
X-Received: by 2002:a17:902:e552:b0:2cf:8131:75e8 with SMTP id d9443c01a7336-2d74df5b062mr8047895ad.13.1787853170690;
        Thu, 27 Aug 2026 10:52:50 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60d25esm23889316eec.4.2026.08.27.10.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:52:49 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 23:21:14 +0530
Subject: [PATCH v5 11/15] clk: qcom: Add Global Clock Controller driver for
 Kuno
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-kuno-soc-support-v5-11-6d47636a8f09@oss.qualcomm.com>
References: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
In-Reply-To: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787853069; l=43539;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=4eneYjBTVm+QEs/DxK6sZdWcClFJMkkU9VCnVA/UjpM=;
 b=RDJxpS2AB9lnxh2p55tHJ9GMmqrGoOZ5VViOu0PpH/x2/xQSoaGPG8YlpJmw9ZVpyAIMRsZOH
 VaVKa7dhHUTArzwSvCqwL6npPGjBTEGofRUT0O0GxCEJ74IA9AsARyj
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-ORIG-GUID: K1PQ-NFo5naCWCtjF0CFqHoYAvZOxzPH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX95yPOLSfTzpI
 xPdpHXwizH0QklTxysWxXUngN+cZVX5DXYnOo5Qrt7+gJgAjzDANQ0KSilP59qdnye6cqugbXeV
 xV6IgFbSYCguSfuZLMZMvxy+ObaJW+qT8uqJC+WLFwLG2nJPBkqiRYA6Z+OdD4aANXBQpzhTH2p
 /Wubcw+8T6guBj0wxZMdqqYKNKFElgo9KT/gRa0X1EJBI1MxgXo56upFfuiZ7ahFj+rLKz5T0Lh
 +xim+fgb7pZtGCOSlR3iULHe6G8Io1mp9UiIpaSVO9WPMkm5jkJxtwRWlb9stFVh/0QA7tahimZ
 Zn23j2kvYLQq493WJ85CBPsh/6ek9q8ZZIiPvdEytHHefIeNwZDzKvzO+yCRcHqJAeRPYEq9Fm6
 VtUiz4/QMjDXUvY6caBdq+W6OaQ/X2YiuevpEQfZoJl2cpmvLyxcbtDiEtpNc4PRYgLUY6XyVtZ
 aPobHWckPkNpai5uEyg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfXwWoWZxuieF8j
 6kVLtP7/aN5C8tlpBsh5Y7Hr9YvKzHZz3QyZjJNp/dbxEKrk5N3+qeq/F/DkUqg/pa+Cny5wpWe
 OKXc0DMwKIQLdx3r+ABl7D2rOLQ7NCI=
X-Proofpoint-GUID: K1PQ-NFo5naCWCtjF0CFqHoYAvZOxzPH
X-Authority-Analysis: v=2.4 cv=dd+wG3Xe c=1 sm=1 tr=0 ts=6a907975 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=er59LzwYcjVnkq2hIHsA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270151

Add the global clock controller (GCC) driver for the Qualcomm Kuno SoC,
providing the PLLs, root clock generators, gate/branch clocks and resets
used by the peripheral devices such as UART, SPI, I2C, USB, SD, PCIe and
Ethernet.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig    |   11 +
 drivers/clk/qcom/Makefile   |    1 +
 drivers/clk/qcom/gcc-kuno.c | 1483 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1495 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index e609a7819e07..5da0f90a9f4e 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -212,6 +212,17 @@ config CLK_KAANAPALI_VIDEOCC
 	  Say Y if you want to support video devices and functionality such as
 	  video encode/decode.
 
+config CLK_KUNO_GCC
+	tristate "Kuno Global Clock Controller"
+	depends on ARM || COMPILE_TEST
+	select QCOM_GDSC
+	default ARCH_QCOM
+	help
+	  Support for the global clock controller (GCC) on Kuno devices.
+	  Say Y if you want to use peripheral devices such as UART, SPI,
+	  I2C, USB, SD, PCIe and Ethernet on the Kuno SoC. This clock
+	  controller supplies the clocks and resets to those peripherals.
+
 config CLK_NORD_DISPCC
 	tristate "Nord Display Clock Controller"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index b8590963736a..67f74898a582 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_CLK_KAANAPALI_GCC) += gcc-kaanapali.o
 obj-$(CONFIG_CLK_KAANAPALI_GPUCC) += gpucc-kaanapali.o gxclkctl-kaanapali.o
 obj-$(CONFIG_CLK_KAANAPALI_TCSRCC) += tcsrcc-kaanapali.o
 obj-$(CONFIG_CLK_KAANAPALI_VIDEOCC) += videocc-kaanapali.o
+obj-$(CONFIG_CLK_KUNO_GCC) += gcc-kuno.o
 obj-$(CONFIG_CLK_MAILI_VIDEOCC) += videocc-maili.o
 obj-$(CONFIG_CLK_NORD_DISPCC) += dispcc0-nord.o dispcc1-nord.o
 obj-$(CONFIG_CLK_NORD_GCC) += gcc-nord.o negcc-nord.o nwgcc-nord.o segcc-nord.o
diff --git a/drivers/clk/qcom/gcc-kuno.c b/drivers/clk/qcom/gcc-kuno.c
new file mode 100644
index 000000000000..787111397df9
--- /dev/null
+++ b/drivers/clk/qcom/gcc-kuno.c
@@ -0,0 +1,1483 @@
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
+#include "gdsc.h"
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
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gpll0",
+			.parent_data = &(const struct clk_parent_data) {
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
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gpll0_out_even",
+		.parent_hws = (const struct clk_hw*[]) {
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
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gpll2",
+			.parent_data = &(const struct clk_parent_data) {
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
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gpll3",
+			.parent_data = &(const struct clk_parent_data) {
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
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gpll4",
+			.parent_data = &(const struct clk_parent_data) {
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
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gpll4_out_even",
+		.parent_hws = (const struct clk_hw*[]) {
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
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_pcie_aux_clk_src",
+			.parent_data = &(const struct clk_parent_data) {
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
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_pcie_pipe_clk_src",
+			.parent_data = &(const struct clk_parent_data) {
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
+	.clkr.hw.init = &(const struct clk_init_data) {
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
+	.clkr.hw.init = &(const struct clk_init_data) {
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
+	.clkr.hw.init = &(const struct clk_init_data) {
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
+	.clkr.hw.init = &(const struct clk_init_data) {
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
+	.clkr.hw.init = &(const struct clk_init_data) {
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
+	.clkr.hw.init = &(const struct clk_init_data) {
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
+	.clkr.hw.init = &(const struct clk_init_data) {
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
+	.clkr.hw.init = &(const struct clk_init_data) {
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
+	.clkr.hw.init = &(const struct clk_init_data) {
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
+	.clkr.hw.init = &(const struct clk_init_data) {
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
+	.clkr.hw.init = &(const struct clk_init_data) {
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
+	.clkr.hw.init = &(const struct clk_init_data) {
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
+		.parent_hws = (const struct clk_hw*[]) {
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
+		.hw.init = &(const struct clk_init_data) {
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
+		.hw.init = &(const struct clk_init_data) {
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
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_emac0_phy_aux_clk",
+			.parent_hws = (const struct clk_hw*[]) {
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
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_emac0_ptp_clk",
+			.parent_hws = (const struct clk_hw*[]) {
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
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_emac0_rgmii_clk",
+			.parent_hws = (const struct clk_hw*[]) {
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
+		.hw.init = &(const struct clk_init_data) {
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
+		.hw.init = &(const struct clk_init_data) {
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
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_gp1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
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
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_gp2_clk",
+			.parent_hws = (const struct clk_hw*[]) {
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
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_gp3_clk",
+			.parent_hws = (const struct clk_hw*[]) {
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
+		.hw.init = &(const struct clk_init_data) {
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
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_pcie_aux_clk",
+			.parent_hws = (const struct clk_hw*[]) {
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
+		.hw.init = &(const struct clk_init_data) {
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
+		.hw.init = &(const struct clk_init_data) {
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
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_pcie_pipe_clk",
+			.parent_hws = (const struct clk_hw*[]) {
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
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_pcie_rchng_phy_clk",
+			.parent_hws = (const struct clk_hw*[]) {
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
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_pcie_sleep_clk",
+			.parent_hws = (const struct clk_hw*[]) {
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
+		.hw.init = &(const struct clk_init_data) {
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
+		.hw.init = &(const struct clk_init_data) {
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
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_pdm2_clk",
+			.parent_hws = (const struct clk_hw*[]) {
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
+		.hw.init = &(const struct clk_init_data) {
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
+		.hw.init = &(const struct clk_init_data) {
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
+		.hw.init = &(const struct clk_init_data) {
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
+		.hw.init = &(const struct clk_init_data) {
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
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap0_s0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
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
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap0_s1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
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
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap0_s2_clk",
+			.parent_hws = (const struct clk_hw*[]) {
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
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap0_s3_clk",
+			.parent_hws = (const struct clk_hw*[]) {
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
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap0_s4_clk",
+			.parent_hws = (const struct clk_hw*[]) {
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
+		.hw.init = &(const struct clk_init_data) {
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
+		.hw.init = &(const struct clk_init_data) {
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
+		.hw.init = &(const struct clk_init_data) {
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
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_sdcc4_apps_clk",
+			.parent_hws = (const struct clk_hw*[]) {
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
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_snoc_cnoc_usb3_clk",
+			.parent_hws = (const struct clk_hw*[]) {
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
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_sys_noc_usb_sf_axi_clk",
+			.parent_hws = (const struct clk_hw*[]) {
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
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb20_master_clk",
+			.parent_hws = (const struct clk_hw*[]) {
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
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb20_mock_utmi_clk",
+			.parent_hws = (const struct clk_hw*[]) {
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
+		.hw.init = &(const struct clk_init_data) {
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
+		.hw.init = &(const struct clk_init_data) {
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
+		.hw.init = &(const struct clk_init_data) {
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
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb_phy_cfg_ahb2phy_clk",
+			.ops = &clk_branch2_aon_ops,
+		},
+	},
+};
+
+static struct gdsc gcc_emac0_gdsc = {
+	.gdscr = 0x71004,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0xf,
+	.pd = {
+		.name = "gcc_emac0_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = RETAIN_FF_ENABLE,
+};
+
+static struct gdsc gcc_pcie_gdsc = {
+	.gdscr = 0x53004,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0xf,
+	.pd = {
+		.name = "gcc_pcie_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = RETAIN_FF_ENABLE,
+};
+
+static struct gdsc gcc_usb20_gdsc = {
+	.gdscr = 0x27004,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0xf,
+	.pd = {
+		.name = "gcc_usb20_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = RETAIN_FF_ENABLE,
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
+static struct gdsc *gcc_kuno_gdscs[] = {
+	[GCC_EMAC0_GDSC] = &gcc_emac0_gdsc,
+	[GCC_PCIE_GDSC] = &gcc_pcie_gdsc,
+	[GCC_USB20_GDSC] = &gcc_usb20_gdsc,
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
+	.gdscs = gcc_kuno_gdscs,
+	.num_gdscs = ARRAY_SIZE(gcc_kuno_gdscs),
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

