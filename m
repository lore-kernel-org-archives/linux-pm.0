From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 1/1] drivers: thermal: st: remove several sparse warnings
Date: Tue,  7 Apr 2015 13:46:15 -0700
Message-ID: <1428439575-1014-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36403 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418AbbDGUqI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Apr 2015 16:46:08 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Lee Jones <lee.jones@linaro.org>, Pavel Machek <pavel@ucw.cz>, Ajit Pal Singh <ajitpal.singh@st.com>, linux-kernel@vger.kernel.org

Simple patch to make symbols static. Symbols that are not
shared with other parts of the kernel can be made static.
This change also removes several sparse complains.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Ajit Pal Singh <ajitpal.singh@st.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/st/st_thermal.c        |  2 +-
 drivers/thermal/st/st_thermal_memmap.c |  8 ++++----
 drivers/thermal/st/st_thermal_syscfg.c | 12 ++++++------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_thermal.c
index d1ec580..76c515d 100644
--- a/drivers/thermal/st/st_thermal.c
+++ b/drivers/thermal/st/st_thermal.c
@@ -25,7 +25,7 @@
  * Function to allocate regfields which are common
  * between syscfg and memory mapped based sensors
  */
-int st_thermal_alloc_regfields(struct st_thermal_sensor *sensor)
+static int st_thermal_alloc_regfields(struct st_thermal_sensor *sensor)
 {
 	struct device *dev = sensor->dev;
 	struct regmap *regmap = sensor->regmap;
diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/st_thermal_memmap.c
index bd22339..fc0c9e1 100644
--- a/drivers/thermal/st/st_thermal_memmap.c
+++ b/drivers/thermal/st/st_thermal_memmap.c
@@ -157,7 +157,7 @@ static const struct st_thermal_sensor_ops st_mmap_sensor_ops = {
 };
 
 /* Compatible device data stih416 mpe thermal sensor */
-const struct st_thermal_compat_data st_416mpe_cdata = {
+static const struct st_thermal_compat_data st_416mpe_cdata = {
 	.reg_fields		= st_mmap_thermal_regfields,
 	.ops			= &st_mmap_sensor_ops,
 	.calibration_val	= 14,
@@ -166,7 +166,7 @@ const struct st_thermal_compat_data st_416mpe_cdata = {
 };
 
 /* Compatible device data stih407 thermal sensor */
-const struct st_thermal_compat_data st_407_cdata = {
+static const struct st_thermal_compat_data st_407_cdata = {
 	.reg_fields		= st_mmap_thermal_regfields,
 	.ops			= &st_mmap_sensor_ops,
 	.calibration_val	= 16,
@@ -181,12 +181,12 @@ static const struct of_device_id st_mmap_thermal_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, st_mmap_thermal_of_match);
 
-int st_mmap_probe(struct platform_device *pdev)
+static int st_mmap_probe(struct platform_device *pdev)
 {
 	return st_thermal_register(pdev,  st_mmap_thermal_of_match);
 }
 
-int st_mmap_remove(struct platform_device *pdev)
+static int st_mmap_remove(struct platform_device *pdev)
 {
 	return st_thermal_unregister(pdev);
 }
diff --git a/drivers/thermal/st/st_thermal_syscfg.c b/drivers/thermal/st/st_thermal_syscfg.c
index 65eab72..3df5b789 100644
--- a/drivers/thermal/st/st_thermal_syscfg.c
+++ b/drivers/thermal/st/st_thermal_syscfg.c
@@ -104,7 +104,7 @@ static const struct st_thermal_sensor_ops st_syscfg_sensor_ops = {
 };
 
 /* Compatible device data for stih415 sas thermal sensor */
-const struct st_thermal_compat_data st_415sas_cdata = {
+static const struct st_thermal_compat_data st_415sas_cdata = {
 	.sys_compat		= "st,stih415-front-syscfg",
 	.reg_fields		= st_415sas_regfields,
 	.ops			= &st_syscfg_sensor_ops,
@@ -114,7 +114,7 @@ const struct st_thermal_compat_data st_415sas_cdata = {
 };
 
 /* Compatible device data for stih415 mpe thermal sensor */
-const struct st_thermal_compat_data st_415mpe_cdata = {
+static const struct st_thermal_compat_data st_415mpe_cdata = {
 	.sys_compat		= "st,stih415-system-syscfg",
 	.reg_fields		= st_415mpe_regfields,
 	.ops			= &st_syscfg_sensor_ops,
@@ -124,7 +124,7 @@ const struct st_thermal_compat_data st_415mpe_cdata = {
 };
 
 /* Compatible device data for stih416 sas thermal sensor */
-const struct st_thermal_compat_data st_416sas_cdata = {
+static const struct st_thermal_compat_data st_416sas_cdata = {
 	.sys_compat		= "st,stih416-front-syscfg",
 	.reg_fields		= st_416sas_regfields,
 	.ops			= &st_syscfg_sensor_ops,
@@ -134,7 +134,7 @@ const struct st_thermal_compat_data st_416sas_cdata = {
 };
 
 /* Compatible device data for stid127 thermal sensor */
-const struct st_thermal_compat_data st_127_cdata = {
+static const struct st_thermal_compat_data st_127_cdata = {
 	.sys_compat		= "st,stid127-cpu-syscfg",
 	.reg_fields		= st_127_regfields,
 	.ops			= &st_syscfg_sensor_ops,
@@ -152,12 +152,12 @@ static const struct of_device_id st_syscfg_thermal_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, st_syscfg_thermal_of_match);
 
-int st_syscfg_probe(struct platform_device *pdev)
+static int st_syscfg_probe(struct platform_device *pdev)
 {
 	return st_thermal_register(pdev, st_syscfg_thermal_of_match);
 }
 
-int st_syscfg_remove(struct platform_device *pdev)
+static int st_syscfg_remove(struct platform_device *pdev)
 {
 	return st_thermal_unregister(pdev);
 }
-- 
2.3.4

