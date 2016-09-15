From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] PM / Domains: Allow holes in genpd_data.domains array
Date: Thu, 15 Sep 2016 12:03:27 +0100
Message-ID: <5256c34e-5afb-2cfe-9818-8e6a6e1f0fa3@nvidia.com>
References: <1473935963-8837-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8781 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756136AbcIOLDf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Sep 2016 07:03:35 -0400
In-Reply-To: <1473935963-8837-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-kernel@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org


On 15/09/16 11:39, Tomeu Vizoso wrote:
> In platforms such as Rockchip's, the array of domains isn't always
> filled without holes, as which domains are present depend on the
> particular SoC revision.
> 
> By allowing holes to be in the array, such SoCs can still use a single
> set of constants to index the array of power domains.
> 
> Fixes: 0159ec670763 ("PM / Domains: Verify the PM domain is present when adding a provider")
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Cc: Jon Hunter <jonathanh@nvidia.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/base/power/domain.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index b0cf46dcae73..ce3f483ec67b 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1581,6 +1581,8 @@ int of_genpd_add_provider_onecell(struct device_node *np,
>  	mutex_lock(&gpd_list_lock);
>  
>  	for (i = 0; i < data->num_domains; i++) {
> +		if (!data->domains[i])
> +			continue;
>  		if (!pm_genpd_present(data->domains[i]))
>  			goto error;
>  

Sounds reasonable and sorry I had not thought of this. Can you also make
sure we check that !data->domains[i] in the error path as well or
potentially we could have a NULL pointer dereference in the case of an
actual error.

Cheers
Jon

-- 
nvpublic
