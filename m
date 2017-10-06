From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / ACPI: Removed unused function
Date: Fri,  6 Oct 2017 09:08:34 +0200
Message-ID: <1507273714-26394-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

acpi_dev_pm_get_node() isn't used or implemented, let's remove it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/acpi.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 502af53..3b89b4f 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -868,17 +868,12 @@ int acpi_dev_runtime_suspend(struct device *dev);
 int acpi_dev_runtime_resume(struct device *dev);
 int acpi_subsys_runtime_suspend(struct device *dev);
 int acpi_subsys_runtime_resume(struct device *dev);
-struct acpi_device *acpi_dev_pm_get_node(struct device *dev);
 int acpi_dev_pm_attach(struct device *dev, bool power_on);
 #else
 static inline int acpi_dev_runtime_suspend(struct device *dev) { return 0; }
 static inline int acpi_dev_runtime_resume(struct device *dev) { return 0; }
 static inline int acpi_subsys_runtime_suspend(struct device *dev) { return 0; }
 static inline int acpi_subsys_runtime_resume(struct device *dev) { return 0; }
-static inline struct acpi_device *acpi_dev_pm_get_node(struct device *dev)
-{
-	return NULL;
-}
 static inline int acpi_dev_pm_attach(struct device *dev, bool power_on)
 {
 	return -ENODEV;
-- 
2.7.4

