From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC v5 5/8] ARM: r8a7779: pm: Convert to multiple states
Date: Sun, 26 Apr 2015 10:43:57 +0200
Message-ID: <CAMuHMdWKGu1hJ=EE2_rw-2j-NLxg-uUe1sOfWW=ALR+ojVD3xQ@mail.gmail.com>
References: <1429896924-21540-1-git-send-email-ahaslam@baylibre.com>
	<1429896924-21540-6-git-send-email-ahaslam@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:35601 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbbDZIn6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 26 Apr 2015 04:43:58 -0400
Received: by obcux3 with SMTP id ux3so64552240obc.2
        for <linux-pm@vger.kernel.org>; Sun, 26 Apr 2015 01:43:57 -0700 (PDT)
In-Reply-To: <1429896924-21540-6-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Haslam <ahaslam@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benoit Cousson <bcousson@baylibre.com>, Linux PM list <linux-pm@vger.kernel.org>

On Fri, Apr 24, 2015 at 7:35 PM,  <ahaslam@baylibre.com> wrote:
> --- a/arch/arm/mach-shmobile/pm-r8a7779.c
> +++ b/arch/arm/mach-shmobile/pm-r8a7779.c
> @@ -79,6 +79,12 @@ static bool pd_active_wakeup(struct device *dev)
>         return true;
>  }
>
> +struct genpd_power_state r8a7779_genpd_states[] = {
> +       {
> +               .name = "OFF",
> +       }
> +};
> +
>  static void r8a7779_init_pm_domain(struct r8a7779_pm_domain *r8a7779_pd)
>  {
>         struct generic_pm_domain *genpd = &r8a7779_pd->genpd;
> @@ -88,6 +94,8 @@ static void r8a7779_init_pm_domain(struct r8a7779_pm_domain *r8a7779_pd)
>         genpd->dev_ops.active_wakeup = pd_active_wakeup;
>         genpd->power_off = pd_power_down;
>         genpd->power_on = pd_power_up;
> +       genpd->states = r8a7779_genpd_states;
> +       genpd->state_count = ARRAY_SIZE(r8a7779_genpd_states);

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
