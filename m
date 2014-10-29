From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 3/4] PM / Domains: Improve error handling while adding/removing devices
Date: Wed, 29 Oct 2014 16:57:48 -0700
Message-ID: <7h38a65szn.fsf@deeprootsystems.com>
References: <1414507090-516-1-git-send-email-ulf.hansson@linaro.org>
	<1414507090-516-4-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1414507090-516-4-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Tue, 28 Oct 2014 15:38:09 +0100")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron Lu <aaron.lu@intel.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: linux-pm@vger.kernel.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> To improve error handling while adding/removing devices from their PM
> domains, we need to restructure the code a bit. Let's do this by moving
> the device specific parts into a separate function.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

[...]

> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 9d511c7..4e5fcd7 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1358,25 +1358,81 @@ EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweron);
>  
>  #endif /* CONFIG_PM_SLEEP */
>  
> -static struct generic_pm_domain_data *__pm_genpd_alloc_dev_data(struct device *dev)
> +static int genpd_alloc_dev_data(struct generic_pm_domain *genpd,
> +				struct device *dev, struct gpd_timing_data *td)
>  {
>  	struct generic_pm_domain_data *gpd_data;
> +	int ret;
> +
> +	dev_dbg(dev, "%s()\n", __func__);
> +
> +	ret = dev_pm_get_subsys_data(dev);
> +	if (ret)
> +		return ret;
>  
>  	gpd_data = kzalloc(sizeof(*gpd_data), GFP_KERNEL);
> -	if (!gpd_data)
> -		return NULL;
> +	if (!gpd_data) {
> +		ret = -ENOMEM;
> +		goto err_alloc;
> +	}
>  
>  	mutex_init(&gpd_data->lock);
> +	gpd_data->base.dev = dev;
> +	gpd_data->td.constraint_changed = true;
> +	gpd_data->td.effective_constraint_ns = -1;
>  	gpd_data->nb.notifier_call = genpd_dev_pm_qos_notifier;
> +	if (td)
> +		gpd_data->td = *td;
> +
> +	spin_lock_irq(&dev->power.lock);
> +	if (!dev->power.subsys_data->domain_data)
> +		dev->power.subsys_data->domain_data = &gpd_data->base;
> +	else
> +		ret = -EINVAL;
> +	spin_unlock_irq(&dev->power.lock);
> +
> +	if (ret)
> +		goto err_data;
> +
> +	if (genpd->attach_dev)
> +		genpd->attach_dev(dev);

To me, it doesn't seem right that the attach is done in the 'alloc'
function.  IMO, the attach should stay in _add_device()

Kevin
