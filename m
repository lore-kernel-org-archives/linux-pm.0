From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: [PATCH v3 01/16] of: add support for retrieving cpu node for a given logical cpu index
Date: Tue, 23 Jul 2013 11:54:10 +0100
Message-ID: <1374576850-9667-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <51ED4A99.3030403@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51ED4A99.3030403@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Sudeep.KarkadaNagesha@arm.com, Russell King <linux@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
List-Id: linux-pm@vger.kernel.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Currently different drivers requiring to access cpu device node are
parsing the device tree themselves. Since the ordering in the DT need
not match the logical cpu ordering, the parsing logic needs to consider
that. However, this has resulted in lots of code duplication and in some
cases even incorrect logic.

It's better to consolidate them by adding support for getting cpu
device node for a given logical cpu index in DT core library. However
logical to physical index mapping can be architecture specific.

This patch adds of_get_cpu_node to retrieve a cpu device node for a
given logical cpu index. The default matching of the physical id to the
logical cpu index can be overridden by architecture specific code.

It is recommended to use these helper function only in pre-SMP/early
initialisation stages to retrieve CPU device node pointers in logical
ordering. Once the cpu devices are registered, it can be retrieved easily
from cpu device of_node which avoids unnecessary parsing and matching.

Acked-by: Rob Herring <rob.herring@calxeda.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/of/base.c   | 73 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 include/linux/cpu.h |  1 +
 include/linux/of.h  |  6 +++++
 3 files changed, 80 insertions(+)

----------------->8--------------------------
Hi Nico,

I found include/linux/cpu.h is more appropriate for this.
Is that fine ?

Regards,
Sudeep

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 5c54279..052b4b2 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -18,6 +18,7 @@
  *      2 of the License, or (at your option) any later version.
  */
 #include <linux/ctype.h>
+#include <linux/cpu.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/spinlock.h>
@@ -230,6 +231,78 @@ const void *of_get_property(const struct device_node *=
np, const char *name,
 }
 EXPORT_SYMBOL(of_get_property);
=20
+/*
+ * arch_match_cpu_phys_id - Match the given logical CPU and physical id
+ *
+ * @cpu: logical index of a cpu
+ * @phys_id: physical identifier of a cpu
+ *
+ * CPU logical to physical index mapping is architecture specific.
+ * However this __weak function provides a default match of physical
+ * id to logical cpu index.
+ *
+ * Returns true if the physical identifier and the logical index correspon=
d
+ * to the same cpu, false otherwise.
+ */
+bool __weak arch_match_cpu_phys_id(int cpu, u64 phys_id)
+{
+=09return (u32)phys_id =3D=3D cpu;
+}
+
+/**
+ * of_get_cpu_node - Get device node associated with the given logical CPU
+ *
+ * @cpu: CPU number(logical index) for which device node is required
+ *
+ * The main purpose of this function is to retrieve the device node for th=
e
+ * given logical CPU index. It should be used to initialize the of_node in
+ * cpu device. Once of_node in cpu device is populated, all the further
+ * references can use that instead.
+ *
+ * CPU logical to physical index mapping is architecture specific and is b=
uilt
+ * before booting secondary cores. This function uses arch_match_cpu_phys_=
id
+ * which can be overridden by architecture specific implementation.
+ *
+ * Returns a node pointer for the logical cpu if found, else NULL.
+ */
+struct device_node *of_get_cpu_node(int cpu)
+{
+=09struct device_node *cpun, *cpus;
+=09const __be32 *cell;
+=09u64 hwid;
+=09int ac, prop_len;
+
+=09cpus =3D of_find_node_by_path("/cpus");
+=09if (!cpus) {
+=09=09pr_warn("Missing cpus node, bailing out\n");
+=09=09return NULL;
+=09}
+
+=09if (of_property_read_u32(cpus, "#address-cells", &ac)) {
+=09=09pr_warn("%s: missing #address-cells\n", cpus->full_name);
+=09=09ac =3D of_n_addr_cells(cpus);
+=09}
+
+=09for_each_child_of_node(cpus, cpun) {
+=09=09if (of_node_cmp(cpun->type, "cpu"))
+=09=09=09continue;
+=09=09cell =3D of_get_property(cpun, "reg", &prop_len);
+=09=09if (!cell) {
+=09=09=09pr_warn("%s: missing reg property\n", cpun->full_name);
+=09=09=09continue;
+=09=09}
+=09=09prop_len /=3D sizeof(*cell);
+=09=09while (prop_len) {
+=09=09=09hwid =3D of_read_number(cell, ac);
+=09=09=09prop_len -=3D ac;
+=09=09=09if (arch_match_cpu_phys_id(cpu, hwid))
+=09=09=09=09return cpun;
+=09=09}
+=09}
+
+=09return NULL;
+}
+
 /** Checks if the given "compat" string matches one of the strings in
  * the device's "compatible" property
  */
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index ab0eade..d0c8204 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -34,6 +34,7 @@ extern void cpu_remove_dev_attr(struct device_attribute *=
attr);
=20
 extern int cpu_add_dev_attr_group(struct attribute_group *attrs);
 extern void cpu_remove_dev_attr_group(struct attribute_group *attrs);
+extern bool arch_match_cpu_phys_id(int cpu, u64 phys_id);
=20
 #ifdef CONFIG_HOTPLUG_CPU
 extern void unregister_cpu(struct cpu *cpu);
diff --git a/include/linux/of.h b/include/linux/of.h
index 1fd08ca..9e82812 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -266,6 +266,7 @@ extern int of_device_is_available(const struct device_n=
ode *device);
 extern const void *of_get_property(const struct device_node *node,
 =09=09=09=09const char *name,
 =09=09=09=09int *lenp);
+extern struct device_node *of_get_cpu_node(int cpu);
 #define for_each_property_of_node(dn, pp) \
 =09for (pp =3D dn->properties; pp !=3D NULL; pp =3D pp->next)
=20
@@ -459,6 +460,11 @@ static inline const void *of_get_property(const struct=
 device_node *node,
 =09return NULL;
 }
=20
+static inline struct device_node *of_get_cpu_node(int cpu)
+{
+=09return NULL;
+}
+
 static inline int of_property_read_u64(const struct device_node *np,
 =09=09=09=09       const char *propname, u64 *out_value)
 {
--=20
1.8.1.2
