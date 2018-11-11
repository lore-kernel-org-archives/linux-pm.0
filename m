From: Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] power: reset: gpio-poweroff: add ability to specific active and inactive delays
Date: Sun, 11 Nov 2018 22:45:38 +0100
Message-ID: <20181111214538.32477-1-heiko@sntech.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mdf@kernel.org, heiko@sntech.de, Heiko Stuebner <heiko.stuebner@bq.com>
List-Id: linux-pm@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@bq.com>

Similar to gpio-reset allow to specify active and inactive delays
while keeping the 100ms defaults that were used previously all the time.

The dt-properties are named the same as in gpio-reset but get an "-ms"
suffix as properties should contain such a suffix specifying its unit.

Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
---
 .../devicetree/bindings/power/reset/gpio-poweroff.txt  |  2 ++
 drivers/power/reset/gpio-poweroff.c                    | 10 ++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
index 6d8980c18c34..3e56c1b34a4c 100644
--- a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
+++ b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
@@ -27,6 +27,8 @@ Optional properties:
   it to an output when the power-off handler is called. If this optional
   property is not specified, the GPIO is initialized as an output in its
   inactive state.
+- active-delay-ms: Delay (default 100) to wait after driving gpio active
+- inactive-delay-ms: Delay (default 100) to wait after driving gpio inactive
 - timeout-ms: Time to wait before asserting a WARN_ON(1). If nothing is
               specified, 3000 ms is used.
 
diff --git a/drivers/power/reset/gpio-poweroff.c b/drivers/power/reset/gpio-poweroff.c
index 38206c39b3bf..52525b6c18db 100644
--- a/drivers/power/reset/gpio-poweroff.c
+++ b/drivers/power/reset/gpio-poweroff.c
@@ -26,6 +26,8 @@
  */
 static struct gpio_desc *reset_gpio;
 static u32 timeout = DEFAULT_TIMEOUT_MS;
+static u32 active_delay = 100;
+static u32 inactive_delay = 100;
 
 static void gpio_poweroff_do_poweroff(void)
 {
@@ -33,10 +35,11 @@ static void gpio_poweroff_do_poweroff(void)
 
 	/* drive it active, also inactive->active edge */
 	gpiod_direction_output(reset_gpio, 1);
-	mdelay(100);
+	mdelay(active_delay);
+
 	/* drive inactive, also active->inactive edge */
 	gpiod_set_value_cansleep(reset_gpio, 0);
-	mdelay(100);
+	mdelay(inactive_delay);
 
 	/* drive it active, also inactive->active edge */
 	gpiod_set_value_cansleep(reset_gpio, 1);
@@ -66,6 +69,9 @@ static int gpio_poweroff_probe(struct platform_device *pdev)
 	else
 		flags = GPIOD_OUT_LOW;
 
+	device_property_read_u32(&pdev->dev, "active-delay-ms", &active_delay);
+	device_property_read_u32(&pdev->dev, "inactive-delay-ms",
+				 &inactive_delay);
 	device_property_read_u32(&pdev->dev, "timeout-ms", &timeout);
 
 	reset_gpio = devm_gpiod_get(&pdev->dev, NULL, flags);
-- 
2.18.0
