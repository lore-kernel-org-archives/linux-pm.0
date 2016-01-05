From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH V3 2/2] PM / OPP: Parse 'opp-<prop>-<name>' bindings
Date: Tue, 5 Jan 2016 11:31:41 +0100
Message-ID: <CAMuHMdUXHU7d_X9PpWTVDc9iE3knd0N-iQKT2FeDhX6mOg13tg@mail.gmail.com>
References: <cover.1449627691.git.viresh.kumar@linaro.org>
	<e3744c43a5ad26e9e49cf938b3ecd846cc500fce.1449627691.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:32862 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbcAEKbm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jan 2016 05:31:42 -0500
In-Reply-To: <e3744c43a5ad26e9e49cf938b3ecd846cc500fce.1449627691.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@codeaurora.org>, Viresh Kumar <vireshk@kernel.org>

Hi Viresh,

On Wed, Dec 9, 2015 at 3:31 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> OPP bindings (for few properties) allow a platform to choose a
> value/range among a set of available options. The options are present as
> opp-<prop>-<name>, where the platform needs to supply the <name> string.
>
> The OPP properties which allow such an option are: opp-microvolt and
> opp-microamp.
>
> Add support to the OPP-core to parse these bindings, by introducing
> dev_pm_opp_{set|put}_prop_name() APIs.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

> @@ -794,35 +797,48 @@ static int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
>  }
>
>  /* TODO: Support multiple regulators */
> -static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev)
> +static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
> +                             struct device_opp *dev_opp)
>  {
>         u32 microvolt[3] = {0};
>         u32 val;
>         int count, ret;
> +       struct property *prop = NULL;
> +       char name[NAME_MAX];
> +
> +       /* Search for "opp-microvolt-<name>" */
> +       if (dev_opp->prop_name) {
> +               sprintf(name, "opp-microvolt-%s", dev_opp->prop_name);

Any chance an attacker can overflow name[] by providing a very long
dev_opp->prop_name?

Better safe than sorry:

        snprintf(name, sizeof(name), ...);

> +               prop = of_find_property(opp->np, name, NULL);
> +       }

> @@ -830,7 +846,20 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev)
>         opp->u_volt_min = microvolt[1];
>         opp->u_volt_max = microvolt[2];
>
> -       if (!of_property_read_u32(opp->np, "opp-microamp", &val))
> +       /* Search for "opp-microamp-<name>" */
> +       prop = NULL;
> +       if (dev_opp->prop_name) {
> +               sprintf(name, "opp-microamp-%s", dev_opp->prop_name);

Likewise

> +               prop = of_find_property(opp->np, name, NULL);
> +       }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
