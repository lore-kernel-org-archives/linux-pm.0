From: Rakib Mullick <rakib.mullick@gmail.com>
Subject: [PATCH] cpuidle: Minor optimization in cpuidle governor finding.
Date: Fri, 26 Sep 2014 23:28:20 +0600
Message-ID: <1411752500.1447.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:44199 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755042AbaIZR2l (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Sep 2014 13:28:41 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Andrew Morton <akpm@linux-foundation.org>

 Currently in __cpuidle_find_governor(), strnicmp() is used to
find which governor (menu or ladder) to register where CPUIDLE_NAME_LEN
is passed strnicmp()'s comparision max limit. But, "menu" or "ladder"
these strings are much smaller than CPUIDLE_NAME_LEN. To avoid it
this patch introduces len field on cpuidle_governor structure, which
is statically initialized to the size of length of governor name. Later
on this size has been passed as strnicmp()'s length param. Another
advantage this patch introduces, before calling strnicmp() by checking
the size of governor name length we can determine whether to call
strnicmp() i.e a shortcut.

Signed-off-by: Rakib Mullick <rakib.mullick@gmail.com>
---

diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
index ca89412..f601cc5 100644
--- a/drivers/cpuidle/governor.c
+++ b/drivers/cpuidle/governor.c
@@ -20,16 +20,21 @@ struct cpuidle_governor *cpuidle_curr_governor;
 /**
  * __cpuidle_find_governor - finds a governor of the specified name
  * @str: the name
+ * @size: length of str
  *
  * Must be called with cpuidle_lock acquired.
  */
-static struct cpuidle_governor * __cpuidle_find_governor(const char *str)
+static struct cpuidle_governor *__cpuidle_find_governor(const char *str,
+							size_t size)
 {
 	struct cpuidle_governor *gov;
 
-	list_for_each_entry(gov, &cpuidle_governors, governor_list)
-		if (!strnicmp(str, gov->name, CPUIDLE_NAME_LEN))
+	list_for_each_entry(gov, &cpuidle_governors, governor_list) {
+		if (size != gov->len)
+			continue;
+		if (!strnicmp(str, gov->name, gov->len))
 			return gov;
+	}
 
 	return NULL;
 }
@@ -85,7 +90,7 @@ int cpuidle_register_governor(struct cpuidle_governor *gov)
 		return -ENODEV;
 
 	mutex_lock(&cpuidle_lock);
-	if (__cpuidle_find_governor(gov->name) == NULL) {
+	if (__cpuidle_find_governor(gov->name, gov->len) == NULL) {
 		ret = 0;
 		list_add_tail(&gov->governor_list, &cpuidle_governors);
 		if (!cpuidle_curr_governor ||
diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
index 044ee0d..91aff9c 100644
--- a/drivers/cpuidle/governors/ladder.c
+++ b/drivers/cpuidle/governors/ladder.c
@@ -177,6 +177,7 @@ static void ladder_reflect(struct cpuidle_device *dev, int index)
 
 static struct cpuidle_governor ladder_governor = {
 	.name =		"ladder",
+	.len =		6,
 	.rating =	10,
 	.enable =	ladder_enable_device,
 	.select =	ladder_select_state,
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 34db2fb..23de182 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -477,6 +477,7 @@ static int menu_enable_device(struct cpuidle_driver *drv,
 
 static struct cpuidle_governor menu_governor = {
 	.name =		"menu",
+	.len =		4,
 	.rating =	20,
 	.enable =	menu_enable_device,
 	.select =	menu_select,
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 25e0df6..bb9b5bd 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -198,6 +198,7 @@ struct cpuidle_governor {
 	char			name[CPUIDLE_NAME_LEN];
 	struct list_head 	governor_list;
 	unsigned int		rating;
+	size_t			len;
 
 	int  (*enable)		(struct cpuidle_driver *drv,
 					struct cpuidle_device *dev);


