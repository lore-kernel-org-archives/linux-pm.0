From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v12 1/4] PM / Domains: Add a generic data pointer to the
 genpd_power_state struct
Date: Thu, 21 Mar 2019 08:47:37 +0100
Message-ID: <11aa2536-9f9c-059d-a4d6-3f683be7caeb@linaro.org>
References: <20190227195836.24739-1-ulf.hansson@linaro.org>
 <20190227195836.24739-2-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190227195836.24739-2-ulf.hansson@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 27/02/2019 20:58, Ulf Hansson wrote:
> Let's add a data pointer to the genpd_power_state struct, to allow a genpd
> backend driver to store per state specific data. To introduce the pointer,
> we need to change the way genpd deals with freeing of the corresponding
> allocated data.
> 
> More precisely, let's clarify the responsibility of whom that shall free
> the data, by adding a ->free_states() callback to the struct
> generic_pm_domain. The one allocating the data shall assign the callback,
> to allow genpd to invoke it from genpd_remove().
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v12:
> 	- None.
> 
> ---
>  drivers/base/power/domain.c | 12 ++++++++++--
>  include/linux/pm_domain.h   |  4 +++-
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 2c334c01fc43..03885c003c6a 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1685,6 +1685,12 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>  }
>  EXPORT_SYMBOL_GPL(pm_genpd_remove_subdomain);
>  
> +static void genpd_free_default_power_state(struct genpd_power_state *states,
> +					   unsigned int state_count)
> +{
> +	kfree(states);
> +}
> +
>  static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
>  {
>  	struct genpd_power_state *state;
> @@ -1695,7 +1701,7 @@ static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
>  
>  	genpd->states = state;
>  	genpd->state_count = 1;
> -	genpd->free = state;
> +	genpd->free_states = genpd_free_default_power_state;
>  
>  	return 0;
>  }
> @@ -1811,7 +1817,9 @@ static int genpd_remove(struct generic_pm_domain *genpd)
>  	list_del(&genpd->gpd_list_node);
>  	genpd_unlock(genpd);
>  	cancel_work_sync(&genpd->power_off_work);
> -	kfree(genpd->free);
> +	if (genpd->free_states)

Is this test necessary as the free_states function is initialized with
the genpd_set_default_power_state() in any case?

> +		genpd->free_states(genpd->states, genpd->state_count);
> +
>  	pr_debug("%s: removed %s\n", __func__, genpd->name);
>  
>  	return 0;
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 1ed5874bcee0..8e1399231753 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -69,6 +69,7 @@ struct genpd_power_state {
>  	s64 residency_ns;
>  	struct fwnode_handle *fwnode;
>  	ktime_t idle_time;
> +	void *data;
>  };
>  
>  struct genpd_lock_ops;
> @@ -110,9 +111,10 @@ struct generic_pm_domain {
>  			   struct device *dev);
>  	unsigned int flags;		/* Bit field of configs for genpd */
>  	struct genpd_power_state *states;
> +	void (*free_states)(struct genpd_power_state *states,
> +			    unsigned int state_count);
>  	unsigned int state_count; /* number of states */
>  	unsigned int state_idx; /* state that genpd will go to when off */
> -	void *free; /* Free the state that was allocated for default */
>  	ktime_t on_time;
>  	ktime_t accounting_time;
>  	const struct genpd_lock_ops *lock_ops;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
