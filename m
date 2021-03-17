Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D9DC2BB85
	for <linux-pm@archiver.kernel.org>; Wed, 17 Mar 2021 13:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0019064F70
	for <linux-pm@archiver.kernel.org>; Wed, 17 Mar 2021 13:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhCQNtu (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 17 Mar 2021 09:49:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56180 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbhCQNtO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 09:49:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 5802C1F451CA
Received: by jupiter.universe (Postfix, from userid 1000)
        id 02B12480108; Wed, 17 Mar 2021 14:49:06 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 22/38] dt-bindings: power: supply: max17042: Convert to DT schema format
Date:   Wed, 17 Mar 2021 14:48:48 +0100
Message-Id: <20210317134904.80737-23-sebastian.reichel@collabora.com>
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
 .../power/supply/max17042_battery.txt         | 35 ---------
 .../bindings/power/supply/maxim,max17042.yaml | 78 +++++++++++++++++++
 2 files changed, 78 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/max17042_battery.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/max17042_battery.txt b/Documentation/devicetree/bindings/power/supply/max17042_battery.txt
deleted file mode 100644
index f34c5daae9af..000000000000
--- a/Documentation/devicetree/bindings/power/supply/max17042_battery.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-max17042_battery
-~~~~~~~~~~~~~~~~
-
-Required properties :
- - compatible : one of the following
- * "maxim,max17042"
- * "maxim,max17047"
- * "maxim,max17050"
- * "maxim,max17055"
-
-Optional properties :
- - maxim,rsns-microohm : Resistance of rsns resistor in micro Ohms
-                         (datasheet-recommended value is 10000).
-   Defining this property enables current-sense functionality.
-
-Optional threshold properties :
- If skipped the condition won't be reported.
- - maxim,cold-temp :      Temperature threshold to report battery
-                          as cold (in tenths of degree Celsius).
- - maxim,over-heat-temp : Temperature threshold to report battery
-                          as over heated (in tenths of degree Celsius).
- - maxim,dead-volt :      Voltage threshold to report battery
-                          as dead (in mV).
- - maxim,over-volt :      Voltage threshold to report battery
-                          as over voltage (in mV).
-
-Example:
-
-	battery-charger@36 {
-		compatible = "maxim,max17042";
-		reg = <0x36>;
-		maxim,rsns-microohm = <10000>;
-		maxim,over-heat-temp = <600>;
-		maxim,over-volt = <4300>;
-	};
diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
new file mode 100644
index 000000000000..c70f05ea6d27
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/maxim,max17042.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Maxim 17042 fuel gauge series
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    enum:
+      - maxim,max17042
+      - maxim,max17047
+      - maxim,max17050
+      - maxim,max17055
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  maxim,rsns-microohm:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Resistance of rsns resistor in micro Ohms (datasheet-recommended value is 10000).
+      Defining this property enables current-sense functionality.
+
+  maxim,cold-temp:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Temperature threshold to report battery as cold (in tenths of degree Celsius).
+      Default is not to report cold events.
+
+  maxim,over-heat-temp:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Temperature threshold to report battery as over heated (in tenths of degree Celsius).
+      Default is not to report over heating events.
+
+  maxim,dead-volt:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Voltage threshold to report battery as dead (in mV).
+      Default is not to report dead battery events.
+
+  maxim,over-volt:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Voltage threshold to report battery as over voltage (in mV).
+      Default is not to report over-voltage events.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      battery@36 {
+        compatible = "maxim,max17042";
+        reg = <0x36>;
+        maxim,rsns-microohm = <10000>;
+        maxim,over-heat-temp = <600>;
+        maxim,over-volt = <4300>;
+      };
+    };
-- 
2.30.2

