From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v9 06/11] cpuidle: dt: Support hierarchical CPU idle
 states
Date: Wed, 10 Oct 2018 16:03:44 +0100
Message-ID: <20181010150344.GC4844@e107155-lin>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
 <20181003143824.13059-7-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181003143824.13059-7-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 03, 2018 at 04:38:19PM +0200, Ulf Hansson wrote:
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

We can get rid of above and the of_node_put below if we move this into
of_get_cpu_state_node as suggested in earlier patch.

Apart from these, I don't see any issues with the subset unless there
are users for these. I will dig the v8 and comment.

-- 
Regards,
Sudeep
