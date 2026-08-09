Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311003ACF06
	for <linux-pm@vger.kernel.org>; Sun,  9 Aug 2026 07:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786260523; cv=none; b=t07VxqpMOxZbsKSijkS3RYz4VTXi6Tttc0VPiDol6hKKOmX6/cTTJp2OrABfZ998AekpWQnY9+qQOAUppEuxVF7W7J1+0WvmIQWMuOA0ueYch6b+V0f7QLv5sk9kNcgyhSpqlAuOPNIus2LYYcgvDYyQGUHrCkJercCPeg6sl1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786260523; c=relaxed/simple;
	bh=yxA32/uuk35Dah7wwIltOLJpeqYfAbrR+6/mS6QVK9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MoVZFS24pIM0efO7QN8fm5SGdPRS6TWapTc65bGhv5OCMHit3yveYKnASGbm8lfvr/nBmYgMsjXjXu9NW7//NFGVr/KPq0ytY0GNA84VSROwKLPrhfqXBqqRMDSTxFKHSbPKYrFT3guJiFuRlrF3x/vx6nQ1DzqKVNJUgMYitq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mBrTiwzt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OyjUUE8U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mBrTiwzt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OyjUUE8U"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6795dWtK1916479
	for <linux-pm@vger.kernel.org>; Sun, 9 Aug 2026 07:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wzYkFa+0iTyfkMFS6BwUwkpxpuQqxwJbf3crHmpZtXY=; b=mBrTiwztQ6ab4uOO
	BcV3Y94XmkCc3UcT5UI+cjhgx6muvXtv/lDGBmwIz33o87Ru967IxRrXp3mYkcFS
	EfthoZH/Mzo5U+rlCm6s6R2I9Hu0hEXS+QE66WixtbXeZDF6o2WYSVeXbUEccqO7
	5HwmK8otHYC8eeeQwI1dBYpapKVt33Oub+tiCxKGw5g8XTN+j5FQPGnTzoZXWGjC
	VjwtoF6G9aoKWu6fMwckCr9LgWtvKOtJbbdXdlbqPjpgwdEo+An/d85QzjbgdJAs
	ONMmZXZAktNK0EmsEiX9NRkL5NYaBV4CCmTRqHRgC0RgrvepHi9FFpXo9bIU/bHu
	yZMNIw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwstp2sbw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 07:28:40 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so1045265a91.1
        for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 00:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786260520; x=1786865320; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wzYkFa+0iTyfkMFS6BwUwkpxpuQqxwJbf3crHmpZtXY=;
        b=OyjUUE8UsJofQv3fOL4NM4mUhzV7ZNvgreuFBN3uI4jD0eWIYRSxT8HpnGn2Vquurd
         VJ0LGwb1yFYmhfZjsQ4n4a8cXQk2ODAk4u/Y5Bp99hMyy4dLdZ7Rjepp5UHp5SWPfeif
         zaOg1bl1Jgv2zTpFAKSwBH2b81lR2jKjp3Mo4me9T/JYTBZYrIQu1S677jGKUp2+RpN9
         /mGE15mHBxXbNw15ItOf6HZJtSNg+fO3HV2fx0qu3PF/GP32IsrybRsnVomGBoosEhDX
         TM/XwDu9voBgMa0CgaaJ9oeSNHBLxyC9S+wqQW+an1zOO2fqBCf/A0eCQv1sHAjMuRPz
         seew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786260520; x=1786865320;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wzYkFa+0iTyfkMFS6BwUwkpxpuQqxwJbf3crHmpZtXY=;
        b=J42hjpGpWMDrnOvzEtIMMGUYvghTfAmkmI2biTkxP6Y2v6USeCe/oD6WPSKAkrzOnD
         EnHMazdzSrYzJwo+M4WXeAvJHtdbU1n8TpHmijye2Iq9wHmmbRUdXILV3ppaH9jAE8ns
         ADo/1CwpKXA4ovcz/l/AshH5kZpBo5ivbReai/s2HrVK3x8DwAsso+X1I8IGfcGQFeY3
         oeuwTdEalvTfIFN6eYU1NtQt3Tx0ffImo9rwSW07/G2KubUhg3NjS++cTL0FlRMqI+nI
         s9DbfTuqe96CYbfEt/APHES7YUeYFVgI2Jt//9QjFx/WbLfWvOcH1aaGeL7OJGdzM6wN
         5DGg==
X-Forwarded-Encrypted: i=1; AHgh+RoyCnTYBez9ePrT+iwiAGJRF2Fo22iCMqxxfVXGA8vvAb0m9YQOeFGhIkrHD19q0f3KoFUCEeVitw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDW/OtIVAWtYd98G/ngD+JcxqjUIdq1T+bJXkof8kSeTGphJll
	w0RGBoIqyuyBaE7ouFfIcWRmVzqJTfag8HeNUlZjLMlFVXRwxpKESPUcNXAO2/2Ymw0m5rxQ5zU
	Jm1XTau7t4tdtW2+avbR+Q4qAG1QquTELjBLZUe252BuHJ0T7j47vuI8jCmM3DQ==
X-Gm-Gg: AR+sD11a2sP2zj/y3jexlcRxBGMZbJ+nH0YoMAc9xk5k8eRbAvJ23Ppnb4S/qckL0yn
	dvmCAkrDL4FKZITI5eD94Ewf1ekeWRkwC8IyDZBa/Quv5cf+5SmlF55RP1VOqV6rHHPSXni53gk
	W1oXTzJEUn6Zum/C2aV/ekCN9aHRkFm6GfX8TUJMKBVyqHjKo+gYOOXux6HVBwprq8NRX8CdpH+
	j6gaixDW2JVfBG1zxQU9cpqq8HFzmjWWd+XPs/8FdW0Faz+jSCT5+LthU5Vyn5Oiuyzd4MnfSQA
	C6iu6JIWVKFiqFlGgHnMO75S+iX3sUkFNxPtrCLU89eKTENTwGQbhFklcx8TdoNZFOODfA0EpkD
	Vzcp7wWR1F7VJ/AnZYBR+MeBkWpeYPNyVZrQzY3FxAPWwE+mzTh0HKMI8rCmxK1BoYUlYcExqZz
	+ZTOP948sVKaHMBy+/PeA9pr8=
X-Received: by 2002:a17:90b:57cd:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-392823c808fmr10795381a91.14.1786260519671;
        Sun, 09 Aug 2026 00:28:39 -0700 (PDT)
X-Received: by 2002:a17:90b:57cd:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-392823c808fmr10795354a91.14.1786260519175;
        Sun, 09 Aug 2026 00:28:39 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019b4eabsm22655630c88.6.2026.08.09.00.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 00:28:38 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 12:57:09 +0530
Subject: [PATCH 10/15] dt-bindings: clock: qcom: Add Kuno Global Clock
 Controller
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-kuno-soc-support-v1-10-5e0ede4a0c72@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786260433; l=5818;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=yxA32/uuk35Dah7wwIltOLJpeqYfAbrR+6/mS6QVK9A=;
 b=Uxjomh2FHLXfw1veZl9q8fbNhQwZHpUab6YYtAvKMy5cJlrFz7iHoM7SYwZot0sSjvDjYn1Hu
 KFuQr+57J7jBw36MPncmnskD7kFY8Xn7rxZ4OrWsqUmIaGfa9oPuUBF
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-GUID: HeOjuVwGV5JSfkCDxRAL31eUgjGN6NM8
X-Proofpoint-ORIG-GUID: HeOjuVwGV5JSfkCDxRAL31eUgjGN6NM8
X-Authority-Analysis: v=2.4 cv=CMEamxrD c=1 sm=1 tr=0 ts=6a782c28 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=55wsOiQBk-PRjUXo0ZkA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDA2MyBTYWx0ZWRfX452xT/daa36x
 B+bqeHyXFb0PCowLmwasewjOvhzVImepUH0xAhOdpCQjM/6sK/H+MBZoDNzLjRdBBfOG6BtQ2YE
 FS8pgVTk6g9eE9I8lPb2EGoPUGR6OvSpup4W4NTGvPLLwzMZgMJTMlFi2l21IKE/bsTsl1rB0ua
 QsLw7hGCRuETASqkUS0v8MKjyf/nVcTawNAkxLzYN/J2Gn9WZIHhP0qKuSWK/aD1a+6uVwBPvUy
 Z+Q+SS/QCh/OJQzbJ5Nyq1hIbOpb4w4yOAKnolFqb88PL8edI8gVQ9V1ctFtJc/mpe9mSBJiUwU
 ja+Un4PIYQh4XSRhTIFxzVOFcPLSiQ5Hq/JvDS0BBT8e8KI6vDFt48Gyuw3HFQL7X7o2Nq3t8j+
 ilYgeSFL38BnEaH+eY/yT5eOiJl1t0mp0f8RpvEUpZwEINwZT2iJFvNdslXqTG9gMyc885Z7fjv
 cWemE5RnUuw2zjK+V4Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDA2MyBTYWx0ZWRfXyoxnpmZJPtGr
 Av3HfCHPQ43GKjT/9gUEEvh/hzdkcDUKjJ+tQm2FsYUnZLXOD0KS1MdI1z76+NlDo3n6kRMeNz8
 0RXr8hdV+tThp4IyIcZy1bpds8VTQ7o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608090063

Add the device tree binding and clock/reset IDs for the global clock
controller (GCC) on the Qualcomm Kuno SoC so its device trees can
describe the GCC block and reference the clocks and resets it provides.

Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 .../devicetree/bindings/clock/qcom,kuno-gcc.yaml   | 56 +++++++++++++
 include/dt-bindings/clock/qcom,kuno-gcc.h          | 95 ++++++++++++++++++++++
 2 files changed, 151 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,kuno-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,kuno-gcc.yaml
new file mode 100644
index 000000000000..ff01ff31c2e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,kuno-gcc.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,kuno-gcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global Clock & Reset Controller on Kuno
+
+maintainers:
+  - Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
+
+description: |
+  Qualcomm global clock control module provides the clocks and resets on Kuno.
+
+  See also: include/dt-bindings/clock/qcom,kuno-gcc.h
+
+properties:
+  compatible:
+    const: qcom,kuno-gcc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Board active-only XO source
+      - description: Sleep clock source
+      - description: PCIe pipe clock source
+
+  power-domains:
+    items:
+      - description: CX domain
+
+required:
+  - compatible
+  - clocks
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
+    clock-controller@80000 {
+        compatible = "qcom,kuno-gcc";
+        reg = <0x00080000 0x1f4200>;
+        clocks = <&rpmhcc RPMH_CXO_CLK>,
+                 <&rpmhcc RPMH_CXO_CLK_A>,
+                 <&sleep_clk>,
+                 <&pcie_phy>;
+        power-domains = <&rpmhpd RPMHPD_CX>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,kuno-gcc.h b/include/dt-bindings/clock/qcom,kuno-gcc.h
new file mode 100644
index 000000000000..bbaf1799590f
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,kuno-gcc.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GCC_KUNO_H
+#define _DT_BINDINGS_CLK_QCOM_GCC_KUNO_H
+
+/* GCC clocks */
+#define GPLL0							0
+#define GPLL0_OUT_EVEN						1
+#define GPLL2							2
+#define GPLL3							3
+#define GPLL4							4
+#define GPLL4_OUT_EVEN						5
+#define GCC_EMAC0_AXI_CLK					7
+#define GCC_EMAC0_PHY_AUX_CLK					8
+#define GCC_EMAC0_PHY_AUX_CLK_SRC				9
+#define GCC_EMAC0_PTP_CLK					10
+#define GCC_EMAC0_PTP_CLK_SRC					11
+#define GCC_EMAC0_RGMII_CLK					12
+#define GCC_EMAC0_RGMII_CLK_SRC					13
+#define GCC_EMAC0_SLV_AHB_CLK					14
+#define GCC_EMAC_0_CLKREF_EN					15
+#define GCC_GP1_CLK						16
+#define GCC_GP1_CLK_SRC						17
+#define GCC_GP2_CLK						18
+#define GCC_GP2_CLK_SRC						19
+#define GCC_GP3_CLK						20
+#define GCC_GP3_CLK_SRC						21
+#define GCC_PCIE_0_CLKREF_EN					22
+#define GCC_PCIE_AUX_CLK					23
+#define GCC_PCIE_AUX_CLK_SRC					24
+#define GCC_PCIE_AUX_PHY_CLK_SRC				25
+#define GCC_PCIE_CFG_AHB_CLK					26
+#define GCC_PCIE_MSTR_AXI_CLK					27
+#define GCC_PCIE_PIPE_CLK					28
+#define GCC_PCIE_PIPE_CLK_SRC					29
+#define GCC_PCIE_RCHNG_PHY_CLK					30
+#define GCC_PCIE_RCHNG_PHY_CLK_SRC				31
+#define GCC_PCIE_SLEEP_CLK					32
+#define GCC_PCIE_SLV_AXI_CLK					33
+#define GCC_PCIE_SLV_Q2A_AXI_CLK				34
+#define GCC_PDM2_CLK						35
+#define GCC_PDM2_CLK_SRC					36
+#define GCC_PDM_AHB_CLK						37
+#define GCC_PDM_XO4_CLK						38
+#define GCC_QUPV3_WRAP0_CORE_2X_CLK				39
+#define GCC_QUPV3_WRAP0_CORE_CLK				40
+#define GCC_QUPV3_WRAP0_S0_CLK					41
+#define GCC_QUPV3_WRAP0_S0_CLK_SRC				42
+#define GCC_QUPV3_WRAP0_S1_CLK					43
+#define GCC_QUPV3_WRAP0_S1_CLK_SRC				44
+#define GCC_QUPV3_WRAP0_S2_CLK					45
+#define GCC_QUPV3_WRAP0_S2_CLK_SRC				46
+#define GCC_QUPV3_WRAP0_S3_CLK					47
+#define GCC_QUPV3_WRAP0_S3_CLK_SRC				48
+#define GCC_QUPV3_WRAP0_S4_CLK					49
+#define GCC_QUPV3_WRAP0_S4_CLK_SRC				50
+#define GCC_QUPV3_WRAP_0_M_AHB_CLK				51
+#define GCC_QUPV3_WRAP_0_S_AHB_CLK				52
+#define GCC_SDCC4_AHB_CLK					53
+#define GCC_SDCC4_APPS_CLK					54
+#define GCC_SDCC4_APPS_CLK_SRC					55
+#define GCC_SNOC_CNOC_USB3_CLK					56
+#define GCC_SYS_NOC_USB_SF_AXI_CLK				57
+#define GCC_USB20_MASTER_CLK					58
+#define GCC_USB20_MASTER_CLK_SRC				59
+#define GCC_USB20_MOCK_UTMI_CLK					60
+#define GCC_USB20_MOCK_UTMI_CLK_SRC				61
+#define GCC_USB20_MOCK_UTMI_POSTDIV_CLK_SRC			62
+#define GCC_USB20_SLEEP_CLK					63
+#define GCC_USB2_CLKREF_EN					64
+#define GCC_USB3_PRIM_CLKREF_EN					65
+#define GCC_USB_PHY_CFG_AHB2PHY_CLK				66
+#define GCC_BOOT_ROM_AHB_CLK					68
+
+/* GCC resets */
+#define GCC_EMAC0_BCR						0
+#define GCC_PCIE_BCR						1
+#define GCC_PCIE_LINK_DOWN_BCR					2
+#define GCC_PCIE_NOCSR_COM_PHY_BCR				3
+#define GCC_PCIE_PHY_BCR					4
+#define GCC_PCIE_PHY_CFG_AHB_BCR				5
+#define GCC_PCIE_PHY_COM_BCR					6
+#define GCC_PCIE_PHY_NOCSR_COM_PHY_BCR				7
+#define GCC_PDM_BCR						8
+#define GCC_QUPV3_WRAPPER_0_BCR					9
+#define GCC_QUSB2PHY_BCR					10
+#define GCC_SDCC4_BCR						11
+#define GCC_TCSR_PCIE_BCR					12
+#define GCC_USB20_BCR						13
+#define GCC_USB_PHY_CFG_AHB2PHY_BCR				14
+
+#endif

-- 
2.43.0

