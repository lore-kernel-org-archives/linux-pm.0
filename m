From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 3/3] mfd: cros_ec_dev: Register cros_usbpd-charger driver as a subdevice.
Date: Wed, 17 Jan 2018 18:59:32 +0100
Message-ID: <20180117175932.20636-4-enric.balletbo@collabora.com>
References: <20180117175932.20636-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117175932.20636-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>
Cc: Gwendal Grignou <gwendal@chromium.org>, Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Sameer Nanda <snanda@chromium.org>
List-Id: linux-pm@vger.kernel.org

From: Sameer Nanda <snanda@chromium.org>

Check whether this EC instance has USBPD host command support and
instatiate the cros_usbpd-charger driver as a subdevice in such case.

Signed-off-by: Sameer Nanda <snanda@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 drivers/mfd/cros_ec_dev.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 26a8731499bf..d98f03f3d251 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -37,6 +37,9 @@ static const struct attribute_group *cros_ec_groups[] = {
 	&cros_ec_attr_group,
 	&cros_ec_lightbar_attr_group,
 	&cros_ec_vbc_attr_group,
+#if IS_ENABLED(CONFIG_CHARGER_CROS_USB_PD)
+	&cros_usb_pd_charger_attr_group,
+#endif
 	NULL,
 };
 
@@ -269,6 +272,24 @@ static void __remove(struct device *dev)
 	kfree(ec);
 }
 
+static const struct mfd_cell cros_usb_pd_charger_devs[] = {
+	{
+		.name = "cros-usb-pd-charger",
+		.id   = -1,
+	},
+};
+
+static void cros_ec_usb_pd_charger_register(struct cros_ec_dev *ec)
+{
+	int ret;
+
+	ret = mfd_add_devices(ec->dev, 0, cros_usb_pd_charger_devs,
+			      ARRAY_SIZE(cros_usb_pd_charger_devs),
+			      NULL, 0, NULL);
+	if (ret)
+		dev_err(ec->dev, "failed to add usb-pd-charger device\n");
+}
+
 static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 {
 	/*
@@ -451,6 +472,10 @@ static int ec_device_probe(struct platform_device *pdev)
 	if (cros_ec_debugfs_init(ec))
 		dev_warn(dev, "failed to create debugfs directory\n");
 
+	/* check whether this EC instance has the PD charge manager */
+	if (cros_ec_check_features(ec, EC_FEATURE_USB_PD))
+		cros_ec_usb_pd_charger_register(ec);
+
 	/* check whether this EC is a sensor hub. */
 	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
 		cros_ec_sensors_register(ec);
-- 
2.15.1
