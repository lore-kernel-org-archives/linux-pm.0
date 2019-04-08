From: Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v2 1/2] cpuidle : auto-promotion for cpuidle states
Date: Tue, 09 Apr 2019 00:25:42 +1000
Message-ID: <87lg0kwp3t.fsf@dja-thinkpad.axtens.net>
References: <20190405091647.4169-1-huntbag@linux.vnet.ibm.com> <20190405091647.4169-2-huntbag@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190405091647.4169-2-huntbag@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, daniel.lezcano@linaro.org, mpe@ellerman.id.au, ego@linux.vnet.ibm.com, Abhishek Goel <huntbag@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

Hi,

Sorry, just realised another thing I wanted to ask:

> @@ -442,6 +442,26 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  		}
>  	}
>
>
> +#ifdef CPUIDLE_FLAG_AUTO_PROMOTION

Why is this based on CPUIDLE_FLAG_ rather than CONFIG_CPU_IDLE_? Won't
this always be true, given that the flag is defined regardless of the
config option in the header?

> +	if (drv->states[idx].flags & CPUIDLE_FLAG_AUTO_PROMOTION) {
> +		/*
> +		 * Timeout is intended to be defined as sum of target residency
> +		 * of next available state, entry latency and exit latency. If
> +		 * time interval equal to timeout is spent in current state,
> +		 * and if it is a shallow lite state, we may want to auto-
> +		 * promote from such state.
> +		 */

Regards,
Daniel

> +		for (i = idx + 1; i < drv->state_count; i++) {
> +			if (drv->states[i].disabled ||
> +					dev->states_usage[i].disable)
> +				continue;
> +			*timeout = drv->states[i].target_residency +
> +					2 * drv->states[i].exit_latency;
> +			break;
> +		}
> +	}
> +#endif
> +
>  	return idx;
>  }
>  
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 3b3947232..84d76d1ec 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -72,6 +72,13 @@ struct cpuidle_state {
>  #define CPUIDLE_FLAG_POLLING	BIT(0) /* polling state */
>  #define CPUIDLE_FLAG_COUPLED	BIT(1) /* state applies to multiple cpus */
>  #define CPUIDLE_FLAG_TIMER_STOP BIT(2) /* timer is stopped on this state */
> +/*
> + * State with only and only fast state bit set don't even lose user context.
> + * But such states prevent other sibling threads from thread folding benefits.
> + * And hence we don't want to stay for too long in such states and want to
> + * auto-promote from it.
> + */
> +#define CPUIDLE_FLAG_AUTO_PROMOTION	BIT(3)
>  
>  struct cpuidle_device_kobj;
>  struct cpuidle_state_kobj;
> @@ -243,7 +250,8 @@ struct cpuidle_governor {
>  
>  	int  (*select)		(struct cpuidle_driver *drv,
>  					struct cpuidle_device *dev,
> -					bool *stop_tick);
> +					bool *stop_tick, unsigned long
> +					*timeout);
>  	void (*reflect)		(struct cpuidle_device *dev, int index);
>  };
>  
> -- 
> 2.17.1
