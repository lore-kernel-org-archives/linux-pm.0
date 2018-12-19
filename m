From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v10 07/27] cpuidle: dt: Support hierarchical CPU idle
 states
Date: Wed, 19 Dec 2018 12:20:00 +0100
Message-ID: <8b8eaac3-9b17-a853-b02e-a5ec4a0c911d@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-8-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129174700.16585-8-ulf.hansson@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc: "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 29/11/2018 18:46, Ulf Hansson wrote:
> From: Lina Iyer <lina.iyer@linaro.org>
> 
> Currently CPU's idle states are represented in a flattened model, via the
> "cpu-idle-states" binding from within the CPU's device nodes.
> 
> Support the hierarchical layout during parsing and validating of the CPU's
> idle states. This is simply done by calling the new OF helper,
> of_get_cpu_state_node().
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> 
> Changes in v10:
> 	- None.
> 
> ---
>  drivers/cpuidle/dt_idle_states.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
> index 53342b7f1010..13f9b7cd32d1 100644
> --- a/drivers/cpuidle/dt_idle_states.c
> +++ b/drivers/cpuidle/dt_idle_states.c
> @@ -118,8 +118,7 @@ static bool idle_state_valid(struct device_node *state_node, unsigned int idx,
>  	for (cpu = cpumask_next(cpumask_first(cpumask), cpumask);
>  	     cpu < nr_cpu_ids; cpu = cpumask_next(cpu, cpumask)) {
>  		cpu_node = of_cpu_device_node_get(cpu);
> -		curr_state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
> -						   idx);
> +		curr_state_node = of_get_cpu_state_node(cpu_node, idx);
>  		if (state_node != curr_state_node)
>  			valid = false;
>  
> @@ -176,7 +175,7 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
>  	cpu_node = of_cpu_device_node_get(cpumask_first(cpumask));
>  
>  	for (i = 0; ; i++) {
> -		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
> +		state_node = of_get_cpu_state_node(cpu_node, i);
>  		if (!state_node)
>  			break;
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
