From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] cpuidle - sysfs : move declaration in the sysfs file
Date: Thu, 25 Oct 2012 13:46:17 +0200
Message-ID: <1351165577-32020-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35418 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754563Ab2JYLqV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Oct 2012 07:46:21 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1266419wgb.1
        for <linux-pm@vger.kernel.org>; Thu, 25 Oct 2012 04:46:20 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-dev@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org

The structure cpuidle_state_kobj is not used anywhere except
in the sysfs.c file. The definition of this structure is not
needed in the cpuidle header file. This patch moves it to the
sysfs.c file in order to encapsulate the code a bit more.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/sysfs.c |    7 +++++++
 include/linux/cpuidle.h |    7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index ed87399..f15c1e5 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -297,6 +297,13 @@ static struct attribute *cpuidle_state_default_attrs[] = {
 	NULL
 };
 
+struct cpuidle_state_kobj {
+	struct cpuidle_state *state;
+	struct cpuidle_state_usage *state_usage;
+	struct completion kobj_unregister;
+	struct kobject kobj;
+};
+
 #define kobj_to_state_obj(k) container_of(k, struct cpuidle_state_kobj, kobj)
 #define kobj_to_state(k) (kobj_to_state_obj(k)->state)
 #define kobj_to_state_usage(k) (kobj_to_state_obj(k)->state_usage)
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 279b1ea..7daf0e3 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -82,13 +82,6 @@ cpuidle_set_statedata(struct cpuidle_state_usage *st_usage, void *data)
 	st_usage->driver_data = data;
 }
 
-struct cpuidle_state_kobj {
-	struct cpuidle_state *state;
-	struct cpuidle_state_usage *state_usage;
-	struct completion kobj_unregister;
-	struct kobject kobj;
-};
-
 struct cpuidle_device {
 	unsigned int		registered:1;
 	unsigned int		enabled:1;
-- 
1.7.5.4

