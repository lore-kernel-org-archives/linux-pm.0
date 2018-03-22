From: Michel Pollet <michel.pollet@bp.renesas.com>
Subject: [PATCH v2 2/8] DT: reset: renesas,rzn1-reboot: document RZ/N1 reboot driver
Date: Thu, 22 Mar 2018 11:44:39 +0000
Message-ID: <1521719091-25157-3-git-send-email-michel.pollet@bp.renesas.com>
References: <1521719091-25157-1-git-send-email-michel.pollet@bp.renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521719091-25157-1-git-send-email-michel.pollet@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: phil.edworthy@renesas.com, Michel Pollet <michel.pollet@bp.renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>, Russell King <linux@armlinux.org.uk>, Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The Renesas RZ/N1 Family (Part #R9A06G0xx) requires a driver
as part of the sysctrl MFD to handle rebooting the CA7 cores.
This documents the driver bindings.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
---
 .../bindings/power/renesas,rzn1-reboot.txt         | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt

diff --git a/Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt b/Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt
new file mode 100644
index 0000000..bea46e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt
@@ -0,0 +1,22 @@
+DT bindings for the Renesas RZ-N1 Reboot Driver
+
+== Reboot Driver Node ==
+
+The reboot driver is always a subnode of the system controller node, see
+renesas,rzn1-sysctrl.txt for details.
+
+Bindings:
++ Optional:
+	compatible = "renesas,r9a06g032-reboot";
++ Required:
+	compatible = "renesas,rzn1-reboot";
+
+Example:
+	sysctrl: sysctrl@4000c000 {
+		compatible = "renesas,r9a06g032-sysctrl", "syscon", "simple-mfd";
+		reg = <0x4000c000 0x1000>;
+
+		reboot {
+			compatible = "renesas,r9a06g032-reboot";
+		};
+	};
-- 
2.7.4
