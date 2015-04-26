From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC v5 1/8] PM / Domains: structure changes for multiple states
Date: Sun, 26 Apr 2015 10:42:00 +0200
Message-ID: <CAMuHMdWx=g+NLOcJyCAzhFjM-woMEzZQq1Tn4d+ctpGmzyzDxA@mail.gmail.com>
References: <1429896924-21540-1-git-send-email-ahaslam@baylibre.com>
	<1429896924-21540-2-git-send-email-ahaslam@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:34742 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbbDZImB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 26 Apr 2015 04:42:01 -0400
Received: by obfe9 with SMTP id e9so64555545obf.1
        for <linux-pm@vger.kernel.org>; Sun, 26 Apr 2015 01:42:00 -0700 (PDT)
In-Reply-To: <1429896924-21540-2-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Haslam <ahaslam@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benoit Cousson <bcousson@baylibre.com>, Linux PM list <linux-pm@vger.kernel.org>

On Fri, Apr 24, 2015 at 7:35 PM,  <ahaslam@baylibre.com> wrote:
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c

> @@ -1438,6 +1458,54 @@ static void genpd_free_dev_data(struct device *dev,
>         kfree(gpd_data);
>         dev_pm_put_subsys_data(dev);
>  }
> +/**
> + * genpd_alloc_states_data - Allocate and copy state parameters
> + * @genpd: PM domain use to copy and allocate data
> + */
> +static struct genpd_power_state *genpd_alloc_states_data(
> +                       struct generic_pm_domain *genpd)
> +{
> +       struct genpd_power_state *states;
> +       size_t states_size;
> +       int i;
> +
> +       if (IS_ERR_OR_NULL(genpd))
> +               return NULL;
> +
> +       if (!genpd->states) {
> +               pr_err("%s Null state pointer\n", genpd->name);
> +               return NULL;
> +       }
> +
> +       if (genpd->state_count < 1) {
> +               pr_err("%s Invalid number of states %d\n",
> +                       genpd->name, genpd->state_count);
> +               return NULL;
> +       }
> +
> +       /* Allocate the local memory to keep the states for this genpd */
> +       states_size = sizeof(*states) * genpd->state_count;
> +       states = kzalloc(states_size, GFP_KERNEL);
> +       if (!states) {
> +               pr_err("%s states Allocation error\n", genpd->name);
> +               return NULL;
> +       }
> +
> +       /* Copy the parameters passed to the allocated structure */
> +       for (i = 0; i < genpd->state_count; i++) {
> +               states[i].power_off_latency_ns =
> +                       genpd->states[i].power_off_latency_ns;
> +               states[i].power_on_latency_ns =
> +                       genpd->states[i].power_on_latency_ns;
> +       }
> +
> +#ifdef CONFIG_PM_ADVANCED_DEBUG
> +       /* State name is used for debug. Avoid unnecessary allocations */
> +       for (i = 0; i < genpd->state_count; i++)
> +               states[i].name = kstrdup(genpd->states[i].name, GFP_KERNEL);
> +#endif
> +       return states;
> +}
>
>  /**
>   * __pm_genpd_add_device - Add a device to an I/O PM domain.
> @@ -1863,6 +1931,13 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
>         if (IS_ERR_OR_NULL(genpd))
>                 return;
>
> +       if (genpd->state_count > 0) {
> +               /* Copy the state data to allocated memory */
> +               genpd->states = genpd_alloc_states_data(genpd);
> +               if (!genpd->states)
> +                       return;
> +       }
> +

So the above replaces genpd->states (which is usually pointing to a an
array of static data) by an allocated copy?
Nice trick, but I'm wondering whether it may bite us one day?
This also means the static data can't be const.

Both could be solved by e.g. passing the states array to pm_genpd_init().

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
