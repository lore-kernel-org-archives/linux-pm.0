From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v2 4/4] power: da9150: Add DT bindings documentation for
 Fuel-Gauge
Date: Fri, 26 Jun 2015 09:47:53 +0100
Message-ID: <10ecdfd381966885c6509ce3e98eec0816c0875e.1435308209.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1435308209.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.bemta14.messagelabs.com ([193.109.254.109]:37699 "EHLO
	mail1.bemta14.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751874AbbFZIyu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2015 04:54:50 -0400
In-Reply-To: <cover.1435308209.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 .../devicetree/bindings/power/da9150-fg.txt        | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/da9150-fg.txt

diff --git a/Documentation/devicetree/bindings/power/da9150-fg.txt b/Documentation/devicetree/bindings/power/da9150-fg.txt
new file mode 100644
index 0000000..c3c76eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/da9150-fg.txt
@@ -0,0 +1,23 @@
+Dialog Semiconductor DA9150 Fuel-Gauge Power Supply bindings
+
+Required properties:
+- compatible: "dlg,da9150-fg" for DA9150 Fuel-Gauge Power Supply
+
+Optional properties:
+- dlg,update-interval: Interval time (milliseconds) between battery level checks.
+- dlg,warn-soc-level: Battery discharge level (%) where warning event raised.
+      [1 - 100]
+- dlg,crit-soc-level: Battery discharge level (%) where critical event raised.
+  This value should be lower than the warning level.
+      [1 - 100]
+
+
+Example:
+
+	da9150-fg {
+		compatible = "dlg,da9150-fg";
+
+		dlg,update-interval = <10000>;
+		dlg,warn-soc-level = /bits/ 8 <15>;
+		dlg,crit-soc-level = /bits/ 8 <5>;
+	};
--
1.9.3

