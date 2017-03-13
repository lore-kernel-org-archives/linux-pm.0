From: Brendan Jackman <brendan.jackman@arm.com>
Subject: Re: [PATCH V5 1/6] drivers: cpuidle: Read CPU's idle state from PM domain
Date: Mon, 13 Mar 2017 13:58:56 +0000
Message-ID: <8760jds2fz.fsf@arm.com>
References: <1488577697-127445-1-git-send-email-lina.iyer@linaro.org> <1488577697-127445-2-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-reply-to: <1488577697-127445-2-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com
List-Id: linux-pm@vger.kernel.org


Hi Lina,

On Fri, Mar 03 2017 at 21:48, Lina Iyer wrote:
> Currently CPUs idle states and idle states of its parent are represented
> in a flattened model by the cpu-dile-states property of the CPU node.
> The CPUs idle states are followed by its cluster idle states. With the
> introduction of CPU PM domains, the CPUs and domain idle states may be
> represented hierarchically as part of the domain DT definition. This
> would mean presenting idle state information in 2 places - CPU nodes for
> the CPU and the cluster's with the PM domains.
>
> Also, it makes sense to define domains around each individual CPU since
> each of them is a power domain in its own right. The CPU idle states can
> now be represented as its domain's idle state, defined by the
> domain-idle-states property. This avoids presenting idle states in
> multiple places in the DT.
>
> Modify the DT-based cpuidle driver to check for the presence of a CPU's
> domain and if present read the domain-idle-states of the PM domain and
> if the CPU's domain is absent, revert to reading in the cpu-idle-states
> property of the CPU DT node.
>
> Suggested-by: Sudeep Holla <sudeep.holla@qrm.com>
s/qrm/arm/

> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  drivers/cpuidle/dt_idle_states.c | 38 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
> index ffca4fc..4df7d45 100644
> --- a/drivers/cpuidle/dt_idle_states.c
> +++ b/drivers/cpuidle/dt_idle_states.c
> @@ -98,6 +98,39 @@ static int init_state_node(struct cpuidle_state *idle_state,
>  }
>
>  /*
> + * Get the state node at @idx. State node may be defined as domain's idle state
> + * if the CPU has its own domain or defined as CPU's idle state if it doesn't
> + * have a domain provider.
> + */
> +static struct device_node *get_state_node(struct device_node *cpu_node,
> +				unsigned int idx)
> +{
> +	struct device_node *dn;
> +	bool cpu_has_domain = false;
> +	struct of_phandle_args args;
> +	const char *property;
> +	int err;
> +
> +	err = of_parse_phandle_with_args(cpu_node, "power-domains",
> +					"#power-domain-cells", 0, &args);
Should probably have an of_node_put to match this.
> +	if (!err) {
> +		dn = args.np;
> +		err = of_count_phandle_with_args(dn, "domain-idle-states",
> +								NULL);
> +		cpu_has_domain = (err > 0);

So if a CPU has a power domain but that domain doesn't have any idle
states, then we fall back to cpu-idle-states?

I think the presence of a power domain for a CPU should mean
cpu-idle-states is totally ignored, and this should be made clear in the
power_domain.txt binding doc.

(I have had this conversation with someone before, I think it was
 internal at ARM but if I'm wrong and we've already discussed it then
 I'm sorry!)
> +	}
> +
> +	if (cpu_has_domain) {
> +		property = "domain-idle-states";
> +	} else {
> +		property = "cpu-idle-states";
> +		dn = cpu_node;
> +	}
> +
> +	return of_parse_phandle(dn, property, idx);
> +}
> +
> +/*
>   * Check that the idle state is uniform across all CPUs in the CPUidle driver
>   * cpumask
>   */
> @@ -118,8 +151,7 @@ static bool idle_state_valid(struct device_node *state_node, unsigned int idx,
>  	for (cpu = cpumask_next(cpumask_first(cpumask), cpumask);
>  	     cpu < nr_cpu_ids; cpu = cpumask_next(cpu, cpumask)) {
>  		cpu_node = of_cpu_device_node_get(cpu);
> -		curr_state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
> -						   idx);
> +		curr_state_node = get_state_node(cpu_node, idx);
>  		if (state_node != curr_state_node)
>  			valid = false;
>
> @@ -176,7 +208,7 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
>  	cpu_node = of_cpu_device_node_get(cpumask_first(cpumask));
>
>  	for (i = 0; ; i++) {
> -		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
> +		state_node = get_state_node(cpu_node, i);
>  		if (!state_node)
>  			break;

This patch only supports using domain-idle-states for the CPU-level idle
states, i.e. it only looks at one level of the power-domains graph
rather than walking it and "linearising"/"flattening" the discovered
states into a cpuidle-friendly list.

That's not a reason against merging this patch but we should note the
limitation and maybe even print a warning in if we find a parent for the
CPU's power domain but we're using cpuidle rather than runtime PM.

Cheers,
Brendan
