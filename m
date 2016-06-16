From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v2 1/3] firmware: arm_scpi: add support for device power state management
Date: Thu, 16 Jun 2016 11:37:59 +0100
Message-ID: <1466073481-697-2-git-send-email-sudeep.holla@arm.com>
References: <1466073481-697-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466073481-697-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jon Medhurst <tixy@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>
List-Id: linux-pm@vger.kernel.org

SCPI protocol supports device power state management. This deals with
power states of various peripheral devices in the system other than the
core compute subsystem.

This patch adds support for the power state management of those
peripheral devices.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scpi.c   | 30 ++++++++++++++++++++++++++++++
 include/linux/scpi_protocol.h |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 51c6db0774cc..438893762076 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -231,6 +231,11 @@ struct sensor_value {
 	__le32 hi_val;
 } __packed;

+struct dev_pstate_set {
+	u16 dev_id;
+	u8 pstate;
+} __packed;
+
 static struct scpi_drvinfo *scpi_info;

 static int scpi_linux_errmap[SCPI_ERR_MAX] = {
@@ -537,6 +542,29 @@ static int scpi_sensor_get_value(u16 sensor, u64 *val)
 	return ret;
 }

+static int scpi_device_get_power_state(u16 dev_id)
+{
+	int ret;
+	u8 pstate;
+	__le16 id = cpu_to_le16(dev_id);
+
+	ret = scpi_send_message(SCPI_CMD_GET_DEVICE_PWR_STATE, &id,
+				sizeof(id), &pstate, sizeof(pstate));
+	return ret ? ret : pstate;
+}
+
+static int scpi_device_set_power_state(u16 dev_id, u8 pstate)
+{
+	int stat;
+	struct dev_pstate_set dev_set = {
+		.dev_id = cpu_to_le16(dev_id),
+		.pstate = pstate,
+	};
+
+	return scpi_send_message(SCPI_CMD_SET_DEVICE_PWR_STATE, &dev_set,
+				 sizeof(dev_set), &stat, sizeof(stat));
+}
+
 static struct scpi_ops scpi_ops = {
 	.get_version = scpi_get_version,
 	.clk_get_range = scpi_clk_get_range,
@@ -548,6 +576,8 @@ static struct scpi_ops scpi_ops = {
 	.sensor_get_capability = scpi_sensor_get_capability,
 	.sensor_get_info = scpi_sensor_get_info,
 	.sensor_get_value = scpi_sensor_get_value,
+	.device_get_power_state = scpi_device_get_power_state,
+	.device_set_power_state = scpi_device_set_power_state,
 };

 struct scpi_ops *get_scpi_ops(void)
diff --git a/include/linux/scpi_protocol.h b/include/linux/scpi_protocol.h
index 35de50a65665..dc5f989be226 100644
--- a/include/linux/scpi_protocol.h
+++ b/include/linux/scpi_protocol.h
@@ -70,6 +70,8 @@ struct scpi_ops {
 	int (*sensor_get_capability)(u16 *sensors);
 	int (*sensor_get_info)(u16 sensor_id, struct scpi_sensor_info *);
 	int (*sensor_get_value)(u16, u64 *);
+	int (*device_get_power_state)(u16);
+	int (*device_set_power_state)(u16, u8);
 };

 #if IS_REACHABLE(CONFIG_ARM_SCPI_PROTOCOL)
--
2.7.4
