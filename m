From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 8/9] ARM: zynq: Remove hotplug.c
Date: Thu, 21 Aug 2014 03:32:22 +0200
Message-ID: <53F54C26.5010000@linaro.org>
References: <1408567315-28479-1-git-send-email-soren.brinkmann@xilinx.com> <1408567315-28479-9-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408567315-28479-9-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Russell King <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 08/20/2014 10:41 PM, Soren Brinkmann wrote:
> The hotplug code contains only a single function, which is an SMP
> function. Move that to platsmp.c where all other SMP runctions reside=
=2E
> That allows removing hotplug.c and declaring the cpu_die function
> static.
>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>   arch/arm/mach-zynq/Makefile  |  1 -
>   arch/arm/mach-zynq/common.h  |  3 +--
>   arch/arm/mach-zynq/hotplug.c | 17 -----------------
>   arch/arm/mach-zynq/platsmp.c | 18 ++++++++++++++++++
>   4 files changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm/mach-zynq/Makefile b/arch/arm/mach-zynq/Makefil=
e
> index 820dff6e1eba..c85fb3f7d5cd 100644
> --- a/arch/arm/mach-zynq/Makefile
> +++ b/arch/arm/mach-zynq/Makefile
> @@ -6,5 +6,4 @@
>   obj-y				:=3D common.o slcr.o pm.o
>   CFLAGS_REMOVE_hotplug.o		=3D-march=3Darmv6k
>   CFLAGS_hotplug.o 		=3D-Wa,-march=3Darmv7-a -mcpu=3Dcortex-a9
> -obj-$(CONFIG_HOTPLUG_CPU)	+=3D hotplug.o
>   obj-$(CONFIG_SMP)		+=3D headsmp.o platsmp.o
> diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/mach-zynq/common.=
h
> index c0773e87e83c..e6bb12c50a23 100644
> --- a/arch/arm/mach-zynq/common.h
> +++ b/arch/arm/mach-zynq/common.h
> @@ -39,8 +39,7 @@ extern struct smp_operations zynq_smp_ops __initdat=
a;
>
>   extern void __iomem *zynq_scu_base;
>
> -/* Hotplug */
> -extern void zynq_platform_cpu_die(unsigned int cpu);
> +int zynq_pm_late_init(void);
>
>   int zynq_pm_late_init(void);
>
> diff --git a/arch/arm/mach-zynq/hotplug.c b/arch/arm/mach-zynq/hotplu=
g.c
> index fe44a05677e2..b685c89f11e4 100644
> --- a/arch/arm/mach-zynq/hotplug.c
> +++ b/arch/arm/mach-zynq/hotplug.c
> @@ -12,20 +12,3 @@
>    */
>   #include <asm/proc-fns.h>
>
> -/*
> - * platform-specific code to shutdown a CPU
> - *
> - * Called with IRQs disabled
> - */
> -void zynq_platform_cpu_die(unsigned int cpu)
> -{
> -	zynq_slcr_cpu_state_write(cpu, true);
> -
> -	/*
> -	 * there is no power-control hardware on this platform, so all
> -	 * we can do is put the core into WFI; this is safe as the calling
> -	 * code will have already disabled interrupts
> -	 */
> -	for (;;)
> -		cpu_do_idle();
> -}
> diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsm=
p.c
> index f77f7ca4c45b..04e578718aa2 100644
> --- a/arch/arm/mach-zynq/platsmp.c
> +++ b/arch/arm/mach-zynq/platsmp.c
> @@ -132,6 +132,24 @@ static int zynq_cpu_kill(unsigned cpu)
>   	zynq_slcr_cpu_stop(cpu);
>   	return 1;
>   }
> +
> +/*
> + * platform-specific code to shutdown a CPU
> + *
> + * Called with IRQs disabled
> + */
> +static void zynq_platform_cpu_die(unsigned int cpu)
> +{
> +	zynq_slcr_cpu_state_write(cpu, true);
> +
> +	/*
> +	 * there is no power-control hardware on this platform, so all
> +	 * we can do is put the core into WFI; this is safe as the calling
> +	 * code will have already disabled interrupts
> +	 */
> +	for (;;)
> +		cpu_do_idle();

IIUC, the cpu_do_idle() will flush the L1 cache and then call the WFI.=20
It makes sense if we are about to power down the core. So I am wonderin=
g=20
if we can just call wfi() instead.

> +}
>   #endif
>
>   struct smp_operations zynq_smp_ops __initdata =3D {
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
