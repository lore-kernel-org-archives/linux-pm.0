From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [RFC PATCH 01/14] arm64: kernel: add MPIDR_EL1 accessors macros
Date: Wed, 28 Aug 2013 12:35:53 +0100
Message-ID: <1377689766-17642-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:38411 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755029Ab3H1LgE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Aug 2013 07:36:04 -0400
In-Reply-To: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Martin <dave.martin@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, Kumar Sankaran <ksankaran@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>

In order to simplify access to different affinity levels within the
MPIDR_EL1 register values, this patch implements some preprocessor
macros that allow to retrieve the MPIDR_EL1 affinity level value according
to the level passed as input parameter.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/include/asm/cputype.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cput=
ype.h
index 5fe138e..2c9e295 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -30,6 +30,16 @@
=20
 #define MPIDR_HWID_BITMASK=090xff00ffffff
=20
+#define MPIDR_LEVEL_BITS 8
+#define MPIDR_LEVEL_MASK ((1 << MPIDR_LEVEL_BITS) - 1)
+
+#define MPIDR_LEVEL_SHIFT(level) ({=09=09=09=09=09\
+=09(level =3D=3D 3) ? 32 : MPIDR_LEVEL_BITS * level;=09=09=09\
+})
+
+#define MPIDR_AFFINITY_LEVEL(mpidr, level)=09=09=09=09\
+=09((mpidr >> MPIDR_LEVEL_SHIFT(level)) & MPIDR_LEVEL_MASK)=09\
+
 #define read_cpuid(reg) ({=09=09=09=09=09=09\
 =09u64 __val;=09=09=09=09=09=09=09\
 =09asm("mrs=09%0, " reg : "=3Dr" (__val));=09=09=09\
--=20
1.8.3.4


