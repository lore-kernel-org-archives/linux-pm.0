Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A519F484241
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787848769; cv=none; b=g/zNm77GuQcU7uBJQmKVJ/i/mO/l+Y1H4H672RDZYifr36QZKkPRp80bkJLtcS/uXRUtG3pVwYWfN9bwYb/cfdsF9LgQPP+S7s8zv1Fi7k4dEBhu5Xiu0GXv5o7DtGQcXqFZqfwKRwmAUjIzn2KMjZ/cQvgYd05X/zK4QcU5riw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787848769; c=relaxed/simple;
	bh=YMt01tffizd/QItWpTO+o5zLFgJYC/uKbLx8J6+OhjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sWTT8Gx2MlvJM/ofYm2p/43T2YZz4XQEHBvL4vUBmNgt71yeQj/SmdH3SgMSe0lmypk6gNoAV0qetUak5WRv0tXz57jcTdKba4ijBlnE1/pCTc1i+d3cROquzFKNBEZhbskEVIyoyBs8LfuqVTPSLivNM+fmLtnA7cN/VGP4iog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pDEZ1DU6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UlvWt0Va; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pDEZ1DU6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UlvWt0Va"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RGIMdt707841
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 16:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jaxPBtFt4fSnEV+87SUaJLo7bEl7ueivESahSDtJv3A=; b=pDEZ1DU6MntP8Jou
	G57gUIJqeFATNGmhLDF6mHzAD5H5gaig2xC+aFAt1EIRYYqTI+cwq8aJgG5D0ghq
	snSHHAoPOyc0NLfiCspDKsTVUI/MFS3VTsJQlYa6zpAc4LeLGg0Hnt1cWjYRlPos
	aTjOf/nXhInGKrmu2zeiPL67cmK3X0rtCYgyi4t68o2jxq7Et4t6TFKZFIMYae9U
	nOvJGJQr+5eaoEFjxfSMtsVxqddhazeSKgIX8c9eo5GPA5wOfbQP5300EfNMYv4S
	BLrqi/PphtkXx7F2Q4bJzgDvTGNu5zEhP9KYyFF/nbWLmR8zoDoRCGPv2MaxKnT3
	gyx1FA==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4garn0g2p1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 16:39:24 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e9ee20bde0so144086a34.2
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 09:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787848764; x=1788453564; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jaxPBtFt4fSnEV+87SUaJLo7bEl7ueivESahSDtJv3A=;
        b=UlvWt0VaAohThAwCi8/6MLxYw+vgTNHHfrIElaURTg1QPHQsi8HuCrnB6r/F7FJYN9
         Ke4BZA8/g3IC58WlbOtOcu92bFkXfJrH3Fn4X3LIqGLAnVfoI29M6KkBSEhg0YFBH7Pz
         lKkwmFg5Uk7SAZcR/nojSgxOr+J6y2qDAFL3RyHveRQQ9uC6OdC2l3hxCtZSRfceugSB
         PuN+kHg79NpDNiUQi+K1uOHHW2ZuYuPsmIQXnys9c9are4Q3LDptIch4YjY5vUaM/4iW
         H1iCErpitA0rzRtDAkIIe+KKX7CXSONXQwR0ym1OOjpiKHxyJTboCRBfZiXvNCTa1+N9
         PLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787848764; x=1788453564;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jaxPBtFt4fSnEV+87SUaJLo7bEl7ueivESahSDtJv3A=;
        b=AeTbMoP9z6ergHqjY4KPhM0iDUeTMhJhmIP3Xu82SL1BBcKG62y2lGUFnkN6eOtjEK
         Z+QV+3fIjzO7OckgPtOShox2jITPItQlBwwtPayyFZFrQfZFoAwS3ZeA3gOlA1d/52oY
         8hKBxa0pTj58mt27lsn57/jcdVTvHylFFSyy1slgnbBt9KZtBcWXb+LwkqVCgwGZzj+P
         afVG1BVgXPVhjW97B+CQGNqzS+2X8jnHX6wVlId+tUlR9IofDZ/ERlOdsOWX/+xjBoY6
         xHZWymYuXCfXG+6uiARt4i/MmfWbL4puueJw0jN4/e9u9BIWL6SkTtR2POTkJ2WYsw4b
         9SKQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpf0xoz8AegYi9Keskx1vrNi6pESeRqaESCuerZUebdQS/rbq5jYA7D99Dc48r3AsYA25ynUEp/mw==@vger.kernel.org
X-Gm-Message-State: AFuF++lvYRXLuff4K35DsezgcKVAKHstfyZ0uURvVLSUhiKCZdVp7iuM
	iLp21kiLH5m7FPH6OnLCamqnMh0ewoEktq0wrRXP3SWNnLetJfwoNQiYzDbSgPKlvtRL6wfRYvQ
	2RokeDxf8z4FH/1EOlVEDsdnX8WEF7uWUtyubTR/ShLWmj/U4tspUyvb5geYSZA==
X-Gm-Gg: AR+sD13nj6NXgQCWQm9NrKQssujOjhC78aqmH/lvBzu/hpg+EYbHsWYDbejbX5TlJdG
	C94N7tTS5BjdWDDwvv77/4hqVPwqsH8/MjW1oEUBfDJJtG/9uYyX5fqnSlX/q/oIn/0u/KPho3L
	FLm1djTlq8lLgKX06rJXH99eqmxwDBGNhChyqn69g7FiewKn+67bYFs3Z6/G2cac1kDsrQIV/Uh
	oK/4Dl7trxmLqWv+1zI7btVfYxy6Q92u51aj0Ma8xP1ve3+0UioqKFe5TinElPShV/9epXhph7/
	Tj+HLzK3KtiVVkMcD594ESmKXDgLkSnUPVddbta1jhQvMMxn6pqM1dcg5nzW8am5o9iXYfXnMz/
	A+IfeHb8Mye4mAmSYUYOa7aR36wZV2ABlThSm//TIAPu1ElLM3KK3x0ZrNT1Tth0ynrTmJPyzZM
	2U9vFCIYv5zKLFGWmnSI1Sk+8=
X-Received: by 2002:a05:6820:f0f1:b0:6b1:8f51:e174 with SMTP id 006d021491bc7-6b1a0566739mr12558068eaf.29.1787848763381;
        Thu, 27 Aug 2026 09:39:23 -0700 (PDT)
X-Received: by 2002:a05:6820:f0f1:b0:6b1:8f51:e174 with SMTP id 006d021491bc7-6b1a0566739mr12557978eaf.29.1787848762747;
        Thu, 27 Aug 2026 09:39:22 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1a24bce78sm4253171eaf.3.2026.08.27.09.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:39:22 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 22:08:08 +0530
Subject: [PATCH v4 07/15] interconnect: qcom: Add Kuno interconnect
 provider driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-kuno-soc-support-v4-7-dd34f235fc1a@oss.qualcomm.com>
References: <20260827-kuno-soc-support-v4-0-dd34f235fc1a@oss.qualcomm.com>
In-Reply-To: <20260827-kuno-soc-support-v4-0-dd34f235fc1a@oss.qualcomm.com>
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787848688; l=26248;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=YMt01tffizd/QItWpTO+o5zLFgJYC/uKbLx8J6+OhjU=;
 b=6AAtGYzhrKnwNe7GFXety7pFvGn4l5r9EjrEBpJiCwpfep8TlLthsW74aksQ7bwWvi8WjEc7+
 363vmSP8P6WDIHR7sHSHN0xdlXGkvPz0XEsBwAJd5ryaGytELCOkuwy
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE0MCBTYWx0ZWRfX/ktWjAftTX/V
 MZBSThCWmCXLTshb+aM+25BMVBQea7+lQZBa+X6KZnUQWVX08Mga16M3P4PZOsWDotUvKXk/Xvm
 jQM5TSk7C9FdkQu3Zw/AGABhlU4EyT1e38DRtqekH4XAxgiq+DH0txt5wKz8MZymwso2qdrzqA+
 MsTsGnHdIubv+oF8CjZ3dRoCxxGcm96AEBwsdu+auNTLIXppsYbFjCuipsiwMlKm2B9lMbCix6r
 inX1ChSy9+wRBkRHINl6sm687I2h2lToK5czod0Ab0K9vRclwoYBKdQdMUCz2oza9y2txRDevJ2
 wm5OL07qKuTxLN1VuzyCDqOyhlAXd/vD8eHvXI6x2JuHDS6qjiSqMK30Rxxtqjo+IEz9elML71V
 v1S8p5zkj5VdL42oKK1tdm06uGqyq9+yFFcdNjOepzhExYNHTiQeWJjFBibw+Xly+vNC6h1QETv
 pQqvocKoz/5FulLDyLQ==
X-Proofpoint-GUID: u4bHW5q2Q0_-gaUft576RK3AKD2ILPc0
X-Authority-Analysis: v=2.4 cv=C+3ZDwP+ c=1 sm=1 tr=0 ts=6a90683c cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=hP8eNrtOcc-Xm2DFYy4A:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-ORIG-GUID: u4bHW5q2Q0_-gaUft576RK3AKD2ILPc0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE0MCBTYWx0ZWRfX3Cfk6PiDGv3J
 dB/wVQVd2SzquUGB1ybkT01XCaMKK9LBwSXOjHIzwHrOwmImFuFE5jUeCajgkEacrD1w2qJxG3X
 PHZyWEsvVerA/iptXEeA92T+y/2nLjs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270140

Add the interconnect provider driver for the Qualcomm Kuno SoC to
enable bus bandwidth voting on the platform. This includes the
aggre-noc and cnoc-main NoC instances with their associated BCM
nodes.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 drivers/interconnect/qcom/Kconfig  |  13 +
 drivers/interconnect/qcom/Makefile |   2 +
 drivers/interconnect/qcom/kuno.c   | 988 +++++++++++++++++++++++++++++++++++++
 3 files changed, 1003 insertions(+)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index b3187acf90b8..6e6b80f22dbd 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -47,6 +47,19 @@ config INTERCONNECT_QCOM_KAANAPALI
 	  This is a driver for the Qualcomm Network-on-Chip on kaanapali-based
 	  platforms.
 
+config INTERCONNECT_QCOM_KUNO
+	tristate "Qualcomm Kuno interconnect driver"
+	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM || COMPILE_TEST
+	select INTERCONNECT_QCOM_RPMH
+	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on kuno-based
+	  platforms. The interconnect provider collects and aggregates the
+	  consumer bandwidth requests to satisfy constraints placed on the
+	  Network-on-Chip performance states.
+
 config INTERCONNECT_QCOM_MAILI
 	tristate "Qualcomm MAILI interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index 5f139a370bbe..a71478aaf591 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -8,6 +8,7 @@ qnoc-eliza-objs				:= eliza.o
 qnoc-glymur-objs			:= glymur.o
 qnoc-hawi-objs				:= hawi.o
 qnoc-kaanapali-objs			:= kaanapali.o
+qnoc-kuno-objs				:= kuno.o
 qnoc-maili-objs				:= maili.o
 qnoc-milos-objs				:= milos.o
 qnoc-msm8909-objs			:= msm8909.o
@@ -57,6 +58,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM_ELIZA) += qnoc-eliza.o
 obj-$(CONFIG_INTERCONNECT_QCOM_GLYMUR) += qnoc-glymur.o
 obj-$(CONFIG_INTERCONNECT_QCOM_HAWI) += qnoc-hawi.o
 obj-$(CONFIG_INTERCONNECT_QCOM_KAANAPALI) += qnoc-kaanapali.o
+obj-$(CONFIG_INTERCONNECT_QCOM_KUNO) += qnoc-kuno.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MAILI) += qnoc-maili.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MILOS) += qnoc-milos.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MSM8909) += qnoc-msm8909.o
diff --git a/drivers/interconnect/qcom/kuno.c b/drivers/interconnect/qcom/kuno.c
new file mode 100644
index 000000000000..546622cf8cea
--- /dev/null
+++ b/drivers/interconnect/qcom/kuno.c
@@ -0,0 +1,988 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/device.h>
+#include <linux/interconnect.h>
+#include <linux/interconnect-provider.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/interconnect/qcom,kuno.h>
+
+#include "bcm-voter.h"
+#include "icc-rpmh.h"
+
+static struct qcom_icc_node qup0_core_slave = {
+	.name = "qup0_core_slave",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ahb2_phy = {
+	.name = "qhs_ahb2_phy",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_aoss = {
+	.name = "qhs_aoss",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_apss = {
+	.name = "qhs_apss",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_audio = {
+	.name = "qhs_audio",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_clk_ctl = {
+	.name = "qhs_clk_ctl",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_cpr_cx = {
+	.name = "qhs_cpr_cx",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_cpr_mxa = {
+	.name = "qhs_cpr_mxa",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_cpr_mxc = {
+	.name = "qhs_cpr_mxc",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_crypto_cfg = {
+	.name = "qhs_crypto_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_emac0_cfg = {
+	.name = "qhs_emac0_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_imem_cfg = {
+	.name = "qhs_imem_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ipa = {
+	.name = "qhs_ipa",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ipc_router = {
+	.name = "qhs_ipc_router",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_mss_cfg = {
+	.name = "qhs_mss_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie0_cfg = {
+	.name = "qhs_pcie0_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie_rscc = {
+	.name = "qhs_pcie_rscc",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pdm = {
+	.name = "qhs_pdm",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pmu_wrapper_cfg = {
+	.name = "qhs_pmu_wrapper_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_prng = {
+	.name = "qhs_prng",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qdss_cfg = {
+	.name = "qhs_qdss_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qpic = {
+	.name = "qhs_qpic",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qup0 = {
+	.name = "qhs_qup0",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_sdc4 = {
+	.name = "qhs_sdc4",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_spmi_vgi_coex = {
+	.name = "qhs_spmi_vgi_coex",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_tcsr = {
+	.name = "qhs_tcsr",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_tlmm = {
+	.name = "qhs_tlmm",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_tme_cfg = {
+	.name = "qhs_tme_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_usb3 = {
+	.name = "qhs_usb3",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
+	.name = "qhs_vsense_ctrl_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qss_anoc_throttle_cfg = {
+	.name = "qss_anoc_throttle_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qxs_boot_imem = {
+	.name = "qxs_boot_imem",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qxs_imem = {
+	.name = "qxs_imem",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_qdss_stm = {
+	.name = "xs_qdss_stm",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_sys_tcu_cfg = {
+	.name = "xs_sys_tcu_cfg",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_lagg = {
+	.name = "qhs_lagg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_mccc_master = {
+	.name = "qhs_mccc_master",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node ebi = {
+	.name = "ebi",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node srvc_memnoc = {
+	.name = "srvc_memnoc",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_pcie_0 = {
+	.name = "xs_pcie_0",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qup0_core_master = {
+	.name = "qup0_core_master",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = { &qup0_core_slave },
+};
+
+static struct qcom_icc_node qnm_cnoc = {
+	.name = "qnm_cnoc",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 2,
+	.link_nodes = { &qhs_lagg, &qhs_mccc_master },
+};
+
+static struct qcom_icc_node llcc_mc = {
+	.name = "llcc_mc",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = { &ebi },
+};
+
+static struct qcom_icc_node qnm_memnoc_cfg = {
+	.name = "qnm_memnoc_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = { &srvc_memnoc },
+};
+
+static struct qcom_icc_node qnm_memnoc_pcie = {
+	.name = "qnm_memnoc_pcie",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.link_nodes = { &xs_pcie_0 },
+};
+
+static struct qcom_icc_node xm_ipa2pcie = {
+	.name = "xm_ipa2pcie",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.link_nodes = { &xs_pcie_0 },
+};
+
+static struct qcom_icc_node qns_ddrss_cfg = {
+	.name = "qns_ddrss_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = { &qnm_cnoc },
+};
+
+static struct qcom_icc_node qns_llcc = {
+	.name = "qns_llcc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = { &llcc_mc },
+};
+
+static struct qcom_icc_node qns_pcie = {
+	.name = "qns_pcie",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.link_nodes = { &qnm_memnoc_pcie },
+};
+
+static struct qcom_icc_node qhm_pcie_rscc = {
+	.name = "qhm_pcie_rscc",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 34,
+	.link_nodes = { &qhs_ahb2_phy, &qhs_aoss,
+			&qhs_apss, &qhs_audio,
+			&qhs_clk_ctl, &qhs_cpr_cx,
+			&qhs_cpr_mxa, &qhs_cpr_mxc,
+			&qhs_crypto_cfg, &qhs_emac0_cfg,
+			&qhs_imem_cfg, &qhs_ipa,
+			&qhs_ipc_router, &qhs_mss_cfg,
+			&qhs_pcie0_cfg, &qhs_pdm,
+			&qhs_pmu_wrapper_cfg, &qhs_prng,
+			&qhs_qdss_cfg, &qhs_qpic,
+			&qhs_qup0, &qhs_sdc4,
+			&qhs_spmi_vgi_coex, &qhs_tcsr,
+			&qhs_tlmm, &qhs_tme_cfg,
+			&qhs_usb3, &qhs_vsense_ctrl_cfg,
+			&qns_ddrss_cfg, &qss_anoc_throttle_cfg,
+			&qxs_boot_imem, &qxs_imem,
+			&xs_qdss_stm, &xs_sys_tcu_cfg },
+};
+
+static struct qcom_icc_node qnm_memnoc_cnoc = {
+	.name = "qnm_memnoc_cnoc",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 35,
+	.link_nodes = { &qhs_ahb2_phy, &qhs_aoss,
+			&qhs_apss, &qhs_audio,
+			&qhs_clk_ctl, &qhs_cpr_cx,
+			&qhs_cpr_mxa, &qhs_cpr_mxc,
+			&qhs_crypto_cfg, &qhs_emac0_cfg,
+			&qhs_imem_cfg, &qhs_ipa,
+			&qhs_ipc_router, &qhs_mss_cfg,
+			&qhs_pcie0_cfg, &qhs_pcie_rscc,
+			&qhs_pdm, &qhs_pmu_wrapper_cfg,
+			&qhs_prng, &qhs_qdss_cfg,
+			&qhs_qpic, &qhs_qup0,
+			&qhs_sdc4, &qhs_spmi_vgi_coex,
+			&qhs_tcsr, &qhs_tlmm,
+			&qhs_tme_cfg, &qhs_usb3,
+			&qhs_vsense_ctrl_cfg, &qns_ddrss_cfg,
+			&qss_anoc_throttle_cfg, &qxs_boot_imem,
+			&qxs_imem, &xs_qdss_stm,
+			&xs_sys_tcu_cfg },
+};
+
+static struct qcom_icc_node qns_memnoc_cnoc = {
+	.name = "qns_memnoc_cnoc",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.link_nodes = { &qnm_memnoc_cnoc },
+};
+
+static struct qcom_icc_node alm_sys_tcu = {
+	.name = "alm_sys_tcu",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.link_nodes = { &qns_llcc, &qns_memnoc_cnoc },
+};
+
+static struct qcom_icc_node qnm_mdsp = {
+	.name = "qnm_mdsp",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 3,
+	.link_nodes = { &qns_llcc, &qns_memnoc_cnoc,
+			&qns_pcie },
+};
+
+static struct qcom_icc_node qnm_pcie = {
+	.name = "qnm_pcie",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.link_nodes = { &qns_llcc, &qns_memnoc_cnoc },
+};
+
+static struct qcom_icc_node qnm_snoc_sf = {
+	.name = "qnm_snoc_sf",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.link_nodes = { &qns_llcc, &qns_memnoc_cnoc },
+};
+
+static struct qcom_icc_node xm_apps0 = {
+	.name = "xm_apps0",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 3,
+	.link_nodes = { &qns_llcc, &qns_memnoc_cnoc,
+			&qns_pcie },
+};
+
+static struct qcom_icc_node qns_pcie_memnoc = {
+	.name = "qns_pcie_memnoc",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.link_nodes = { &qnm_pcie },
+};
+
+static struct qcom_icc_node qns_memnoc_sf = {
+	.name = "qns_memnoc_sf",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.link_nodes = { &qnm_snoc_sf },
+};
+
+static struct qcom_icc_node xm_pcie3_0 = {
+	.name = "xm_pcie3_0",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.link_nodes = { &qns_pcie_memnoc },
+};
+
+static struct qcom_icc_node qhm_cpucp = {
+	.name = "qhm_cpucp",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = { &qns_memnoc_sf },
+};
+
+static struct qcom_icc_node qnm_aggre_noc = {
+	.name = "qnm_aggre_noc",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.link_nodes = { &qns_memnoc_sf, &xs_pcie_0 },
+};
+
+static struct qcom_icc_node qnm_cnoc_datapath = {
+	.name = "qnm_cnoc_datapath",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 2,
+	.link_nodes = { &qns_memnoc_sf, &xs_pcie_0 },
+};
+
+static struct qcom_icc_node qxm_mss_nav_ce = {
+	.name = "qxm_mss_nav_ce",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.link_nodes = { &qns_memnoc_sf, &xs_pcie_0 },
+};
+
+static struct qcom_icc_node qxm_tme = {
+	.name = "qxm_tme",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.link_nodes = { &qns_memnoc_sf, &xs_pcie_0 },
+};
+
+static struct qcom_icc_node qns_a1noc = {
+	.name = "qns_a1noc",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.link_nodes = { &qnm_aggre_noc },
+};
+
+static struct qcom_icc_node qns_snoc_datapath = {
+	.name = "qns_snoc_datapath",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = { &qnm_cnoc_datapath },
+};
+
+static struct qcom_icc_node qhm_audio = {
+	.name = "qhm_audio",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = { &qns_a1noc },
+};
+
+static struct qcom_icc_node qhm_qdss_bam = {
+	.name = "qhm_qdss_bam",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = { &qns_a1noc },
+};
+
+static struct qcom_icc_node qhm_qpic = {
+	.name = "qhm_qpic",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = { &qns_a1noc },
+};
+
+static struct qcom_icc_node qhm_qup0 = {
+	.name = "qhm_qup0",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = { &qns_a1noc },
+};
+
+static struct qcom_icc_node qxm_crypto = {
+	.name = "qxm_crypto",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.link_nodes = { &qns_a1noc },
+};
+
+static struct qcom_icc_node qxm_ipa = {
+	.name = "qxm_ipa",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.link_nodes = { &qns_a1noc },
+};
+
+static struct qcom_icc_node xm_emac_0 = {
+	.name = "xm_emac_0",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.link_nodes = { &qns_a1noc },
+};
+
+static struct qcom_icc_node xm_qdss_etr0 = {
+	.name = "xm_qdss_etr0",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.link_nodes = { &qns_a1noc },
+};
+
+static struct qcom_icc_node xm_qdss_etr1 = {
+	.name = "xm_qdss_etr1",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.link_nodes = { &qns_a1noc },
+};
+
+static struct qcom_icc_node xm_sdc4 = {
+	.name = "xm_sdc4",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.link_nodes = { &qns_a1noc },
+};
+
+static struct qcom_icc_node xm_usb3 = {
+	.name = "xm_usb3",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.link_nodes = { &qns_a1noc },
+};
+
+static struct qcom_icc_node xm_qdss_dap = {
+	.name = "xm_qdss_dap",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 36,
+	.link_nodes = { &qhs_ahb2_phy, &qhs_aoss,
+			&qhs_apss, &qhs_audio,
+			&qhs_clk_ctl, &qhs_cpr_cx,
+			&qhs_cpr_mxa, &qhs_cpr_mxc,
+			&qhs_crypto_cfg, &qhs_emac0_cfg,
+			&qhs_imem_cfg, &qhs_ipa,
+			&qhs_ipc_router, &qhs_mss_cfg,
+			&qhs_pcie0_cfg, &qhs_pcie_rscc,
+			&qhs_pdm, &qhs_pmu_wrapper_cfg,
+			&qhs_prng, &qhs_qdss_cfg,
+			&qhs_qpic, &qhs_qup0,
+			&qhs_sdc4, &qhs_spmi_vgi_coex,
+			&qhs_tcsr, &qhs_tlmm,
+			&qhs_tme_cfg, &qhs_usb3,
+			&qhs_vsense_ctrl_cfg, &qns_ddrss_cfg,
+			&qns_snoc_datapath, &qss_anoc_throttle_cfg,
+			&qxs_boot_imem, &qxs_imem,
+			&xs_qdss_stm, &xs_sys_tcu_cfg },
+};
+
+static struct qcom_icc_bcm bcm_acv = {
+	.name = "ACV",
+	.enable_mask = 0x8,
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_ce0 = {
+	.name = "CE0",
+	.num_nodes = 1,
+	.nodes = { &qxm_crypto },
+};
+
+static struct qcom_icc_bcm bcm_cn0 = {
+	.name = "CN0",
+	.keepalive = true,
+	.enable_mask = 0x1,
+	.num_nodes = 39,
+	.nodes = { &qhm_pcie_rscc, &qnm_memnoc_cnoc,
+		   &xm_qdss_dap, &qhs_ahb2_phy,
+		   &qhs_aoss, &qhs_apss,
+		   &qhs_audio, &qhs_clk_ctl,
+		   &qhs_cpr_cx, &qhs_cpr_mxa,
+		   &qhs_cpr_mxc, &qhs_crypto_cfg,
+		   &qhs_emac0_cfg, &qhs_imem_cfg,
+		   &qhs_ipa, &qhs_ipc_router,
+		   &qhs_mss_cfg, &qhs_pcie0_cfg,
+		   &qhs_pcie_rscc, &qhs_pdm,
+		   &qhs_pmu_wrapper_cfg, &qhs_prng,
+		   &qhs_qdss_cfg, &qhs_qpic,
+		   &qhs_qup0, &qhs_sdc4,
+		   &qhs_spmi_vgi_coex, &qhs_tcsr,
+		   &qhs_tlmm, &qhs_tme_cfg,
+		   &qhs_usb3, &qhs_vsense_ctrl_cfg,
+		   &qns_ddrss_cfg, &qns_snoc_datapath,
+		   &qss_anoc_throttle_cfg, &qxs_boot_imem,
+		   &qxs_imem, &xs_qdss_stm,
+		   &xs_sys_tcu_cfg },
+};
+
+static struct qcom_icc_bcm bcm_mc0 = {
+	.name = "MC0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_qup0 = {
+	.name = "QUP0",
+	.vote_scale = 1,
+	.num_nodes = 1,
+	.nodes = { &qup0_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_sh0 = {
+	.name = "SH0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_llcc },
+};
+
+static struct qcom_icc_bcm bcm_sh1 = {
+	.name = "SH1",
+	.enable_mask = 0x1,
+	.num_nodes = 2,
+	.nodes = { &qns_memnoc_cnoc, &qns_pcie },
+};
+
+static struct qcom_icc_bcm bcm_sn0 = {
+	.name = "SN0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_memnoc_sf },
+};
+
+static struct qcom_icc_bcm bcm_sn1 = {
+	.name = "SN1",
+	.enable_mask = 0x1,
+	.num_nodes = 1,
+	.nodes = { &xm_pcie3_0 },
+};
+
+static struct qcom_icc_bcm bcm_sn2 = {
+	.name = "SN2",
+	.num_nodes = 2,
+	.nodes = { &qns_a1noc, &qnm_aggre_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn4 = {
+	.name = "SN4",
+	.num_nodes = 1,
+	.nodes = { &qxm_mss_nav_ce },
+};
+
+static struct qcom_icc_bcm bcm_sn7 = {
+	.name = "SN7",
+	.num_nodes = 1,
+	.nodes = { &xs_pcie_0 },
+};
+
+static struct qcom_icc_bcm * const aggre_noc_bcms[] = {
+	&bcm_ce0,
+};
+
+static struct qcom_icc_node * const aggre_noc_nodes[] = {
+	[MASTER_AUDIO] = &qhm_audio,
+	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
+	[MASTER_QPIC] = &qhm_qpic,
+	[MASTER_QUP_0] = &qhm_qup0,
+	[MASTER_CRYPTO] = &qxm_crypto,
+	[MASTER_IPA] = &qxm_ipa,
+	[MASTER_EMAC] = &xm_emac_0,
+	[MASTER_QDSS_ETR] = &xm_qdss_etr0,
+	[MASTER_QDSS_ETR_1] = &xm_qdss_etr1,
+	[MASTER_SDCC_4] = &xm_sdc4,
+	[MASTER_USB3_0] = &xm_usb3,
+	[SLAVE_A1NOC_CFG] = &qns_a1noc,
+};
+
+static const struct qcom_icc_desc kuno_aggre_noc = {
+	.nodes = aggre_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre_noc_nodes),
+	.bcms = aggre_noc_bcms,
+	.num_bcms = ARRAY_SIZE(aggre_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const clk_virt_bcms[] = {
+	&bcm_qup0,
+};
+
+static struct qcom_icc_node * const clk_virt_nodes[] = {
+	[MASTER_QUP_CORE_0] = &qup0_core_master,
+	[SLAVE_QUP_CORE_0] = &qup0_core_slave,
+};
+
+static const struct qcom_icc_desc kuno_clk_virt = {
+	.nodes = clk_virt_nodes,
+	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
+	.bcms = clk_virt_bcms,
+	.num_bcms = ARRAY_SIZE(clk_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const cnoc_main_bcms[] = {
+	&bcm_cn0,
+};
+
+static struct qcom_icc_node * const cnoc_main_nodes[] = {
+	[MASTER_PCIE_RSCC] = &qhm_pcie_rscc,
+	[MASTER_GEM_NOC_CNOC] = &qnm_memnoc_cnoc,
+	[MASTER_QDSS_DAP] = &xm_qdss_dap,
+	[SLAVE_AHB2PHY] = &qhs_ahb2_phy,
+	[SLAVE_AOSS] = &qhs_aoss,
+	[SLAVE_APPSS] = &qhs_apss,
+	[SLAVE_AUDIO] = &qhs_audio,
+	[SLAVE_CLK_CTL] = &qhs_clk_ctl,
+	[SLAVE_RBCPR_CX_CFG] = &qhs_cpr_cx,
+	[SLAVE_RBCPR_MXA_CFG] = &qhs_cpr_mxa,
+	[SLAVE_RBCPR_MXC_CFG] = &qhs_cpr_mxc,
+	[SLAVE_CRYPTO_0_CFG] = &qhs_crypto_cfg,
+	[SLAVE_EMAC_CFG] = &qhs_emac0_cfg,
+	[SLAVE_IMEM_CFG] = &qhs_imem_cfg,
+	[SLAVE_IPA_CFG] = &qhs_ipa,
+	[SLAVE_IPC_ROUTER_CFG] = &qhs_ipc_router,
+	[SLAVE_CNOC_MSS] = &qhs_mss_cfg,
+	[SLAVE_PCIE_0_CFG] = &qhs_pcie0_cfg,
+	[SLAVE_PCIE_RSC_CFG] = &qhs_pcie_rscc,
+	[SLAVE_PDM] = &qhs_pdm,
+	[SLAVE_PMU_WRAPPER_CFG] = &qhs_pmu_wrapper_cfg,
+	[SLAVE_PRNG] = &qhs_prng,
+	[SLAVE_QDSS_CFG] = &qhs_qdss_cfg,
+	[SLAVE_QPIC] = &qhs_qpic,
+	[SLAVE_QUP_0] = &qhs_qup0,
+	[SLAVE_SDCC_4] = &qhs_sdc4,
+	[SLAVE_SPMI_VGI_COEX] = &qhs_spmi_vgi_coex,
+	[SLAVE_TCSR] = &qhs_tcsr,
+	[SLAVE_TLMM] = &qhs_tlmm,
+	[SLAVE_TME_CFG] = &qhs_tme_cfg,
+	[SLAVE_USB3] = &qhs_usb3,
+	[SLAVE_VSENSE_CTRL_CFG] = &qhs_vsense_ctrl_cfg,
+	[SLAVE_DDRSS_CFG] = &qns_ddrss_cfg,
+	[SLAVE_SNOC_CNOC] = &qns_snoc_datapath,
+	[SLAVE_ANOC_THROTTLE_CFG] = &qss_anoc_throttle_cfg,
+	[SLAVE_BOOT_IMEM] = &qxs_boot_imem,
+	[SLAVE_IMEM] = &qxs_imem,
+	[SLAVE_QDSS_STM] = &xs_qdss_stm,
+	[SLAVE_TCU] = &xs_sys_tcu_cfg,
+};
+
+static const struct qcom_icc_desc kuno_cnoc_main = {
+	.nodes = cnoc_main_nodes,
+	.num_nodes = ARRAY_SIZE(cnoc_main_nodes),
+	.bcms = cnoc_main_bcms,
+	.num_bcms = ARRAY_SIZE(cnoc_main_bcms),
+};
+
+static struct qcom_icc_node * const dc_noc_nodes[] = {
+	[MASTER_CNOC_DC_NOC] = &qnm_cnoc,
+	[SLAVE_LAGG_CFG] = &qhs_lagg,
+	[SLAVE_MCCC_MASTER] = &qhs_mccc_master,
+};
+
+static const struct qcom_icc_desc kuno_dc_noc = {
+	.nodes = dc_noc_nodes,
+	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
+};
+
+static struct qcom_icc_bcm * const mc_virt_bcms[] = {
+	&bcm_acv,
+	&bcm_mc0,
+};
+
+static struct qcom_icc_node * const mc_virt_nodes[] = {
+	[MASTER_LLCC] = &llcc_mc,
+	[SLAVE_EBI1] = &ebi,
+};
+
+static const struct qcom_icc_desc kuno_mc_virt = {
+	.nodes = mc_virt_nodes,
+	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
+	.bcms = mc_virt_bcms,
+	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const mem_noc_bcms[] = {
+	&bcm_sh0,
+	&bcm_sh1,
+};
+
+static struct qcom_icc_node * const mem_noc_nodes[] = {
+	[MASTER_SYS_TCU] = &alm_sys_tcu,
+	[MASTER_MSS_PROC] = &qnm_mdsp,
+	[MASTER_GEM_NOC_CFG] = &qnm_memnoc_cfg,
+	[MASTER_ANOC_PCIE_GEM_NOC] = &qnm_pcie,
+	[MASTER_SNOC_SF_MEM_NOC] = &qnm_snoc_sf,
+	[MASTER_APPSS_PROC] = &xm_apps0,
+	[SLAVE_LLCC] = &qns_llcc,
+	[SLAVE_GEM_NOC_CNOC] = &qns_memnoc_cnoc,
+	[SLAVE_MEM_NOC_PCIE_SNOC] = &qns_pcie,
+	[SLAVE_SERVICE_GEM_NOC] = &srvc_memnoc,
+};
+
+static const struct qcom_icc_desc kuno_mem_noc = {
+	.nodes = mem_noc_nodes,
+	.num_nodes = ARRAY_SIZE(mem_noc_nodes),
+	.bcms = mem_noc_bcms,
+	.num_bcms = ARRAY_SIZE(mem_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const pcie_anoc_bcms[] = {
+	&bcm_sn1,
+};
+
+static struct qcom_icc_node * const pcie_anoc_nodes[] = {
+	[MASTER_PCIE_0] = &xm_pcie3_0,
+	[SLAVE_ANOC_PCIE_GEM_NOC] = &qns_pcie_memnoc,
+};
+
+static const struct qcom_icc_desc kuno_pcie_anoc = {
+	.nodes = pcie_anoc_nodes,
+	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
+	.bcms = pcie_anoc_bcms,
+	.num_bcms = ARRAY_SIZE(pcie_anoc_bcms),
+};
+
+static struct qcom_icc_bcm * const system_noc_bcms[] = {
+	&bcm_sn0,
+	&bcm_sn2,
+	&bcm_sn4,
+	&bcm_sn7,
+};
+
+static struct qcom_icc_node * const system_noc_nodes[] = {
+	[MASTER_CPUCP] = &qhm_cpucp,
+	[MASTER_ANOC_SNOC] = &qnm_aggre_noc,
+	[MASTER_CNOC_SNOC] = &qnm_cnoc_datapath,
+	[MASTER_GEM_NOC_PCIE_SNOC] = &qnm_memnoc_pcie,
+	[MASTER_MSS_NAV] = &qxm_mss_nav_ce,
+	[MASTER_TME] = &qxm_tme,
+	[MASTER_IPA_PCIE] = &xm_ipa2pcie,
+	[SLAVE_SNOC_MEM_NOC_SF] = &qns_memnoc_sf,
+	[SLAVE_PCIE_0] = &xs_pcie_0,
+};
+
+static const struct qcom_icc_desc kuno_system_noc = {
+	.nodes = system_noc_nodes,
+	.num_nodes = ARRAY_SIZE(system_noc_nodes),
+	.bcms = system_noc_bcms,
+	.num_bcms = ARRAY_SIZE(system_noc_bcms),
+};
+
+static const struct of_device_id qnoc_of_match[] = {
+	{ .compatible = "qcom,kuno-aggre-noc", .data = &kuno_aggre_noc },
+	{ .compatible = "qcom,kuno-clk-virt", .data = &kuno_clk_virt },
+	{ .compatible = "qcom,kuno-cnoc-main", .data = &kuno_cnoc_main },
+	{ .compatible = "qcom,kuno-dc-noc", .data = &kuno_dc_noc },
+	{ .compatible = "qcom,kuno-mc-virt", .data = &kuno_mc_virt },
+	{ .compatible = "qcom,kuno-mem-noc", .data = &kuno_mem_noc },
+	{ .compatible = "qcom,kuno-pcie-anoc", .data = &kuno_pcie_anoc },
+	{ .compatible = "qcom,kuno-system-noc", .data = &kuno_system_noc },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qnoc_of_match);
+
+static struct platform_driver qnoc_driver = {
+	.probe = qcom_icc_rpmh_probe,
+	.remove = qcom_icc_rpmh_remove,
+	.driver = {
+		.name = "qnoc-kuno",
+		.of_match_table = qnoc_of_match,
+		.sync_state = icc_sync_state,
+	},
+};
+
+static int __init qnoc_driver_init(void)
+{
+	return platform_driver_register(&qnoc_driver);
+}
+core_initcall(qnoc_driver_init);
+
+static void __exit qnoc_driver_exit(void)
+{
+	platform_driver_unregister(&qnoc_driver);
+}
+module_exit(qnoc_driver_exit);
+
+MODULE_DESCRIPTION("Kuno NoC driver");
+MODULE_LICENSE("GPL");

-- 
2.43.0

