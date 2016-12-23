From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH v2 11/11] power: supplies: bq275xx: adds device tree binding documentation.
Date: Fri, 23 Dec 2016 11:05:07 +1100
Message-ID: <1482451507-37676-12-git-send-email-chris@lapa.com.au>
References: <1482369743-79764-1-git-send-email-chris@lapa.com.au>
 <1482451507-37676-1-git-send-email-chris@lapa.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34298 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942099AbcLWAFt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Dec 2016 19:05:49 -0500
Received: by mail-pg0-f68.google.com with SMTP id b1so21669821pgc.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Dec 2016 16:05:49 -0800 (PST)
In-Reply-To: <1482451507-37676-1-git-send-email-chris@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: pali.rohar@gmail.com, afd@ti.com, sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chris Lapa <chris@lapa.com.au>

From: Chris Lapa <chris@lapa.com.au>

The bq275xx binding is a standard i2c style binding, however the
deprecated compatible fields and different revisions warrant its own
documentation.

Signed-off-by: Chris Lapa <chris@lapa.com.au>
---
 .../devicetree/bindings/power/supply/bq275xx.txt   | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq275xx.txt

diff --git a/Documentation/devicetree/bindings/power/supply/bq275xx.txt b/Documentation/devicetree/bindings/power/supply/bq275xx.txt
new file mode 100644
index 0000000..8f4f759
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/bq275xx.txt
@@ -0,0 +1,27 @@
+binding for BQ275XX fuel gauge family
+
+Supports revisions listed below in the BQ275XX family of fuel gauges.
+Each revision is slightly different enough to warrant separate
+comapatible fields.
+
+Required properties:
+- compatible:
+    * "ti,bq27500" - deprecated
+    * "ti,bq27510" - deprecated
+    * "ti,bq27520" - deprecated
+    * "ti,bq27500-1" - BQ27500/1
+    * "ti,bq27510g1" - BQ27510-g1
+    * "ti,bq27510g2" - BQ27510-g2
+    * "ti,bq27510g3" - BQ27510-g3
+    * "ti,bq27520g1" - BQ27520-g1
+    * "ti,bq27520g2" - BQ27520-g2
+    * "ti,bq27520g3" - BQ27520-g3
+    * "ti,bq27520g4" - BQ27520-g4
+- reg: The 7-bit I2C address.
+
+Example:
+
+	fuelgauge: bq27510g3@55 {
+		compatible = "ti,bq27510g3";
+		reg = <0x55>;
+	};
-- 
2.1.4

