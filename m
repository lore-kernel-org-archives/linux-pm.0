From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH 8/9] ARM: zynq: Remove hotplug.c
Date: Thu, 21 Aug 2014 16:38:26 -0700
Message-ID: <347fcf72-b3a5-4212-87b9-0cc92d1a962c@BN1AFFO11FD035.protection.gbl>
References: <1408567315-28479-1-git-send-email-soren.brinkmann@xilinx.com>
 <1408567315-28479-9-git-send-email-soren.brinkmann@xilinx.com>
 <53F54C26.5010000@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53F54C26.5010000@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>, Russell King <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2014-08-21 at 03:32AM +0200, Daniel Lezcano wrote:
> On 08/20/2014 10:41 PM, Soren Brinkmann wrote:
> >The hotplug code contains only a single function, which is an SMP
> >function. Move that to platsmp.c where all other SMP runctions resid=
e.
> >That allows removing hotplug.c and declaring the cpu_die function
> >static.
> >
> >Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> >---
> >  arch/arm/mach-zynq/Makefile  |  1 -
> >  arch/arm/mach-zynq/common.h  |  3 +--
> >  arch/arm/mach-zynq/hotplug.c | 17 -----------------
> >  arch/arm/mach-zynq/platsmp.c | 18 ++++++++++++++++++
> >  4 files changed, 19 insertions(+), 20 deletions(-)
> >
> >diff --git a/arch/arm/mach-zynq/Makefile b/arch/arm/mach-zynq/Makefi=
le
> >index 820dff6e1eba..c85fb3f7d5cd 100644
> >--- a/arch/arm/mach-zynq/Makefile
> >+++ b/arch/arm/mach-zynq/Makefile
> >@@ -6,5 +6,4 @@
> >  obj-y				:=3D common.o slcr.o pm.o
> >  CFLAGS_REMOVE_hotplug.o		=3D-march=3Darmv6k
> >  CFLAGS_hotplug.o 		=3D-Wa,-march=3Darmv7-a -mcpu=3Dcortex-a9
> >-obj-$(CONFIG_HOTPLUG_CPU)	+=3D hotplug.o
> >  obj-$(CONFIG_SMP)		+=3D headsmp.o platsmp.o
> >diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/mach-zynq/common=
=2Eh
> >index c0773e87e83c..e6bb12c50a23 100644
> >--- a/arch/arm/mach-zynq/common.h
> >+++ b/arch/arm/mach-zynq/common.h
> >@@ -39,8 +39,7 @@ extern struct smp_operations zynq_smp_ops __initda=
ta;
> >
> >  extern void __iomem *zynq_scu_base;
> >
> >-/* Hotplug */
> >-extern void zynq_platform_cpu_die(unsigned int cpu);
> >+int zynq_pm_late_init(void);
> >
> >  int zynq_pm_late_init(void);
> >
> >diff --git a/arch/arm/mach-zynq/hotplug.c b/arch/arm/mach-zynq/hotpl=
ug.c
> >index fe44a05677e2..b685c89f11e4 100644
> >--- a/arch/arm/mach-zynq/hotplug.c
> >+++ b/arch/arm/mach-zynq/hotplug.c
> >@@ -12,20 +12,3 @@
> >   */
> >  #include <asm/proc-fns.h>
> >
> >-/*
> >- * platform-specific code to shutdown a CPU
> >- *
> >- * Called with IRQs disabled
> >- */
> >-void zynq_platform_cpu_die(unsigned int cpu)
> >-{
> >-	zynq_slcr_cpu_state_write(cpu, true);
> >-
> >-	/*
> >-	 * there is no power-control hardware on this platform, so all
> >-	 * we can do is put the core into WFI; this is safe as the calling
> >-	 * code will have already disabled interrupts
> >-	 */
> >-	for (;;)
> >-		cpu_do_idle();
> >-}
> >diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/plats=
mp.c
> >index f77f7ca4c45b..04e578718aa2 100644
> >--- a/arch/arm/mach-zynq/platsmp.c
> >+++ b/arch/arm/mach-zynq/platsmp.c
> >@@ -132,6 +132,24 @@ static int zynq_cpu_kill(unsigned cpu)
> >  	zynq_slcr_cpu_stop(cpu);
> >  	return 1;
> >  }
> >+
> >+/*
> >+ * platform-specific code to shutdown a CPU
> >+ *
> >+ * Called with IRQs disabled
> >+ */
> >+static void zynq_platform_cpu_die(unsigned int cpu)
> >+{
> >+	zynq_slcr_cpu_state_write(cpu, true);
> >+
> >+	/*
> >+	 * there is no power-control hardware on this platform, so all
> >+	 * we can do is put the core into WFI; this is safe as the calling
> >+	 * code will have already disabled interrupts
> >+	 */
> >+	for (;;)
> >+		cpu_do_idle();
>=20
> IIUC, the cpu_do_idle() will flush the L1 cache and then call the
> WFI. It makes sense if we are about to power down the core. So I am
> wondering if we can just call wfi() instead.

I'm not sure - it's not that trivial to trace that through the sources.
But I think cpu_do_idle ends up in cpu_v7_do_idle which is just:
	ENTRY(cpu_v7_do_idle)                                                 =
          =20
	        dsb                                     @ WFI may enter a low-=
power mode=20
	        wfi                                                           =
          =20
	        ret     lr                                                    =
          =20
	ENDPROC(cpu_v7_do_idle)

I think that is what we want here.

	Thanks,
	S=C3=B6ren
