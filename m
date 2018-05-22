From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 1/2] power: supply: Add fwnode pointer to power_supply_config
 struct
Date: Tue, 22 May 2018 16:16:23 +0100
Message-ID: <c398d1fcc81017b9cc694a00d2c1f655874dfeac.1527000797.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1527000797.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1527000797.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com
List-Id: linux-pm@vger.kernel.org

To allow users of the power supply framework to be hw description
agnostic, this commit adds the ability to pass a fwnode pointer,
via the power_supply_config structure, to the initialisation code
of the core, instead of explicitly specifying of_ndoe. If that
fwnode pointer is provided then it will automatically resolve down
to of_node on platforms which support it, otherwise it will be NULL.

In the future, when ACPI support is added, this can be modified to
accommodate ACPI without the need to change calling code which
already provides the fwnode handle in this manner.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/power/supply/power_supply_core.c | 4 +++-
 include/linux/power_supply.h             | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index ecd68c2..f57ab0a 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -19,6 +19,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/power_supply.h>
+#include <linux/property.h>
 #include <linux/thermal.h>
 #include "power_supply.h"
 
@@ -874,7 +875,8 @@ static void psy_unregister_cooler(struct power_supply *psy)
 	psy->desc = desc;
 	if (cfg) {
 		psy->drv_data = cfg->drv_data;
-		psy->of_node = cfg->of_node;
+		psy->of_node =
+			cfg->fwnode ? to_of_node(cfg->fwnode) : cfg->of_node;
 		psy->supplied_to = cfg->supplied_to;
 		psy->num_supplicants = cfg->num_supplicants;
 	}
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 0c9a572..b21c4bd9 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -199,6 +199,8 @@ enum power_supply_notifier_events {
 /* Run-time specific power supply configuration */
 struct power_supply_config {
 	struct device_node *of_node;
+	struct fwnode_handle *fwnode;
+
 	/* Driver private data */
 	void *drv_data;
 
-- 
1.9.1
