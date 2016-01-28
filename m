From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 1/9] lib/string: introduce match_string() helper
Date: Thu, 28 Jan 2016 15:14:17 +0200
Message-ID: <1453986865-133572-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1453986865-133572-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453986865-133572-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

>From time to time we have to match a string in an array. Make a simple helper
for that purpose.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/string.h |  2 ++
 lib/string.c           | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index b0a732b..07505aa 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -131,6 +131,8 @@ extern void argv_free(char **argv);
 extern bool sysfs_streq(const char *s1, const char *s2);
 extern int strtobool(const char *s, bool *res);
 
+int match_string(const char * const *array, size_t n, const char *string);
+
 #ifdef CONFIG_BINARY_PRINTF
 int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args);
 int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf);
diff --git a/lib/string.c b/lib/string.c
index 0323c0d..ba01d4f 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -631,6 +631,32 @@ bool sysfs_streq(const char *s1, const char *s2)
 EXPORT_SYMBOL(sysfs_streq);
 
 /**
+ * match_string - matches given string in an array
+ * @array:	array of strings
+ * @n:		number of strings in the array or -1 for NULL terminated arrays
+ * @string:	string to match with
+ *
+ * Return:
+ * index of a @string in the @array if matches, or %-ENODATA otherwise.
+ */
+int match_string(const char * const *array, size_t n, const char *string)
+{
+	int index;
+	const char *item;
+
+	for (index = 0; index < n; index++) {
+		item = array[index];
+		if (!item)
+			break;
+		if (!strcmp(item, string))
+			return index;
+	}
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
2.7.0.rc3
