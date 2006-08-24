From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: [PATCH] PowerOP, PowerOP Core, 1/3
Date: Thu, 24 Aug 2006 05:10:47 +0400
Message-ID: <44ECFC97.5060609@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060907040409080208090208"
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------060907040409080208090208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The PowerOP Core provides completely arch independent interface
to create and control operating points which consist of arbitrary
subset of power parameters available on a certain platform.

--------------060907040409080208090208
Content-Type: text/x-patch;
 name="powerop.core.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="powerop.core.patch"

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 8b11ceb..9161068 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -74,4 +74,6 @@ source "drivers/rtc/Kconfig"
 
 source "drivers/dma/Kconfig"
 
+source "drivers/powerop/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index fc2d744..f8eaf31 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_ISDN)		+= isdn/
 obj-$(CONFIG_EDAC)		+= edac/
 obj-$(CONFIG_MCA)		+= mca/
 obj-$(CONFIG_EISA)		+= eisa/
+obj-$(CONFIG_POWEROP)		+= powerop/
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_MMC)		+= mmc/
 obj-$(CONFIG_NEW_LEDS)		+= leds/
diff --git a/drivers/powerop/Kconfig b/drivers/powerop/Kconfig
new file mode 100644
index 0000000..94d2459
--- /dev/null
+++ b/drivers/powerop/Kconfig
@@ -0,0 +1,12 @@
+#
+# powerop
+#
+
+menu "PowerOP (Power Management)"
+
+config POWEROP
+	bool "PowerOP Core"
+	help
+
+endmenu
+
diff --git a/drivers/powerop/Makefile b/drivers/powerop/Makefile
new file mode 100644
index 0000000..131b983
--- /dev/null
+++ b/drivers/powerop/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_POWEROP)		+= powerop.o
+
diff --git a/drivers/powerop/powerop.c b/drivers/powerop/powerop.c
new file mode 100644
index 0000000..326ab31
--- /dev/null
+++ b/drivers/powerop/powerop.c
@@ -0,0 +1,454 @@
+/*
+ * PowerOP Core routines
+ *
+ * Author: Eugeny S. Mints <eugeny@nomadgs.com>
+ * 2006 (C) Nomad Global Solutions, Inc. 
+ *
+ * Original Author: Todd Poynor <tpoynor@mvista.com>
+ * Interface update by Eugeny S. Mints <eugeny.mints@gmail.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/powerop.h>
+
+#define POWEROP_MAX_OPT_NAME_LENGTH 32
+
+/* 
+ * FIXME: temporary limit. next implementation will handle unlimited number 
+ * of operating point
+ */
+#define POWEROP_MAX_OPT_NUMBER      20
+/* current number of registered operating points */
+static int registered_opt_number;
+
+/* array of registered opereting point names */
+static char *registered_names[POWEROP_MAX_OPT_NUMBER];
+
+/* notifications about an operating point registration/deregistration */
+static BLOCKING_NOTIFIER_HEAD(powerop_notifier_list);
+
+struct powerop_point {
+	struct kobject   kobj;   /* hook to reference an operating point in
+				  * some arch independent way
+				  */
+	void            *md_opt; /* arch dependent set of power parameters */
+	struct list_head node;
+};
+
+static struct powerop_driver *powerop_driver;
+
+/* list of named operating points maintained by PowerOP Core layer */
+static struct list_head named_opt_list;
+static DECLARE_MUTEX(named_opt_list_mutex);
+static int powerop_initialized;
+
+/* hw access serialization */
+static DECLARE_MUTEX(powerop_mutex);
+
+/* Auxiliary PowerOP Core internal routines */
+
+static void *
+create_point(const char *pwr_params, va_list args)
+{
+	void *res;
+
+	down(&powerop_mutex);
+	res = powerop_driver && powerop_driver->create_point ? 
+	      powerop_driver->create_point(pwr_params, args) :
+	      NULL;
+	up(&powerop_mutex);
+	
+	return res;
+}
+
+static int
+set_point(void *md_opt)
+{
+	int rc;
+
+	down(&powerop_mutex);
+	rc = md_opt && powerop_driver && powerop_driver->set_point ? 
+		powerop_driver->set_point(md_opt) : -EINVAL;
+	up(&powerop_mutex);
+	
+	return rc;
+}
+/*
+ * get_point - get value of specified power paramenter of operating 
+ * point pointed by 'md_opt'
+ *
+ * INPUT:
+ *   md_opt     - pointer to operating point to be processed or NULL to get
+ *                values of currently active operating point
+ *   pwr_params - name of requested power parameters
+ * 
+ * OUTPUT:
+ *   none
+ *
+ * INPUT/OUTPUT:
+ *   args - array of result placeholders 
+ *
+ * RETURN:
+ *   0 on success, error code otherwise
+ */
+static int
+get_point(void *md_opt, const char *pwr_params, va_list args)
+{
+	int rc;
+
+	down(&powerop_mutex);
+	rc = powerop_driver && powerop_driver->get_point ? 
+	     powerop_driver->get_point(md_opt, pwr_params, args) : 
+	     -EINVAL;
+	up(&powerop_mutex);
+
+	return rc;
+}
+
+/* PowerOP Core public interface */
+
+int 
+powerop_driver_register(struct powerop_driver *p)
+{
+	int error = 0;
+
+	if (! powerop_driver) {
+		printk(KERN_INFO "PowerOP registering driver %s.\n", p->name);
+		powerop_driver = p;
+
+	} else
+		error = -EBUSY;
+
+	return error;
+}
+
+void 
+powerop_driver_unregister(struct powerop_driver *p)
+{
+	if (powerop_driver == p) {
+		printk(KERN_INFO "PowerOP unregistering driver %s.\n", p->name);
+		powerop_driver = NULL;
+	}
+}
+
+EXPORT_SYMBOL_GPL(powerop_driver_register);
+EXPORT_SYMBOL_GPL(powerop_driver_unregister);
+
+
+/* 
+ * powerop_register_point - add new operating point with a given name to
+ * operating points list. A caller passes power parameters for new operating
+ * points as pairs of name/value and passes only those parameter names the
+ * caller is interested in. PowerOP Core calls powerop driver to initialize
+ * arch dependent part of new operating point and links new named operating 
+ * point to the list maintained by PowerOP Core
+ * 
+ *
+ * INPUT
+ *   id         - operating point name
+ *   pwr_params - set of (power parameter name, value) pairs
+ *
+ * OUTPUT
+ *   none
+ *
+ * RETURN
+ *   zero on success, -EEXIST or error code otherwise
+ *    
+ */
+int 
+powerop_register_point(const char *id, const char *pwr_params, ...)
+{
+	int err = 0;
+	struct powerop_point *opt, *tmpopt;
+	va_list args;
+
+	if ((!powerop_initialized) || (id == NULL) || 
+	    (strlen(id) > POWEROP_MAX_OPT_NAME_LENGTH) || 
+	    (registered_opt_number >= POWEROP_MAX_OPT_NUMBER))
+		return -EINVAL;
+
+	/* check whether operating point with specified name already exists */
+	down(&named_opt_list_mutex);
+	list_for_each_entry_safe(opt, tmpopt, &named_opt_list, node) {
+		if (strcmp(opt->kobj.name, id) == 0) {
+			err = -EEXIST;
+			break;
+		}
+	}
+	up(&named_opt_list_mutex);
+
+	if (err == -EEXIST)
+		return err;
+
+	if ((opt = kzalloc(sizeof(struct powerop_point), GFP_KERNEL)) == NULL)
+			return -ENOMEM;
+
+	if ((registered_names[registered_opt_number] = 
+		kzalloc(sizeof(char) * POWEROP_MAX_OPT_NAME_LENGTH, 
+			GFP_KERNEL)) == NULL) {
+		kfree(opt);
+		return -ENOMEM;
+	}
+
+	err = kobject_set_name(&opt->kobj, id);
+	if (err != 0) {
+		kfree(opt);			
+		return err;
+	}
+
+	va_start(args, pwr_params);
+	opt->md_opt = create_point(pwr_params, args);
+	va_end(args);
+
+	down(&named_opt_list_mutex);
+	list_add_tail(&opt->node, &named_opt_list);
+	strcpy(registered_names[registered_opt_number], id);
+	registered_opt_number++;
+	up(&named_opt_list_mutex);
+	
+	blocking_notifier_call_chain(&powerop_notifier_list, 
+				     POWEROP_REGISTER_EVENT, id);
+
+
+	return 0;
+}
+
+/* 
+ * powerop_unregister_point - search for operating point with specified
+ * name and remove it from operating points list
+ *
+ * INPUT
+ *   id - name of operating point
+ *
+ * OUTPUT
+ *   none
+ *
+ * RETURN
+ *   zero on success, -EINVAL if no operating point is found
+ *    
+ */
+int 
+powerop_unregister_point(const char *id)
+{
+	struct powerop_point *opt, *tmpopt;
+	int i = 0, ret = -EINVAL;
+
+	if ((!powerop_initialized) || (id == NULL))
+		return ret;
+
+	down(&named_opt_list_mutex);
+
+	list_for_each_entry_safe(opt, tmpopt, &named_opt_list, node) {
+		if (strcmp(opt->kobj.name, id) == 0) {
+			/* FIXME: can't remove a point if it's the active */ 
+			list_del(&opt->node);
+			kfree(opt->md_opt);
+			kfree(opt);
+			ret = 0;
+			break;
+		}
+	}
+
+	for (i = 0; i < registered_opt_number; i++) {
+		if (strcmp(registered_names[registered_opt_number], id) == 0) {
+			kfree(registered_names[i]);
+			registered_names[i] = 
+				       registered_names[registered_opt_number];
+			break;
+		}
+	}
+	registered_opt_number++;
+	up(&named_opt_list_mutex);
+
+	blocking_notifier_call_chain(&powerop_notifier_list, 
+				     POWEROP_UNREGISTER_EVENT, id);
+
+
+	return ret;
+}
+
+/* 
+ * powerop_set_point - search for operating point with specified name 
+ * and switch the system to the specified operating point
+ *
+ * INPUT
+ *   id - name of operating point
+ *
+ * OUTPUT
+ *   none
+ *
+ * RETURN
+ *     zero   on success 
+ *   -EINVAL  if no operating point is found or error code otherwise
+ */
+int 
+powerop_set_point(const char *id)
+{
+	struct powerop_point *opt, *selected_opt = NULL;
+	int ret;
+
+	if ((!powerop_initialized) || (id == NULL))
+		return -EINVAL;
+
+	down(&named_opt_list_mutex);
+
+	list_for_each_entry(opt, &named_opt_list, node) {
+		if (strcmp(opt->kobj.name, id) == 0) {
+			selected_opt = opt;
+			break;
+		}
+	}
+
+	ret = (selected_opt == NULL) ?
+		-EINVAL : set_point(opt->md_opt);
+
+	up(&named_opt_list_mutex);
+
+	return ret;
+}
+
+/* 
+ * powerop_get_point - search for operating point with specified name 
+ * and return value of power parameters corresponding to the operating point.
+ * NULL name is reserved to get power parameter values of current active
+ * operating point 
+ *
+ * INPUT
+ *   id - name of operating point or NULL to get values for current active
+ *        operating point
+ *
+ * OUTPUT
+ *   pwr_params - set of (power parameter name, result placeholder) pairs
+ *
+ * RETURN
+ *   zero on success, -EINVAL if no operating point is found
+ */
+int 
+powerop_get_point(const char *id, const char *pwr_params, ...)
+{
+	int ret = -EINVAL;
+	struct powerop_point *opt;
+	va_list args;
+	void *md_opt = NULL;
+
+	if (!powerop_initialized)
+		return ret;
+
+	down(&named_opt_list_mutex);
+
+	/* FIXME: get rid of sema for NULL case */
+	if (id != NULL) {
+		list_for_each_entry(opt, &named_opt_list, node) {
+			if (strcmp(opt->kobj.name, id) == 0) {
+				md_opt = opt->md_opt;
+				ret = 0;
+				break;
+			}
+		}
+		/* 
+		 * name is specified but corresponding operating point 
+		 * is not found 
+		 */
+		if (ret != 0)
+			goto out;
+	}
+
+
+	va_start(args, pwr_params);
+	ret = get_point(md_opt, pwr_params, args);
+	va_end(args);
+out:				
+	up(&named_opt_list_mutex);
+	return ret;
+}
+
+EXPORT_SYMBOL_GPL(powerop_register_point);
+EXPORT_SYMBOL_GPL(powerop_unregister_point);
+EXPORT_SYMBOL_GPL(powerop_set_point);
+EXPORT_SYMBOL_GPL(powerop_get_point);
+
+/* 
+ * powerop_get_registered_opt_names - get registered operating point 
+ * names list
+ *
+ * INPUT
+ *   none
+ *
+ * OUTPUT
+ *   opt_names_list - array of pointers to name strings
+ *   length         - array size
+ *
+ * RETURN
+ *   zero on success, an erro otherwise
+ */
+int 
+powerop_get_registered_opt_names(char *opt_names_list[], int *num)
+{
+	down(&named_opt_list_mutex);
+	opt_names_list = registered_names;
+	*num = registered_opt_number;	
+	return 0;
+}
+
+void 
+powerop_put_registered_opt_names(char *opt_names_list[])
+{
+	up(&named_opt_list_mutex);
+}
+EXPORT_SYMBOL_GPL(powerop_get_registered_opt_names);
+EXPORT_SYMBOL_GPL(powerop_put_registered_opt_names);
+
+
+int 
+powerop_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&powerop_notifier_list, nb);
+}
+
+int 
+powerop_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&powerop_notifier_list, nb);
+}
+
+EXPORT_SYMBOL(powerop_register_notifier);
+EXPORT_SYMBOL(powerop_unregister_notifier);
+
+
+
+static int __init powerop_init(void)
+{
+	INIT_LIST_HEAD(&named_opt_list);
+	powerop_initialized = 1;
+
+	return 0;
+}
+
+static void __exit powerop_exit(void)
+{
+	struct powerop_point *opt, *tmp_opt;
+
+	down(&named_opt_list_mutex);
+
+	list_for_each_entry_safe(opt, tmp_opt, &named_opt_list, node) {
+		list_del(&opt->node);
+		kfree(opt->md_opt);
+		kfree(opt);
+	}		
+
+	up(&named_opt_list_mutex);
+}
+
+module_init(powerop_init);
+module_exit(powerop_exit);
+
+MODULE_DESCRIPTION("PowerOP Core");
+MODULE_LICENSE("GPL");
+
diff --git a/include/linux/powerop.h b/include/linux/powerop.h
new file mode 100644
index 0000000..428a6e0
--- /dev/null
+++ b/include/linux/powerop.h
@@ -0,0 +1,129 @@
+/*
+ * PowerOP core definitions
+ *
+ * Author: Eugeny S. Mints <eugeny.@nomadgs.com>
+ *
+ * 2006 (C) Nomad Global Solutions, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Based on ideas and code by Todd Poynor <tpoynor@mvista.com>
+ */
+#ifndef __POWEROP_H__
+#define __POWEROP_H__
+
+/* Interface to an arch PM Core layer */
+
+struct powerop_driver {
+	char *name;
+	void *(*create_point)(const char *pwr_params, va_list args);
+	int  (*set_point)(void *md_opt);
+	int  (*get_point)(void *md_opt, const char *pwr_params, va_list args);
+};
+
+int powerop_driver_register(struct powerop_driver *p);
+void powerop_driver_unregister(struct powerop_driver *p);
+
+/* Main PowerOP Core interface */
+
+/* 
+ * powerop_register_point - add new operating point with a given name to
+ * operating points list. A caller passes power parameters for new operating
+ * points as pairs of name/value and passes only those parameter names the
+ * caller is interested in. PowerOP Core calls powerop driver to initialize
+ * arch dependent part of new operating point and links new named operating 
+ * point to the list maintained by PowerOP Core
+ * 
+ *
+ * INPUT
+ *   id         - operating point name
+ *   pwr_params - set of (power parameter name, value) pairs
+ *
+ * OUTPUT
+ *   none
+ *
+ * RETURN
+ *   zero on success, error code otherwise
+ *    
+ */
+int powerop_register_point(const char *id, const char *pwr_params, ...);
+
+/* 
+ * powerop_unregister_point - search for operating point with specified
+ * name and remove it from operating points list
+ *
+ * INPUT
+ *   id - name of operating point
+ *
+ * OUTPUT
+ *   none
+ *
+ * RETURN
+ *   zero on success, -EINVAL if no operating point is found
+ *    
+ */
+int powerop_unregister_point(const char *id);
+
+/* 
+ * powerop_set_point - search for operating point with specified name 
+ * and switch the system to the specified operating point
+ *
+ * INPUT
+ *   id - name of operating point
+ *
+ * OUTPUT
+ *   none
+ *
+ * RETURN
+ *     zero   on success 
+ *   -EINVAL  if no operating point is found or error code otherwise
+ */
+int powerop_set_point(const char *id);
+
+/* 
+ * powerop_get_point - search for operating point with specified name 
+ * and return value of power parameters corresponding to the operating point.
+ * NULL name is reserved to get power parameter values of current active
+ * operating point 
+ *
+ * INPUT
+ *   id - name of operating point or NULL to get values for current active
+ *        operating point
+ *
+ * OUTPUT
+ *   pwr_params - set of (power parameter name, result placeholder) pairs
+ *
+ * RETURN
+ *   zero on success, -EINVAL if no operating point is found
+ */
+int powerop_get_point(const char *id, const char *pwr_params, ...);
+
+/* 
+ * powerop_get_registered_opt_names - get registered operating point 
+ * names list
+ *
+ * INPUT
+ *   none
+ *
+ * OUTPUT
+ *   opt_names_list - array of pointers to name strings
+ *   length         - array size
+ *
+ * RETURN
+ *   zero on success, an erro otherwise
+ */
+int powerop_get_registered_opt_names(char *opt_names_list[], int *length);
+
+void powerop_put_registered_opt_names(char *opt_names_list[]);
+
+#define POWEROP_REGISTER_EVENT    1
+#define POWEROP_UNREGISTER_EVENT  2
+
+int powerop_register_notifier(struct notifier_block *nb);
+int powerop_unregister_notifier(struct notifier_block *nb);
+
+
+
+#endif /* __POWEROP_H__ */
+

--------------060907040409080208090208
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--------------060907040409080208090208--
