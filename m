From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v5 18/21] ARM: dts: Add exynos4412-ppmu-common dtsi to delete
 duplicate PPMU nodes
Date: Thu, 24 Mar 2016 13:25:27 +0900
Message-ID: <1458793530-31897-19-git-send-email-cw00.choi@samsung.com>
References: <1458793530-31897-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1458793530-31897-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, tjakobi@math.uni-bielefeld.de, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch adds the exynos4412-ppmu-common.dtsi to remove duplicate PPMU nodes
because exynos3250-rinato/monk, exynos4412-trats2/odroidu3 has the same
PPMU device tree node.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos3250-monk.dts           | 41 +-------------------
 arch/arm/boot/dts/exynos3250-rinato.dts         | 41 +-------------------
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |  1 +
 arch/arm/boot/dts/exynos4412-ppmu-common.dtsi   | 50 +++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4412-trats2.dts         | 41 +-------------------
 5 files changed, 54 insertions(+), 120 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos4412-ppmu-common.dtsi

diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
index 1fd7ecb5c415..fbe09d640c9a 100644
--- a/arch/arm/boot/dts/exynos3250-monk.dts
+++ b/arch/arm/boot/dts/exynos3250-monk.dts
@@ -14,6 +14,7 @@
 
 /dts-v1/;
 #include "exynos3250.dtsi"
+#include "exynos4412-ppmu-common.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/samsung,s2mps11.h>
@@ -464,46 +465,6 @@
 	status = "okay";
 };
 
-&ppmu_dmc0 {
-	status = "okay";
-
-	events {
-		ppmu_dmc0_3: ppmu-event3-dmc0 {
-			event-name = "ppmu-event3-dmc0";
-		};
-	};
-};
-
-&ppmu_dmc1 {
-	status = "okay";
-
-	events {
-		ppmu_dmc1_3: ppmu-event3-dmc1 {
-			event-name = "ppmu-event3-dmc1";
-		};
-	};
-};
-
-&ppmu_leftbus {
-	status = "okay";
-
-	events {
-		ppmu_leftbus_3: ppmu-event3-leftbus {
-			event-name = "ppmu-event3-leftbus";
-		};
-	};
-};
-
-&ppmu_rightbus {
-	status = "okay";
-
-	events {
-		ppmu_rightbus_3: ppmu-event3-rightbus {
-			event-name = "ppmu-event3-rightbus";
-		};
-	};
-};
-
 &xusbxti {
 	clock-frequency = <24000000>;
 };
diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 5175bd7e015f..9710e79e10a0 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -14,6 +14,7 @@
 
 /dts-v1/;
 #include "exynos3250.dtsi"
+#include "exynos4412-ppmu-common.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/samsung,s2mps11.h>
@@ -641,46 +642,6 @@
 	status = "okay";
 };
 
-&ppmu_dmc0 {
-	status = "okay";
-
-	events {
-		ppmu_dmc0_3: ppmu-event3-dmc0 {
-			event-name = "ppmu-event3-dmc0";
-		};
-	};
-};
-
-&ppmu_dmc1 {
-	status = "okay";
-
-	events {
-		ppmu_dmc1_3: ppmu-event3-dmc1 {
-			event-name = "ppmu-event3-dmc1";
-		};
-	};
-};
-
-&ppmu_leftbus {
-	status = "okay";
-
-	events {
-		ppmu_leftbus_3: ppmu-event3-leftbus {
-			event-name = "ppmu-event3-leftbus";
-		};
-	};
-};
-
-&ppmu_rightbus {
-	status = "okay";
-
-	events {
-		ppmu_rightbus_3: ppmu-event3-rightbus {
-			event-name = "ppmu-event3-rightbus";
-		};
-	};
-};
-
 &xusbxti {
 	clock-frequency = <24000000>;
 };
diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 5e5d3fecb04c..cba37c974703 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/clock/maxim,max77686.h>
 #include "exynos4412.dtsi"
+#include "exynos4412-ppmu-common.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 
 / {
diff --git a/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi b/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
new file mode 100644
index 000000000000..16e4b77d8cb1
--- /dev/null
+++ b/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
@@ -0,0 +1,50 @@
+/*
+ * Device tree sources for Exynos4412 PPMU common device tree
+ *
+ * Copyright (C) 2015 Samsung Electronics
+ * Author: Chanwoo Choi <cw00.choi@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+&ppmu_dmc0 {
+       status = "okay";
+
+       events {
+	       ppmu_dmc0_3: ppmu-event3-dmc0 {
+		       event-name = "ppmu-event3-dmc0";
+	       };
+       };
+};
+
+&ppmu_dmc1 {
+       status = "okay";
+
+       events {
+	       ppmu_dmc1_3: ppmu-event3-dmc1 {
+		       event-name = "ppmu-event3-dmc1";
+	       };
+       };
+};
+
+&ppmu_leftbus {
+       status = "okay";
+
+       events {
+	       ppmu_leftbus_3: ppmu-event3-leftbus {
+		       event-name = "ppmu-event3-leftbus";
+	       };
+       };
+};
+
+&ppmu_rightbus {
+       status = "okay";
+
+       events {
+	       ppmu_rightbus_3: ppmu-event3-rightbus {
+		       event-name = "ppmu-event3-rightbus";
+	       };
+       };
+};
diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index ed017cc7b14f..dce3cebe0606 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -14,6 +14,7 @@
 
 /dts-v1/;
 #include "exynos4412.dtsi"
+#include "exynos4412-ppmu-common.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/clock/maxim,max77686.h>
@@ -871,46 +872,6 @@
 	assigned-clock-parents =  <&clock CLK_XUSBXTI>;
 };
 
-&ppmu_dmc0 {
-	status = "okay";
-
-	events {
-		ppmu_dmc0_3: ppmu-event3-dmc0 {
-			event-name = "ppmu-event3-dmc0";
-		};
-	};
-};
-
-&ppmu_dmc1 {
-	status = "okay";
-
-	events {
-		ppmu_dmc1_3: ppmu-event3-dmc1 {
-			event-name = "ppmu-event3-dmc1";
-		};
-	};
-};
-
-&ppmu_leftbus {
-	status = "okay";
-
-	events {
-		ppmu_leftbus_3: ppmu-event3-leftbus {
-			event-name = "ppmu-event3-leftbus";
-		};
-	};
-};
-
-&ppmu_rightbus {
-	status = "okay";
-
-	events {
-		ppmu_rightbus_3: ppmu-event3-rightbus {
-			event-name = "ppmu-event3-rightbus";
-		};
-	};
-};
-
 &pinctrl_0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sleep0>;
-- 
1.9.1
