From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 1/9 v2] thermal: hisilicon: constify thermal_zone_of_device_ops structures
Date: Tue,  8 Aug 2017 17:08:55 +0200
Message-ID: <1502204943-20075-2-git-send-email-Julia.Lawall@lip6.fr>
References: <1502204943-20075-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502204943-20075-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The thermal_zone_of_device_ops structure is only passed as the fourth
argument to devm_thermal_zone_of_sensor_register, which is declared
as const.  Thus the thermal_zone_of_device_ops structure itself can
be const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---

v2: New patch

 drivers/thermal/hisi_thermal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 9c3ce34..bd3572c 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -206,7 +206,7 @@ static int hisi_thermal_get_temp(void *_sensor, int *temp)
 	return 0;
 }
 
-static struct thermal_zone_of_device_ops hisi_of_thermal_ops = {
+static const struct thermal_zone_of_device_ops hisi_of_thermal_ops = {
 	.get_temp = hisi_thermal_get_temp,
 };
 
