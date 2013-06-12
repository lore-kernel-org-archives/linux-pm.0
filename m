From: kpark3469@gmail.com
Subject: [PATCH] PM / QOS: correct the valid range of pm_qos_class
Date: Wed, 12 Jun 2013 14:53:15 +0900
Message-ID: <1371016395-20688-1-git-send-email-kpark3469@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:34295 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078Ab3FLFxi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jun 2013 01:53:38 -0400
Received: by mail-qa0-f46.google.com with SMTP id ih17so109205qab.5
        for <linux-pm@vger.kernel.org>; Tue, 11 Jun 2013 22:53:37 -0700 (PDT)
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
 kernel/power/qos.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 587ddde..ec6f0a7 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -477,7 +477,7 @@ static int find_pm_qos_object_by_minor(int minor)
 {
 	int pm_qos_class;
 
-	for (pm_qos_class = 0;
+	for (pm_qos_class = 1;
 		pm_qos_class < PM_QOS_NUM_CLASSES; pm_qos_class++) {
 		if (minor ==
 			pm_qos_array[pm_qos_class]->pm_qos_power_miscdev.minor)
@@ -491,7 +491,7 @@ static int pm_qos_power_open(struct inode *inode, struct file *filp)
 	long pm_qos_class;
 
 	pm_qos_class = find_pm_qos_object_by_minor(iminor(inode));
-	if (pm_qos_class >= 0) {
+	if (pm_qos_class >= 1) {
 		struct pm_qos_request *req = kzalloc(sizeof(*req), GFP_KERNEL);
 		if (!req)
 			return -ENOMEM;
-- 
1.7.1

