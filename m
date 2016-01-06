From: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 3/4] thermal: add sys node for k_pu_ratio/k_po_ratio
Date: Wed,  6 Jan 2016 16:53:47 +0800
Message-ID: <1452070428-2567-4-git-send-email-leo.yan@linaro.org>
References: <1452070428-2567-1-git-send-email-leo.yan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452070428-2567-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@arm.com>, Punit Agrawal <punit.agrawal@arm.com>, Daniel Kurtz <djkurtz@chromium.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
List-Id: linux-pm@vger.kernel.org

Add two sys nodes for k_pu_ratio and k_po_ratio, so user can set ratio
value from them. Also change k_pu/k_po as read only nodes, it will only
be used to show proportional term constants which are calculated by
ratio.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/thermal/thermal_core.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d9e525c..bc149a67 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -955,8 +955,25 @@ static DEVICE_ATTR(sustainable_power, S_IWUSR | S_IRUGO, sustainable_power_show,
 	}								\
 	static DEVICE_ATTR(name, S_IWUSR | S_IRUGO, name##_show, name##_store)
 
-create_s32_tzp_attr(k_po);
-create_s32_tzp_attr(k_pu);
+
+#define create_s32_tzp_attr_ro(name)					\
+	static ssize_t							\
+	name##_show(struct device *dev, struct device_attribute *devattr, \
+		char *buf)						\
+	{								\
+	struct thermal_zone_device *tz = to_thermal_zone(dev);		\
+									\
+	if (tz->tzp)							\
+		return sprintf(buf, "%u\n", tz->tzp->name);		\
+	else								\
+		return -EIO;						\
+	}								\
+	static DEVICE_ATTR(name, S_IRUGO, name##_show, NULL)
+
+create_s32_tzp_attr_ro(k_po);
+create_s32_tzp_attr_ro(k_pu);
+create_s32_tzp_attr(k_po_ratio);
+create_s32_tzp_attr(k_pu_ratio);
 create_s32_tzp_attr(k_i);
 create_s32_tzp_attr(k_d);
 create_s32_tzp_attr(integral_cutoff);
@@ -968,6 +985,8 @@ static struct device_attribute *dev_tzp_attrs[] = {
 	&dev_attr_sustainable_power,
 	&dev_attr_k_po,
 	&dev_attr_k_pu,
+	&dev_attr_k_po_ratio,
+	&dev_attr_k_pu_ratio,
 	&dev_attr_k_i,
 	&dev_attr_k_d,
 	&dev_attr_integral_cutoff,
-- 
1.9.1
