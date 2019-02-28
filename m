From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/7] drivers: firmware: psci: Split
 psci_dt_cpu_init_idle()
Date: Thu, 28 Feb 2019 15:42:53 +0100
Message-ID: <02a96f2c-dde1-73be-683d-b51d8c6b1b03@linaro.org>
References: <20190228135919.3747-1-ulf.hansson@linaro.org>
 <20190228135919.3747-4-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190228135919.3747-4-ulf.hansson@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 28/02/2019 14:59, Ulf Hansson wrote:
> Let's split the psci_dt_cpu_init_idle() function into two functions. This
> makes the code clearer and provides better re-usability.
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

but one question below.


> ---
>  drivers/firmware/psci/psci.c | 42 ++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index c80ec1d03274..9788bfc1cf8b 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -270,9 +270,26 @@ static int __init psci_features(u32 psci_func_id)
>  #ifdef CONFIG_CPU_IDLE
>  static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
>  
> +static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
> +{
> +	int err = of_property_read_u32(np, "arm,psci-suspend-param", state);
> +
> +	if (err) {
> +		pr_warn("%pOF missing arm,psci-suspend-param property\n", np);
> +		return err;
> +	}
> +
> +	if (!psci_power_state_is_valid(*state)) {
> +		pr_warn("Invalid PSCI power state %#x\n", *state);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
>  {
> -	int i, ret, count = 0;
> +	int i, ret = 0, count = 0;

Why do you need to intialize the ret variable? If the count is zero we
go directly to return 0, otherwise we enter in the loop and ret is
affected with the new function call.

>  	u32 *psci_states;
>  	struct device_node *state_node;
>  
> @@ -291,29 +308,16 @@ static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
>  		return -ENOMEM;
>  
>  	for (i = 0; i < count; i++) {
> -		u32 state;
> -
>  		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
> +		ret = psci_dt_parse_state_node(state_node, &psci_states[i]);
> +		of_node_put(state_node);
>  
> -		ret = of_property_read_u32(state_node,
> -					   "arm,psci-suspend-param",
> -					   &state);
> -		if (ret) {
> -			pr_warn(" * %pOF missing arm,psci-suspend-param property\n",
> -				state_node);
> -			of_node_put(state_node);
> +		if (ret)
>  			goto free_mem;
> -		}
>  
> -		of_node_put(state_node);
> -		pr_debug("psci-power-state %#x index %d\n", state, i);
> -		if (!psci_power_state_is_valid(state)) {
> -			pr_warn("Invalid PSCI power state %#x\n", state);
> -			ret = -EINVAL;
> -			goto free_mem;
> -		}
> -		psci_states[i] = state;
> +		pr_debug("psci-power-state %#x index %d\n", psci_states[i], i);
>  	}
> +
>  	/* Idle states parsed correctly, initialize per-cpu pointer */
>  	per_cpu(psci_power_state, cpu) = psci_states;
>  	return 0;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
