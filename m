Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864300;
	b=3dnIhv6XLgQNXa25njtC+wGvLaJZSQhIMwvWsz2qmxZpcLyYftTiNKscz7s2KU+WNlnu
	 qrLEJEV/mY0P+8g1/N9JD+JxjuR0T/o9CQra75IZiTkpcLtqlLZz33SCu9az3BL0K83On
	 guEBgKsMDtz4tH21u0VQ4dkHt0DnYU6vWmnWVO43BUgoKcMSiT5Wz9OAjR4vJlDjcJwYH
	 DX0x3b0yjEmTAxNL3YNpFShtdCqGB30dDcoMeJvStW9/gRXbciFQb9eRGfQ9RsSVPe7YS
	 tZQQ6I5ePd/qWEcFVPW2vFs1Lx9S+/hg5XGJnwfl9vHhup7hS5LMvpdT5VbeAR5m4Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=k4ABT3aCjOFmqJb09qUSoyD91Am5eBWq5yne7kljDPQ=;
	b=grjM479XLMZ0M5Ny/FrE4RMZAxEZnseTuQ9ypi5m0vxed1HKQeHLe+LRK/VRFx5MeDQd
	 c6RO88Rn6eRk4LkXnLXBqDjL4WdDcwhp6cB+if2D+SdhLAMRilmMjduM+80Rl9HiguHRx
	 l4LnhWN0V9Pqf1tENbkEDFodTUFB/2+SSoxR0v82piIrJRtiBRHenXwOgb+ZGx5d+Ft9c
	 wG+4xAYEFdZdVKyMPI0uHawIgZpfD5lXaAN7W82hGA4CNVNU5Mhf4mXD969wYW13nn6O6
	 s1P6s98uxw3+RUrdZSX8Inf36r8mLLoGi8D/t9j0PjmfcKyRscxyvGb72XEMcX6TFaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="j/+qzraZ";
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5374606A334
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 21:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5374606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j/+qzraZ
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso27212235e9.3
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 13:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864298; x=1795469098; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k4ABT3aCjOFmqJb09qUSoyD91Am5eBWq5yne7kljDPQ=;
        b=j/+qzraZRv4jnqiE41DbGLpyohUiTa4H0/CbgToAvAeb9NPHgzqPAG5RGO3pdSV0tn
         M0jYWrPUnuVRZSmUup4CkHpS0lXhg4G19bjO3dwmE4bc5XbfgUDVDvzUWRyEEbsrRbNE
         IGyJ+WdglbHrOAlfCBGzG/Np4mpDXpfGha65gIThXejBNyhOaqrLuOuVZeJIggSFq3xO
         xiaw8DzbRq/oPVJPhpskl2cQlQfJaxlIOqh1P7zPMKIwwpD3lSC9SExpRLsbAMGMpFXT
         5+pv8IEPeZq3E2ZIb2KZRm4+GQ10MqGDeyobCD03W+Rrgz+geXmQtXnae/oQ4bzJde8J
         Xl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864298; x=1795469098;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k4ABT3aCjOFmqJb09qUSoyD91Am5eBWq5yne7kljDPQ=;
        b=Ksq6mvIG4Jy+fyMFu0LQPB23rAQBiH90/Qi5X9LU2VzaGAHO0wDgMQ5RpRSJdgxKVW
         O68+8dVeLc4edS2dr+LCuwwURIfYblc+uKrDc05kNAZIsd8fSuD13qXOtzxxYC5RlJBs
         O8u7qOksgw2h4QYn72H2EsA30gIRpnvkRaMlDl/htSw45zVELCHtI1ByXdkxjjjr3j5g
         uoZbAX5cUnUhCIujarxNPDKIw7Jp/hbBhrw540TyjXes+BQ4iJDpH6IfA3xoQ+ohKrWA
         sDi4U1JS5ihZdYZQL8Xy51mpMsM2n/VuMWVd/8NUUXAlziNtmxCpBTNNXlw/akg6Ol0H
         rfYw==
X-Forwarded-Encrypted: i=1; AL+hErHI5Kai3SvTVuBrgLkTfW+1SJ6nw1a6VQ8IN7fuL8zFmcfMr+Qx/Zs7OCwoajsfz9HYgXiFSuUQnQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z962C+ECmO6RbG1AXDUp4RLuuW5H9sR9fqtKULW17nwfQqsG2Zy
	h5MXapbBI16VQgvuQuFofiAF0rcm91P3LbvaTHJpm1kzmulnv5sxv7NHIDceIrvYwYkC1Q==
X-Gm-Gg: AYBFou1pBwgYBWNin0bTcWk9jIk4iTV6mRVC9ZrBISxIZXl31+ZbfKSuzm8PXEa05k3
	msTZqR6b+EUu/CWMjrtOoQgIn+fI07Ub7Ta9JbU2fe6mnmVSRgnhG38tPexZzv7YyEple8u11zU
	9VJWGcg24M31MC8BJZlzjMWU37tLIwz/f6RbPmkqjnS02QKe7FI5a8x7aLx0GqK6SDVJZVY2NF8
	jdcXXOuW0eRUuKMUxlT0i99fytsbvmT+40FnIA1/1xoArJEfBAX0Cy62TJKdEkPmlErRfr9hNCT
	MotqhFHjSZM1zi//hkIvIuWja90ZgatRLSKG8bT01LB4/3o6QmVw3nYfuG6eB6ABWWye9gsmxrk
	gsYhhjVQJgvQAy9YJZC/rh4HqvoVZpgD2Ue7kU+c+PtR5BChZXqq3idfVmY6uZ4JIlwvkzBhYKn
	YrB5gPPxRqrUDTQnI4LqMSJ+9F8uMACUBiPD6DKO5AevMcSHj2u/IzuDQQ0/lqUNAzcWRd3mNlA
	bQnJd0n9h5dTrNqks1E2d84DdwsOe1ApnzcLf+M3CkIDZlN4KUjBqjwyv08vVhsSCARcuRo4Djc
	amzKmL0XaOqG7HrC+hZUXie+IGh4kznEJzGaZCXRxhGrCXMEvQViO5ylw0MaAw==
X-Received: by 2002:a05:600c:3ba2:b0:4bb:7757:fe6d with SMTP id 5b1f17b1804b1-4bb7758002fmr41245925e9.11.1794864298139;
        Mon, 16 Nov 2026 13:24:58 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb734b9f44sm61928305e9.1.2026.11.16.13.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:24:57 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 16 Nov 2026 21:24:50 +0000
Subject: [PATCH v2 1/3] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Halliday SoC
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
Message-Id: <20261116-halliday-icc-v2-1-6df8fc0e0620@gmail.com>
References: <20261116-halliday-icc-v2-0-6df8fc0e0620@gmail.com>
In-Reply-To: <20261116-halliday-icc-v2-0-6df8fc0e0620@gmail.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Stanislav Aleksandrov <lightofmysoul@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794864293; l=8878;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=xF60/A7hjYDqDJ9/az3c1Q+UR4EVU83CDQSjdNWW368=;
 b=StthY+WeqH05nuecIwXP2UA+VZJmP1vVTTV6cTJqtzTNxyU5n/Yxc5tv/DsW5OEWHJYW0/8ZH
 N3rDjdVBUPxA1QN2rOMUH8YX/8pYBztBXOKGrA2Gp+LG1rpANWeGOa2
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the RPMh Network-On-Chip interconnect on the Qualcomm Halliday
SoC (SXR2250P).

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 .../bindings/interconnect/qcom,halliday-rpmh.yaml  | 131 +++++++++++++++++
 .../dt-bindings/interconnect/qcom,halliday-rpmh.h  | 158 +++++++++++++++++++++
 2 files changed, 289 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,halliday-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,halliday-rpmh.yaml
new file mode 100644
index 000000000000..0bc27ace965d
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,halliday-rpmh.yaml
@@ -0,0 +1,131 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,halliday-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on Halliday
+
+maintainers:
+  - Stanislav Aleksandrov <lightofmysoul@gmail.com>
+
+description: |
+  RPMh interconnect providers support system bandwidth requirements through
+  RPMh hardware accelerators known as Bus Clock Manager (BCM).
+
+  See also: include/dt-bindings/interconnect/qcom,halliday-rpmh.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,halliday-aggre1-noc
+      - qcom,halliday-aggre2-noc
+      - qcom,halliday-clk-virt
+      - qcom,halliday-config-noc
+      - qcom,halliday-gem-noc
+      - qcom,halliday-lpass-ag-noc
+      - qcom,halliday-mc-virt
+      - qcom,halliday-mmss-noc
+      - qcom,halliday-nsp-noc
+      - qcom,halliday-pcie-anoc
+      - qcom,halliday-system-noc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+required:
+  - compatible
+
+allOf:
+  - $ref: qcom,rpmh-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,halliday-clk-virt
+              - qcom,halliday-mc-virt
+    then:
+      properties:
+        reg: false
+    else:
+      required:
+        - reg
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,halliday-aggre1-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre UFS PHY AXI clock
+            - description: aggre USB3 PRIM AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,halliday-aggre2-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: RPMH CC IPA clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,halliday-pcie-anoc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre-NOC PCIe AXI clock
+            - description: cfg-NOC PCIe a-NOC AHB clock
+            - description: aggre-NOC PCIe SF AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,halliday-aggre1-noc
+              - qcom,halliday-aggre2-noc
+              - qcom,halliday-pcie-anoc
+    then:
+      required:
+        - clocks
+    else:
+      properties:
+        clocks: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    interconnect-0 {
+        compatible = "qcom,halliday-clk-virt";
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    interconnect@16c0000 {
+        compatible = "qcom,halliday-pcie-anoc";
+        reg = <0x016c0000 0xc080>;
+        clocks = <&aggre_noc_pcie_axi_clk>,
+                 <&cfg_noc_pcie_anoc_ahb_clk>,
+                 <&aggre_noc_pcie_sf_axi_clk>;
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
diff --git a/include/dt-bindings/interconnect/qcom,halliday-rpmh.h b/include/dt-bindings/interconnect/qcom,halliday-rpmh.h
new file mode 100644
index 000000000000..d60086489b38
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,halliday-rpmh.h
@@ -0,0 +1,158 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2026, Stanislav Aleksandrov <lightofmysoul@gmail.com>
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_HALLIDAY_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_HALLIDAY_H
+
+/* aggre1_noc */
+#define MASTER_QUP_1				0
+#define MASTER_A1NOC_CFG			1
+#define MASTER_UFS_MEM				2
+#define MASTER_USB3_0				3
+#define SLAVE_A1NOC_SNOC			4
+#define SLAVE_SERVICE_A1NOC			5
+
+/* aggre2_noc */
+#define MASTER_QDSS_BAM				0
+#define MASTER_QUP_0				1
+#define MASTER_A2NOC_CFG			2
+#define MASTER_CNOC_A2NOC			3
+#define MASTER_CRYPTO				4
+#define MASTER_IPA				5
+#define MASTER_SP				6
+#define MASTER_QDSS_ETR				7
+#define MASTER_QDSS_ETR_1			8
+#define MASTER_SDCC_2				9
+#define SLAVE_A2NOC_SNOC			10
+#define SLAVE_SERVICE_A2NOC			11
+
+/* clk_virt */
+#define MASTER_QUP_CORE_0			0
+#define MASTER_QUP_CORE_1			1
+#define SLAVE_QUP_CORE_0			2
+#define SLAVE_QUP_CORE_1			3
+
+/* config_noc */
+#define MASTER_GEM_NOC_CNOC			0
+#define MASTER_QDSS_DAP				1
+#define SLAVE_AHB2PHY_SOUTH			2
+#define SLAVE_AHB2PHY_NORTH			3
+#define SLAVE_AOSS				4
+#define SLAVE_CAMERA_CFG			5
+#define SLAVE_CLK_CTL				6
+#define SLAVE_CDSP_CFG				7
+#define SLAVE_RBCPR_CX_CFG			8
+#define SLAVE_RBCPR_MMCX_CFG			9
+#define SLAVE_RBCPR_MXA_CFG			10
+#define SLAVE_RBCPR_MXC_CFG			11
+#define SLAVE_CRYPTO_0_CFG			12
+#define SLAVE_CX_RDPM				13
+#define SLAVE_DISPLAY_CFG			14
+#define SLAVE_DISPLAY1_CFG			15
+#define SLAVE_GFX3D_CFG				16
+#define SLAVE_IMEM_CFG				17
+#define SLAVE_IPA_CFG				18
+#define SLAVE_IPC_ROUTER_CFG			19
+#define SLAVE_LPASS				20
+#define SLAVE_MX_RDPM				21
+#define SLAVE_PDM				22
+#define SLAVE_PRNG				23
+#define SLAVE_QDSS_CFG				24
+#define SLAVE_QUP_0				25
+#define SLAVE_QUP_1				26
+#define SLAVE_SDCC_2				27
+#define SLAVE_SPSS_CFG				28
+#define SLAVE_TCSR				29
+#define SLAVE_TLMM				30
+#define SLAVE_TME_CFG				31
+#define SLAVE_UFS_MEM_CFG			32
+#define SLAVE_USB3_0				33
+#define SLAVE_VENUS_CFG				34
+#define SLAVE_VSENSE_CTRL_CFG			35
+#define SLAVE_A1NOC_CFG				36
+#define SLAVE_A2NOC_CFG				37
+#define SLAVE_CNOC_A2NOC			38
+#define SLAVE_DDRSS_CFG				39
+#define SLAVE_CNOC_MNOC_CFG			40
+#define SLAVE_PCIE_ANOC_CFG			41
+#define SLAVE_SNOC_CFG				42
+#define SLAVE_IMEM				43
+#define SLAVE_SERVICE_CNOC			44
+#define SLAVE_QDSS_STM				45
+#define SLAVE_TCU				46
+
+/* gem_noc */
+#define MASTER_GPU_TCU				0
+#define MASTER_SYS_TCU				1
+#define MASTER_APPSS_PROC			2
+#define MASTER_GFX3D				3
+#define MASTER_MNOC_HF_MEM_NOC			4
+#define MASTER_MNOC_SF_MEM_NOC			5
+#define MASTER_COMPUTE_NOC			6
+#define MASTER_ANOC_PCIE_GEM_NOC		7
+#define MASTER_SNOC_GC_MEM_NOC			8
+#define MASTER_SNOC_SF_MEM_NOC			9
+#define SLAVE_GEM_NOC_CNOC			10
+#define SLAVE_LLCC				11
+
+/* lpass_ag_noc */
+#define MASTER_CNOC_LPASS_AG_NOC		0
+#define MASTER_LPASS_PROC			1
+#define SLAVE_LPASS_CORE_CFG			2
+#define SLAVE_LPASS_LPI_CFG			3
+#define SLAVE_LPASS_MPU_CFG			4
+#define SLAVE_LPASS_TOP_CFG			5
+#define SLAVE_LPASS_SNOC			6
+#define SLAVE_SERVICES_LPASS_AML_NOC		7
+#define SLAVE_SERVICE_LPASS_AG_NOC		8
+
+/* mc_virt */
+#define MASTER_LLCC				0
+#define SLAVE_EBI1				1
+#define MASTER_DDR_RT				2
+#define SLAVE_DDR_RT				3
+
+/* mmss_noc */
+#define MASTER_CAMNOC_HF			0
+#define MASTER_CAMNOC_ICP			1
+#define MASTER_CAMNOC_SF			2
+#define MASTER_MDP0				3
+#define MASTER_MDP1				4
+#define MASTER_CNOC_MNOC_CFG			5
+#define MASTER_CDSP_HCP				6
+#define MASTER_VIDEO				7
+#define MASTER_VIDEO_CV_PROC			8
+#define MASTER_VIDEO_PROC			9
+#define MASTER_VIDEO_V_PROC			10
+#define SLAVE_MNOC_HF_MEM_NOC			11
+#define SLAVE_MNOC_SF_MEM_NOC			12
+#define SLAVE_SERVICE_MNOC			13
+
+/* nsp_noc */
+#define MASTER_CDSP_NOC_CFG			0
+#define MASTER_CDSP_PROC			1
+#define SLAVE_CDSP_MEM_NOC			2
+#define SLAVE_SERVICE_NSP_NOC			3
+
+/* pcie_anoc */
+#define MASTER_PCIE_ANOC_CFG			0
+#define MASTER_PCIE_0				1
+#define MASTER_PCIE_1				2
+#define MASTER_PCIE_4				3
+#define SLAVE_ANOC_PCIE_GEM_NOC			4
+#define SLAVE_SERVICE_PCIE_ANOC			5
+
+/* system_noc */
+#define MASTER_GIC_AHB				0
+#define MASTER_A1NOC_SNOC			1
+#define MASTER_A2NOC_SNOC			2
+#define MASTER_LPASS_ANOC			3
+#define MASTER_SNOC_CFG				4
+#define MASTER_GIC				5
+#define SLAVE_SNOC_GEM_NOC_GC			6
+#define SLAVE_SNOC_GEM_NOC_SF			7
+#define SLAVE_SERVICE_SNOC			8
+
+#endif

-- 
2.55.0

