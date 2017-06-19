From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH] thermal: imx: interpret fsl,tempmon-data through nvmem
Date: Mon, 19 Jun 2017 16:40:43 +0300
Message-ID: <d1a8ec1ef73aefe6018f6a4923bd04b3ac34a5d4.1497879110.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Fabio Estevam <fabio.estevam@nxp.com>
Cc: Bai Ping <ping.bai@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On imx6sx accessing the ocotp memory area directly is wrong because the
ocotp clock needs to be enabled first. Fix this by reinterpreting the
fsl,tempmon-data phandle as a reference to a nvmem_device and doing all
the read through that.

This clock requirement does not apply to older imx6qdl chips because
there the ocotp access clock (clk_ipg_s) is always enabled.

This is visible by comparing the "System Clocks, Gating, and Override"
tables (OCOTP rows) in the 6DQ and 6SX manuals:
http://www.nxp.com/assets/documents/data/en/reference-manuals/IMX6SXRM.pdf
http://www.nxp.com/assets/documents/data/en/reference-manuals/IMX6DQRM.pdf

This happens to work right now without this patch because the ocotp
clock might be enabled for some other reason. In particular it might be
enabled from the bootloader and it only gets disabled late during boot
in clk_disable_unused, after imx-thermal has completed probing.

If imx-thermal is compiled as a module then the system can hang on
probe.

This makes IMX_THERMAL depend on NVMEM_IMX_OCOTP but that driver seems
be already available for all chips that contain tempmon so it's
acceptable.

Reported-by: Lothar Waßmann <LW@KARO-electronics.de>
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---

This was reported as a comment to a patch adding tempmon support for
imx6ul (which is very similar to imx6sx). Since it already affects a
supported chip this patch is sent as a separate bugfix.

Link: https://lkml.org/lkml/2017/6/9/578

There are various other ways to fix this problem. The main advantage of
this solution is that it does not add a new binding but rather preserves
compatibility with old DTBs. It also aligns with the idea that
devicetree describes hardware relationships rather than a specific linux
implementation.

An alternative would have been to add a nvmem-cells binding to imx-thermal and
use that if available instead of fsl,tempmon-data. It might not be good to
sidestep the official nvmem bindings, the devicetree people were added so that
they have an opportunity to object.

In theory the "thermal grade" is a two-bit quantity and might be a
candidate for using a cell with a "bits" binding. However this causes
the nvmem core to issue reads of length and alignment less than 4 to the
imx-ocotp driver so additional fixes might be required.

 drivers/nvmem/core.c           | 15 ++++++++++++
 drivers/thermal/Kconfig        |  2 +-
 drivers/thermal/imx_thermal.c  | 53 ++++++++++++++++++++++++++----------------
 include/linux/nvmem-consumer.h |  6 +++++
 4 files changed, 55 insertions(+), 21 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 8c830a8..66502ca 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -630,6 +630,21 @@ struct nvmem_device *of_nvmem_device_get(struct device_node *np, const char *id)
 	return __nvmem_device_get(nvmem_np, NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(of_nvmem_device_get);
+
+/**
+ * of_nvmem_device_phandle_get() - Get nvmem device from a given phandle
+ *
+ * @nvmem_np: Device tree node for the nvmem device
+ *
+ * Return: ERR_PTR() on error or a valid pointer to a struct nvmem_device
+ * on success.
+ */
+struct nvmem_device *of_nvmem_device_phandle_get(struct device_node *nvmem_np)
+{
+
+	return __nvmem_device_get(nvmem_np, NULL, NULL);
+}
+EXPORT_SYMBOL_GPL(of_nvmem_device_phandle_get);
 #endif
 
 /**
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index b5b5fac..a427936 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -206,7 +206,7 @@ config HISI_THERMAL
 config IMX_THERMAL
 	tristate "Temperature sensor driver for Freescale i.MX SoCs"
 	depends on (ARCH_MXC && CPU_THERMAL) || COMPILE_TEST
-	depends on MFD_SYSCON
+	depends on NVMEM_IMX_OCOTP
 	depends on OF
 	help
 	  Support for Temperature Monitor (TEMPMON) found on Freescale i.MX SoCs.
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index fb648a4..1cf35bd 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/thermal.h>
 #include <linux/types.h>
+#include <linux/nvmem-consumer.h>
 
 #define REG_SET		0x4
 #define REG_CLR		0x8
@@ -55,8 +56,8 @@
 #define TEMPSENSE2_PANIC_VALUE_SHIFT	16
 #define TEMPSENSE2_PANIC_VALUE_MASK	0xfff0000
 
-#define OCOTP_MEM0			0x0480
-#define OCOTP_ANA1			0x04e0
+#define OCOTP_MEM0_OFFSET		32
+#define OCOTP_ANA1_OFFSET    		56
 
 /* The driver supports 1 passive trip point and 1 critical trip point */
 enum imx_thermal_trip {
@@ -347,29 +348,39 @@ static struct thermal_zone_device_ops imx_tz_ops = {
 static int imx_get_sensor_data(struct platform_device *pdev)
 {
 	struct imx_thermal_data *data = platform_get_drvdata(pdev);
-	struct regmap *map;
+	struct device_node *ocotp_np;
+	struct nvmem_device *ocotp;
 	int t1, n1;
 	int ret;
 	u32 val;
 	u64 temp64;
 
-	map = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
-					      "fsl,tempmon-data");
-	if (IS_ERR(map)) {
-		ret = PTR_ERR(map);
-		dev_err(&pdev->dev, "failed to get sensor regmap: %d\n", ret);
+	ocotp_np = of_parse_phandle(pdev->dev.of_node, "fsl,tempmon-data", 0);
+	if (IS_ERR(ocotp_np)) {
+		ret = PTR_ERR(ocotp_np);
+		dev_err(&pdev->dev, "failed to parse fsl,tempmon-data phandle: %d\n", ret);
+		return ret;
+	}
+	ocotp = of_nvmem_device_phandle_get(ocotp_np);
+	of_node_put(ocotp_np);
+	if (IS_ERR(ocotp)) {
+		ret = PTR_ERR(ocotp);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to get fsl,tempmon-data nvmem device: %d\n", ret);
 		return ret;
 	}
 
-	ret = regmap_read(map, OCOTP_ANA1, &val);
-	if (ret) {
+	ret = nvmem_device_read(ocotp, OCOTP_ANA1_OFFSET, sizeof(val), &val);
+	if (ret != sizeof(val)) {
 		dev_err(&pdev->dev, "failed to read sensor data: %d\n", ret);
-		return ret;
+		ret = -EIO;
+		goto out;
 	}
 
 	if (val == 0 || val == ~0) {
 		dev_err(&pdev->dev, "invalid sensor calibration data\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	/*
@@ -404,10 +415,11 @@ static int imx_get_sensor_data(struct platform_device *pdev)
 	data->c2 = n1 * data->c1 + 1000 * t1;
 
 	/* use OTP for thermal grade */
-	ret = regmap_read(map, OCOTP_MEM0, &val);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to read temp grade: %d\n", ret);
-		return ret;
+	ret = nvmem_device_read(ocotp, OCOTP_MEM0_OFFSET, sizeof(val), &val);
+	if (ret != sizeof(val)) {
+		dev_err(&pdev->dev, "failed to read sensor data: %d\n", ret);
+		ret = -EIO;
+		goto out;
 	}
 
 	/* The maximum die temp is specified by the Temperature Grade */
@@ -437,7 +449,10 @@ static int imx_get_sensor_data(struct platform_device *pdev)
 	data->temp_critical = data->temp_max - (1000 * 5);
 	data->temp_passive = data->temp_max - (1000 * 10);
 
-	return 0;
+	ret = 0;
+out:
+	nvmem_device_put(ocotp);
+	return ret;
 }
 
 static irqreturn_t imx_thermal_alarm_irq(int irq, void *dev)
@@ -513,10 +528,8 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, data);
 
 	ret = imx_get_sensor_data(pdev);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to get sensor data\n");
+	if (ret)
 		return ret;
-	}
 
 	/* Make sure sensor is in known good state for measurements */
 	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index c2256d7..3606167 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -140,6 +140,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 				     const char *name);
 struct nvmem_device *of_nvmem_device_get(struct device_node *np,
 					 const char *name);
+struct nvmem_device *of_nvmem_device_phandle_get(struct device_node *nvmem_np);
 #else
 static inline struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 				     const char *name)
@@ -152,6 +153,11 @@ static inline struct nvmem_device *of_nvmem_device_get(struct device_node *np,
 {
 	return ERR_PTR(-ENOSYS);
 }
+
+static inline struct nvmem_device *of_nvmem_device_phandle_get(struct device_node *nvmem_np)
+{
+	return ERR_PTR(-ENOSYS);
+}
 #endif /* CONFIG_NVMEM && CONFIG_OF */
 
 #endif  /* ifndef _LINUX_NVMEM_CONSUMER_H */
-- 
2.7.4
