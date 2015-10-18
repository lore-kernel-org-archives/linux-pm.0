From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3] debugfs: Add debugfs_create_ulong()
Date: Sun, 18 Oct 2015 14:45:27 +0530
Message-ID: <6d786424835b514b92f847e6f9af21b01244de85.1445159433.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, arnd@arndb.de, sboyd@codeaurora.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, stern@rowland.harvard.edu, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Add debugfs_create_ulong() for the users of type 'unsigned long'. These
will be 32 bits long on a 32 bit machine and 64 bits long on a 64 bit
machine.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2->V3:
- Rebased over driver-core tree.
- Also add missing fops_xlong_ro/wo.

 fs/debugfs/file.c       | 69 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/debugfs.h |  4 +++
 2 files changed, 73 insertions(+)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 8450549d54a9..d2f93ceef78c 100644
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
@@ -258,6 +306,9 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_x32_wo, NULL, debugfs_u32_set, "0x%08llx\n");
 DEFINE_SIMPLE_ATTRIBUTE(fops_x64, debugfs_u64_get, debugfs_u64_set, "0x%016llx\n");
 DEFINE_SIMPLE_ATTRIBUTE(fops_x64_ro, debugfs_u64_get, NULL, "0x%016llx\n");
 DEFINE_SIMPLE_ATTRIBUTE(fops_x64_wo, NULL, debugfs_u64_set, "0x%016llx\n");
+DEFINE_SIMPLE_ATTRIBUTE(fops_xlong, debugfs_ulong_get, debugfs_ulong_set, "0x%016llx\n");
+DEFINE_SIMPLE_ATTRIBUTE(fops_xlong_ro, debugfs_ulong_get, NULL, "0x%016llx\n");
+DEFINE_SIMPLE_ATTRIBUTE(fops_xlong_wo, NULL, debugfs_ulong_set, "0x%016llx\n");
 
 /*
  * debugfs_create_x{8,16,32,64} - create a debugfs file that is used to read and write an unsigned {8,16,32,64}-bit value
@@ -339,6 +390,24 @@ struct dentry *debugfs_create_x64(const char *name, umode_t mode,
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
+	return debugfs_create_mode(name, mode, parent, value, &fops_xlong,
+				   &fops_xlong_ro, &fops_xlong_wo);
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
