From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH V1 4/7] cpuidle: (powerpc) Add
 cpu_idle_wait() to allow switching idle routines
Date: Fri, 17 Jun 2011 14:32:08 +1000
Message-ID: <1308285128.32158.8.camel__1971.68903328038$1308285181$gmane$org@pasglop>
References: <20110607162847.6848.44707.stgit@tringupt.in.ibm.com>
	<20110607162959.6848.26918.stgit@tringupt.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110607162959.6848.26918.stgit@tringupt.in.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Trinabh Gupta <trinabh@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2011-06-07 at 22:00 +0530, Trinabh Gupta wrote:

> diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
> index 39a2baa..932392b 100644
> --- a/arch/powerpc/kernel/idle.c
> +++ b/arch/powerpc/kernel/idle.c
> @@ -102,6 +102,24 @@ void cpu_idle(void)
>  	}
>  }
>  
> +static void do_nothing(void *unused)
> +{
> +}
> +
> +/*
> + * cpu_idle_wait - Used to ensure that all the CPUs come out of the old
> + * idle loop and start using the new idle loop.
> + * Required while changing idle handler on SMP systems.
> + * Caller must have changed idle handler to the new value before the call.
> + */
> +void cpu_idle_wait(void)
> +{
> +	smp_mb();
> +	/* kick all the CPUs so that they exit out of old idle routine */
> +	smp_call_function(do_nothing, NULL, 1);
> +}
> +EXPORT_SYMBOL_GPL(cpu_idle_wait);
> +
>  int powersave_nap;
>  
>  #ifdef CONFIG_SYSCTL

This is gross :-)

Do you need to absolutely ensure the idle task has changed or just
kicking it with a send reschedule is enough ?

Cheers,
Ben.
