From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 1/2] firmware: arm_scpi: add support to populate OPPs and get transition latency
Date: Fri, 28 Apr 2017 10:21:35 +0100
Message-ID: <1493371296-12465-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755113AbdD1JVv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Apr 2017 05:21:51 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>

Currently only CPU devices use the transition latency and the OPPs
populated in the SCPI driver. scpi-cpufreq has logic to handle these.
However, even GPU and other users of SCPI DVFS will need the same logic.

In order to avoid duplication, this patch adds support to get DVFS
transition latency and add all the OPPs to the device using OPP library
helper functions. The helper functions added here can be used for any
device whose DVFS are managed by SCPI.

Also, we also have incorrect dependency on the cluster identifier for
the CPUs. It's fundamentally wrong as the domain id need not match the
cluster id. This patch gets rid of that dependency by making use of the
clock bindings which are already in place.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scpi.c   | 62 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/scpi_protocol.h |  2 ++
 2 files changed, 64 insertions(+)

Hi,

It would be good to have this tested on AmLogic platforms that use
SCPI.

Regards,
Sudeep

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 9ad0b1934be9..3677d13cdcac 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -39,6 +39,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/printk.h>
+#include <linux/pm_opp.h>
 #include <linux/scpi_protocol.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
@@ -684,6 +685,65 @@ static struct scpi_dvfs_info *scpi_dvfs_get_info(u8 domain)
 	return info;
 }
 
+static int scpi_dev_domain_id(struct device *dev)
+{
+	struct of_phandle_args clkspec;
+
+	if (of_parse_phandle_with_args(dev->of_node, "clocks", "#clock-cells",
+				       0, &clkspec))
+		return -EINVAL;
+
+	return clkspec.args[0];
+}
+
+static struct scpi_dvfs_info *scpi_dvfs_info(struct device *dev)
+{
+	int domain = scpi_dev_domain_id(dev);
+
+	if (domain < 0)
+		return ERR_PTR(domain);
+
+	return scpi_dvfs_get_info(domain);
+}
+
+static int scpi_dvfs_get_transition_latency(struct device *dev)
+{
+	struct scpi_dvfs_info *info = scpi_dvfs_info(dev);
+
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	if (!info->latency)
+		return 0;
+
+	return info->latency;
+}
+
+static int scpi_dvfs_add_opps_to_device(struct device *dev)
+{
+	int idx, ret;
+	struct scpi_opp *opp;
+	struct scpi_dvfs_info *info = scpi_dvfs_info(dev);
+
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	if (!info->opps)
+		return -EIO;
+
+	for (opp = info->opps, idx = 0; idx < info->count; idx++, opp++) {
+		ret = dev_pm_opp_add(dev, opp->freq, opp->m_volt * 1000);
+		if (ret) {
+			dev_warn(dev, "failed to add opp %uHz %umV\n",
+				 opp->freq, opp->m_volt);
+			while (idx-- > 0)
+				dev_pm_opp_remove(dev, (--opp)->freq);
+			return ret;
+		}
+	}
+	return 0;
+}
+
 static int scpi_sensor_get_capability(u16 *sensors)
 {
 	struct sensor_capabilities cap_buf;
@@ -765,6 +825,8 @@ static struct scpi_ops scpi_ops = {
 	.dvfs_get_idx = scpi_dvfs_get_idx,
 	.dvfs_set_idx = scpi_dvfs_set_idx,
 	.dvfs_get_info = scpi_dvfs_get_info,
+	.get_transition_latency = scpi_dvfs_get_transition_latency,
+	.add_opps_to_device = scpi_dvfs_add_opps_to_device,
 	.sensor_get_capability = scpi_sensor_get_capability,
 	.sensor_get_info = scpi_sensor_get_info,
 	.sensor_get_value = scpi_sensor_get_value,
diff --git a/include/linux/scpi_protocol.h b/include/linux/scpi_protocol.h
index dc5f989be226..7043f2259604 100644
--- a/include/linux/scpi_protocol.h
+++ b/include/linux/scpi_protocol.h
@@ -67,6 +67,8 @@ struct scpi_ops {
 	int (*dvfs_get_idx)(u8);
 	int (*dvfs_set_idx)(u8, u8);
 	struct scpi_dvfs_info *(*dvfs_get_info)(u8);
+	int (*get_transition_latency)(struct device *);
+	int (*add_opps_to_device)(struct device *);
 	int (*sensor_get_capability)(u16 *sensors);
 	int (*sensor_get_info)(u16 sensor_id, struct scpi_sensor_info *);
 	int (*sensor_get_value)(u16, u64 *);
-- 
2.7.4
