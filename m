From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/4] PM / Domains: Drop unused in-parameter to some genpd
 functions
Date: Thu, 25 Apr 2019 15:10:35 +0530
Message-ID: <20190425094035.c7tn2efkxhbl25re@vireshk-i7>
References: <20190425090413.10700-1-ulf.hansson@linaro.org>
 <20190425090413.10700-3-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190425090413.10700-3-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Rajendra Nayak <rnayak@codeaurora.org>, Niklas Cassel <niklas.cassel@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 25-04-19, 11:04, Ulf Hansson wrote:
> Both genpd_alloc_dev_data() and genpd_add_device(), whom are internal genpd
> functions, allows a struct gpd_timing_data *td to be passed as an
> in-parameter. However, as NULL is always passed, let's just drop the
> in-parameter altogether.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 8aca1c9b4406..93298b7db408 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1396,8 +1396,7 @@ EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweron);
>  
>  #endif /* CONFIG_PM_SLEEP */
>  
> -static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
> -					struct gpd_timing_data *td)
> +static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev)
>  {
>  	struct generic_pm_domain_data *gpd_data;
>  	int ret;
> @@ -1412,9 +1411,6 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
>  		goto err_put;
>  	}
>  
> -	if (td)
> -		gpd_data->td = *td;
> -
>  	gpd_data->base.dev = dev;
>  	gpd_data->td.constraint_changed = true;
>  	gpd_data->td.effective_constraint_ns = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
> @@ -1504,8 +1500,7 @@ static void genpd_clear_cpumask(struct generic_pm_domain *genpd,
>  	genpd_update_cpumask(genpd, dev, false);
>  }
>  
> -static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
> -			    struct gpd_timing_data *td)
> +static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev)
>  {
>  	struct generic_pm_domain_data *gpd_data;
>  	int ret;
> @@ -1515,7 +1510,7 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>  	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
>  		return -EINVAL;
>  
> -	gpd_data = genpd_alloc_dev_data(dev, td);
> +	gpd_data = genpd_alloc_dev_data(dev);
>  	if (IS_ERR(gpd_data))
>  		return PTR_ERR(gpd_data);
>  
> @@ -1553,7 +1548,7 @@ int pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev)
>  	int ret;
>  
>  	mutex_lock(&gpd_list_lock);
> -	ret = genpd_add_device(genpd, dev, NULL);
> +	ret = genpd_add_device(genpd, dev);
>  	mutex_unlock(&gpd_list_lock);
>  
>  	return ret;
> @@ -2259,7 +2254,7 @@ int of_genpd_add_device(struct of_phandle_args *genpdspec, struct device *dev)
>  		goto out;
>  	}
>  
> -	ret = genpd_add_device(genpd, dev, NULL);
> +	ret = genpd_add_device(genpd, dev);
>  
>  out:
>  	mutex_unlock(&gpd_list_lock);
> @@ -2429,7 +2424,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>  
>  	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
>  
> -	ret = genpd_add_device(pd, dev, NULL);
> +	ret = genpd_add_device(pd, dev);
>  	mutex_unlock(&gpd_list_lock);
>  
>  	if (ret < 0) {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
