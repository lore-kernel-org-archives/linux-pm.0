From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [RFC PATCH 2/3] PM / Domains: Add support for devices with
 multiple domains
Date: Tue, 20 Sep 2016 18:54:25 +0100
Message-ID: <37940866-a740-f959-9cba-1f18824151b0@nvidia.com>
References: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com>
 <1474367287-10402-3-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10018 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754694AbcITRyp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Sep 2016 13:54:45 -0400
In-Reply-To: <1474367287-10402-3-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org


On 20/09/16 11:28, Jon Hunter wrote:
> Some devices may require more than one PM domain to operate and this is
> not currently by the PM domain framework. Furthermore, the current Linux
> 'device' structure only allows devices to be associated with a single PM
> domain and so cannot easily be associated with more than one. To allow
> devices to be associated with more than one PM domain, if multiple
> domains are defined for a given device (eg. via device-tree), then:
> 1. Create a new PM domain for this device. The name of the new PM domain
>    created matches the device name for which it was created for.
> 2. Register the new PM domain as a sub-domain for all PM domains
>    required by the device.
> 3. Attach the device to the new PM domain.
> 
> By default the newly created PM domain is assumed to be in the 'off'
> state to ensure that any parent PM domains will be turned on if not
> already on when the new PM domain is turned on.
> 
> When a device associated with more than one PM domain is detached,
> wait for any power-off work to complete, then remove the PM domain that
> was created for the device by calling pm_genpd_remove() (this also
> removes it as a child to any other PM domains) and free the memory
> for the PM domain.
> 
> For devices using device-tree, devices that require multiple PM domains
> are detected by seeing if the 'power-domains' property has more than one
> entry defined.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> 
> Here is an example output from pm_genpd_summary following this change
> for the Tegra210 XHCI device:
> 
> domain                          status          slaves
>     /device                                             runtime status
> ----------------------------------------------------------------------
> 70090000.usb                    on
>     /devices/platform/70090000.usb                      unsupported
> xusbc                           on              70090000.usb
> xusbb                           off-0
> xusba                           on              70090000.usb
> 
> I am not sure if this is confusing to have a device and domain with the
> same name. So let me know if you have any thoughts!
> 
> 
>  drivers/base/power/domain.c | 102 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 88 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 382735949591..ee39824c03b3 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1826,7 +1826,7 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
>  {
>  	struct generic_pm_domain *pd;
>  	unsigned int i;
> -	int ret = 0;
> +	int count, ret = 0;
>  
>  	pd = genpd_lookup_dev(dev);
>  	if (!pd)
> @@ -1851,6 +1851,19 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
>  
>  	/* Check if PM domain can be powered off after removing this device. */
>  	genpd_queue_power_off_work(pd);
> +
> +	count = of_count_phandle_with_args(dev->of_node, "power-domains",
> +					   "#power-domain-cells");
> +	if (count > 1) {
> +		cancel_work_sync(&pd->power_off_work);
> +
> +		ret = pm_genpd_remove(pd);
> +		if (ret < 0)
> +			dev_err(dev, "failed to remove PM domain %s: %d\n",
> +				pd->name, ret);
> +
> +		kfree(pd);

I realise I am missing a return if pm_genpd_remove() returns a failure!
Will correct this.

Jon

-- 
nvpublic
