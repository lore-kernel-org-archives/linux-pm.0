From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] PPC: powernv: remove redundant cpuidle_idle_call()
Date: Thu, 06 Feb 2014 21:26:43 +0530
Message-ID: <52F3B0BB.50401@linux.vnet.ibm.com>
References: <1391696188-14540-1-git-send-email-nicolas.pitre@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:41097 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbaBFQAa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 6 Feb 2014 11:00:30 -0500
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Fri, 7 Feb 2014 02:00:28 +1000
In-Reply-To: <1391696188-14540-1-git-send-email-nicolas.pitre@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org

On 02/06/2014 07:46 PM, Nicolas Pitre wrote:
> The core idle loop now takes care of it.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>  arch/powerpc/platforms/powernv/setup.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
> index 21166f65c9..a932feb290 100644
> --- a/arch/powerpc/platforms/powernv/setup.c
> +++ b/arch/powerpc/platforms/powernv/setup.c
> @@ -26,7 +26,6 @@
>  #include <linux/of_fdt.h>
>  #include <linux/interrupt.h>
>  #include <linux/bug.h>
> -#include <linux/cpuidle.h>
> 
>  #include <asm/machdep.h>
>  #include <asm/firmware.h>
> @@ -217,16 +216,6 @@ static int __init pnv_probe(void)
>  	return 1;
>  }
> 
> -void powernv_idle(void)
> -{
> -	/* Hook to cpuidle framework if available, else
> -	 * call on default platform idle code
> -	 */
> -	if (cpuidle_idle_call()) {
> -		power7_idle();
> -	}
> -}
> -
>  define_machine(powernv) {
>  	.name			= "PowerNV",
>  	.probe			= pnv_probe,
> @@ -236,7 +225,7 @@ define_machine(powernv) {
>  	.show_cpuinfo		= pnv_show_cpuinfo,
>  	.progress		= pnv_progress,
>  	.machine_shutdown	= pnv_shutdown,
> -	.power_save             = powernv_idle,
> +	.power_save             = power7_idle,
>  	.calibrate_decr		= generic_calibrate_decr,
>  #ifdef CONFIG_KEXEC
>  	.kexec_cpu_down		= pnv_kexec_cpu_down,
> 

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

