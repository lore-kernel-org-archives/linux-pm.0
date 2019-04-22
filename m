From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/3] PM / Domains: Allow OF lookup for multi PM domain
 case from ->attach_dev()
Date: Mon, 22 Apr 2019 13:59:17 +0530
Message-ID: <20190422082917.3yaxzyg643sdjsji@vireshk-i7>
References: <20190418102757.1246-1-ulf.hansson@linaro.org>
 <20190418102757.1246-3-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190418102757.1246-3-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Hunter <jonathanh@nvidia.com>, Rajendra Nayak <rnayak@codeaurora.org>, Niklas Cassel <niklas.cassel@linaro.org>, Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 18-04-19, 12:27, Ulf Hansson wrote:
> A genpd provider that uses the ->attach_dev() callback to lookup resources
> for a device, fails to do so when the device has multiple PM domains. This
> is because when genpd invokes the ->attach_dev() callback, it passes the
> allocated virtual device as the in-parameter.
> 
> To address this problem, let's simply assign the dev->of_node for the
> virtual device, based upon the original device's OF node.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 7fec69aebf46..801f31c87d16 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2345,6 +2345,7 @@ EXPORT_SYMBOL_GPL(of_genpd_remove_last);
>  
>  static void genpd_release_dev(struct device *dev)
>  {
> +	of_node_put(dev->of_node);
>  	kfree(dev);
>  }
>  
> @@ -2406,14 +2407,14 @@ static void genpd_dev_pm_sync(struct device *dev)
>  	genpd_queue_power_off_work(pd);
>  }
>  
> -static int __genpd_dev_pm_attach(struct device *dev, struct device_node *np,
> -				 unsigned int index, bool power_on)
> +static int __genpd_dev_pm_attach(struct device *dev, unsigned int index,
> +				 bool power_on)
>  {
>  	struct of_phandle_args pd_args;
>  	struct generic_pm_domain *pd;
>  	int ret;
>  
> -	ret = of_parse_phandle_with_args(np, "power-domains",
> +	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
>  				"#power-domain-cells", index, &pd_args);
>  	if (ret < 0)
>  		return ret;
> @@ -2481,7 +2482,7 @@ int genpd_dev_pm_attach(struct device *dev)
>  				       "#power-domain-cells") != 1)
>  		return 0;
>  
> -	return __genpd_dev_pm_attach(dev, dev->of_node, 0, true);
> +	return __genpd_dev_pm_attach(dev, 0, true);
>  }
>  EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
>  
> @@ -2525,6 +2526,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>  	dev_set_name(virt_dev, "genpd:%u:%s", index, dev_name(dev));
>  	virt_dev->bus = &genpd_bus_type;
>  	virt_dev->release = genpd_release_dev;
> +	virt_dev->of_node = of_node_get(dev->of_node);
>  
>  	ret = device_register(virt_dev);
>  	if (ret) {
> @@ -2533,7 +2535,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>  	}
>  
>  	/* Try to attach the device to the PM domain at the specified index. */
> -	ret = __genpd_dev_pm_attach(virt_dev, dev->of_node, index, false);
> +	ret = __genpd_dev_pm_attach(virt_dev, index, false);
>  	if (ret < 1) {
>  		device_unregister(virt_dev);
>  		return ret ? ERR_PTR(ret) : NULL;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
