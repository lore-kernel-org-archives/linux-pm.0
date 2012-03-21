From: Amit Daniel Kachhap <amit.kachhap@linaro.org>
Subject: [PATCH] thermal: Fix for setting the thermal zone mode to enable/disable
Date: Wed, 21 Mar 2012 16:40:01 +0530
Message-ID: <1332328201-21191-1-git-send-email-amit.kachhap@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, khali@linux-fr.org, linaro-dev@lists.linaro.org, amit.kachhap@linaro.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

Basically without this patch changing the mode of thermal zone
is not possible as wrong string size is passed to strncmp.

Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
---
 drivers/thermal/thermal_sys.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 220ce7e..96da1af 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -152,9 +152,9 @@ mode_store(struct device *dev, struct device_attribute *attr,
 	if (!tz->ops->set_mode)
 		return -EPERM;
 
-	if (!strncmp(buf, "enabled", sizeof("enabled")))
+	if (!strncmp(buf, "enabled", sizeof("enabled") - 1))
 		result = tz->ops->set_mode(tz, THERMAL_DEVICE_ENABLED);
-	else if (!strncmp(buf, "disabled", sizeof("disabled")))
+	else if (!strncmp(buf, "disabled", sizeof("disabled") - 1))
 		result = tz->ops->set_mode(tz, THERMAL_DEVICE_DISABLED);
 	else
 		result = -EINVAL;
-- 
1.7.1

