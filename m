From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH] PM / Domains: Ensure genpd name is set before creating
 debugfs entry
Date: Fri, 28 Jul 2017 13:55:35 -0500
Message-ID: <7c1b9c08-4b54-78ec-98da-ae10abd63dc7@ti.com>
References: <20170728184818.1306-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:39625 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752236AbdG1S40 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jul 2017 14:56:26 -0400
In-Reply-To: <20170728184818.1306-1-d-gerlach@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Thara Gopinath <thara.gopinath@linaro.org>

Hi,
On 07/28/2017 01:48 PM, Dave Gerlach wrote:
> Commit b6a1d093f96b ("PM / Domains: Extend generic power domain
> debugfs") extends the existing generic power domain debugfs to provide
> more information about each genpd, however it creates a debugfs
> directory for each based on the name of the genpd. While it is a good
> idea to populate the name field of each genpd, up until this commit it
> was not required. However, attempting to call debugfs_create_dir with a
> null name value causes a NULL pointer dereference panic.
> 
> In order to keep things working as they did before the aforementioned
> patch, check to see if name has been populated and if not, skip creating
> the extended debugfs info path and warn that name is needed to get this
> extended info.
> 
> Fixes: b6a1d093f96b ("PM / Domains: Extend generic power domain debugfs")
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---

As changelog describes, commit b6a1d093f96b ("PM / Domains: Extend generic power
domain debugfs") currently causes a NULL pointer dereference panic if no name is
assigned for a struct generic_pm_domain registered with the framework. Before
this patch no name was required, so this patch is a first attempt to keep things
that way and just warn the user that they can't get extended debugfs info
without providing a genpd name.

Of course a name is always a good idea, so I'm not sure if this patch is how we
want to go about preventing this panic or perhaps just making the name mandatory
and checking during probe, but I figured I'd kick the discussion off with a
suggestion by sending this patch.

Regards,
Dave

>  drivers/base/power/domain.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 43fd08e50ae9..77f7ea6f7fc3 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2575,6 +2575,12 @@ static int __init pm_genpd_debug_init(void)
>  		return -ENOMEM;
>  
>  	list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
> +		if (!genpd->name) {
> +			pr_warn("%s: Must populate name of genpd for extended debugfs info.",
> +				__func__);
> +			continue;
> +		}
> +
>  		d = debugfs_create_dir(genpd->name, pm_genpd_debugfs_dir);
>  		if (!d)
>  			return -ENOMEM;
> 
