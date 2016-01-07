From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/8] lib/string: introduce match_string() helper
Date: Thu,  7 Jan 2016 14:06:01 +0200
Message-ID: <1452168368-75630-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:59786 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752704AbcAGMGO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 7 Jan 2016 07:06:14 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

>From time to time we have to match a string in an array. Make a simple helper
for that purpose.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/string.h |  2 ++
 lib/string.c           | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index b0a732b..37062fb 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -131,6 +131,8 @@ extern void argv_free(char **argv);
 extern bool sysfs_streq(const char *s1, const char *s2);
 extern int strtobool(const char *s, bool *res);
 
+int match_string(const char * const *array, size_t len, const char *string);
+
 #ifdef CONFIG_BINARY_PRINTF
 int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args);
 int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf);
diff --git a/lib/string.c b/lib/string.c
index 0323c0d..dd02270 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -631,6 +631,32 @@ bool sysfs_streq(const char *s1, const char *s2)
 EXPORT_SYMBOL(sysfs_streq);
 
 /**
+ * match_string - matches given string in an array
+ * @array:	array of strings
+ * @len:	number of strings in the array or 0 for NULL terminated arrays
+ * @string:	string to match with
+ *
+ * Return:
+ * index of a @string in the @array if matches, or %-ENODATA otherwise.
+ */
+int match_string(const char * const *array, size_t len, const char *string)
+{
+	int index = 0;
+	const char *item;
+
+	do {
+		item = array[index];
+		if (!item)
+			break;
+		if (!strcmp(item, string))
+			return index;
+	} while (++index < len || !len);
+
+	return -ENODATA;
+}
+EXPORT_SYMBOL(match_string);
+
+/**
  * strtobool - convert common user inputs into boolean values
  * @s: input string
  * @res: result
-- 
2.6.4

