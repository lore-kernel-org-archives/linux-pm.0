Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.47.186.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516834;
	b=SkSf8E1oozgdoZLX43LbEfMhOh6p2QVObDRjPOicd2aQ3x5xtXa/w1Dvg81v5qtOr6a+
	 EDXFEQW8QnGlHrWTIcud9Cc1YI2Wuyzw/VcTs4LfqCL4AgusxFjE2sllv0QSSv8Bgrysr
	 bUTRf+kwToUIjcrjJWWEPT5SHT0G95qvzQISTXfCIi+M9vo8j3lrN4KpJIKyC/1+y53GM
	 OvhfEWpZ1g6dcgJk5JJXEDRt1CZvNU9TJtINupy4q1RMKtm/WMr+9cOefgWAqwC2dlaCp
	 t91C1+o+HA757vHVX/vnllxU9+SnhQEXkAllf9534uVUaiTnZjL3awmoz+V+6iRSlGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516834;
	h=DMARC-Filter:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ugVpAzrKRIDwD3UvXW7zHcPMnBCkzuYJI8KmO/cIlDs=;
	b=vm2kEiJStDG4MzTQ8yzv42zyl52zDYHUPdu4jTFVGKXoIol2lNgATx0c3r6ag3vLCHn6
	 dqYy+Vnl9emHMqftZriU7Lh4m3LMJOWp9WLTEmHodDxpEMdY6l0Bhpq1wBYnsDtJO9095
	 x2jAmdvmDlEtqawQNT8N/b1qdHTsCdKhYk8LV7uRTRfKbp1UetNP1m96QXNWMv3OwksXZ
	 7CkgcrM+Dtpq/1xij3ST245Bmh34UajjCGD9xbaCYWL01CDyyNp9HESoo0Q+yDPr/LKIF
	 5XK5V1u2s/sjBTBMqa8JZAQRaMevIhMi3GL4v9CKjwaNnMCY2BkygkQZbEJcokjdD/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=krgm.moe;
	spf=pass smtp.mailfrom=krgm.moe;
	arc=none smtp.remote-ip=103.47.186.116
Received: from krgm.moe (krgm.moe [103.47.186.116])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6586606A687;
	Tue, 24 Nov 2026 10:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6586606A687
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=krgm.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krgm.moe
Received: from [10.42.0.96] (unknown [114.242.206.180])
	by krgm.moe (Postfix) with ESMTPSA id AE22677B7;
	Tue, 24 Nov 2026 16:10:30 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
Date: Tue, 24 Nov 2026 18:39:39 +0800
Subject: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm Netrani
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
Message-Id: <20261124-netrani-interconnect-v1-v1-1-bb5efdb229cd@krgm.moe>
References: <20261124-netrani-interconnect-v1-v1-0-bb5efdb229cd@krgm.moe>
In-Reply-To: <20261124-netrani-interconnect-v1-v1-0-bb5efdb229cd@krgm.moe>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8553; i=prcups@krgm.moe;
 h=from:subject:message-id; bh=oKt7tT7DRJ0IB9qOrW6CoWfDmTULvCHP67hIDqEHK4Y=;
 b=owEBCQL2/ZANAwAIAV0dOJt2umJjAcsmYgBrBWl4H973MlilZiT8rDvMdhnUrKeN1YweM0QMj
 dZP60PWPESJAc8EAAEIADkWIQRSClJ2zjncUdNU0FFdHTibdrpiYwUCawVpeBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDIACgkQXR04m3a6YmPXPgv/ci+6fht3usgBWqsdyKm9KdpaLSBnmf6
 uAY5c9TCa3bRA2agyFZRfjbpNvUg7OjBTm/CAsf8sV702kjXByTFSI6mCA6xUjPxYAhDa+IfI9V
 oFLmjtauAHagpU2eFY6ghuNVslyVAiI1aUgK6rcylDJ5ooXLbxqzsr8N/WTLZgpf21YmCkNBcM4
 yWJ7wKgh/b+o0egjOup12P75ygH5WeYdXewB26/GaSbsuxSuKi9mId4V/5yCesWhRwwtF5UBnIw
 CaCLulG9xV3zp0iTyDNoLzkLt/dnjkU1eBf1Uym4C6rih+PUYIAKZdWmmH1S+8oAp5kukGwadw0
 l5ADF3XTvSGGEhJDEAgzAhbwG7zdbXfwr7uvlsZV6bHDRtAQP2FxriTics/Dp/blHALuX2nNpjB
 A3RXOi+7TPnNiKKPtKGBpqI8b6Ur9g5LYU9RUuLXtUGss3pjtHIn4u13gz66csxhSzrTycz+AA9
 HgU1iUXtWNncz5FmkmOMiPuU/qKdFHS
X-Developer-Key: i=prcups@krgm.moe; a=openpgp;
 fpr=520A5276CE39DC51D354D0515D1D389B76BA6263

Describe the Netrani RPMh interconnect providers and their register
access clocks.

Signed-off-by: SignKirigami <prcups@krgm.moe>
---
 .../bindings/interconnect/qcom,netrani-rpmh.yaml   | 131 ++++++++++++++++
 .../dt-bindings/interconnect/qcom,netrani-rpmh.h   | 169 +++++++++++++++++++++
 2 files changed, 300 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,netrani-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,netrani-rpmh.yaml
new file mode 100644
index 0000000000000..b2d36cd632d82
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,netrani-rpmh.yaml
@@ -0,0 +1,131 @@
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
+  RPMh interconnect providers on Netrani (parrot) communicate bandwidth
+  requests through Bus Clock Managers (BCMs) using the applications RSC.
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
+  clocks:
+    minItems: 1
+    maxItems: 2
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
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,netrani-pcie-anoc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: PCIe AXI clock
+            - description: PCIe ANOC AHB clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,netrani-aggre1-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: USB3 primary AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,netrani-aggre2-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: SDCC2 AHB clock
+            - description: IPA RPMh BCM clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,netrani-aggre1-noc
+              - qcom,netrani-aggre2-noc
+              - qcom,netrani-pcie-anoc
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
+    #include <dt-bindings/clock/qcom,netrani-gcc.h>
+
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
+        clocks = <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+...
diff --git a/include/dt-bindings/interconnect/qcom,netrani-rpmh.h b/include/dt-bindings/interconnect/qcom,netrani-rpmh.h
new file mode 100644
index 0000000000000..d13573792ea92
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

