From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 7/8] PM / Domains: Fix missing default_power_down_ok comment
Date: Tue, 13 Jun 2017 12:39:35 +0200
Message-ID: <CAPDyKFryAji5ZFkhuN24zNCjPf2kcfvzVgxC9j1ub3L59LRVTg@mail.gmail.com>
References: <20170612151748.7380-1-krzk@kernel.org> <20170612151748.7380-8-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:35620 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752078AbdFMKjg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jun 2017 06:39:36 -0400
Received: by mail-qt0-f171.google.com with SMTP id w1so164602203qtg.2
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2017 03:39:36 -0700 (PDT)
In-Reply-To: <20170612151748.7380-8-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 12 June 2017 at 17:17, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Commit fc5cbf0c94b6 ("PM / Domains: Support for multiple states") split
> out some code out of default_power_down_ok() function so the
> documentation has to be moved to appropriate place.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/base/power/domain_governor.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
> index 2e0fce711135..281f949c5ffe 100644
> --- a/drivers/base/power/domain_governor.c
> +++ b/drivers/base/power/domain_governor.c
> @@ -92,12 +92,6 @@ static bool default_suspend_ok(struct device *dev)
>         return td->cached_suspend_ok;
>  }
>
> -/**
> - * default_power_down_ok - Default generic PM domain power off governor routine.
> - * @pd: PM domain to check.
> - *
> - * This routine must be executed under the PM domain's lock.
> - */
>  static bool __default_power_down_ok(struct dev_pm_domain *pd,
>                                      unsigned int state)
>  {
> @@ -187,6 +181,12 @@ static bool __default_power_down_ok(struct dev_pm_domain *pd,
>         return true;
>  }
>
> +/**
> + * default_power_down_ok - Default generic PM domain power off governor routine.
> + * @pd: PM domain to check.
> + *
> + * This routine must be executed under the PM domain's lock.
> + */
>  static bool default_power_down_ok(struct dev_pm_domain *pd)
>  {
>         struct generic_pm_domain *genpd = pd_to_genpd(pd);
> --
> 2.9.3
>
