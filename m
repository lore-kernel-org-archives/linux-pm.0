From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 2/2] typec: tcpm: Provide fwnode pointer as part of psy_cfg
Date: Tue, 22 May 2018 16:16:24 +0100
Message-ID: <449707040719c8845cf9fa6bc779bae25fca54a5.1527000797.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1527000797.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1527000797.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com
List-Id: linux-pm@vger.kernel.org

For supply registration, provide fwnode pointer of the port device,
via the power_supply_config structure, to allow other psy drivers
to add us as a supplier. At present this only applies to DT
based platforms using the 'power-supplies' DT property, but in the
future should also work for ACPI platforms when the relevant support
is added to the power_supply core.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/tcpm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index 72996cc..0ccd2ce 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -14,6 +14,7 @@
 #include <linux/mutex.h>
 #include <linux/power_supply.h>
 #include <linux/proc_fs.h>
+#include <linux/property.h>
 #include <linux/sched/clock.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
@@ -4500,6 +4501,7 @@ static int devm_tcpm_psy_register(struct tcpm_port *port)
 	char *psy_name;
 
 	psy_cfg.drv_data = port;
+	psy_cfg.fwnode = dev_fwnode(port->dev);
 	psy_name = devm_kzalloc(port->dev, psy_name_len, GFP_KERNEL);
 	if (!psy_name)
 		return -ENOMEM;
-- 
1.9.1
