From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v10 13/27] drivers: firmware: psci: Support hierarchical
 CPU idle states
Date: Wed, 19 Dec 2018 13:11:09 +0100
Message-ID: <a5c19c01-31d5-f703-663c-3d5bd2ea8201@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-14-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129174700.16585-14-ulf.hansson@linaro.org>
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
> Support the hierarchical layout, simply by converting to calling the new OF
> helper, of_get_cpu_state_node().
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---

Fold it with 07/27 ?

> 
> Changes in v10:
> 	- None.
> 
> ---
>  drivers/firmware/psci/psci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index cbfc936d251c..631e20720a22 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -300,7 +300,7 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
>  		return -ENOMEM;
>  
>  	for (i = 0; i < num_state_nodes; i++) {
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
