From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM: Avoid false-positive warnings in dev_pm_domain_set()
Date: Wed, 3 Feb 2016 10:58:21 +0100
Message-ID: <CAPDyKFoCO6DY55+rsEhXqcA6dA12PvejroxDoS8G+SPKZsPWJA@mail.gmail.com>
References: <80793506.EZRY3UmSeu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:33315 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753101AbcBCJ6W (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2016 04:58:22 -0500
Received: by mail-yk0-f181.google.com with SMTP id z13so13671065ykd.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Feb 2016 01:58:22 -0800 (PST)
In-Reply-To: <80793506.EZRY3UmSeu@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Kevin Hilman <khilman@kernel.org>

On 30 January 2016 at 12:54, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> There is a WARN_ON() in dev_pm_domain_set() that triggers on attempts
> to set the pm_domain pointer for devices with a driver bound.
>
> However, that WARN_ON() triggers on attempts to clear the pointer
> too and the test it uses is based on checking the device's
> p->knode_driver pointer which still is set when the device bus
> type's/driver's ->remove callback has been executed.  This
> leads to false-positive warnings when bus type code calls
> dev_pm_domain_set() to clear the pm_domain pointer after
> invoking the driver's ->remove() callback.
>
> To avoid those false-positives, make dev_pm_domain_set() check
> if the pointer passed to it is NULL and skip the warning in
> that case.
>
> Fixes: 989561de9b51 (PM / Domains: add setter for dev.pm_domain)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/common.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: linux-pm/drivers/base/power/common.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/common.c
> +++ linux-pm/drivers/base/power/common.c
> @@ -146,7 +146,7 @@ void dev_pm_domain_set(struct device *de
>         if (dev->pm_domain == pd)
>                 return;
>
> -       WARN(device_is_bound(dev),
> +       WARN(pd && device_is_bound(dev),
>              "PM domains can only be changed for unbound devices\n");

Perhaps this information then becomes a bit misleading, as it's okay
to clear the pointer, but not assign it to a valid PM domain.

>         dev->pm_domain = pd;
>         device_pm_check_callbacks(dev);
>

Otherwise, this looks good to me!

Kind regards
Uffe
