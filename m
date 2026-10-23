Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792748732;
	b=TW66kb150N1khZXxCQsfRSKu0/OMMuQCCnCMsqUW7Gyo7FcFEG7tHGhQQfN42ON6PVaN
	 1WJq07sGwQixf6falFk8XF91FpYgQrYU43yNJ5TXbsva5IiD15nr9qCEr2mEsD5uNTHU6
	 kY6g6OsRz+M3fGRyzkzu2u4N/SPChWM0Dfrm7EXPkFKUGSTH6O2b2H7phrysiqkciD0CX
	 1jCr8omJMtSDPdLT2CXwreDu3tEmVizgBy1umrm9x6xibgf+VlaYELY5bi3zGLNl9Pgbx
	 2B/EvyesTPwkslENMu8yO2gtebKQN7SAuU0uvjGtazZ8PvM/IaFTe5+ZKEfgH24mrkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792748732;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tUc+FjVihyrMyt8u1GuC5/hCihNZDjg0Yfb+68xAV+g=;
	b=uL2dEuuUNsRNj8nYVMkwnpL6aZxu0gmcEdVJa5ETZpcpd9ar5YQJzzQ0d+HsHr0ZPodU
	 jB4cTrnEwEx8a88B4vAxUcZDww1myUeTlyc8sn1fybCD6f0oBudNPiYBMufyc2CJwA28H
	 NYByFvqBzu9MhRvAQhhq4YxRwhapgoXG9oXYV9oX4zAw3CkcCXcf10V7knX5oTrx39M3Q
	 NfqP5HUsmWhmq9tqjETuiYVGOgvg/Lf16P3QYCNojYXUOTLHSKz72VOXNuB6pd7orP6Uk
	 qngamubgm9Pzzd8vPV4LtnKH5wsfNjBHGeKj6Kwdp9m33FBAc/eKTf5aTECsw8p9w5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+wDiIEc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B406E606A31F;
	Fri, 23 Oct 2026 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+wDiIEc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792748731;
	b=mHbWy8+cn9zsoJgc16QbhupPSmtiU5TSGveFbbF1Z6ragaX77fAsLE1YAtazqZR+n6Vb
	 azDk8cT7UXdTKkG20dm9ougFo0yJhkty83zTn8gE3ZafgZudP6ImtVAlqTa/3igkxeen+
	 FooTycupddUE3HNLCzcgTeMvVFdf4UHZDvPpsW1whS+cwqJCcGhFWZzXmAUuwJHdgwG3W
	 ijofRPnKj50KwQFhROCX6d8Qix8HHvTqYAhnBL8PBJYe4bc3tkkYJ4Kh+e2lmiQ6zrGL3
	 dllJOPqD17LA+L+SMMl8j4JjNyNw8vxb8hoOIzqU1jqaEFTREDSr+1fc/ao3SC+xr/Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792748731;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tUc+FjVihyrMyt8u1GuC5/hCihNZDjg0Yfb+68xAV+g=;
	b=RApnVSHUnXTKxN06x8Cm3ro6pu+yXD5JaMzVryHHgCL57l/ZKWoibFEf7i6sqBDQTzjR
	 VMJCH4Qo01cPkNZG/62ieyGh1nuet/5PTigx3qpmrKLQlYcTMvCrCj4Bjjvj/2j4IPmTr
	 Op98/MtzC/gfRnxd5lEVKcXY9NThCxr950MUk0e2T2oPoZkrJ0rD4KKJL+8ISjyVPzZOO
	 nPbXiQmUP4Bs5nSVL6kXdcFiw0bG0c4kSR5ru+nWje+tT5AP41Ogd7knpWL4tzkfAJJNi
	 i0dMoylwMbaeSiWdaK76yCC8YYZHbqyncRO3txc0pYc5nIS5Kt1oQhMNCuOaVRwDMmA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CB5FB1F01828;
	Fri, 23 Oct 2026 09:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792748731;
	bh=tUc+FjVihyrMyt8u1GuC5/hCihNZDjg0Yfb+68xAV+g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=M+wDiIEcJwFXuMnTb8C1RLQNywuigSyvlcU7y3AwxMi/AQRohuycObbQeqqucZWDC
	 wEbDHAM7p4GShQBUoFYBv86qnN2eDX+05ddiUc7wipYTK1DwiG5snYDKylDBCS7YwR
	 svXIIy8uWDB5KRwQbQRj76t34AB6zyDsy2g0+UpHhQc6yR/ePYvHgJnVAO0aPkcN1E
	 x4jiRZmjHmhRWpgY7Gl+EkXTUCWyZQpFNzko5190+OcvT20+42jfwwGK4+GULdsWKl
	 eLnMmIoUeJ1bimJJko7T0Cl3RbIwqPWaSkiUgeINASh3BsNBLU3HQNA7leP2FdHcWT
	 1gC6N4X1T4Llw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4472844464;
	Fri, 23 Oct 2026 09:45:30 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Date: Fri, 23 Oct 2026 15:15:28 +0530
Subject: [PATCH 1/2] dt-bindings: interconnect: qcom: Add SM7250 RPMh NoC
 bindings
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
Message-Id: <20261023-icc-sm7250-v1-1-1e47c1226857@brar.si>
References: <20261023-icc-sm7250-v1-0-1e47c1226857@brar.si>
In-Reply-To: <20261023-icc-sm7250-v1-0-1e47c1226857@brar.si>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ishu Brar <patches@brar.si>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792748728; l=8242;
 i=patches@brar.si; h=from:subject:message-id;
 bh=NccBBbDDuphPR80m3IPK9e90vIXBiLy3s2bwplat0Ac=;
 b=OfykcREVVxn+1+yArg+ckv7S4K6XQff1UZwlFcCFJ+JcQ//FhiBa+7u9zGSQH4bpEVAKRh3Ok
 1CEtst3KOaCCLXQtV7goi3QpNF8D+cB7vM8f96M5YoKwM77rIRBALQ1
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

Assisted-by: Claude
Signed-off-by: Ishu Brar <patches@brar.si>
---
 .../bindings/interconnect/qcom,sm7250-rpmh.yaml    | 102 ++++++++++++++
 .../dt-bindings/interconnect/qcom,sm7250-rpmh.h    | 151 +++++++++++++++++++++
 2 files changed, 253 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm7250-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm7250-rpmh.yaml
new file mode 100644
index 000000000..cb1327f6b
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sm7250-rpmh.yaml
@@ -0,0 +1,102 @@
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
+          - qcom,sm7250-ipa-virt
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
+        interconnect-ipa-virt {
+            compatible = "qcom,sm7250-ipa-virt";
+            #interconnect-cells = <2>;
+            qcom,bcm-voters = <&apps_bcm_voter>;
+        };
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
index 000000000..a3b964438
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sm7250-rpmh.h
@@ -0,0 +1,151 @@
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
+#define MASTER_IPA_CORE			0
+#define SLAVE_IPA_CORE			1
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


