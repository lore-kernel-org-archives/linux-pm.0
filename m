From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: [PATCH] PowerOP, PowerOP Sysfs 2/3
Date: Thu, 24 Aug 2006 05:12:02 +0400
Message-ID: <44ECFCE2.4040806@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050105070501020901050100"
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
--------------050105070501020901050100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Reference SysFS code for PowerOP

--------------050105070501020901050100
Content-Type: text/x-patch;
 name="powerop.sysfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="powerop.sysfs.patch"

diff --git a/drivers/powerop/Kconfig b/drivers/powerop/Kconfig
index 94d2459..fe5c946 100644
--- a/drivers/powerop/Kconfig
+++ b/drivers/powerop/Kconfig
@@ -8,5 +8,10 @@ config POWEROP
 	bool "PowerOP Core"
 	help
 
+config POWEROP_SYSFS
+	bool "  Enable PowerOP sysfs interface"
+	depends on POWEROP && SYSFS
+	help
+ 
 endmenu
 
diff --git a/drivers/powerop/Makefile b/drivers/powerop/Makefile
index 131b983..1d430ce 100644
--- a/drivers/powerop/Makefile
+++ b/drivers/powerop/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_POWEROP)		+= powerop.o
+obj-$(CONFIG_POWEROP_SYSFS)     += powerop_sysfs.o
 
diff --git a/drivers/powerop/powerop_sysfs.c b/drivers/powerop/powerop_sysfs.c
new file mode 100644
index 0000000..6cfd45f
--- /dev/null
+++ b/drivers/powerop/powerop_sysfs.c
@@ -0,0 +1,99 @@
+/*
+ * PowerOP sysfs UI
+ *
+ * Author: Todd Poynor <tpoynor@mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/powerop.h>
+#include <linux/init.h>
+#include <linux/kobject.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+
+
+#define powerop_attr(_name) \
+static struct subsys_attribute _name##_attr = { \
+	.attr   = {				\
+		.name = __stringify(_name),	\
+		.mode = 0644,			\
+		.owner = THIS_MODULE,		\
+	},					\
+	.show   = _name##_show,                 \
+	.store  = _name##_store,                \
+}
+
+decl_subsys(powerop, NULL, NULL);
+static char active_name[32];
+
+static ssize_t active_show(struct subsystem * subsys, char * buf)
+{
+	return sprintf(buf, "%s\n", active_name);
+}
+
+static ssize_t active_store(struct subsystem * subsys, const char * buf,
+			    size_t n)
+{
+	int error;
+	
+	error = powerop_set_point(buf);
+	if (error != 0)
+		return error;
+
+	strcpy(active_name, buf);
+	return n;
+}
+
+powerop_attr(active);
+
+static struct attribute * g[] = {
+	&active_attr.attr,
+	NULL,
+};
+
+static struct attribute_group attr_group = {
+	.attrs = g,
+};
+
+static int __init powerop_sysfs_init(void)
+{
+        int error;
+
+	if ((error = subsystem_register(&powerop_subsys))) {
+		printk(KERN_ERR
+		       "PowerOP SysFS subsystem_register failed.\n");
+		return error;
+	}
+
+	if ((error =
+	     sysfs_create_group(&powerop_subsys.kset.kobj,&attr_group))) {
+		printk(KERN_ERR
+		       "PowerOP subsys sysfs_create_group failed.\n");
+		subsystem_unregister(&powerop_subsys);
+		return error;
+	}
+
+        return 0;
+}
+
+static void __exit powerop_sysfs_exit(void)
+{
+	sysfs_remove_group(&powerop_subsys.kset.kobj,&attr_group);
+	subsystem_unregister(&powerop_subsys);
+}
+
+module_init(powerop_sysfs_init);
+module_exit(powerop_sysfs_exit);
+
+MODULE_DESCRIPTION("PowerOP Power Management SysFS UI");
+MODULE_LICENSE("GPL");
+

--------------050105070501020901050100
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--------------050105070501020901050100--
