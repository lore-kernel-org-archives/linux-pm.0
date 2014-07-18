From: dirk.brandewie@gmail.com
Subject: [PATCH 01/11] cpufreq: intel_pstate: Make intel_pstate_kobject and debugfs_parent locals
Date: Fri, 18 Jul 2014 08:37:17 -0700
Message-ID: <1405697848-13546-2-git-send-email-dirk.j.brandewie@intel.com>
References: <1405697848-13546-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:61184 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422654AbaGRPhk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jul 2014 11:37:40 -0400
Received: by mail-pa0-f50.google.com with SMTP id et14so5691122pad.9
        for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2014 08:37:40 -0700 (PDT)
In-Reply-To: <1405697848-13546-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, Stratos Karafotis <stratosk@semaphore.gr>, Dirk Brandewie <dirk.j.brandewie@intel.com>

From: Stratos Karafotis <stratosk@semaphore.gr>

Since we never remove sysfs entry and debugfs files, we can make
the intel_pstate_kobject and debugfs_parent locals.

Also, annotate with __init intel_pstate_sysfs_expose_params()
and intel_pstate_debug_expose_params() in order to be freed
after bootstrap.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 86631cb..601c428 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -253,9 +253,9 @@ static struct pid_param pid_files[] = {
 	{NULL, NULL}
 };
 
-static struct dentry *debugfs_parent;
-static void intel_pstate_debug_expose_params(void)
+static void __init intel_pstate_debug_expose_params(void)
 {
+	struct dentry *debugfs_parent;
 	int i = 0;
 
 	debugfs_parent = debugfs_create_dir("pstate_snb", NULL);
@@ -342,10 +342,10 @@ static struct attribute *intel_pstate_attributes[] = {
 static struct attribute_group intel_pstate_attr_group = {
 	.attrs = intel_pstate_attributes,
 };
-static struct kobject *intel_pstate_kobject;
 
-static void intel_pstate_sysfs_expose_params(void)
+static void __init intel_pstate_sysfs_expose_params(void)
 {
+	struct kobject *intel_pstate_kobject;
 	int rc;
 
 	intel_pstate_kobject = kobject_create_and_add("intel_pstate",
-- 
1.9.3

