From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC v6 4/5] ARM: imx6: pm: declare pm domain latency on
 power_state struct.
Date: Thu, 30 Apr 2015 09:20:29 +0200
Message-ID: <CAMuHMdWvfNbovYNa_guYfCN4ZjY1Ep-Z9D_fL0sUyrv50LZArw@mail.gmail.com>
References: <1430334615-1161-1-git-send-email-ahaslam@baylibre.com>
	<1430334615-1161-5-git-send-email-ahaslam@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:34916 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbbD3HUa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2015 03:20:30 -0400
Received: by obcux3 with SMTP id ux3so37964916obc.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2015 00:20:29 -0700 (PDT)
In-Reply-To: <1430334615-1161-5-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Haslam <ahaslam@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benoit Cousson <bcousson@baylibre.com>, Linux PM list <linux-pm@vger.kernel.org>, Axel Haslam <ahaslam+renesas@baylibre.com>

On Wed, Apr 29, 2015 at 9:10 PM,  <ahaslam@baylibre.com> wrote:
> --- a/arch/arm/mach-imx/gpc.c
> +++ b/arch/arm/mach-imx/gpc.c
> @@ -45,9 +45,11 @@
>
>  struct pu_domain {
>         struct generic_pm_domain base;
> +       struct genpd_power_state *states;
>         struct regulator *reg;
>         struct clk *clk[GPC_CLK_MAX];
>         int num_clks;
> +       int num_states;

unsigned int

(BTW, num_clks and the loop counter iterating over it should be unsigned, too).

>  };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
