From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Subject: [PATCH 1/2] sysfs: Add hook for checking the file capable for opener
Date: Sun, 30 Dec 2018 21:28:55 +0800
Message-ID: <20181230132856.24095-2-jlee@suse.com>
References: <20181230132856.24095-1-jlee@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181230132856.24095-1-jlee@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Randy Dunlap <rdunlap@infradead.org>, Joe Perches <joe@perches.com>, Bart Van Assche <bvanassche@acm.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Chen Yu <yu.c.chen@intel.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-pm@vger.kernel.org

Base on the discussion in the following mail loop about checking
capability in sysfs write handler:
    https://lkml.org/lkml/2018/9/13/978

Some sysfs write handler are checking the writer's capability by using
capable(). Base on CVE-2013-1959, those code should use file_ns_capable()
to check the opener's capability. Otherwise the capability checking logic
can be bypassed.

This patch adds hook to sysfs_ops that it allows different implementation
in object and attribute levels for checking file capable before
accessing sysfs interfaces.

The callback function in kobject sysfs_ops is the first implementation of
new hook. It casts attribute to kobj_attribute and calls the file
capability callback function in kobject attribute level.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Chen Yu <yu.c.chen@intel.com>
Cc: Giovanni Gherdovich <ggherdovich@suse.cz>
Cc: Jann Horn <jannh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Joe Perches <joe@perches.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 fs/sysfs/file.c         |  8 ++++++++
 include/linux/kobject.h |  2 ++
 include/linux/sysfs.h   |  2 ++
 lib/kobject.c           | 26 ++++++++++++++++++++++++++
 4 files changed, 38 insertions(+)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index bb71db63c99c..cf98957babd0 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -58,6 +58,10 @@ static int sysfs_kf_seq_show(struct seq_file *sf, void *v)
 	 * if @ops->show() isn't implemented.
 	 */
 	if (ops->show) {
+		if (ops->show_file_capable &&
+		    !ops->show_file_capable(of->file, of->kn->priv))
+			return -EPERM;
+
 		count = ops->show(kobj, of->kn->priv, buf);
 		if (count < 0)
 			return count;
@@ -136,6 +140,10 @@ static ssize_t sysfs_kf_write(struct kernfs_open_file *of, char *buf,
 	if (!count)
 		return 0;
 
+	if (ops->store_file_capable &&
+	    !ops->store_file_capable(of->file, of->kn->priv))
+		return -EPERM;
+
 	return ops->store(kobj, of->kn->priv, buf, count);
 }
 
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 1ab0d624fb36..f89fd692e812 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -166,6 +166,8 @@ struct kobj_attribute {
 			char *buf);
 	ssize_t (*store)(struct kobject *kobj, struct kobj_attribute *attr,
 			 const char *buf, size_t count);
+	bool    (*show_file_capable)(const struct file *);
+	bool    (*store_file_capable)(const struct file *);
 };
 
 extern const struct sysfs_ops kobj_sysfs_ops;
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 786816cf4aa5..0b107795bee4 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -214,6 +214,8 @@ struct bin_attribute bin_attr_##_name = __BIN_ATTR_RW(_name, _size)
 struct sysfs_ops {
 	ssize_t	(*show)(struct kobject *, struct attribute *, char *);
 	ssize_t	(*store)(struct kobject *, struct attribute *, const char *, size_t);
+	bool	(*show_file_capable)(const struct file *, struct attribute *);
+	bool	(*store_file_capable)(const struct file *, struct attribute *);
 };
 
 #ifdef CONFIG_SYSFS
diff --git a/lib/kobject.c b/lib/kobject.c
index b72e00fd7d09..81699b2b7f72 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -800,6 +800,18 @@ static ssize_t kobj_attr_show(struct kobject *kobj, struct attribute *attr,
 	return ret;
 }
 
+static bool kobj_attr_show_file_capable(const struct file *file,
+					struct attribute *attr)
+{
+	struct kobj_attribute *kattr;
+
+	kattr = container_of(attr, struct kobj_attribute, attr);
+	if (kattr->show_file_capable)
+		return kattr->show_file_capable(file);
+
+	return true;
+}
+
 static ssize_t kobj_attr_store(struct kobject *kobj, struct attribute *attr,
 			       const char *buf, size_t count)
 {
@@ -812,9 +824,23 @@ static ssize_t kobj_attr_store(struct kobject *kobj, struct attribute *attr,
 	return ret;
 }
 
+static bool kobj_attr_store_file_capable(const struct file *file,
+					struct attribute *attr)
+{
+	struct kobj_attribute *kattr;
+
+	kattr = container_of(attr, struct kobj_attribute, attr);
+	if (kattr->store_file_capable)
+		return kattr->store_file_capable(file);
+
+	return true;
+}
+
 const struct sysfs_ops kobj_sysfs_ops = {
 	.show	= kobj_attr_show,
 	.store	= kobj_attr_store,
+	.show_file_capable = kobj_attr_show_file_capable,
+	.store_file_capable = kobj_attr_store_file_capable,
 };
 EXPORT_SYMBOL_GPL(kobj_sysfs_ops);
 
-- 
2.13.6
