Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.47.186.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619467;
	b=JdwnPw5CJV1gmSzbBqtf5e9E2wLuXfANLmRt8pOjT0AyUfJm6Kny8foyKJkusaJvLKTE
	 BKHnaZWpu9jdsXKUy0cFAiHFZVggfAVLNFHZvcogkuf7s4iv898oPWDk/lGdbDIVbhMsk
	 O04hD+L4NJYyoW8q2CKF5gqSk9R7n58g4iaVRdmigh0pK3NnM0kQz/51uj2vD9sR3VcHz
	 RI3bI/qr2S8TDlS0uyacqOYMQTere6bjfbHz0Hwzhj2aWMpNOAVg37vwaCo9m7WPYdm4A
	 R/l9BYIUqD9EVMDaaGwyeaPIDeVZ58sG3Tr7bIxmMs154Z9MB57CWtn8f4UjFfgR9+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619467;
	h=DMARC-Filter:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=drBy3hL6KwxHBhNonmFa34I0uyR+LFO1bY6d8UYU1NI=;
	b=w5qAs+wX7z2duyhOTozZomBlA1gG4ywPuU0Z4DxyeeCEC1cU9L6i8nx48a/8GKQpjkFI
	 9ldIlj/XHhaZPac/S51labR7XlV0bOKXcH53rRb6gFaEWThlhlK06V2VseZd0Omf5n36d
	 cMAoE+9ZLfxkfxKvYcgrWbgU9FIGeK8zQ+9Iolied0Y4dHB3dnVUOEBlTtthnDnidJ6bn
	 +7WMrBFqj87ygYYrymueXGta1FmhnJtmaL02iJ2bqNK7yi4QAJtiL5Piv2kDgH8Vv4qfT
	 MzLGvOzrpA5Ammqn4PLizShnPT5DFNrKEp3TCbtanLEBLywgaGXz4RbSJ5VphGAB+1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=krgm.moe;
	spf=pass smtp.mailfrom=krgm.moe;
	arc=none smtp.remote-ip=103.47.186.116
Received: from krgm.moe (krgm.moe [103.47.186.116])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4FA606A331;
	Wed, 25 Nov 2026 15:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D4FA606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=krgm.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krgm.moe
Received: from yuno-laptop.local (unknown [103.47.186.116])
	by krgm.moe (Postfix) with ESMTPSA id 4C1C5859;
	Wed, 25 Nov 2026 20:41:03 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
Date: Wed, 25 Nov 2026 23:10:28 +0800
Subject: [PATCH v2 1/2] dt-bindings: interconnect: Add Qualcomm Netrani
 RPMh interconnect bindings
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
Message-Id: <20261125-netrani-interconnect-v2-v2-1-4eab92854137@krgm.moe>
References: <20261125-netrani-interconnect-v2-v2-0-4eab92854137@krgm.moe>
In-Reply-To: <20261125-netrani-interconnect-v2-v2-0-4eab92854137@krgm.moe>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, SignKirigami <prcups@krgm.moe>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7668; i=prcups@krgm.moe;
 h=from:subject:message-id; bh=rqSdbwdG7muDa+HRQnpOeBGd01qZ7LvI9VtwR7gxD3I=;
 b=owEBCQL2/ZANAwAIAUNLJdlxtMKiAcsmYgBrBvqC7jVJANLIBKcJkTyKOLjGhbxF5wbpdtugh
 naKuO4sJ+qJAc8EAAEIADkWIQQKI/ZJLAWGn9r1JLZDSyXZcbTCogUCawb6ghsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQQ0sl2XG0wqKycgwA0S1yGd6gdJtgg/rfE7MzpEh1zH8B8qk
 dYgZ65CzfogHG4K39Gwy0RZ1SUYN0eRgVy3d4d1Lvxb//8ddkRQzpQz+OIlRKxEdk0tlo1CS1zi
 t4VEFTceFIpied1DHlGHa3OsP1vAiXsba8DOire2hvyA2za72QZzunGuG3JDemZADjVh/RqSzEN
 +Lxl+sOsWYVByHjcvxqerGVoXPJlXveF1w9i11uIKmxnStjrwLGgMvc/fTzjCkroQeJ/3XW0u6h
 JbJkRAmiJBVBv77H9aTpueND2xUWL/ZtTS59V9gm/9dmkV2CwjuQ3IQDcArRxmbWO9SkECZhNNP
 1kNGZqd14BoVpam2iq1hpAXUo4H8mDr2ogVWC4ZfRWrcy8EOqF2HtOvME5Vcr7Ynr6LHh/SCMRm
 gG7pJwtbtx+pbPdQhp5m9MDSKAyod2F0g3QWyDSlLBOd2KMMorisZ7c7nt4gDrAUCTG0eQk0pyG
 Ba5rQiW+LFkbYILOY6ZgV2/SDlP1nQC
X-Developer-Key: i=prcups@krgm.moe; a=openpgp;
 fpr=0A23F6492C05869FDAF524B6434B25D971B4C2A2

Document the twelve Netrani RPMh interconnect provider compatibles and add
the interconnect port-ID header used by future DTS consumers. The master
and slave IDs in that header form part of the devicetree ABI.

Signed-off-by: SignKirigami <prcups@krgm.moe>
---
 .../bindings/interconnect/qcom,netrani-rpmh.yaml   |  77 ++++++++++
 .../dt-bindings/interconnect/qcom,netrani-rpmh.h   | 169 +++++++++++++++++++++
 2 files changed, 246 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,netrani-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,netrani-rpmh.yaml
new file mode 100644
index 000000000..8857d2a67
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,netrani-rpmh.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,netrani-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on Netrani
+
+maintainers:
+  - SignKirigami <prcups@krgm.moe>
+
+description: |
+  RPMh interconnect providers support system bandwidth requirements through
+  RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
+  able to communicate with the BCM through the Resource State Coordinator (RSC)
+  associated with each execution environment. Provider nodes must point to at
+  least one RPMh device child node pertaining to their RSC and each provider
+  can map to multiple RPMh resources.
+
+  See also: include/dt-bindings/interconnect/qcom,netrani-rpmh.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,netrani-aggre1-noc
+      - qcom,netrani-aggre2-noc
+      - qcom,netrani-clk-virt
+      - qcom,netrani-cnoc2
+      - qcom,netrani-cnoc3
+      - qcom,netrani-gem-noc
+      - qcom,netrani-lpass-ag-noc
+      - qcom,netrani-mc-virt
+      - qcom,netrani-mmss-noc
+      - qcom,netrani-nsp-noc
+      - qcom,netrani-pcie-anoc
+      - qcom,netrani-system-noc
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+
+allOf:
+  - $ref: qcom,rpmh-common.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,netrani-clk-virt
+              - qcom,netrani-mc-virt
+    then:
+      properties:
+        reg: false
+    else:
+      required:
+        - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    interconnect-0 {
+        compatible = "qcom,netrani-clk-virt";
+        #interconnect-cells = <1>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    interconnect@16e0000 {
+        compatible = "qcom,netrani-aggre1-noc";
+        reg = <0x016e0000 0x1c080>;
+        #interconnect-cells = <1>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+...
diff --git a/include/dt-bindings/interconnect/qcom,netrani-rpmh.h b/include/dt-bindings/interconnect/qcom,netrani-rpmh.h
new file mode 100644
index 000000000..d13573792
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,netrani-rpmh.h
@@ -0,0 +1,169 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_NETRANI_RPMH_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_NETRANI_RPMH_H
+
+/* AGGRE1 NOC */
+#define MASTER_QSPI_0	0
+#define MASTER_QUP_0	1
+#define MASTER_A1NOC_CFG	2
+#define MASTER_SDCC_1	3
+#define MASTER_UFS_MEM	4
+#define MASTER_USB3_0	5
+#define SLAVE_A1NOC_SNOC	6
+#define SLAVE_SERVICE_A1NOC	7
+
+/* AGGRE2 NOC */
+#define MASTER_QDSS_BAM	0
+#define MASTER_QUP_1	1
+#define MASTER_A2NOC_CFG	2
+#define MASTER_CNOC_A2NOC	3
+#define MASTER_CRYPTO	4
+#define MASTER_IPA	5
+#define MASTER_QDSS_ETR	6
+#define MASTER_QDSS_ETR_1	7
+#define MASTER_SDCC_2	8
+#define SLAVE_A2NOC_SNOC	9
+#define SLAVE_SERVICE_A2NOC	10
+
+/* CLK VIRT */
+#define MASTER_QUP_CORE_0	0
+#define MASTER_QUP_CORE_1	1
+#define SLAVE_QUP_CORE_0	2
+#define SLAVE_QUP_CORE_1	3
+
+/* CNOC2 */
+#define MASTER_CNOC3_CNOC2	0
+#define MASTER_QDSS_DAP	1
+#define SLAVE_AHB2PHY_SOUTH	2
+#define SLAVE_AHB2PHY_NORTH	3
+#define SLAVE_ANOC_THROTTLE_CFG	4
+#define SLAVE_CAMERA_CFG	5
+#define SLAVE_CLK_CTL	6
+#define SLAVE_RBCPR_CX_CFG	7
+#define SLAVE_RBCPR_MX_CFG	8
+#define SLAVE_CRYPTO_0_CFG	9
+#define SLAVE_CX_RDPM	10
+#define SLAVE_DISPLAY_CFG	11
+#define SLAVE_GFX3D_CFG	12
+#define SLAVE_IMEM_CFG	13
+#define SLAVE_IPA_CFG	14
+#define SLAVE_IPC_ROUTER_CFG	15
+#define SLAVE_LPASS	16
+#define SLAVE_CNOC_MSS	17
+#define SLAVE_MX_RDPM	18
+#define SLAVE_PCIE_0_CFG	19
+#define SLAVE_PDM	20
+#define SLAVE_PIMEM_CFG	21
+#define SLAVE_PMU_WRAPPER_CFG	22
+#define SLAVE_PRNG	23
+#define SLAVE_QSPI_0	24
+#define SLAVE_QUP_0	25
+#define SLAVE_QUP_1	26
+#define SLAVE_SDC1	27
+#define SLAVE_SDCC_2	28
+#define SLAVE_TCSR	29
+#define SLAVE_TLMM	30
+#define SLAVE_UFS_MEM_CFG	31
+#define SLAVE_USB3_0	32
+#define SLAVE_VENUS_CFG	33
+#define SLAVE_VSENSE_CTRL_CFG	34
+#define SLAVE_A1NOC_CFG	35
+#define SLAVE_A2NOC_CFG	36
+#define SLAVE_CNOC2_CNOC3	37
+#define SLAVE_CNOC_MNOC_CFG	38
+#define SLAVE_PCIE_ANOC_CFG	39
+#define SLAVE_SNOC_CFG	40
+
+/* CNOC3 */
+#define MASTER_CNOC2_CNOC3	0
+#define MASTER_GEM_NOC_CNOC	1
+#define MASTER_GEM_NOC_PCIE_SNOC	2
+#define SLAVE_AOSS	3
+#define SLAVE_APPSS	4
+#define SLAVE_CDSP_CFG	5
+#define SLAVE_QDSS_CFG	6
+#define SLAVE_TME_CFG	7
+#define SLAVE_WLAN	8
+#define SLAVE_CNOC3_CNOC2	9
+#define SLAVE_CNOC_A2NOC	10
+#define SLAVE_BOOT_IMEM	11
+#define SLAVE_IMEM	12
+#define SLAVE_PIMEM	13
+#define SLAVE_PCIE_0	14
+#define SLAVE_QDSS_STM	15
+#define SLAVE_TCU	16
+
+/* GEM NOC */
+#define MASTER_GPU_TCU	0
+#define MASTER_SYS_TCU	1
+#define MASTER_APPSS_PROC	2
+#define MASTER_GFX3D	3
+#define MASTER_MSS_PROC	4
+#define MASTER_MNOC_HF_MEM_NOC	5
+#define MASTER_MNOC_SF_MEM_NOC	6
+#define MASTER_COMPUTE_NOC	7
+#define MASTER_ANOC_PCIE_GEM_NOC	8
+#define MASTER_SNOC_GC_MEM_NOC	9
+#define MASTER_SNOC_SF_MEM_NOC	10
+#define MASTER_WLAN_Q6	11
+#define SLAVE_GEM_NOC_CNOC	12
+#define SLAVE_LLCC	13
+#define SLAVE_MEM_NOC_PCIE_SNOC	14
+
+/* LPASS AG NOC */
+#define MASTER_CNOC_LPASS_AG_NOC	0
+#define MASTER_LPASS_PROC	1
+#define SLAVE_LPASS_CORE_CFG	2
+#define SLAVE_LPASS_LPI_CFG	3
+#define SLAVE_LPASS_MPU_CFG	4
+#define SLAVE_LPASS_TOP_CFG	5
+#define SLAVE_LPASS_SNOC	6
+#define SLAVE_SERVICES_LPASS_AML_NOC	7
+#define SLAVE_SERVICE_LPASS_AG_NOC	8
+
+/* MC VIRT */
+#define MASTER_LLCC	0
+#define SLAVE_EBI1	1
+
+/* MMSS NOC */
+#define MASTER_CAMNOC_HF	0
+#define MASTER_CAMNOC_ICP	1
+#define MASTER_CAMNOC_SF	2
+#define MASTER_MDP	3
+#define MASTER_CNOC_MNOC_CFG	4
+#define MASTER_VIDEO_P0	5
+#define MASTER_VIDEO_PROC	6
+#define SLAVE_MNOC_HF_MEM_NOC	7
+#define SLAVE_MNOC_SF_MEM_NOC	8
+#define SLAVE_SERVICE_MNOC	9
+
+/* NSP NOC */
+#define MASTER_CDSP_NOC_CFG	0
+#define MASTER_CDSP_PROC	1
+#define SLAVE_CDSP_MEM_NOC	2
+#define SLAVE_SERVICE_NSP_NOC	3
+
+/* PCIE ANOC */
+#define MASTER_PCIE_ANOC_CFG	0
+#define MASTER_PCIE_0	1
+#define SLAVE_ANOC_PCIE_GEM_NOC	2
+#define SLAVE_SERVICE_PCIE_ANOC	3
+
+/* SYSTEM NOC */
+#define MASTER_GIC_AHB	0
+#define MASTER_A1NOC_SNOC	1
+#define MASTER_A2NOC_SNOC	2
+#define MASTER_LPASS_ANOC	3
+#define MASTER_SNOC_CFG	4
+#define MASTER_PIMEM	5
+#define MASTER_TME	6
+#define MASTER_GIC	7
+#define SLAVE_SNOC_GEM_NOC_GC	8
+#define SLAVE_SNOC_GEM_NOC_SF	9
+#define SLAVE_SERVICE_SNOC	10
+
+#endif

-- 
2.56.0

