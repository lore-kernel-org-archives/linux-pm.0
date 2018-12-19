From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v10 14/27] drivers: firmware: psci: Simplify error path of
 psci_dt_init()
Date: Wed, 19 Dec 2018 13:08:39 +0100
Message-ID: <e5218407-f08b-9eda-9a67-0acea0e04e6e@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-15-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129174700.16585-15-ulf.hansson@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc: "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 29/11/2018 18:46, Ulf Hansson wrote:
> Instead of having each psci init function taking care of the of_node_put(),
> let's deal with that from psci_dt_init(), as this enables a bit simpler
> error path for each psci init function.
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


> ---
> 
> Changes in v10:
> 	- None.
> 
> ---
>  drivers/firmware/psci/psci.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 631e20720a22..6bfa47cbd174 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -609,9 +609,9 @@ static int __init psci_0_2_init(struct device_node *np)
>  	int err;
>  
>  	err = get_set_conduit_method(np);
> -
>  	if (err)
> -		goto out_put_node;
> +		return err;
> +
>  	/*
>  	 * Starting with v0.2, the PSCI specification introduced a call
>  	 * (PSCI_VERSION) that allows probing the firmware version, so
> @@ -619,11 +619,7 @@ static int __init psci_0_2_init(struct device_node *np)
>  	 * can be carried out according to the specific version reported
>  	 * by firmware
>  	 */
> -	err = psci_probe();
> -
> -out_put_node:
> -	of_node_put(np);
> -	return err;
> +	return psci_probe();
>  }
>  
>  /*
> @@ -635,9 +631,8 @@ static int __init psci_0_1_init(struct device_node *np)
>  	int err;
>  
>  	err = get_set_conduit_method(np);
> -
>  	if (err)
> -		goto out_put_node;
> +		return err;
>  
>  	pr_info("Using PSCI v0.1 Function IDs from DT\n");
>  
> @@ -661,9 +656,7 @@ static int __init psci_0_1_init(struct device_node *np)
>  		psci_ops.migrate = psci_migrate;
>  	}
>  
> -out_put_node:
> -	of_node_put(np);
> -	return err;
> +	return 0;
>  }
>  
>  static const struct of_device_id psci_of_match[] __initconst = {
> @@ -678,6 +671,7 @@ int __init psci_dt_init(void)
>  	struct device_node *np;
>  	const struct of_device_id *matched_np;
>  	psci_initcall_t init_fn;
> +	int ret;
>  
>  	np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
>  
> @@ -685,7 +679,10 @@ int __init psci_dt_init(void)
>  		return -ENODEV;
>  
>  	init_fn = (psci_initcall_t)matched_np->data;
> -	return init_fn(np);
> +	ret = init_fn(np);
> +
> +	of_node_put(np);
> +	return ret;
>  }
>  
>  #ifdef CONFIG_ACPI
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
