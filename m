From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 5/8] thermal:cpu cooling:tegra: Provide deferred probing for
 tegra driver
Date: Thu, 13 Nov 2014 18:02:42 +0100
Message-ID: <1415898165-27406-6-git-send-email-l.majewski@samsung.com>
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
 drivers/thermal/tegra_soctherm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/thermal/tegra_soctherm.c b/drivers/thermal/tegra_soctherm.c
index 70f7e9e..9c5aaa4 100644
--- a/drivers/thermal/tegra_soctherm.c
+++ b/drivers/thermal/tegra_soctherm.c
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/thermal.h>
+#include <linux/cpufreq.h>
 
 #include <soc/tegra/fuse.h>
 
@@ -346,6 +347,12 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 
 	const struct tegra_tsensor *tsensors = t124_tsensors;
 
+#ifdef CONFIG_CPU_THERMAL
+	if (!cpufreq_get_current_driver()) {
+		dev_dbg(&pdev->dev, "no cpufreq driver!");
+		return -EPROBE_DEFER;
+	}
+#endif
 	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
 	if (!tegra)
 		return -ENOMEM;
-- 
2.0.0.rc2
