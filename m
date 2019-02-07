From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v1 03/24] drivers: thermal: tsens: Rename tsens_device
Date: Thu,  7 Feb 2019 16:19:21 +0530
Message-ID: <7579d56663c5309d3171130afdf3858b2aaa387c.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>, David Brown <david.brown@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Rename to tsens_priv to denote that it is private data for each tsens
instance.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-8916.c   |  2 +-
 drivers/thermal/qcom/tsens-8960.c   | 14 +++++++-------
 drivers/thermal/qcom/tsens-8974.c   |  2 +-
 drivers/thermal/qcom/tsens-common.c |  6 +++---
 drivers/thermal/qcom/tsens-v2.c     |  2 +-
 drivers/thermal/qcom/tsens.c        | 14 +++++++-------
 drivers/thermal/qcom/tsens.h        | 30 ++++++++++++++---------------
 7 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8916.c b/drivers/thermal/qcom/tsens-8916.c
index 66edcfca1526..7b8f83c9a033 100644
--- a/drivers/thermal/qcom/tsens-8916.c
+++ b/drivers/thermal/qcom/tsens-8916.c
@@ -39,7 +39,7 @@
 #define CAL_SEL_MASK	0xe0000000
 #define CAL_SEL_SHIFT	29
 
-static int calibrate_8916(struct tsens_device *tmdev)
+static int calibrate_8916(struct tsens_priv *tmdev)
 {
 	int base0 = 0, base1 = 0, i;
 	u32 p1[5], p2[5];
diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index f3c3820e6e8e..7e340eea48da 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -56,7 +56,7 @@
 #define TRDY_MASK		BIT(7)
 #define TIMEOUT_US		100
 
-static int suspend_8960(struct tsens_device *tmdev)
+static int suspend_8960(struct tsens_priv *tmdev)
 {
 	int ret;
 	unsigned int mask;
@@ -82,7 +82,7 @@ static int suspend_8960(struct tsens_device *tmdev)
 	return 0;
 }
 
-static int resume_8960(struct tsens_device *tmdev)
+static int resume_8960(struct tsens_priv *tmdev)
 {
 	int ret;
 	struct regmap *map = tmdev->tm_map;
@@ -112,7 +112,7 @@ static int resume_8960(struct tsens_device *tmdev)
 	return 0;
 }
 
-static int enable_8960(struct tsens_device *tmdev, int id)
+static int enable_8960(struct tsens_priv *tmdev, int id)
 {
 	int ret;
 	u32 reg, mask;
@@ -138,7 +138,7 @@ static int enable_8960(struct tsens_device *tmdev, int id)
 	return 0;
 }
 
-static void disable_8960(struct tsens_device *tmdev)
+static void disable_8960(struct tsens_priv *tmdev)
 {
 	int ret;
 	u32 reg_cntl;
@@ -162,7 +162,7 @@ static void disable_8960(struct tsens_device *tmdev)
 	regmap_write(tmdev->tm_map, CNTL_ADDR, reg_cntl);
 }
 
-static int init_8960(struct tsens_device *tmdev)
+static int init_8960(struct tsens_priv *tmdev)
 {
 	int ret, i;
 	u32 reg_cntl;
@@ -212,7 +212,7 @@ static int init_8960(struct tsens_device *tmdev)
 	return 0;
 }
 
-static int calibrate_8960(struct tsens_device *tmdev)
+static int calibrate_8960(struct tsens_priv *tmdev)
 {
 	int i;
 	char *data;
@@ -243,7 +243,7 @@ static inline int code_to_mdegC(u32 adc_code, const struct tsens_sensor *s)
 	return adc_code * slope + offset;
 }
 
-static int get_temp_8960(struct tsens_device *tmdev, int id, int *temp)
+static int get_temp_8960(struct tsens_priv *tmdev, int id, int *temp)
 {
 	int ret;
 	u32 code, trdy;
diff --git a/drivers/thermal/qcom/tsens-8974.c b/drivers/thermal/qcom/tsens-8974.c
index 5023f20afc14..f983f98f2176 100644
--- a/drivers/thermal/qcom/tsens-8974.c
+++ b/drivers/thermal/qcom/tsens-8974.c
@@ -91,7 +91,7 @@
 
 #define BIT_APPEND		0x3
 
-static int calibrate_8974(struct tsens_device *tmdev)
+static int calibrate_8974(struct tsens_priv *tmdev)
 {
 	int base1 = 0, base2 = 0, i;
 	u32 p1[11], p2[11];
diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 78652cac7f3d..128ee3621b41 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -46,7 +46,7 @@ char *qfprom_read(struct device *dev, const char *cname)
  * and offset values are derived from tz->tzp->slope and tz->tzp->offset
  * resp.
  */
-void compute_intercept_slope(struct tsens_device *tmdev, u32 *p1,
+void compute_intercept_slope(struct tsens_priv *tmdev, u32 *p1,
 			     u32 *p2, u32 mode)
 {
 	int i;
@@ -95,7 +95,7 @@ static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
 	return degc;
 }
 
-int get_temp_common(struct tsens_device *tmdev, int id, int *temp)
+int get_temp_common(struct tsens_priv *tmdev, int id, int *temp)
 {
 	struct tsens_sensor *s = &tmdev->sensor[id];
 	u32 code;
@@ -127,7 +127,7 @@ static const struct regmap_config tsens_srot_config = {
 	.reg_stride	= 4,
 };
 
-int __init init_common(struct tsens_device *tmdev)
+int __init init_common(struct tsens_priv *tmdev)
 {
 	void __iomem *tm_base, *srot_base;
 	struct resource *res;
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index cc98a61e093b..d812fd3f4567 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -12,7 +12,7 @@
 #define LAST_TEMP_MASK		0xfff
 #define STATUS_VALID_BIT	BIT(21)
 
-static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
+static int get_temp_tsens_v2(struct tsens_priv *tmdev, int id, int *temp)
 {
 	struct tsens_sensor *s = &tmdev->sensor[id];
 	u32 code;
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 065ec2189bd3..074fbb4d70f2 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -15,7 +15,7 @@
 static int tsens_get_temp(void *data, int *temp)
 {
 	const struct tsens_sensor *s = data;
-	struct tsens_device *tmdev = s->tmdev;
+	struct tsens_priv *tmdev = s->tmdev;
 
 	return tmdev->ops->get_temp(tmdev, s->id, temp);
 }
@@ -23,7 +23,7 @@ static int tsens_get_temp(void *data, int *temp)
 static int tsens_get_trend(void *p, int trip, enum thermal_trend *trend)
 {
 	const struct tsens_sensor *s = p;
-	struct tsens_device *tmdev = s->tmdev;
+	struct tsens_priv *tmdev = s->tmdev;
 
 	if (tmdev->ops->get_trend)
 		return  tmdev->ops->get_trend(tmdev, s->id, trend);
@@ -33,7 +33,7 @@ static int tsens_get_trend(void *p, int trip, enum thermal_trend *trend)
 
 static int  __maybe_unused tsens_suspend(struct device *dev)
 {
-	struct tsens_device *tmdev = dev_get_drvdata(dev);
+	struct tsens_priv *tmdev = dev_get_drvdata(dev);
 
 	if (tmdev->ops && tmdev->ops->suspend)
 		return tmdev->ops->suspend(tmdev);
@@ -43,7 +43,7 @@ static int  __maybe_unused tsens_suspend(struct device *dev)
 
 static int __maybe_unused tsens_resume(struct device *dev)
 {
-	struct tsens_device *tmdev = dev_get_drvdata(dev);
+	struct tsens_priv *tmdev = dev_get_drvdata(dev);
 
 	if (tmdev->ops && tmdev->ops->resume)
 		return tmdev->ops->resume(tmdev);
@@ -76,7 +76,7 @@ static const struct thermal_zone_of_device_ops tsens_of_ops = {
 	.get_trend = tsens_get_trend,
 };
 
-static int tsens_register(struct tsens_device *tmdev)
+static int tsens_register(struct tsens_priv *tmdev)
 {
 	int i;
 	struct thermal_zone_device *tzd;
@@ -101,7 +101,7 @@ static int tsens_probe(struct platform_device *pdev)
 	int ret, i;
 	struct device *dev;
 	struct device_node *np;
-	struct tsens_device *tmdev;
+	struct tsens_priv *tmdev;
 	const struct tsens_plat_data *data;
 	const struct of_device_id *id;
 	u32 num_sensors;
@@ -174,7 +174,7 @@ static int tsens_probe(struct platform_device *pdev)
 
 static int tsens_remove(struct platform_device *pdev)
 {
-	struct tsens_device *tmdev = platform_get_drvdata(pdev);
+	struct tsens_priv *tmdev = platform_get_drvdata(pdev);
 
 	if (tmdev->ops->disable)
 		tmdev->ops->disable(tmdev);
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 232376c690cc..936bdc7b1bc2 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -12,7 +12,7 @@
 
 #include <linux/thermal.h>
 
-struct tsens_device;
+struct tsens_priv;
 
 /**
  * struct tsens_sensor - data for each sensor connected to the tsens device
@@ -25,7 +25,7 @@ struct tsens_device;
  * @status: 8960-specific variable to track 8960 and 8660 status register offset
  */
 struct tsens_sensor {
-	struct tsens_device		*tmdev;
+	struct tsens_priv		*tmdev;
 	struct thermal_zone_device	*tzd;
 	int				offset;
 	int				id;
@@ -47,15 +47,15 @@ struct tsens_sensor {
  */
 struct tsens_ops {
 	/* mandatory callbacks */
-	int (*init)(struct tsens_device *);
-	int (*calibrate)(struct tsens_device *);
-	int (*get_temp)(struct tsens_device *, int, int *);
+	int (*init)(struct tsens_priv *);
+	int (*calibrate)(struct tsens_priv *);
+	int (*get_temp)(struct tsens_priv *, int, int *);
 	/* optional callbacks */
-	int (*enable)(struct tsens_device *, int);
-	void (*disable)(struct tsens_device *);
-	int (*suspend)(struct tsens_device *);
-	int (*resume)(struct tsens_device *);
-	int (*get_trend)(struct tsens_device *, int, enum thermal_trend *);
+	int (*enable)(struct tsens_priv *, int);
+	void (*disable)(struct tsens_priv *);
+	int (*suspend)(struct tsens_priv *);
+	int (*resume)(struct tsens_priv *);
+	int (*get_trend)(struct tsens_priv *, int, enum thermal_trend *);
 };
 
 enum reg_list {
@@ -87,7 +87,7 @@ struct tsens_context {
 };
 
 /**
- * struct tsens_device - private data for each instance of the tsens IP
+ * struct tsens_priv - private data for each instance of the tsens IP
  * @dev: pointer to struct device
  * @num_sensors: number of sensors enabled on this device
  * @tm_map: pointer to TM register address space
@@ -99,7 +99,7 @@ struct tsens_context {
  * @ops: pointer to list of callbacks supported by this device
  * @sensor: list of sensors attached to this device
  */
-struct tsens_device {
+struct tsens_priv {
 	struct device			*dev;
 	u32				num_sensors;
 	struct regmap			*tm_map;
@@ -112,9 +112,9 @@ struct tsens_device {
 };
 
 char *qfprom_read(struct device *, const char *);
-void compute_intercept_slope(struct tsens_device *, u32 *, u32 *, u32);
-int init_common(struct tsens_device *);
-int get_temp_common(struct tsens_device *, int, int *);
+void compute_intercept_slope(struct tsens_priv *, u32 *, u32 *, u32);
+int init_common(struct tsens_priv *);
+int get_temp_common(struct tsens_priv *, int, int *);
 
 /* TSENS v1 targets */
 extern const struct tsens_plat_data data_8916, data_8974, data_8960;
-- 
2.17.1
