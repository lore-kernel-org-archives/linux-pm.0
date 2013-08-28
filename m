From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [RFC PATCH 02/14] arm64: kernel: build MPIDR_EL1 hash function data structure
Date: Wed, 28 Aug 2013 12:35:54 +0100
Message-ID: <1377689766-17642-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:38520 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754849Ab3H1LgF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Aug 2013 07:36:05 -0400
In-Reply-To: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Martin <dave.martin@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, Kumar Sankaran <ksankaran@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>

On ARM64 SMP systems, cores are identified by their MPIDR_EL1 register.
The MPIDR_EL1 guidelines in the ARM ARM do not provide strict enforcement o=
f
MPIDR_EL1 layout, only recommendations that, if followed, split the MPIDR_E=
L1
on ARM 64 bit platforms in four affinity levels. In multi-cluster
systems like big.LITTLE, if the affinity guidelines are followed, the
MPIDR_EL1 can not be considered a linear index. This means that the
association between logical CPU in the kernel and the HW CPU identifier
becomes somewhat more complicated requiring methods like hashing to
associate a given MPIDR_EL1 to a CPU logical index, in order for the look-u=
p
to be carried out in an efficient and scalable way.

This patch provides a function in the kernel that starting from the
cpu_logical_map, implement collision-free hashing of MPIDR_EL1 values by
checking all significative bits of MPIDR_EL1 affinity level bitfields.
The hashing can then be carried out through bits shifting and ORing; the
resulting hash algorithm is a collision-free though not minimal hash that c=
an
be executed with few assembly instructions. The mpidr_el1 is filtered throu=
gh a
mpidr mask that is built by checking all bits that toggle in the set of
MPIDR_EL1s corresponding to possible CPUs. Bits that do not toggle do not
carry information so they do not contribute to the resulting hash.

Pseudo code:

/* check all bits that toggle, so they are required */
for (i =3D 1, mpidr_el1_mask =3D 0; i < num_possible_cpus(); i++)
=09mpidr_el1_mask |=3D (cpu_logical_map(i) ^ cpu_logical_map(0));

/*
 * Build shifts to be applied to aff0, aff1, aff2, aff3 values to hash the
 * mpidr_el1
 * fls() returns the last bit set in a word, 0 if none
 * ffs() returns the first bit set in a word, 0 if none
 */
fs0 =3D mpidr_el1_mask[7:0] ? ffs(mpidr_el1_mask[7:0]) - 1 : 0;
fs1 =3D mpidr_el1_mask[15:8] ? ffs(mpidr_el1_mask[15:8]) - 1 : 0;
fs2 =3D mpidr_el1_mask[23:16] ? ffs(mpidr_el1_mask[23:16]) - 1 : 0;
fs3 =3D mpidr_el1_mask[39:32] ? ffs(mpidr_el1_mask[39:32]) - 1 : 0;
ls0 =3D fls(mpidr_el1_mask[7:0]);
ls1 =3D fls(mpidr_el1_mask[15:8]);
ls2 =3D fls(mpidr_el1_mask[23:16]);
ls3 =3D fls(mpidr_el1_mask[39:32]);
bits0 =3D ls0 - fs0;
bits1 =3D ls1 - fs1;
bits2 =3D ls2 - fs2;
bits3 =3D ls3 - fs3;
aff0_shift =3D fs0;
aff1_shift =3D 8 + fs1 - bits0;
aff2_shift =3D 16 + fs2 - (bits0 + bits1);
aff3_shift =3D 32 + fs3 - (bits0 + bits1 + bits2);
u32 hash(u64 mpidr_el1) {
=09u32 l0, l1, l2;
=09u64 mpidr_el1_masked =3D mpidr_el1 & mpidr_el1_mask;
=09l0 =3D mpidr_el1_masked & 0xff;
=09l1 =3D mpidr_el1_masked & 0xff00;
=09l2 =3D mpidr_el1_masked & 0xff0000;
=09l3 =3D mpidr_el1_masked & 0xff00000000;
=09return (l0 >> aff0_shift | l1 >> aff1_shift | l2 >> aff2_shift |
=09=09l3 >> aff3_shift);
}

The hashing algorithm relies on the inherent properties set in the ARM ARM
recommendations for the MPIDR_EL1. Exotic configurations, where for instanc=
e
the MPIDR_EL1 values at a given affinity level have large holes, can end up
requiring big hash tables since the compression of values that can be achie=
ved
through shifting is somewhat crippled when holes are present. Kernel warns =
if
the number of buckets of the resulting hash table exceeds the number of
possible CPUs by a factor of 4, which is a symptom of a very sparse HW
MPIDR_EL1 configuration.

The hash algorithm is quite simple and can easily be implemented in assembl=
y
code, to be used in code paths where the kernel virtual address space is
not set-up (ie cpu_resume) and instruction and data fetches are strongly
ordered so code must be compact and must carry out few data accesses.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/include/asm/smp_plat.h | 13 ++++++++
 arch/arm64/kernel/asm-offsets.c   |  5 +++
 arch/arm64/kernel/setup.c         | 70 +++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 88 insertions(+)

diff --git a/arch/arm64/include/asm/smp_plat.h b/arch/arm64/include/asm/smp=
_plat.h
index ed43a0d..59e2823 100644
--- a/arch/arm64/include/asm/smp_plat.h
+++ b/arch/arm64/include/asm/smp_plat.h
@@ -21,6 +21,19 @@
=20
 #include <asm/types.h>
=20
+struct mpidr_hash {
+=09u64=09mask;
+=09u32=09shift_aff[4];
+=09u32=09bits;
+};
+
+extern struct mpidr_hash mpidr_hash;
+
+static inline u32 mpidr_hash_size(void)
+{
+=09return 1 << mpidr_hash.bits;
+}
+
 /*
  * Logical CPU mapping.
  */
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offset=
s.c
index 666e231..f300a13 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -25,6 +25,7 @@
 #include <asm/thread_info.h>
 #include <asm/memory.h>
 #include <asm/cputable.h>
+#include <asm/smp_plat.h>
 #include <asm/vdso_datapage.h>
 #include <linux/kbuild.h>
=20
@@ -138,5 +139,9 @@ int main(void)
   DEFINE(KVM_VTTBR,=09=09offsetof(struct kvm, arch.vttbr));
   DEFINE(KVM_VGIC_VCTRL,=09offsetof(struct kvm, arch.vgic.vctrl_base));
 #endif
+#ifdef CONFIG_ARM_CPU_SUSPEND
+  DEFINE(MPIDR_HASH_MASK,=09offsetof(struct mpidr_hash, mask));
+  DEFINE(MPIDR_HASH_SHIFTS,=09offsetof(struct mpidr_hash, shift_aff));
+#endif
   return 0;
 }
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index add6ea6..3601186 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -97,6 +97,75 @@ void __init early_print(const char *str, ...)
 =09printk("%s", buf);
 }
=20
+struct mpidr_hash mpidr_hash;
+#ifdef CONFIG_SMP
+/**
+ * smp_build_mpidr_hash - Pre-compute shifts required at each affinity
+ *=09=09=09  level in order to build a linear index from an
+ *=09=09=09  MPIDR value. Resulting algorithm is a collision
+ *=09=09=09  free hash carried out through shifting and ORing
+ */
+static void __init smp_build_mpidr_hash(void)
+{
+=09u32 i, affinity, fs[4], bits[4], ls;
+=09u64 mask =3D 0;
+=09/*
+=09 * Pre-scan the list of MPIDRS and filter out bits that do
+=09 * not contribute to affinity levels, ie they never toggle.
+=09 */
+=09for_each_possible_cpu(i)
+=09=09mask |=3D (cpu_logical_map(i) ^ cpu_logical_map(0));
+=09pr_debug("mask of set bits %#llx\n", mask);
+=09/*
+=09 * Find and stash the last and first bit set at all affinity levels to
+=09 * check how many bits are required to represent them.
+=09 */
+=09for (i =3D 0; i < 4; i++) {
+=09=09affinity =3D MPIDR_AFFINITY_LEVEL(mask, i);
+=09=09/*
+=09=09 * Find the MSB bit and LSB bits position
+=09=09 * to determine how many bits are required
+=09=09 * to express the affinity level.
+=09=09 */
+=09=09ls =3D fls(affinity);
+=09=09fs[i] =3D affinity ? ffs(affinity) - 1 : 0;
+=09=09bits[i] =3D ls - fs[i];
+=09}
+=09/*
+=09 * An index can be created from the MPIDR_EL1 by isolating the
+=09 * significant bits at each affinity level and by shifting
+=09 * them in order to compress the 32 bits values space to a
+=09 * compressed set of values. This is equivalent to hashing
+=09 * the MPIDR_EL1 through shifting and ORing. It is a collision free
+=09 * hash though not minimal since some levels might contain a number
+=09 * of CPUs that is not an exact power of 2 and their bit
+=09 * representation might contain holes, eg MPIDR_EL1[7:0] =3D {0x2, 0x80=
}.
+=09 */
+=09mpidr_hash.shift_aff[0] =3D MPIDR_LEVEL_SHIFT(0) + fs[0];
+=09mpidr_hash.shift_aff[1] =3D MPIDR_LEVEL_SHIFT(1) + fs[1] - bits[0];
+=09mpidr_hash.shift_aff[2] =3D MPIDR_LEVEL_SHIFT(2) + fs[2] -
+=09=09=09=09=09=09(bits[1] + bits[0]);
+=09mpidr_hash.shift_aff[3] =3D MPIDR_LEVEL_SHIFT(3) +
+=09=09=09=09  fs[3] - (bits[2] + bits[1] + bits[0]);
+=09mpidr_hash.mask =3D mask;
+=09mpidr_hash.bits =3D bits[3] + bits[2] + bits[1] + bits[0];
+=09pr_debug("MPIDR hash: aff0[%u] aff1[%u] aff2[%u] aff3[%u] mask[%#llx] b=
its[%u]\n",
+=09=09mpidr_hash.shift_aff[0],
+=09=09mpidr_hash.shift_aff[1],
+=09=09mpidr_hash.shift_aff[2],
+=09=09mpidr_hash.shift_aff[3],
+=09=09mpidr_hash.mask,
+=09=09mpidr_hash.bits);
+=09/*
+=09 * 4x is an arbitrary value used to warn on a hash table much bigger
+=09 * than expected on most systems.
+=09 */
+=09if (mpidr_hash_size() > 4 * num_possible_cpus())
+=09=09pr_warn("Large number of MPIDR hash buckets detected\n");
+=09__flush_dcache_area(&mpidr_hash, sizeof(struct mpidr_hash));
+}
+#endif
+
 static void __init setup_processor(void)
 {
 =09struct cpu_info *cpu_info;
@@ -271,6 +340,7 @@ void __init setup_arch(char **cmdline_p)
 =09cpu_logical_map(0) =3D read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
 #ifdef CONFIG_SMP
 =09smp_init_cpus();
+=09smp_build_mpidr_hash();
 #endif
=20
 #ifdef CONFIG_VT
--=20
1.8.3.4


