Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6710F40B112
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2026 06:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791355880; cv=none; b=NCnNIo1qED1pjs1a3GSPnTASHAwfLu9YNbmcXpgxRZGC9P0H/hugus27jBjHJffNaIoJid5dTvxGZcloDy2XCSVDD72U0FWIuUVEgYT3qpxIIjllTM8Lo5Ja1mo1eQD5H+H+hiUwwClfPMcfGap75xBDqoNwoIoybqYtrwF5T1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791355880; c=relaxed/simple;
	bh=KyN5yZrFVJKthjAmmbAkJxjolAt+EZeqj8evlB0uFuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uvNlrCIpSUjSo9XtyczvCCBPtKYZiHFkG8IzzrmvDTkx++m/Zx1ICAYKW8FZmDMlqrvduprDZrs4l/yHwKU+Eb3eHeeNsun9EU5j4emBr/sfc9jn23Sxo1KCWAb1nbbT82QnMKFyARqsuBaFMP3uY+TcbalyFEL3e34IuxlUh3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eIuVN+2F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LZVVEhlg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eIuVN+2F";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LZVVEhlg"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6974U1jO3923506
	for <linux-pm@vger.kernel.org>; Wed, 7 Oct 2026 06:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Lh+LpMJSEHytBkWqz8ESY8YPUgkth8UqfG+klhzEh6M=; b=eIuVN+2FK7xX98+e
	g73jLmYwYk5ZzkF/0sNPeBkzvhZh2MiL5mqkffeQJZzZhsvDeOBE2uKz8KUcdOBA
	r7su/Z1U+yzZvrKL+Cfkf9r1XXkzGGIxke2UAgeWq0CHaLLesZAe3+LgDLnrsa9y
	CfKqE7uZNfH+79aH2SZcAMXs6XewvxE5OED8pXTJgHIUjQ2vJXimhl9tGpMwqwCl
	JbF5K/js/rqBBdHVDcQ3rcVDw5ZqYlNN+tKGe1SylJxBrr0hDFsI02Js8clSo/2y
	jchfAYMSIp6vFsXsCRaQ2qRDPpk/bgepWFwJfplsVMHWMiIwwjj9D53yP4HXsdiu
	ul227g==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c718xar-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 06:51:17 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1438719cc1eso5539522c88.0
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2026 23:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791355877; x=1791960677; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lh+LpMJSEHytBkWqz8ESY8YPUgkth8UqfG+klhzEh6M=;
        b=LZVVEhlgJgsM1EJevcs9K+aDb1YKzZPXp8qKytRZftsK52fOtqHDLqTB41cxWTDah5
         KYgEvFOxAafga02wzqhAIhaQVixqc9haoZNqxDwOKJM+wmWsZrXeWy0zppVDbV8hvHMh
         zYrw1IXu6azy4qCxXFHz0S4sOuGQibOPXytoPtKufzLDuazJJaeMa2ZVnAwu5YNH0dPZ
         0HJPhKu0fmbJqjHL6tPMA83Jc6JTw0Hytr7lNoyhC7OLMoaG2pbvn8s5MIvNANg2XCJk
         6Gxd1A+0ANgu/v0c2Gtm7WE7NNhgiQcpMtA+IvqNEDWwTrm9Xl8g9Mb21aKXtPgx0xxN
         nX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791355877; x=1791960677;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lh+LpMJSEHytBkWqz8ESY8YPUgkth8UqfG+klhzEh6M=;
        b=rIM8ByTvsH0oCWimLOyQU31t93M0tQS3XzvQB2+8inV5jjyL/7N91tw/0vbb0mblHV
         uTIeMEX+gx0fWFEcwTL7FTpY1GY/hXxYKWTFe23EFD1sEa9kEAclIKzwq7h8JYoobF2P
         KYy62BjrE9tVcD1SPQ5Io5TwaHuzF66LMM+QH6pVDuceTWKrGmbQrXDdtlb7PpD9Oemj
         vsrcmtPfOnXjfOpTKHxVfwr+kwbzqr41opN4zAwQlGcmzauhIvDQkUwB09fHN9vXXWN6
         onTZ1aj4QOHleqtQqy/CMJtdo20vptY4YzZypotz6u5xv2OBOvmkN9jraIaz8Kp3lcHy
         twew==
X-Gm-Message-State: AFuF++knb+H6OJGhDCDVPghhf0LpspdE6BETsbLb1xRoX66FATrxelKZ
	TY6LQXygb+6y0G2124ZOvP6xXCLYvdEyji4P7hE6og+0HwUQiKHwm+75/TqKU8n7rhtAQlPKvKl
	U8MK2UViqkXhsiBMAcNY/AjEMkJ0Wp9bM0oFtBQCvODPLnvxzNmex4qHDsEXvrQ==
X-Gm-Gg: AYBFou0Zpc4va+T72suY4pL3W4lhscMBAac8U9I2Mq4viX4Pkw6CT1cUe41iJdnUzxg
	n5DtnGp5/I9EDrq0yU029x/U0XAnWueX8bxmLO5Ym2Yfkq0e8gIk/MS/ElnZZq4lWrC/c5BnVPW
	kyK2SGRSWIdos5yzjrwJZMT8xfSdZ17wEANILpyyn3jIIHFhXTWJTryrR1RIbbIAKJA4puFBDGW
	biOpfBw+IQPhVx8FHXnlsbdNlmnT+J5VTMmpDDcsjIIyBnxdzexMYqJ1oEHmWQ/I+6uFcDlTY4r
	6+R6319MLVIuilCOottYEooXNg4gKdiWhrzvgfY42pBctvq7PZscG2/7sMCrW6fmLEQ2Kuw2mJU
	vIVTWaYFZHZvurxX5l5DqS9SOFXTkwrjf/D9M3XEYT0L1F8MaNkdf3A0tZ8uEXq3PouzNYeJaiD
	mpUPTXr8oPwRpaqXUPqMPpnZl04bprXffc1DE=
X-Received: by 2002:a05:7022:f502:b0:143:7001:7645 with SMTP id a92af1059eb24-16209760be6mr1069621c88.47.1791355876631;
        Tue, 06 Oct 2026 23:51:16 -0700 (PDT)
X-Received: by 2002:a05:7022:f502:b0:143:7001:7645 with SMTP id a92af1059eb24-16209760be6mr1069587c88.47.1791355876026;
        Tue, 06 Oct 2026 23:51:16 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1615f1ac8c5sm7374730c88.2.2026.10.06.23.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 23:51:15 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Wed, 07 Oct 2026 12:20:47 +0530
Subject: [PATCH 4/4] clk: qcom: apss-ipq9650: Add IPQ9650 APSS clock
 controller driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-ipq9650_apss_clk-v1-4-fd4c2b3cbdea@oss.qualcomm.com>
References: <20261007-ipq9650_apss_clk-v1-0-fd4c2b3cbdea@oss.qualcomm.com>
In-Reply-To: <20261007-ipq9650_apss_clk-v1-0-fd4c2b3cbdea@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAyNyBTYWx0ZWRfX+97Av6LsY+Yr
 7lqu0k3YgIay4Mtwe0mhUd0fAGTlJRMYilBlyz3fSfzzgDPliDTGNdRYDaJzM/X3ryfS3uHsEWm
 M+WS2nK6VR2AsBWX/rl1vXe58S3mlv8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAyNyBTYWx0ZWRfX5q9/QThAU/uJ
 EN73B0T4f/BpnLTyxMK7Oks9r+QEScfNFqLXYa0ukaTA+JNKH3huZS4xPGtIGl3UZeSLOFgS+u9
 e/k5o20OvuxNMFhxmoaQArjVI3uR+Wk7bhuGi/P5WWagt6c9couu0xsKR1ETxV6B1dAlF7I6QkM
 Ywan6r1mc5L6AAA1OlvjA8tdz2XVziafXiT9JdPvZFdtvnyxOUJGqfR0+8ZwWbCrzPJh/nTihI1
 qY3OzsdOa9/2kaMcnHygaqG68oiBFxVJjI7CJqH7Ft5Urf6My2070fZHE2oDz3mlFKXWuy/1x9K
 EDgI96E4LRS6yBbxxUc/BtDZ9IwFta/5/bE4ukWDtEIurtvqtMOBpzwkK/Acc7dI+uxyXNuf20u
 8Tp1WcrxOgesItR2o9coR/NHTvH5oM/tTkAQTU/+y1z037Dbi//yzBBC6Ads5Byxr8rk4epS9/Q
 qhbu4vXM5uni4pC5a+g==
X-Proofpoint-GUID: TV4j__uA3Qedp1-qCAUeUTh6GH8Xb35h
X-Proofpoint-ORIG-GUID: TV4j__uA3Qedp1-qCAUeUTh6GH8Xb35h
X-Authority-Analysis: v=2.4 cv=LvYHWXdc c=1 sm=1 tr=0 ts=6ac5ebe5 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=ml8jbCMxnmMANGqTHqUA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070027

The APSS clock controller on IPQ9650 provides the CPU and L3 clocks.
The four Cortex-A55 cores (silver), the Cortex-A78 core (gold) and the
L3 are each clocked by their own Zonda PLL. Each clock is selected
through a glitch-free mux (GFM) whose parents are XO, GPLL0 and the
corresponding PLL. The gold mux can also select the PLL's post-divider
output.

The L3 needs to be scaled along with the CPUs, so register an icc-clk
provider in which both CPU clusters vote on the L3 core clock.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig        |   9 +
 drivers/clk/qcom/Makefile       |   1 +
 drivers/clk/qcom/apss-ipq9650.c | 385 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 395 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 27d0ab24d50a..a17f661c3102 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -599,6 +599,15 @@ config IPQ_APSS_6018
 	  Say Y if you want to support CPU frequency scaling on
 	  ipq based devices.
 
+config IPQ_APSS_9650
+	tristate "IPQ9650 APSS Clock Controller"
+	depends on ARM64 || COMPILE_TEST
+	default y if IPQ_GCC_9650
+	help
+	  Support for APSS Clock controller on Qualcomm IPQ9650 platform.
+	  Say Y if you want to support CPU frequency scaling on IPQ9650 based
+	  devices.
+
 config IPQ_CMN_PLL
 	tristate "IPQ CMN PLL Clock Controller"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 6affb5073f26..ec3d8512a812 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_CLK_QCM2290_GPUCC) += gpucc-qcm2290.o
 obj-$(CONFIG_IPQ_APSS_PLL) += apss-ipq-pll.o
 obj-$(CONFIG_IPQ_APSS_5424) += apss-ipq5424.o
 obj-$(CONFIG_IPQ_APSS_6018) += apss-ipq6018.o
+obj-$(CONFIG_IPQ_APSS_9650) += apss-ipq9650.o
 obj-$(CONFIG_IPQ_CMN_PLL) += ipq-cmn-pll.o
 obj-$(CONFIG_IPQ_GCC_4019) += gcc-ipq4019.o
 obj-$(CONFIG_IPQ_GCC_5018) += gcc-ipq5018.o
diff --git a/drivers/clk/qcom/apss-ipq9650.c b/drivers/clk/qcom/apss-ipq9650.c
new file mode 100644
index 000000000000..7602f3896fe3
--- /dev/null
+++ b/drivers/clk/qcom/apss-ipq9650.c
@@ -0,0 +1,385 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/interconnect-provider.h>
+
+#include <dt-bindings/clock/qcom,apss-ipq.h>
+#include <dt-bindings/interconnect/qcom,ipq9650.h>
+
+#include "clk-alpha-pll.h"
+#include "clk-branch.h"
+#include "clk-regmap.h"
+#include "common.h"
+
+enum {
+	DT_XO,
+	DT_GPLL0,
+};
+
+static const struct pll_vco silver_pll_vco[] = {
+	{ 816000000, 1968000000, 0 },
+};
+
+static const struct pll_vco gold_pll_vco[] = {
+	{ 696000000, 1992000000, 0 },
+};
+
+static const struct pll_vco l3_pll_vco[] = {
+	{ 696000000, 1512000000, 0 },
+};
+
+static const struct alpha_pll_config silver_apss_pll_config = {
+	.l = 0x23,
+	.config_ctl_val = 0x08200920,
+	.config_ctl_hi_val = 0x05008001,
+	.config_ctl_hi1_val = 0x04000000,
+	.user_ctl_val = 0x01000009,
+};
+
+static const struct alpha_pll_config gold_apss_pll_config = {
+	.l = 0x26,
+	.config_ctl_val = 0x08200920,
+	.config_ctl_hi_val = 0x05008001,
+	.config_ctl_hi1_val = 0x04000000,
+	.user_ctl_val = 0x01000009,
+};
+
+static const struct alpha_pll_config l3_pll_config = {
+	.l = 0x1e,
+	.config_ctl_val = 0x08200920,
+	.config_ctl_hi_val = 0x05008001,
+	.config_ctl_hi1_val = 0x04000000,
+	.user_ctl_val = 0x01000009,
+};
+
+static struct clk_alpha_pll silver_apss_pll = {
+	.offset = 0x0,
+	.config = &silver_apss_pll_config,
+	.vco_table = silver_pll_vco,
+	.num_vco = ARRAY_SIZE(silver_pll_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_ZONDA],
+	.flags = SUPPORTS_DYNAMIC_UPDATE,
+	.clkr = {
+		.enable_reg = 0x0,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "silver_apss_pll",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_XO,
+			},
+			.num_parents = 1,
+			.flags = CLK_IS_CRITICAL,
+			.ops = &clk_alpha_pll_zonda_ops,
+		},
+	},
+};
+
+static struct clk_alpha_pll gold_apss_pll = {
+	.offset = 0x10000,
+	.config = &gold_apss_pll_config,
+	.vco_table = gold_pll_vco,
+	.num_vco = ARRAY_SIZE(gold_pll_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_ZONDA],
+	.flags = SUPPORTS_DYNAMIC_UPDATE,
+	.clkr = {
+		.enable_reg = 0x10000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gold_apss_pll",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_XO,
+			},
+			.num_parents = 1,
+			.flags = CLK_IS_CRITICAL,
+			.ops = &clk_alpha_pll_zonda_ops,
+		},
+	},
+};
+
+static const struct clk_div_table gold_apss_pll_post_div_table[] = {
+	{ 0x0, 1 },
+	{ 0x1, 2 },
+	{ }
+};
+
+static struct clk_alpha_pll_postdiv gold_apss_pll_postdiv = {
+	.offset = 0x10000,
+	.post_div_shift = 8,
+	.post_div_table = gold_apss_pll_post_div_table,
+	.num_post_div = ARRAY_SIZE(gold_apss_pll_post_div_table),
+	.width = 2,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_ZONDA],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "gold_apss_pll_postdiv",
+		.parent_hws = (const struct clk_hw*[]){
+			&gold_apss_pll.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_alpha_pll_postdiv_zonda_ops,
+	},
+};
+
+static struct clk_alpha_pll l3_pll = {
+	.offset = 0x20000,
+	.config = &l3_pll_config,
+	.vco_table = l3_pll_vco,
+	.num_vco = ARRAY_SIZE(l3_pll_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_ZONDA],
+	.flags = SUPPORTS_DYNAMIC_UPDATE,
+	.clkr = {
+		.enable_reg = 0x20000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "l3_pll",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_XO,
+			},
+			.num_parents = 1,
+			.flags = CLK_IS_CRITICAL,
+			.ops = &clk_alpha_pll_zonda_ops,
+		},
+	},
+};
+
+struct clk_gfm {
+	u32 mux_reg;
+	u32 mux_mask;
+	struct clk_hw hw;
+	void __iomem *base;
+};
+
+#define to_clk_gfm(_hw) container_of(_hw, struct clk_gfm, hw)
+
+static u8 clk_gfm_get_parent(struct clk_hw *hw)
+{
+	struct clk_gfm *gfm = to_clk_gfm(hw);
+	u32 val;
+
+	val = readl(gfm->base + gfm->mux_reg);
+	return val & gfm->mux_mask;
+}
+
+static int clk_gfm_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_gfm *gfm = to_clk_gfm(hw);
+	u32 val;
+
+	val = readl(gfm->base + gfm->mux_reg);
+	val &= ~gfm->mux_mask;
+	val |= (index & gfm->mux_mask);
+	writel(val, gfm->base + gfm->mux_reg);
+
+	return 0;
+}
+
+static const struct clk_ops clk_gfm_ops = {
+	.get_parent = clk_gfm_get_parent,
+	.set_parent = clk_gfm_set_parent,
+	.determine_rate = __clk_mux_determine_rate_closest,
+};
+
+static struct clk_gfm silver_apss_pll_gfmux = {
+	.mux_reg = 0x84,
+	.mux_mask = 0xf,
+	.hw.init = &(struct clk_init_data) {
+		.name = "silver_apss_pll_gfmux",
+		.parent_data = (const struct clk_parent_data[]) {
+			{ .index = DT_XO },
+			{ .index = DT_GPLL0 },
+			{ .hw = &silver_apss_pll.clkr.hw },
+		},
+		.num_parents = 3,
+		.ops = &clk_gfm_ops,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_gfm gold_apss_pll_gfmux = {
+	.mux_reg = 0x10084,
+	.mux_mask = 0xf,
+	.hw.init = &(struct clk_init_data) {
+		.name = "gold_apss_pll_gfmux",
+		.parent_data = (const struct clk_parent_data[]) {
+			{ .index = DT_XO },
+			{ .index = DT_GPLL0 },
+			{ .hw = &gold_apss_pll.clkr.hw },
+			{ .hw = &gold_apss_pll_postdiv.clkr.hw },
+		},
+		.num_parents = 4,
+		.ops = &clk_gfm_ops,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_gfm l3_pll_gfmux = {
+	.mux_reg = 0x20084,
+	.mux_mask = 0xf,
+	.hw.init = &(struct clk_init_data) {
+		.name = "l3_pll_gfmux",
+		.parent_data = (const struct clk_parent_data[]) {
+			{ .index = DT_XO },
+			{ .index = DT_GPLL0 },
+			{ .hw = &l3_pll.clkr.hw },
+		},
+		.num_parents = 3,
+		.ops = &clk_gfm_ops,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_branch apss_silver_core_clk = {
+	.halt_reg = 0x8c,
+	.clkr = {
+		.enable_reg = 0x8c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "apss_silver_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&silver_apss_pll_gfmux.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch apss_gold_core_clk = {
+	.halt_reg = 0x1008c,
+	.clkr = {
+		.enable_reg = 0x1008c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "apss_gold_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gold_apss_pll_gfmux.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch l3_core_clk = {
+	.halt_reg = 0x2008c,
+	.clkr = {
+		.enable_reg = 0x2008c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "l3_core_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&l3_pll_gfmux.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_hw *apss_hws[] = {
+	&silver_apss_pll_gfmux.hw,
+	&l3_pll_gfmux.hw,
+	&gold_apss_pll_gfmux.hw,
+};
+
+static struct clk_regmap *apss_clks[] = {
+	[APSS_PLL_EARLY] = &silver_apss_pll.clkr,
+	[APSS_SILVER_CORE_CLK] = &apss_silver_core_clk.clkr,
+	[L3_PLL] = &l3_pll.clkr,
+	[L3_CORE_CLK] = &l3_core_clk.clkr,
+	[APSS_GOLD_PLL] = &gold_apss_pll.clkr,
+	[APSS_GOLD_PLL_POSTDIV] = &gold_apss_pll_postdiv.clkr,
+	[APSS_GOLD_CORE_CLK] = &apss_gold_core_clk.clkr,
+};
+
+static const struct regmap_config apss_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x2fffc,
+	.fast_io = true,
+};
+
+static struct clk_alpha_pll *ipq9650_apss_plls[] = {
+	&silver_apss_pll,
+	&gold_apss_pll,
+	&l3_pll,
+};
+
+static const struct qcom_cc_driver_data ipq9650_apss_driver_data = {
+	.alpha_plls = ipq9650_apss_plls,
+	.num_alpha_plls = ARRAY_SIZE(ipq9650_apss_plls),
+};
+
+#define IPQ_APPS_PLL_ID			(9650 * 3)	/* some unique value */
+
+static const struct qcom_icc_hws_data icc_cpu_l3[] = {
+	{ MASTER_CPU_SILVER, SLAVE_L3, L3_CORE_CLK },
+	{ MASTER_CPU_GOLD, SLAVE_L3, L3_CORE_CLK },
+};
+
+static const struct qcom_cc_desc apss_desc = {
+	.config = &apss_regmap_config,
+	.clks = apss_clks,
+	.num_clks = ARRAY_SIZE(apss_clks),
+	.icc_hws = icc_cpu_l3,
+	.num_icc_hws = ARRAY_SIZE(icc_cpu_l3),
+	.icc_first_node_id = IPQ_APPS_PLL_ID,
+	.clk_hws = apss_hws,
+	.num_clk_hws = ARRAY_SIZE(apss_hws),
+	.driver_data = &ipq9650_apss_driver_data,
+};
+
+static int apss_ipq9650_probe(struct platform_device *pdev)
+{
+	const struct qcom_cc_desc *desc = &apss_desc;
+	struct regmap *regmap;
+	struct clk_gfm *gfm;
+	void __iomem *base;
+	int i;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	regmap = devm_regmap_init_mmio(&pdev->dev, base,
+				       &apss_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	for (i = 0; i < desc->num_clk_hws; i++) {
+		gfm = to_clk_gfm(apss_hws[i]);
+		gfm->base = base;
+	}
+
+	return qcom_cc_really_probe(&pdev->dev, desc, regmap);
+}
+
+static const struct of_device_id apss_ipq9650_match_table[] = {
+	{ .compatible = "qcom,ipq9650-apss-clk" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, apss_ipq9650_match_table);
+
+static struct platform_driver apss_ipq9650_driver = {
+	.probe = apss_ipq9650_probe,
+	.driver = {
+		.name = "qcom,ipq9650-apss-clk",
+		.of_match_table = apss_ipq9650_match_table,
+		.sync_state = icc_sync_state,
+	},
+};
+
+module_platform_driver(apss_ipq9650_driver);
+
+MODULE_DESCRIPTION("Qualcomm IPQ9650 APSS Clock Driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

