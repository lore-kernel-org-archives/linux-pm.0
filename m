Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792811457;
	b=sziUiQrdUvYA3PcdqT5h1GVck357DQZF17clz6dfMNTHFK0+g0C/RZDANBD45MX/cciN
	 z8LSaLhMzEq00fVcPMysG2q221skIuIxU/4YfKEZ6dcqs6f8tmwDM0QAS+EPifDkNWwdh
	 cnsNulnh7+Jn8Q8H4oktHYM4E4GDj2eplZQAgQiWG6jNtiKXGSTp1lIbuN+hFjimaFcwH
	 muYZi9PK0i3O23AxA4Hqcw5tTITfsf3jAO2F5kobrGJ4rtEM3JzXkjve1/E8cy46rVGqS
	 FZOPfzlTsZdh7MBAjUAW4NNt4TL7ffYiIs9knZt3H+3n7cSwv4EVrZP9aiLooxS/R9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792811457;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DzSpcJZMXa2laAVlB8D0oo3ivv5w7c04ZRQR/R0ibI8=;
	b=kSBzoSU1zMFAicI9dsnRiFvpO/eMFN6G6BU4WU+rVT0snSeWVUa57kgW79Y6JXWf+9yH
	 x/Xew2ysMSBxJHX/pONbnhdOxd6BOAzfIluSEa5gouXbdOhSqs46oUUbrc1v4bw9TSGGa
	 Z0uSBdIG9BvSALwV6DZWP866xl/N5ijtvQ22sMMTs1VdpzdfmY6bY6+Mo6Kk3Vu0WwDbV
	 yUCg9R+O2sukc//ai+WMt6oIxu2+gRaj+jfulQ+DwHg2gPJhp40F3pjqB/ElCDXqJHnDZ
	 0EP9VAsPPE7zBgsdxFCKANwSvaTIxHrsZ8vENjHVPAGLgqspdGbLQc7/MUlc3+5Fdhg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GSorlSpQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68B2606A322;
	Sat, 24 Oct 2026 03:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GSorlSpQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792811456;
	b=WrbcEndT9LsiYGCwd91L7/fTBbZD1Jv5oqjoy8zTlfX5HdFWczf/9z8rwB7l6fLHxPyY
	 6rTmVU4KVm/hFqU3XCA9lukyARrlMSZtS7a/ddH1F6eWM0iQb4ymWlin5zwyCBFRtCrHg
	 ElWJ9+7Cslo85htlw/YbvZgIfY3ai5/Suvsf94uhfPLWEfjNisvXikCMhZaXZ2THNdA/S
	 WnNZrulWpSTI4FtVm7bzd14Lh73hyhqvVc0U/k+SUW9Yyt09aQCETfi/qlDIOLZ7Aj5AB
	 pNgGwg9LZycNGs+4UsNzHDblCD8P4fRUxBPay6jUl3ASR3HkGhK/wZtuPbbaLd/hKcQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792811456;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DzSpcJZMXa2laAVlB8D0oo3ivv5w7c04ZRQR/R0ibI8=;
	b=A48xV6uFYokRH1m8k6HnD/FHGwjjV3d4a/jOpVm6GXt76MBI5bPCUGEWnZwFHWCw7LEA
	 lPWZ5D/x35axCDwGQA0q9xu7vlJ2wkK44/1YaKBdzGQ0/1di27Pw9pX47m/tu2UGTgdc5
	 pIHPkm+yGobDeeZSjXt3mpiNMcx99szwobr5uUd2yaDqN/qICDQ369Enb1qOF7bfYfro9
	 kxMxAgDC40WrrVHNuqaAECzAgNRZvklUBklXvL3S9VP39bgssAT8oS66GK75VwFpxNmj2
	 G3A7EHFr4RWZrJZfR9t+T/sixjYOfryYgDGF7nEn5acGDuj4ErT+QbQ7oltOWYzWbkA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B3C961F01829;
	Sat, 24 Oct 2026 03:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792811456;
	bh=DzSpcJZMXa2laAVlB8D0oo3ivv5w7c04ZRQR/R0ibI8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=GSorlSpQu9lj6LT28D/PhBbdQG5PsHO1+xJKXOzk56+/iqdGQjnp6zVrnPSTUuNfr
	 bSo3WAvtLOjmx4nahjXLI9x0ooDvUqi7oTUpSVLrObTMwzQwi1Y7rtEjmJZ6F0Jwr0
	 ShSnmEozXbOlZT1q4LHL0b+rOovwzzr9d3NRJv6y6d7Kc+mCKTO8zJb7Z8ybmSYRRD
	 D6xFRQaJN26JtdRwSURNMDIUBiSYMg/1EnKHzwetTk4XlA9SU/gfFEhexJNY6RSGM+
	 Px7QrSg346WXbdnCplZ53HnhnZ95AZDSVvUzjqtdUCTRsXA6zObPqU/y7/tu0RmL4/
	 R5ifgnbG++rWg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 49391446C6;
	Sat, 24 Oct 2026 03:10:55 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Date: Sat, 24 Oct 2026 08:40:53 +0530
Subject: [PATCH v2 1/2] dt-bindings: interconnect: qcom: Add SM7250 RPMh
 NoC bindings
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
Message-Id: <20261024-icc-sm7250-v2-1-0e755894b188@brar.si>
References: <20261024-icc-sm7250-v2-0-0e755894b188@brar.si>
In-Reply-To: <20261024-icc-sm7250-v2-0-0e755894b188@brar.si>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ishu Brar <patches@brar.si>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792811453; l=7929;
 i=patches@brar.si; h=from:subject:message-id;
 bh=yZquXLooeH5R8zCHpDPLWf2qb8A1PIOqUHS45lWeTWU=;
 b=j6jvN+tNlMCm9wz+NSGpTspj+USOfHWpcQsXikmODxMAok/Yi7XdUP+5Urrgdg/f8fxR7XeqI
 i62uweo5HknAvaKMoDOY0hYtlf5tiicDzP0+AoBIvI3batQtUfN51lb
X-Developer-Key: i=patches@brar.si; a=ed25519;
 pk=Ds+E23E3ntzjPzuBDyVRkOouclcNI5k75R+N42yJtCk=
X-Endpoint-Received: by B4 Relay for patches@brar.si/default with
 auth_id=1189
X-Original-From: Ishu Brar <patches@brar.si>
Reply-To: patches@brar.si
Content-Transfer-Encoding: 7bit

From: Ishu Brar <patches@brar.si>

Document the Network-On-Chip interconnect providers of the Qualcomm
SM7250 SoC (Snapdragon 765/765G/768G), which are controlled through RPMh
Bus Clock Managers, and add the header with the node and slave IDs.

Signed-off-by: Ishu Brar <patches@brar.si>
---
 .../bindings/interconnect/qcom,sm7250-rpmh.yaml    |  95 +++++++++++++
 .../dt-bindings/interconnect/qcom,sm7250-rpmh.h    | 148 +++++++++++++++++++++
 2 files changed, 243 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm7250-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm7250-rpmh.yaml
new file mode 100644
index 000000000..f8891faa8
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sm7250-rpmh.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sm7250-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on SM7250
+
+maintainers:
+  - Ishu Brar <patches@brar.si>
+
+description: |
+  RPMh interconnect providers support system bandwidth requirements through
+  RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
+  able to communicate with the BCM through the Resource State Coordinator (RSC)
+  associated with each execution environment. Provider nodes must point to at
+  least one RPMh device child node pertaining to their RSC and each provider
+  can map to multiple RPMh resources.
+
+  See also: include/dt-bindings/interconnect/qcom,sm7250-rpmh.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm7250-aggre1-noc
+      - qcom,sm7250-aggre2-noc
+      - qcom,sm7250-config-noc
+      - qcom,sm7250-dc-noc
+      - qcom,sm7250-gem-noc
+      - qcom,sm7250-mmss-noc
+      - qcom,sm7250-npu-noc
+      - qcom,sm7250-system-noc
+
+  reg:
+    maxItems: 1
+
+# Child node's properties
+patternProperties:
+  '^interconnect-[a-z0-9\-]+$':
+    type: object
+    description:
+      The interconnect providers do not have a separate QoS register space,
+      but share parent's space.
+    $ref: qcom,rpmh-common.yaml#
+
+    properties:
+      compatible:
+        enum:
+          - qcom,sm7250-compute-noc
+          - qcom,sm7250-mc-virt
+          - qcom,sm7250-qup-virt
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
+  - $ref: qcom,rpmh-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interconnect/qcom,sm7250-rpmh.h>
+
+    interconnect@1620000 {
+        compatible = "qcom,sm7250-system-noc";
+        reg = <0x01620000 0x19200>;
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+
+        interconnect-qup-virt {
+            compatible = "qcom,sm7250-qup-virt";
+            #interconnect-cells = <2>;
+            qcom,bcm-voters = <&apps_bcm_voter>;
+        };
+    };
+
+    interconnect@9680000 {
+        compatible = "qcom,sm7250-gem-noc";
+        reg = <0x09680000 0x3e200>;
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+
+        interconnect-mc-virt {
+            compatible = "qcom,sm7250-mc-virt";
+            #interconnect-cells = <2>;
+            qcom,bcm-voters = <&apps_bcm_voter>;
+        };
+    };
diff --git a/include/dt-bindings/interconnect/qcom,sm7250-rpmh.h b/include/dt-bindings/interconnect/qcom,sm7250-rpmh.h
new file mode 100644
index 000000000..2b1fa23d0
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sm7250-rpmh.h
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Qualcomm SM7250 interconnect IDs
+ *
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SM7250_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SM7250_H
+
+#define MASTER_A1NOC_CFG		0
+#define MASTER_QUP_1			1
+#define MASTER_SDCC_2			2
+#define MASTER_SDCC_4			3
+#define MASTER_EMMC			4
+#define MASTER_UFS_MEM			5
+#define MASTER_USB3			6
+#define A1NOC_SNOC_SLV			7
+#define SLAVE_SERVICE_A1NOC		8
+
+#define MASTER_A2NOC_CFG		0
+#define MASTER_QDSS_BAM			1
+#define MASTER_QUP_0			2
+#define MASTER_CRYPTO_CORE_0		3
+#define MASTER_IPA			4
+#define MASTER_QDSS_ETR			5
+#define A2NOC_SNOC_SLV			6
+#define SLAVE_SERVICE_A2NOC		7
+
+#define MASTER_NPU			0
+#define MASTER_NPU_CDP			1
+#define SLAVE_CDSP_GEM_NOC		2
+
+#define SNOC_CNOC_MAS			0
+#define MASTER_QDSS_DAP			1
+#define SLAVE_A1NOC_CFG			2
+#define SLAVE_A2NOC_CFG			3
+#define SLAVE_AHB2PHY_SOUTH		4
+#define SLAVE_AHB2PHY_CENTER		5
+#define SLAVE_AOSS			6
+#define SLAVE_CAMERA_CFG		7
+#define SLAVE_CLK_CTL			8
+#define SLAVE_CDSP_CFG			9
+#define SLAVE_RBCPR_CX_CFG		10
+#define SLAVE_RBCPR_MX_CFG		11
+#define SLAVE_CRYPTO_0_CFG		12
+#define SLAVE_CX_RDPM			13
+#define SLAVE_DCC_CFG			14
+#define SLAVE_CNOC_DDRSS		15
+#define SLAVE_DISPLAY_CFG		16
+#define SLAVE_GRAPHICS_3D_CFG		17
+#define SLAVE_IMEM_CFG			18
+#define SLAVE_IPA_CFG			19
+#define SLAVE_IPC_ROUTER_CFG		20
+#define SLAVE_LPASS			21
+#define SLAVE_CNOC_MNOC_CFG		22
+#define SLAVE_NPU_CFG			23
+#define SLAVE_PDM			24
+#define SLAVE_PIMEM_CFG			25
+#define SLAVE_PRNG			26
+#define SLAVE_QDSS_CFG			27
+#define SLAVE_QUP_0			28
+#define SLAVE_QUP_1			29
+#define SLAVE_SDCC_2			30
+#define SLAVE_SDCC_4			31
+#define SLAVE_SNOC_CFG			32
+#define SLAVE_TCSR			33
+#define SLAVE_TLMM_NORTH		34
+#define SLAVE_TLMM_SOUTH		35
+#define SLAVE_TLMM_WEST			36
+#define SLAVE_UFS_MEM_CFG		37
+#define SLAVE_EMMC_CFG			38
+#define SLAVE_USB3			39
+#define SLAVE_VENUS_CFG			40
+#define SLAVE_VSENSE_CTRL_CFG		41
+#define SLAVE_SERVICE_CNOC		42
+
+#define MASTER_CNOC_DC_NOC		0
+#define SLAVE_GEM_NOC_CFG		1
+#define SLAVE_LLCC_CFG			2
+
+#define MASTER_AMPSS_M0			0
+#define MASTER_SYS_TCU			1
+#define MASTER_GPU_TCU			2
+#define MASTER_GEM_NOC_CFG		3
+#define MASTER_COMPUTE_NOC		4
+#define MASTER_GRAPHICS_3D		5
+#define MASTER_MNOC_HF_MEM_NOC		6
+#define MASTER_MNOC_SF_MEM_NOC		7
+#define MASTER_SNOC_GC_MEM_NOC		8
+#define MASTER_SNOC_SF_MEM_NOC		9
+#define SLAVE_MCDMA_MS_MPU_CFG		10
+#define SLAVE_MSS_PROC_MS_MPU_CFG	11
+#define SLAVE_GEM_NOC_SNOC		12
+#define SLAVE_LLCC			13
+#define SLAVE_SERVICE_GEM_NOC		14
+
+#define MASTER_LLCC			0
+#define SLAVE_EBI_CH0			1
+
+#define MASTER_CNOC_MNOC_CFG		0
+#define MASTER_CAMNOC_ICP		1
+#define MASTER_CAMNOC_HF0		2
+#define MASTER_CAMNOC_HF1		3
+#define MASTER_CAMNOC_SF		4
+#define MASTER_MDP_PORT0		5
+#define MASTER_MDP_PORT1		6
+#define MASTER_ROTATOR			7
+#define MASTER_VIDEO_P0			8
+#define MASTER_VIDEO_P1			9
+#define MASTER_VIDEO_PROC		10
+#define SLAVE_MNOC_HF_MEM_NOC		11
+#define SLAVE_MNOC_SF_MEM_NOC		12
+#define SLAVE_SERVICE_MNOC		13
+
+#define MASTER_NPU_SYS			0
+#define MASTER_NPU_NOC_CFG		1
+#define SLAVE_NPU_CAL_DP0		2
+#define SLAVE_NPU_CP			3
+#define SLAVE_NPU_INT_DMA_BWMON_CFG	4
+#define SLAVE_NPU_DPM			5
+#define SLAVE_ISENSE_CFG		6
+#define SLAVE_NPU_LLM_CFG		7
+#define SLAVE_NPU_TCM			8
+#define SLAVE_NPU_COMPUTE_NOC		9
+#define SLAVE_SERVICE_NPU_NOC		10
+
+#define MASTER_QUP_CORE_0		0
+#define MASTER_QUP_CORE_1		1
+#define SLAVE_QUP_CORE_0		2
+#define SLAVE_QUP_CORE_1		3
+
+#define MASTER_SNOC_CFG			0
+#define A1NOC_SNOC_MAS			1
+#define A2NOC_SNOC_MAS			2
+#define MASTER_GEM_NOC_SNOC		3
+#define MASTER_PIMEM			4
+#define SLAVE_APPSS			5
+#define SNOC_CNOC_SLV			6
+#define SLAVE_SNOC_GEM_NOC_GC		7
+#define SLAVE_SNOC_GEM_NOC_SF		8
+#define SLAVE_OCIMEM			9
+#define SLAVE_PIMEM			10
+#define SLAVE_SERVICE_SNOC		11
+#define SLAVE_QDSS_STM			12
+#define SLAVE_TCU			13
+
+#endif

-- 
2.56.0


