Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795806365;
	b=wTRvjZ5Bh9/9vdm3EzcRQXv9gTTdeh3F0C4TfIzgx4jFday5V8uD407AhA3cda5fHys7
	 eWBvRT6Ru+4qDnVfH0PrjU5pV/2nc28vSrwTO312+w21NtzWYLKy91hoHoq0VsEVyIDLJ
	 M5K+FyDLF4ZCI0on1yoRtad0iLdsmXPkMp/Mq1cRCNZQkKHIz1lr/SnVC7HJOEeIsGO4E
	 WtKzAd8h2MZWIGeHWDXf+z45h1dXlULg+bZEK5Q1eLdAXJ4w4x6jysh1kttf66rNCQ759
	 hTIHg+GLOBH4Dgf8zhWbeSyUk8QXJwrkuoRrWiBRZD/9R5GwrjaDiUqMW/pBQdLAeKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795806365;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jUyHnLRkW1QULvm5PRsrhM1AWKZBc9s0L1P7hWt5rR0=;
	b=3MaQegBSyl2t4F33JsO0oGr+t8xRjUYG2PNKAFxXjJdEE+TeB2CprtpVDOgZVVFeW7QO
	 gwfpWn65YRCdbr2HSnSBdx3dG1cMs2Tl8mUiFMHdJamRdxwuq6RrjiMwj7cLSsKXle2n8
	 Sf6vP88PK6jXKfJCFROqXBAMQ+tAqeHgDrhC51tZR5K5UWOSB3skgwY03jRjUNvZptAP+
	 w+tR5B/KqZk3Grh3BhRPlp7oHQEwpktoeMnyvE29f7OVWxzs1mCEz0lNlsOX4mnTgceAA
	 0u/f3No6MFt8DS7vRBNvn8ZCkOLVnuEt2HlLDtPS1Wzb3QVhO29Lf3a3O7lNifFiAyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KGRaLgc9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A15606A338;
	Fri, 27 Nov 2026 19:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KGRaLgc9
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795806364;
	b=VsAQBKmtGh4DyTxYUUPPZLTc9DaILB+QTbHgLvMNHhyScapvqe2+CyOsRh62X2dJaH4X
	 CFhcBb6fVSFN2/GSt7DKQhTc4lxotZv51WUVP0GLvvvuuXeHFlRNo+gXJ4/WQobUBF6D+
	 N74udKG1NDLR2ZEJ6csPGSV6Jtr1kB1jK+QDJPapvl1oLKRIFq4lJmuS2/uwz+JN2phCs
	 2ds2MXZib/ROKTjnXzrouQ4V/Zpfx81M4uUwAfAFC2GjHUFrdi3g4fcMcV7PGXTboubXg
	 LCxSBHus6zlOjMMbB+Gdc+rF+g9HiAdiI9P/Ogs4KP6pP29EQ15e67i/AHHPbZ2a9nA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795806364;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jUyHnLRkW1QULvm5PRsrhM1AWKZBc9s0L1P7hWt5rR0=;
	b=rG79n8qz+Wynl5U77fpHF03CXt0vmcMmDH3Ky0bHRHPQlR0phbWxPr60dRjX9XxycKxD
	 mmxhbvyIY29d41TGitVkqUXWfstcTfYRvX3RLcjNw0BrbzcKoSqaIe7esOvnqOFKP+RfY
	 bREzbSChUkuzYnOIOZ0f2gH+jHTx0P/YuWB78RTKArUOIW58Pc5DqywDi1NuY81HeT95p
	 ThXOfgpC47RuKhquNliLloc4lsiR6TWA1v9JHgp8m13/6VIHst5WThG3ItwoSamYXVfT0
	 Jg7XHonmMzXojw+hgte/QQ07nj9stMuB6R4NF/AnB3aBaVbfQaKyKi0hbtmSKkrEqSw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7438E1F0089A;
	Fri, 27 Nov 2026 19:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795806364;
	bh=jUyHnLRkW1QULvm5PRsrhM1AWKZBc9s0L1P7hWt5rR0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=KGRaLgc9n3SW9QHC9ukveqMiCl5Gvjqi8D2pdUFn0JLgYJrcXbh8gb17cZyttYhA6
	 P4JufPNnn3w7Jd+HrCNn8F8taqKzMzaFVQXq5t01rrSZFMyd0gGNkn7oVNPw27x16m
	 6GIQmjlnY2AuoDtSIkGMMJAmMAMVQmk82A8ftevI5zbOygEYbWaXpQC4sMKwElLGHZ
	 K038yrbnN0objOh6FNXijQfdNeuMEW2nT1xHnMmA73zvAYN0VfgOKqrjgRBexBl6zr
	 rPuKbEjX/EOXTEtG+Kl9QYlCPkFOIuFdNnJW0WYcWLB7Sp4WiXYES+92d8U5T0ZPnK
	 xApccGj+m7aYg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 00CE84DD77;
	Fri, 27 Nov 2026 19:05:54 +0000 (UTC)
From: Venkat Yadlapati via B4 Relay <devnull+venkat.yadlapati.yahoo.com@kernel.org>
Date: Sat, 28 Nov 2026 00:35:53 +0530
Subject: [PATCH v2 1/2] dt-bindings: interconnect: qcom: Add Molokai RPMh
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
Message-Id: <20261128-molokai-icc-v2-1-7806842d166b@yahoo.com>
References: <20261128-molokai-icc-v2-0-7806842d166b@yahoo.com>
In-Reply-To: <20261128-molokai-icc-v2-0-7806842d166b@yahoo.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795806352; l=6144;
 i=venkat.yadlapati@yahoo.com; s=20261023; h=from:subject:message-id;
 bh=Xxt8D8wMK92grXZn8O4mppTs+YgJ/y35V+I07aULN64=;
 b=uvSIv40tP9LTLYHLrFSmhq/uXmDIYkGSkvywDUM+198kUqAUo9DD3zjfSuCwkjUiJ5fp9RQeo
 ZTqs8a0ADz3C7RQRmWc5gztvhi/UDswVyhUfPfFSMRzL4rw9NWRuzo2
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


