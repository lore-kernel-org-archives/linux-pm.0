From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2 1/5] power: domain: add pm_genpd_exit
Date: Mon, 7 Dec 2015 10:04:10 +0000
Message-ID: <5665599A.4060509@nvidia.com>
References: <1449251148-19344-1-git-send-email-eric@anholt.net>
 <1449251148-19344-2-git-send-email-eric@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449251148-19344-2-git-send-email-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Anholt <eric@anholt.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Alexander Aring <alex.aring@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-rpi-kernel@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


On 04/12/15 17:45, Eric Anholt wrote:
> From: Alexander Aring <alex.aring@gmail.com>
> 
> This patch adds function pm_genpd_exit for undo a pm_genpd_init. This
> is useful for multiple power domains while probing. If the probing fails
> after one pm_genpd_init was called we need to undo all previous
> registrations of generic pm domains inside the gpd_list list.
> 
> There is a check on IS_ERR_OR_NULL(genpd) which is useful to check again
> registered power domains and not registered domains, the driver can use
> this mechanism to have an array with registered and non-registered power
> domains, where non-registered power domains are NULL.
> 
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 22 ++++++++++++++++++++++
>  include/linux/pm_domain.h   |  4 ++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 167418e..e7aca27 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1509,6 +1509,28 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
>  }
>  EXPORT_SYMBOL_GPL(pm_genpd_init);
>  
> +/**
> + * pm_genpd_exit - Uninitialize a generic I/O PM domain object.
> + * @genpd: PM domain object to uninitialize.
> + */
> +void pm_genpd_exit(struct generic_pm_domain *genpd)
> +{
> +	if (IS_ERR_OR_NULL(genpd))
> +		return;
> +
> +	/* check if domain is still in registered inside the pm subsystem */
> +	WARN_ON_ONCE(!list_empty(&genpd->master_links) ||
> +		     !list_empty(&genpd->slave_links) ||
> +		     !list_empty(&genpd->dev_list));
> +

Why not return an error here? Seems bad to remove it, if it could still
be referenced by other domains.

Also not sure if you need to lock around the above test and removing the
domain.

> +	mutex_lock(&gpd_list_lock);
> +	list_del(&genpd->gpd_list_node);
> +	mutex_unlock(&gpd_list_lock);
> +
> +	mutex_destroy(&genpd->lock);
> +}
> +EXPORT_SYMBOL_GPL(pm_genpd_exit);
> +

BTW, I had just submitted a similar patch here [0]. So I would also like
to see such an API added.

Cheers
Jon

[0] http://marc.info/?l=devicetree&m=144924138932726&w=2
