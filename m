Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F16C4151A
	for <linux-pm@archiver.kernel.org>; Wed, 17 Mar 2021 13:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 690A964E86
	for <linux-pm@archiver.kernel.org>; Wed, 17 Mar 2021 13:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhCQNty (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 17 Mar 2021 09:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbhCQNtP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 09:49:15 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4161C06175F;
        Wed, 17 Mar 2021 06:49:14 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 56BA81F451B2
Received: by jupiter.universe (Postfix, from userid 1000)
        id 0062F480107; Wed, 17 Mar 2021 14:49:05 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 21/38] dt-bindings: power: supply: max14656: Convert to DT schema format
Date:   Wed, 17 Mar 2021 14:48:47 +0100
Message-Id: <20210317134904.80737-22-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210317134904.80737-1-sebastian.reichel@collabora.com>
References: <20210317134904.80737-1-sebastian.reichel@collabora.com>
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
2.30.2

