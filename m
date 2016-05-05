From: Chris Brand <chris.brand@broadcom.com>
Subject: [PATCH 3/6] docs: Document BCM23550 bindings
Date: Thu,  5 May 2016 13:48:51 -0700
Message-ID: <1462481334-8943-4-git-send-email-chris.brand@broadcom.com>
References: <1462481334-8943-1-git-send-email-chris.brand@broadcom.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:29560 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756427AbcEEUr4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 May 2016 16:47:56 -0400
In-Reply-To: <1462481334-8943-1-git-send-email-chris.brand@broadcom.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Russell King <linux@arm.linux.org.uk>, bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Raymond Ngun <raymond.ngun@broadcom.com>, Markus Mayer <markus.mayer@broadcom.com>

Add binding document for Broadcom BCM23550 SoC.

BCM23550 has a Cluster Dormant Control IP block that holds cores
in an idle state. Introduce a new CPU enable method in which the CDC is
accessed to bring the core online.

Signed-off-by: Chris Brand <chris.brand@broadcom.com>
---
 .../bindings/arm/bcm/brcm,bcm23550-cpu-method.txt  | 36 ++++++++++++++++++++++
 .../devicetree/bindings/arm/bcm/brcm,bcm23550.txt  | 15 +++++++++
 Documentation/devicetree/bindings/arm/cpus.txt     |  1 +
 3 files changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550-cpu-method.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.txt

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550-cpu-method.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550-cpu-method.txt
new file mode 100644
index 000000000000..b1b16872bbca
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550-cpu-method.txt
@@ -0,0 +1,36 @@
+Broadcom Kona Family CPU Enable Method
+--------------------------------------
+This binding defines the enable method used for starting secondary
+CPUs in the following Broadcom SoCs:
+  BCM23550
+
+The enable method is specified by defining the following required
+properties in the "cpu" device tree node:
+  - enable-method = "brcm,bcm23550-cpu-method";
+  - secondary-boot-reg = <...>;
+
+The secondary-boot-reg property is a u32 value that specifies the
+physical address of the register used to request the ROM holding pen
+code release a secondary CPU.  The value written to the register is
+formed by encoding the target CPU id into the low bits of the
+physical start address it should jump to.
+
+Example:
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <1>;
+			enable-method = "brcm,bcm23550-cpu-method";
+			secondary-boot-reg = <0x3500417c>;
+		};
+	};
diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.txt
new file mode 100644
index 000000000000..080baad923d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.txt
@@ -0,0 +1,15 @@
+Broadcom BCM23550 device tree bindings
+--------------------------------------
+
+This document describes the device tree bindings for boards with the BCM23550
+SoC.
+
+Required root node property:
+  - compatible: brcm,bcm23550
+
+Example:
+	/ {
+		model = "BCM23550 SoC";
+		compatible = "brcm,bcm23550";
+		[...]
+	}
diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index ccc62f145306..8d63711139bd 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -194,6 +194,7 @@ nodes to be present and contain the properties described below.
 			    "allwinner,sun8i-a23"
 			    "arm,psci"
 			    "arm,realview-smp"
+			    "brcm,bcm23550-cpu-method"
 			    "brcm,bcm-nsp-smp"
 			    "brcm,brahma-b15"
 			    "marvell,armada-375-smp"
-- 
1.9.1

