From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] ARM64: powernv: remove redundant cpuidle_idle_call()
Date: Thu, 06 Feb 2014 21:29:58 +0530
Message-ID: <52F3B17E.4040209@linux.vnet.ibm.com>
References: <1391696188-14540-1-git-send-email-nicolas.pitre@linaro.org> <1391696188-14540-2-git-send-email-nicolas.pitre@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:39908 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbaBFQDh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 6 Feb 2014 11:03:37 -0500
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Fri, 7 Feb 2014 02:03:35 +1000
In-Reply-To: <1391696188-14540-2-git-send-email-nicolas.pitre@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org

Hi Nicolas,

powernv in the subject of the patch?

Regards
Preeti U Murthy
On 02/06/2014 07:46 PM, Nicolas Pitre wrote:
> The core idle loop now takes care of it.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>  arch/arm64/kernel/process.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 1c0a9be2ff..9cce0098f4 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -33,7 +33,6 @@
>  #include <linux/kallsyms.h>
>  #include <linux/init.h>
>  #include <linux/cpu.h>
> -#include <linux/cpuidle.h>
>  #include <linux/elfcore.h>
>  #include <linux/pm.h>
>  #include <linux/tick.h>
> @@ -94,10 +93,8 @@ void arch_cpu_idle(void)
>  	 * This should do all the clock switching and wait for interrupt
>  	 * tricks
>  	 */
> -	if (cpuidle_idle_call()) {
> -		cpu_do_idle();
> -		local_irq_enable();
> -	}
> +	cpu_do_idle();
> +	local_irq_enable();
>  }
> 
>  #ifdef CONFIG_HOTPLUG_CPU
> 

