From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 1/3] PM / Domains: Initial PM clock support for genpd
Date: Fri, 28 Nov 2014 08:26:28 +0100
Message-ID: <CAPDyKFp8sSCAt-oZTex-UG1RAFUYQBRPwbKuGmYiGP+0OtaTYw@mail.gmail.com>
References: <1417099911-12688-1-git-send-email-ulf.hansson@linaro.org>
	<1417099911-12688-2-git-send-email-ulf.hansson@linaro.org>
	<3169286.RI9fuSo8ZA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:38762 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbaK1H03 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 02:26:29 -0500
Received: by mail-qa0-f42.google.com with SMTP id j7so4228076qaq.29
        for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2014 23:26:28 -0800 (PST)
In-Reply-To: <3169286.RI9fuSo8ZA@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Arnd Bergmann <arnd@arndb.de>

>
> If you defined the flag as
>
>         #define PM_DOMAIN_FLAGS_PM_CLK  (1U << 0)
>
> (which is a kind of usual way to do that), you wouldn't need the
> bitops.h above.
>
> Moreover, I personally don't like #defines in struct definitions.
>
>>
>> @@ -76,6 +77,8 @@ struct generic_pm_domain {
>>                         struct device *dev);
>>       void (*detach_dev)(struct generic_pm_domain *domain,
>>                          struct device *dev);
>> +     unsigned int flags;             /* Bit field of configs for genpd */
>> +#define PM_DOMAIN_PM_CLK     BIT(0)  /* PM domain uses PM clk */

While I fix your above comments, I wonder whether I actually also
should change the prefix of the define as well.
>From "PM_DOMAIN" to "GENPD". Cause I think it's a genpd specific
define and not a "PM domain" define. Please tell me if you have any
objections to that.

>>  };
>>
>>  static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
>>
>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.


Thanks for review!

Kind regards
Uffe
