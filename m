Return-Path: <SRS0=28Z2=AA=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8DCC433DF
	for <linux-pm@archiver.kernel.org>; Fri, 19 Jun 2020 15:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A0BF21532
	for <linux-pm@archiver.kernel.org>; Fri, 19 Jun 2020 15:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392555AbgFSPTS (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404048AbgFSPPq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2020 11:15:46 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3755FC06174E
        for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2020 08:15:45 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed20:38b1:3718:f116:dc69])
        by albert.telenet-ops.be with bizsmtp
        id t3Fj2200C1b8psi063FjHk; Fri, 19 Jun 2020 17:15:44 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jmIk3-0005jD-Dj; Fri, 19 Jun 2020 17:15:43 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jmIk3-0003vm-Bv; Fri, 19 Jun 2020 17:15:43 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: thermal: rcar-thermal: Improve schema validation
Date:   Fri, 19 Jun 2020 17:15:41 +0200
Message-Id: <20200619151541.15069-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

  - Document missing "#thermal-sensor-cells",
  - Factor out common required properties,
  - "interrupts", "clocks", and "power-domains" are required on R-Mobile
    APE6, too,
  - Invert logic to simplify descriptions,
  - Add "additionalProperties: false".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../bindings/thermal/rcar-thermal.yaml        | 53 ++++++++++++-------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml b/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
index 0994693d240f9ff4..88787b98992fe7c9 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
@@ -59,25 +59,40 @@ properties:
   resets:
     maxItems: 1
 
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - renesas,thermal-r8a73a4 # R-Mobile APE6
-          - renesas,thermal-r8a7779 # R-Car H1
-then:
-  required:
-    - compatible
-    - reg
-else:
-  required:
-    - compatible
-    - reg
-    - interrupts
-    - clocks
-    - power-domains
-    - resets
+  '#thermal-sensor-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - renesas,thermal-r8a73a4 # R-Mobile APE6
+                - renesas,thermal-r8a7779 # R-Car H1
+    then:
+      required:
+        - resets
+        - '#thermal-sensor-cells'
+
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: renesas,thermal-r8a7779 # R-Car H1
+    then:
+      required:
+        - interrupts
+        - clocks
+        - power-domains
+
+additionalProperties: false
 
 examples:
   # Example (non interrupt support)
-- 
2.17.1

