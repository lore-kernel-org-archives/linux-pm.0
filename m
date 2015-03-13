From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/9] pm: domains: avoid potential oops in pm_genpd_remove_device()
Date: Fri, 13 Mar 2015 09:56:02 +0100
Message-ID: <CAPDyKFq8P7eceHkPFDnyUwpfjEN_0ao0NDLoxNjE7h4KDBL=qA@mail.gmail.com>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
	<E1YW7sq-0003m6-89@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:38630 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887AbbCMI4D (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 04:56:03 -0400
Received: by qgdz60 with SMTP id z60so24288516qgd.5
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2015 01:56:02 -0700 (PDT)
In-Reply-To: <E1YW7sq-0003m6-89@rmk-PC.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 12 March 2015 at 19:31, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> pm_genpd_remove_device() should only be called with valid and present
> pm domain.  There are circumstances where we may end up with something
> that isn't a generic PM domain in dev->pm_domain (eg, vga_switcheroo
> stuff.)

Could the "vga_switcheroo" code deal with this instead?

>
> Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/base/power/domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index b3fbc21da2dc..11a1023fa64a 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1509,7 +1509,7 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
>
>         dev_dbg(dev, "%s()\n", __func__);
>
> -       if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev)
> +       if (!pm_genpd_present(genpd) || IS_ERR_OR_NULL(dev)

The are two issues with this approach.

1. pm_genpd_present() is build only for CONFIG_PM_SLEEP set.
2. pm_genpd_present() totally ignores holding the mutex which protects
the list of GPDs.

>             ||  IS_ERR_OR_NULL(dev->pm_domain)
>             ||  pd_to_genpd(dev->pm_domain) != genpd)
>                 return -EINVAL;
> --
> 1.8.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Kind regards
Uffe
