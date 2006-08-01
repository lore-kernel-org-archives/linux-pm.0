From: david singleton <dsingleton@mvista.com>
Subject: PowerOp-x86-centrino-speedstep.patch
Date: Mon, 31 Jul 2006 17:47:07 -0700
Message-ID: <c2c1939879c9274b0c84194882696151@mvista.com>
Mime-Version: 1.0 (Apple Message framework v624)
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
To: linux-pm@lists.osdl.org
Cc: david singleton <dsingleton@mvista.com>
List-Id: linux-pm@vger.kernel.org

This patch adds operating points that mirror the CPUFREQ frequency =

table.
It also adds the routine necessary to transition to a new frequency on
the centrino-speedstep.

Each operating point has function pointers to the routines that prepare =

transition,
transition and finish the transition.  For CPUFREQ and Dynamic Power =

Mangement
the prepare and finish transition routines are commonly shared across =

platforms,
and in fact are the same notifier list of functions to call when =

changing to a new
operating point wether the transition comes through the CPUFREQ =

interface or
the PowerOp interface in /sys/power/state.

The transition routine itself is usually platform specific.

David

Signed-Off-by: David Singleton dsingleton@mvista.com

  arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c |  108 =

++++++++++++++++++++++
  1 files changed, 108 insertions(+)

Index: linux-2.6.17/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.orig/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
+++ linux-2.6.17/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
@@ -20,6 +20,7 @@
  #include <linux/sched.h>       /* current */
  #include <linux/delay.h>
  #include <linux/compiler.h>
+#include <linux/pm.h>

  #ifdef CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
  #include <linux/acpi.h>
@@ -160,6 +161,80 @@ static struct cpufreq_frequency_table ba
         OP(1400, 1484),
         { .frequency =3D CPUFREQ_TABLE_END }
  };
+#ifdef CONFIG_PM
+/*
+ * this is the formula for OP.  We need the perfctl
+ * msr value to change to a new frequency.
+ * We'll save it in the machine dependent variable md_data.
+ */
+static void set_perfctl_msr(struct power_op *pm)
+{
+       unsigned int msr =3D pm->frequency/100;
+       unsigned int v =3D pm->voltage - 700;
+
+       msr =3D (unsigned int)(msr << 8);
+       msr |=3D (unsigned int)(v / 16);
+       pm->md_data =3D (void *)msr;
+}
+
+static int centrino_transition(struct power_op *cur, struct power_op =

*new);
+
+static struct power_op mhz600 =3D {
+        .name =3D "600MHz",
+        .description =3D "Low Frequency state",
+        .type =3D PM_FREQ_CHANGE,
+        .frequency =3D 600,
+        .voltage =3D 956,
+       .latency =3D 100,
+       .prepare_transition  =3D cpufreq_prepare_transition,
+       .transition =3D centrino_transition,
+       .finish_transition =3D cpufreq_finish_transition,
+};
+static struct power_op mhz800 =3D {
+        .name =3D "800MHz",
+        .description =3D "Lower Frequency state",
+        .type =3D PM_FREQ_CHANGE,
+        .frequency =3D 800,
+        .voltage =3D 1180,
+       .latency =3D 100,
+       .prepare_transition  =3D cpufreq_prepare_transition,
+       .transition =3D centrino_transition,
+       .finish_transition =3D cpufreq_finish_transition,
+};
+static struct power_op ghz1 =3D {
+        .name =3D "1GHz",
+        .description =3D "Med Frequency state",
+        .type =3D PM_FREQ_CHANGE,
+        .frequency =3D 1000,
+        .voltage =3D 1308,
+       .latency =3D 100,
+       .prepare_transition  =3D cpufreq_prepare_transition,
+       .transition =3D centrino_transition,
+       .finish_transition =3D cpufreq_finish_transition,
+};
+static struct power_op ghz12 =3D {
+        .name =3D "1.2GHz",
+        .description =3D "High Frequency state",
+        .type =3D PM_FREQ_CHANGE,
+        .frequency =3D 1200,
+        .voltage =3D 1436,
+       .latency =3D 100,
+       .prepare_transition  =3D cpufreq_prepare_transition,
+       .transition =3D centrino_transition,
+       .finish_transition =3D cpufreq_finish_transition,
+};
+static struct power_op ghz14 =3D {
+        .name =3D "1.4GHz",
+        .description =3D "Highest Frequency state",
+        .type =3D PM_FREQ_CHANGE,
+        .frequency =3D 1400,
+        .voltage =3D 1484,
+       .latency =3D 100,
+       .prepare_transition  =3D cpufreq_prepare_transition,
+       .transition =3D centrino_transition,
+       .finish_transition =3D cpufreq_finish_transition,
+};
+#endif

  /* Intel Pentium M processor 1.50GHz (Banias) */
  static struct cpufreq_frequency_table banias_1500[] =3D
@@ -266,6 +341,19 @@ static int centrino_cpu_init_table(struc
         dprintk("found \"%s\": max frequency: %dkHz\n",
                model->model_name, model->max_freq);

+#ifdef CONFIG_PM
+       list_add_tail(&mhz600.list, &pm_states.list);
+       set_perfctl_msr(&mhz600);
+       list_add_tail(&mhz800.list, &pm_states.list);
+       set_perfctl_msr(&mhz800);
+       list_add_tail(&ghz1.list, &pm_states.list);
+       set_perfctl_msr(&ghz1);
+       list_add_tail(&ghz12.list, &pm_states.list);
+       set_perfctl_msr(&ghz12);
+       list_add_tail(&ghz14.list, &pm_states.list);
+       set_perfctl_msr(&ghz14);
+       current_state =3D &ghz14;
+#endif
         return 0;
  }

@@ -620,6 +708,26 @@ static int centrino_verify (struct cpufr
         return cpufreq_frequency_table_verify(policy, =

centrino_model[policy->cpu]->op_points);
  }

+static int centrino_transition(struct power_op *cur, struct power_op =

*new)
+{
+       unsigned int msr, oldmsr =3D 0, h =3D 0;
+
+       if (cur =3D=3D new)
+               return 0;
+
+       msr =3D (unsigned int)new->md_data;
+       rdmsr(MSR_IA32_PERF_CTL, oldmsr, h);
+
+       /* all but 16 LSB are reserved, treat them with care */
+       oldmsr &=3D ~0xffff;
+       msr &=3D 0xffff;
+       oldmsr |=3D msr;
+
+       wrmsr(MSR_IA32_PERF_CTL, oldmsr, h);
+
+       return 0;
+}
+
  /**
   * centrino_setpolicy - set a new CPUFreq policy
   * @policy: new policy
