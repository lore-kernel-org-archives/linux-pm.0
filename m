From: Johannes Berg <johannes@sipsolutions.net>
Subject: [RFC 07/10] powermac: support G5 CPU hotplug
Date: Mon, 05 Feb 2007 19:30:34 +0100
Message-ID: <20070205185837.640324000@sipsolutions.net>
References: <20070205183026.989209000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline; filename=powermac-g5-cpu-offline.patch
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linuxppc-dev@ozlabs.org
Cc: linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>
List-Id: linux-pm@vger.kernel.org

This patch allows "hotplugging" of CPUs on G5 machines. CPUs that are
disabled are put into an idle loop with interrupts hard-disabled, to wake
them up again we kick them just like when bringing them up.

Maybe there's some way to actually turn off those CPUs even more?

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

--- mb-wireless.orig/arch/powerpc/platforms/powermac/smp.c	2007-02-05 16:07=
:09.164524763 +0100
+++ mb-wireless/arch/powerpc/platforms/powermac/smp.c	2007-02-05 16:07:50.7=
74524763 +0100
@@ -898,7 +898,7 @@ void smp_core99_cpu_die(unsigned int cpu
 	cpu_dead[cpu] =3D 0;
 }
 =

-#endif
+#endif /* CONFIG_HOTPLUG_CPU && CONFIG_PP32 */
 =

 /* Core99 Macs (dual G4s and G5s) */
 struct smp_ops_t core99_smp_ops =3D {
@@ -908,8 +908,16 @@ struct smp_ops_t core99_smp_ops =3D {
 	.setup_cpu	=3D smp_core99_setup_cpu,
 	.give_timebase	=3D smp_core99_give_timebase,
 	.take_timebase	=3D smp_core99_take_timebase,
-#if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PPC32)
+#if defined(CONFIG_HOTPLUG_CPU)
+# if defined(CONFIG_PPC32)
 	.cpu_disable	=3D smp_core99_cpu_disable,
 	.cpu_die	=3D smp_core99_cpu_die,
+# endif
+# if defined(CONFIG_PPC64)
+	.cpu_disable	=3D generic_cpu_disable,
+	.cpu_die	=3D generic_cpu_die,
+	/* intentionally do *NOT* assign cpu_enable,
+	 * the generic code will use kick_cpu then! */
+# endif
 #endif
 };
--- mb-wireless.orig/arch/powerpc/platforms/powermac/setup.c	2007-02-05 16:=
07:22.024524763 +0100
+++ mb-wireless/arch/powerpc/platforms/powermac/setup.c	2007-02-05 16:07:50=
.784524763 +0100
@@ -490,6 +490,9 @@ static int pmac_late_init(void)
 #ifdef CONFIG_SOFTWARE_SUSPEND
 	pm_set_ops(&pmac_pm_ops);
 #endif /* CONFIG_SOFTWARE_SUSPEND */
+	/* this is udbg (which is __init) and we can later use it during
+	 * cpu hotplug (in smp_core99_kick_cpu) */
+	ppc_md.progress =3D NULL;
 	return 0;
 }
 =

@@ -716,6 +719,33 @@ static int pmac_pci_probe_mode(struct pc
 		return PCI_PROBE_NORMAL;
 	return PCI_PROBE_DEVTREE;
 }
+
+#ifdef CONFIG_HOTPLUG_CPU
+/* access per cpu vars from generic smp.c */
+DECLARE_PER_CPU(int, cpu_state);
+
+static void pmac_cpu_die(void)
+{
+	/* turn off as much as possible, we'll be
+	 * kicked out as this will only be invoked
+	 * on core99 platforms for now ... */
+	hard_irq_disable();
+
+	printk(KERN_DEBUG "CPU#%d offline\n", smp_processor_id());
+	__get_cpu_var(cpu_state) =3D CPU_DEAD;
+	smp_wmb();
+	while (1) {
+		ppc64_runlatch_off();
+		if (ppc_md.power_save) {
+			ppc_md.power_save();
+		} else {
+			HMT_low();
+			HMT_very_low();
+		}
+	}
+}
+#endif
+
 #endif
 =

 static void __init pmac_init_irq(void)
@@ -769,6 +799,6 @@ define_machine(powermac) {
 	.phys_mem_access_prot	=3D pci_phys_mem_access_prot,
 #endif
 #if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PPC64)
-	.cpu_die		=3D generic_mach_cpu_die,
+	.cpu_die		=3D pmac_cpu_die,
 #endif
 };
--- mb-wireless.orig/arch/powerpc/kernel/smp.c	2007-02-05 16:07:09.27452476=
3 +0100
+++ mb-wireless/arch/powerpc/kernel/smp.c	2007-02-05 18:15:51.114524763 +01=
00
@@ -558,6 +558,11 @@ int __devinit start_secondary(void *unus
 =

 	local_irq_enable();
 =

+	/* it seems to be possible that we died from within
+	 * an interrupt ... reset the in-irq counts */
+	task_thread_info(paca[cpu].__current)->preempt_count &=3D
+		~(SOFTIRQ_MASK|HARDIRQ_MASK);
+
 	cpu_idle();
 	return 0;
 }

--
