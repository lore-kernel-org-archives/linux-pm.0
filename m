From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] dt-bindings: power: New bindings for ltc3651-charger
Date: Fri,  5 May 2017 08:38:35 +0200
Message-ID: <1493966315-15893-1-git-send-email-mike.looijmans@topic.nl>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atl4mhob07.myregisteredsite.com ([209.17.115.45]:41376 "EHLO
        atl4mhob07.registeredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751630AbdEEGio (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 May 2017 02:38:44 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.210])
        by atl4mhob07.registeredsite.com (8.14.4/8.14.4) with ESMTP id v456cg4R030473
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
        for <linux-pm@vger.kernel.org>; Fri, 5 May 2017 02:38:42 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, Mike Looijmans <mike.looijmans@topic.nl>

This adds the devicetree bindings documentation for the LTC3651 battery charger.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 .../bindings/power/supply/ltc3651-charger.txt      | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt

diff --git a/Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt b/Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt
new file mode 100644
index 0000000..a7dd80f
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt
@@ -0,0 +1,26 @@
+ltc3651-charger
+
+Required properties:
+ - compatible: "lltc,ltc3651-charger"
+ - acpr-gpios: Connect to ACPR output. See remark below.
+
+Optional properties:
+ - fault-gpios: Connect to FAULT output. See remark below.
+ - chrg-gpios: Connect to CHRG output. See remark below.
+
+The ltc3651 outputs are open-drain type and active low. The driver assumes the
+GPIO reports "active" when the output is asserted, so if the pins have been
+connected directly, the GPIO flags should be set to active low also.
+
+The driver will attempt to aquire interrupts for all GPIOs. If the system is
+not capabale of providing that, the driver cannot report changes and userspace
+will need to periodically read the sysfs attributes to detect changes.
+
+Example:
+
+	charger: battery-charger {
+		compatible = "lltc,ltc3651-charger";
+		acpr-gpios = <&gpio0 68 GPIO_ACTIVE_LOW>;
+		fault-gpios = <&gpio0 64 GPIO_ACTIVE_LOW>;
+		chrg-gpios = <&gpio0 63 GPIO_ACTIVE_LOW>;
+	};
-- 
1.9.1
