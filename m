Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34413C4332B
	for <linux-pm@archiver.kernel.org>; Wed, 17 Mar 2021 13:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE3264F0F
	for <linux-pm@archiver.kernel.org>; Wed, 17 Mar 2021 13:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhCQNtl (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 17 Mar 2021 09:49:41 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56190 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbhCQNtN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 09:49:13 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 4A1781F44A29
Received: by jupiter.universe (Postfix, from userid 1000)
        id E5B03480102; Wed, 17 Mar 2021 14:49:05 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 16/38] dt-bindings: power: supply: tps65217: Convert to DT schema format
Date:   Wed, 17 Mar 2021 14:48:42 +0100
Message-Id: <20210317134904.80737-17-sebastian.reichel@collabora.com>
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
 .../power/supply/tps65217-charger.yaml        | 43 +++++++++++++++++++
 .../power/supply/tps65217_charger.txt         | 17 --------
 2 files changed, 43 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/tps65217-charger.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/tps65217_charger.txt

diff --git a/Documentation/devicetree/bindings/power/supply/tps65217-charger.yaml b/Documentation/devicetree/bindings/power/supply/tps65217-charger.yaml
new file mode 100644
index 000000000000..a33408c3a407
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/tps65217-charger.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/tps65217-charger.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: TPS65217 Charger
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: ti,tps65217-charger
+
+  interrupts:
+    minItems: 2
+    maxItems: 2
+
+  interrupt-names:
+    items:
+      - const: USB
+      - const: AC
+      
+required:
+  - compatible
+  - interrupts
+  - interrupt-names
+
+additionalProperties: false
+
+examples:
+  - |
+    pmic {
+      charger {
+        compatible = "ti,tps65217-charger";
+        interrupts = <0>, <1>;
+        interrupt-names = "USB", "AC";
+      };
+    };
diff --git a/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt b/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
deleted file mode 100644
index a11072c5a866..000000000000
--- a/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-TPS65217 Charger
-
-Required Properties:
--compatible: "ti,tps65217-charger"
--interrupts: TPS65217 interrupt numbers for the AC and USB charger input change.
-             Should be <0> for the USB charger and <1> for the AC adapter.
--interrupt-names: Should be "USB" and "AC"
-
-This node is a subnode of the tps65217 PMIC.
-
-Example:
-
-	tps65217-charger {
-		compatible = "ti,tps65217-charger";
-		interrupts = <0>, <1>;
-		interrupt-names = "USB", "AC";
-	};
-- 
2.30.2

