From: Markus Mayer <mmayer@broadcom.com>
Subject: [PATCH v4 7/7] power_supply: make use of new strcpytoupper() function
Date: Fri, 22 Jul 2016 16:31:09 -0700
Message-ID: <1469230269-1644-8-git-send-email-mmayer@broadcom.com>
References: <1469230269-1644-1-git-send-email-mmayer@broadcom.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:32889 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131AbcGVXdj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jul 2016 19:33:39 -0400
Received: by mail-qk0-f169.google.com with SMTP id p74so114504478qka.0
        for <linux-pm@vger.kernel.org>; Fri, 22 Jul 2016 16:33:39 -0700 (PDT)
In-Reply-To: <1469230269-1644-1-git-send-email-mmayer@broadcom.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Markus Mayer <mmayer@broadcom.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Call strcpytoupper() rather than walking the string explicitly to
convert it to uppercase.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/power/power_supply_sysfs.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/power/power_supply_sysfs.c b/drivers/power/power_supply_sysfs.c
index 80fed98..20fdcc5 100644
--- a/drivers/power/power_supply_sysfs.c
+++ b/drivers/power/power_supply_sysfs.c
@@ -256,19 +256,16 @@ void power_supply_init_attrs(struct device_type *dev_type)
 
 static char *kstruprdup(const char *str, gfp_t gfp)
 {
-	char *ret, *ustr;
+	char *ustr;
 
-	ustr = ret = kmalloc(strlen(str) + 1, gfp);
+	ustr = kmalloc(strlen(str) + 1, gfp);
 
-	if (!ret)
+	if (!ustr)
 		return NULL;
 
-	while (*str)
-		*ustr++ = toupper(*str++);
+	strcpytoupper(ustr, str);
 
-	*ustr = 0;
-
-	return ret;
+	return ustr;
 }
 
 int power_supply_uevent(struct device *dev, struct kobj_uevent_env *env)
-- 
2.7.4

