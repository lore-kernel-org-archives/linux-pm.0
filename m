From: Michel Pollet <michel.pollet@bp.renesas.com>
Subject: [PATCH v2 1/8] DT: mfd: renesas,rzn1-sysctrl: document RZ/N1 sysctrl node
Date: Thu, 22 Mar 2018 11:44:38 +0000
Message-ID: <1521719091-25157-2-git-send-email-michel.pollet@bp.renesas.com>
References: <1521719091-25157-1-git-send-email-michel.pollet@bp.renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521719091-25157-1-git-send-email-michel.pollet@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: phil.edworthy@renesas.com, Michel Pollet <michel.pollet@bp.renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>, Russell King <linux@armlinux.org.uk>, Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The Renesas RZ/N1 Family (Part #R9A06G0xx) has a multi-function
system controller. This documents the node used to encapsulate
it's sub drivers.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
---
 .../bindings/mfd/renesas,rzn1-sysctrl.txt          | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt

diff --git a/Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt b/Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt
new file mode 100644
index 0000000..5aaef43
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt
@@ -0,0 +1,22 @@
+DT bindings for the Renesas RZ-N1 System Controller
+
+== System Controller Node ==
+
+The system controller node currently only hosts a single sub-driver to handle
+the rebooting of the CPU. Eventually it will host the clock driver, SMP
+start handler, watchdog etc.
+
+See renesas,rzn1-reboot.txt for further details.
+
+Bindings:
++ Optional:
+	compatible = "renesas,r9a06g032-sysctrl";
++ Required:
+	compatible = "renesas,rzn1-sysctrl";
+
+Example:
+	sysctrl: sysctrl@4000c000 {
+		compatible = "renesas,r9a06g032-sysctrl",
+			"renesas,rzn1-sysctrl", "syscon", "simple-mfd";
+		reg = <0x4000c000 0x1000>;
+	};
-- 
2.7.4
