Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A782D3DFC74
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692817; cv=none; b=NxzSa/YJXJN8i3613+tq+lTWjZZBe+7HWOQDJvuMNimBhrMw38sCzr0gL13zJvOAbMMRnk9VQKP2Qan4t2CDB2inbLVGzyUP6j5RzD2nNKXKcOX2G392uiwcv2nRjwQv24pfEzF9mtaAnrqwifPv6insz8NbK+wNwtMpUE5tkdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692817; c=relaxed/simple;
	bh=aXWpR9RFXpy9ud1Dns2lQygbdcCe3sMTa3o62RhIi0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XaH5CrFkJSTCVxhchrd+uEVgzhoWfd3X9/f2cD69kut3Lyk8UnB8DdK1gUKiHh4Hh+Ejtsz7TDh+1tYERz8p2HO0fsYhlO1eOeu/1poW2+bRbwsVUH8CYUDXqHS5T14FFxnFIerVV1BlbcQ3SqeIDIrPf0j3z1i2kEhlD/42wmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mQRCEUQt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Iojjg1/z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mQRCEUQt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Iojjg1/z"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E4QV5b669238
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x5vJI2qJH2lLpq70iJNQR3nSA73Yk8o+xPkD1glMQXQ=; b=mQRCEUQtidTT+p/E
	BFhmM3RYpvqsEwBaf52BIfPfBqoUu6guKEfkJLtAX/MAAazL2+KsQWjdx1vvI58o
	JaWXQ639iCMocOdq+xZ6qjuy5+aOXRc+jr+NUYG4eUwyI9FUMGjRHRBXirl+/kqc
	QNsQ0aCPjl1q/T3GwebnGEQdCnkdRNrboIMGPrjhr0Mzz5HsILhB6CgqFFoMJiFe
	aLLpt1FA5qJgDYhaDxXmOTrSAqAZFt6s3VTc4QVwPijNzFuX9lcYQW0/q8ZFLeAh
	a/3iKM2thmKDyZz/1EMd3FAg42LeEU36HzttUQ17/obMIMypkIOn2i3seTVNriqX
	sesobA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1h1uua9j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:33:19 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e6d253330so697218a91.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 00:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786692799; x=1787297599; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x5vJI2qJH2lLpq70iJNQR3nSA73Yk8o+xPkD1glMQXQ=;
        b=Iojjg1/zRhiF1/XKqVGOmuEmAFonhHTWwBtAd66S0uX0AXiZtxEwSovYv/1iiFhlzR
         02zjN2E1KfNRw1WASPjKTzA+vJz06NrWk0wjHEpcvi+SQXxZ73EoYXX269uIBS/9mSdt
         7APP1bzFJQvhIfB/EvNSxqCKRd61s4Ieit1ff99krnAmo+4/a/PuqrqwouMa5kFP72lu
         sYF7mM/TCvAYpQfoggD8lxRabR/rcJ+85eENVa2giyHNhYi/7T/PqRDBiG0tcbdWeqfX
         H6Y2AlLIHuwHWPOxSSQlx/zXkRe4sifZ903o8URvhnrE85i1tvne0u87V82GhhdBmo8q
         ekug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786692799; x=1787297599;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x5vJI2qJH2lLpq70iJNQR3nSA73Yk8o+xPkD1glMQXQ=;
        b=RxjZye5jbDxeXzNzWEQ2Qt7mrhp6NiTDWAL6Ne0jpn5npAPBASFdm1TAP58a1HHNt1
         tRQfR31/kDG+jJXBBc0EixwiWMQMNCt2t/e4T9v9BsZJqY+RCplwB/Ry6igR/FA7TsMc
         VlbzYjW8tzOwX6ih57Qp/9hqE2yGAF3Qfd9JroWrDfSrpJ2fa3ffojljwk6E9UEz2sPh
         OFno6aWSMReWJlPLd/cjfALoC6mOw5rSflkjsaMNCSfkhTxvGk9N1FhFkShMyyYgp8kG
         3i2JtXxylV24JYCDJHhuZoo2YRyXcKrKdbsCvs3HneaIIsmJ3wy6sXxB4Aj/MhOyiswn
         GAzg==
X-Forwarded-Encrypted: i=1; AHgh+RoN8w8vC2y7avO0iMi8EJ5OWfRzfh/l1yfhRECRRdSXjl+FK4Glrd8obh1rPcm2PeT47jhtmC55zA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkJ6ARv6ggJTBZ8oVtQK+BfDbuVIp7KIPdJYzqxwUgSyUMuWXq
	A7qtfRNj9GXAuqqo2J9YYh9Qt41ob2v3/VLuAmQs5Zp6t3PpIkouNGpulte9ABJa8SzpuLjQh0b
	zMGzjAHsDQ5XnTst1fwuXHvmXXke7gHFxpXVp7ftJ0PHzrLsxp7QN2gerVcayVA==
X-Gm-Gg: AR+sD10Scpj6tntzc99f/u+Xguqt/dVlDHLznuILEUm32L73fMX0Rv9X3XCZG51rErx
	6UWSi4j8DmOlSe1tyzaTacd+hmtljcWNfG7NEx7g8OkvLM0pCBfT+IhKWTIS+NZRiUloi1MfxDX
	MPoUybunsKtJ5LYHHU5TE7lsoZESFn4atmPp2UTimMF0IxGe4AtyXuJ40pgoAPIyHI6THtvMYQa
	JaWL25hXKni6lrkG4MWsZqtRbxzA28bKTnnuDqliyrBWrJTFj51LYNYrKR3ewXh8elOc9GV27fG
	fuuAilxWkmT83k8Otr8VOqGApYT82hfoqGyIzFJjQ0UOh40buyEIPD+KSZVX8phOUYV51TS8l0b
	WrY9E+Ux6VRQLr58Wi0l/sVbo4SBWlZCz4wLifBMNhZ6hq0WQuBzy1zSZmOIRGVaLpZqMEDgF6t
	cNiO7Oaf7uuH9IwR6QuudVlHA=
X-Received: by 2002:a17:90b:5445:b0:386:ca4b:16a9 with SMTP id 98e67ed59e1d1-3933b0d5e25mr3003610a91.16.1786692798402;
        Fri, 14 Aug 2026 00:33:18 -0700 (PDT)
X-Received: by 2002:a17:90b:5445:b0:386:ca4b:16a9 with SMTP id 98e67ed59e1d1-3933b0d5e25mr3003542a91.16.1786692797694;
        Fri, 14 Aug 2026 00:33:17 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea804233sm1062280eec.26.2026.08.14.00.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:33:17 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 13:01:40 +0530
Subject: [PATCH v2 09/15] pinctrl: qcom: Add Kuno pinctrl driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-kuno-soc-support-v2-9-3079794f0f73@oss.qualcomm.com>
References: <20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com>
In-Reply-To: <20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com>
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
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786692714; l=29217;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=aXWpR9RFXpy9ud1Dns2lQygbdcCe3sMTa3o62RhIi0M=;
 b=2wya2YYUH226pEJURqjBggGg3K5Y+STwebqxUW54cDLNcPd2hZMvpTLVuuxFkYiN+XnLhfbUe
 1B12g07qVbaDkaYJuQCAj76e2HF8T5H2qnC3RxeEBPeQ6QopndIgpn7
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-GUID: 4eyq9wzKcIgu2Hed_usYOAWvnJOwY_do
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfX8+mIXJnf87M/
 QiG2ZjLfZYc6+COkNuyw5IiXvRPsxDMKm+KjN12zguVB5NSBTX+4qz92d6ttdn4Zd5D6sQFZIgB
 gi3NTjk07vtqWZ/YO5q9n9rWCdt7iW+b0UjmHxoGgtyp+zWGHLy3+iN2j4JD562QqmUdPyg9Hdr
 Ibmp/L7dzs5+kdk/Yy9whDa6BzBFlRLGdI3HO96h0S/3MsM4RicIGrM3s5DDp7y+nJXSOzj1Cd/
 Nufcv/roIkJR2VOXEzkh82Ydik/5694URh5Q1X34po7u3lXrUEX0wEx1L73BrQ/RHCGQErchGPs
 WAxjL2ouRqYADxq6+UT1LErg4GpYX87QsDbfaBJykzjZIrjTZMhV9F/0YKg7F2E+OTRxHwHNiHq
 NXcuhgeh2FzbUaOpSS/zdTAKzIGz9eebG/mYCzMDS80Yy+OAjfKSALedGYtkkc9lwE7rN8NxK6m
 uV5TyNYbUnTK9d07ujQ==
X-Proofpoint-ORIG-GUID: 4eyq9wzKcIgu2Hed_usYOAWvnJOwY_do
X-Authority-Analysis: v=2.4 cv=HMjz0Itv c=1 sm=1 tr=0 ts=6a7ec4bf cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=CsXzbs-S2857TcPiuzUA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfX218WXSktK7M8
 ETKi3Xae+nb/gqypdBnNkdYO8gCm4yK2buohEW1oqKYQXKFS/VumAiWU5F/ZO4WW0lh+YqSbzCL
 QfPl1PK+jWtpXbhK1UFLjU39XO072cs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140058

Add the TLMM pinctrl driver for the Qualcomm Kuno platform, supporting
110 GPIOs and their pin multiplexing, pin configuration and gpiolib
interface through the common pinctrl-msm driver.

Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/Kconfig.msm    |  11 +
 drivers/pinctrl/qcom/Makefile       |   1 +
 drivers/pinctrl/qcom/pinctrl-kuno.c | 796 ++++++++++++++++++++++++++++++++++++
 3 files changed, 808 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig.msm b/drivers/pinctrl/qcom/Kconfig.msm
index 42875457b5fc..9b95bf8ecb22 100644
--- a/drivers/pinctrl/qcom/Kconfig.msm
+++ b/drivers/pinctrl/qcom/Kconfig.msm
@@ -153,6 +153,17 @@ config PINCTRL_KAANAPALI
 	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
 	  Technologies Inc Kaanapali platform.
 
+config PINCTRL_KUNO
+	tristate "Qualcomm Kuno pin controller driver"
+	depends on ARM || COMPILE_TEST
+	default ARCH_QCOM
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
+	  Technologies Inc Kuno platform.
+	  Say Y here to compile statically, or M here to compile it as a
+	  module. If unsure, say N.
+
 config PINCTRL_MAILI
 	tristate "Qualcomm Technologies Inc Maili pin controller driver"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 43ecd246afe8..f003add981ab 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_PINCTRL_IPQ6018)	+= pinctrl-ipq6018.o
 obj-$(CONFIG_PINCTRL_IPQ9574)	+= pinctrl-ipq9574.o
 obj-$(CONFIG_PINCTRL_IPQ9650)	+= pinctrl-ipq9650.o
 obj-$(CONFIG_PINCTRL_KAANAPALI) += pinctrl-kaanapali.o
+obj-$(CONFIG_PINCTRL_KUNO)	+= pinctrl-kuno.o
 obj-$(CONFIG_PINCTRL_MAILI)	+= pinctrl-maili.o
 obj-$(CONFIG_PINCTRL_MSM8226)	+= pinctrl-msm8226.o
 obj-$(CONFIG_PINCTRL_MSM8660)	+= pinctrl-msm8660.o
diff --git a/drivers/pinctrl/qcom/pinctrl-kuno.c b/drivers/pinctrl/qcom/pinctrl-kuno.c
new file mode 100644
index 000000000000..3211c8a4054f
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-kuno.c
@@ -0,0 +1,796 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include "pinctrl-msm.h"
+
+#define REG_BASE 0x100000
+#define REG_SIZE 0x1000
+#define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9)		\
+	{					        \
+		.grp = PINCTRL_PINGROUP("gpio" #id,	\
+			gpio##id##_pins,		\
+			ARRAY_SIZE(gpio##id##_pins)),	\
+		.funcs = (int[]){			\
+			msm_mux_gpio, /* gpio mode */	\
+			msm_mux_##f1,			\
+			msm_mux_##f2,			\
+			msm_mux_##f3,			\
+			msm_mux_##f4,			\
+			msm_mux_##f5,			\
+			msm_mux_##f6,			\
+			msm_mux_##f7,			\
+			msm_mux_##f8,			\
+			msm_mux_##f9			\
+		},				        \
+		.nfuncs = 10,				\
+		.ctl_reg = REG_BASE + REG_SIZE * id,			\
+		.io_reg = REG_BASE + 0x4 + REG_SIZE * id,		\
+		.intr_cfg_reg = REG_BASE + 0x8 + REG_SIZE * id,		\
+		.intr_status_reg = REG_BASE + 0xc + REG_SIZE * id,	\
+		.mux_bit = 2,			\
+		.pull_bit = 0,			\
+		.drv_bit = 6,			\
+		.oe_bit = 9,			\
+		.in_bit = 0,			\
+		.out_bit = 1,			\
+		.intr_enable_bit = 0,		\
+		.intr_status_bit = 0,		\
+		.intr_target_bit = 5,		\
+		.intr_target_kpss_val = 3,	\
+		.intr_raw_status_bit = 4,	\
+		.intr_polarity_bit = 1,		\
+		.intr_detection_bit = 2,	\
+		.intr_detection_width = 2,	\
+	}
+
+static const struct pinctrl_pin_desc kuno_pins[] = {
+	PINCTRL_PIN(0, "GPIO_0"),
+	PINCTRL_PIN(1, "GPIO_1"),
+	PINCTRL_PIN(2, "GPIO_2"),
+	PINCTRL_PIN(3, "GPIO_3"),
+	PINCTRL_PIN(4, "GPIO_4"),
+	PINCTRL_PIN(5, "GPIO_5"),
+	PINCTRL_PIN(6, "GPIO_6"),
+	PINCTRL_PIN(7, "GPIO_7"),
+	PINCTRL_PIN(8, "GPIO_8"),
+	PINCTRL_PIN(9, "GPIO_9"),
+	PINCTRL_PIN(10, "GPIO_10"),
+	PINCTRL_PIN(11, "GPIO_11"),
+	PINCTRL_PIN(12, "GPIO_12"),
+	PINCTRL_PIN(13, "GPIO_13"),
+	PINCTRL_PIN(14, "GPIO_14"),
+	PINCTRL_PIN(15, "GPIO_15"),
+	PINCTRL_PIN(16, "GPIO_16"),
+	PINCTRL_PIN(17, "GPIO_17"),
+	PINCTRL_PIN(18, "GPIO_18"),
+	PINCTRL_PIN(19, "GPIO_19"),
+	PINCTRL_PIN(20, "GPIO_20"),
+	PINCTRL_PIN(21, "GPIO_21"),
+	PINCTRL_PIN(22, "GPIO_22"),
+	PINCTRL_PIN(23, "GPIO_23"),
+	PINCTRL_PIN(24, "GPIO_24"),
+	PINCTRL_PIN(25, "GPIO_25"),
+	PINCTRL_PIN(26, "GPIO_26"),
+	PINCTRL_PIN(27, "GPIO_27"),
+	PINCTRL_PIN(28, "GPIO_28"),
+	PINCTRL_PIN(29, "GPIO_29"),
+	PINCTRL_PIN(30, "GPIO_30"),
+	PINCTRL_PIN(31, "GPIO_31"),
+	PINCTRL_PIN(32, "GPIO_32"),
+	PINCTRL_PIN(33, "GPIO_33"),
+	PINCTRL_PIN(34, "GPIO_34"),
+	PINCTRL_PIN(35, "GPIO_35"),
+	PINCTRL_PIN(36, "GPIO_36"),
+	PINCTRL_PIN(37, "GPIO_37"),
+	PINCTRL_PIN(38, "GPIO_38"),
+	PINCTRL_PIN(39, "GPIO_39"),
+	PINCTRL_PIN(40, "GPIO_40"),
+	PINCTRL_PIN(41, "GPIO_41"),
+	PINCTRL_PIN(42, "GPIO_42"),
+	PINCTRL_PIN(43, "GPIO_43"),
+	PINCTRL_PIN(44, "GPIO_44"),
+	PINCTRL_PIN(45, "GPIO_45"),
+	PINCTRL_PIN(46, "GPIO_46"),
+	PINCTRL_PIN(47, "GPIO_47"),
+	PINCTRL_PIN(48, "GPIO_48"),
+	PINCTRL_PIN(49, "GPIO_49"),
+	PINCTRL_PIN(50, "GPIO_50"),
+	PINCTRL_PIN(51, "GPIO_51"),
+	PINCTRL_PIN(52, "GPIO_52"),
+	PINCTRL_PIN(53, "GPIO_53"),
+	PINCTRL_PIN(54, "GPIO_54"),
+	PINCTRL_PIN(55, "GPIO_55"),
+	PINCTRL_PIN(56, "GPIO_56"),
+	PINCTRL_PIN(57, "GPIO_57"),
+	PINCTRL_PIN(58, "GPIO_58"),
+	PINCTRL_PIN(59, "GPIO_59"),
+	PINCTRL_PIN(60, "GPIO_60"),
+	PINCTRL_PIN(61, "GPIO_61"),
+	PINCTRL_PIN(62, "GPIO_62"),
+	PINCTRL_PIN(63, "GPIO_63"),
+	PINCTRL_PIN(64, "GPIO_64"),
+	PINCTRL_PIN(65, "GPIO_65"),
+	PINCTRL_PIN(66, "GPIO_66"),
+	PINCTRL_PIN(67, "GPIO_67"),
+	PINCTRL_PIN(68, "GPIO_68"),
+	PINCTRL_PIN(69, "GPIO_69"),
+	PINCTRL_PIN(70, "GPIO_70"),
+	PINCTRL_PIN(71, "GPIO_71"),
+	PINCTRL_PIN(72, "GPIO_72"),
+	PINCTRL_PIN(73, "GPIO_73"),
+	PINCTRL_PIN(74, "GPIO_74"),
+	PINCTRL_PIN(75, "GPIO_75"),
+	PINCTRL_PIN(76, "GPIO_76"),
+	PINCTRL_PIN(77, "GPIO_77"),
+	PINCTRL_PIN(78, "GPIO_78"),
+	PINCTRL_PIN(79, "GPIO_79"),
+	PINCTRL_PIN(80, "GPIO_80"),
+	PINCTRL_PIN(81, "GPIO_81"),
+	PINCTRL_PIN(82, "GPIO_82"),
+	PINCTRL_PIN(83, "GPIO_83"),
+	PINCTRL_PIN(84, "GPIO_84"),
+	PINCTRL_PIN(85, "GPIO_85"),
+	PINCTRL_PIN(86, "GPIO_86"),
+	PINCTRL_PIN(87, "GPIO_87"),
+	PINCTRL_PIN(88, "GPIO_88"),
+	PINCTRL_PIN(89, "GPIO_89"),
+	PINCTRL_PIN(90, "GPIO_90"),
+	PINCTRL_PIN(91, "GPIO_91"),
+	PINCTRL_PIN(92, "GPIO_92"),
+	PINCTRL_PIN(93, "GPIO_93"),
+	PINCTRL_PIN(94, "GPIO_94"),
+	PINCTRL_PIN(95, "GPIO_95"),
+	PINCTRL_PIN(96, "GPIO_96"),
+	PINCTRL_PIN(97, "GPIO_97"),
+	PINCTRL_PIN(98, "GPIO_98"),
+	PINCTRL_PIN(99, "GPIO_99"),
+	PINCTRL_PIN(100, "GPIO_100"),
+	PINCTRL_PIN(101, "GPIO_101"),
+	PINCTRL_PIN(102, "GPIO_102"),
+	PINCTRL_PIN(103, "GPIO_103"),
+	PINCTRL_PIN(104, "GPIO_104"),
+	PINCTRL_PIN(105, "GPIO_105"),
+	PINCTRL_PIN(106, "GPIO_106"),
+	PINCTRL_PIN(107, "GPIO_107"),
+	PINCTRL_PIN(108, "GPIO_108"),
+	PINCTRL_PIN(109, "GPIO_109"),
+};
+
+#define DECLARE_MSM_GPIO_PINS(pin) \
+	static const unsigned int gpio##pin##_pins[] = { pin }
+DECLARE_MSM_GPIO_PINS(0);
+DECLARE_MSM_GPIO_PINS(1);
+DECLARE_MSM_GPIO_PINS(2);
+DECLARE_MSM_GPIO_PINS(3);
+DECLARE_MSM_GPIO_PINS(4);
+DECLARE_MSM_GPIO_PINS(5);
+DECLARE_MSM_GPIO_PINS(6);
+DECLARE_MSM_GPIO_PINS(7);
+DECLARE_MSM_GPIO_PINS(8);
+DECLARE_MSM_GPIO_PINS(9);
+DECLARE_MSM_GPIO_PINS(10);
+DECLARE_MSM_GPIO_PINS(11);
+DECLARE_MSM_GPIO_PINS(12);
+DECLARE_MSM_GPIO_PINS(13);
+DECLARE_MSM_GPIO_PINS(14);
+DECLARE_MSM_GPIO_PINS(15);
+DECLARE_MSM_GPIO_PINS(16);
+DECLARE_MSM_GPIO_PINS(17);
+DECLARE_MSM_GPIO_PINS(18);
+DECLARE_MSM_GPIO_PINS(19);
+DECLARE_MSM_GPIO_PINS(20);
+DECLARE_MSM_GPIO_PINS(21);
+DECLARE_MSM_GPIO_PINS(22);
+DECLARE_MSM_GPIO_PINS(23);
+DECLARE_MSM_GPIO_PINS(24);
+DECLARE_MSM_GPIO_PINS(25);
+DECLARE_MSM_GPIO_PINS(26);
+DECLARE_MSM_GPIO_PINS(27);
+DECLARE_MSM_GPIO_PINS(28);
+DECLARE_MSM_GPIO_PINS(29);
+DECLARE_MSM_GPIO_PINS(30);
+DECLARE_MSM_GPIO_PINS(31);
+DECLARE_MSM_GPIO_PINS(32);
+DECLARE_MSM_GPIO_PINS(33);
+DECLARE_MSM_GPIO_PINS(34);
+DECLARE_MSM_GPIO_PINS(35);
+DECLARE_MSM_GPIO_PINS(36);
+DECLARE_MSM_GPIO_PINS(37);
+DECLARE_MSM_GPIO_PINS(38);
+DECLARE_MSM_GPIO_PINS(39);
+DECLARE_MSM_GPIO_PINS(40);
+DECLARE_MSM_GPIO_PINS(41);
+DECLARE_MSM_GPIO_PINS(42);
+DECLARE_MSM_GPIO_PINS(43);
+DECLARE_MSM_GPIO_PINS(44);
+DECLARE_MSM_GPIO_PINS(45);
+DECLARE_MSM_GPIO_PINS(46);
+DECLARE_MSM_GPIO_PINS(47);
+DECLARE_MSM_GPIO_PINS(48);
+DECLARE_MSM_GPIO_PINS(49);
+DECLARE_MSM_GPIO_PINS(50);
+DECLARE_MSM_GPIO_PINS(51);
+DECLARE_MSM_GPIO_PINS(52);
+DECLARE_MSM_GPIO_PINS(53);
+DECLARE_MSM_GPIO_PINS(54);
+DECLARE_MSM_GPIO_PINS(55);
+DECLARE_MSM_GPIO_PINS(56);
+DECLARE_MSM_GPIO_PINS(57);
+DECLARE_MSM_GPIO_PINS(58);
+DECLARE_MSM_GPIO_PINS(59);
+DECLARE_MSM_GPIO_PINS(60);
+DECLARE_MSM_GPIO_PINS(61);
+DECLARE_MSM_GPIO_PINS(62);
+DECLARE_MSM_GPIO_PINS(63);
+DECLARE_MSM_GPIO_PINS(64);
+DECLARE_MSM_GPIO_PINS(65);
+DECLARE_MSM_GPIO_PINS(66);
+DECLARE_MSM_GPIO_PINS(67);
+DECLARE_MSM_GPIO_PINS(68);
+DECLARE_MSM_GPIO_PINS(69);
+DECLARE_MSM_GPIO_PINS(70);
+DECLARE_MSM_GPIO_PINS(71);
+DECLARE_MSM_GPIO_PINS(72);
+DECLARE_MSM_GPIO_PINS(73);
+DECLARE_MSM_GPIO_PINS(74);
+DECLARE_MSM_GPIO_PINS(75);
+DECLARE_MSM_GPIO_PINS(76);
+DECLARE_MSM_GPIO_PINS(77);
+DECLARE_MSM_GPIO_PINS(78);
+DECLARE_MSM_GPIO_PINS(79);
+DECLARE_MSM_GPIO_PINS(80);
+DECLARE_MSM_GPIO_PINS(81);
+DECLARE_MSM_GPIO_PINS(82);
+DECLARE_MSM_GPIO_PINS(83);
+DECLARE_MSM_GPIO_PINS(84);
+DECLARE_MSM_GPIO_PINS(85);
+DECLARE_MSM_GPIO_PINS(86);
+DECLARE_MSM_GPIO_PINS(87);
+DECLARE_MSM_GPIO_PINS(88);
+DECLARE_MSM_GPIO_PINS(89);
+DECLARE_MSM_GPIO_PINS(90);
+DECLARE_MSM_GPIO_PINS(91);
+DECLARE_MSM_GPIO_PINS(92);
+DECLARE_MSM_GPIO_PINS(93);
+DECLARE_MSM_GPIO_PINS(94);
+DECLARE_MSM_GPIO_PINS(95);
+DECLARE_MSM_GPIO_PINS(96);
+DECLARE_MSM_GPIO_PINS(97);
+DECLARE_MSM_GPIO_PINS(98);
+DECLARE_MSM_GPIO_PINS(99);
+DECLARE_MSM_GPIO_PINS(100);
+DECLARE_MSM_GPIO_PINS(101);
+DECLARE_MSM_GPIO_PINS(102);
+DECLARE_MSM_GPIO_PINS(103);
+DECLARE_MSM_GPIO_PINS(104);
+DECLARE_MSM_GPIO_PINS(105);
+DECLARE_MSM_GPIO_PINS(106);
+DECLARE_MSM_GPIO_PINS(107);
+DECLARE_MSM_GPIO_PINS(108);
+DECLARE_MSM_GPIO_PINS(109);
+
+enum kuno_functions {
+	msm_mux_gpio,
+	msm_mux_audio_ref_clk,
+	msm_mux_coex_uart,
+	msm_mux_ebi2_lcd_a,
+	msm_mux_ebi2_lcd_cs,
+	msm_mux_ebi2_lcd_reset,
+	msm_mux_ebi2_lcd_te,
+	msm_mux_emac_mdc,
+	msm_mux_emac_mdio,
+	msm_mux_emac_pps_in,
+	msm_mux_emac_ptp_aux,
+	msm_mux_emac_ptp_pps,
+	msm_mux_gcc_gp1_clk,
+	msm_mux_gcc_gp2_clk,
+	msm_mux_gcc_gp3_clk,
+	msm_mux_mi2s0_data0,
+	msm_mux_mi2s0_data1,
+	msm_mux_mi2s0_sck,
+	msm_mux_mi2s0_ws,
+	msm_mux_mi2s1_data0,
+	msm_mux_mi2s1_data1,
+	msm_mux_mi2s1_sck,
+	msm_mux_mi2s1_ws,
+	msm_mux_mi2s_mclk,
+	msm_mux_nav_gpio,
+	msm_mux_pci_e_rst,
+	msm_mux_pcie_clkreq_n,
+	msm_mux_pll_bist_sync,
+	msm_mux_pll_clk_aux,
+	msm_mux_qdss_cti_trig0,
+	msm_mux_qdss_cti_trig1,
+	msm_mux_qdss_gpio_traceclk,
+	msm_mux_qdss_gpio_tracectl,
+	msm_mux_qup0_se0,
+	msm_mux_qup0_se1,
+	msm_mux_qup0_se2,
+	msm_mux_qup0_se3_mira,
+	msm_mux_qup0_se3_mirb,
+	msm_mux_qup0_se4,
+	msm_mux_sdc4_clk,
+	msm_mux_sdc4_cmd,
+	msm_mux_sdc4_data,
+	msm_mux_sdc4_tb_trig,
+	msm_mux_sgmii_phy_intr,
+	msm_mux_spmi_coex_clk,
+	msm_mux_spmi_coex_data,
+	msm_mux_spmi_vgi_hwevent,
+	msm_mux_uim1_clk,
+	msm_mux_uim1_data,
+	msm_mux_uim1_present,
+	msm_mux_uim1_reset,
+	msm_mux_usb2phy_ac_en,
+	msm_mux_NA,
+};
+
+static const char * const gpio_groups[] = {
+	"gpio0", "gpio1", "gpio2", "gpio3", "gpio4", "gpio5", "gpio6", "gpio7",
+	"gpio8", "gpio9", "gpio10", "gpio11", "gpio12", "gpio13", "gpio14",
+	"gpio15", "gpio16", "gpio17", "gpio18", "gpio19", "gpio20", "gpio21",
+	"gpio22", "gpio23", "gpio24", "gpio25", "gpio26", "gpio27", "gpio28",
+	"gpio29", "gpio30", "gpio31", "gpio32", "gpio33", "gpio34", "gpio35",
+	"gpio36", "gpio37", "gpio38", "gpio39", "gpio40", "gpio41", "gpio42",
+	"gpio43", "gpio44", "gpio45", "gpio46", "gpio47", "gpio48", "gpio49",
+	"gpio50", "gpio51", "gpio52", "gpio53", "gpio54", "gpio55", "gpio56",
+	"gpio57", "gpio58", "gpio59", "gpio60", "gpio61", "gpio62", "gpio63",
+	"gpio64", "gpio65", "gpio66", "gpio67", "gpio68", "gpio69", "gpio70",
+	"gpio71", "gpio72", "gpio73", "gpio74", "gpio75", "gpio76", "gpio77",
+	"gpio78", "gpio79", "gpio80", "gpio81", "gpio82", "gpio83", "gpio84",
+	"gpio85", "gpio86", "gpio87", "gpio88", "gpio89", "gpio90", "gpio91",
+	"gpio92", "gpio93", "gpio94", "gpio95", "gpio96", "gpio97", "gpio98",
+	"gpio99", "gpio100", "gpio101", "gpio102", "gpio103", "gpio104",
+	"gpio105", "gpio106", "gpio107", "gpio108", "gpio109",
+};
+
+static const char * const audio_ref_clk_groups[] = {
+	"gpio62",
+};
+
+static const char * const coex_uart_groups[] = {
+	"gpio44", "gpio45",
+};
+
+static const char * const ebi2_lcd_a_groups[] = {
+	"gpio93",
+};
+
+static const char * const ebi2_lcd_cs_groups[] = {
+	"gpio94",
+};
+
+static const char * const ebi2_lcd_reset_groups[] = {
+	"gpio89",
+};
+
+static const char * const ebi2_lcd_te_groups[] = {
+	"gpio88",
+};
+
+static const char * const emac_mdc_groups[] = {
+	"gpio98",
+};
+
+static const char * const emac_mdio_groups[] = {
+	"gpio99",
+};
+
+static const char * const emac_pps_in_groups[] = {
+	"gpio88",
+};
+
+static const char * const emac_ptp_aux_groups[] = {
+	"gpio93", "gpio94",
+};
+
+static const char * const emac_ptp_pps_groups[] = {
+	"gpio93", "gpio94",
+};
+
+static const char * const gcc_gp1_clk_groups[] = {
+	"gpio34",
+};
+
+static const char * const gcc_gp2_clk_groups[] = {
+	"gpio46",
+};
+
+static const char * const gcc_gp3_clk_groups[] = {
+	"gpio35",
+};
+
+static const char * const mi2s0_data0_groups[] = {
+	"gpio13",
+};
+
+static const char * const mi2s0_data1_groups[] = {
+	"gpio14",
+};
+
+static const char * const mi2s0_sck_groups[] = {
+	"gpio15",
+};
+
+static const char * const mi2s0_ws_groups[] = {
+	"gpio12",
+};
+
+static const char * const mi2s1_data0_groups[] = {
+	"gpio17",
+};
+
+static const char * const mi2s1_data1_groups[] = {
+	"gpio18",
+};
+
+static const char * const mi2s1_sck_groups[] = {
+	"gpio19",
+};
+
+static const char * const mi2s1_ws_groups[] = {
+	"gpio16",
+};
+
+static const char * const mi2s_mclk_groups[] = {
+	"gpio62",
+};
+
+static const char * const nav_gpio_groups[] = {
+	"gpio31", "gpio32", "gpio33",
+};
+
+static const char * const pci_e_rst_groups[] = {
+	"gpio57",
+};
+
+static const char * const pcie_clkreq_n_groups[] = {
+	"gpio56",
+};
+
+static const char * const pll_bist_sync_groups[] = {
+	"gpio47",
+};
+
+static const char * const pll_clk_aux_groups[] = {
+	"gpio54",
+};
+
+static const char * const qdss_cti_trig0_groups[] = {
+	"gpio16", "gpio17", "gpio54", "gpio55", "gpio60", "gpio84", "gpio101",
+	"gpio102",
+};
+
+static const char * const qdss_cti_trig1_groups[] = {
+	"gpio16", "gpio17", "gpio54", "gpio55", "gpio65", "gpio65", "gpio66",
+	"gpio66", "gpio101", "gpio102",
+};
+
+static const char * const qdss_gpio_traceclk_groups[] = {
+	"gpio8",
+};
+
+static const char * const qdss_gpio_tracectl_groups[] = {
+	"gpio9",
+};
+
+static const char * const qup0_se0_groups[] = {
+	"gpio14", "gpio18", "gpio19", "gpio48", "gpio49", "gpio92", "gpio101",
+};
+
+static const char * const qup0_se1_groups[] = {
+	"gpio14", "gpio63", "gpio64", "gpio65", "gpio66", "gpio92", "gpio101",
+};
+
+static const char * const qup0_se2_groups[] = {
+	"gpio4", "gpio5", "gpio6", "gpio7", "gpio14", "gpio92", "gpio101",
+};
+
+static const char * const qup0_se3_mira_groups[] = {
+	"gpio8", "gpio9", "gpio14", "gpio16", "gpio17", "gpio92", "gpio101",
+};
+
+static const char * const qup0_se3_mirb_groups[] = {
+	"gpio12", "gpio13", "gpio14", "gpio15",
+};
+
+static const char * const qup0_se4_groups[] = {
+	"gpio10", "gpio11", "gpio14", "gpio80", "gpio81", "gpio92", "gpio101",
+};
+
+static const char * const sdc4_clk_groups[] = {
+	"gpio103",
+};
+
+static const char * const sdc4_cmd_groups[] = {
+	"gpio102",
+};
+
+static const char * const sdc4_data_groups[] = {
+	"gpio104", "gpio105", "gpio106", "gpio107",
+};
+
+static const char * const sdc4_tb_trig_groups[] = {
+	"gpio101",
+};
+
+static const char * const sgmii_phy_intr_groups[] = {
+	"gpio91",
+};
+
+static const char * const spmi_coex_clk_groups[] = {
+	"gpio76",
+};
+
+static const char * const spmi_coex_data_groups[] = {
+	"gpio75",
+};
+
+static const char * const spmi_vgi_hwevent_groups[] = {
+	"gpio78", "gpio79",
+};
+
+static const char * const uim1_clk_groups[] = {
+	"gpio3",
+};
+
+static const char * const uim1_data_groups[] = {
+	"gpio0",
+};
+
+static const char * const uim1_present_groups[] = {
+	"gpio1",
+};
+
+static const char * const uim1_reset_groups[] = {
+	"gpio2",
+};
+
+static const char * const usb2phy_ac_en_groups[] = {
+	"gpio90",
+};
+
+static const struct pinfunction kuno_functions[] = {
+	MSM_GPIO_PIN_FUNCTION(gpio),
+	MSM_PIN_FUNCTION(audio_ref_clk),
+	MSM_PIN_FUNCTION(coex_uart),
+	MSM_PIN_FUNCTION(ebi2_lcd_a),
+	MSM_PIN_FUNCTION(ebi2_lcd_cs),
+	MSM_PIN_FUNCTION(ebi2_lcd_reset),
+	MSM_PIN_FUNCTION(ebi2_lcd_te),
+	MSM_PIN_FUNCTION(emac_mdc),
+	MSM_PIN_FUNCTION(emac_mdio),
+	MSM_PIN_FUNCTION(emac_pps_in),
+	MSM_PIN_FUNCTION(emac_ptp_aux),
+	MSM_PIN_FUNCTION(emac_ptp_pps),
+	MSM_PIN_FUNCTION(gcc_gp1_clk),
+	MSM_PIN_FUNCTION(gcc_gp2_clk),
+	MSM_PIN_FUNCTION(gcc_gp3_clk),
+	MSM_PIN_FUNCTION(mi2s0_data0),
+	MSM_PIN_FUNCTION(mi2s0_data1),
+	MSM_PIN_FUNCTION(mi2s0_sck),
+	MSM_PIN_FUNCTION(mi2s0_ws),
+	MSM_PIN_FUNCTION(mi2s1_data0),
+	MSM_PIN_FUNCTION(mi2s1_data1),
+	MSM_PIN_FUNCTION(mi2s1_sck),
+	MSM_PIN_FUNCTION(mi2s1_ws),
+	MSM_PIN_FUNCTION(mi2s_mclk),
+	MSM_PIN_FUNCTION(nav_gpio),
+	MSM_PIN_FUNCTION(pci_e_rst),
+	MSM_PIN_FUNCTION(pcie_clkreq_n),
+	MSM_PIN_FUNCTION(pll_bist_sync),
+	MSM_PIN_FUNCTION(pll_clk_aux),
+	MSM_PIN_FUNCTION(qdss_cti_trig0),
+	MSM_PIN_FUNCTION(qdss_cti_trig1),
+	MSM_PIN_FUNCTION(qdss_gpio_traceclk),
+	MSM_PIN_FUNCTION(qdss_gpio_tracectl),
+	MSM_PIN_FUNCTION(qup0_se0),
+	MSM_PIN_FUNCTION(qup0_se1),
+	MSM_PIN_FUNCTION(qup0_se2),
+	MSM_PIN_FUNCTION(qup0_se3_mira),
+	MSM_PIN_FUNCTION(qup0_se3_mirb),
+	MSM_PIN_FUNCTION(qup0_se4),
+	MSM_PIN_FUNCTION(sdc4_clk),
+	MSM_PIN_FUNCTION(sdc4_cmd),
+	MSM_PIN_FUNCTION(sdc4_data),
+	MSM_PIN_FUNCTION(sdc4_tb_trig),
+	MSM_PIN_FUNCTION(sgmii_phy_intr),
+	MSM_PIN_FUNCTION(spmi_coex_clk),
+	MSM_PIN_FUNCTION(spmi_coex_data),
+	MSM_PIN_FUNCTION(spmi_vgi_hwevent),
+	MSM_PIN_FUNCTION(uim1_clk),
+	MSM_PIN_FUNCTION(uim1_data),
+	MSM_PIN_FUNCTION(uim1_present),
+	MSM_PIN_FUNCTION(uim1_reset),
+	MSM_PIN_FUNCTION(usb2phy_ac_en),
+};
+
+/* Every pin is maintained as a single group, and missing or non-existing pin
+ * would be maintained as dummy group to synchronize pin group index with
+ * pin descriptor registered with pinctrl core.
+ * Clients would not be able to request these dummy pin groups.
+ */
+static const struct msm_pingroup kuno_groups[] = {
+	[0] = PINGROUP(0, uim1_data, NA, NA, NA, NA, NA, NA, NA, NA),
+	[1] = PINGROUP(1, uim1_present, NA, NA, NA, NA, NA, NA, NA, NA),
+	[2] = PINGROUP(2, uim1_reset, NA, NA, NA, NA, NA, NA, NA, NA),
+	[3] = PINGROUP(3, uim1_clk, NA, NA, NA, NA, NA, NA, NA, NA),
+	[4] = PINGROUP(4, qup0_se2, NA, NA, NA, NA, NA, NA, NA, NA),
+	[5] = PINGROUP(5, qup0_se2, NA, NA, NA, NA, NA, NA, NA, NA),
+	[6] = PINGROUP(6, qup0_se2, NA, NA, NA, NA, NA, NA, NA, NA),
+	[7] = PINGROUP(7, qup0_se2, NA, NA, NA, NA, NA, NA, NA, NA),
+	[8] = PINGROUP(8, qup0_se3_mira, NA, qdss_gpio_traceclk, NA, NA, NA, NA, NA, NA),
+	[9] = PINGROUP(9, qup0_se3_mira, NA, qdss_gpio_tracectl, NA, NA, NA, NA, NA, NA),
+	[10] = PINGROUP(10, qup0_se4, NA, NA, NA, NA, NA, NA, NA, NA),
+	[11] = PINGROUP(11, qup0_se4, NA, NA, NA, NA, NA, NA, NA, NA),
+	[12] = PINGROUP(12, mi2s0_ws, qup0_se3_mirb, NA, NA, NA, NA, NA, NA, NA),
+	[13] = PINGROUP(13, mi2s0_data0, qup0_se3_mirb, NA, NA, NA, NA, NA, NA, NA),
+	[14] = PINGROUP(14, mi2s0_data1, qup0_se3_mirb, qup0_se0, qup0_se1, qup0_se2,
+			qup0_se3_mira, qup0_se4, NA, NA),
+	[15] = PINGROUP(15, mi2s0_sck, qup0_se3_mirb, NA, NA, NA, NA, NA, NA, NA),
+	[16] = PINGROUP(16, mi2s1_ws, qup0_se3_mira, qdss_cti_trig1, qdss_cti_trig0,
+			NA, NA, NA, NA, NA),
+	[17] = PINGROUP(17, mi2s1_data0, qup0_se3_mira, qdss_cti_trig1, qdss_cti_trig0,
+			NA, NA, NA, NA, NA),
+	[18] = PINGROUP(18, mi2s1_data1, qup0_se0, NA, NA, NA, NA, NA, NA, NA),
+	[19] = PINGROUP(19, mi2s1_sck, qup0_se0, NA, NA, NA, NA, NA, NA, NA),
+	[20] = PINGROUP(20, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[21] = PINGROUP(21, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[22] = PINGROUP(22, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[23] = PINGROUP(23, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[24] = PINGROUP(24, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[25] = PINGROUP(25, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[26] = PINGROUP(26, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[27] = PINGROUP(27, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[28] = PINGROUP(28, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[29] = PINGROUP(29, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[30] = PINGROUP(30, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[31] = PINGROUP(31, nav_gpio, NA, NA, NA, NA, NA, NA, NA, NA),
+	[32] = PINGROUP(32, nav_gpio, NA, NA, NA, NA, NA, NA, NA, NA),
+	[33] = PINGROUP(33, nav_gpio, NA, NA, NA, NA, NA, NA, NA, NA),
+	[34] = PINGROUP(34, NA, gcc_gp1_clk, NA, NA, NA, NA, NA, NA, NA),
+	[35] = PINGROUP(35, NA, NA, gcc_gp3_clk, NA, NA, NA, NA, NA, NA),
+	[36] = PINGROUP(36, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[37] = PINGROUP(37, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[38] = PINGROUP(38, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[39] = PINGROUP(39, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[40] = PINGROUP(40, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[41] = PINGROUP(41, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[42] = PINGROUP(42, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[43] = PINGROUP(43, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[44] = PINGROUP(44, coex_uart, NA, NA, NA, NA, NA, NA, NA, NA),
+	[45] = PINGROUP(45, coex_uart, NA, NA, NA, NA, NA, NA, NA, NA),
+	[46] = PINGROUP(46, NA, NA, NA, gcc_gp2_clk, NA, NA, NA, NA, NA),
+	[47] = PINGROUP(47, NA, pll_bist_sync, NA, NA, NA, NA, NA, NA, NA),
+	[48] = PINGROUP(48, qup0_se0, NA, NA, NA, NA, NA, NA, NA, NA),
+	[49] = PINGROUP(49, qup0_se0, NA, NA, NA, NA, NA, NA, NA, NA),
+	[50] = PINGROUP(50, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[51] = PINGROUP(51, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[52] = PINGROUP(52, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[53] = PINGROUP(53, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[54] = PINGROUP(54, qdss_cti_trig1, qdss_cti_trig0, pll_clk_aux, NA, NA, NA, NA, NA, NA),
+	[55] = PINGROUP(55, qdss_cti_trig1, qdss_cti_trig0, NA, NA, NA, NA, NA, NA, NA),
+	[56] = PINGROUP(56, pcie_clkreq_n, NA, NA, NA, NA, NA, NA, NA, NA),
+	[57] = PINGROUP(57, pci_e_rst, NA, NA, NA, NA, NA, NA, NA, NA),
+	[58] = PINGROUP(58, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[59] = PINGROUP(59, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[60] = PINGROUP(60, qdss_cti_trig0, NA, NA, NA, NA, NA, NA, NA, NA),
+	[61] = PINGROUP(61, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[62] = PINGROUP(62, mi2s_mclk, audio_ref_clk, NA, NA, NA, NA, NA, NA, NA),
+	[63] = PINGROUP(63, qup0_se1, NA, NA, NA, NA, NA, NA, NA, NA),
+	[64] = PINGROUP(64, qup0_se1, NA, NA, NA, NA, NA, NA, NA, NA),
+	[65] = PINGROUP(65, qup0_se1, qdss_cti_trig1, qdss_cti_trig1, NA, NA, NA, NA, NA, NA),
+	[66] = PINGROUP(66, qup0_se1, qdss_cti_trig1, qdss_cti_trig1, NA, NA, NA, NA, NA, NA),
+	[67] = PINGROUP(67, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[68] = PINGROUP(68, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[69] = PINGROUP(69, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[70] = PINGROUP(70, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[71] = PINGROUP(71, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[72] = PINGROUP(72, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[73] = PINGROUP(73, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[74] = PINGROUP(74, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[75] = PINGROUP(75, spmi_coex_data, NA, NA, NA, NA, NA, NA, NA, NA),
+	[76] = PINGROUP(76, spmi_coex_clk, NA, NA, NA, NA, NA, NA, NA, NA),
+	[77] = PINGROUP(77, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[78] = PINGROUP(78, spmi_vgi_hwevent, NA, NA, NA, NA, NA, NA, NA, NA),
+	[79] = PINGROUP(79, spmi_vgi_hwevent, NA, NA, NA, NA, NA, NA, NA, NA),
+	[80] = PINGROUP(80, qup0_se4, NA, NA, NA, NA, NA, NA, NA, NA),
+	[81] = PINGROUP(81, qup0_se4, NA, NA, NA, NA, NA, NA, NA, NA),
+	[82] = PINGROUP(82, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[83] = PINGROUP(83, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[84] = PINGROUP(84, qdss_cti_trig0, NA, NA, NA, NA, NA, NA, NA, NA),
+	[85] = PINGROUP(85, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[86] = PINGROUP(86, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[87] = PINGROUP(87, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[88] = PINGROUP(88, ebi2_lcd_te, emac_pps_in, NA, NA, NA, NA, NA, NA, NA),
+	[89] = PINGROUP(89, ebi2_lcd_reset, NA, NA, NA, NA, NA, NA, NA, NA),
+	[90] = PINGROUP(90, usb2phy_ac_en, NA, NA, NA, NA, NA, NA, NA, NA),
+	[91] = PINGROUP(91, sgmii_phy_intr, NA, NA, NA, NA, NA, NA, NA, NA),
+	[92] = PINGROUP(92, qup0_se0, qup0_se1, qup0_se2, qup0_se3_mira, qup0_se4, NA, NA, NA, NA),
+	[93] = PINGROUP(93, ebi2_lcd_a, emac_ptp_pps, emac_ptp_aux, NA, NA, NA, NA, NA, NA),
+	[94] = PINGROUP(94, ebi2_lcd_cs, emac_ptp_pps, emac_ptp_aux, NA, NA, NA, NA, NA, NA),
+	[95] = PINGROUP(95, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[96] = PINGROUP(96, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[97] = PINGROUP(97, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[98] = PINGROUP(98, emac_mdc, NA, NA, NA, NA, NA, NA, NA, NA),
+	[99] = PINGROUP(99, emac_mdio, NA, NA, NA, NA, NA, NA, NA, NA),
+	[100] = PINGROUP(100, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[101] = PINGROUP(101, sdc4_tb_trig, qdss_cti_trig1, qdss_cti_trig0, qup0_se0,
+			qup0_se1, qup0_se2, qup0_se3_mira, qup0_se4, NA),
+	[102] = PINGROUP(102, sdc4_cmd, qdss_cti_trig1, qdss_cti_trig0, NA, NA, NA, NA, NA, NA),
+	[103] = PINGROUP(103, sdc4_clk, NA, NA, NA, NA, NA, NA, NA, NA),
+	[104] = PINGROUP(104, sdc4_data, NA, NA, NA, NA, NA, NA, NA, NA),
+	[105] = PINGROUP(105, sdc4_data, NA, NA, NA, NA, NA, NA, NA, NA),
+	[106] = PINGROUP(106, sdc4_data, NA, NA, NA, NA, NA, NA, NA, NA),
+	[107] = PINGROUP(107, sdc4_data, NA, NA, NA, NA, NA, NA, NA, NA),
+	[108] = PINGROUP(108, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	[109] = PINGROUP(109, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+};
+
+static const struct msm_gpio_wakeirq_map kuno_pdc_map[] = {
+	{ 1, 62 }, { 2, 83 }, { 4, 59 }, { 5, 107 }, { 6, 112 }, { 7, 119 },
+	{ 8, 123 }, { 10, 52 }, { 11, 73 }, { 12, 74 }, { 13, 75 }, { 14, 76 },
+	{ 15, 77 }, { 16, 81 }, { 17, 82 }, { 18, 80 }, { 19, 100 }, { 21, 88 },
+	{ 22, 99 }, { 23, 84 }, { 24, 85 }, { 25, 97 }, { 26, 86 }, { 27, 102 },
+	{ 28, 87 }, { 35, 103 }, { 43, 90 }, { 44, 60 }, { 45, 61 }, { 46, 104 },
+	{ 47, 89 }, { 48, 105 }, { 49, 106 }, { 50, 101 }, { 52, 109 }, { 53, 79 },
+	{ 54, 110 }, { 55, 111 }, { 56, 78 }, { 57, 71 }, { 60, 113 }, { 61, 114 },
+	{ 63, 115 }, { 64, 116 }, { 65, 57 }, { 66, 117 }, { 68, 64 }, { 69, 118 },
+	{ 71, 108 }, { 73, 120 }, { 74, 121 }, { 76, 47 }, { 77, 122 }, { 78, 65 },
+	{ 79, 66 }, { 80, 124 }, { 81, 125 }, { 82, 126 }, { 83, 127 }, { 84, 93 },
+	{ 85, 128 }, { 86, 129 }, { 87, 70 }, { 88, 130 }, { 96, 68 }, { 98, 50 },
+	{ 99, 67 }, { 100, 51 }, { 101, 53 }, { 102, 54 }, { 103, 98 }, { 104, 91 },
+	{ 105, 69 }, { 106, 55 }, { 107, 56 }, { 109, 72 },
+};
+
+static const struct msm_pinctrl_soc_data kuno_tlmm = {
+	.pins = kuno_pins,
+	.npins = ARRAY_SIZE(kuno_pins),
+	.functions = kuno_functions,
+	.nfunctions = ARRAY_SIZE(kuno_functions),
+	.groups = kuno_groups,
+	.ngroups = ARRAY_SIZE(kuno_groups),
+	.ngpios = 110,
+	.wakeirq_map = kuno_pdc_map,
+	.nwakeirq_map = ARRAY_SIZE(kuno_pdc_map),
+};
+
+static int kuno_tlmm_probe(struct platform_device *pdev)
+{
+	return msm_pinctrl_probe(pdev, &kuno_tlmm);
+}
+
+static const struct of_device_id kuno_tlmm_of_match[] = {
+	{ .compatible = "qcom,kuno-tlmm", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, kuno_tlmm_of_match);
+
+static struct platform_driver kuno_tlmm_driver = {
+	.driver = {
+		.name = "kuno-tlmm",
+		.of_match_table = kuno_tlmm_of_match,
+	},
+	.probe = kuno_tlmm_probe,
+};
+
+static int __init kuno_tlmm_init(void)
+{
+	return platform_driver_register(&kuno_tlmm_driver);
+}
+arch_initcall(kuno_tlmm_init);
+
+static void __exit kuno_tlmm_exit(void)
+{
+	platform_driver_unregister(&kuno_tlmm_driver);
+}
+module_exit(kuno_tlmm_exit);
+
+MODULE_DESCRIPTION("QTI Kuno TLMM driver");
+MODULE_LICENSE("GPL");

-- 
2.43.0

