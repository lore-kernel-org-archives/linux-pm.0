From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2] debugfs: Add debugfs_create_ulong()
Date: Fri,  9 Oct 2015 22:41:16 +0530
Message-ID: <69e3888403d23de9aadf3792be3c0bdce57495b0.1444410517.git.viresh.kumar@linaro.org>
References: <3a48d2bb4320bba82f91354d7165c300ef8108bd.1444402709.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35043 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbbJIRLZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 Oct 2015 13:11:25 -0400
Received: by pabve7 with SMTP id ve7so33214067pab.2
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2015 10:11:25 -0700 (PDT)
In-Reply-To: <3a48d2bb4320bba82f91354d7165c300ef8108bd.1444402709.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, arnd@arndb.de, sboyd@codeaurora.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, stern@rowland.harvard.edu, Viresh Kumar <viresh.kumar@linaro.org>

Add debugfs_create_ulong() for the users of type 'unsigned long'. These
will be 32 bits long on a 32 bit machine and 64 bits long on a 64 bit
machine.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1->V2:
- Fix missing debugfs_create_xlong() routine, was left in the
  repository.

 fs/debugfs/file.c       | 72 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/debugfs.h |  4 +++
 2 files changed, 76 insertions(+)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index b70c20fae502..129d19b72fd4 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -251,6 +251,60 @@ struct dentry *debugfs_create_u64(const char *name, umode_t mode,
 }
 EXPORT_SYMBOL_GPL(debugfs_create_u64);
 
+static int debugfs_ulong_set(void *data, u64 val)
+{
+	*(unsigned long *)data = val;
+	return 0;
+}
+
+static int debugfs_ulong_get(void *data, u64 *val)
+{
+	*val = *(unsigned long *)data;
+	return 0;
+}
+DEFINE_SIMPLE_ATTRIBUTE(fops_ulong, debugfs_ulong_get, debugfs_ulong_set, "%llu\n");
+DEFINE_SIMPLE_ATTRIBUTE(fops_ulong_ro, debugfs_ulong_get, NULL, "%llu\n");
+DEFINE_SIMPLE_ATTRIBUTE(fops_ulong_wo, NULL, debugfs_ulong_set, "%llu\n");
+
+/**
+ * debugfs_create_ulong - create a debugfs file that is used to read and write
+ * an unsigned long value.
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is %NULL, then the
+ *          file will be created in the root of the debugfs filesystem.
+ * @value: a pointer to the variable that the file should read to and write
+ *         from.
+ *
+ * This function creates a file in debugfs with the given name that
+ * contains the value of the variable @value.  If the @mode variable is so
+ * set, it can be read from, and written to.
+ *
+ * This function will return a pointer to a dentry if it succeeds.  This
+ * pointer must be passed to the debugfs_remove() function when the file is
+ * to be removed (no automatic cleanup happens if your module is unloaded,
+ * you are responsible here.)  If an error occurs, %NULL will be returned.
+ *
+ * If debugfs is not enabled in the kernel, the value -%ENODEV will be
+ * returned.  It is not wise to check for this value, but rather, check for
+ * %NULL or !%NULL instead as to eliminate the need for #ifdef in the calling
+ * code.
+ */
+struct dentry *debugfs_create_ulong(const char *name, umode_t mode,
+				    struct dentry *parent, unsigned long *value)
+{
+	/* if there are no write bits set, make read only */
+	if (!(mode & S_IWUGO))
+		return debugfs_create_file(name, mode, parent, value, &fops_ulong_ro);
+	/* if there are no read bits set, make write only */
+	if (!(mode & S_IRUGO))
+		return debugfs_create_file(name, mode, parent, value, &fops_ulong_wo);
+
+	return debugfs_create_file(name, mode, parent, value, &fops_ulong);
+}
+EXPORT_SYMBOL_GPL(debugfs_create_ulong);
+
 DEFINE_SIMPLE_ATTRIBUTE(fops_x8, debugfs_u8_get, debugfs_u8_set, "0x%02llx\n");
 DEFINE_SIMPLE_ATTRIBUTE(fops_x8_ro, debugfs_u8_get, NULL, "0x%02llx\n");
 DEFINE_SIMPLE_ATTRIBUTE(fops_x8_wo, NULL, debugfs_u8_set, "0x%02llx\n");
@@ -264,6 +318,7 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_x32_ro, debugfs_u32_get, NULL, "0x%08llx\n");
 DEFINE_SIMPLE_ATTRIBUTE(fops_x32_wo, NULL, debugfs_u32_set, "0x%08llx\n");
 
 DEFINE_SIMPLE_ATTRIBUTE(fops_x64, debugfs_u64_get, debugfs_u64_set, "0x%016llx\n");
+DEFINE_SIMPLE_ATTRIBUTE(fops_xlong, debugfs_ulong_get, debugfs_ulong_set, "0x%016llx\n");
 
 /*
  * debugfs_create_x{8,16,32,64} - create a debugfs file that is used to read and write an unsigned {8,16,32,64}-bit value
@@ -362,6 +417,23 @@ struct dentry *debugfs_create_x64(const char *name, umode_t mode,
 }
 EXPORT_SYMBOL_GPL(debugfs_create_x64);
 
+/**
+ * debugfs_create_xlong - create a debugfs file that is used to read and write an unsigned long value
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is %NULL, then the
+ *          file will be created in the root of the debugfs filesystem.
+ * @value: a pointer to the variable that the file should read to and write
+ *         from.
+ */
+struct dentry *debugfs_create_xlong(const char *name, umode_t mode,
+				    struct dentry *parent, unsigned long *value)
+{
+	return debugfs_create_file(name, mode, parent, value, &fops_xlong);
+}
+EXPORT_SYMBOL_GPL(debugfs_create_xlong);
+
 
 static int debugfs_size_t_set(void *data, u64 val)
 {
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 8321fe3058d6..60b150248b54 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -79,6 +79,8 @@ struct dentry *debugfs_create_u32(const char *name, umode_t mode,
 				  struct dentry *parent, u32 *value);
 struct dentry *debugfs_create_u64(const char *name, umode_t mode,
 				  struct dentry *parent, u64 *value);
+struct dentry *debugfs_create_ulong(const char *name, umode_t mode,
+				    struct dentry *parent, unsigned long *value);
 struct dentry *debugfs_create_x8(const char *name, umode_t mode,
 				 struct dentry *parent, u8 *value);
 struct dentry *debugfs_create_x16(const char *name, umode_t mode,
@@ -87,6 +89,8 @@ struct dentry *debugfs_create_x32(const char *name, umode_t mode,
 				  struct dentry *parent, u32 *value);
 struct dentry *debugfs_create_x64(const char *name, umode_t mode,
 				  struct dentry *parent, u64 *value);
+struct dentry *debugfs_create_xlong(const char *name, umode_t mode,
+				    struct dentry *parent, unsigned long *value);
 struct dentry *debugfs_create_size_t(const char *name, umode_t mode,
 				     struct dentry *parent, size_t *value);
 struct dentry *debugfs_create_atomic_t(const char *name, umode_t mode,
-- 
2.4.0

