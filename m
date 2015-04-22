From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC v4 1/8] PM / Domains: structure changes for multiple states
Date: Wed, 22 Apr 2015 13:17:39 +0200
Message-ID: <CAMuHMdXs_Wytg7xwyQP=+L8enzoT2JBg78YTFe59Zp5K8vbq_A@mail.gmail.com>
References: <1429695935-15815-1-git-send-email-ahaslam@baylibre.com>
	<1429695935-15815-2-git-send-email-ahaslam@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:32999 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbbDVLRk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2015 07:17:40 -0400
Received: by oica37 with SMTP id a37so173704127oic.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2015 04:17:39 -0700 (PDT)
In-Reply-To: <1429695935-15815-2-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ahaslam@baylibre.com
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benoit Cousson <bcousson@baylibre.com>, Linux PM list <linux-pm@vger.kernel.org>

On Wed, Apr 22, 2015 at 11:45 AM,  <ahaslam@baylibre.com> wrote:
> From: Axel Haslam <ahaslam@baylibre.com>
>
> Add the structure changes to be able to declare
> multiple states. When trying to set a power domain
> to off, genpd will be able to choose from an array
> of states declared by the platform.
>
> The power on and off callbacks and latencies are
> now tied to a particular state.
>
> States should be declared in ascending order from
> shallowest to deepest, deepest meaning the state
> which takes longer to enter and exit.
>
> if the genpd is initially off, the user should set the
> .init_state field when registering the genpd,
> so that genpd knows which callbacks to call to set the
> domain to on.

The initial state may depend on various factors (hardware default,
boot loader, previously loaded kernel, ...). This is even true with the
current binary states.

> index 45937f8..f60a175 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c

> @@ -154,23 +155,24 @@ static void genpd_recalc_cpu_exit_latency(struct generic_pm_domain *genpd)
>
>  static int genpd_power_on(struct generic_pm_domain *genpd)
>  {
> +       int target_state = genpd->target_state;
>         ktime_t time_start;
>         s64 elapsed_ns;
>         int ret;
>
> -       if (!genpd->power_on)
> +       if (!genpd->states[target_state].power_on)
>                 return 0;
>

While your series now looks compilable for all patch steps, it's not
bisectable: the right hook won't be called until the platform is
converted to support multiple states.

I think you can fix this by e.g. using -1 for the target_state on non-converted
platforms, and doing:

        if (target_state < 0) {
                if (!genpd->power_on)
                        return 0;
        } else {
                if (!genpd->states[target_state].power_on)
                        return 0;
        }

and

        ret = target_state < 0 ? genpd->power_on(genpd)
                               : genpd->states[target_state].power_on(genpd);

The checks for a negative target_state can be removed only after
all platforms have been converted.

> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -17,6 +17,8 @@
>  #include <linux/notifier.h>
>  #include <linux/cpuidle.h>
>
> +#define GENPD_MAX_NSTATES 10
> +
>  /* Defines used for the flags field in the struct generic_pm_domain */
>  #define GENPD_FLAG_PM_CLK      (1U << 0) /* PM domain uses PM clk */
>
> @@ -46,6 +48,16 @@ struct gpd_cpuidle_data {
>         struct cpuidle_state *idle_state;
>  };
>
> +struct generic_pm_domain;
> +
> +struct genpd_power_state {
> +       char *name;
> +       s64 power_off_latency_ns;
> +       s64 power_on_latency_ns;
> +       int (*power_off)(struct generic_pm_domain *domain);
> +       int (*power_on)(struct generic_pm_domain *domain);
> +};
> +
>  struct generic_pm_domain {
>         struct dev_pm_domain domain;    /* PM domain operations */
>         struct list_head gpd_list_node; /* Node in the global PM domains list */
> @@ -80,6 +92,11 @@ struct generic_pm_domain {
>         void (*detach_dev)(struct generic_pm_domain *domain,
>                            struct device *dev);
>         unsigned int flags;             /* Bit field of configs for genpd */
> +
> +       struct genpd_power_state states[GENPD_MAX_NSTATES];

I think states should be a pointer to an array, not an array of 10 entries, to
avoid wasting memory on systems with a small number of states.

E.g. on r8a73a4, we have 24 PM Domains.
That would waste 24 * 9 * 32 = 6912 bytes of memory.

What about keeping the .power_o{ff,n}() callbacks in struct generic_pm_domain,
but adding a state index parameter to the callbacks?
That would save even more memory on systems where all callbacks are identical.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
