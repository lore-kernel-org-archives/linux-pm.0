From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH RFC v3 09/12] arm64: enable generic clockevent broadcast
Date: Thu, 21 Nov 2013 11:24:16 +0000
Message-ID: <1385033059-25896-10-git-send-email-lorenzo.pieralisi@arm.com>
References: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:33191 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab3KULZA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2013 06:25:00 -0500
In-Reply-To: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Martin <dave.martin@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, Kumar Sankaran <ksankaran@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Christoffer Dall <christoffer.dall@linaro.org>

On platforms with power management capabilities, timers that are shut
down when a CPU enters deep C-states must be emulated using an always-on
timer and a timer IPI to relay the timer IRQ to target CPUs on an SMP
system.

This patch enables the generic clockevents broadcast infrastructure for
arm64, by providing the required Kconfig entries and adding the timer
IPI infrastructure.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/Kconfig               |  2 ++
 arch/arm64/include/asm/hardirq.h |  2 +-
 arch/arm64/kernel/smp.c          | 17 +++++++++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 88c8b6c1..1d222b1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2,6 +2,7 @@ config ARM64
 =09def_bool y
 =09select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 =09select ARCH_USE_CMPXCHG_LOCKREF
+=09select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 =09select ARCH_WANT_OPTIONAL_GPIOLIB
 =09select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 =09select ARCH_WANT_FRAME_POINTERS
@@ -12,6 +13,7 @@ config ARM64
 =09select CLONE_BACKWARDS
 =09select COMMON_CLK
 =09select GENERIC_CLOCKEVENTS
+=09select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 =09select GENERIC_IOMAP
 =09select GENERIC_IRQ_PROBE
 =09select GENERIC_IRQ_SHOW
diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hard=
irq.h
index 990c051..ae4801d 100644
--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -20,7 +20,7 @@
 #include <linux/threads.h>
 #include <asm/irq.h>
=20
-#define NR_IPI=094
+#define NR_IPI=095
=20
 typedef struct {
 =09unsigned int __softirq_pending;
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index a5aeefa..56b68d7 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -61,6 +61,7 @@ enum ipi_msg_type {
 =09IPI_CALL_FUNC,
 =09IPI_CALL_FUNC_SINGLE,
 =09IPI_CPU_STOP,
+=09IPI_TIMER,
 };
=20
 /*
@@ -446,6 +447,7 @@ static const char *ipi_types[NR_IPI] =3D {
 =09S(IPI_CALL_FUNC, "Function call interrupts"),
 =09S(IPI_CALL_FUNC_SINGLE, "Single function call interrupts"),
 =09S(IPI_CPU_STOP, "CPU stop interrupts"),
+=09S(IPI_TIMER, "Timer broadcast interrupts"),
 };
=20
 void show_ipi_list(struct seq_file *p, int prec)
@@ -531,6 +533,14 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 =09=09irq_exit();
 =09=09break;
=20
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
+=09case IPI_TIMER:
+=09=09irq_enter();
+=09=09tick_receive_broadcast();
+=09=09irq_exit();
+=09=09break;
+#endif
+
 =09default:
 =09=09pr_crit("CPU%u: Unknown IPI message 0x%x\n", cpu, ipinr);
 =09=09break;
@@ -543,6 +553,13 @@ void smp_send_reschedule(int cpu)
 =09smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
 }
=20
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
+void tick_broadcast(const struct cpumask *mask)
+{
+=09smp_cross_call(mask, IPI_TIMER);
+}
+#endif
+
 void smp_send_stop(void)
 {
 =09unsigned long timeout;
--=20
1.8.4


