From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 12/12] mfd: cros_ec: Add throttler sub-device
Date: Thu, 14 Jun 2018 12:47:12 -0700
Message-ID: <20180614194712.102134-13-mka@chromium.org>
References: <20180614194712.102134-1-mka@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180614194712.102134-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

Instantiate the CrOS EC throttler if it is enabled in the kernel
configuration.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v3:
- patch added to series

 drivers/mfd/cros_ec.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index 36156a41499c..5f52b6e2c21a 100644
--- a/drivers/mfd/cros_ec.c
+++ b/drivers/mfd/cros_ec.c
@@ -91,6 +91,10 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
 	return cros_ec_cmd_xfer(ec_dev, &buf.msg);
 }
 
+static const struct mfd_cell ec_throttler_cell = {
+	.name = "cros-ec-throttler",
+};
+
 int cros_ec_register(struct cros_ec_device *ec_dev)
 {
 	struct device *dev = ec_dev->dev;
@@ -153,6 +157,18 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_CROS_EC_THROTTLER)) {
+		err = mfd_add_devices(ec_dev->dev, PLATFORM_DEVID_AUTO,
+				      &ec_throttler_cell, 1, NULL, ec_dev->irq,
+				      NULL);
+		if (err) {
+			dev_err(dev,
+				"Failed to register throttler subdevice %d\n",
+				err);
+			return err;
+		}
+	}
+
 	if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
 		err = devm_of_platform_populate(dev);
 		if (err) {
-- 
2.18.0.rc1.242.g61856ae69a-goog
