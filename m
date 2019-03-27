From: Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 4/7] psci: Add cpu_poke ops to support core poking
Date: Wed, 27 Mar 2019 13:21:13 +0000
Message-ID: <1553692845-20983-5-git-send-email-abel.vesa@nxp.com>
References: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Fabio Estevam <fabio.estevam@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, Aisheng Dong <aisheng.dong@nxp.com>
Cc: dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Abel Vesa <abel.vesa@nxp.com>
List-Id: linux-pm@vger.kernel.org

There can be platforms that need a dedicated work to be done
in TF-A before the specified core can be woken up through an IPI.
Allow those platforms to call into the TF-A to do that work
by making use of the cpu_poke operation.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/include/asm/cpu_ops.h | 1 +
 arch/arm64/kernel/psci.c         | 1 +
 drivers/firmware/psci.c          | 6 ++++++
 include/linux/psci.h             | 1 +
 include/uapi/linux/psci.h        | 2 ++
 5 files changed, 11 insertions(+)

diff --git a/arch/arm64/include/asm/cpu_ops.h b/arch/arm64/include/asm/cpu_=
ops.h
index 8f03446..913afef 100644
--- a/arch/arm64/include/asm/cpu_ops.h
+++ b/arch/arm64/include/asm/cpu_ops.h
@@ -60,6 +60,7 @@ struct cpu_operations {
 #ifdef CONFIG_CPU_IDLE
 	int		(*cpu_init_idle)(unsigned int);
 	int		(*cpu_suspend)(unsigned long);
+	int		(*cpu_poke)(unsigned int);
 #endif
 };
=20
diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 8cdaf25..53227eb 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -115,6 +115,7 @@ const struct cpu_operations cpu_psci_ops =3D {
 #ifdef CONFIG_CPU_IDLE
 	.cpu_init_idle	=3D psci_cpu_init_idle,
 	.cpu_suspend	=3D psci_cpu_suspend_enter,
+	.cpu_poke	=3D psci_cpu_suspend_exit,
 #endif
 	.cpu_init	=3D cpu_psci_cpu_init,
 	.cpu_prepare	=3D cpu_psci_cpu_prepare,
diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index c80ec1d..282bc47 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -73,6 +73,7 @@ enum psci_function {
 	PSCI_FN_CPU_ON,
 	PSCI_FN_CPU_OFF,
 	PSCI_FN_MIGRATE,
+	PSCI_FN_CPU_POKE,
 	PSCI_FN_MAX,
 };
=20
@@ -424,6 +425,11 @@ int psci_cpu_suspend_enter(unsigned long index)
 	return ret;
 }
=20
+int psci_cpu_suspend_exit(unsigned int index)
+{
+	return invoke_psci_fn(PSCI_0_2_FN_CPU_POKE, index, 0, 0);
+}
+
 /* ARM specific CPU idle operations */
 #ifdef CONFIG_ARM
 static const struct cpuidle_ops psci_cpuidle_ops __initconst =3D {
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 8b1b3b5..d863733 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -24,6 +24,7 @@ bool psci_tos_resident_on(int cpu);
=20
 int psci_cpu_init_idle(unsigned int cpu);
 int psci_cpu_suspend_enter(unsigned long index);
+int psci_cpu_suspend_exit(unsigned int index);
=20
 enum psci_conduit {
 	PSCI_CONDUIT_NONE,
diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
index b3bcabe..19e7481 100644
--- a/include/uapi/linux/psci.h
+++ b/include/uapi/linux/psci.h
@@ -40,8 +40,10 @@
 #define PSCI_0_2_FN_MIGRATE_INFO_UP_CPU		PSCI_0_2_FN(7)
 #define PSCI_0_2_FN_SYSTEM_OFF			PSCI_0_2_FN(8)
 #define PSCI_0_2_FN_SYSTEM_RESET		PSCI_0_2_FN(9)
+#define PSCI_0_2_FN_CPU_POKE			PSCI_0_2_FN(11)
=20
 #define PSCI_0_2_FN64_CPU_SUSPEND		PSCI_0_2_FN64(1)
+#define PSCI_0_2_FN64_CPU_POKE			PSCI_0_2_FN64(11)
 #define PSCI_0_2_FN64_CPU_ON			PSCI_0_2_FN64(3)
 #define PSCI_0_2_FN64_AFFINITY_INFO		PSCI_0_2_FN64(4)
 #define PSCI_0_2_FN64_MIGRATE			PSCI_0_2_FN64(5)
--=20
2.7.4
