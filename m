Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36823C432C3
	for <linux-pm@archiver.kernel.org>; Fri, 12 Mar 2021 15:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1638664F72
	for <linux-pm@archiver.kernel.org>; Fri, 12 Mar 2021 15:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhCLPwi (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 12 Mar 2021 10:52:38 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55864 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbhCLPwa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 10:52:30 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id AF29D1F46E80
Received: by jupiter.universe (Postfix, from userid 1000)
        id 5B931480107; Fri, 12 Mar 2021 16:44:08 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 21/38] dt-bindings: power: supply: max14656: Convert to DT schema format
Date:   Fri, 12 Mar 2021 16:43:40 +0100
Message-Id: <20210312154357.1561730-22-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210312154357.1561730-1-sebastian.reichel@collabora.com>
References: <20210312154357.1561730-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the binding to DT schema format.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/power/supply/maxim,max14656.txt  | 23 ----------
 .../bindings/power/supply/maxim,max14656.yaml | 45 +++++++++++++++++++
 2 files changed, 45 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max14656.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max14656.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max14656.txt b/Documentation/devicetree/bindings/power/supply/maxim,max14656.txt
deleted file mode 100644
index f956247d493e..000000000000
--- a/Documentation/devicetree/bindings/power/supply/maxim,max14656.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Maxim MAX14656 / AL32 USB Charger Detector
-
-Required properties :
-- compatible : "maxim,max14656";
-- reg: i2c slave address
-- interrupts: interrupt line
-
-Example:
-
-&i2c2 {
-	clock-frequency = <50000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-
-	max14656@35 {
-		compatible = "maxim,max14656";
-		reg = <0x35>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_charger_detect>;
-		interrupt-parent = <&gpio6>;
-		interrupts = <26 IRQ_TYPE_LEVEL_HIGH>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max14656.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max14656.yaml
new file mode 100644
index 000000000000..0a41078ebd99
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max14656.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/maxim,max14656.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Maxim MAX14656 DT bindings
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: maxim,max14656
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      charger-detector@35 {
+        compatible = "maxim,max14656";
+        reg = <0x35>;
+        interrupt-parent = <&gpio6>;
+        interrupts = <26 IRQ_TYPE_LEVEL_HIGH>;
+      };
+    };
-- 
2.30.1

