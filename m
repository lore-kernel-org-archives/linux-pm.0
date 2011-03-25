From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/5] x86 idle: remove NOP hlt_use_halt()
Date: Sat, 26 Mar 2011 00:32:45 +0530
Message-ID: <20110325190245.GA20328__25308.8092468262$1301079849$gmane$org@dirshya.in.ibm.com>
References: <67e90d97e0a77df4acd0c75e1bacc7714e011f3e.1300950095.git.len.brown@intel.com>
	<6bdee95bc92adfbe9de20c415e936bf1bb94993d.1300950095.git.len.brown@intel.com>
Reply-To: svaidy@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <6bdee95bc92adfbe9de20c415e936bf1bb94993d.1300950095.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

* Len Brown <lenb@kernel.org> [2011-03-24 03:08:28]:

> From: Len Brown <len.brown@intel.com>
> 
> hlt_use_halt() no longer has any effect,
> except to complicate the indentation in default_idle().
> 
> no functional change.
> 
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  arch/x86/kernel/process.c |   39 ++++++++++++++-------------------------
>  1 files changed, 14 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 8688ade..094d4ac 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -342,39 +342,28 @@ EXPORT_SYMBOL(boot_option_idle_override);
>  void (*pm_idle)(void);
>  EXPORT_SYMBOL(pm_idle);
> 
> -static inline int hlt_use_halt(void)
> -{
> -	return 1;
> -}
> -
>  /*
>   * We use this if we don't have any better
>   * idle routine..
>   */
>  void default_idle(void)
>  {
> -	if (hlt_use_halt()) {
> -		trace_power_start(POWER_CSTATE, 1, smp_processor_id());
> -		trace_cpu_idle(1, smp_processor_id());
> -		current_thread_info()->status &= ~TS_POLLING;
> -		/*
> -		 * TS_POLLING-cleared state must be visible before we
> -		 * test NEED_RESCHED:
> -		 */
> -		smp_mb();
> +	trace_power_start(POWER_CSTATE, 1, smp_processor_id());
> +	trace_cpu_idle(1, smp_processor_id());
> +	current_thread_info()->status &= ~TS_POLLING;
> +	/*
> +	 * TS_POLLING-cleared state must be visible before we
> +	 * test NEED_RESCHED:
> +	 */
> +	smp_mb();
> 
> -		if (!need_resched())
> -			safe_halt();	/* enables interrupts racelessly */
> -		else
> -			local_irq_enable();
> -		current_thread_info()->status |= TS_POLLING;
> -		trace_power_end(smp_processor_id());
> -		trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
> -	} else {
> +	if (!need_resched())
> +		safe_halt();	/* enables interrupts racelessly */
> +	else
>  		local_irq_enable();
> -		/* loop is done by the caller */
> -		cpu_relax();
> -	}
> +	current_thread_info()->status |= TS_POLLING;
> +	trace_power_end(smp_processor_id());
> +	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
>  }
>  #ifdef CONFIG_APM_MODULE
>  EXPORT_SYMBOL(default_idle);

Hi Len,

The cleanup looks good.

--Vaidy
