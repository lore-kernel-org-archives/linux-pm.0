From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 9/9] PM / Domains: Add dev_pm_domain_attach_by_id() to
 manage multi PM domains
Date: Thu, 24 May 2018 16:48:53 +0100
Message-ID: <1c21d18e-954a-f3a8-9817-0117b7cb7e4f@nvidia.com>
References: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
 <1526639490-12167-10-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526639490-12167-10-git-send-email-ulf.hansson@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Todor Tomov <todor.tomov@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


On 18/05/18 11:31, Ulf Hansson wrote:
> The existing dev_pm_domain_attach() function, allows a single PM domain to
> be attached per device. To be able to support devices that are partitioned
> across multiple PM domains, let's introduce a new interface,
> dev_pm_domain_attach_by_id().
> 
> The dev_pm_domain_attach_by_id() returns a new allocated struct device with
> the corresponding attached PM domain. This enables for example a driver to
> operate on the new device from a power management point of view. The driver
> may then also benefit from using the received device, to set up so called
> device-links towards its original device. Depending on the situation, these
> links may then be dynamically changed.
> 
> The new interface is typically called by drivers during their probe phase,
> in case they manages devices which uses multiple PM domains. If that is the
> case, the driver also becomes responsible of managing the detaching of the
> PM domains, which typically should be done at the remove phase. Detaching
> is done by calling the existing dev_pm_domain_detach() function and for
> each of the received devices from dev_pm_domain_attach_by_id().
> 
> Note, currently its only genpd that supports multiple PM domains per
> device, but dev_pm_domain_attach_by_id() can easily by extended to cover
> other PM domain types, if/when needed.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   drivers/base/power/common.c | 33 ++++++++++++++++++++++++++++++++-
>   include/linux/pm_domain.h   |  7 +++++++
>   2 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> index 7ae62b6..d3db974 100644
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c
> @@ -117,13 +117,44 @@ int dev_pm_domain_attach(struct device *dev, bool power_on)
>   EXPORT_SYMBOL_GPL(dev_pm_domain_attach);
>   
>   /**
> + * dev_pm_domain_attach_by_id - Attach a device to one of its PM domains.

Isn't this more of a 'get'?

> + * @index: The index of the PM domain.
> + * @dev: Device to attach.

Isn't this just the device associated with the PM domain we are getting?

> + *
> + * As @dev may only be attached to a single PM domain, the backend PM domain
> + * provider should create a virtual device to attach instead. As attachment
> + * succeeds, the ->detach() callback in the struct dev_pm_domain should be
> + * assigned by the corresponding backend attach function.
> + *
> + * This function should typically be invoked from drivers during probe phase.
> + * Especially for those that manages devices which requires power management
> + * through more than one PM domain.
> + *
> + * Callers must ensure proper synchronization of this function with power
> + * management callbacks.
> + *
> + * Returns the virtual attached device in case successfully attached PM domain,
> + * NULL in case @dev don't need a PM domain, else a PTR_ERR().

Should this be 'NULL in the case where the @dev already has a power-domain'?

> + */
> +struct device *dev_pm_domain_attach_by_id(struct device *dev,
> +					  unsigned int index)
> +{
> +	if (dev->pm_domain)

I wonder if this is worthy of a ...

	if (WARN_ON(dev->pm_domain))

> +		return NULL;

Don't we consider this an error case? I wonder why not return PTR_ERR 
here as well? This would be consistent with dev_pm_domain_attach().

Cheers
Jon

-- 
nvpublic
