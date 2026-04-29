Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE9C3D47D4
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471447; cv=none; b=AgE52u/35yhq3TTmwaympfsOLyo5/AZKmd0xL+U+JCYsnhKe489eeuQc9JKUD5Wtsq1yIUSHKRUbG6dy7c8rGe4gNi+wjcK5JQpBwPd/gEUV+LWzpwnbVduprS+vWLh3Z/rawCNrRy/9TAfwfogh7dDJhl2Zhtn5rI8XB5L6kWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471447; c=relaxed/simple;
	bh=lg3exJdvbBikiSbHZD6rElxxQAHVm8PB1Aw/g2PvgFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FzalkDY31rQ2bZqQ7Bj0c8mHSXU00RE0TdpaW8I5LezGPk8aYzZ1inBReepXaaZcBaMmYte66q5mtc6k3lkM1e7mm3gcuOb9WZjVCkyW+oSF441VfrDtWtGWVCZcchoY1RQRAWUd4PaIVmI5AP3l0WZ+kqxRFEzMlODJBjmVD9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VV+FwrWN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZjMZa5Lw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VV+FwrWN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZjMZa5Lw"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8pp4x901798
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 14:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rChLUnnbls7t87wRS5VOY/U2VaRdDjm0YPu6OIG8g+w=; b=VV+FwrWNGzM0N1xb
	UVJbIKcPXZUfU85CLF6aOffcu7pHOI6ow/nUM2nNKNDc3c8UjEP1vIwgMZOTcfFg
	i8tWwFZ/F6NCOiSHpE2ohiL85NJ2vq8gdq8nEcLwsAadJx6BgGDatWp6hJX5s3iN
	Jk1d6gs0svFd4VhpUmtYvrH4X7EUUOLzZspa5yXbjHLfdTT8xJc/SoGjnzPSoMHQ
	sxICjGrVtozIDs0xGNtOTddT6Osfi/CQT0irxg9arxt5gxiM8EvdoAR3WtpGv4ar
	GMkkp/yPC34rffmOKhllXr5kvIM81rlb+9nnN5ywBtArJvx4+Yv6/R8c3IJ8BOBM
	cM5OZg==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dubq9j08r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 14:04:05 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7900fc7033bso20781667b3.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 07:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777471445; x=1778076245; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rChLUnnbls7t87wRS5VOY/U2VaRdDjm0YPu6OIG8g+w=;
        b=ZjMZa5LwZo7L282wVqbh3BHLY6mZhEa73ChHIj/JHvctmmp8h6gLWZDXQ+N+IVjUz4
         SzlRuQBIHF8QtSnRE4Q0mAGaJXnUtvPVUCZ1/pG5Bn5WUYOTCFGZYp3EijbGcarCCg5m
         VOUZhIsV4Y98W63sNdEO9hdbZLCfB01JY4zE6YK4sx7VnFXInA3ZLtFYXeCq7hE9c1Qw
         jNqr6l35S05m6Ju+MkeGYvNv3146Wk1yQaGEcUui9kpFKmRrg5UUEv1FMSPKy+CtxB25
         kFL2La1+DuX48WF8fsztivekFUdlkt+9wd6eikmZHBB5roLiMba5lMNFJQuA3K6iQwrJ
         KA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777471445; x=1778076245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rChLUnnbls7t87wRS5VOY/U2VaRdDjm0YPu6OIG8g+w=;
        b=fwOmqPh2IW/+z1XkMMJkkSN7sR+dpAdGl0UXJRlksetqLl412WKW38/3r71MNn3VD7
         zuoVOVm2TWw19jqKDrHJ918pD4DRED4NTW4B/BSBTVS8mlyfN23dTkx+VXdNQXybcg4b
         2xf5rkXedirlv0+KqBQHSrjrdeV+h0xSdMPpI5A/S1tBpz0TyFRhf6RxTroAWQw3jbaI
         TtkhmW4xgAbNL4IlLlWeBvNuQ/ANYZYDGB3R8HG3oP9HW5jftudFj1p2nmAWyaIBRW8v
         As0dfSpN992TPGc0GFFTy2b2l8uDte375/Hz8zgaDdmkloVq88J8QulRa1SwQzLYLxmr
         PNsQ==
X-Forwarded-Encrypted: i=1; AFNElJ+IjGbKXP4CKmYPj7bSLc2H6HGerjoKTl61djkLF/nxPAIzcKb/DyZE4tJCumTvSandTYFayIiZhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzN5w+9jrc/KEAEVsR2pI39Geor/gaxUDFFY0SCCUuL9mB1fGAF
	KKXz2GI94gX7a/zGYTqYmMa2duNmrMQPP829K5OZoYUdhM7JCeAiPNxjn96VUn4+/fpFM8WoqjT
	QX3hM5IS9rP+etkhcwgZaK6InhPX5g4g8itY9rfSJEas9MGCLYm0iX4MN9z1RucZlnIslQg==
X-Gm-Gg: AeBDietgLORigPOOcO82mq3ia+KcQVb6t+o0KZBPd7vwJzSwe3/TiOPKEV7MroLgHpH
	PCtg9YHCx6JCZTstT0Mn00h+UpIZzzQgEAbgjLVNiI5ezg3kXQc1+PDYipd+HQsFMw9QfAh2tEk
	TPQj0FqkZt84RcTQCl0VYpjcDmUY4JCaQFktGn3Q6A7D8MpLorv5XWYW4MBIUW/Fu8wv6NZHy8I
	+cDKVhWSWcDnq7075lMM9EDjlMuRPtF1RYBn/TJ1bbehDzO6iWtIM5W7w0LLPJhOnZ2vOtkl+KX
	16L2w8pdHGGgPqbFu8cXAQGPKpLoscpni7Iu56suDr6zCd6hknYsIbGIA+KiVdM+fn6stXCeQkl
	ZoteAd31rT4VqmomYxd2qfRJbwuZoWUCkcbhqW3L75jgKL8oTCwS/2h8=
X-Received: by 2002:a05:690c:ed4:b0:79a:b440:5c8d with SMTP id 00721157ae682-7bd23e72241mr26245357b3.11.1777471444485;
        Wed, 29 Apr 2026 07:04:04 -0700 (PDT)
X-Received: by 2002:a05:690c:ed4:b0:79a:b440:5c8d with SMTP id 00721157ae682-7bd23e72241mr26244547b3.11.1777471443639;
        Wed, 29 Apr 2026 07:04:03 -0700 (PDT)
Received: from [169.254.0.2] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd258ce06asm15382827b3.36.2026.04.29.07.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 07:04:03 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 14:03:48 +0000
Subject: [PATCH 1/2] dt-bindings: interconnect: document the RPM
 Network-On-Chip interconnect in Shikra SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-shikra_icc-v1-1-e3439903edf1@oss.qualcomm.com>
References: <20260429-shikra_icc-v1-0-e3439903edf1@oss.qualcomm.com>
In-Reply-To: <20260429-shikra_icc-v1-0-e3439903edf1@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Proofpoint-GUID: hlSUxf3N1OgZ7ynxE8PMGK9rwEPPMFZ0
X-Proofpoint-ORIG-GUID: hlSUxf3N1OgZ7ynxE8PMGK9rwEPPMFZ0
X-Authority-Analysis: v=2.4 cv=Wak8rUhX c=1 sm=1 tr=0 ts=69f20fd5 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=8QtCtDovb98T9R5Wn5QA:9 a=QEXdDO2ut3YA:10
 a=WgItmB6HBUc_1uVUp3mg:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE0MiBTYWx0ZWRfX16rcte5x2pEx
 P3RqkLBbuckGqMqNRxcC+i/m/Fnv6MiuPd8JF6U5lVMjLsWjKRKoDpdWGDvC1ak+XIhpMkDFhPq
 fTS00V5UZ9Zqn2Be5DSSjqvfk86upkCOOeiE9R4DfV6wykUV/UHleth9DbTvHo2/vTn1RYI8Srd
 3XBgbtY8yKMScUuPkSffyIdTfeBoBLziqcl5rIqxxsk7EnW5Ac68PLCUZktYYyf3audiH1/OMTB
 OkL5+VYLKm0/dVapjYHBWSzy6EWcqKLPRKli9r3xX3ZD2m2Kn6CzKLUDyT5++a8dC/JVGWnScNl
 doMvdIllXMtWlPSapRM+djrWWFx3q4EcnJNKY5IvIxaYjFvNMmrfKHVR1H1KIMMbY/LCtDcqbNb
 qVru/KRJYDluvBRZKB6fvwTHCaDfToDx4eTP8T6FJgS2eh64kYAUzxep64Luez6LPIFNuFvn6vf
 5mYB3p/yezgGCdJAahA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290142

Document the RPM Network-On-Chip Interconnect for the Qualcomm
Shikra platform.

Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
 .../bindings/interconnect/qcom,shikra.yaml         | 135 +++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,shikra.h     | 121 ++++++++++++++++++
 2 files changed, 256 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,shikra.yaml b/Documentation/devicetree/bindings/interconnect/qcom,shikra.yaml
new file mode 100644
index 000000000000..945bbeeb00ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,shikra.yaml
@@ -0,0 +1,135 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,shikra.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Shikra Network-On-Chip interconnect
+
+maintainers:
+  - Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
+
+description: |
+  The Qualcomm Shikra interconnect providers support adjusting the
+  bandwidth requirements between the various NoC fabrics.
+
+properties:
+  compatible:
+    enum:
+      - qcom,shikra-config-noc
+      - qcom,shikra-mem-noc-core
+      - qcom,shikra-sys-noc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 4
+
+  clock-names:
+    minItems: 1
+    maxItems: 4
+
+# Child node's properties
+patternProperties:
+  '^interconnect-[a-z0-9]+$':
+    type: object
+    description:
+      The interconnect providers do not have a separate QoS register space,
+      but share parent's space.
+
+    $ref: qcom,rpm-common.yaml#
+
+    properties:
+      compatible:
+        enum:
+          - qcom,shikra-clk-virt
+          - qcom,shikra-mc-virt
+          - qcom,shikra-mmrt-virt
+          - qcom,shikra-mmnrt-virt
+
+    required:
+      - compatible
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: qcom,rpm-common.yaml#
+  - if:
+      properties:
+        compatible:
+          const: qcom,shikra-mem-noc-core
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: GPU-NoC AXI clock
+
+        clock-names:
+          items:
+            - const: gpu_axi
+
+  - if:
+      properties:
+        compatible:
+          const: qcom,shikra-sys-noc
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: EMAC0-NoC AXI clock.
+            - description: EMAC1-NoC AXI clock.
+            - description: USB2-NoC AXI clock.
+            - description: USB3-NoC AXI clock.
+
+        clock-names:
+          items:
+            - const: emac0_axi
+            - const: emac1_axi
+            - const: usb2_axi
+            - const: usb3_axi
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,shikra-clk-virt
+            - qcom,shikra-config-noc
+            - qcom,shikra-mc-virt
+            - qcom,shikra-mmrt-virt
+            - qcom,shikra-mmnrt-virt
+
+    then:
+      properties:
+        clocks: false
+        clock-names: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    snoc: interconnect@1880000 {
+        compatible = "qcom,shikra-sys-noc";
+        reg = <0x01880000 0x6a080>;
+        #interconnect-cells = <2>;
+        clocks = <&gcc_emac0_axi_sys_noc_clk>,
+                 <&gcc_emac1_axi_sys_noc_clk>,
+                 <&gcc_sys_noc_usb2_prim_axi_clk>,
+                 <&gcc_sys_noc_usb3_prim_axi_clk>;
+        clock-names = "emac0_axi",
+                      "emac1_axi",
+                      "usb2_axi",
+                      "usb3_axi";
+
+        clk_virt: interconnect-clk {
+            compatible = "qcom,shikra-clk-virt";
+            #interconnect-cells = <2>;
+        };
+    };
diff --git a/include/dt-bindings/interconnect/qcom,shikra.h b/include/dt-bindings/interconnect/qcom,shikra.h
new file mode 100644
index 000000000000..a42ea22ee162
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,shikra.h
@@ -0,0 +1,121 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SHIKRA_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SHIKRA_H
+
+#define MASTER_QUP_CORE_0			0
+#define SLAVE_QUP_CORE_0			1
+
+#define SNOC_CNOC_MAS				0
+#define MASTER_QDSS_DAP				1
+#define SLAVE_AHB2PHY_USB			2
+#define SLAVE_APSS_THROTTLE_CFG			3
+#define SLAVE_AUDIO				4
+#define SLAVE_BOOT_ROM				5
+#define SLAVE_CAMERA_NRT_THROTTLE_CFG		6
+#define SLAVE_CAMERA_CFG			7
+#define SLAVE_CDSP_THROTTLE_CFG			8
+#define SLAVE_CLK_CTL				9
+#define SLAVE_DSP_CFG				10
+#define SLAVE_RBCPR_CX_CFG			11
+#define SLAVE_RBCPR_MX_CFG			12
+#define SLAVE_CRYPTO_0_CFG			13
+#define SLAVE_DDR_SS_CFG			14
+#define SLAVE_DISPLAY_CFG			15
+#define SLAVE_EMAC0_CFG				16
+#define SLAVE_EMAC1_CFG				17
+#define SLAVE_GPU_CFG				18
+#define SLAVE_GPU_THROTTLE_CFG			19
+#define SLAVE_HWKM				20
+#define SLAVE_IMEM_CFG				21
+#define SLAVE_MAPSS				22
+#define SLAVE_MDSP_MPU_CFG			23
+#define SLAVE_MESSAGE_RAM			24
+#define SLAVE_MSS				25
+#define SLAVE_PCIE_CFG				26
+#define SLAVE_PDM				27
+#define SLAVE_PIMEM_CFG				28
+#define SLAVE_PKA_WRAPPER_CFG			29
+#define SLAVE_PMIC_ARB				30
+#define SLAVE_QDSS_CFG				31
+#define SLAVE_QM_CFG				32
+#define SLAVE_QM_MPU_CFG			33
+#define SLAVE_QPIC				34
+#define SLAVE_QUP_0				35
+#define SLAVE_RPM				36
+#define SLAVE_SDCC_1				37
+#define SLAVE_SDCC_2				38
+#define SLAVE_SECURITY				39
+#define SLAVE_SNOC_CFG				40
+#define SNOC_SF_THROTTLE_CFG			41
+#define SLAVE_TLMM				42
+#define SLAVE_TSCSS				43
+#define SLAVE_USB2				44
+#define SLAVE_USB3				45
+#define SLAVE_VENUS_CFG				46
+#define SLAVE_VENUS_THROTTLE_CFG		47
+#define SLAVE_VSENSE_CTRL_CFG			48
+#define SLAVE_SERVICE_CNOC			49
+
+#define MASTER_LLCC				0
+#define SLAVE_EBI_CH0				1
+
+#define MASTER_GRAPHICS_3D			0
+#define MASTER_MNOC_HF_MEM_NOC			1
+#define MASTER_ANOC_PCIE_MEM_NOC		2
+#define MASTER_SNOC_SF_MEM_NOC			3
+#define MASTER_AMPSS_M0				4
+#define MASTER_SYS_TCU				5
+#define SLAVE_LLCC				6
+#define SLAVE_MEMNOC_SNOC			7
+#define SLAVE_MEM_NOC_PCIE_SNOC			8
+
+#define MASTER_CAMNOC_SF			0
+#define MASTER_VIDEO_P0				1
+#define MASTER_VIDEO_PROC			2
+#define SLAVE_MMNRT_VIRT			3
+
+#define MASTER_CAMNOC_HF			0
+#define MASTER_MDP_PORT0			1
+#define MASTER_MMRT_VIRT			2
+#define SLAVE_MM_MEMNOC				3
+
+#define MASTER_SNOC_CFG				0
+#define MASTER_TIC				1
+#define MASTER_ANOC_SNOC			2
+#define MASTER_MEMNOC_PCIE			3
+#define MASTER_MEMNOC_SNOC			4
+#define MASTER_PIMEM				5
+#define MASTER_PCIE2_0				6
+#define MASTER_QDSS_BAM				7
+#define MASTER_QPIC				8
+#define MASTER_QUP_0				9
+#define CNOC_SNOC_MAS				10
+#define MASTER_AUDIO				11
+#define MASTER_EMAC_0				12
+#define MASTER_EMAC_1				13
+#define MASTER_QDSS_ETR				14
+#define MASTER_SDCC_1				15
+#define MASTER_SDCC_2				16
+#define MASTER_USB2_0				17
+#define MASTER_USB3				18
+#define MASTER_CRYPTO_CORE0			19
+#define SLAVE_APPSS				20
+#define SLAVE_MCUSS				21
+#define SLAVE_WCSS				22
+#define SLAVE_MEMNOC_SF				23
+#define SNOC_CNOC_SLV				24
+#define SLAVE_BOOTIMEM				25
+#define SLAVE_OCIMEM				26
+#define SLAVE_PIMEM				27
+#define SLAVE_SERVICE_SNOC			28
+#define SLAVE_PCIE2_0				29
+#define SLAVE_QDSS_STM				30
+#define SLAVE_TCU				31
+#define SLAVE_PCIE_MEMNOC			32
+#define SLAVE_ANOC_SNOC				33
+
+#endif

-- 
2.43.0

