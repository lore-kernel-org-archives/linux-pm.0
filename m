From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] PM / Domains: defer dev_pm_domain_set() until genpd->attach_dev succeeds if present
Date: Sat, 15 Jul 2017 00:06:57 +0200
Message-ID: <4426566.dI53sBdSeV@aspire.rjw.lan>
References: <1498759251-11709-1-git-send-email-sudeep.holla@arm.com> <1500029508-7103-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1500029508-7103-1-git-send-email-sudeep.holla@arm.com>
Sender: stable-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, "# v4 . 0+" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, July 14, 2017 11:51:48 AM Sudeep Holla wrote:
> If the genpd->attach_dev or genpd->power_on fails, genpd_dev_pm_attach
> may return -EPROBE_DEFER initially. However genpd_alloc_dev_data sets
> the PM domain for the device unconditionally.
> 
> When subsequent attempts are made to call genpd_dev_pm_attach, it may
> return -EEXISTS checking dev->pm_domain without re-attempting to call
> attach_dev or power_on.
> 
> platform_drv_probe then attempts to call drv->probe as the return value
> -EEXIST != -EPROBE_DEFER, which may end up in a situation where the
> device is accessed without it's power domain switched on.
> 
> Fixes: f104e1e5ef57 ("PM / Domains: Re-order initialization of generic_pm_domain_data")
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: <stable@vger.kernel.org> # v4.0+
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Ulf, Kevin?

> ---
>  drivers/base/power/domain.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Hi,
> 
> I have added Cc/Fixes tags based on the original commit that caused the issue.
> I need to workout a patch that can cleanly apply before commit 989561de9b51
> ("PM / Domains: add setter for dev.pm_domain"), i.e. for v4.0.x to v4.4.x
> This patch should apply from v4.5.x onwards.
> 
> Let me know if I got anything wrong.
> 
> v1->v2: Moved dev_pm_domain_set(dev, NULL) from genpd_free_dev_data
> 
> Regards,
> Sudeep
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index da49a8383dc3..2d9178660061 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1168,8 +1168,6 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
>  
>  	spin_unlock_irq(&dev->power.lock);
>  
> -	dev_pm_domain_set(dev, &genpd->domain);
> -
>  	return gpd_data;
>  
>   err_free:
> @@ -1183,8 +1181,6 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
>  static void genpd_free_dev_data(struct device *dev,
>  				struct generic_pm_domain_data *gpd_data)
>  {
> -	dev_pm_domain_set(dev, NULL);
> -
>  	spin_lock_irq(&dev->power.lock);
>  
>  	dev->power.subsys_data->domain_data = NULL;
> @@ -1221,6 +1217,8 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>  	if (ret)
>  		goto out;
>  
> +	dev_pm_domain_set(dev, &genpd->domain);
> +
>  	genpd->device_count++;
>  	genpd->max_off_time_changed = true;
>  
> @@ -1282,6 +1280,8 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
>  	if (genpd->detach_dev)
>  		genpd->detach_dev(genpd, dev);
>  
> +	dev_pm_domain_set(dev, NULL);
> +
>  	list_del_init(&pdd->list_node);
>  
>  	genpd_unlock(genpd);
> 
