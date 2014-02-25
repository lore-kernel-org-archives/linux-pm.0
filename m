From: Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH 10/10] cpuidle: cpuidle driver for MIPS CPS
Date: Tue, 25 Feb 2014 22:12:00 +0000
Message-ID: <20140225221200.GP25765@pburton-linux.le.imgtec.org>
References: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com>
 <1389794137-11361-11-git-send-email-paul.burton@imgtec.com>
 <530CB7DA.7060305@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <530CB7DA.7060305@linaro.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-mips@linux-mips.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 25, 2014 at 04:33:46PM +0100, Daniel Lezcano wrote:
> On 01/15/2014 02:55 PM, Paul Burton wrote:
> >This patch introduces a cpuidle driver implementation for the MIPS
> >Coherent Processing System (ie. Coherence Manager, Cluster Power
> >Controller). It allows for use of the following idle states:
> >
> >  - Coherent wait. This is the usual MIPS wait instruction.
> >
> >  - Non-coherent wait. In this state a core will disable coherency w=
ith
> >    the rest of the system before running the wait instruction. This
> >    eliminates coherence interventions which would typically be used=
 to
> >    keep cores coherent.
> >
> >These two states lay the groundwork for deeper states to be implemen=
ted
> >later, since all deeper states require the core to become non-cohere=
nt.
> >
> >Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> >Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> >Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> >Cc: linux-pm@vger.kernel.org
> >---
> >  drivers/cpuidle/Kconfig            |   5 +
> >  drivers/cpuidle/Kconfig.mips       |  14 +
> >  drivers/cpuidle/Makefile           |   3 +
> >  drivers/cpuidle/cpuidle-mips-cps.c | 545 +++++++++++++++++++++++++=
++++++++++++
> >  4 files changed, 567 insertions(+)
> >  create mode 100644 drivers/cpuidle/Kconfig.mips
> >  create mode 100644 drivers/cpuidle/cpuidle-mips-cps.c
> >
> >diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> >index b3fb81d..11ff281 100644
> >--- a/drivers/cpuidle/Kconfig
> >+++ b/drivers/cpuidle/Kconfig
> >@@ -35,6 +35,11 @@ depends on ARM
> >  source "drivers/cpuidle/Kconfig.arm"
> >  endmenu
> >
> >+menu "MIPS CPU Idle Drivers"
> >+depends on MIPS
> >+source "drivers/cpuidle/Kconfig.mips"
> >+endmenu
> >+
> >  endif
> >
> >  config ARCH_NEEDS_CPU_IDLE_COUPLED
> >diff --git a/drivers/cpuidle/Kconfig.mips b/drivers/cpuidle/Kconfig.=
mips
> >new file mode 100644
> >index 0000000..dc96691
> >--- /dev/null
> >+++ b/drivers/cpuidle/Kconfig.mips
> >@@ -0,0 +1,14 @@
> >+#
> >+# MIPS CPU Idle drivers
> >+#
> >+
> >+config MIPS_CPS_CPUIDLE
> >+	bool "Support for MIPS Coherent Processing Systems"
> >+	depends on SYS_SUPPORTS_MIPS_CPS && CPU_MIPSR2 && !MIPS_MT_SMTC
> >+	select ARCH_NEEDS_CPU_IDLE_COUPLED if MIPS_MT
> >+	select MIPS_CM
> >+	help
> >+	  Select this option to enable CPU idle driver for systems based
> >+	  around the MIPS Coherent Processing System architecture - that
> >+	  is, those with a Coherence Manager & optionally a Cluster
> >+	  Power Controller.
> >diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> >index 527be28..693cd95 100644
> >--- a/drivers/cpuidle/Makefile
> >+++ b/drivers/cpuidle/Makefile
> >@@ -13,3 +13,6 @@ obj-$(CONFIG_ARM_KIRKWOOD_CPUIDLE)	+=3D cpuidle-ki=
rkwood.o
> >  obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+=3D cpuidle-zynq.o
> >  obj-$(CONFIG_ARM_U8500_CPUIDLE)         +=3D cpuidle-ux500.o
> >  obj-$(CONFIG_ARM_AT91_CPUIDLE)          +=3D cpuidle-at91.o
> >+
> >+# MIPS SoC drivers
> >+obj-$(CONFIG_MIPS_CPS_CPUIDLE)		+=3D cpuidle-mips-cps.o
> >diff --git a/drivers/cpuidle/cpuidle-mips-cps.c b/drivers/cpuidle/cp=
uidle-mips-cps.c
> >new file mode 100644
> >index 0000000..a78bfb4
> >--- /dev/null
> >+++ b/drivers/cpuidle/cpuidle-mips-cps.c
> >@@ -0,0 +1,545 @@
> >+/*
> >+ * Copyright (C) 2013 Imagination Technologies
> >+ * Author: Paul Burton <paul.burton@imgtec.com>
> >+ *
> >+ * This program is free software; you can redistribute it and/or mo=
dify it
> >+ * under the terms of the GNU General Public License as published b=
y the
> >+ * Free Software Foundation;  either version 2 of the  License, or =
(at your
> >+ * option) any later version.
> >+ */
> >+
> >+#include <linux/cpuidle.h>
> >+#include <linux/init.h>
> >+#include <linux/kconfig.h>
> >+#include <linux/slab.h>
> >+
> >+#include <asm/cacheflush.h>
> >+#include <asm/cacheops.h>
> >+#include <asm/idle.h>
> >+#include <asm/mips-cm.h>
> >+#include <asm/mipsmtregs.h>
> >+#include <asm/uasm.h>
>=20
> The convention is to not include headers from arch. These headers sho=
uldn't
> appear in this driver.
>=20

Without accessing those headers I can't really implement anything usefu=
l
- entering these idle states by their nature involves architecture
specifics. Would you rather the bulk of the driver is implemented under
arch/mips & the code in drivers/cpuidle simply calls elsewhere to do th=
e
real work?

> >+/*
> >+ * The CM & CPC can only handle coherence & power control on a per-=
core basis,
> >+ * thus in an MT system the VPEs within each core are coupled and c=
an only
> >+ * enter or exit states requiring CM or CPC assistance in unison.
> >+ */
> >+#ifdef CONFIG_MIPS_MT
> >+# define coupled_coherence cpu_has_mipsmt
> >+#else
> >+# define coupled_coherence 0
> >+#endif
> >+
> >+/*
> >+ * cps_nc_entry_fn - type of a generated non-coherent state entry f=
unction
> >+ * @vpe_mask: a bitmap of online coupled VPEs, excluding this one
> >+ * @online: the count of online coupled VPEs (weight of vpe_mask + =
1)
> >+ *
> >+ * The code entering & exiting non-coherent states is generated at =
runtime
> >+ * using uasm, in order to ensure that the compiler cannot insert a=
 stray
> >+ * memory access at an unfortunate time and to allow the generation=
 of optimal
> >+ * core-specific code particularly for cache routines. If coupled_c=
oherence
> >+ * is non-zero, returns the number of VPEs that were in the wait st=
ate at the
> >+ * point this VPE left it. Returns garbage if coupled_coherence is =
zero.
> >+ */
> >+typedef unsigned (*cps_nc_entry_fn)(unsigned vpe_mask, unsigned onl=
ine);
> >+
> >+/*
> >+ * The entry point of the generated non-coherent wait entry/exit fu=
nction.
> >+ * Actually per-core rather than per-CPU.
> >+ */
> >+static DEFINE_PER_CPU_READ_MOSTLY(cps_nc_entry_fn, ncwait_asm_enter=
);
> >+
> >+/*
> >+ * Indicates the number of coupled VPEs ready to operate in a non-c=
oherent
> >+ * state. Actually per-core rather than per-CPU.
> >+ */
> >+static DEFINE_PER_CPU_ALIGNED(u32, nc_ready_count);
> >+
> >+/* A somewhat arbitrary number of labels & relocs for uasm */
> >+static struct uasm_label labels[32] __initdata;
> >+static struct uasm_reloc relocs[32] __initdata;
> >+
> >+/* CPU dependant sync types */
> >+static unsigned stype_intervention;
> >+static unsigned stype_memory;
> >+static unsigned stype_ordering;
> >+
> >+enum mips_reg {
> >+	zero, at, v0, v1, a0, a1, a2, a3,
> >+	t0, t1, t2, t3, t4, t5, t6, t7,
> >+	s0, s1, s2, s3, s4, s5, s6, s7,
> >+	t8, t9, k0, k1, gp, sp, fp, ra,
> >+};
> >+
> >+static int cps_ncwait_enter(struct cpuidle_device *dev,
> >+			    struct cpuidle_driver *drv, int index)
> >+{
> >+	unsigned core =3D cpu_data[dev->cpu].core;
> >+	unsigned online, first_cpu, num_left;
> >+	cpumask_var_t coupled_mask, vpe_mask;
> >+
> >+	if (!alloc_cpumask_var(&coupled_mask, GFP_KERNEL))
> >+		return -ENOMEM;
> >+
> >+	if (!alloc_cpumask_var(&vpe_mask, GFP_KERNEL)) {
> >+		free_cpumask_var(coupled_mask);
> >+		return -ENOMEM;
> >+	}
>=20
> You can't do that in this function where the local irqs are disabled.=
 IMO,
> if you set CONFIG_CPUMASK_OFFSTACK and CONFIG_DEBUG_ATOMIC_SLEEP, you=
 should
> see a kernel warning.

Right you are, it should either use GFP_ATOMIC or just not handle the
off-stack case (which isn't currently used).

>=20
> >+	/* Calculate which coupled CPUs (VPEs) are online */
> >+#ifdef CONFIG_MIPS_MT
> >+	cpumask_and(coupled_mask, cpu_online_mask, &dev->coupled_cpus);
> >+	first_cpu =3D cpumask_first(coupled_mask);
> >+	online =3D cpumask_weight(coupled_mask);
> >+	cpumask_clear_cpu(dev->cpu, coupled_mask);
> >+	cpumask_shift_right(vpe_mask, coupled_mask,
> >+			    cpumask_first(&dev->coupled_cpus));
>=20
> What is the purpose of this computation ?

If you read through the code generated in cps_gen_entry_code, the
vpe_mask is used to indicate the VPEs within the current core which are
both online & not the VPE currently running the code.

>=20
> >+#else
> >+	cpumask_clear(coupled_mask);
> >+	cpumask_clear(vpe_mask);
> >+	first_cpu =3D dev->cpu;
> >+	online =3D 1;
> >+#endif
>=20
> first_cpu is not used.

Right you are. It's used in further work-in-progress patches but I'll
remove it from this one.

>=20
> >+	/*
> >+	 * Run the generated entry code. Note that we assume the number of=
 VPEs
> >+	 * within this core does not exceed the width in bits of a long. S=
ince
> >+	 * MVPConf0.PVPE is 4 bits wide this seems like a safe assumption.
> >+	 */
> >+	num_left =3D per_cpu(ncwait_asm_enter, core)(vpe_mask->bits[0], on=
line);
> >+
> >+	/*
> >+	 * If this VPE is the first to leave the non-coherent wait state t=
hen
> >+	 * it needs to wake up any coupled VPEs still running their wait
> >+	 * instruction so that they return to cpuidle,
>=20
> Why is it needed ? Can't the other cpus stay idle ?

Not with the current cpuidle code. Please see the end of
cpuidle_enter_state_coupled in drivers/cpuidle/coupled.c. The code wait=
s
for all coupled CPUs to exit the idle state before any of them proceed.
Whilst I suppose it would be possible to modify cpuidle to not require
that, it would leave you with inaccurate residence statistics mentioned
below.

>=20
> >       * which can then complete
> >+	 * coordination between the coupled VPEs & provide the governor wi=
th
> >+	 * a chance to reflect on the length of time the VPEs were in the
> >+	 * idle state.
> >+	 */
> >+	if (coupled_coherence && (num_left =3D=3D online))
> >+		arch_send_call_function_ipi_mask(coupled_mask);
>=20
> Except there is no choice due to hardware limitations, I don't think =
this is
> valid.

By nature when one CPU (VPE) within a core leaves a non-coherent state
the rest do too, because as I mentioned coherence is a property of the
core not of individual VPEs. It would be possible to leave the other
VPEs idle if we didn't differentiate between the coherent & non-coheren=
t
wait states, but again not with cpuidle as it is today (due to the
waiting for all CPUs at the end of cpuidle_enter_state_coupled).

>=20
> >+	free_cpumask_var(vpe_mask);
> >+	free_cpumask_var(coupled_mask);
> >+	return index;
> >+}
> >+
> >+static struct cpuidle_driver cps_driver =3D {
> >+	.name			=3D "cpc_cpuidle",
> >+	.owner			=3D THIS_MODULE,
> >+	.states =3D {
> >+		MIPS_CPUIDLE_WAIT_STATE,
> >+		{
> >+			.enter	=3D cps_ncwait_enter,
> >+			.exit_latency		=3D 200,
> >+			.target_residency	=3D 450,
> >+			.flags	=3D CPUIDLE_FLAG_TIME_VALID,
> >+			.name	=3D "nc-wait",
> >+			.desc	=3D "non-coherent MIPS wait",
> >+		},
> >+	},
> >+	.state_count		=3D 2,
> >+	.safe_state_index	=3D 0,
> >+};
>=20
>=20
>=20
> >+static void __init cps_gen_cache_routine(u32 **pp, struct uasm_labe=
l **pl,
> >+					 struct uasm_reloc **pr,
> >+					 const struct cache_desc *cache,
> >+					 unsigned op, int lbl)
> >+{
> >+	unsigned cache_size =3D cache->ways << cache->waybit;
> >+	unsigned i;
> >+	const unsigned unroll_lines =3D 32;
> >+
> >+	/* If the cache isn't present this function has it easy */
> >+	if (cache->flags & MIPS_CACHE_NOT_PRESENT)
> >+		return;
> >+
> >+	/* Load base address */
> >+	UASM_i_LA(pp, t0, (long)CKSEG0);
> >+
> >+	/* Calculate end address */
> >+	if (cache_size < 0x8000)
> >+		uasm_i_addiu(pp, t1, t0, cache_size);
> >+	else
> >+		UASM_i_LA(pp, t1, (long)(CKSEG0 + cache_size));
> >+
> >+	/* Start of cache op loop */
> >+	uasm_build_label(pl, *pp, lbl);
> >+
> >+	/* Generate the cache ops */
> >+	for (i =3D 0; i < unroll_lines; i++)
> >+		uasm_i_cache(pp, op, i * cache->linesz, t0);
> >+
> >+	/* Update the base address */
> >+	uasm_i_addiu(pp, t0, t0, unroll_lines * cache->linesz);
> >+
> >+	/* Loop if we haven't reached the end address yet */
> >+	uasm_il_bne(pp, pr, t0, t1, lbl);
> >+	uasm_i_nop(pp);
> >+}
> >+
> >+static void * __init cps_gen_entry_code(struct cpuidle_device *dev)
> >+{
> >+	unsigned core =3D cpu_data[dev->cpu].core;
> >+	struct uasm_label *l =3D labels;
> >+	struct uasm_reloc *r =3D relocs;
> >+	u32 *buf, *p;
> >+	const unsigned r_vpemask =3D a0;
> >+	const unsigned r_online =3D a1;
> >+	const unsigned r_pcount =3D t6;
> >+	const unsigned r_pcohctl =3D t7;
> >+	const unsigned max_instrs =3D 256;
> >+	enum {
> >+		lbl_incready =3D 1,
> >+		lbl_lastvpe,
> >+		lbl_vpehalt_loop,
> >+		lbl_vpehalt_poll,
> >+		lbl_vpehalt_next,
> >+		lbl_disable_coherence,
> >+		lbl_invicache,
> >+		lbl_flushdcache,
> >+		lbl_vpeactivate_loop,
> >+		lbl_vpeactivate_next,
> >+		lbl_wait,
> >+		lbl_decready,
> >+	};
> >+
> >+	/* Allocate a buffer to hold the generated code */
> >+	p =3D buf =3D kcalloc(max_instrs, sizeof(u32), GFP_KERNEL);
> >+	if (!buf)
> >+		return NULL;
> >+
> >+	/* Clear labels & relocs ready for (re)use */
> >+	memset(labels, 0, sizeof(labels));
> >+	memset(relocs, 0, sizeof(relocs));
> >+
> >+	/*
> >+	 * Load address of the CM GCR_CL_COHERENCE register. This is done =
early
> >+	 * because it's needed in both the enable & disable coherence step=
s but
> >+	 * in the coupled case the enable step will only run on one VPE.
> >+	 */
> >+	UASM_i_LA(&p, r_pcohctl, (long)addr_gcr_cl_coherence());
> >+
> >+	if (coupled_coherence) {
> >+		/* Load address of nc_ready_count */
> >+		UASM_i_LA(&p, r_pcount, (long)&per_cpu(nc_ready_count, core));
> >+
> >+		/* Increment nc_ready_count */
> >+		uasm_build_label(&l, p, lbl_incready);
> >+		uasm_i_sync(&p, stype_ordering);
> >+		uasm_i_ll(&p, t1, 0, r_pcount);
> >+		uasm_i_addiu(&p, t2, t1, 1);
> >+		uasm_i_sc(&p, t2, 0, r_pcount);
> >+		uasm_il_beqz(&p, &r, t2, lbl_incready);
> >+		uasm_i_addiu(&p, t1, t1, 1);
> >+
> >+		/*
> >+		 * If this is the last VPE to become ready for non-coherence
> >+		 * then it should branch below.
> >+		 */
> >+		uasm_il_beq(&p, &r, t1, r_online, lbl_lastvpe);
> >+		uasm_i_nop(&p);
> >+
> >+		/*
> >+		 * Otherwise this is not the last VPE to become ready for
> >+		 * non-coherence. It needs to wait until coherence has been
> >+		 * disabled before executing a wait instruction, otherwise it
> >+		 * may return from wait quickly & re-enable coherence causing
> >+		 * a race with the VPE disabling coherence. It can't simply
> >+		 * poll the CPC sequencer for a non-coherent state as that
> >+		 * would race with any other VPE which may spot the
> >+		 * non-coherent state, run wait, return quickly & re-enable
> >+		 * coherence before this VPE ever saw the non-coherent state.
> >+		 * Instead this VPE will halt its TC such that it ceases to
> >+		 * execute for the moment.
> >+		 */
> >+		uasm_i_addiu(&p, t0, zero, TCHALT_H);
> >+		uasm_i_mtc0(&p, t0, 2, 4); /* TCHalt */
> >+
> >+		/* instruction_hazard(), to ensure the TC halts */
> >+		UASM_i_LA(&p, t0, (long)p + 12);
> >+		uasm_i_jr_hb(&p, t0);
> >+		uasm_i_nop(&p);
> >+
> >+		/*
> >+		 * The VPE which disables coherence will then clear the halt
> >+		 * bit for this VPE's TC once coherence has been disabled and
> >+		 * it can safely proceed to execute the wait instruction.
> >+		 */
> >+		uasm_il_b(&p, &r, lbl_wait);
> >+		uasm_i_nop(&p);
> >+
> >+		/*
> >+		 * The last VPE to increment nc_ready_count will continue from
> >+		 * here and must spin until all other VPEs within the core have
> >+		 * been halted, at which point it can be sure that it is safe
> >+		 * to disable coherence.
> >+		 *
> >+		 *   t0: number of VPEs left to handle
> >+		 *   t1: (shifted) mask of online VPEs
> >+		 *   t2: current VPE index
> >+		 */
> >+		uasm_build_label(&l, p, lbl_lastvpe);
> >+		uasm_i_addiu(&p, t0, r_online, -1);
> >+		uasm_il_beqz(&p, &r, t0, lbl_disable_coherence);
> >+		uasm_i_move(&p, t1, r_vpemask);
> >+		uasm_i_move(&p, t2, zero);
> >+
> >+		/*
> >+		 * Now loop through all VPEs within the core checking whether
> >+		 * they are online & not this VPE, which can be determined by
> >+		 * checking the vpe_mask argument. If a VPE is offline or is
> >+		 * this VPE, skip it.
> >+		 */
> >+		uasm_build_label(&l, p, lbl_vpehalt_loop);
> >+		uasm_i_andi(&p, t3, t1, 1);
> >+		uasm_il_beqz(&p, &r, t3, lbl_vpehalt_next);
> >+
> >+		/* settc(vpe) */
> >+		uasm_i_mfc0(&p, t3, 1, 1); /* VPEControl */
> >+		uasm_i_ins(&p, t3, t2, 0, 8);
> >+		uasm_i_mtc0(&p, t3, 1, 1); /* VPEControl */
> >+		uasm_i_ehb(&p);
> >+
> >+		/*
> >+		 * It's very likely that the VPE has already halted itself
> >+		 * by now, but there's theoretically a chance that it may not
> >+		 * have. Wait until the VPE's TC is halted.
> >+		 */
> >+		uasm_build_label(&l, p, lbl_vpehalt_poll);
> >+		uasm_i_mftc0(&p, t3, 2, 4); /* TCHalt */
> >+		uasm_il_beqz(&p, &r, t3, lbl_vpehalt_poll);
> >+		uasm_i_nop(&p);
> >+
> >+		/* Decrement the count of VPEs to be handled */
> >+		uasm_i_addiu(&p, t0, t0, -1);
> >+
> >+		/* Proceed to the next VPE, if there is one */
> >+		uasm_build_label(&l, p, lbl_vpehalt_next);
> >+		uasm_i_srl(&p, t1, t1, 1);
> >+		uasm_il_bnez(&p, &r, t0, lbl_vpehalt_loop);
> >+		uasm_i_addiu(&p, t2, t2, 1);
> >+	}
> >+
> >+	/*
> >+	 * This is the point of no return - this VPE will now proceed to
> >+	 * disable coherence. At this point we *must* be sure that no othe=
r
> >+	 * VPE within the core will interfere with the L1 dcache.
> >+	 */
> >+	uasm_build_label(&l, p, lbl_disable_coherence);
> >+
> >+	/* Completion barrier */
> >+	uasm_i_sync(&p, stype_memory);
> >+
> >+	/* Invalidate the L1 icache */
> >+	cps_gen_cache_routine(&p, &l, &r, &cpu_data[dev->cpu].icache,
> >+			      Index_Invalidate_I, lbl_invicache);
> >+
> >+	/* Writeback & invalidate the L1 dcache */
> >+	cps_gen_cache_routine(&p, &l, &r, &cpu_data[dev->cpu].dcache,
> >+			      Index_Writeback_Inv_D, lbl_flushdcache);
> >+
> >+	/*
> >+	 * Disable all but self interventions. The load from COHCTL is def=
ined
> >+	 * by the interAptiv & proAptiv SUMs as ensuring that the operatio=
n
> >+	 * resulting from the preceeding store is complete.
> >+	 */
> >+	uasm_i_addiu(&p, t0, zero, 1 << cpu_data[dev->cpu].core);
> >+	uasm_i_sw(&p, t0, 0, r_pcohctl);
> >+	uasm_i_lw(&p, t0, 0, r_pcohctl);
> >+
> >+	/* Sync to ensure previous interventions are complete */
> >+	uasm_i_sync(&p, stype_intervention);
> >+
> >+	/* Disable coherence */
> >+	uasm_i_sw(&p, zero, 0, r_pcohctl);
> >+	uasm_i_lw(&p, t0, 0, r_pcohctl);
> >+
> >+	if (coupled_coherence) {
> >+		/*
> >+		 * Now that coherence is disabled it is safe for all VPEs to
> >+		 * proceed with executing their wait instruction, so this VPE
> >+		 * will go ahead and clear the halt bit of the TCs associated
> >+		 * with all other online VPEs within the core. Start by
> >+		 * initialising variables used throughout the loop, and
> >+		 * skipping the loop entirely if there are no VPEs to handle.
> >+		 *
> >+		 *   t0: number of VPEs left to handle
> >+		 *   t1: (shifted) mask of online VPEs
> >+		 *   t2: current VPE index
> >+		 */
> >+		uasm_i_addiu(&p, t0, r_online, -1);
> >+		uasm_il_beqz(&p, &r, t0, lbl_wait);
> >+		uasm_i_move(&p, t1, r_vpemask);
> >+		uasm_i_move(&p, t2, zero);
> >+
> >+		/*
> >+		 * Now loop through all VPEs within the core checking whether
> >+		 * they are online & not this VPE, which can be determined by
> >+		 * checking the vpe_mask argument. If a VPE is offline or is
> >+		 * this VPE, skip it.
> >+		 */
> >+		uasm_build_label(&l, p, lbl_vpeactivate_loop);
> >+		uasm_i_andi(&p, t3, t1, 1);
> >+		uasm_il_beqz(&p, &r, t3, lbl_vpeactivate_next);
> >+
> >+		/* settc(vpe) */
> >+		uasm_i_mfc0(&p, t3, 1, 1); /* VPEControl */
> >+		uasm_i_ins(&p, t3, t2, 0, 8);
> >+		uasm_i_mtc0(&p, t3, 1, 1); /* VPEControl */
> >+		uasm_i_ehb(&p);
> >+
> >+		/* Clear TCHalt */
> >+		uasm_i_mttc0(&p, zero, 2, 4); /* TCHalt */
> >+
> >+		/* Decrement the count of VPEs to be handled */
> >+		uasm_i_addiu(&p, t0, t0, -1);
> >+
> >+		/* Proceed to the next VPE, if there is one */
> >+		uasm_build_label(&l, p, lbl_vpeactivate_next);
> >+		uasm_i_srl(&p, t1, t1, 1);
> >+		uasm_il_bnez(&p, &r, t0, lbl_vpeactivate_loop);
> >+		uasm_i_addiu(&p, t2, t2, 1);
> >+	}
> >+
> >+	/* Now perform our wait */
> >+	uasm_build_label(&l, p, lbl_wait);
> >+	uasm_i_wait(&p, 0);
> >+
> >+	/*
> >+	 * Re-enable coherence. Note that all coupled VPEs will run this, =
the
> >+	 * first will actually re-enable coherence & the rest will just be
> >+	 * performing a rather unusual nop.
> >+	 */
> >+	uasm_i_addiu(&p, t0, zero, CM_GCR_Cx_COHERENCE_COHDOMAINEN_MSK);
> >+	uasm_i_sw(&p, t0, 0, r_pcohctl);
> >+	uasm_i_lw(&p, t0, 0, r_pcohctl);
> >+
> >+	/* Ordering barrier */
> >+	uasm_i_sync(&p, stype_ordering);
> >+
> >+	if (coupled_coherence) {
> >+		/* Decrement nc_ready_count */
> >+		uasm_build_label(&l, p, lbl_decready);
> >+		uasm_i_sync(&p, stype_ordering);
> >+		uasm_i_ll(&p, t1, 0, r_pcount);
> >+		uasm_i_addiu(&p, t2, t1, -1);
> >+		uasm_i_sc(&p, t2, 0, r_pcount);
> >+		uasm_il_beqz(&p, &r, t2, lbl_decready);
> >+		uasm_i_move(&p, v0, t1);
> >+	}
> >+
> >+	/* The core is coherent, time to return to C code */
> >+	uasm_i_jr(&p, ra);
> >+	uasm_i_nop(&p);
> >+
> >+	/* Ensure the code didn't exceed the resources allocated for it */
> >+	BUG_ON((p - buf) > max_instrs);
> >+	BUG_ON((l - labels) > ARRAY_SIZE(labels));
> >+	BUG_ON((r - relocs) > ARRAY_SIZE(relocs));
> >+
> >+	/* Patch branch offsets */
> >+	uasm_resolve_relocs(relocs, labels);
> >+
> >+	/* Flush the icache */
> >+	local_flush_icache_range((unsigned long)buf, (unsigned long)p);
> >+
> >+	return buf;
> >+}
>=20
> The two functions above should go to somewhere in arch/mips.

Well I guess they can, but they only make any sense in the context of
cpuidle which is why I implemented them here.

>=20
> >+
> >+static void __init cps_cpuidle_unregister(void)
> >+{
> >+	int cpu;
> >+	struct cpuidle_device *device;
> >+	cps_nc_entry_fn *fn;
> >+
> >+	for_each_possible_cpu(cpu) {
> >+		device =3D &per_cpu(cpuidle_dev, cpu);
> >+		cpuidle_unregister_device(device);
> >+
> >+		/* Free entry code */
> >+		fn =3D &per_cpu(ncwait_asm_enter, cpu_data[cpu].core);
> >+		kfree(*fn);
> >+		*fn =3D NULL;
> >+	}
> >+
> >+	cpuidle_unregister_driver(&cps_driver);
> >+}
> >+
> >+static int __init cps_cpuidle_init(void)
> >+{
> >+	int err, cpu, core, i;
> >+	struct cpuidle_device *device;
> >+	void *core_entry;
> >+
> >+	/*
> >+	 * If interrupts were enabled whilst running the wait instruction =
then
> >+	 * the VPE may end up processing interrupts whilst non-coherent.
> >+	 */
> >+	if (cpu_wait !=3D r4k_wait_irqoff) {
> >+		pr_warn("cpuidle-cps requires that masked interrupts restart the =
CPU pipeline following a wait\n");
> >+		return -ENODEV;
> >+	}
> >+
> >+	/* Detect appropriate sync types for the system */
> >+	switch (current_cpu_data.cputype) {
> >+	case CPU_INTERAPTIV:
> >+	case CPU_PROAPTIV:
> >+		stype_intervention =3D 0x2;
> >+		stype_memory =3D 0x3;
> >+		stype_ordering =3D 0x10;
> >+		break;
> >+
> >+	default:
> >+		pr_warn("cpuidle-cps using heavyweight sync 0\n");
> >+	}
> >+
> >+	/*
> >+	 * Set the coupled flag on the appropriate states if this system
> >+	 * requires it.
> >+	 */
> >+	if (coupled_coherence)
> >+		for (i =3D 1; i < cps_driver.state_count; i++)
> >+			cps_driver.states[i].flags |=3D CPUIDLE_FLAG_COUPLED;
>=20
> I am not sure CPUIDLE_FLAG_COUPLED is the solution for this driver. I=
IUC,
> with the IPI above and the wakeup sync with the couple states, this d=
river
> is waking up everybody instead of sleeping as much as possible.
>=20
> I would recommend to have a look at a different approach, like the on=
e used
> for cpuidle-ux500.c.

Ok it looks like that just counts & performs work only on the last
online CPU to run the code. As before that could work but only by
disregarding any differentiation between coherent & non-coherent wait
states at levels above the driver.

Paul

>=20
> >+
> >+	err =3D cpuidle_register_driver(&cps_driver);
> >+	if (err) {
> >+		pr_err("Failed to register CPS cpuidle driver\n");
> >+		return err;
> >+	}
> >+
> >+	for_each_possible_cpu(cpu) {
> >+		core =3D cpu_data[cpu].core;
> >+		device =3D &per_cpu(cpuidle_dev, cpu);
> >+		device->cpu =3D cpu;
> >+#ifdef CONFIG_MIPS_MT
> >+		cpumask_copy(&device->coupled_cpus, &cpu_sibling_map[cpu]);
> >+#endif
> >+		if (!per_cpu(ncwait_asm_enter, core)) {
> >+			core_entry =3D cps_gen_entry_code(device);
> >+			if (!core_entry) {
> >+				pr_err("Failed to generate core %u entry\n",
> >+				       core);
> >+				err =3D -ENOMEM;
> >+				goto err_out;
> >+			}
> >+			per_cpu(ncwait_asm_enter, core) =3D core_entry;
> >+		}
> >+
> >+		err =3D cpuidle_register_device(device);
> >+		if (err) {
> >+			pr_err("Failed to register CPU%d cpuidle device\n",
> >+			       cpu);
> >+			goto err_out;
> >+		}
> >+	}
> >+
> >+	return 0;
> >+err_out:
> >+	cps_cpuidle_unregister();
> >+	return err;
> >+}
> >+device_initcall(cps_cpuidle_init);
> >
>=20
>=20
> --=20
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software f=
or ARM SoCs
>=20
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>=20
