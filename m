From: Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH v4 2/8] devicetree: power: add battery state machine documentation
Date: Sat, 21 Jan 2017 23:13:58 -0800
Message-ID: <20170122071404.9654-3-matt@ranostay.consulting>
References: <20170122071404.9654-1-matt@ranostay.consulting>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35740 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbdAVHOH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Jan 2017 02:14:07 -0500
Received: by mail-pg0-f47.google.com with SMTP id 194so35631372pgd.2
        for <linux-pm@vger.kernel.org>; Sat, 21 Jan 2017 23:14:07 -0800 (PST)
In-Reply-To: <20170122071404.9654-1-matt@ranostay.consulting>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: sre@kernel.org, tony@atomide.com, Matt Ranostay <matt@ranostay.consulting>, Rob Herring <robh@kernel.org>

Documentation on battery properties that can be defined for
fine tuning fuel gauge state machines.

Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
---
 .../devicetree/bindings/power/supply/battery.txt   | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/battery.txt

diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
new file mode 100644
index 000000000000..398b4d622883
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/battery.txt
@@ -0,0 +1,24 @@
+Battery State Machine Support
+
+Required Properties:
+ - compatible: Must be "fixed-battery"
+
+Optional Properties:
+ - nominal-microvolt: dead battery voltage in microvolts
+ - design-microwatt-hours: battery design mWh in microwatts
+ - design-microamp-hours: battery design mAh in microamps
+
+Example:
+
+	bat: battery@0 {
+		compatible = "fixed-battery";
+		nominal-microvolt = <3700000>;
+		design-microwatt-hours = <5290000>;
+		design-microamp-hours = <1430000>;
+	};
+
+	fuel_gauge: fuel_gauge@0 {
+		....
+		monitored-battery = <&bat>;
+		...
+	};
-- 
2.10.2

