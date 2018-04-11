From: Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH v3 2/4] dt-bindings:power:supply: Add docs for ADP5061 battery charger
Date: Wed, 11 Apr 2018 18:10:15 +0300
Message-ID: <1523459415-31636-1-git-send-email-stefan.popa@analog.com>
References: <1522829832-7866-1-git-send-email-stefan.popa@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522829832-7866-1-git-send-email-stefan.popa@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: davem@davemloft.net, mchehab@kernel.org, gregkh@linuxfoundation.org, linus.walleij@linaro.org, akpm@linux-foundation.org, rdunlap@infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, stefan.popa@analog.com
List-Id: linux-pm@vger.kernel.org

Document adi,adp5061 properties.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v3:
	- Split devicetree bindings into a separate patch.

 .../devicetree/bindings/power/supply/adp5061.txt        | 17 +++++++++++++++++
 MAINTAINERS                                             |  1 +
 2 files changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/adp5061.txt

diff --git a/Documentation/devicetree/bindings/power/supply/adp5061.txt b/Documentation/devicetree/bindings/power/supply/adp5061.txt
new file mode 100644
index 0000000..7447446
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/adp5061.txt
@@ -0,0 +1,17 @@
+Analog Devices ADP5061 Programmable Linear Battery Charger Driver
+
+Required properties:
+  - compatible:		should be "adi,adp5061"
+  - reg:		i2c address of the device
+
+The node for this driver must be a child node of a I2C controller, hence
+all mandatory properties described in
+Documentation/devicetree/bindings/i2c/i2c.txt
+must be specified.
+
+Example:
+
+	adp5061@14 {
+		    compatible = "adi,adp5061";
+		    reg = <0x14>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 60cd6db..a9ca73b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -802,6 +802,7 @@ M:	Stefan Popa <stefan.popa@analog.com>
 L:	linux-pm@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
+F:	Documentation/devicetree/bindings/power/supply/adp5061.txt
 F:	drivers/power/supply/adp5061.c
 
 ANALOG DEVICES INC ADV7180 DRIVER
-- 
2.7.4
