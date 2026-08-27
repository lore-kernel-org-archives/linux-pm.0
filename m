Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF84448C8D7
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 16:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787848794; cv=none; b=SrpPDeE3ZNbbjzL6qCKOcI0E2ID6WnxDx26zKjxhE5EsawLJhxP/wMaXJKyZswYCvIRJoch5AYOXOEWjrBtmG8XXQJbHK0G8UpCHFbosbwi/CYnIyqve08y5V1iU7/oNGYN/P5jC7XPCPmBSgA/zh4GJAjrm43qGVYbha6I/UVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787848794; c=relaxed/simple;
	bh=9FPCV87eitw661yJc7gqbrscj5MlCzlDB1E+PFlfCyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tIbmrKEJbpS5zzhiwVS7bldE7c75E4xUiRPFm2WQ+LPXsBRzZYANxOrdSSS//WlwZRKtgQYdrOP3c/m/l6tBmlC2bWky96G9p/S3hHu92Q7bAMN5oNBtxFEr0sqnIF4bE80qKBh7Obl7S3l9rAoWdC3KyObl3sJ6BqbVXhRtnNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CVpL4ZfA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OtHtMiKX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CVpL4ZfA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OtHtMiKX"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RFbnK21310900
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 16:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XYHgBCRZLEB3XoVwSokcAPnaY99rEFsjH7u+mtUXlls=; b=CVpL4ZfAqXMzDcJZ
	ljxvyeaPmM1kRXJtJvHHnkMcgARG58d3PvinlVj2Dmat7mny6eTPgEgZb//ViJyK
	Bhz+725jeHRfKpEo8b+95P7nOdxjWoJRaaY2/KweC1pQDFgTRWRf/09LUXkYYhXG
	f5/iT9srv11pCQRP6joxLV07p02Ujj6uivqBM2G46hbZDvzKRhVT4ZeFkKsScd6n
	x24jZQWBzDt/IVMkvtWlTG+XuWOi4qpguRu05xfXZRAEO/Y5nXSH/faJsw2wruJ/
	na18C9DjSFXT8JpFFLmHa25Y+4IUv55IdfVO+dl4SJ8fRoTWIUnICn7x5eAUuTza
	cDUu7w==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga8m5ksyt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 16:39:51 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e9e2db9914so1984984a34.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 09:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787848790; x=1788453590; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XYHgBCRZLEB3XoVwSokcAPnaY99rEFsjH7u+mtUXlls=;
        b=OtHtMiKX1E+Pjj6Ao7wr8W0lIPZcPYiYoY0Tu8OH2TvPlgHZhJb14p7smqRuvDohGU
         J1UylyQWRa6wC/9gfRdkjZy2JTFj0RpgJ4TW1z5cA3y/Y887hKmcI4tsudMBSIaz7DMf
         4oKreULnnW3EQWIXB7FcAHklzNlf2sdKauYoRxkR9Bu+gbQhz3sJEPtuNEEeMBWwQNGU
         Hr34u6JaF0VZwozja6CbmzM/1GJUFY3uWSAKGEN/TZdx42+mT1Ia8dOCKYM2MnyDl6+C
         SECvakA54vZNe3XR5paWhfTqLyUzC8v/v9S7ntvbtGFe47LgEcZqGqSD8Toc0EB6p31t
         d0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787848790; x=1788453590;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XYHgBCRZLEB3XoVwSokcAPnaY99rEFsjH7u+mtUXlls=;
        b=Rz5SUJjunYK9yaXvyb2jGdRnWZW/BYFUxSZLL2iQ0taFMj1WfHQPQPMF5uu9qGzQcP
         vjfWenxDxA4+/JbABU42Ygx15rcre/akEkT8Ur05DGlJUOhIxRT8yFeqWu6wsctzH48C
         aR+7GF+6RPy0wafnBIrxktlOHtxbX5rmfMChdmr3kpA5VhHksr/uQks/bAbfZUbE55KN
         fuP7E6/F+wCfluYBbBgzReBh+Kx6kRGOAUfy93D0Lthm99DMlyQ9VIIJy+4IheoOUIlO
         Fh6JfKCY7HSXifRw9t6lp/sPl3Qp6hq/O7exB/mtm3E19FPzhS5R7/a+49rP97hyejpI
         QrJw==
X-Forwarded-Encrypted: i=1; AHgh+Roxf347UFdpRfB41jnU3BQ/1iHe935dmVp2u5cuVSPhzYQAokcBSBPEiYJiIM1QWAlmDlvPj1oy2Q==@vger.kernel.org
X-Gm-Message-State: AFuF++mOzT/+lL6uSPrLBTh9AawmZLZWaj2S3gyaSh40k9Wemam2F9YM
	D6KMWNVPdakxgd0IidQPoRAIxxCKbJK0gQur/T8x5QRXxdqm093uYyi89K4OVcoZnDcqqpZf/VY
	FGSP9WNCfY/yXMsTzTMhy28c/85WzC+spiPCz/wflNUvU8tUT8qvtgC8BbgU+KA==
X-Gm-Gg: AR+sD12xH/yNZXV1J9PXF0yHVHf4leIV3Shs25Dn/WaiidpSl5TBUyXELU8+SdBJNE4
	5vdkZ9FiHMhY5FbRrflar+JC2elhKVY0wzBQmA58qAC9g7JL49RE3wE8bDV7a+ychlwWINvhdkA
	g8+X7JhFz+gVsn5e+J7Kn7Z8vd4xp+RY9cOTgMmqWQ6QWsRCnd87IT7pOVjto6VdGBsO9tuy1Xp
	pA81ihFbe8+0L2ASaTS7XUq6F7AbmIwKslAHmKl3iC0Lxzg2PB3J89jnxOfCeOSp23uRsKgu1F0
	SeTlKdHjAI1cN47m50szrJSL+zHTbN+3YafEuYpNefcoX+edLxWbYAlEgrKriAzzvU5zrJ0mnXa
	jajcGWn+2yzqjBeU1aX4NpMgFnwtL5aY+KDBGYbXpIxQgIFPGtA18G/3OcwPMYNCix+n9aeyxEQ
	WJQNVMNpuCUzjCkhG+3RfBImc=
X-Received: by 2002:a05:6820:5616:b0:6b1:5a1e:f9d4 with SMTP id 006d021491bc7-6b1c49a5099mr279395eaf.8.1787848790121;
        Thu, 27 Aug 2026 09:39:50 -0700 (PDT)
X-Received: by 2002:a05:6820:5616:b0:6b1:5a1e:f9d4 with SMTP id 006d021491bc7-6b1c49a5099mr279357eaf.8.1787848789584;
        Thu, 27 Aug 2026 09:39:49 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1a24bce78sm4253171eaf.3.2026.08.27.09.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:39:49 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 22:08:11 +0530
Subject: [PATCH v4 10/15] dt-bindings: clock: qcom: Add Kuno Global Clock
 Controller
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-kuno-soc-support-v4-10-dd34f235fc1a@oss.qualcomm.com>
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
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787848688; l=5749;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=9FPCV87eitw661yJc7gqbrscj5MlCzlDB1E+PFlfCyc=;
 b=THRecKjInsGkrbimoAUM4rAtwm+vArD8Vaf5lSlwEQ4dUSeGaQmP6dfSzryd5NEjMZ5B77BYC
 Ss+a1EuK9FRBwpWRMrja3mJJe+XTdiw2wkyp6OErQbQLVEC1HtMtIHG
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-ORIG-GUID: 0eV_EIcW5e6xOsZ_ilQs5s2aCwkZG5Nj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE0MCBTYWx0ZWRfX5oOR8p2ArOJN
 kipFKG0hwH3GewKHLCfjjni8TiJXeYRGchY+Qqp4QyzxYFdhJrBeM+tXoTzNptf+lW/ynw43Op/
 tEYVVuHmQWwGVU/E3j19YQA2XJQMBUc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE0MCBTYWx0ZWRfX1mGxYEuEwkWv
 lPJ0iH5zgcTo9lijPBcV6IdJY9mkCLKzkQbhQUAdCZ6H+PV5k1EkwtA4yeUqc4rfHEqqS5Io+IP
 IEkDYC8MHHNRQmNPQMmfTbzAggg+/xnGZuetOlwd6s9Tmb059ffQjoN03Yv3kxMj2yruA2H0k9U
 +8WR19W75S6duxl4EJ0n4FNonMxyUQulPTUsCqVoJ01VMLjXYS8u80YkIZmRuvz03mpOsTztAB7
 6d8+75pTQq3TFW4Z5SGRpClGXBDKM+VUDtXIT2p/JQp1be8oS25cgPPzXM0z9aGTwp8Pktjcatn
 vBy6AaBJprGPdgQb3fb5D2f/+KWBAiymQp7WsU0U+vM3eJUfbUrLML63ftfc2TAXHb5npvB41jo
 O5l11wJqEvVKUcmdMWh2MRwyTqvPjoizVr6zhXadO59aGaJBeeUfbtmBqO1mtzyPtmOQmpGUEuP
 of5LZ7tlKzqs7xHpNsw==
X-Proofpoint-GUID: 0eV_EIcW5e6xOsZ_ilQs5s2aCwkZG5Nj
X-Authority-Analysis: v=2.4 cv=SomgLvO0 c=1 sm=1 tr=0 ts=6a906857 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=PKuh8qK-LUMqOkA3WUgA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270140

Document the Global Clock Controller (GCC) binding and associated
clock/reset IDs for the Qualcomm Kuno SoC.

Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 .../devicetree/bindings/clock/qcom,kuno-gcc.yaml   |  52 +++++++++++
 include/dt-bindings/clock/qcom,kuno-gcc.h          | 100 +++++++++++++++++++++
 2 files changed, 152 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,kuno-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,kuno-gcc.yaml
new file mode 100644
index 000000000000..7ae37033a1af
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,kuno-gcc.yaml
@@ -0,0 +1,52 @@
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
+required:
+  - compatible
+  - clocks
+  - '#power-domain-cells'
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    clock-controller@80000 {
+        compatible = "qcom,kuno-gcc";
+        reg = <0x00080000 0x1f4200>;
+        clocks = <&rpmhcc RPMH_CXO_CLK>,
+                 <&rpmhcc RPMH_CXO_CLK_A>,
+                 <&sleep_clk>,
+                 <&pcie_pipe_clk>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+        #power-domain-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,kuno-gcc.h b/include/dt-bindings/clock/qcom,kuno-gcc.h
new file mode 100644
index 000000000000..a237b25a061d
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,kuno-gcc.h
@@ -0,0 +1,100 @@
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
+/* GCC power domains */
+#define GCC_EMAC0_GDSC						0
+#define GCC_PCIE_GDSC						1
+#define GCC_USB20_GDSC						2
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

