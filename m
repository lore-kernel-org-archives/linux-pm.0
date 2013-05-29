From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 7/7] thermal: ti-soc-thermal: add DT example for DRA752 chip
Date: Wed, 29 May 2013 11:07:46 -0400
Message-ID: <1369840066-20357-8-git-send-email-eduardo.valentin@ti.com>
References: <1369840066-20357-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1369840066-20357-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, J Keerthy <j-keerthy@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Update documentation by adding an example for DRA752 on DT description.

Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Rob Landley <rob@landley.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: J Keerthy <j-keerthy@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 Documentation/devicetree/bindings/thermal/ti_soc_thermal.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/ti_soc_thermal.txt b/Documentation/devicetree/bindings/thermal/ti_soc_thermal.txt
index 1629652..1953b33 100644
--- a/Documentation/devicetree/bindings/thermal/ti_soc_thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/ti_soc_thermal.txt
@@ -59,3 +59,15 @@ bandgap {
 	compatible = "ti,omap5430-bandgap";
 	interrupts = <0 126 4>; /* talert */
 };
+
+DRA752:
+bandgap {
+	reg = <0x4a0021e0 0xc
+		0x4a00232c 0xc
+		0x4a002380 0x2c
+		0x4a0023C0 0x3c
+		0x4a002564 0x8
+		0x4a002574 0x50>;
+	compatible = "ti,dra752-bandgap";
+	interrupts = <0 126 4>; /* talert */
+};
-- 
1.8.2.1.342.gfa7285d
