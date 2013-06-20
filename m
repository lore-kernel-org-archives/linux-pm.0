From: kpark3469@gmail.com
Subject: [PATCH v2] PM / QOS: correct the valid range of pm_qos_class
Date: Thu, 20 Jun 2013 11:33:57 +0900
Message-ID: <1371695637-5118-1-git-send-email-kpark3469@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:35605 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935506Ab3FTCeP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2013 22:34:15 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so15126874ieb.38
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2013 19:34:14 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: keun-o.park@windriver.com, len.brown@intel.com, rjw@sisk.pl

From: Sahara <keun-o.park@windriver.com>

The valid start index for pm_qos_array is not 0 but 1. There is a
null_pm_qos at index 0 of pm_qos_array. However, null_pm_qos is not
created as misc device so that inclusion of 0 index for checking
pm_qos_class especially for file operations is not proper here.

Signed-off-by: Sahara <keun-o.park@windriver.com>
---
 kernel/power/qos.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 587ddde..f2f5f6e 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -477,7 +477,7 @@ static int find_pm_qos_object_by_minor(int minor)
 {
 	int pm_qos_class;
 
-	for (pm_qos_class = 0;
+	for (pm_qos_class = PM_QOS_CPU_DMA_LATENCY;
 		pm_qos_class < PM_QOS_NUM_CLASSES; pm_qos_class++) {
 		if (minor ==
 			pm_qos_array[pm_qos_class]->pm_qos_power_miscdev.minor)
@@ -491,7 +491,7 @@ static int pm_qos_power_open(struct inode *inode, struct file *filp)
 	long pm_qos_class;
 
 	pm_qos_class = find_pm_qos_object_by_minor(iminor(inode));
-	if (pm_qos_class >= 0) {
+	if (pm_qos_class >= PM_QOS_CPU_DMA_LATENCY) {
 		struct pm_qos_request *req = kzalloc(sizeof(*req), GFP_KERNEL);
 		if (!req)
 			return -ENOMEM;
@@ -584,7 +584,7 @@ static int __init pm_qos_power_init(void)
 
 	BUILD_BUG_ON(ARRAY_SIZE(pm_qos_array) != PM_QOS_NUM_CLASSES);
 
-	for (i = 1; i < PM_QOS_NUM_CLASSES; i++) {
+	for (i = PM_QOS_CPU_DMA_LATENCY; i < PM_QOS_NUM_CLASSES; i++) {
 		ret = register_pm_qos_misc(pm_qos_array[i]);
 		if (ret < 0) {
 			printk(KERN_ERR "pm_qos_param: %s setup failed\n",
-- 
1.7.1

