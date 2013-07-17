From: Sudeep.KarkadaNagesha@arm.com
Subject: [RFC PATCH v2 03/15] ARM: DT/kernel: define ARM specific arch_match_cpu_phys_id
Date: Wed, 17 Jul 2013 15:06:12 +0100
Message-ID: <1374069984-20567-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: cpufreq-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Russell King <linux@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
List-Id: linux-pm@vger.kernel.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

OF/DT core library now provides architecture specific hook to match the
logical cpu index with the corresponding physical identifier. Most of the
cpu DT node parsing and initialisation is contained in devtree.c. So it's
better to define ARM specific arch_match_cpu_phys_id there.

This mainly helps to avoid replication of the code doing CPU node parsing
and physical(MPIDR) to logical mapping.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 arch/arm/kernel/devtree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 5859c8b..5a36f32 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -169,6 +169,11 @@ void __init arm_dt_init_cpu_maps(void)
 =09}
 }
=20
+int arch_match_cpu_phys_id(int cpu, u64 phys_id)
+{
+=09return (phys_id & MPIDR_HWID_BITMASK) =3D=3D cpu_logical_map(cpu);
+}
+
 /**
  * setup_machine_fdt - Machine setup when an dtb was passed to the kernel
  * @dt_phys: physical address of dt blob
--=20
1.8.1.2


