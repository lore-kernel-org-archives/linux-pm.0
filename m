From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4] debugfs: Add debugfs_create_ulong()
Date: Sun, 18 Oct 2015 22:43:19 +0530
Message-ID: <e5fab11bb5f5914783c5a8222d4d9e146593dc59.1445188352.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33471 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932104AbbJRRNk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 18 Oct 2015 13:13:40 -0400
Received: by pabrc13 with SMTP id rc13so166708329pab.0
        for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2015 10:13:39 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, arnd@arndb.de, sboyd@codeaurora.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, stern@rowland.harvard.edu, Viresh Kumar <viresh.kumar@linaro.org>

Add debugfs_create_ulong() for the users of type 'unsigned long'. These
will be 32 bits long on a 32 bit machine and 64 bits long on a 64 bit
machine.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V3->V4:
- Drop xlong APIs..

 fs/debugfs/file.c       | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/debugfs.h |  2 ++
 2 files changed, 50 insertions(+)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 8450549d54a9..d2ba12e23ed9 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -243,6 +243,54 @@ struct dentry *debugfs_create_u64(const char *name, umode_t mode,
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
+	return debugfs_create_mode(name, mode, parent, value, &fops_ulong,
+				   &fops_ulong_ro, &fops_ulong_wo);
+}
+EXPORT_SYMBOL_GPL(debugfs_create_ulong);
+
 DEFINE_SIMPLE_ATTRIBUTE(fops_x8, debugfs_u8_get, debugfs_u8_set, "0x%02llx\n");
 DEFINE_SIMPLE_ATTRIBUTE(fops_x8_ro, debugfs_u8_get, NULL, "0x%02llx\n");
 DEFINE_SIMPLE_ATTRIBUTE(fops_x8_wo, NULL, debugfs_u8_set, "0x%02llx\n");
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 8321fe3058d6..19c066dce1da 100644
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
-- 
2.4.0

