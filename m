From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH RFC v3 01/12] arm64: kernel: add MPIDR_EL1 accessors macros
Date: Thu, 21 Nov 2013 11:24:08 +0000
Message-ID: <1385033059-25896-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:60985 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753416Ab3KULYw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2013 06:24:52 -0500
In-Reply-To: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Martin <dave.martin@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, Kumar Sankaran <ksankaran@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Christoffer Dall <christoffer.dall@linaro.org>

In order to simplify access to different affinity levels within the
MPIDR_EL1 register values, this patch implements some preprocessor
macros that allow to retrieve the MPIDR_EL1 affinity level value according
to the level passed as input parameter.

Reviewed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/include/asm/cputype.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cput=
ype.h
index 5fe138e..e371936 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -30,6 +30,16 @@
=20
 #define MPIDR_HWID_BITMASK=090xff00ffffff
=20
+#define MPIDR_LEVEL_BITS_SHIFT=093
+#define MPIDR_LEVEL_BITS=09(1 << MPIDR_LEVEL_BITS_SHIFT)
+#define MPIDR_LEVEL_MASK=09((1 << MPIDR_LEVEL_BITS) - 1)
+
+#define MPIDR_LEVEL_SHIFT(level) \
+=09(((1 << level) >> 1) << MPIDR_LEVEL_BITS_SHIFT)
+
+#define MPIDR_AFFINITY_LEVEL(mpidr, level) \
+=09((mpidr >> MPIDR_LEVEL_SHIFT(level)) & MPIDR_LEVEL_MASK)
+
 #define read_cpuid(reg) ({=09=09=09=09=09=09\
 =09u64 __val;=09=09=09=09=09=09=09\
 =09asm("mrs=09%0, " reg : "=3Dr" (__val));=09=09=09\
--=20
1.8.4


