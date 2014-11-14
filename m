From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / domains: Kconfig: always enable PM_RUNTIME when
 genpd enabled
Date: Fri, 14 Nov 2014 08:26:58 +0100
Message-ID: <CAPDyKFou5iwX2Oe9K6n=2u6xRAqUtVNRrDn736oo0kGf0GgaLQ@mail.gmail.com>
References: <1415917702-6742-1-git-send-email-khilman@kernel.org>
	<1415917702-6742-2-git-send-email-khilman@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:34783 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754323AbaKNH06 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Nov 2014 02:26:58 -0500
Received: by mail-qg0-f47.google.com with SMTP id j107so11627244qga.6
        for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2014 23:26:58 -0800 (PST)
In-Reply-To: <1415917702-6742-2-git-send-email-khilman@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Geert Uytterhoeven <geert+renesas@glider.be>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linaro-kernel <linaro-kernel@lists.linaro.org>, Kevin Hilman <khilman@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, open list <linux-kernel@vger.kernel.org>

On 13 November 2014 23:28, Kevin Hilman <khilman@kernel.org> wrote:
> From: Kevin Hilman <khilman@linaro.org>
>
> It makes little sense to use generic power domains without runtime PM.
> Also, since the complexities of handling the !PM_RUNTIME case are
> causing more trouble and confusion than they're worth, let's simplify
> the world by making genpd always enable runtime PM.

I do agree that your above statement seems reasonable, even if can't
really tell if that would break some SOCs use-cases.

My concern is though, that I fear we will be taking short-cuts in
genpd that might bite us later on, but I might be wrong.

The reason for my concern is that on every other place, like in the
subsystem level, driver core, PM core and of course in drivers -  we
need to cope with all the combinations of CONFIG_PM_SLEEP and
CONFIG_PM_SLEEP.  So theoretically, why shouldn't genpd be able to do
that as well?

>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>
> ---
>  kernel/power/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 3d39cc0228e9..2a8c64d0a43c 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -271,7 +271,7 @@ config PM_CLK
>
>  config PM_GENERIC_DOMAINS
>         bool
> -       depends on PM
> +       select PM_RUNTIME

Shouldn't we actually depend on PM_RUNTIME instead?

>
>  config WQ_POWER_EFFICIENT_DEFAULT
>         bool "Enable workqueue power-efficient mode by default"
> --
> 2.1.3
>

Kind regards
Uffe
