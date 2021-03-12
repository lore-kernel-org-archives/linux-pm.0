Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B368C2BA1A
	for <linux-pm@archiver.kernel.org>; Fri, 12 Mar 2021 15:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43A6C64FF3
	for <linux-pm@archiver.kernel.org>; Fri, 12 Mar 2021 15:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhCLPou (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 12 Mar 2021 10:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbhCLPoR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 10:44:17 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE1BC061574;
        Fri, 12 Mar 2021 07:44:17 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 521011F46EC6
Received: by jupiter.universe (Postfix, from userid 1000)
        id 5EC5B48010A; Fri, 12 Mar 2021 16:44:08 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 23/38] dt-bindings: power: supply: max8903: Convert to DT schema format
Date:   Fri, 12 Mar 2021 16:43:42 +0100
Message-Id: <20210312154357.1561730-24-sebastian.reichel@collabora.com>
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
 .../bindings/power/supply/max8903-charger.txt | 24 -------
 .../bindings/power/supply/maxim,max8903.yaml  | 67 +++++++++++++++++++
 2 files changed, 67 insertions(+), 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/max8903-charger.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max8903.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/max8903-charger.txt b/Documentation/devicetree/bindings/power/supply/max8903-charger.txt
deleted file mode 100644
index bab947fef025..000000000000
--- a/Documentation/devicetree/bindings/power/supply/max8903-charger.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-Maxim Semiconductor MAX8903 Battery Charger bindings
-
-Required properties:
-- compatible: "maxim,max8903" for MAX8903 Battery Charger
-- dok-gpios: Valid DC power has been detected (active low, input), optional if uok-gpios is provided
-- uok-gpios: Valid USB power has been detected (active low, input), optional if dok-gpios is provided
-
-Optional properties:
-- cen-gpios: Charge enable pin (active low, output)
-- chg-gpios: Charger status pin (active low, input)
-- flt-gpios: Fault pin (active low, output)
-- dcm-gpios: Current limit mode setting (DC=1 or USB=0, output)
-- usus-gpios: USB suspend pin (active high, output)
-
-
-Example:
-
-	max8903-charger {
-		compatible = "maxim,max8903";
-		dok-gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
-		flt-gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
-		chg-gpios = <&gpio3 15 GPIO_ACTIVE_LOW>;
-		cen-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
-	};
diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max8903.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max8903.yaml
new file mode 100644
index 000000000000..4828ca0842ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max8903.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/maxim,max8903.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Maxim Semiconductor MAX8903 Battery Charger
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: maxim,max8903
+
+  dok-gpios:
+    maxItems: 1
+    description: Valid DC power has been detected (active low, input)
+
+  uok-gpios:
+    maxItems: 1
+    description: Valid USB power has been detected (active low, input)
+
+  cen-gpios:
+    maxItems: 1
+    description: Charge enable pin (active low, output)
+
+  chg-gpios:
+    maxItems: 1
+    description: Charger status pin (active low, input)
+
+  flt-gpios:
+    maxItems: 1
+    description: Fault pin (active low, output)
+
+  dcm-gpios:
+    maxItems: 1
+    description: Current limit mode setting (DC=1 or USB=0, output)
+
+  usus-gpios:
+    maxItems: 1
+    description: USB suspend pin (active high, output)
+
+required:
+  - compatible
+
+anyOf:
+  - required:
+      - dok-gpios
+  - required:
+      - uok-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    charger {
+      compatible = "maxim,max8903";
+      dok-gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
+      flt-gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
+      chg-gpios = <&gpio3 15 GPIO_ACTIVE_LOW>;
+      cen-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
+    };
-- 
2.30.1

