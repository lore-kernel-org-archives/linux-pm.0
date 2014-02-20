From: Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH 08/10] MIPS: support use of cpuidle
Date: Thu, 20 Feb 2014 09:57:32 +0000
Message-ID: <20140220095732.GO25765@pburton-linux.le.imgtec.org>
References: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com>
 <1389794137-11361-9-git-send-email-paul.burton@imgtec.com>
 <5305C24A.1070006@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <5305C24A.1070006@linaro.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-mips@linux-mips.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 20, 2014 at 09:52:26AM +0100, Daniel Lezcano wrote:
> On 01/15/2014 02:55 PM, Paul Burton wrote:
> >This patch lays the groundwork for MIPS platforms to make use of the
> >cpuidle framework. The arch_cpu_idle function simply calls cpuidle &
> >falls back to the regular cpu_wait path if cpuidle should fail (eg. =
if
> >it's not selected or no driver is registered). A generic cpuidle sta=
te
> >for the wait instruction is introduced, intended to ease use of the =
wait
> >instruction from cpuidle drivers and reduce code duplication.
>=20
> Hi,
>=20
> What is the status of this patchset ? Still need comments ?
>=20
> Thanks
>   -- Daniel
>=20

It's present in Ralf's current mips-for-linux-next branch, and in
linux-next from next-20140210 up to todays next-20140220. So I presume
barring any problems it should make it into 3.15.

Thanks,
    Paul

> >
> >Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> >Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> >Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> >Cc: linux-pm@vger.kernel.org
> >---
> >  arch/mips/Kconfig            |  2 ++
> >  arch/mips/include/asm/idle.h | 14 ++++++++++++++
> >  arch/mips/kernel/idle.c      | 20 +++++++++++++++++++-
> >  3 files changed, 35 insertions(+), 1 deletion(-)
> >
> >diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> >index 5bc27c0..95f2f11 100644
> >--- a/arch/mips/Kconfig
> >+++ b/arch/mips/Kconfig
> >@@ -1838,6 +1838,8 @@ config CPU_R4K_CACHE_TLB
> >  	bool
> >  	default y if !(CPU_R3000 || CPU_R8000 || CPU_SB1 || CPU_TX39XX ||=
 CPU_CAVIUM_OCTEON)
> >
> >+source "drivers/cpuidle/Kconfig"
> >+
> >  choice
> >  	prompt "MIPS MT options"
> >
> >diff --git a/arch/mips/include/asm/idle.h b/arch/mips/include/asm/id=
le.h
> >index d192158..d9f932d 100644
> >--- a/arch/mips/include/asm/idle.h
> >+++ b/arch/mips/include/asm/idle.h
> >@@ -1,6 +1,7 @@
> >  #ifndef __ASM_IDLE_H
> >  #define __ASM_IDLE_H
> >
> >+#include <linux/cpuidle.h>
> >  #include <linux/linkage.h>
> >
> >  extern void (*cpu_wait)(void);
> >@@ -20,4 +21,17 @@ static inline int address_is_in_r4k_wait_irqoff(u=
nsigned long addr)
> >  	       addr < (unsigned long)__pastwait;
> >  }
> >
> >+extern int mips_cpuidle_wait_enter(struct cpuidle_device *dev,
> >+				   struct cpuidle_driver *drv, int index);
> >+
> >+#define MIPS_CPUIDLE_WAIT_STATE {\
> >+	.enter			=3D mips_cpuidle_wait_enter,\
> >+	.exit_latency		=3D 1,\
> >+	.target_residency	=3D 1,\
> >+	.power_usage		=3D UINT_MAX,\
> >+	.flags			=3D CPUIDLE_FLAG_TIME_VALID,\
> >+	.name			=3D "wait",\
> >+	.desc			=3D "MIPS wait",\
> >+}
> >+
> >  #endif /* __ASM_IDLE_H  */
> >diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
> >index 3553243..64e91e4 100644
> >--- a/arch/mips/kernel/idle.c
> >+++ b/arch/mips/kernel/idle.c
> >@@ -11,6 +11,7 @@
> >   * as published by the Free Software Foundation; either version
> >   * 2 of the License, or (at your option) any later version.
> >   */
> >+#include <linux/cpuidle.h>
> >  #include <linux/export.h>
> >  #include <linux/init.h>
> >  #include <linux/irqflags.h>
> >@@ -239,7 +240,7 @@ static void smtc_idle_hook(void)
> >  #endif
> >  }
> >
> >-void arch_cpu_idle(void)
> >+static void mips_cpu_idle(void)
> >  {
> >  	smtc_idle_hook();
> >  	if (cpu_wait)
> >@@ -247,3 +248,20 @@ void arch_cpu_idle(void)
> >  	else
> >  		local_irq_enable();
> >  }
> >+
> >+void arch_cpu_idle(void)
> >+{
> >+	if (cpuidle_idle_call())
> >+		mips_cpu_idle();
> >+}
> >+
> >+#ifdef CONFIG_CPU_IDLE
> >+
> >+int mips_cpuidle_wait_enter(struct cpuidle_device *dev,
> >+			    struct cpuidle_driver *drv, int index)
> >+{
> >+	mips_cpu_idle();
> >+	return index;
> >+}
> >+
> >+#endif
> >
>=20
>=20
> --=20
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software f=
or ARM SoCs
>=20
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>=20
