From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 6/8] PM / Domains: Remove a provider by referencing
 the data pointer
Date: Tue, 21 Jun 2016 15:45:09 +0100
Message-ID: <576952F5.5020808@nvidia.com>
References: <1457090634-14785-1-git-send-email-jonathanh@nvidia.com>
 <1457090634-14785-7-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457090634-14785-7-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


On 04/03/16 11:23, Jon Hunter wrote:
> To remove a PM domain from the system, it is necessary to ensure
> that any PM domain providers associated with the PM domain have
> been removed. Otherwise it could be possible to obtain a pointer
> to a PM domain structure that has been removed.
> 
> PM domains now have a reference to the pointer for the PM domain
> provider's data variable. Add a function so that a PM domain can
> remove a PM domain provider by referencing the data pointer.
> 
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/base/power/domain.c | 24 ++++++++++++++++++++++++
>  include/linux/pm_domain.h   |  2 ++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 72055fef6256..438885f2455f 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1738,6 +1738,30 @@ void of_genpd_del_provider(struct device_node *np)
>  EXPORT_SYMBOL_GPL(of_genpd_del_provider);
>  
>  /**
> + * of_genpd_del_provider_by_data() - Remove a registered PM domain provider
> + * @data: Pointer to the data associated with the PM domain provider
> + *
> + * Look up a PM domain provider based upon a pointer to it's data and
> + * remove the PM domain provider from the list of providers.
> + */
> +void of_genpd_del_provider_by_data(void *data)
> +{
> +	struct of_genpd_provider *c, *cp;
> +
> +	mutex_lock(&of_genpd_mutex);
> +	list_for_each_entry_safe(cp, c, &of_genpd_providers, link) {
> +		if (cp->data == data) {
> +			list_del(&cp->link);
> +			of_node_put(cp->node);
> +			kfree(cp);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&of_genpd_mutex);

On further the thought I believe that the above does not need to be safe
variant of list_for_each_entry because we are breaking out of the loop
when we find the one we are looking for. of_genpd_del_provider() does
the same.

Cheers
Jon

-- 
nvpublic
