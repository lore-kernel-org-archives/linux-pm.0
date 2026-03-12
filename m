Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E9238B7D6
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773305617; cv=none; b=jfwgePIyMbJHrLWPMg9D3Faq9YD31ousolLn7NbPkmookDEHCdEkLpV4u7uPqk1UCaCWPy33Fa+WzjFwK5oWRlAI7Vybd2zj9TsQ/9JeZAhzd9w3jJN7DD1hR/YWbjL0P6lDCL3w2J2Pt6yABmvWMTFFDGDjVHMzgBhP/vISLxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773305617; c=relaxed/simple;
	bh=qTyyR/BLXV+wQhrfLS7JucV4UIJvspj9QsneaCoNrIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcE84l1kHXCmJY9n8oW6Gopt0PMrk3zKI3VPeg7tjW2D5iBBzc5RtFx13nFoCpEcrIwaKWSb89OAQ8Um0SB7JG+kt7BpjMxVB7Dta5qLwwhyHm6Za3DJ04+8zh+hsAB8I1+O8GLlEFIp9AJI3alBKEuhBD7/bRBdnFJGIHqH6SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OV0sTWze; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OV0sTWze"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439c56e822eso794972f8f.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 01:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773305613; x=1773910413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkE9U9Ba2mep35Dcyp82RRxILmmwOqHrUGE6qweKQdw=;
        b=OV0sTWze9lE7QOmng7jDwZKOvu379/iR+1EMR9385u19P1AGOGKJw8FCfh7BLhTIWd
         IKVen+5GzHft3Ug+HKmegcZep2N6oS8dYVNm8BA0Sob8jngP7MJkI7IF1gFnXkjAzeuQ
         GcuDmlGrudt/ZWjdG4LLLjEMnbEU2L7ifvWvotTck+Y4gQc9QVc1itaQ4Iu07ekrmnbb
         gukqFFCYfllvmek+3/UUPl2U6flvdyz6xIybITFpboRqZ+J7y5IzSM+sGTgnaEH8qgCw
         zukRMQmR6lnoP3l99GepSJeLzTzKB4mB3tD7JOl83+XvQkn5n330hvtLy2N55AMBfOCp
         Uvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773305613; x=1773910413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bkE9U9Ba2mep35Dcyp82RRxILmmwOqHrUGE6qweKQdw=;
        b=HBNYU6ymLh4GhCL+jS5TW3z8sAVXsz3bK1sBB7eF+SKMoSGx7tuR3UCanWIOslo4YU
         40ggrJ3OGQqFYMU1dAE1p28d1mNcA9iOBHg+tHU2VEUuZ1YhWhpN66eIK5uFn2tDUhRl
         zK0FtBmE9WaKNvNcV5RDkexICHK8GD6fNTGFPNWVyAH62vxJWcJPsRo5A4IwJR9+B8bT
         CYwrankYiD33Q2SlWxc8aLWTKTLsg6xDeLTB0TM977lifFXVW/gt2GgKnOZc1XKNWI+6
         td+Zg1OARtYHehLi7YkbmMV1wvyLdr+oXGHndMe0cbuChs1GAUAidbiRp1rsh72dAWwq
         0cYA==
X-Forwarded-Encrypted: i=1; AJvYcCWn0GxbGi/Yqs3cE5aC2eShZzrWHdM3NulonptK8es/SVs5/ysUD9k2XgxPpkprNJMmmobT9xVihQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl9oYiDivI6uV+UnvjnzloNckEm+pcBNp1/oEC5XIABZKlnN/9
	5JCSYoXOS/CxxG4TamHZB9E/6FX7HCws0Fgk1oru1iCEdIT2FXexFkx/
X-Gm-Gg: ATEYQzzKX6UTbxDMeH0/6nDiL09UpbT3W1vvi9KF89782CO5Fal+miXrajyXha4DoZs
	rOTh9FXKH2q+9RIF4nshPhMjT3K9aPjchf385Pv714jSl8yCdauujp40rJQ1CuAUH1lvYvgQqq6
	8ZISSQ/ErNIXT0UheRYWcBfw132vCEX6g579nZEKhKHy9kievFn5BhwXxkI1DvmpLE16CQPGQ4H
	qElQ0rUhIsSzr1MVLnhxy+kkvPWwcxel8Wz6K9rRb0yrYVXkY2d16nF1az/kfWn8gfpP0nzVegw
	Nrycmdt9IUtBsrCWiBQqf7d+i1EXH5KyZbfYKHWE97YDA+trYwCC92DTSLIwdt/Cqfzt0x4K8iL
	VvPVFn5LCF5gmFVxRtpdpC6TDEcWwmNFi26MRljliLsz6+Caa9lJkT6p7lg75NS+WRK5IaMugHH
	n8wM0DTnDviheC
X-Received: by 2002:a05:6000:2304:b0:439:c550:d92f with SMTP id ffacd0b85a97d-439f8225315mr10827850f8f.56.1773305612306;
        Thu, 12 Mar 2026 01:53:32 -0700 (PDT)
Received: from xeon ([188.163.112.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe226473sm5449162f8f.32.2026.03.12.01.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 01:53:31 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH v4 3/5] dt-bindings: mfd: max77620: convert to DT schema
Date: Thu, 12 Mar 2026 10:52:56 +0200
Message-ID: <20260312085258.11431-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312085258.11431-1-clamor95@gmail.com>
References: <20260312085258.11431-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert max77620 devicetree bindings from TXT to YAML format. This patch
does not change any functionality; the bindings remain the same. The
thermal bindings are incorporated into the binding. GPIO controller
function in MAX77620 has no dedicated node and is folded into the parent
node itself.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/gpio/trivial-gpio.yaml           |   2 -
 .../devicetree/bindings/mfd/max77620.txt      | 162 -------
 .../bindings/mfd/maxim,max77620.yaml          | 424 ++++++++++++++++++
 .../bindings/thermal/max77620_thermal.txt     |  70 ---
 4 files changed, 424 insertions(+), 234 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/max77620.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77620.yaml
 delete mode 100644 Documentation/devicetree/bindings/thermal/max77620_thermal.txt

diff --git a/Documentation/devicetree/bindings/gpio/trivial-gpio.yaml b/Documentation/devicetree/bindings/gpio/trivial-gpio.yaml
index 3f4bbd57fc52..fe9b14a72d69 100644
--- a/Documentation/devicetree/bindings/gpio/trivial-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/trivial-gpio.yaml
@@ -27,7 +27,6 @@ properties:
           - gateworks,pld-gpio
           - ibm,ppc4xx-gpio
           - loongson,ls1x-gpio
-          - maxim,max77620
           - nintendo,hollywood-gpio
           - nxp,pca9570
           - nxp,pca9571
@@ -86,7 +85,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - maxim,max77620
               - rockchip,rk3328-grf-gpio
               - ti,lp3943-gpio
               - ti,palmas-gpio
diff --git a/Documentation/devicetree/bindings/mfd/max77620.txt b/Documentation/devicetree/bindings/mfd/max77620.txt
deleted file mode 100644
index 5a642a51d58e..000000000000
--- a/Documentation/devicetree/bindings/mfd/max77620.txt
+++ /dev/null
@@ -1,162 +0,0 @@
-MAX77620 Power management IC from Maxim Semiconductor.
-
-Required properties:
--------------------
-- compatible: Must be one of
-		"maxim,max77620"
-		"maxim,max20024"
-		"maxim,max77663"
-- reg: I2C device address.
-
-Optional properties:
--------------------
-- interrupts:		The interrupt on the parent the controller is
-			connected to.
-- interrupt-controller: Marks the device node as an interrupt controller.
-- #interrupt-cells:	is <2> and their usage is compliant to the 2 cells
-			variant of <../interrupt-controller/interrupts.txt>
-			IRQ numbers for different interrupt source of MAX77620
-			are defined at dt-bindings/mfd/max77620.h.
-
-- system-power-controller: Indicates that this PMIC is controlling the
-			   system power, see [1] for more details.
-
-[1] Documentation/devicetree/bindings/power/power-controller.txt
-
-Optional subnodes and their properties:
-=======================================
-
-Flexible power sequence configurations:
---------------------------------------
-The Flexible Power Sequencer (FPS) allows each regulator to power up under
-hardware or software control. Additionally, each regulator can power on
-independently or among a group of other regulators with an adjustable power-up
-and power-down delays (sequencing). GPIO1, GPIO2, and GPIO3 can be programmed
-to be part of a sequence allowing external regulators to be sequenced along
-with internal regulators. 32KHz clock can be programmed to be part of a
-sequence.
-
-The flexible sequencing structure consists of two hardware enable inputs
-(EN0, EN1), and 3 master sequencing timers called FPS0, FPS1 and FPS2.
-Each master sequencing timer is programmable through its configuration
-register to have a hardware enable source (EN1 or EN2) or a software enable
-source (SW). When enabled/disabled, the master sequencing timer generates
-eight sequencing events on different time periods called slots. The time
-period between each event is programmable within the configuration register.
-Each regulator, GPIO1, GPIO2, GPIO3, and 32KHz clock has a flexible power
-sequence slave register which allows its enable source to be specified as
-a flexible power sequencer timer or a software bit. When a FPS source of
-regulators, GPIOs and clocks specifies the enable source to be a flexible
-power sequencer, the power up and power down delays can be specified in
-the regulators, GPIOs and clocks flexible power sequencer configuration
-registers.
-
-When FPS event cleared (set to LOW), regulators, GPIOs and 32KHz
-clock are set into following state at the sequencing event that
-corresponds to its flexible sequencer configuration register.
-	Sleep state: 			In this state, regulators, GPIOs
-					and 32KHz clock get disabled at
-					the sequencing event.
-	Global Low Power Mode (GLPM):	In this state, regulators are set in
-					low power mode at the sequencing event.
-
-The configuration parameters of FPS is provided through sub-node "fps"
-and their child for FPS specific. The child node name for FPS are "fps0",
-"fps1", and "fps2" for FPS0, FPS1 and FPS2 respectively.
-
-The FPS configurations like FPS source, power up and power down slots for
-regulators, GPIOs and 32kHz clocks are provided in their respective
-configuration nodes which is explained in respective sub-system DT
-binding document.
-
-There is need for different FPS configuration parameters based on system
-state like when system state changed from active to suspend or active to
-power off (shutdown).
-
-Optional properties:
--------------------
--maxim,fps-event-source:		u32, FPS event source like external
-					hardware input to PMIC i.e. EN0, EN1 or
-					software (SW).
-					The macros are defined on
-						dt-bindings/mfd/max77620.h
-					for different control source.
-					- MAX77620_FPS_EVENT_SRC_EN0
-						for hardware input pin EN0.
-					- MAX77620_FPS_EVENT_SRC_EN1
-						for hardware input pin EN1.
-					- MAX77620_FPS_EVENT_SRC_SW
-						for software control.
-
--maxim,shutdown-fps-time-period-us:	u32, FPS time period in microseconds
-					when system enters in to shutdown
-					state.
-
--maxim,suspend-fps-time-period-us:	u32, FPS time period in microseconds
-					when system enters in to suspend state.
-
--maxim,device-state-on-disabled-event:	u32, describe the PMIC state when FPS
-					event cleared (set to LOW) whether it
-					should go to sleep state or low-power
-					state. Following are valid values:
-					- MAX77620_FPS_INACTIVE_STATE_SLEEP
-						to set the PMIC state to sleep.
-					- MAX77620_FPS_INACTIVE_STATE_LOW_POWER
-						to set the PMIC state to low
-						power.
-					Absence of this property or other value
-					will not change device state when FPS
-					event get cleared.
-
-Here supported time periods by device in microseconds are as follows:
-MAX77620 supports 40, 80, 160, 320, 640, 1280, 2560 and 5120 microseconds.
-MAX20024 supports 20, 40, 80, 160, 320, 640, 1280 and 2540 microseconds.
-MAX77663 supports 20, 40, 80, 160, 320, 640, 1280 and 2540 microseconds.
-
--maxim,power-ok-control: configure map power ok bit
-			1: Enables POK(Power OK) to control nRST_IO and GPIO1
-			POK function.
-			0: Disables POK control.
-			if property missing, do not configure MPOK bit.
-			If POK mapping is enabled for GPIO1/nRST_IO then,
-			GPIO1/nRST_IO pins are HIGH only if all rails
-			that have POK control enabled are HIGH.
-			If any of the rails goes down(which are enabled for POK
-			control) then, GPIO1/nRST_IO goes LOW.
-			this property is valid for max20024 only.
-
-For DT binding details of different sub modules like GPIO, pincontrol,
-regulator, power, please refer respective device-tree binding document
-under their respective sub-system directories.
-
-Example:
---------
-#include <dt-bindings/mfd/max77620.h>
-
-max77620@3c {
-	compatible = "maxim,max77620";
-	reg = <0x3c>;
-
-	interrupt-parent = <&intc>;
-	interrupts = <0 86 IRQ_TYPE_NONE>;
-
-	interrupt-controller;
-	#interrupt-cells = <2>;
-
-	fps {
-		fps0 {
-			maxim,shutdown-fps-time-period-us = <1280>;
-			maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_EN1>;
-		};
-
-		fps1 {
-			maxim,shutdown-fps-time-period-us = <1280>;
-			maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_EN0>;
-		};
-
-		fps2 {
-			maxim,shutdown-fps-time-period-us = <1280>;
-			maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_SW>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77620.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77620.yaml
new file mode 100644
index 000000000000..85d7fe0f9f85
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77620.yaml
@@ -0,0 +1,424 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/maxim,max77620.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MAX77620 Power management IC from Maxim Semiconductor
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - maxim,max20024
+      - maxim,max77620
+      - maxim,max77663
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+    description:
+      Device has 8 GPIO pins which can be configured as GPIO as well as
+      the special IO functions. The first cell is the pin number, and the
+      second cell is used to specify the gpio polarity (GPIO_ACTIVE_HIGH or
+      GPIO_ACTIVE_LOW).
+
+  system-power-controller: true
+
+  "#thermal-sensor-cells":
+    const: 0
+    description:
+      Maxim Semiconductor MAX77620 supports alarm interrupts when its
+      die temperature crosses 120C and 140C. These threshold temperatures
+      are not configurable. Device does not provide the real temperature
+      of die other than just indicating whether temperature is above or
+      below threshold level.
+
+  fps:
+    type: object
+    additionalProperties: false
+    description: |
+      The Flexible Power Sequencer (FPS) allows each regulator to power up
+      under hardware or software control. Additionally, each regulator can
+      power on independently or among a group of other regulators with an
+      adjustable power-up and power-down delays (sequencing). GPIO1, GPIO2,
+      and GPIO3 can be programmed to be part of a sequence allowing external
+      regulators to be sequenced along with internal regulators. 32KHz clock
+      can be programmed to be part of a sequence.
+
+      The flexible sequencing structure consists of two hardware enable inputs
+      (EN0, EN1), and 3 master sequencing timers called FPS0, FPS1 and FPS2.
+      Each master sequencing timer is programmable through its configuration
+      register to have a hardware enable source (EN1 or EN2) or a software enable
+      source (SW). When enabled/disabled, the master sequencing timer generates
+      eight sequencing events on different time periods called slots. The time
+      period between each event is programmable within the configuration register.
+      Each regulator, GPIO1, GPIO2, GPIO3, and 32KHz clock has a flexible power
+      sequence slave register which allows its enable source to be specified as
+      a flexible power sequencer timer or a software bit. When a FPS source of
+      regulators, GPIOs and clocks specifies the enable source to be a flexible
+      power sequencer, the power up and power down delays can be specified in
+      the regulators, GPIOs and clocks flexible power sequencer configuration
+      registers.
+
+      When FPS event cleared (set to LOW), regulators, GPIOs and 32KHz clock
+      are set into following state at the sequencing event that corresponds
+      to its flexible sequencer configuration register.
+
+      Sleep state: In this state, regulators, GPIOs and 32KHz clock get disabled
+                   at the sequencing event.
+      Global Low Power Mode (GLPM): In this state, regulators are set in low
+                                    power mode at the sequencing event.
+
+      The configuration parameters of FPS is provided through sub-node "fps"
+      and their child for FPS specific. The child node name for FPS are "fps0",
+      "fps1", and "fps2" for FPS0, FPS1 and FPS2 respectively.
+
+      The FPS configurations like FPS source, power up and power down slots for
+      regulators, GPIOs and 32kHz clocks are provided in their respective
+      configuration nodes which is explained in respective sub-system DT
+      binding document.
+
+      There is need for different FPS configuration parameters based on system
+      state like when system state changed from active to suspend or active to
+      power off (shutdown).
+
+    patternProperties:
+      "^fps[0-2]$":
+        type: object
+        additionalProperties: false
+
+        properties:
+          maxim,fps-event-source:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: |
+              FPS event source like external hardware input to PMIC i.e. EN0, EN1
+              or software (SW).
+
+              The macros are defined on dt-bindings/mfd/max77620.h for different
+              control source.
+                - MAX77620_FPS_EVENT_SRC_EN0 for hardware input pin EN0.
+                - MAX77620_FPS_EVENT_SRC_EN1 for hardware input pin EN1.
+                - MAX77620_FPS_EVENT_SRC_SW for software control.
+
+          maxim,shutdown-fps-time-period-us:
+            description:
+              FPS time period in microseconds when system enters in to shutdown state.
+
+          maxim,suspend-fps-time-period-us:
+            description:
+              FPS time period in microseconds when system enters in to suspend state.
+
+          maxim,device-state-on-disabled-event:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: |
+              Describe the PMIC state when FPS event cleared (set to LOW) whether it
+              should go to sleep state or low-power state. Following are valid values:
+                - MAX77620_FPS_INACTIVE_STATE_SLEEP to set the PMIC state to sleep.
+                - MAX77620_FPS_INACTIVE_STATE_LOW_POWER to set the PMIC state to low
+                  power.
+              Absence of this property or other value will not change device state
+              when FPS event get cleared.
+
+          maxim,power-ok-control:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: |
+              Configure map power ok bit
+
+              1: Enables POK(Power OK) to control nRST_IO and GPIO1 POK function.
+              0: Disables POK control.
+
+              If property missing, do not configure MPOK bit. If POK mapping is
+              enabled for GPIO1/nRST_IO then, GPIO1/nRST_IO pins are HIGH only if
+              all rails that have POK control enabled are HIGH. If any of the rails
+              goes down (which are enabled for POK control) then, GPIO1/nRST_IO
+              goes LOW.
+            enum: [0, 1]
+
+  pinmux:
+    $ref: /schemas/pinctrl/maxim,max77620-pinctrl.yaml
+
+  regulators:
+    $ref: /schemas/regulator/maxim,max77620-regulator.yaml
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - maxim,max20024
+              - maxim,max77663
+    then:
+      properties:
+        "#thermal-sensor-cells": false
+        fps:
+          patternProperties:
+            "^fps[0-2]$":
+              properties:
+                maxim,shutdown-fps-time-period-us:
+                  enum: [20, 40, 80, 160, 320, 640, 1280, 2540]
+                maxim,suspend-fps-time-period-us:
+                  enum: [20, 40, 80, 160, 320, 640, 1280, 2540]
+                maxim,power-ok-control: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: maxim,max77620
+    then:
+      properties:
+        fps:
+          patternProperties:
+            "^fps[0-2]$":
+              properties:
+                maxim,shutdown-fps-time-period-us:
+                  enum: [40, 80, 160, 320, 640, 1280, 2560, 5120]
+                maxim,suspend-fps-time-period-us:
+                  enum: [40, 80, 160, 320, 640, 1280, 2560, 5120]
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/mfd/max77620.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@3c {
+            compatible = "maxim,max77620";
+            reg = <0x3c>;
+
+            interrupt-parent = <&gpio>;
+            interrupts = <86 IRQ_TYPE_LEVEL_HIGH>;
+
+            interrupt-controller;
+            #interrupt-cells = <2>;
+
+            gpio-controller;
+            #gpio-cells = <2>;
+
+            #thermal-sensor-cells = <0>;
+
+            system-power-controller;
+
+            pinctrl-names = "default";
+            pinctrl-0 = <&max77620_default>;
+
+            max77620_default: pinmux {
+                gpio0 {
+                    pins = "gpio0";
+                    function = "gpio";
+                };
+
+                gpio1 {
+                    pins = "gpio1";
+                    function = "fps-out";
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
+                };
+
+                gpio2 {
+                    pins = "gpio2";
+                    function = "fps-out";
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_1>;
+                };
+
+                gpio3 {
+                    pins = "gpio3";
+                    function = "gpio";
+                };
+
+                gpio4 {
+                    pins = "gpio4";
+                    function = "32k-out1";
+                };
+
+                gpio5-6 {
+                    pins = "gpio5", "gpio6";
+                    function = "gpio";
+                    drive-push-pull = <1>;
+                };
+
+                gpio7 {
+                    pins = "gpio7";
+                    function = "gpio";
+                };
+            };
+
+            fps {
+                fps0 {
+                    maxim,shutdown-fps-time-period-us = <1280>;
+                    maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_EN0>;
+                };
+
+                fps1 {
+                    maxim,shutdown-fps-time-period-us = <1280>;
+                    maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_EN1>;
+                };
+
+                fps2 {
+                    maxim,shutdown-fps-time-period-us = <1280>;
+                    maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_SW>;
+                };
+            };
+
+            regulators {
+                in-sd0-supply = <&vdd_5v0_vbus>;
+                in-sd1-supply = <&vdd_5v0_vbus>;
+                in-sd2-supply = <&vdd_5v0_vbus>;
+                in-sd3-supply = <&vdd_5v0_vbus>;
+
+                in-ldo0-1-supply = <&vdd_1v8_vio>;
+                in-ldo2-supply   = <&vdd_3v3_vbat>;
+                in-ldo3-5-supply = <&vdd_3v3_vbat>;
+                in-ldo4-6-supply = <&vdd_3v3_vbat>;
+                in-ldo7-8-supply = <&vdd_1v8_vio>;
+
+                sd0 {
+                    regulator-name = "vdd_cpu";
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <1250000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+                };
+
+                sd1 {
+                    regulator-name = "vdd_core";
+                    regulator-min-microvolt = <950000>;
+                    regulator-max-microvolt = <1350000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_1>;
+                };
+
+                vdd_1v8_vio: sd2 {
+                    regulator-name = "vdd_1v8_gen";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+                };
+
+                sd3 {
+                    regulator-name = "vddio_ddr";
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <1200000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+                };
+
+                ldo0 {
+                    regulator-name = "avdd_pll";
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <1200000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_1>;
+                };
+
+                ldo1 {
+                    regulator-name = "vdd_ddr_hs";
+                    regulator-min-microvolt = <1000000>;
+                    regulator-max-microvolt = <1000000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+                };
+
+                ldo2 {
+                    regulator-name = "avdd_usb";
+                    regulator-min-microvolt = <3300000>;
+                    regulator-max-microvolt = <3300000>;
+
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+                };
+
+                ldo3 {
+                    regulator-name = "vdd_sdmmc3";
+                    regulator-min-microvolt = <3000000>;
+                    regulator-max-microvolt = <3000000>;
+                    regulator-always-on;
+
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+                };
+
+                ldo4 {
+                    regulator-name = "vdd_rtc";
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <1200000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
+                };
+
+                ldo5 {
+                    regulator-name = "vdd_ddr_rx";
+                    regulator-min-microvolt = <2850000>;
+                    regulator-max-microvolt = <2850000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
+                };
+
+                ldo6 {
+                    regulator-name = "avdd_osc";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+                };
+
+                ldo7 {
+                    regulator-name = "vdd_1v2_mhl";
+                    regulator-min-microvolt = <1050000>;
+                    regulator-max-microvolt = <1250000>;
+
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+                };
+
+                ldo8 {
+                    regulator-name = "avdd_dsi_csi";
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <1200000>;
+
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+                };
+            };
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/thermal/max77620_thermal.txt b/Documentation/devicetree/bindings/thermal/max77620_thermal.txt
deleted file mode 100644
index 82ed5d487966..000000000000
--- a/Documentation/devicetree/bindings/thermal/max77620_thermal.txt
+++ /dev/null
@@ -1,70 +0,0 @@
-Thermal driver for MAX77620 Power management IC from Maxim Semiconductor.
-
-Maxim Semiconductor MAX77620 supports alarm interrupts when its
-die temperature crosses 120C and 140C. These threshold temperatures
-are not configurable. Device does not provide the real temperature
-of die other than just indicating whether temperature is above or
-below threshold level.
-
-Required properties:
--------------------
-#thermal-sensor-cells:	For more details, please refer to
-			<devicetree/bindings/thermal/thermal-sensor.yaml>
-			The value must be 0.
-
-For more details, please refer generic thermal DT binding document
-<devicetree/bindings/thermal/thermal*.yaml>.
-
-Please refer <devicetree/bindings/mfd/max77620.txt> for mfd DT binding
-document for the MAX77620.
-
-Example:
---------
-#include <dt-bindings/mfd/max77620.h>
-#include <dt-bindings/thermal/thermal.h>
-...
-
-i2c@7000d000 {
-	spmic: max77620@3c {
-		compatible = "maxim,max77620";
-		:::::
-		#thermal-sensor-cells = <0>;
-		:::
-	};
-};
-
-cool_dev: cool-dev {
-	compatible = "cooling-dev";
-	#cooling-cells = <2>;
-};
-
-thermal-zones {
-	PMIC-Die {
-		polling-delay = <0>;
-		polling-delay-passive = <0>;
-		thermal-sensors = <&spmic>;
-
-		trips {
-			pmic_die_warn_temp_thresh: hot-die {
-				temperature = <120000>;
-				type = "hot";
-				hysteresis = <0>;
-			};
-
-			pmic_die_cirt_temp_thresh: cirtical-die {
-				temperature = <140000>;
-				type = "critical";
-				hysteresis = <0>;
-			};
-		};
-
-		cooling-maps {
-			map0 {
-				trip = <&pmic_die_warn_temp_thresh>;
-				cooling-device = <&cool_dev THERMAL_NO_LIMIT
-						  THERMAL_NO_LIMIT>;
-				contribution = <100>;
-			};
-		};
-	};
-};
-- 
2.51.0

