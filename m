From: Sudeep.KarkadaNagesha@arm.com
Subject: [RFC PATCH 02/11] ARM: DT/kernel: define ARM specific arch_of_get_cpu_node
Date: Mon, 15 Jul 2013 11:22:03 +0100
Message-ID: <1373883732-26303-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1373883732-26303-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1373883732-26303-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: cpufreq-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: cpufreq@vger.kernel.org, arnd@arndb.de, olof@lixom.net, lorenzo.pieralisi@arm.com, rob.herring@calxeda.com, grant.likely@linaro.org, rjw@sisk.pl, viresh.kumar@linaro.org, gregkh@linuxfoundation.org, gregory.clement@free-electrons.com, kernel@pengutronix.de, shawn.guo@linaro.org, linux@arm.linux.org.uk, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
List-Id: linux-pm@vger.kernel.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

CPU subsystem now provides architecture specific hook to retrieve the
of_node. Most of the cpu DT node parsing and initialisation is contained
in devtree.c. It's better to contain all CPU device node parsing there.

arch_of_get_cpu_node is mainly used to assign cpu->of_node when CPUs get
registered. This patch overrides the defination of the same. It can also
act as the helper function in pre-SMP/early initialisation stages to
retrieve CPU device node pointers in logical ordering.

This mainly helps to avoid replication of the code doing CPU node parsing
and physical(MPIDR) to logical mapping.

Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 arch/arm/include/asm/prom.h |  1 +
 arch/arm/kernel/devtree.c   | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm/include/asm/prom.h b/arch/arm/include/asm/prom.h
index a219227..96f1682 100644
--- a/arch/arm/include/asm/prom.h
+++ b/arch/arm/include/asm/prom.h
@@ -18,6 +18,7 @@
 extern struct machine_desc *setup_machine_fdt(unsigned int dt_phys);
 extern void arm_dt_memblock_reserve(void);
 extern void __init arm_dt_init_cpu_maps(void);
+extern struct device_node *arch_of_get_cpu_node(int cpu);
=20
 #else /* CONFIG_OF */
=20
diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 5859c8b..3431aa9 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -169,6 +169,35 @@ void __init arm_dt_init_cpu_maps(void)
 =09}
 }
=20
+struct device_node * __init arch_of_get_cpu_node(int cpu)
+{
+=09struct device_node *cpun, *cpus;
+=09const u32 *cell;
+=09u64 hwid;
+=09int ac;
+
+=09cpus =3D of_find_node_by_path("/cpus");
+=09if (WARN(!cpus, "Missing cpus node, bailing out\n"))
+=09=09return NULL;
+
+=09if (WARN_ON(of_property_read_u32(cpus, "#address-cells", &ac)))
+=09=09ac =3D of_n_addr_cells(cpus);
+
+=09for_each_child_of_node(cpus, cpun) {
+=09=09if (of_node_cmp(cpun->type, "cpu"))
+=09=09=09continue;
+=09=09cell =3D of_get_property(cpun, "reg", NULL);
+=09=09if (WARN(!cell, "%s: missing reg property\n", cpun->full_name))
+=09=09=09continue;
+
+=09=09hwid =3D of_read_number(cell, ac);
+=09=09if ((hwid & MPIDR_HWID_BITMASK) =3D=3D cpu_logical_map(cpu))
+=09=09=09return cpun;
+=09}
+
+=09return NULL;
+}
+
 /**
  * setup_machine_fdt - Machine setup when an dtb was passed to the kernel
  * @dt_phys: physical address of dt blob
--=20
1.8.1.2


