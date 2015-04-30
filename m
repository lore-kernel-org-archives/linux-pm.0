From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC v6 2/5] PM / Domains: core changes for multiple states
Date: Thu, 30 Apr 2015 09:18:58 +0200
Message-ID: <CAMuHMdUApRkxcNnqRpcMMsEdGE8TGWE3uhHETai=JAoxBKzadQ@mail.gmail.com>
References: <1430334615-1161-1-git-send-email-ahaslam@baylibre.com>
	<1430334615-1161-3-git-send-email-ahaslam@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:35007 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbbD3HS7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2015 03:18:59 -0400
Received: by obcux3 with SMTP id ux3so37942836obc.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2015 00:18:58 -0700 (PDT)
In-Reply-To: <1430334615-1161-3-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Haslam <ahaslam@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benoit Cousson <bcousson@baylibre.com>, Linux PM list <linux-pm@vger.kernel.org>, Axel Haslam <ahaslam+renesas@baylibre.com>

On Wed, Apr 29, 2015 at 9:10 PM,  <ahaslam@baylibre.com> wrote:
> From: Axel Haslam <ahaslam+renesas@baylibre.com>
>
> Add the core changes to be able to declare multiple states.
> When trying to set a power domain to off, genpd will be able
> to choose from an array of states declared by the platform.
>
> The power on and off latencies are now tied to a state.
>
> States should be declared in ascending order from shallowest
> to deepest, deepest meaning the state which takes longer to
> enter and exit.
>
> the power_off and power_on function can use the 'state_idx'
> field of the generic_pm_domain structure, to distinguish between
> the different states and act accordingly.
>
>  - if the genpd is initially off, the user should set the state_idx
>    field when registering the genpd.
>
>  - if no states are passed to pm_genpd_init, a single OFF
>    state with no latency is assumed.
>
> Example:
>
> static int pd1_power_on(struct generic_pm_domain *domain)
> {
>         /* domain->state_idx = state the domain is coming from */
> }
>
> static int pd1_power_off(struct generic_pm_domain *domain)
> {
>         /* domain->state_idx = desired powered off state */
> }
>
> struct genpd_power_state pd_states[] = {

const

>         {
>                 .name = "RET",
>                 .power_on_latency_ns = ON_LATENCY_FAST,
>                 .power_off_latency_ns = OFF_LATENCY_FAST,
>         },
>         {
>                 .name = "DEEP_RET",
>                 .power_on_latency_ns = ON_LATENCY_MED,
>                 .power_off_latency_ns = OFF_LATENCY_MED,
>         },
>         {
>                 .name = "OFF",
>                 .power_on_latency_ns = ON_LATENCY_SLOW,
>                 .power_off_latency_ns = OFF_LATENCY_SLOW,
>         }
> };
>
> struct generic_pm_domain pd1 = {
>         .name = "PD1",
>         .state_idx = 2, /* needed if domain is not on at init. */
>         .power_on = pd1_power_on,
>         .power_off = pd1_power_off,
>         ...
> };
>
> int xxx_init_pm_domain(){
>
>         pm_genpd_init(struct generic_pm_domain,
>                         pd1, pd_states, ARRAY_SIZE(pd_states), true);
>
> }
>
> Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>

> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 3849312..4ea1365 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c

> @@ -170,12 +176,13 @@ static void genpd_set_active(struct generic_pm_domain *genpd)
>
>  static void genpd_recalc_cpu_exit_latency(struct generic_pm_domain *genpd)
>  {
> +       int state_idx = genpd->state_idx;

unsigned int (everywhere)

> @@ -1468,6 +1479,61 @@ static void genpd_free_dev_data(struct device *dev,
>         dev_pm_put_subsys_data(dev);
>  }
>
> +static int genpd_alloc_states_data(struct generic_pm_domain *genpd,
> +                                  const struct genpd_power_state *st,
> +                                  int st_count)
> +{

> +       /*
> +        * Copy the latency values To keep compatibility with
> +        * platfroms that are not converted to use the multiple states.

platforms

> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 96265d5..8a3d43f 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -86,6 +86,10 @@ struct generic_pm_domain {
>         void (*detach_dev)(struct generic_pm_domain *domain,
>                            struct device *dev);
>         unsigned int flags;             /* Bit field of configs for genpd */
> +       struct genpd_power_state *states;
> +       int state_count; /* number of states */
> +       int state_idx; /* state that genpd will go to when off */

unsigned int (both).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
