Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795804724;
	b=AyWRjLwDYQVvlsyODqVP+Gv6Uq0jCBKsasziClbqRIiN92u6zzF46VtuI4wn/LnZo2p5
	 mN35a8sb+TbE0fRvol5P98LEE0p7hcX1Dg26lh6XGeVRp2/xr8kr0kto4JTnJDuNiRJvi
	 18w+RU83JqJlX1b25d0vgN8NuEMMXuMUcuSAoBggIeWyNMHvWvlyQYPtZhl7uu3mrVl3/
	 P6dB9vAnQoHegmy+mLoqp7DfizubTUHXJU2pYmtxZDeElld4uQQOUXDoWv1ZKkc7l+Rhn
	 SBxMkwCjKrWBk+osaSQVa/narYEUK+AG0sXJHPrfzhu8kBz04QgaM/zyQqvHGPI7ExA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804724;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jUyHnLRkW1QULvm5PRsrhM1AWKZBc9s0L1P7hWt5rR0=;
	b=XqKkrqJE4JKMW29i5OTHJ5eioqVbNrvcrjG9lXvRznVyTEmg/cjQ7gIyQ/WJVrTPbGNa
	 7fSGbY1froNgZ9O7AeJEETuHOxZG4CCkq56VUXJAVF/In6sBDey+/6hf9319AKpq9oD3b
	 hjordtcHswzaA4/6+BhbDJCuHJXzPQHYDJNcijoE2C9jvnAb/0YkSZ2gwy7Pc/mg9EjYC
	 ZuTmUZ/DKVgmG5qGcfCzNPm/D4yXkSQeKOdXY6gLNAh8PMkm7COcn/92v/Woy0s2br/TS
	 qDTiN2K+VLnDycanTgRo/w2bt8DsZOgfr80i990vLbCnhwzeKoJNOFu6EwguBkMFjNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=go8xZ+1i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07FD606A31F;
	Fri, 27 Nov 2026 18:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=go8xZ+1i
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795804723;
	b=2r+CP+wkB7ssnw+8b3mB5ib6SsxmulDyBfH5l8ynsJH06zAJpqubfjL3ZrJbZmQi7oVe
	 /Gx/mG/oSgfjOzM/goJyfyA7K+h9wr8KASYBygrp4FAlY251l4Z6MHzZ4mw2T0vrMyHHG
	 uK1gkJs/VoU3Nh70Wzd7ug+10RtwtcdkNmlAonTe1yALv+YmCrKS6hfUEc3CXtr1w6duk
	 lmf9+huzc6pWGC34iRfr66HUtsAFa1CxHXjsLPGgvEq2mFNL/YNYJRWjqTCRSfOMZmZbC
	 UpXTc/as/Fl/XwOOJeYwPrMwlUHpm2yj7Fzgo55GqM7OxebIDW6YSjVlLH59e/RRABQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795804723;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jUyHnLRkW1QULvm5PRsrhM1AWKZBc9s0L1P7hWt5rR0=;
	b=YwxbbUSLlVSvmCdXP5fUnUkalrygc2Va9S0lp+pwr7md296qWp2z68KNHhsUKiZNRb9z
	 72h34Qag2zzzm+xXLFy+Br4SWseRgq0X4LqjFFy8Ins43gb3jDtJn1ehk3racO2zavoPk
	 3NcHZC9pr/4fwXHIQT8vTkvi0TYxNnoeUMjHKZaUIqEl1mZRwE7Nq2l9JcJlBVyNI5n0B
	 YS2jotIwkoG315H6gbsx7kg12V1EGi8T11/GagrKylqsoouVvZtOmmLOE3oFo+hhZ+x7t
	 Wwwi7IvPjDLY3IyxSgMs22dYv7Ok5AtHc96bdgwa7GUhbPAt6+E9noNpyHj++G8L7jA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A67DE1F00899;
	Fri, 27 Nov 2026 18:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795804723;
	bh=jUyHnLRkW1QULvm5PRsrhM1AWKZBc9s0L1P7hWt5rR0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=go8xZ+1iM1pDhLqqfhZv68br2KONdtAuXhFJscFuvw/5Phz/2vsQXpTmTyZrSQent
	 v75zzXgobfM4SOTpnRzB9nzgd36SIY3t4et70tas6H0T22u/4ZFCaXbtB72kV23DAz
	 eLgoTDB9b0/8D9AU83i6wwd5sfKE0wWaQk8PkOJb1+J6sBSz4Ica29cUo+KklfVvwN
	 sT88KxBHvFmgRHtjRxm35RnwoCI+4Hhm4qEf8bnL6TvSWA0ajasJGbL3heLSDvlm6W
	 EWjET0pFl0Xqt9xTq7qCGL72jX1L6vd2qcWbW8BcXgVUSf0o6qPBrqfAds5OLkxNEE
	 urnMdXYKptfTQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3115E4DD1C;
	Fri, 27 Nov 2026 18:38:32 +0000 (UTC)
From: Venkat Yadlapati via B4 Relay <devnull+venkat.yadlapati.yahoo.com@kernel.org>
Date: Sat, 28 Nov 2026 00:08:31 +0530
Subject: [PATCH 1/2] dt-bindings: interconnect: qcom: Add Molokai RPMh NoC
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
Message-Id: <20261128-molokai-icc-v1-1-a5e1754f086d@yahoo.com>
References: <20261128-molokai-icc-v1-0-a5e1754f086d@yahoo.com>
In-Reply-To: <20261128-molokai-icc-v1-0-a5e1754f086d@yahoo.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
 Venkat Yadlapati <venkat.yadlapati@yahoo.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795804710; l=6144;
 i=venkat.yadlapati@yahoo.com; s=20261023; h=from:subject:message-id;
 bh=Xxt8D8wMK92grXZn8O4mppTs+YgJ/y35V+I07aULN64=;
 b=WdbQ75oZj0nU64WpFqTLszvav7+JOUQytzEfViXsY/Gvs3fXrto4Gir1fW5QJ2rVkn5UdedSp
 HjOa2yBRN97AA5/S7gc9lboABxBq2dTHutc3KrDdQIxjgyDBv99XH7S
X-Developer-Key: i=venkat.yadlapati@yahoo.com; a=ed25519;
 pk=e8KStCtEMvUP1Se/riB/KVnDAQFEVR2Dw2PcuA8/eME=
X-Endpoint-Received: by B4 Relay for venkat.yadlapati@yahoo.com/20261023
 with auth_id=1303
X-Original-From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
Reply-To: venkat.yadlapati@yahoo.com
Content-Transfer-Encoding: 7bit

From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>

Document the RPMh Network-On-Chip interconnect providers of the Qualcomm
Molokai (SM8845) SoC.

Molokai is close to Kaanapali, but its NoCs differ: the aggregate NoC is
split into aggre1 (0x16e0000) and aggre2 (0x1700000), the MMSS NoC config
and service ports are split into HF and SF halves, and some masters and
slaves are missing. aggre1 needs the UFS and USB3 AXI clocks for QoS
programming, aggre2 the IPA clock.

The header keeps the Kaanapali IDs for every node the two SoCs share and
adds only the new MMSS config nodes, so molokai.dtsi can keep the
interconnect paths it inherits from kaanapali.dtsi.

Signed-off-by: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
---
 .../bindings/interconnect/qcom,molokai-rpmh.yaml   | 144 +++++++++++++++++++++
 .../dt-bindings/interconnect/qcom,molokai-rpmh.h   |  26 ++++
 2 files changed, 170 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,molokai-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,molokai-rpmh.yaml
new file mode 100644
index 000000000000..fd94f6dae1a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,molokai-rpmh.yaml
@@ -0,0 +1,144 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,molokai-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on Molokai
+
+maintainers:
+  - Venkat Yadlapati <venkat.yadlapati@yahoo.com>
+
+description: |
+  RPMh interconnect providers support system bandwidth requirements through
+  RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
+  able to communicate with the BCM through the Resource State Coordinator (RSC)
+  associated with each execution environment. Provider nodes must point to at
+  least one RPMh device child node pertaining to their RSC and each provider
+  can map to multiple RPMh resources.
+
+  See also: include/dt-bindings/interconnect/qcom,molokai-rpmh.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,molokai-aggre1-noc
+      - qcom,molokai-aggre2-noc
+      - qcom,molokai-clk-virt
+      - qcom,molokai-cnoc-cfg
+      - qcom,molokai-cnoc-main
+      - qcom,molokai-gem-noc
+      - qcom,molokai-lpass-ag-noc
+      - qcom,molokai-lpass-lpiaon-noc
+      - qcom,molokai-lpass-lpicx-noc
+      - qcom,molokai-mc-virt
+      - qcom,molokai-mmss-noc
+      - qcom,molokai-nsp-noc
+      - qcom,molokai-pcie-anoc
+      - qcom,molokai-system-noc
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
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,molokai-clk-virt
+              - qcom,molokai-mc-virt
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
+              - qcom,molokai-pcie-anoc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre-NOC PCIe AXI clock
+            - description: cfg-NOC PCIe a-NOC AHB clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,molokai-aggre1-noc
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
+              - qcom,molokai-aggre2-noc
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
+              - qcom,molokai-aggre1-noc
+              - qcom,molokai-aggre2-noc
+              - qcom,molokai-pcie-anoc
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
+    clk_virt: interconnect-0 {
+      compatible = "qcom,molokai-clk-virt";
+      #interconnect-cells = <2>;
+      qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    aggre1_noc: interconnect@16e0000 {
+      compatible = "qcom,molokai-aggre1-noc";
+      reg = <0x016e0000 0x16400>;
+      #interconnect-cells = <2>;
+      clocks = <&gcc_aggre_ufs_phy_axi_clk>,
+               <&gcc_aggre_usb3_prim_axi_clk>;
+      qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    aggre2_noc: interconnect@1700000 {
+      compatible = "qcom,molokai-aggre2-noc";
+      reg = <0x01700000 0x22400>;
+      #interconnect-cells = <2>;
+      clocks = <&rpmhcc_ipa_clk>;
+      qcom,bcm-voters = <&apps_bcm_voter>;
+    };
diff --git a/include/dt-bindings/interconnect/qcom,molokai-rpmh.h b/include/dt-bindings/interconnect/qcom,molokai-rpmh.h
new file mode 100644
index 000000000000..88efa9f1d7a7
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,molokai-rpmh.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Molokai interconnect IDs
+ *
+ * Molokai keeps the Kaanapali node IDs for every node the two SoCs share,
+ * so this only adds the nodes Kaanapali does not have. On Molokai the
+ * aggre1-noc and aggre2-noc providers use the Kaanapali aggre-noc IDs,
+ * and cnoc-main also carries SLAVE_PCIE_CFG.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_MOLOKAI_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_MOLOKAI_H
+
+#include <dt-bindings/interconnect/qcom,kaanapali-rpmh.h>
+
+/* cnoc-cfg */
+#define SLAVE_CNOC_MNOC_HF_CFG			36
+#define SLAVE_CNOC_MNOC_SF_CFG			37
+
+/* mmss-noc */
+#define MASTER_CNOC_MNOC_HF_CFG			15
+#define MASTER_CNOC_MNOC_SF_CFG			16
+#define SLAVE_SERVICE_MNOC_HF			17
+#define SLAVE_SERVICE_MNOC_SF			18
+
+#endif

-- 
2.56.1


