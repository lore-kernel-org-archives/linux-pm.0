From: Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v2 2/2] cpuidle : Add auto-promotion flag to cpuidle flags
Date: Tue, 09 Apr 2019 00:22:26 +1000
Message-ID: <87o95gwp99.fsf@dja-thinkpad.axtens.net>
References: <20190405091647.4169-1-huntbag@linux.vnet.ibm.com> <20190405091647.4169-3-huntbag@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190405091647.4169-3-huntbag@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, daniel.lezcano@linaro.org, mpe@ellerman.id.au, ego@linux.vnet.ibm.com, Abhishek Goel <huntbag@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

Abhishek Goel <huntbag@linux.vnet.ibm.com> writes:

> This patch sets up flags for the state which needs to be auto-promoted. On
> POWERNV system, only lite states need to be autopromoted. We identify lite
> states by those which do not lose user context. That information has been
> used to set the flag for lite states.
>
> Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/opal-api.h |  1 +
>  drivers/cpuidle/Kconfig             |  4 ++++
>  drivers/cpuidle/cpuidle-powernv.c   | 13 +++++++++++--
>  3 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
> index 870fb7b23..735dec731 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -226,6 +226,7 @@
>   */
>  
>  #define OPAL_PM_TIMEBASE_STOP		0x00000002
> +#define OPAL_PM_LOSE_USER_CONTEXT	0x00001000

Is the important thing that you don't lose user context, or that the
state prevents thread folding? From your description, it seems from a
power managment point of view that the important thing is that the state
prevents thread folding, and it seems almost coincidental that it
preserves user context.

If this is mirrored from the way hardware or opal describes it (which
looking at the other flags it looks like it might be), it would be worth
adding a comment that explains why we want to leave such a state.

>  #define OPAL_PM_LOSE_HYP_CONTEXT	0x00002000
>  #define OPAL_PM_LOSE_FULL_CONTEXT	0x00004000
>  #define OPAL_PM_NAP_ENABLED		0x00010000
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index 8caccbbd7..9b8e9b96a 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -35,6 +35,10 @@ config CPU_IDLE_GOV_TEO
>  config DT_IDLE_STATES
>  	bool
>  
> +config CPU_IDLE_AUTO_PROMOTION
> +	bool
> +	default y if PPC_POWERNV
> +
As I mentioned in the previous patch, this is used in the previous
patch. It's also not used here.


Regards,
Daniel

>  menu "ARM CPU Idle Drivers"
>  depends on ARM || ARM64
>  source "drivers/cpuidle/Kconfig.arm"
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 84b1ebe21..0dd767270 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -299,6 +299,7 @@ static int powernv_add_idle_states(void)
>  	for (i = 0; i < dt_idle_states; i++) {
>  		unsigned int exit_latency, target_residency;
>  		bool stops_timebase = false;
> +		bool lose_user_context = false;
>  		struct pnv_idle_states_t *state = &pnv_idle_states[i];
>  
>  		/*
> @@ -324,6 +325,9 @@ static int powernv_add_idle_states(void)
>  		if (has_stop_states && !(state->valid))
>  				continue;
>  
> +		if (state->flags & OPAL_PM_LOSE_USER_CONTEXT)
> +			lose_user_context = true;
> +
>  		if (state->flags & OPAL_PM_TIMEBASE_STOP)
>  			stops_timebase = true;
>  
> @@ -332,12 +336,17 @@ static int powernv_add_idle_states(void)
>  			add_powernv_state(nr_idle_states, "Nap",
>  					  CPUIDLE_FLAG_NONE, nap_loop,
>  					  target_residency, exit_latency, 0, 0);
> +		} else if (has_stop_states && !lose_user_context) {
> +			add_powernv_state(nr_idle_states, state->name,
> +					  CPUIDLE_FLAG_AUTO_PROMOTION,
> +					  stop_loop, target_residency,
> +					  exit_latency, state->psscr_val,
> +					  state->psscr_mask);
>  		} else if (has_stop_states && !stops_timebase) {
>  			add_powernv_state(nr_idle_states, state->name,
>  					  CPUIDLE_FLAG_NONE, stop_loop,
>  					  target_residency, exit_latency,
> -					  state->psscr_val,
> -					  state->psscr_mask);
> +					  state->psscr_val, state->psscr_mask);
>  		}
>  
>  		/*
> -- 
> 2.17.1
