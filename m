From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 5/7] drivers: firmware: psci: Simplify state node parsing
Date: Fri, 1 Mar 2019 17:28:10 +0000
Message-ID: <20190301172810.GR15517@lakrids.cambridge.arm.com>
References: <20190228135919.3747-1-ulf.hansson@linaro.org>
 <20190228135919.3747-6-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190228135919.3747-6-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 28, 2019 at 02:59:17PM +0100, Ulf Hansson wrote:
> Instead of iterating through all the state nodes in DT, to find out how
> many states that needs to be allocated, let's use the number already known
> by the cpuidle driver. In this way we can drop the iteration altogether.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/firmware/psci/psci.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index d50b46a0528f..cbfc936d251c 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -290,26 +290,20 @@ static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
>  static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
>  			struct device_node *cpu_node, int cpu)
>  {
> -	int i, ret = 0, count = 0;
> +	int i, ret = 0, num_state_nodes = drv->state_count - 1;
>  	u32 *psci_states;
>  	struct device_node *state_node;
>  
> -	/* Count idle states */
> -	while ((state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
> -					      count))) {
> -		count++;
> -		of_node_put(state_node);
> -	}
> -

To be honest, I'd rather not tighten the coupling with the cpuidle
driver here. For example, I'm not that happy with the PSCI backend
having to know the driver has a specific WFI state.

IIUC we could get rid of the explicit counting with something like:

	count = of_parse_phandle_with_args(cpu_node, "cpu-idle-states", NULL);

... but I'm not sure that the overall change is a simplification.

Does this change make it easier to plumb in something in future?

Thanks,
Mark.

> -	if (!count)
> -		return -ENODEV;
> -
> -	psci_states = kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
> +	psci_states = kcalloc(num_state_nodes, sizeof(*psci_states),
> +			GFP_KERNEL);
>  	if (!psci_states)
>  		return -ENOMEM;
>  
> -	for (i = 0; i < count; i++) {
> +	for (i = 0; i < num_state_nodes; i++) {
>  		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
> +		if (!state_node)
> +			break;
> +
>  		ret = psci_dt_parse_state_node(state_node, &psci_states[i]);
>  		of_node_put(state_node);
>  
> @@ -319,6 +313,11 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
>  		pr_debug("psci-power-state %#x index %d\n", psci_states[i], i);
>  	}
>  
> +	if (i != num_state_nodes) {
> +		ret = -ENODEV;
> +		goto free_mem;
> +	}
> +
>  	/* Idle states parsed correctly, initialize per-cpu pointer */
>  	per_cpu(psci_power_state, cpu) = psci_states;
>  	return 0;
> -- 
> 2.17.1
> 
