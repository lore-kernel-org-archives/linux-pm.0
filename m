From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v2 05/13] arm64: add CPU PM infrastructure selection
Date: Mon, 14 Oct 2013 12:03:02 +0100
Message-ID: <1381748590-14279-6-git-send-email-lorenzo.pieralisi@arm.com>
References: <1381748590-14279-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:57005 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754652Ab3JNLCd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2013 07:02:33 -0400
In-Reply-To: <1381748590-14279-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Martin <dave.martin@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, Kumar Sankaran <ksankaran@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

In order to rely on the CPU PM implementation for saving and restoring
of CPU subsystems like GIC and PMU, the arch Kconfig must be augmented
to select the CONFIG_CPU_PM option when SUSPEND or CPU_IDLE kernel
implementation are selected. This patch adds the appropriate selection
entry in the arm64 Kconfig file.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9d0c8dd..bcf88e4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -10,6 +10,7 @@ config ARM64
 =09select BUILDTIME_EXTABLE_SORT
 =09select CLONE_BACKWARDS
 =09select COMMON_CLK
+=09select CPU_PM if (SUSPEND || CPU_IDLE)
 =09select GENERIC_CLOCKEVENTS
 =09select GENERIC_IOMAP
 =09select GENERIC_IRQ_PROBE
--=20
1.8.4


