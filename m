From: Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 6/7] cpuidle-arm: Add arm64 wake helper for cpu_poke op
Date: Wed, 27 Mar 2019 13:21:16 +0000
Message-ID: <1553692845-20983-7-git-send-email-abel.vesa@nxp.com>
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

When the arm_poke_idle_state gets called, the poking
cpu_ops of the current core gets called, passing on the
the index of the core to be poked.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/include/asm/cpuidle.h | 6 ++++++
 arch/arm64/kernel/cpuidle.c      | 8 ++++++++
 drivers/cpuidle/cpuidle-arm.c    | 2 +-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpuidle.h b/arch/arm64/include/asm/cpui=
dle.h
index 3c5ddb4..e637d4d 100644
--- a/arch/arm64/include/asm/cpuidle.h
+++ b/arch/arm64/include/asm/cpuidle.h
@@ -7,6 +7,7 @@
 #ifdef CONFIG_CPU_IDLE
 extern int arm_cpuidle_init(unsigned int cpu);
 extern int arm_cpuidle_suspend(int index);
+extern int arm_cpuidle_wake(int index);
 #else
 static inline int arm_cpuidle_init(unsigned int cpu)
 {
@@ -17,5 +18,10 @@ static inline int arm_cpuidle_suspend(int index)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int arm_cpuidle_wake(int index)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 #endif
diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
index f2d1381..af00955 100644
--- a/arch/arm64/kernel/cpuidle.c
+++ b/arch/arm64/kernel/cpuidle.c
@@ -43,6 +43,14 @@ int arm_cpuidle_suspend(int index)
 	return cpu_ops[cpu]->cpu_suspend(index);
 }
=20
+int arm_cpuidle_wake(int index)
+{
+	int cpu =3D smp_processor_id();
+
+	return cpu_ops[cpu]->cpu_poke(index);
+}
+
+
 #ifdef CONFIG_ACPI
=20
 #include <acpi/processor.h>
diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 76ee7ac..d5d3eef 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -48,7 +48,7 @@ static int arm_enter_idle_state(struct cpuidle_device *de=
v,
 static int arm_poke_idle_state(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv, int cpu)
 {
-	return 0;
+	return arm_cpuidle_wake(cpu);
 }
=20
 static struct cpuidle_driver arm_idle_driver __initdata =3D {
--=20
2.7.4
