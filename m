From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC v5 6/8] ARM: rmobile: pm: Convert to multiple states
Date: Sun, 26 Apr 2015 10:44:15 +0200
Message-ID: <CAMuHMdXd2Qq4c5voLeOoXXtvxJbJ2L6=fHBo1BAv7A56a_RL+Q@mail.gmail.com>
References: <1429896924-21540-1-git-send-email-ahaslam@baylibre.com>
	<1429896924-21540-7-git-send-email-ahaslam@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:34293 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbbDZIoQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 26 Apr 2015 04:44:16 -0400
Received: by obfe9 with SMTP id e9so64569266obf.1
        for <linux-pm@vger.kernel.org>; Sun, 26 Apr 2015 01:44:15 -0700 (PDT)
In-Reply-To: <1429896924-21540-7-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Haslam <ahaslam@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benoit Cousson <bcousson@baylibre.com>, Linux PM list <linux-pm@vger.kernel.org>

On Fri, Apr 24, 2015 at 7:35 PM,  <ahaslam@baylibre.com> wrote:
> --- a/arch/arm/mach-shmobile/pm-rmobile.c
> +++ b/arch/arm/mach-shmobile/pm-rmobile.c
> @@ -158,6 +164,8 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
>         genpd->dev_ops.active_wakeup    = rmobile_pd_active_wakeup;
>         genpd->power_off                = rmobile_pd_power_down;
>         genpd->power_on                 = rmobile_pd_power_up;
> +       genpd->states = rmobile_genpd_states;
> +       genpd->state_count = ARRAY_SIZE(rmobile_genpd_states);

The states are set _after_ pm_genpd_init(), so this won't work.

BTW, no idea why all these genpd fields are set after that call. Perhaps
originally they had to override defaults set by pm_genpd_init()?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
