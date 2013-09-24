From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 1/6] thermal: exynos: fix: Return from exynos_report_trigger()
 when therm_dev is NULL
Date: Tue, 24 Sep 2013 10:08:17 +0200
Message-ID: <1380010102-25817-2-git-send-email-l.majewski@samsung.com>
References: <1380010102-25817-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1380010102-25817-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The commit 4de0bdaa9677d11406c9becb70c60887c957e1f0
("thermal: exynos: Add support for instance based register/unregister")
broke check for presence of therm_dev at global thermal zone in
exynos_report_trigger().

The resulting wrong test prevents thermal_zone_device_update() call, which
calls handlers for situation when trip points are passed.
Such behavior prevents thermal driver from proper reaction (when TMU interrupt
is raised) in a situation when overheating is detected at TMU hardware.
This patch fixes it.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 drivers/thermal/samsung/exynos_thermal_common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_thermal_common.c b/drivers/thermal/samsung/exynos_thermal_common.c
index f10a6ad..55a912a 100644
--- a/drivers/thermal/samsung/exynos_thermal_common.c
+++ b/drivers/thermal/samsung/exynos_thermal_common.c
@@ -310,7 +310,7 @@ void exynos_report_trigger(struct thermal_sensor_conf *conf)
 	}
 
 	th_zone = conf->pzone_data;
-	if (th_zone->therm_dev)
+	if (!th_zone->therm_dev)
 		return;
 
 	if (th_zone->bind == false) {
-- 
1.7.10.4
