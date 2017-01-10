From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH v4 10/10] power: supplies: bq27xxx: adds device tree binding documentation.
Date: Tue, 10 Jan 2017 16:25:38 +1100
Message-ID: <1484025938-114133-11-git-send-email-chris@lapa.com.au>
References: <1482369743-79764-1-git-send-email-chris@lapa.com.au>
 <1484025938-114133-1-git-send-email-chris@lapa.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35205 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941797AbdAJF00 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jan 2017 00:26:26 -0500
Received: by mail-pf0-f194.google.com with SMTP id f144so8126300pfa.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Jan 2017 21:26:25 -0800 (PST)
In-Reply-To: <1484025938-114133-1-git-send-email-chris@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: pali.rohar@gmail.com, afd@ti.com, sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chris Lapa <chris@lapa.com.au>

From: Chris Lapa <chris@lapa.com.au>

The bq27xxx binding is a standard i2c style binding, however the
deprecated compatible fields and different revisions warrant its own
documentation.

Signed-off-by: Chris Lapa <chris@lapa.com.au>
Acked-by: Pali Rohár <pali.rohar@gmail.com>
Reviewed-by: Andrew F. Davis <afd@ti.com>
---
 .../devicetree/bindings/power/supply/bq27xxx.txt   | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq27xxx.txt

diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
new file mode 100644
index 0000000..b0c95ef
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
@@ -0,0 +1,36 @@
+Binding for TI BQ27XXX fuel gauge family
+
+Required properties:
+- compatible: Should contain one of the following:
+ * "ti,bq27200" - BQ27200
+ * "ti,bq27210" - BQ27210
+ * "ti,bq27500" - deprecated, use revision specific property below
+ * "ti,bq27510" - deprecated, use revision specific property below
+ * "ti,bq27520" - deprecated, use revision specific property below
+ * "ti,bq27500-1" - BQ27500/1
+ * "ti,bq27510g1" - BQ27510-g1
+ * "ti,bq27510g2" - BQ27510-g2
+ * "ti,bq27510g3" - BQ27510-g3
+ * "ti,bq27520g1" - BQ27520-g1
+ * "ti,bq27520g2" - BQ27520-g2
+ * "ti,bq27520g3" - BQ27520-g3
+ * "ti,bq27520g4" - BQ27520-g4
+ * "ti,bq27530" - BQ27530
+ * "ti,bq27531" - BQ27531
+ * "ti,bq27541" - BQ27541
+ * "ti,bq27542" - BQ27542
+ * "ti,bq27546" - BQ27546
+ * "ti,bq27742" - BQ27742
+ * "ti,bq27545" - BQ27545
+ * "ti,bq27421" - BQ27421
+ * "ti,bq27425" - BQ27425
+ * "ti,bq27441" - BQ27441
+ * "ti,bq27621" - BQ27621
+- reg: integer, i2c address of the device.
+
+Example:
+
+bq27510g3 {
+    compatible = "ti,bq27510g3";
+    reg = <0x55>;
+};
-- 
2.1.4

