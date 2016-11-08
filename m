From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 40/49] thermal: sysfs: remove symbols of emul_temp when config is disabled
Date: Mon,  7 Nov 2016 21:09:18 -0800
Message-ID: <1478581767-7009-41-git-send-email-edubezval@gmail.com>
References: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33959 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752899AbcKHFLI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Nov 2016 00:11:08 -0500
In-Reply-To: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Remove the following warning:
In file included from drivers/thermal/thermal_sysfs.c:19:0:
include/linux/device.h:575:26: warning: ‘dev_attr_emul_temp’ defined but not used [-Wunused-variable]
  struct device_attribute dev_attr_##_name = __ATTR(_name, _mode, _show, _store)
                          ^
drivers/thermal/thermal_sysfs.c:395:8: note: in expansion of macro ‘DEVICE_ATTR’

when emul temp is disabled at Kconfig.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 87d9f4d..4807015 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -292,6 +292,7 @@ available_policies_show(struct device *dev, struct device_attribute *devattr,
 	return thermal_build_list_of_policies(buf);
 }
 
+#if (IS_ENABLED(CONFIG_THERMAL_EMULATION))
 static ssize_t
 emul_temp_store(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
@@ -316,6 +317,8 @@ emul_temp_store(struct device *dev, struct device_attribute *attr,
 
 	return ret ? ret : count;
 }
+static DEVICE_ATTR(emul_temp, S_IWUSR, NULL, emul_temp_store);
+#endif
 
 static ssize_t
 sustainable_power_show(struct device *dev, struct device_attribute *devattr,
@@ -395,7 +398,6 @@ create_s32_tzp_attr(offset);
  */
 static DEVICE_ATTR(type, 0444, type_show, NULL);
 static DEVICE_ATTR(temp, 0444, temp_show, NULL);
-static DEVICE_ATTR(emul_temp, S_IWUSR, NULL, emul_temp_store);
 static DEVICE_ATTR(policy, S_IRUGO | S_IWUSR, policy_show, policy_store);
 static DEVICE_ATTR(available_policies, S_IRUGO, available_policies_show, NULL);
 static DEVICE_ATTR(sustainable_power, S_IWUSR | S_IRUGO, sustainable_power_show,
-- 
2.1.4

