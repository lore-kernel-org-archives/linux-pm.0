From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 3/8] cpuidle: Fix indentation and conform to Coding Style
Date: Wed, 12 Jun 2013 15:08:50 +0200
Message-ID: <1371042535-22630-3-git-send-email-daniel.lezcano@linaro.org>
References: <1371042535-22630-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:62774 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284Ab3FLNI7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jun 2013 09:08:59 -0400
Received: by mail-we0-f171.google.com with SMTP id m46so6973242wev.30
        for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2013 06:08:57 -0700 (PDT)
In-Reply-To: <1371042535-22630-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org

This mindless patch does just fix the code to have 80 columns and the pointer
variable format in the parameter functions / declarations to conform the Coding
Style.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/sysfs.c |   38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index 428754a..7d4448a 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -33,7 +33,8 @@ static ssize_t show_available_governors(struct device *dev,
 
 	mutex_lock(&cpuidle_lock);
 	list_for_each_entry(tmp, &cpuidle_governors, governor_list) {
-		if (i >= (ssize_t) ((PAGE_SIZE/sizeof(char)) - CPUIDLE_NAME_LEN - 2))
+		if (i >= (ssize_t) ((PAGE_SIZE/sizeof(char)) -
+				    CPUIDLE_NAME_LEN - 2))
 			goto out;
 		i += scnprintf(&buf[i], CPUIDLE_NAME_LEN, "%s ", tmp->name);
 	}
@@ -168,11 +169,13 @@ struct cpuidle_attr {
 
 #define kobj_to_cpuidledev(k) container_of(k, struct cpuidle_device, kobj)
 #define attr_to_cpuidleattr(a) container_of(a, struct cpuidle_attr, attr)
-static ssize_t cpuidle_show(struct kobject * kobj, struct attribute * attr ,char * buf)
+
+static ssize_t cpuidle_show(struct kobject *kobj, struct attribute *attr,
+			    char *buf)
 {
 	int ret = -EIO;
 	struct cpuidle_device *dev = kobj_to_cpuidledev(kobj);
-	struct cpuidle_attr * cattr = attr_to_cpuidleattr(attr);
+	struct cpuidle_attr *cattr = attr_to_cpuidleattr(attr);
 
 	if (cattr->show) {
 		mutex_lock(&cpuidle_lock);
@@ -182,12 +185,12 @@ static ssize_t cpuidle_show(struct kobject * kobj, struct attribute * attr ,char
 	return ret;
 }
 
-static ssize_t cpuidle_store(struct kobject * kobj, struct attribute * attr,
-		     const char * buf, size_t count)
+static ssize_t cpuidle_store(struct kobject *kobj, struct attribute *attr,
+			     const char *buf, size_t count)
 {
 	int ret = -EIO;
 	struct cpuidle_device *dev = kobj_to_cpuidledev(kobj);
-	struct cpuidle_attr * cattr = attr_to_cpuidleattr(attr);
+	struct cpuidle_attr *cattr = attr_to_cpuidleattr(attr);
 
 	if (cattr->store) {
 		mutex_lock(&cpuidle_lock);
@@ -237,8 +240,8 @@ static ssize_t show_state_##_name(struct cpuidle_state *state, \
 
 #define define_store_state_ull_function(_name) \
 static ssize_t store_state_##_name(struct cpuidle_state *state, \
-		struct cpuidle_state_usage *state_usage, \
-		const char *buf, size_t size) \
+				   struct cpuidle_state_usage *state_usage, \
+				   const char *buf, size_t size)	\
 { \
 	unsigned long long value; \
 	int err; \
@@ -256,14 +259,16 @@ static ssize_t store_state_##_name(struct cpuidle_state *state, \
 
 #define define_show_state_ull_function(_name) \
 static ssize_t show_state_##_name(struct cpuidle_state *state, \
-			struct cpuidle_state_usage *state_usage, char *buf) \
+				  struct cpuidle_state_usage *state_usage, \
+				  char *buf)				\
 { \
 	return sprintf(buf, "%llu\n", state_usage->_name);\
 }
 
 #define define_show_state_str_function(_name) \
 static ssize_t show_state_##_name(struct cpuidle_state *state, \
-			struct cpuidle_state_usage *state_usage, char *buf) \
+				  struct cpuidle_state_usage *state_usage, \
+				  char *buf)				\
 { \
 	if (state->_name[0] == '\0')\
 		return sprintf(buf, "<null>\n");\
@@ -309,8 +314,9 @@ struct cpuidle_state_kobj {
 #define kobj_to_state(k) (kobj_to_state_obj(k)->state)
 #define kobj_to_state_usage(k) (kobj_to_state_obj(k)->state_usage)
 #define attr_to_stateattr(a) container_of(a, struct cpuidle_state_attr, attr)
-static ssize_t cpuidle_state_show(struct kobject * kobj,
-	struct attribute * attr ,char * buf)
+
+static ssize_t cpuidle_state_show(struct kobject *kobj, struct attribute *attr,
+				  char * buf)
 {
 	int ret = -EIO;
 	struct cpuidle_state *state = kobj_to_state(kobj);
@@ -323,8 +329,8 @@ static ssize_t cpuidle_state_show(struct kobject * kobj,
 	return ret;
 }
 
-static ssize_t cpuidle_state_store(struct kobject *kobj,
-	struct attribute *attr, const char *buf, size_t size)
+static ssize_t cpuidle_state_store(struct kobject *kobj, struct attribute *attr,
+				   const char *buf, size_t size)
 {
 	int ret = -EIO;
 	struct cpuidle_state *state = kobj_to_state(kobj);
@@ -449,8 +455,8 @@ static void cpuidle_driver_sysfs_release(struct kobject *kobj)
 	complete(&driver_kobj->kobj_unregister);
 }
 
-static ssize_t cpuidle_driver_show(struct kobject *kobj, struct attribute * attr,
-				   char * buf)
+static ssize_t cpuidle_driver_show(struct kobject *kobj, struct attribute *attr,
+				   char *buf)
 {
 	int ret = -EIO;
 	struct cpuidle_driver_kobj *driver_kobj = kobj_to_driver_kobj(kobj);
-- 
1.7.9.5

