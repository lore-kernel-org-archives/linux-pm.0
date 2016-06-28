From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 1/2] ARM: tango: add HOTPLUG_CPU support
Date: Tue, 28 Jun 2016 13:30:24 +0100
Message-ID: <57726DE0.8090308@arm.com>
References: <57726597.8030501@sigmadesigns.com>
 <577266AD.8000006@sigmadesigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46795 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753007AbcF1Mad (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 28 Jun 2016 08:30:33 -0400
In-Reply-To: <577266AD.8000006@sigmadesigns.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, arm-soc <arm@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Sebastian Frias <sf84@laposte.net>, Mason <slash.tmp@free.fr>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On 28/06/16 12:59, Marc Gonzalez wrote:
> cpu_die() and cpu_kill() are implemented in firmware.
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
>  arch/arm/mach-tango/platsmp.c | 30 ++++++++++++++++++++++++++++++
>  arch/arm/mach-tango/smc.h     |  4 +++-
>  2 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-tango/platsmp.c b/arch/arm/mach-tango/platsmp.c
> index a21f55e000d2..a24b9b1d0b1a 100644
> --- a/arch/arm/mach-tango/platsmp.c
> +++ b/arch/arm/mach-tango/platsmp.c
> @@ -1,3 +1,4 @@
> +#include <linux/delay.h>
>  #include <linux/init.h>
>  #include <linux/smp.h>
>  #include "smc.h"
> @@ -9,8 +10,37 @@ static int tango_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_HOTPLUG_CPU
> +/*
> + * cpu_kill() and cpu_die() run concurrently on different cores.
> + * Firmware will only "kill" a core once it has properly "died".
> + * Keep trying to kill a core until the operation succeeds, but
> + * sleep between tries to give the core time to die.
> + */
> +static int tango_cpu_kill(unsigned int cpu)
> +{
> +	do {
> +		msleep(10);
> +	} while (tango_aux_core_kill(cpu) != 0);

Does the firmware guarantee that this will succeed (or at least report
success) in finite time, regardless of how messed up the system might
be? I'd imagine this should probably have either a timeout or a comment
clarifying why it doesn't need a timeout.

Robin.

> +
> +	return 1;
> +}
> +
> +static void tango_cpu_die(unsigned int cpu)
> +{
> +	do {
> +		cpu_relax();
> +	} while (tango_aux_core_die(cpu) != 0);
> +}
> +#else
> +#define tango_cpu_kill	NULL
> +#define tango_cpu_die	NULL
> +#endif
> +
>  static const struct smp_operations tango_smp_ops __initconst = {
>  	.smp_boot_secondary	= tango_boot_secondary,
> +	.cpu_kill		= tango_cpu_kill,
> +	.cpu_die		= tango_cpu_die,
>  };
>  
>  CPU_METHOD_OF_DECLARE(tango4_smp, "sigma,tango4-smp", &tango_smp_ops);
> diff --git a/arch/arm/mach-tango/smc.h b/arch/arm/mach-tango/smc.h
> index 7a4af35cc390..3d31f984f44c 100644
> --- a/arch/arm/mach-tango/smc.h
> +++ b/arch/arm/mach-tango/smc.h
> @@ -2,4 +2,6 @@ extern int tango_smc(unsigned int val, unsigned int service);
>  
>  #define tango_set_l2_control(val)	tango_smc(val, 0x102)
>  #define tango_start_aux_core(val)	tango_smc(val, 0x104)
> -#define tango_set_aux_boot_addr(val)	tango_smc((unsigned int)val, 0x105)
> +#define tango_set_aux_boot_addr(val)	tango_smc(val, 0x105)
> +#define tango_aux_core_die(val)		tango_smc(val, 0x121)
> +#define tango_aux_core_kill(val)	tango_smc(val, 0x122)
> 

