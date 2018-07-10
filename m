From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 1/2] thermal_hwmon: Sanitize attribute name passed to hwmon
Date: Tue, 10 Jul 2018 16:40:34 +0100
Message-ID: <20180710154035.26828-2-marc.zyngier@arm.com>
References: <20180710154035.26828-1-marc.zyngier@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180710154035.26828-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

My Chromebook Plus (kevin) is spitting the following at boot time:

(NULL device *): hwmon: 'sbs-9-000b' is not a valid name attribute, please fix

Clearly, __hwmon_device_register is unhappy about the property name.
Some investigation reveals that thermal_add_hwmon_sysfs doesn't
sanitize the name of the attribute.

In order to keep it quiet, let's replace '-' with '_' in hwmon->type
This is consistent with what iio-hwmon does since b92fe9e3379c8.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/thermal/thermal_hwmon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index 11278836ed12..0bd47007c57f 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -142,6 +142,7 @@ int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 
 	INIT_LIST_HEAD(&hwmon->tz_list);
 	strlcpy(hwmon->type, tz->type, THERMAL_NAME_LENGTH);
+	strreplace(hwmon->type, '-', '_');
 	hwmon->device = hwmon_device_register_with_info(NULL, hwmon->type,
 							hwmon, NULL, NULL);
 	if (IS_ERR(hwmon->device)) {
-- 
2.18.0
