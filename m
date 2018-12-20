From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v10 16/27] drivers: firmware: psci: Prepare to use OS
 initiated suspend mode
Date: Thu, 20 Dec 2018 15:08:58 +0100
Message-ID: <20e1c04b-870f-3213-835d-28724ef4f530@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-17-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129174700.16585-17-ulf.hansson@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc: "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 29/11/2018 18:46, Ulf Hansson wrote:
> To enable the OS initiated mode, the CPU topology needs to be described
> using the hierarchical model in DT. When used, the idle state bits for the
> CPU are created by ORing the bits for PM domain's idle state.
> 
> Let's prepare the PSCI driver to deal with this, via introducing a per CPU
> variable called domain_state and by adding internal helpers to read/write
> the value of the variable.

What are the domain states ? What values can they have ?

> Cc: Lina Iyer <ilina@codeaurora.org>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v10:
> 	- Use __this_cpu_read|write() rather than this_cpu_read|write().
> 
> ---
>  drivers/firmware/psci/psci.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 4f0cbc95e41b..8dbcdecc2ae4 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -87,8 +87,19 @@ static u32 psci_function_id[PSCI_FN_MAX];
>  				(PSCI_1_0_EXT_POWER_STATE_ID_MASK | \
>  				PSCI_1_0_EXT_POWER_STATE_TYPE_MASK)
>  
> +static DEFINE_PER_CPU(u32, domain_state);
>  static u32 psci_cpu_suspend_feature;
>  
> +static inline u32 psci_get_domain_state(void)
> +{
> +	return __this_cpu_read(domain_state);
> +}
> +
> +static inline void psci_set_domain_state(u32 state)
> +{
> +	__this_cpu_write(domain_state, state);
> +}
> +
>  static inline bool psci_has_ext_power_state(void)
>  {
>  	return psci_cpu_suspend_feature &
> @@ -187,6 +198,8 @@ static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
>  
>  	fn = psci_function_id[PSCI_FN_CPU_ON];
>  	err = invoke_psci_fn(fn, cpuid, entry_point, 0);
> +	/* Clear the domain state to start fresh. */
> +	psci_set_domain_state(0);
>  	return psci_to_linux_errno(err);

I think this change is ambiguous:

 - if it is a change of the state because of the cpu_on, then I was
expecting a similar change in cpu_off and the change only if
invoke_psci_fn() succeeds.

 - if it is a change to take opportunity of the code path to initialize
the domain state, I suggest to remove it from there and make it very
explicit with static DEFINE_PER_CPU(u32, domain_state) = { 0 };


>  }
>  
> @@ -409,15 +422,17 @@ int psci_cpu_init_idle(struct cpuidle_driver *drv, unsigned int cpu)
>  static int psci_suspend_finisher(unsigned long index)
>  {
>  	u32 *state = __this_cpu_read(psci_power_state);
> +	u32 composite_state = state[index - 1] | psci_get_domain_state();
>  
> -	return psci_ops.cpu_suspend(state[index - 1],
> -				    __pa_symbol(cpu_resume));
> +	return psci_ops.cpu_suspend(composite_state, __pa_symbol(cpu_resume));
>  }
>  
>  int psci_cpu_suspend_enter(unsigned long index)
>  {
>  	int ret;
>  	u32 *state = __this_cpu_read(psci_power_state);
> +	u32 composite_state = state[index - 1] | psci_get_domain_state();
> +
>  	/*
>  	 * idle state index 0 corresponds to wfi, should never be called
>  	 * from the cpu_suspend operations
> @@ -425,11 +440,14 @@ int psci_cpu_suspend_enter(unsigned long index)
>  	if (WARN_ON_ONCE(!index))
>  		return -EINVAL;
>  
> -	if (!psci_power_state_loses_context(state[index - 1]))
> -		ret = psci_ops.cpu_suspend(state[index - 1], 0);
> +	if (!psci_power_state_loses_context(composite_state))
> +		ret = psci_ops.cpu_suspend(composite_state, 0);
>  	else
>  		ret = cpu_suspend(index, psci_suspend_finisher);
>  
> +	/* Clear the domain state to start fresh when back from idle. */
> +	psci_set_domain_state(0);
> +
>  	return ret;
>  }
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
