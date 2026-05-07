Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C781D3FBED0;
	Thu,  7 May 2026 14:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778163954; cv=none; b=W5cQ0CTen3WkMbEgxbteamzm5Jp8Do9dret0+FTLbmhAEHXfs7Cl4mULIm09z5YX4cdZjxU+ByN7pEucMRir3h8/fYqsCKYlw4elT+HyBN2GLM4qaEml8jdWmYTKIIOG/ctPj2yN4lozdgzGydHOI7Q79NzV5SfyRgCYvSRcIuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778163954; c=relaxed/simple;
	bh=KdzwVU8IK1gqq04CutOwP5DDVNNDmSbJ+IC5PGAGMVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CMGEV89wD96hfjrVhXUmJzgLCjmriVKbUg6dxsHrdJ75A+uwms/gKmQMY55pJIBfCaQ1Y2gTKo9LUcGGoHz/dWifwcQv6NLfpAiBGWVXuHizjLcW+ZOeGEldwZY3gIfSHo8wcSPFivQfMd0zaFLKp8OfpfZdljpWLfivETaXxKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: esmtpgz12t1778163921t64ba066d
X-QQ-Originating-IP: T6wJUoRNjvM1mvNJs5gWMX633YucnQkbgVDKCEcdsWE=
Received: from [192.168.30.32] ( [116.234.74.217])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 07 May 2026 22:25:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10160670334267879407
EX-QQ-RecipientCnt: 11
From: Xilin Wu <sophon@radxa.com>
Date: Thu, 07 May 2026 22:25:12 +0800
Subject: [PATCH 1/3] dt-bindings: interconnect: qcom,sc8280xp-rpmh: Add reg
 and clocks for QoS
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-sc8280xp-qos-v1-1-15135858cd98@radxa.com>
References: <20260507-sc8280xp-qos-v1-0-15135858cd98@radxa.com>
In-Reply-To: <20260507-sc8280xp-qos-v1-0-15135858cd98@radxa.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4130; i=sophon@radxa.com;
 h=from:subject:message-id; bh=KdzwVU8IK1gqq04CutOwP5DDVNNDmSbJ+IC5PGAGMVs=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDJl/Fpy1lWQV8mo6kirlr9NmFfZZuUlij9qjBVxJ37IYv
 yt9tDDsKGVhEONikBVTZFGIZ5jLXpl77alYqR7MHFYmkCEMXJwCMJGzZQx/xXmNG/a/yT+QyTvR
 JDf6kf8hRds5e/dnG6/+VZo1Z1H2Y0aGfdIn37z7YxJ/N8Ngf9bu1aKiCyT/XgxT2hGYlZ0anLK
 bHwA=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NvWYEgjCCjcV+k+EafPwdwn55cC+XFjol/ttsc/ooOD78p6RivE/rBbk
	LwPsN33h8gb9KQBH6LYR405JOyZerMerGAi/Bf+XkKbpLJC4Gc0f8dKqZtU49gGLkCL7TjL
	bC6HO1go+rXpPxMNfT6l0ZffzbynHbTn8Vt9q2R0ZH3KxblVdn7+Cv/SteNGfe2ORmAgxa2
	DljJNF6dpqZbNyDkKGB3yxvKZcE2qjbk+G7fvTNYTazYHfMvLMVArBfEcfIUGe5wf9qAy9c
	clxpOEvu6qDixQvCkqSLeC3EECYNKcfIkmTiuFqgxx2DzgkSkShPl1Up6910Rm8DRq4gaRV
	vcH83M/xGHz3STMhPZnTBSO1AapLN4ctevVPPlcST4j1oXButtkNl+88crGjqWqddjY9c/Q
	cIMsXY8j/uoh4F9Fc4sFQwXCPGhJ6GMyPqTN7kpdj2hVrd0+Km/lIgucv3eJw92tQemTqz3
	8MjOG4VITx48oI2TThRovXhqP+OkspvKTESGX3b9aed2qL3YS07D9eTGIZeq9W9/6vc/jAb
	xexWZTDM3UkwpQf+9CnmRrJQtLNIFLWnxXLHJsUWd9buDelJXLTL2PLRwAGjwZ0u2CaHzZK
	A1kP5vM/pG1XXsqsag1WCNzWagDIrdVrMnXXRKPrxSaL3B127ytrkBtB2g5N7Ax2KapO8D7
	W3GTqlDhnz6OoNcvxCGfRgnM742zcgd7eAPPZvfxbR67dKdu6OzHZwI3DVXhejaNIrWY21t
	iLHaAm3EZtXwTzMA+JrPGaJW9OIu1lnVJi4wVOOKNVfuofJkl7fDPemvY09Lcywv9fTn75o
	zN+53jteZsnHhz3hsz7SvhftYurB1ffC9T6SVOAqP2QMF8MaBbcoksbg+IrkT4jLidVtZB3
	2/x9mPzWGuy2G/150x1kfGo9vVDR1ucv+tUJOHwn5/DJX2ORirHzlKw395lrloFrdxz3eWz
	7gVEnw7aMAxQhOsOgirxSuaTw4frKCuWI6kHZhAvZ0OxrynaGeMq4ECjUDd7j0wuPcqBplf
	YlbW51AOKtKbFkgP5w5NAq4VQeAtzoef9qbiyDQDyWU3Hegfu8pn9yxqjCm/E=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

Add the register range and clock properties needed for programming NoC QoS
configuration on SC8280XP.

Require a register range for the real NoC providers, require QoS clocks for
aggre1_noc and aggre2_noc, and keep the virtual clk_virt and mc_virt
providers without MMIO resources or clocks.

Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 .../bindings/interconnect/qcom,sc8280xp-rpmh.yaml  | 99 +++++++++++++++++++++-
 1 file changed, 98 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml
index 2a5a7594bafd..cd327a3bf3b9 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml
@@ -32,18 +32,115 @@ properties:
       - qcom,sc8280xp-nspb-noc
       - qcom,sc8280xp-system-noc
 
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 7
+    maxItems: 8
+
 required:
   - compatible
 
 allOf:
   - $ref: qcom,rpmh-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc8280xp-clk-virt
+              - qcom,sc8280xp-mc-virt
+    then:
+      properties:
+        reg: false
+        clocks: false
+    else:
+      required:
+        - reg
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc8280xp-aggre1-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre UFS PHY AXI clock
+            - description: aggre USB3 PRIM AXI clock
+            - description: aggre USB3 SEC AXI clock
+            - description: aggre USB3 MP AXI clock
+            - description: aggre USB4 AXI clock
+            - description: aggre USB4 1 AXI clock
+            - description: aggre USB NOC SOUTH AXI clock
+            - description: RPMH CC IPA clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc8280xp-aggre2-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre NOC PCIE0 tunnel AXI clock
+            - description: aggre NOC PCIE1 tunnel AXI clock
+            - description: aggre NOC PCIE 4 AXI clock
+            - description: aggre NOC PCIE SOUTH SF AXI clock
+            - description: aggre UFS CARD AXI clock
+            - description: DDRSS GPU AXI clock
+            - description: DDRSS PCIE SF TBU clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc8280xp-aggre1-noc
+              - qcom,sc8280xp-aggre2-noc
+    then:
+      required:
+        - clocks
+    else:
+      properties:
+        clocks: false
 
 unevaluatedProperties: false
 
 examples:
   - |
-    interconnect-0 {
+    #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+
+    interconnect {
+        compatible = "qcom,sc8280xp-clk-virt";
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    interconnect@9100000 {
+        compatible = "qcom,sc8280xp-gem-noc";
+        reg = <0x9100000 0xb8400>;
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    interconnect@16c0000 {
         compatible = "qcom,sc8280xp-aggre1-noc";
+        reg = <0x16c0000 0x3af80>;
         #interconnect-cells = <2>;
         qcom,bcm-voters = <&apps_bcm_voter>;
+        clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+                 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
+                 <&gcc GCC_AGGRE_USB3_SEC_AXI_CLK>,
+                 <&gcc GCC_AGGRE_USB3_MP_AXI_CLK>,
+                 <&gcc GCC_AGGRE_USB4_AXI_CLK>,
+                 <&gcc GCC_AGGRE_USB4_1_AXI_CLK>,
+                 <&gcc GCC_AGGRE_USB_NOC_SOUTH_AXI_CLK>,
+                 <&rpmhcc RPMH_IPA_CLK>;
     };

-- 
2.54.0

