From: Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH v3 6/7] devicetree: power: bq27xxx: add monitored battery documentation
Date: Tue, 10 Jan 2017 22:20:02 -0800
Message-ID: <20170111062003.10110-7-matt@ranostay.consulting>
References: <20170111062003.10110-1-matt@ranostay.consulting>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35432 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761926AbdAKGUN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jan 2017 01:20:13 -0500
Received: by mail-pf0-f173.google.com with SMTP id f144so50182262pfa.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Jan 2017 22:20:13 -0800 (PST)
In-Reply-To: <20170111062003.10110-1-matt@ranostay.consulting>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: sre@kernel.org, tony@atomide.com, Matt Ranostay <matt@ranostay.consulting>, Rob Herring <robh@kernel.org>

Depends-On: http://marc.info/?l=linux-pm&m=148392292830015&w=2
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
---
 Documentation/devicetree/bindings/power/supply/bq27xxx.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
index b0c95ef63e68..0472a2db0f13 100644
--- a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
+++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
@@ -28,9 +28,17 @@ Required properties:
  * "ti,bq27621" - BQ27621
 - reg: integer, i2c address of the device.
 
+Optional properties:
+- monitored-battery: phandle of battery information devicetree node
+
+  See Documentation/devicetree/bindings/power/supply/battery.txt
+  If any of the referenced battery properties are set, then all must be.
+
 Example:
 
 bq27510g3 {
     compatible = "ti,bq27510g3";
     reg = <0x55>;
+
+    monitored-battery = <&bat>;
 };
-- 
2.10.2

