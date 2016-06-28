From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v5 01/13] devicetree: bindings: Renesas APMU and SMP Enable method
Date: Tue, 28 Jun 2016 16:10:30 +0200
Message-ID: <1467123042-8468-2-git-send-email-geert+renesas@glider.be>
References: <1467123042-8468-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1467123042-8468-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Keita Kobayashi <keita.kobayashi.ym@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Magnus Damm <damm+renesas@opensource.se>, Geert Uytterhoeven <geert+renesas@glider.be>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Add DT binding documentation for the APMU hardware and add "renesas,apmu"
to the list of enable methods for the ARM cpus.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
---
v5:
  - Add Acked-by,

v4:
  - s/reigsters/registers/,
  - Use "renesas,<soctype>-apmu" instead of "renesas,apmu-<soctype>",

v3:
  - s/Until/Unit/g,

v2:
  - No changes.
---
 Documentation/devicetree/bindings/arm/cpus.txt     |  1 +
 .../devicetree/bindings/power/renesas,apmu.txt     | 31 ++++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/renesas,apmu.txt

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 3f0cbbb8395f84ef..fa7520eb6387edbe 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -204,6 +204,7 @@ nodes to be present and contain the properties described below.
 			    "qcom,gcc-msm8660"
 			    "qcom,kpss-acc-v1"
 			    "qcom,kpss-acc-v2"
+			    "renesas,apmu"
 			    "rockchip,rk3036-smp"
 			    "rockchip,rk3066-smp"
 			    "ste,dbx500-smp"
diff --git a/Documentation/devicetree/bindings/power/renesas,apmu.txt b/Documentation/devicetree/bindings/power/renesas,apmu.txt
new file mode 100644
index 0000000000000000..84404c9edff73d97
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/renesas,apmu.txt
@@ -0,0 +1,31 @@
+DT bindings for the Renesas Advanced Power Management Unit
+
+Renesas R-Car line of SoCs utilize one or more APMU hardware units
+for CPU core power domain control including SMP boot and CPU Hotplug.
+
+Required properties:
+
+- compatible: Should be "renesas,<soctype>-apmu", "renesas,apmu" as fallback.
+	      Examples with soctypes are:
+		- "renesas,r8a7790-apmu" (R-Car H2)
+		- "renesas,r8a7791-apmu" (R-Car M2-W)
+		- "renesas,r8a7792-apmu" (R-Car V2H)
+		- "renesas,r8a7793-apmu" (R-Car M2-N)
+		- "renesas,r8a7794-apmu" (R-Car E2)
+
+- reg: Base address and length of the I/O registers used by the APMU.
+
+- cpus: This node contains a list of CPU cores, which should match the order
+  of CPU cores used by the WUPCR and PSTR registers in the Advanced Power
+  Management Unit section of the device's datasheet.
+
+
+Example:
+
+This shows the r8a7791 APMU that can control CPU0 and CPU1.
+
+	apmu@e6152000 {
+		compatible = "renesas,r8a7791-apmu", "renesas,apmu";
+		reg = <0 0xe6152000 0 0x188>;
+		cpus = <&cpu0 &cpu1>;
+	};
-- 
1.9.1
