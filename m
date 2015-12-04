From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] PM / Domains: Validate cases of a non-bound driver in genpd governor
Date: Thu, 03 Dec 2015 16:05:22 -0800
Message-ID: <7htwnz13jx.fsf@deeprootsystems.com>
References: <1449061707-16030-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35762 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbbLDALI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2015 19:11:08 -0500
Received: by pfu207 with SMTP id 207so16435199pfu.2
        for <linux-pm@vger.kernel.org>; Thu, 03 Dec 2015 16:11:08 -0800 (PST)
In-Reply-To: <1449061707-16030-1-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Wed, 2 Dec 2015 14:08:27 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> Recently genpd removed the requirement of a having a driver bound for its
> attached devices to allow genpd to power off. That change should also have
> removed a corresponding validation in the governor, let's correct that.
>
> Fixes: 298cd0f08801 ("PM / Domains: Remove dev->driver check for runtime")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Kevin Hilman <khilman@linaro.org>

> ---
>  drivers/base/power/domain_governor.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
> index e60dd12..1e937ac 100644
> --- a/drivers/base/power/domain_governor.c
> +++ b/drivers/base/power/domain_governor.c
> @@ -160,9 +160,6 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
>  		struct gpd_timing_data *td;
>  		s64 constraint_ns;
>  
> -		if (!pdd->dev->driver)
> -			continue;
> -
>  		/*
>  		 * Check if the device is allowed to be off long enough for the
>  		 * domain to turn off and on (that's how much time it will
