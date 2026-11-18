Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794993621;
	b=5icd+Xj13S50K1ILNLB3mm8XHW+xEgPzrJuXvEskzRK1G8bWKfEIMZvjf7Pi7Z8LkYw6
	 0pMiXRV0hqeTthOfKQpcsHtRoF6VCI3dGJvvevBtbMifItKNm/BLVxKpFYJjPTMkjFVX1
	 jHN//wvKeGO/POEKcf8AUnEyENxJAxwiXmt7t16TltNKpUQ5IRo05BfH4uPMnW71+c8f2
	 yDh0GUA4eAd/eGK/9Oj/HrvZ9eC1iOMj4jmb7icYFU15zCHab/HsqsRatb2PzGcYQrdcb
	 J6DQzYim1lSOCoP8MBPuM2qzKC3/9Abku7V0ZvhDn77/lM7O8IdhbOEtDKNYPG4Vhfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993621;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1eDZqaeAdBXkeNEYN8hrXH+4wZcd0JXpXQ5BXT1LIJY=;
	b=OhXs6Zk18faPTAW3dc9Dz+EYP1g8rqhLVYd1/IhJ/yI6oLjc1yF8f+c+MivaUzH+XEPA
	 1nFCRbcIv9LEqragDdeRjhyupJIke5wjhctmaU4NwTJopaD7CXbO4kL1liygX4hcUfMZg
	 eGOOscmlRIDnQn2rTAQzYiBBHalMieMqaU6S2DVGHUM70yqtIU01Q9GovH7hla6UjFEHe
	 ZkhSdMTM787rPS2QRddprIqFSE6pdTWNsTQ2i93TicqZQzpub0CBF2RIIVJ7ndbFhUWYY
	 KVQ94pfAu10EdUD1gYWKqool0GJN1U1NsflHStu3L24q/NBcjzNSByQfyas0BXwS6jA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h8wO3zJr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331E3606A334;
	Wed, 18 Nov 2026 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h8wO3zJr
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794993620;
	b=y5bpyr9u2NdqXMijdDE3mGcjU56zT0MJL1bM6oRpi1H7GU8kwmXWlYxuctz7PBGLlcVt
	 Jg/BGKgGr/7OBkNNwE3tptM2Qigl7oU7FBlzu6M+nVmteVRrTkV6Wc5bSTVrTYsy4yKlg
	 q50weEXnkELKT4du2jRhr4rk0t9JP7T29Ft+E84lCLRjd5nURfVkGLrm3Tptb5g2r7Uru
	 EPZ2+8c8W12fWK28hJur62UL8fkd7OfAQhMYCl/ygD2XsWz28gm5GhFpJGpzI9NQlm9AD
	 2mkrXSLO+VzQtkyEPU7CVcrJu90zpVeZLbMAgZero1SdpOBCe8Li/4yLAs+cPD3xWaA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794993620;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1eDZqaeAdBXkeNEYN8hrXH+4wZcd0JXpXQ5BXT1LIJY=;
	b=qUGDdXp0EzZe1h9uY4jIvppz5wYmXC5KnbUHWOHPykYgSqDf9tCFTv5V98fcjiyKULAI
	 MXtPXhfgEK5V7ay0ojIu1wjFyvuQzHhYcnRfZSk4QhxZDGMtG3rc9z9EebFjxFc1WzVXi
	 lIdBeyPgl/xKpATo79EO50dS6Daun012bo7k9uMRSnc8HDzqpj13Rr2ZQkYLwq4Asgo9J
	 hWjcguXuqmvOB2N2uKyGpmDxH3UYTjh32w3oYzAleederya0kj8ReyxVDFDVev36syNuA
	 4qPkBKZrDsK08eU8f6u2fKA2efPolJb0khbuHYjxTCjADHd4xqKEnMw8L5hdS+qIUYg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EB6AC1F000C5;
	Wed, 18 Nov 2026 09:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794993620;
	bh=1eDZqaeAdBXkeNEYN8hrXH+4wZcd0JXpXQ5BXT1LIJY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=h8wO3zJrAOFVO4tbQdOI4z235irCzjIxS+kX0ZvWm+Pfzi/OakiJSNDm7gBYk0rqx
	 aIQy41eJQFpvNh+pSORlwaBZvQTalHUhfhrkzkfB63SZGnC/NoVvlR/xQRi7WcPjbG
	 ZEIKFgDnKP1Xtw9yxqFIHC7/GiGoKMLyEwS1+yAQWOW1qXgXeVFc9DooUqJTuCDt46
	 UM/Oovq3NbHaMDLvNJlvgK/qMIs2frUqTdu/fO74F2eWIl/9Y7PjKft8S48MPwCcP/
	 4Lb2vxnBHTdpcQuJb29jnMeriVI5uzmTV8qPuDh0Z7c1HwVU7vMhIh+ib/EpQcL9Ef
	 A8TPqW2asT4Vg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 80FFA4ACC4;
	Wed, 18 Nov 2026 09:20:19 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Date: Wed, 18 Nov 2026 14:50:16 +0530
Subject: [PATCH v6 1/2] dt-bindings: interconnect: qcom: Add SM7250 RPMh
 NoC
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
Message-Id: <20261118-icc-sm7250-v6-1-a06ec15c6e29@brar.si>
References: <20261118-icc-sm7250-v6-0-a06ec15c6e29@brar.si>
In-Reply-To: <20261118-icc-sm7250-v6-0-a06ec15c6e29@brar.si>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ishu Brar <patches@brar.si>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794993617; l=9850;
 i=patches@brar.si; h=from:subject:message-id;
 bh=nZz553/2dh16j4l5ZONtevBvzE8n45Y9EXV6hm2h9T8=;
 b=ZxJaVRj9VHqfCDc7b0LGz9BaX6L4j5fzeaQW1HvYCJDC/5lVc6ig6tgLbOWj0bsz6eRPknsHu
 ta3qT7HMBCQBKHMKkegzUycmB0AaTxT2EPagFdAb9li/YFZOWuNtejO
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
 .../bindings/interconnect/qcom,sm7250-rpmh.yaml    | 176 +++++++++++++++++++++
 .../dt-bindings/interconnect/qcom,sm7250-rpmh.h    | 148 +++++++++++++++++
 2 files changed, 324 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm7250-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm7250-rpmh.yaml
new file mode 100644
index 000000000000..1bb1ef409221
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sm7250-rpmh.yaml
@@ -0,0 +1,176 @@
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
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  interconnect:
+    type: object
+    description:
+      Interconnect provider without a register space of its own. The
+      compute-noc QoS registers are within the aggre2-noc register space.
+      The mc-virt and qup-virt providers are virtual and have no registers.
+
+    allOf:
+      - $ref: qcom,rpmh-common.yaml#
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
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,sm7250-aggre1-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre UFS PHY AXI clock
+            - description: aggre USB3 PRIM AXI clock
+      required:
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,sm7250-aggre2-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: RPMH CC IPA clock
+        interconnect:
+          properties:
+            compatible:
+              const: qcom,sm7250-compute-noc
+      required:
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,sm7250-gem-noc
+    then:
+      properties:
+        interconnect:
+          properties:
+            compatible:
+              const: qcom,sm7250-mc-virt
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,sm7250-system-noc
+    then:
+      properties:
+        interconnect:
+          properties:
+            compatible:
+              const: qcom,sm7250-qup-virt
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm7250-config-noc
+              - qcom,sm7250-dc-noc
+              - qcom,sm7250-gem-noc
+              - qcom,sm7250-mmss-noc
+              - qcom,sm7250-npu-noc
+              - qcom,sm7250-system-noc
+    then:
+      properties:
+        clocks: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm7250-aggre1-noc
+              - qcom,sm7250-config-noc
+              - qcom,sm7250-dc-noc
+              - qcom,sm7250-mmss-noc
+              - qcom,sm7250-npu-noc
+    then:
+      properties:
+        interconnect: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    interconnect@16e0000 {
+        compatible = "qcom,sm7250-aggre1-noc";
+        reg = <0x016e0000 0x15080>;
+        #interconnect-cells = <2>;
+        clocks = <&gcc 4>, <&gcc 5>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    interconnect@1620000 {
+        compatible = "qcom,sm7250-system-noc";
+        reg = <0x01620000 0x19200>;
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+
+        interconnect {
+            compatible = "qcom,sm7250-qup-virt";
+            #interconnect-cells = <2>;
+            qcom,bcm-voters = <&apps_bcm_voter>;
+        };
+    };
diff --git a/include/dt-bindings/interconnect/qcom,sm7250-rpmh.h b/include/dt-bindings/interconnect/qcom,sm7250-rpmh.h
new file mode 100644
index 000000000000..2b1fa23d0a21
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
2.56.1


