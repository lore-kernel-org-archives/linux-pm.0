From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: [RFC] OMAP1 PM Core,  Platform Power Parameter 1/2
Date: Sat, 30 Sep 2006 02:24:28 +0400
Message-ID: <20060930022428.e27d4c53.eugeny.mints@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: linux-kernel@vger.kernel.org
Cc: linux-pm@lists.osdl.org, ext-Tuukka.Tikkanen@nokia.com
List-Id: linux-pm@vger.kernel.org

Basic building block for PM Core layer is platform power parameter concept.=
 A platform power parameter is a name, get and set methods.  =


Although an PM Core implementation is completely arch specific any PM Core =
is
supposed to utilize platform power parameter concept.

Also any PM Core is supposed to export names of all platform power paramete=
rs
available on a platform. Any entity which registeres operating points is pr=
imary
consumer of platform_pwr_param_get_names() interface.

(Probably this interface routine might be moved to be a part of PowerOP Cor=
e =

interface)

diff --git a/include/linux/plat_pwr_param.h b/include/linux/plat_pwr_param.h
new file mode 100644
index 0000000..3a78d2b
--- /dev/null
+++ b/include/linux/plat_pwr_param.h
@@ -0,0 +1,27 @@
+/*
+ * Interface to the list of platfrom power parameter names available on a
+ * platform
+ *
+ * Author: Eugeny S. Mints <eugeny@nomadgs.com>
+ *
+ * 2006 (c) Nomad Global Solutions, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * This is used by an operating point registration entity/module =

+ */
+
+#ifndef __PLAT_PWR_PARAM_H__
+#define __PLAT_PWR_PARAM_H__
+
+/* =

+ * FIXME: for struct attribute; may be we need get rid of sysfs header =

+ * dependency
+ */
+#include <linux/sysfs.h>
+
+int
+platform_pwr_param_get_names(struct attribute ***platform_pwr_params_names=
);
+
+#endif /*__PLAT_PWR_PARAM_H__*/
diff --git a/include/linux/pm_core.h b/include/linux/pm_core.h
new file mode 100644
index 0000000..a166bc5
--- /dev/null
+++ b/include/linux/pm_core.h
@@ -0,0 +1,46 @@
+/*
+ * Generic platform power parameter interface =

+ *
+ * Author: Eugeny S. Mints <eugeny@nomadgs.com>
+ *
+ * 2006 (c) Nomad Global Solutions, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * This _arch_ _independent_ header defines concept of platform power para=
meter
+ * to be used by any PM Core layer arch specific implementation
+ *
+ * NOTE: this header is designed to be included by PM Core implementations=
 only
+ */
+
+#ifndef __PM_CORE_H__
+#define __PM_CORE_H__
+
+/* =

+ * FIXME: for struct attribute; may be we need get rid of sysfs header =

+ * dependency
+ */
+#include <linux/sysfs.h>
+
+struct platform_pwr_param {
+	struct attribute attr;
+	int  (*show) (void *md_opt, int *value);
+	void (*store) (void *md_opt, int value);
+};
+
+#define platform_pwr_param_init(_name) \
+static struct platform_pwr_param _name##_attr =3D { \
+	.attr   =3D {				\
+		.name =3D __stringify(_name),	\
+		.mode =3D 0644,			\
+		.owner =3D THIS_MODULE,		\
+	},					\
+	.show   =3D _name##_show,			\
+	.store  =3D _name##_store,		\
+}
+
+#define to_platform_pwr_param(_attr) container_of((_attr), \
+	struct platform_pwr_param, attr)
+
+#endif /*__PM_CORE_H__*/
