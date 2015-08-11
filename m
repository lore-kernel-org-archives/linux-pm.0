From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 6/6] PM / OPP: Add debugfs support
Date: Tue, 11 Aug 2015 12:05:49 +0530
Message-ID: <20150811063549.GB5147@linux>
References: <cover.1439187821.git.viresh.kumar@linaro.org>
 <8a238dcc3bdef28aa9fc3f68787a84449c6ff17a.1439187821.git.viresh.kumar@linaro.org>
 <20150810195009.GE9678@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150810195009.GE9678@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, khilman@linaro.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On 10-08-15, 12:50, Stephen Boyd wrote:
> > +	/* Create device specific directory link */
> > +	d = debugfs_create_symlink(dev_name(dev), rootdir,
> 
> The dev_name thing is going to fail. Eventually we'll get into a
> situation where two devices with the same name on different
> busses have OPPs. When we add them to debugfs their names are
> going to conflict. The regulator core suffered this problem, see
> commit a9eaa8130707 (regulator: Ensure unique regulator debugfs
> directory names, 2014-10-17) for one solution.

The regulator core had a slightly different problem probably as it was
assigning similar names to devices of same type. And we may not hit
it.

But still, I have prefixed it with parent name to make it look
slightly stronger :)

Diff with earlier patch (only compile tested for now, don't have
access to setup currently):

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index b3af1825266a..871502dec381 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -679,7 +679,7 @@ static int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 	new_opp->dev_opp = dev_opp;
 	list_add_rcu(&new_opp->node, head);
 
-	ret = opp_debug_create_one(new_opp, dev_opp->dentry);
+	ret = opp_debug_create_one(new_opp, dev_opp);
 	if (ret)
 		dev_err(dev, "%s: Failed to register opp to debugfs (%d)\n",
 			__func__, ret);
diff --git a/drivers/base/power/opp/debugfs.c b/drivers/base/power/opp/debugfs.c
index d4e18eac8278..6c048bfbf954 100644
--- a/drivers/base/power/opp/debugfs.c
+++ b/drivers/base/power/opp/debugfs.c
@@ -17,13 +17,24 @@
 
 static struct dentry *rootdir;
 
+static void opp_set_dev_name(const struct device *dev, char *name)
+{
+
+	if (dev->parent)
+		snprintf(name, NAME_MAX, "%s-%s", dev_name(dev->parent),
+			 dev_name(dev));
+	else
+		snprintf(name, NAME_MAX, "%s", dev_name(dev));
+}
+
 void opp_debug_remove_one(struct dev_pm_opp *opp)
 {
 	debugfs_remove_recursive(opp->dentry);
 }
 
-int opp_debug_create_one(struct dev_pm_opp *opp, struct dentry *pdentry)
+int opp_debug_create_one(struct dev_pm_opp *opp, struct device_opp *dev_opp)
 {
+	struct dentry *pdentry = dev_opp->dentry;
 	struct dentry *d;
 	char name[15];
 
@@ -75,10 +86,12 @@ static int device_opp_debug_create_dir(struct device_list_opp *list_dev,
 				       struct device_opp *dev_opp)
 {
 	const struct device *dev = list_dev->dev;
-	struct dentry *d = NULL;
+	struct dentry *d;
+
+	opp_set_dev_name(dev, dev_opp->dentry_name);
 
 	/* Create device specific directory */
-	d = debugfs_create_dir(dev_name(dev), rootdir);
+	d = debugfs_create_dir(dev_opp->dentry_name, rootdir);
 	if (!d) {
 		dev_err(dev, "%s: Failed to create debugfs dir\n", __func__);
 		return -ENOMEM;
@@ -86,7 +99,6 @@ static int device_opp_debug_create_dir(struct device_list_opp *list_dev,
 
 	list_dev->dentry = d;
 	dev_opp->dentry = d;
-	dev_opp->debugfs_dev = dev;
 
 	return 0;
 }
@@ -95,11 +107,13 @@ static int device_opp_debug_create_link(struct device_list_opp *list_dev,
 					struct device_opp *dev_opp)
 {
 	const struct device *dev = list_dev->dev;
-	struct dentry *d = NULL;
+	char name[NAME_MAX];
+	struct dentry *d;
+
+	opp_set_dev_name(list_dev->dev, name);
 
 	/* Create device specific directory link */
-	d = debugfs_create_symlink(dev_name(dev), rootdir,
-				   dev_name(dev_opp->debugfs_dev));
+	d = debugfs_create_symlink(name, rootdir, dev_opp->dentry_name);
 	if (!d) {
 		dev_err(dev, "%s: Failed to create link\n", __func__);
 		return -ENOMEM;
@@ -135,6 +149,36 @@ int opp_debug_register(struct device_list_opp *list_dev,
 	return device_opp_debug_create_dir(list_dev, dev_opp);
 }
 
+static void opp_migrate_dentry(struct device_list_opp *list_dev,
+			       struct device_opp *dev_opp)
+{
+	struct device_list_opp *new_dev;
+	const struct device *dev;
+	struct dentry *dentry;
+
+	/* Look for next list-dev */
+	list_for_each_entry(new_dev, &dev_opp->dev_list, node)
+		if (new_dev != list_dev)
+			break;
+
+	/* new_dev is guaranteed to be valid here */
+	dev = new_dev->dev;
+	debugfs_remove_recursive(new_dev->dentry);
+
+	opp_set_dev_name(dev, dev_opp->dentry_name);
+
+	dentry = debugfs_rename(rootdir, list_dev->dentry, rootdir,
+				dev_opp->dentry_name);
+	if (!dentry) {
+		dev_err(dev, "%s: Failed to rename link from: %s to %s\n",
+			__func__, dev_name(list_dev->dev), dev_name(dev));
+		return;
+	}
+
+	new_dev->dentry = dentry;
+	dev_opp->dentry = dentry;
+}
+
 /**
  * opp_debug_unregister - remove a device opp node from debugfs opp directory
  * @list_dev: list-dev pointer for device
@@ -145,9 +189,18 @@ int opp_debug_register(struct device_list_opp *list_dev,
 void opp_debug_unregister(struct device_list_opp *list_dev,
 			  struct device_opp *dev_opp)
 {
-	debugfs_remove_recursive(list_dev->dentry);
-	if (list_dev->dentry == dev_opp->dentry)
+	if (list_dev->dentry == dev_opp->dentry) {
+		/* Move the real dentry object under another device */
+		if (!list_is_singular(&dev_opp->dev_list)) {
+			opp_migrate_dentry(list_dev, dev_opp);
+			goto out;
+		}
 		dev_opp->dentry = NULL;
+	}
+
+	debugfs_remove_recursive(list_dev->dentry);
+
+out:
 	list_dev->dentry = NULL;
 }
 
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 8eb6a9a098a1..0e4c27fb0c4a 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -17,6 +17,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/limits.h>
 #include <linux/pm_opp.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
@@ -83,8 +84,10 @@ struct dev_pm_opp {
 
 	struct device_node *np;
 
+#ifdef CONFIG_DEBUG_FS
 	/* debugfs */
 	struct dentry *dentry;
+#endif
 };
 
 /**
@@ -102,8 +105,10 @@ struct device_list_opp {
 	const struct device *dev;
 	struct rcu_head rcu_head;
 
+#ifdef CONFIG_DEBUG_FS
 	/* debugfs */
 	struct dentry *dentry;
+#endif
 };
 
 /**
@@ -120,7 +125,7 @@ struct device_list_opp {
  * @np:		struct device_node pointer for opp's DT node.
  * @shared_opp: OPP is shared between multiple devices.
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
- * @debugfs_dev: Pointer to device for which the real directory was created.
+ * @dentry_name: Name of the real dentry.
  *
  * This is an internal data structure maintaining the link to opps attached to
  * a device. This structure is not meant to be shared to users as it is
@@ -143,9 +148,11 @@ struct device_opp {
 	bool shared_opp;
 	struct dev_pm_opp *suspend_opp;
 
+#ifdef CONFIG_DEBUG_FS
 	/* debugfs */
 	struct dentry *dentry;
-	const struct device *debugfs_dev;
+	char dentry_name[NAME_MAX];
+#endif
 };
 
 /* Routines internal to opp core */
@@ -156,7 +163,7 @@ struct device_node *_of_get_opp_desc_node(struct device *dev);
 
 #ifdef CONFIG_DEBUG_FS
 void opp_debug_remove_one(struct dev_pm_opp *opp);
-int opp_debug_create_one(struct dev_pm_opp *opp, struct dentry *pdentry);
+int opp_debug_create_one(struct dev_pm_opp *opp, struct device_opp *dev_opp);
 int opp_debug_register(struct device_list_opp *list_dev,
 		       struct device_opp *dev_opp);
 void opp_debug_unregister(struct device_list_opp *list_dev,
@@ -165,7 +172,7 @@ void opp_debug_unregister(struct device_list_opp *list_dev,
 static inline void opp_debug_remove_one(struct dev_pm_opp *opp) {}
 
 static inline int opp_debug_create_one(struct dev_pm_opp *opp,
-				       struct dentry *pdentry)
+				       struct device_opp *dev_opp)
 { return 0; }
 static inline int opp_debug_register(struct device_list_opp *list_dev,
 				     struct device_opp *dev_opp)
