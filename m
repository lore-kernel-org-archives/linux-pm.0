From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC v6 1/5] PM / Domains: prepare for multiple states
Date: Thu, 30 Apr 2015 09:14:47 +0200
Message-ID: <CAMuHMdXL+Btqp9G6tP4H8FjjYavv1Umyr=87JSrf5a=KP4_N4w@mail.gmail.com>
References: <1430334615-1161-1-git-send-email-ahaslam@baylibre.com>
	<1430334615-1161-2-git-send-email-ahaslam@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:33035 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbbD3HOs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2015 03:14:48 -0400
Received: by oblw8 with SMTP id w8so38116784obl.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2015 00:14:47 -0700 (PDT)
In-Reply-To: <1430334615-1161-2-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Haslam <ahaslam@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benoit Cousson <bcousson@baylibre.com>, Linux PM list <linux-pm@vger.kernel.org>, Axel Haslam <ahaslam+renesas@baylibre.com>

On Wed, Apr 29, 2015 at 9:10 PM,  <ahaslam@baylibre.com> wrote:
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1882,10 +1882,14 @@ static int pm_genpd_default_restore_state(struct device *dev)
>   * pm_genpd_init - Initialize a generic I/O PM domain object.
>   * @genpd: PM domain object to initialize.
>   * @gov: PM domain governor to associate with the domain (may be NULL).
> + * @states: Array of possible low power states when powering off.
> + * @state_count: Number of low power states.
>   * @is_off: Initial value of the domain's power_is_off field.
>   */
>  void pm_genpd_init(struct generic_pm_domain *genpd,
> -                  struct dev_power_governor *gov, bool is_off)
> +                  struct dev_power_governor *gov,
> +                  const struct genpd_power_state *states,
> +                  int state_count, bool is_off)

unsigned int state.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
