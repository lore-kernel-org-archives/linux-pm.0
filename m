From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] PM / QoS: constify *_attribute_group.
Date: Thu, 22 Jun 2017 16:23:32 +0530
Message-ID: <572276af30704b5b79cca4e4864a2c3303e4ab4e.1498128683.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

File size before:
   text	   data	    bss	    dec	    hex	filename
   3890	   1152	      8	   5050	   13ba	drivers/base/power/sysfs.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   4250	    800	      8	   5058	   13c2	drivers/base/power/sysfs.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/base/power/sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 33b4b90..185a525 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -607,7 +607,7 @@ static ssize_t async_store(struct device *dev, struct device_attribute *attr,
 #endif /* CONFIG_PM_ADVANCED_DEBUG */
 	NULL,
 };
-static struct attribute_group pm_attr_group = {
+static const struct attribute_group pm_attr_group = {
 	.name	= power_group_name,
 	.attrs	= power_attrs,
 };
@@ -629,7 +629,7 @@ static ssize_t async_store(struct device *dev, struct device_attribute *attr,
 #endif
 	NULL,
 };
-static struct attribute_group pm_wakeup_attr_group = {
+static const struct attribute_group pm_wakeup_attr_group = {
 	.name	= power_group_name,
 	.attrs	= wakeup_attrs,
 };
@@ -644,7 +644,7 @@ static ssize_t async_store(struct device *dev, struct device_attribute *attr,
 	&dev_attr_autosuspend_delay_ms.attr,
 	NULL,
 };
-static struct attribute_group pm_runtime_attr_group = {
+static const struct attribute_group pm_runtime_attr_group = {
 	.name	= power_group_name,
 	.attrs	= runtime_attrs,
 };
@@ -653,7 +653,7 @@ static ssize_t async_store(struct device *dev, struct device_attribute *attr,
 	&dev_attr_pm_qos_resume_latency_us.attr,
 	NULL,
 };
-static struct attribute_group pm_qos_resume_latency_attr_group = {
+static const struct attribute_group pm_qos_resume_latency_attr_group = {
 	.name	= power_group_name,
 	.attrs	= pm_qos_resume_latency_attrs,
 };
@@ -662,7 +662,7 @@ static ssize_t async_store(struct device *dev, struct device_attribute *attr,
 	&dev_attr_pm_qos_latency_tolerance_us.attr,
 	NULL,
 };
-static struct attribute_group pm_qos_latency_tolerance_attr_group = {
+static const struct attribute_group pm_qos_latency_tolerance_attr_group = {
 	.name	= power_group_name,
 	.attrs	= pm_qos_latency_tolerance_attrs,
 };
@@ -672,7 +672,7 @@ static ssize_t async_store(struct device *dev, struct device_attribute *attr,
 	&dev_attr_pm_qos_remote_wakeup.attr,
 	NULL,
 };
-static struct attribute_group pm_qos_flags_attr_group = {
+static const struct attribute_group pm_qos_flags_attr_group = {
 	.name	= power_group_name,
 	.attrs	= pm_qos_flags_attrs,
 };
-- 
1.9.1
