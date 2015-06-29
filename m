From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH RFC v2 01/16] PM / Domains: Allocate memory outside domain
 locks
Date: Mon, 29 Jun 2015 09:26:27 +0900
Message-ID: <559090B3.4040502@samsung.com>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
 <1435374156-19214-2-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:27476 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbbF2A0e (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 28 Jun 2015 20:26:34 -0400
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NQO00M2UJW7GF20@mailout2.w1.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 29 Jun 2015 01:26:31 +0100 (BST)
In-reply-to: <1435374156-19214-2-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>, rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org
Cc: geert@linux-m68k.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org

On 27.06.2015 12:02, Lina Iyer wrote:
> In preparation for supporting IRQ-safe domains, allocate domain data
> outside the domain locks. These functions are not called in an atomic
> context, so we can always allocate memory using GFP_KERNEL. By
> allocating memory before the locks, we can safely lock the domain using
> spinlocks instead of mutexes.
> 
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@linaro.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
> Changes in v2:
> 	- Modify commit text
> ---
>  drivers/base/power/domain.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 87d405a..44af889 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1379,13 +1379,17 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
>  int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
>  			   struct generic_pm_domain *subdomain)
>  {
> -	struct gpd_link *link;
> +	struct gpd_link *link, *itr;
>  	int ret = 0;
>  
>  	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(subdomain)
>  	    || genpd == subdomain)
>  		return -EINVAL;
>  
> +	link = kzalloc(sizeof(*link), GFP_KERNEL);
> +	if (!link)
> +		return -ENOMEM;
> +
>  	mutex_lock(&genpd->lock);
>  	mutex_lock_nested(&subdomain->lock, SINGLE_DEPTH_NESTING);
>  
> @@ -1395,18 +1399,13 @@ int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
>  		goto out;
>  	}
>  
> -	list_for_each_entry(link, &genpd->master_links, master_node) {
> -		if (link->slave == subdomain && link->master == genpd) {
> +	list_for_each_entry(itr, &genpd->master_links, master_node) {
> +		if (itr->slave == subdomain && itr->master == genpd) {
>  			ret = -EINVAL;
>  			goto out;

The same comment as in previous version - where is the kfree()? You
moved the allocation so all error paths have to be checked and adjusted.
Not just one that I pointed in previous review.

>  		}
>  	}
>  
> -	link = kzalloc(sizeof(*link), GFP_KERNEL);
> -	if (!link) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
>  	link->master = genpd;
>  	list_add_tail(&link->master_node, &genpd->master_links);
>  	link->slave = subdomain;
> @@ -1508,17 +1507,17 @@ int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int state)
>  	if (IS_ERR_OR_NULL(genpd) || state < 0)
>  		return -EINVAL;
>  
> +	cpuidle_data = kzalloc(sizeof(*cpuidle_data), GFP_KERNEL);
> +	if (!cpuidle_data)
> +		return -ENOMEM;
> +
>  	mutex_lock(&genpd->lock);
>  
>  	if (genpd->cpuidle_data) {
>  		ret = -EEXIST;
> -		goto out;
> -	}
> -	cpuidle_data = kzalloc(sizeof(*cpuidle_data), GFP_KERNEL);
> -	if (!cpuidle_data) {
> -		ret = -ENOMEM;
> -		goto out;
> +		goto err_drv;

Is the mutex freed in this exit path?

Best regards,
Krzysztof

>  	}
> +
>  	cpuidle_drv = cpuidle_driver_ref();
>  	if (!cpuidle_drv) {
>  		ret = -ENODEV;
> 

