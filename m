From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 7/9] pinctrl: samsung: Add property to mark pad state as
 suitable for power down
Date: Fri, 23 Dec 2016 13:24:47 +0100
Message-ID: <1482495889-6201-8-git-send-email-m.szyprowski@samsung.com>
References: <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161223122538epcas5p29515ceff21963ab035b3b32878830ce2@epcas5p2.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Add support for special property "samsung,off-state", which indicates a special
state suitable for device's "sleep" state. Its pin values/properties should
match the configuration in power down mode. It indicates that pin controller
can notify runtime power management subsystem, that it is ready for runtime
suspend if its all pins are configured for such state. This in turn might
allow to turn respective power domain off to reduce power consumption.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt | 8 ++++++++
 drivers/pinctrl/samsung/pinctrl-samsung.c                     | 4 ++++
 drivers/pinctrl/samsung/pinctrl-samsung.h                     | 1 +
 3 files changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
index b7bd2e12a269..354eea0e7798 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
@@ -105,6 +105,7 @@ Required Properties:
   - samsung,pin-drv: Drive strength configuration.
   - samsung,pin-pud-pdn: Pull up/down configuration in power down mode.
   - samsung,pin-drv-pdn: Drive strength configuration in power down mode.
+  - samsung,off-state: Mark this configuration as suitable for bank power off.
 
   The values specified by these config properties should be derived from the
   hardware manual and these values are programmed as-is into the pin
@@ -113,6 +114,13 @@ Required Properties:
   Note: A child should include atleast a pin function selection property or
   pin configuration property (one or more) or both.
 
+  Note: Special property "samsung,off-state" indicates that this state can
+  be used for device's "sleep" pins state. Its pin values/properties should
+  match the configuration in power down mode. It indicates that pin control
+  can notify runtime power management subsystem, that it is ready for runtime
+  suspend if its all pins are configured for such state. This in turn might
+  allow to turn respective power domain off to reduce power consumption.
+
   The client nodes that require a particular pin function selection and/or
   pin configuration should use the bindings listed in the "pinctrl-bindings.txt"
   file.
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index a7b7d75373f2..301169d2b6e1 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -692,6 +692,10 @@ static int samsung_pinctrl_create_function(struct device *dev,
 	}
 
 	func->name = func_np->full_name;
+	if (of_property_read_bool(func_np, "samsung,off-state"))
+		func->rpm_active = false;
+	else
+		func->rpm_active = true;
 
 	func->groups = devm_kzalloc(dev, npins * sizeof(char *), GFP_KERNEL);
 	if (!func->groups)
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index 32b949e2a89b..edeafa00abd3 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -280,6 +280,7 @@ struct samsung_pmx_func {
 	const char		**groups;
 	u8			num_groups;
 	u32			val;
+	bool			rpm_active;
 };
 
 /* list of all exported SoC specific data */
-- 
1.9.1
