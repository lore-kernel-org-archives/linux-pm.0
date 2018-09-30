From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 01/14] power: supply: core: add support for custom sysfs attributes
Date: Mon,  1 Oct 2018 00:03:36 +0200
Message-ID: <20180930220349.10515-2-sebastian.reichel@collabora.com>
References: <20180930220349.10515-1-sebastian.reichel@collabora.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180930220349.10515-1-sebastian.reichel@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Milo Kim <milo.kim@ti.com>, Andreas Dannenberg <dannenberg@ti.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Hans de Goede <hdegoede@redhat.com>, Liam Breck <kernel@networkimprov.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.com>
List-Id: linux-pm@vger.kernel.org

Add functionality to setup device specific sysfs attributes
in a race condition free manner

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/power_supply_core.c | 1 +
 include/linux/power_supply.h             | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index e85361878450..cb7ddced85ed 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -880,6 +880,7 @@ __power_supply_register(struct device *parent,
 	dev_set_drvdata(dev, psy);
 	psy->desc = desc;
 	if (cfg) {
+		dev->groups = cfg->attr_grp;
 		psy->drv_data = cfg->drv_data;
 		psy->of_node =
 			cfg->fwnode ? to_of_node(cfg->fwnode) : cfg->of_node;
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index f80769175c56..410466946890 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -204,6 +204,9 @@ struct power_supply_config {
 	/* Driver private data */
 	void *drv_data;
 
+	/* Device specific sysfs attributes */
+	const struct attribute_group **attr_grp;
+
 	char **supplied_to;
 	size_t num_supplicants;
 };
-- 
2.19.0
