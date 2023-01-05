Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658F1C4708E
	for <linux-pm@archiver.kernel.org>; Thu,  5 Jan 2023 18:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbjAESeU (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 5 Jan 2023 13:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbjAESds (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Jan 2023 13:33:48 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C5F0564CE;
        Thu,  5 Jan 2023 10:33:46 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,303,1665414000"; 
   d="scan'208";a="145303723"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Jan 2023 03:33:45 +0900
Received: from mulinux.example.org (unknown [10.226.92.64])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 18C2940065A8;
        Fri,  6 Jan 2023 03:33:39 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: mfd: Add RZ/V2M PWC
Date:   Thu,  5 Jan 2023 18:33:18 +0000
Message-Id: <20230105183319.144366-2-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230105183319.144366-1-fabrizio.castro.jz@renesas.com>
References: <20230105183319.144366-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Renesas RZ/V2M External Power Sequence Controller (PWC)
IP is a multi-function device, and it's capable of:
* external power supply on/off sequence generation
* on/off signal generation for the LPDDR4 core power supply (LPVDD)
* key input signals processing
* general-purpose output pins

Add the corresponding dt-bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

v1->v2: I have dropped syscon, simple-mfd, regmap, offset, and the child nodes.
v2->v3: No change.

 .../bindings/mfd/renesas,rzv2m-pwc.yaml       | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/renesas,rzv2m-pwc.yaml

diff --git a/Documentation/devicetree/bindings/mfd/renesas,rzv2m-pwc.yaml b/Documentation/devicetree/bindings/mfd/renesas,rzv2m-pwc.yaml
new file mode 100644
index 000000000000..e6794c5152d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/renesas,rzv2m-pwc.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/renesas,rzv2m-pwc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/V2M External Power Sequence Controller (PWC)
+
+description: |+
+  The PWC IP found in the RZ/V2M family of chips comes with the below
+  capabilities
+    - external power supply on/off sequence generation
+    - on/off signal generation for the LPDDR4 core power supply (LPVDD)
+    - key input signals processing
+    - general-purpose output pins
+
+maintainers:
+  - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a09g011-pwc # RZ/V2M
+          - renesas,r9a09g055-pwc # RZ/V2MA
+      - const: renesas,rzv2m-pwc
+
+  reg:
+    maxItems: 1
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+  renesas,rzv2m-pwc-power:
+    description: The PWC is used to control the system power supplies.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - '#gpio-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    pwc: pwc@a3700000 {
+      compatible = "renesas,r9a09g011-pwc", "renesas,rzv2m-pwc";
+      reg = <0xa3700000 0x800>;
+      gpio-controller;
+      #gpio-cells = <2>;
+      renesas,rzv2m-pwc-power;
+    };
-- 
2.34.1

