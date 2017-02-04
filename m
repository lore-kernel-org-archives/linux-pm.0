From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 1/2] dt-bindings: Add thermal zone to bcm2835-thermal example
Date: Sat,  4 Feb 2017 14:16:26 +0000
Message-ID: <1486217787-15703-1-git-send-email-stefan.wahren@i2se.com>
References: <E0A4388D-788A-40B4-9193-36FD75284654@martin.sperl.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:55513 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbdBDORe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Feb 2017 09:17:34 -0500
In-Reply-To: <E0A4388D-788A-40B4-9193-36FD75284654@martin.sperl.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, kernel@martin.sperl.org
Cc: Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>

Add a thermal zone in order to make the example complete.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../bindings/thermal/brcm,bcm2835-thermal.txt      |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
index 474531d..680aca9 100644
--- a/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
@@ -10,6 +10,25 @@ clocks: 	Phandle of the clock used by the thermal sensor.
 
 Example:
 
+thermal-zones {
+	gpu_thermal: gpu-thermal {
+		polling-delay-passive = <0>;
+		polling-delay = <1000>;
+
+		thermal-sensors = <&thermal>;
+
+		trips {
+			cpu-crit {
+				temperature	= <80000>;
+				hysteresis	= <0>;
+				type		= "critical";
+			};
+		};
+		cooling-maps {
+		};
+	};
+};
+
 thermal: thermal@7e212000 {
 	compatible = "brcm,bcm2835-thermal";
 	reg = <0x7e212000 0x8>;
-- 
1.7.9.5

