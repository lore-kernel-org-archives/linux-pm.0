From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [RFC PATCH 12/14] arm64: kernel: add cpu_{suspend}/{resume} build infrastructure
Date: Wed, 28 Aug 2013 12:36:04 +0100
Message-ID: <1377689766-17642-13-git-send-email-lorenzo.pieralisi@arm.com>
References: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:39124 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755081Ab3H1LgO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Aug 2013 07:36:14 -0400
In-Reply-To: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Martin <dave.martin@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, Kumar Sankaran <ksankaran@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>

To enable the suspend infrastructure for the ARM64 kernel the
corresponding Kconfig and Makefile entries must be updated.

This patch adds a menu entry for power management options and
entries to enable newly added suspend/resume implementation.

Makefile changes add appropriate entries to include corresponding
files in the kernel image.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/Kconfig         | 12 ++++++++++++
 arch/arm64/kernel/Makefile |  1 +
 2 files changed, 13 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5855519..827d95e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -272,6 +272,18 @@ config SYSVIPC_COMPAT
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
+config ARM_CPU_SUSPEND
+=09def_bool y
+
+endmenu
+
 source "net/Kconfig"
=20
 source "drivers/Kconfig"
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 7b4b564..ad63448 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -18,6 +18,7 @@ arm64-obj-$(CONFIG_SMP)=09=09=09+=3D smp.o smp_spin_table=
.o smp_psci.o
 arm64-obj-$(CONFIG_HW_PERF_EVENTS)=09+=3D perf_event.o
 arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)+=3D hw_breakpoint.o
 arm64-obj-$(CONFIG_EARLY_PRINTK)=09+=3D early_printk.o
+arm64-obj-$(CONFIG_ARM_CPU_SUSPEND)=09+=3D sleep.o suspend.o
=20
 obj-y=09=09=09=09=09+=3D $(arm64-obj-y) vdso/
 obj-m=09=09=09=09=09+=3D $(arm64-obj-m)
--=20
1.8.3.4


