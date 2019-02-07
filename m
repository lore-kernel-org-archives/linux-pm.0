From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v1 01/24] drivers: thermal: tsens: Document the data structures
Date: Thu,  7 Feb 2019 16:19:19 +0530
Message-ID: <ab0571b9d3059342361522b8ae0df69990385547.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>, David Brown <david.brown@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Describe how the TSENS device and the various sensors connected to it
are described in the driver

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens.h | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 7b7feee5dc46..89318523c848 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -14,6 +14,16 @@
 
 struct tsens_device;
 
+/**
+ * struct tsens_sensor - data for each sensor connected to the tsens device
+ * @tmdev: tsens device instance that this sensor is connected to
+ * @tzd: pointer to the thermal zone that this sensor is in
+ * @offset: offset of temperature adjustment curve
+ * @id: Sensor ID
+ * @hw_id: HW ID can be used in case of platform-specific IDs
+ * @slope: slope of temperature adjustment curve
+ * @status: 8960-specific variable to track 8960 and 8660 status register offset
+ */
 struct tsens_sensor {
 	struct tsens_device		*tmdev;
 	struct thermal_zone_device	*tzd;
@@ -55,8 +65,8 @@ enum reg_list {
 };
 
 /**
- * struct tsens_data - tsens instance specific data
- * @num_sensors: Max number of sensors supported by platform
+ * struct tsens_data - tsens platform data
+ * @num_sensors: Number of sensors supported by platform
  * @ops: operations the tsens instance supports
  * @hw_ids: Subset of sensors ids supported by platform, if not the first n
  * @reg_offsets: Register offsets for commonly used registers
@@ -68,12 +78,27 @@ struct tsens_data {
 	unsigned int		*hw_ids;
 };
 
-/* Registers to be saved/restored across a context loss */
+/**
+ * struct tsens_context - Registers to be saved/restored across a context loss
+ */
 struct tsens_context {
 	int	threshold;
 	int	control;
 };
 
+/**
+ * struct tsens_device - private data for each instance of the tsens IP
+ * @dev: pointer to struct device
+ * @num_sensors: number of sensors enabled on this device
+ * @tm_map: pointer to TM register address space
+ * @srot_map: pointer to SROT register address space
+ * @tm_offset: deal with old device trees that don't address TM and SROT
+ *             address space separately
+ * @reg_offsets: array of offsets to important regs for this version of IP
+ * @ctx: registers to be saved and restored during suspend/resume
+ * @ops: pointer to list of callbacks supported by this device
+ * @sensor: list of sensors attached to this device
+ */
 struct tsens_device {
 	struct device			*dev;
 	u32				num_sensors;
-- 
2.17.1
