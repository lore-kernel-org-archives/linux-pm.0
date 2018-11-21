From: Anson Huang <anson.huang@nxp.com>
Subject: [PATCH V4] thermal: imx: fix for dependency on cpu-freq
Date: Wed, 21 Nov 2018 05:08:05 +0000
Message-ID: <1542776563-6716-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pm@vger.kernel.org

The thermal driver is a standalone driver for monitoring SoC temperature
by enabling thermal sensor, so it can be enabled even when CONFIG_CPU_FREQ
is NOT set. So remove the dependency with CPU_THERMAL.

Introduce dummy function of legacy cooling register/unregister to make
thermal driver probe successfully when CONFIG_CPU_FREQ is NOT set.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V3:
	rename the label of "cpufreq_put" with "legacy_cleanup".
 drivers/thermal/Kconfig       |  2 +-
 drivers/thermal/imx_thermal.c | 44 +++++++++++++++++++++++++++++++--------=
----
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 5422523..93bd3bb 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -212,7 +212,7 @@ config HISI_THERMAL
=20
 config IMX_THERMAL
 	tristate "Temperature sensor driver for Freescale i.MX SoCs"
-	depends on (ARCH_MXC && CPU_THERMAL) || COMPILE_TEST
+	depends on ARCH_MXC || COMPILE_TEST
 	depends on NVMEM || !NVMEM
 	depends on MFD_SYSCON
 	depends on OF
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 1566154..328ee05 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -648,15 +648,24 @@ static const struct of_device_id of_imx_thermal_match=
[] =3D {
 };
 MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
=20
+#ifdef CONFIG_CPU_FREQ
 /*
  * Create cooling device in case no #cooling-cells property is available i=
n
  * CPU node
  */
 static int imx_thermal_register_legacy_cooling(struct imx_thermal_data *da=
ta)
 {
-	struct device_node *np =3D of_get_cpu_node(data->policy->cpu, NULL);
+	struct device_node *np;
 	int ret;
=20
+	data->policy =3D cpufreq_cpu_get(0);
+	if (!data->policy) {
+		pr_debug("%s: CPUFreq policy not found\n", __func__);
+		return -EPROBE_DEFER;
+	}
+
+	np =3D of_get_cpu_node(data->policy->cpu, NULL);
+
 	if (!np || !of_find_property(np, "#cooling-cells", NULL)) {
 		data->cdev =3D cpufreq_cooling_register(data->policy);
 		if (IS_ERR(data->cdev)) {
@@ -669,6 +678,22 @@ static int imx_thermal_register_legacy_cooling(struct =
imx_thermal_data *data)
 	return 0;
 }
=20
+static void imx_thermal_unregister_legacy_cooling(struct imx_thermal_data =
*data)
+{
+	cpufreq_cooling_unregister(data->cdev);
+	cpufreq_cpu_put(data->policy);
+}
+#else
+static inline int imx_thermal_register_legacy_cooling(struct imx_thermal_d=
ata *data)
+{
+	return 0;
+}
+
+static inline void imx_thermal_unregister_legacy_cooling(struct imx_therma=
l_data *data)
+{
+}
+#endif
+
 static int imx_thermal_probe(struct platform_device *pdev)
 {
 	struct imx_thermal_data *data;
@@ -743,13 +768,9 @@ static int imx_thermal_probe(struct platform_device *p=
dev)
 	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
 		     data->socdata->power_down_mask);
=20
-	data->policy =3D cpufreq_cpu_get(0);
-	if (!data->policy) {
-		pr_debug("%s: CPUFreq policy not found\n", __func__);
-		return -EPROBE_DEFER;
-	}
-
 	ret =3D imx_thermal_register_legacy_cooling(data);
+	if (ret =3D=3D -EPROBE_DEFER)
+		return ret;
 	if (ret) {
 		dev_err(&pdev->dev,
 			"failed to register cpufreq cooling device: %d\n", ret);
@@ -762,7 +783,7 @@ static int imx_thermal_probe(struct platform_device *pd=
ev)
 		if (ret !=3D -EPROBE_DEFER)
 			dev_err(&pdev->dev,
 				"failed to get thermal clk: %d\n", ret);
-		goto cpufreq_put;
+		goto legacy_cleanup;
 	}
=20
 	/*
@@ -775,7 +796,7 @@ static int imx_thermal_probe(struct platform_device *pd=
ev)
 	ret =3D clk_prepare_enable(data->thermal_clk);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable thermal clk: %d\n", ret);
-		goto cpufreq_put;
+		goto legacy_cleanup;
 	}
=20
 	data->tz =3D thermal_zone_device_register("imx_thermal_zone",
@@ -829,9 +850,8 @@ static int imx_thermal_probe(struct platform_device *pd=
ev)
 	thermal_zone_device_unregister(data->tz);
 clk_disable:
 	clk_disable_unprepare(data->thermal_clk);
-cpufreq_put:
-	cpufreq_cooling_unregister(data->cdev);
-	cpufreq_cpu_put(data->policy);
+legacy_cleanup:
+	imx_thermal_unregister_legacy_cooling(data);
=20
 	return ret;
 }
--=20
2.7.4
