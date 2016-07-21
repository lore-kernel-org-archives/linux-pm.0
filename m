From: Grzegorz Jaszczyk <jaz@semihalf.com>
Subject: [PATCH] thermal: armada: add support for suspend/resume
Date: Thu, 21 Jul 2016 12:43:27 +0200
Message-ID: <1469097807-17748-1-git-send-email-jaz@semihalf.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com, gregory.clement@free-electrons.com
Cc: mw@semihalf.com, jaz@semihalf.com, alior@marvell.com
List-Id: linux-pm@vger.kernel.org

There is no need to implement subroutine for suspend since there is no
data to store before suspending.

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
---
 drivers/thermal/armada_thermal.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index ae75328..65f9838 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -304,12 +304,26 @@ static int armada_thermal_exit(struct platform_device *pdev)
 	return 0;
 }
 
+static int armada_thermal_resume(struct device *dev)
+{
+	struct thermal_zone_device *thermal =
+		dev_get_drvdata(dev);
+	struct armada_thermal_priv *priv = thermal->devdata;
+
+	priv->data->init_sensor(to_platform_device(dev), priv);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(armada_thermal_pm_ops, NULL, armada_thermal_resume);
+
 static struct platform_driver armada_thermal_driver = {
 	.probe = armada_thermal_probe,
 	.remove = armada_thermal_exit,
 	.driver = {
 		.name = "armada_thermal",
 		.of_match_table = armada_thermal_id_table,
+		.pm = &armada_thermal_pm_ops,
 	},
 };
 
-- 
1.8.3.1
