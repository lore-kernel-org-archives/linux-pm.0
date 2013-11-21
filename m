From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH RFC v3 11/12] arm64: kernel: add PM build infrastructure
Date: Thu, 21 Nov 2013 11:24:18 +0000
Message-ID: <1385033059-25896-12-git-send-email-lorenzo.pieralisi@arm.com>
References: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:33286 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119Ab3KULZB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2013 06:25:01 -0500
In-Reply-To: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Martin <dave.martin@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, Kumar Sankaran <ksankaran@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Christoffer Dall <christoffer.dall@linaro.org>

This patch adds the required makefile and kconfig entries to enable PM
for arm64 systems.

The kernel relies on the cpu_{suspend}/{resume} infrastructure to
properly save the context for a CPU and put it to sleep, hence this
patch adds the config option required to enable cpu_{suspend}/{resume}
API.

In order to rely on the CPU PM implementation for saving and restoring
of CPU subsystems like GIC and PMU, the arch Kconfig must be also
augmented to select the CONFIG_CPU_PM option when SUSPEND or CPU_IDLE
kernel implementations are selected.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/Kconfig         | 13 +++++++++++++
 arch/arm64/kernel/Makefile |  1 +
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1d222b1..0d78e92 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -12,6 +12,7 @@ config ARM64
 =09select BUILDTIME_EXTABLE_SORT
 =09select CLONE_BACKWARDS
 =09select COMMON_CLK
+=09select CPU_PM if (SUSPEND || CPU_IDLE)
 =09select GENERIC_CLOCKEVENTS
 =09select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 =09select GENERIC_IOMAP
@@ -278,6 +279,18 @@ config SYSVIPC_COMPAT
=20
 endmenu
=20
+menu "Power management options"
+
+source "kernel/power/Kconfig"
+
+config ARCH_SUSPEND_POSSIBLE
+=09def_bool y
+
+config ARM64_CPU_SUSPEND
+=09def_bool PM_SLEEP
+
+endmenu
+
 source "net/Kconfig"
=20
 source "drivers/Kconfig"
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 5ba2fd4..1cd339d 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -18,6 +18,7 @@ arm64-obj-$(CONFIG_SMP)=09=09=09+=3D smp.o smp_spin_table=
.o
 arm64-obj-$(CONFIG_HW_PERF_EVENTS)=09+=3D perf_event.o
 arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)+=3D hw_breakpoint.o
 arm64-obj-$(CONFIG_EARLY_PRINTK)=09+=3D early_printk.o
+arm64-obj-$(CONFIG_ARM64_CPU_SUSPEND)=09+=3D sleep.o suspend.o
=20
 obj-y=09=09=09=09=09+=3D $(arm64-obj-y) vdso/
 obj-m=09=09=09=09=09+=3D $(arm64-obj-m)
--=20
1.8.4


