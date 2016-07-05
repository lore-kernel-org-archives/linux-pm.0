From: Markus Mayer <mmayer@broadcom.com>
Subject: [PATCH v2 7/7] power_supply: make use of new strcpytoupper() function
Date: Tue,  5 Jul 2016 13:47:11 -0700
Message-ID: <1467751631-22878-8-git-send-email-mmayer@broadcom.com>
References: <1467751631-22878-1-git-send-email-mmayer@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467751631-22878-1-git-send-email-mmayer@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Markus Mayer <mmayer@broadcom.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

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
