From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 3/4] thermal: exynos: constify thermal_zone_of_device_ops structures
Date: Sat,  5 Aug 2017 22:37:16 +0200
Message-ID: <1501965437-30730-4-git-send-email-Julia.Lawall@lip6.fr>
References: <1501965437-30730-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501965437-30730-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The thermal_zone_of_device_ops structure is only passed as the fourth
argument to thermal_zone_of_sensor_register, which is declared as const.
Thus the thermal_zone_of_device_ops structure itself can be const.

Done with the help of Coccinelle.

// <smpl>
@r disable optional_qualifier@
identifier i;
position p;
@@
static struct thermal_zone_of_device_ops i@p = { ... };

@ok1@
identifier r.i;
expression e1,e2,e3;
position p;
@@
thermal_zone_of_sensor_register(e1,e2,e3,&i@p)

@bad@
position p != {r.p,ok1.p};
identifier r.i;
struct thermal_zone_of_device_ops e;
@@
e@i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct thermal_zone_of_device_ops i = { ... };
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/thermal/samsung/exynos_tmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 7b8ef09..ed805c7 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1286,7 +1286,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 	return 0;
 }
 
-static struct thermal_zone_of_device_ops exynos_sensor_ops = {
+static const struct thermal_zone_of_device_ops exynos_sensor_ops = {
 	.get_temp = exynos_get_temp,
 	.set_emul_temp = exynos_tmu_set_emulation,
 };
