From: Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH 07/34] cpufreq: cris: remove calls to
 cpufreq_notify_transition()
Date: Tue, 10 Oct 2017 09:57:42 +0200
Message-ID: <20171010075742.GL17578@axis.com>
References: <cover.1376619363.git.viresh.kumar@linaro.org>
 <d8b7b00908f0fa16feca841b1bf7fb1a49c62df1.1376619363.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d8b7b00908f0fa16feca841b1bf7fb1a49c62df1.1376619363.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jesper Nilsson <jespern@axis.com>, Mikael Starvik <starvik@axis.com>, linux-cris-kernel <linux-cris-kernel@axis.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 16, 2013 at 04:25:04AM +0200, Viresh Kumar wrote:
> Most of the drivers do following in their ->target_index() routines:
> 
> 	struct cpufreq_freqs freqs;
> 	freqs.old = old freq...
> 	freqs.new = new freq...
> 
> 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
> 
> 	/* Change rate here */
> 
> 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
> 
> This is replicated over all cpufreq drivers today and there doesn't exists a
> good enough reason why this shouldn't be moved to cpufreq core instead.
> 
> Earlier patches have added support in cpufreq core to do cpufreq notification on
> frequency change, this one removes it from this driver.
> 
> Some related minor cleanups are also done along with it.
> 

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> Cc: Mikael Starvik <starvik@axis.com>
> Cc: linux-cris-kernel@axis.com
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cris-artpec3-cpufreq.c | 8 --------
>  drivers/cpufreq/cris-etraxfs-cpufreq.c | 8 --------
>  2 files changed, 16 deletions(-)
> 
> diff --git a/drivers/cpufreq/cris-artpec3-cpufreq.c b/drivers/cpufreq/cris-artpec3-cpufreq.c
> index dace19d..e31e1e5 100644
> --- a/drivers/cpufreq/cris-artpec3-cpufreq.c
> +++ b/drivers/cpufreq/cris-artpec3-cpufreq.c
> @@ -29,15 +29,9 @@ static unsigned int cris_freq_get_cpu_frequency(unsigned int cpu)
>  
>  static int cris_freq_target(struct cpufreq_policy *policy, unsigned int state)
>  {
> -	struct cpufreq_freqs freqs;
>  	reg_clkgen_rw_clk_ctrl clk_ctrl;
>  	clk_ctrl = REG_RD(clkgen, regi_clkgen, rw_clk_ctrl);
>  
> -	freqs.old = cris_freq_get_cpu_frequency(policy->cpu);
> -	freqs.new = cris_freq_table[state].frequency;
> -
> -	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
> -
>  	local_irq_disable();
>  
>  	/* Even though we may be SMP they will share the same clock
> @@ -50,8 +44,6 @@ static int cris_freq_target(struct cpufreq_policy *policy, unsigned int state)
>  
>  	local_irq_enable();
>  
> -	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/cpufreq/cris-etraxfs-cpufreq.c b/drivers/cpufreq/cris-etraxfs-cpufreq.c
> index 4d40d9df..9d577d0 100644
> --- a/drivers/cpufreq/cris-etraxfs-cpufreq.c
> +++ b/drivers/cpufreq/cris-etraxfs-cpufreq.c
> @@ -29,15 +29,9 @@ static unsigned int cris_freq_get_cpu_frequency(unsigned int cpu)
>  
>  static int cris_freq_target(struct cpufreq_policy *policy, unsigned int state)
>  {
> -	struct cpufreq_freqs freqs;
>  	reg_config_rw_clk_ctrl clk_ctrl;
>  	clk_ctrl = REG_RD(config, regi_config, rw_clk_ctrl);
>  
> -	freqs.old = cris_freq_get_cpu_frequency(policy->cpu);
> -	freqs.new = cris_freq_table[state].frequency;
> -
> -	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
> -
>  	local_irq_disable();
>  
>  	/* Even though we may be SMP they will share the same clock
> @@ -50,8 +44,6 @@ static int cris_freq_target(struct cpufreq_policy *policy, unsigned int state)
>  
>  	local_irq_enable();
>  
> -	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
> -
>  	return 0;
>  }
>  
> -- 
> 1.7.12.rc2.18.g61b472e

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
