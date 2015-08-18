From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] [RFC] PM / Domains: Remove unusable governor dummies
Date: Tue, 18 Aug 2015 14:19:39 +0200
Message-ID: <CAPDyKFo=VKvn-dvMnyZso3p86=sUu6_ZFH-X+D=DVdSwXmQvrA@mail.gmail.com>
References: <1439897882-10901-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:37226 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbbHRMTk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Aug 2015 08:19:40 -0400
Received: by igui7 with SMTP id i7so78090052igu.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2015 05:19:40 -0700 (PDT)
In-Reply-To: <1439897882-10901-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 18 August 2015 at 13:38, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> The governor dummies for the !CONFIG_PM_GENERIC_DOMAINS case are
> unusable, as a governors is always referred to by taking its address,
> which you can't do with a literal NULL pointer.
>
> I.e.
>
>         pm_genpd_init(genpd, &simple_qos_governor, false);
>
> fails to compile with:
>
>         error: lvalue required as unary '&' operand
>
> Hence just remove the governor dummies.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Looks good to me.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
> Alternatives:
>   - Prefix the real governors with "__", #define simple_qos_governor to
>     "&__simple_qos_governor" or "NULL", and drop the "&" in all users,
>   - Convert dummy pm_genpd_init() to a macro.
> ---
>  include/linux/pm_domain.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index b2725e6e8e7b94bc..b1cf7e797892b29d 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -221,8 +221,6 @@ static inline int pm_genpd_name_poweron(const char *domain_name)
>         return -ENOSYS;
>  }
>  static inline void pm_genpd_poweroff_unused(void) {}
> -#define simple_qos_governor NULL
> -#define pm_domain_always_on_gov NULL
>  #endif
>
>  static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
> --
> 1.9.1
>
