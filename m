From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v10 06/27] of: base: Add of_get_cpu_state_node() to get
 idle states for a CPU node
Date: Wed, 19 Dec 2018 12:05:56 +0100
Message-ID: <65605bbd-ceda-2266-615e-20b9d3491bed@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-7-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129174700.16585-7-ulf.hansson@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc: "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 29/11/2018 18:46, Ulf Hansson wrote:
> The CPU's idle state nodes are currently parsed at the common cpuidle DT
> library, but also when initializing back-end data for the arch specific CPU
> operations, as in the PSCI driver case.
> 
> To avoid open-coding, let's introduce of_get_cpu_state_node(), which takes
> the device node for the CPU and the index to the requested idle state node,
> as in-parameters. In case a corresponding idle state node is found, it
> returns the node with the refcount incremented for it, else it returns
> NULL.
> 
> Moreover, for ARM, there are two generic methods, to describe the CPU's
> idle states, either via the flattened description through the
> "cpu-idle-states" binding [1] or via the hierarchical layout, using the
> "power-domains" and the "domain-idle-states" bindings [2]. Hence, let's
> take both options into account.
> 
> [1]
> Documentation/devicetree/bindings/arm/idle-states.txt
> [2]
> Documentation/devicetree/bindings/arm/psci.txt
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: Lina Iyer <ilina@codeaurora.org>
> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Nitpicking some kerneldoc formatting below.

Other than that:

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> 
> Changes in v10:
> 	- None.
> 
> ---
>  drivers/of/base.c  | 35 +++++++++++++++++++++++++++++++++++
>  include/linux/of.h |  8 ++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 09692c9b32a7..8f6974a22006 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -429,6 +429,41 @@ int of_cpu_node_to_id(struct device_node *cpu_node)
>  }
>  EXPORT_SYMBOL(of_cpu_node_to_id);
>  
> +/**
> + * of_get_cpu_state_node - Get CPU's idle state node at the given index
> + *
> + * @cpu_node: The device node for the CPU
> + * @index: The index in the list of the idle states
> + *
> + * Two generic methods can be used to describe a CPU's idle states, either via
> + * a flattened description through the "cpu-idle-states" binding or via the
> + * hierarchical layout, using the "power-domains" and the "domain-idle-states"
> + * bindings. This function check for both and returns the idle state node for
> + * the requested index.
> + *
> + * In case and idle state node is found at index, the refcount incremented for

s/and/an/

s/index/@index/


> + * it, so call of_node_put() on it when done. Returns NULL if not found.

The Return description must be in a separate section.

> + */
> +struct device_node *of_get_cpu_state_node(struct device_node *cpu_node,
> +					  int index)
> +{
> +	struct of_phandle_args args;
> +	int err;
> +
> +	err = of_parse_phandle_with_args(cpu_node, "power-domains",
> +					"#power-domain-cells", 0, &args);
> +	if (!err) {
> +		struct device_node *state_node =
> +			of_parse_phandle(args.np, "domain-idle-states", index);
> +
> +		of_node_put(args.np);
> +		return state_node;
> +	}
> +
> +	return of_parse_phandle(cpu_node, "cpu-idle-states", index);
> +}
> +EXPORT_SYMBOL(of_get_cpu_state_node);
> +
>  /**
>   * __of_device_is_compatible() - Check if the node matches given constraints
>   * @device: pointer to node
> diff --git a/include/linux/of.h b/include/linux/of.h
> index a5aee3c438ad..f9f0c65c095c 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -348,6 +348,8 @@ extern const void *of_get_property(const struct device_node *node,
>  				int *lenp);
>  extern struct device_node *of_get_cpu_node(int cpu, unsigned int *thread);
>  extern struct device_node *of_get_next_cpu_node(struct device_node *prev);
> +extern struct device_node *of_get_cpu_state_node(struct device_node *cpu_node,
> +						 int index);
>  
>  #define for_each_property_of_node(dn, pp) \
>  	for (pp = dn->properties; pp != NULL; pp = pp->next)
> @@ -762,6 +764,12 @@ static inline struct device_node *of_get_next_cpu_node(struct device_node *prev)
>  	return NULL;
>  }
>  
> +static inline struct device_node *of_get_cpu_state_node(struct device_node *cpu_node,
> +					int index)
> +{
> +	return NULL;
> +}
> +
>  static inline int of_n_addr_cells(struct device_node *np)
>  {
>  	return 0;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
