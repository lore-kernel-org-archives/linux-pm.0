From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH v2 4/4] power: ds2760_battery: add device tree glue
Date: Thu, 28 Jun 2018 09:55:40 +0200
Message-ID: <20180628075540.1757-5-daniel@zonque.org>
References: <20180628075540.1757-1-daniel@zonque.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180628075540.1757-1-daniel@zonque.org>
Sender: linux-kernel-owner@vger.kernel.org
To: zbr@ioremap.net, robh+dt@kernel.org, mark.rutland@arm.com, szabolcs.gyurko@tlt.hu
Cc: sre@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robert.jarzmik@free.fr, Daniel Mack <daniel@zonque.org>
List-Id: linux-pm@vger.kernel.org

The w1 slave device used by this driver now has a of_node in case it
was matched against a devicetree sub-node of the bus master. This can
now be passed down to the power supply core which will parse more
properties from the node, such as 'power-supplies'.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 drivers/power/supply/ds2760_battery.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/ds2760_battery.c b/drivers/power/supply/ds2760_battery.c
index ae180dc929c9..77dfdeb5fbc0 100644
--- a/drivers/power/supply/ds2760_battery.c
+++ b/drivers/power/supply/ds2760_battery.c
@@ -510,6 +510,10 @@ static int ds2760_battery_probe(struct platform_device *pdev)
 	char status;
 	int retval = 0;
 	struct ds2760_device_info *di;
+	struct device *w1_dev;
+
+	w1_dev = pdev->dev.parent;
+	psy_cfg.of_node = w1_dev->of_node;
 
 	di = devm_kzalloc(&pdev->dev, sizeof(*di), GFP_KERNEL);
 	if (!di) {
@@ -520,7 +524,7 @@ static int ds2760_battery_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, di);
 
 	di->dev				= &pdev->dev;
-	di->w1_dev			= pdev->dev.parent;
+	di->w1_dev			= w1_dev;
 	di->bat_desc.name		= dev_name(&pdev->dev);
 	di->bat_desc.type		= POWER_SUPPLY_TYPE_BATTERY;
 	di->bat_desc.properties		= ds2760_battery_props;
-- 
2.17.1
