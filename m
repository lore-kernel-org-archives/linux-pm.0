From: Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v2 1/3] mfd: cros: add charger port count command definition
Date: Fri, 10 Aug 2018 15:13:47 +0200
Message-ID: <20180810131349.3883-2-fparent@baylibre.com>
References: <20180810131349.3883-1-fparent@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180810131349.3883-1-fparent@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, gpain@baylibre.com, Fabien Parent <fparent@baylibre.com>
List-Id: linux-pm@vger.kernel.org

A new more command has been added to the ChromeOS embedded controller
that allows to get the number of charger port count. Unlike
EC_CMD_USB_PD_PORTS, this new command also includes the dedicated
port if present.

This command will be used to expose the dedicated charger port
in the ChromeOS charger driver.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
V1 -> V2:
  * No change
---
 include/linux/mfd/cros_ec_commands.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 0d926492ac3a..e3187f8bdb7e 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -3005,6 +3005,16 @@ struct ec_params_usb_pd_info_request {
 	uint8_t port;
 } __packed;
 
+/*
+ * This command will return the number of USB PD charge port + the number
+ * of dedicated port present.
+ * EC_CMD_USB_PD_PORTS does NOT include the dedicated ports
+ */
+#define EC_CMD_CHARGE_PORT_COUNT 0x0105
+struct ec_response_charge_port_count {
+	uint8_t port_count;
+} __packed;
+
 /* Read USB-PD Device discovery info */
 #define EC_CMD_USB_PD_DISCOVERY 0x0113
 struct ec_params_usb_pd_discovery_entry {
-- 
2.18.0
