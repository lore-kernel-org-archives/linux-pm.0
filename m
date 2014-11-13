From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 3/8] thermal:cpu cooling:rcar: Provide deferred probing for
 rcar driver
Date: Thu, 13 Nov 2014 18:02:40 +0100
Message-ID: <1415898165-27406-4-git-send-email-l.majewski@samsung.com>
References: <1411547232-21493-1-git-send-email-l.majewski@samsung.com>
 <1415898165-27406-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1415898165-27406-1-git-send-email-l.majewski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux PM list <linux-pm@vger.kernel.org>, Vincenzo Frascino <vincenzo.frascino@st.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Mikko Perttunen <mperttunen@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

When CPU freq is used as a thermal zone cooling device, one needs to wait
until cpufreq subsystem is properly initialized.

This code is similar to the one already available in imx_thermal.c file.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 drivers/thermal/rcar_thermal.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 8803e69..b268b4d 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -29,6 +29,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/thermal.h>
+#include <linux/cpufreq.h>
 
 #define IDLE_INTERVAL	5000
 
@@ -373,6 +374,12 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 	int ret = -ENODEV;
 	int idle = IDLE_INTERVAL;
 
+#ifdef CONFIG_CPU_THERMAL
+	if (!cpufreq_get_current_driver()) {
+		dev_dbg(&pdev->dev, "no cpufreq driver!");
+		return -EPROBE_DEFER;
+	}
+#endif
 	common = devm_kzalloc(dev, sizeof(*common), GFP_KERNEL);
 	if (!common)
 		return -ENOMEM;
-- 
2.0.0.rc2
