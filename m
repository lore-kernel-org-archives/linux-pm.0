From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [RFC PATCH] PM / Domains: Ensure subdomain is not in use before removing
Date: Fri, 28 Aug 2015 10:38:03 -0700
Message-ID: <7hbndr48lg.fsf@deeprootsystems.com>
References: <1440667276-8986-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35422 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544AbbH1RiG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2015 13:38:06 -0400
Received: by pacdd16 with SMTP id dd16so69133127pac.2
        for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2015 10:38:06 -0700 (PDT)
In-Reply-To: <1440667276-8986-1-git-send-email-jonathanh@nvidia.com> (Jon
	Hunter's message of "Thu, 27 Aug 2015 10:21:16 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, geert@linux-m68k.org, linux-pm@vger.kernel.org

Jon Hunter <jonathanh@nvidia.com> writes:

> The function pm_genpd_remove_subdomain() removes a subdomain from a
> generic PM domain, however, it does not check if the subdomain has any
> slave domains or device attached before doing so. Therefore, add a test
> to verify that the subdomain does not have any slave domains associated
> or any device attached before removing.
>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/base/power/domain.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 27888a90ca98..a3ed71d8129a 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1469,6 +1469,11 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>  
>  	mutex_lock(&genpd->lock);
>  
> +	if (!list_empty(&subdomain->slave_links) || subdomain->device_count) {

maybe a pr_warn() or similar is appropriate here?

> +		ret = -EBUSY;
> +		goto out;
> +	}
> +

... otherwise looks like a good check to add.

Acked-by: Kevin Hilman <khilman@linaro.org>
