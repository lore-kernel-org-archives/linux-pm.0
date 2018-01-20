From: Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH v3 1/2] PM / OPP: introduce an OPP power estimation helper
Date: Fri, 19 Jan 2018 20:10:46 -0800
Message-ID: <CAJWu+orBCzCxre8adtjP6r8Hh=DQRfwzANU9_sA4SL3SWiiZpw@mail.gmail.com>
References: <20180119094549.5468-1-quentin.perret@arm.com> <20180119094549.5468-2-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:33055 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753645AbeATEKs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jan 2018 23:10:48 -0500
Received: by mail-it0-f67.google.com with SMTP id c102so6795002itd.0
        for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2018 20:10:48 -0800 (PST)
In-Reply-To: <20180119094549.5468-2-quentin.perret@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, amit.kachhap@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, matthias.bgg@gmail.com, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, Todd Kjos <tkjos@google.com>

On Fri, Jan 19, 2018 at 1:45 AM, Quentin Perret <quentin.perret@arm.com> wrote:
> The power dissipated by a CPU at a specific OPP is currently estimated by
> the thermal subsystem as P = C * V^2 * f, with P the power, C the CPU's
> capacitance, V the OPP's voltage and f the OPP's frequency. As this
> feature can be useful for other clients requiring energy models of CPUs,
> this commit introduces an equivalent power estimator directly into the OPP
> library, hence enabling code re-use.
>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  drivers/opp/core.c     | 32 ++++++++++++++++++++++++++++++++
>  drivers/opp/of.c       | 11 +++++++----
>  drivers/opp/opp.h      |  7 +++++++
>  include/linux/pm_opp.h |  7 +++++++
>  4 files changed, 53 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 92fa94a6dcc1..81bf18554b34 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -127,6 +127,24 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
>
> +/**
> + * dev_pm_opp_get_power() - Gets the estimated power corresponding to an opp
> + * @opp:       opp for which power has to be returned for
> + *
> + * Return: estimated power in micro-watts corresponding to the opp, else
> + * return 0
> + */
> +unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp)
> +{
> +       if (IS_ERR_OR_NULL(opp)) {
> +               pr_err("%s: Invalid parameters\n", __func__);
> +               return 0;
> +       }
> +
> +       return opp->power_estimate_uw;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_get_power);
> +
>  /**
>   * dev_pm_opp_is_turbo() - Returns if opp is turbo OPP or not
>   * @opp: opp for which turbo mode is being verified
> @@ -985,6 +1003,18 @@ static bool _opp_supported_by_regulators(struct dev_pm_opp *opp,
>         return true;
>  }
>
> +/**
> + * Estimate the power of an OPP as P = C * V^2 * f, with C the device's
> + * capacitance, V the OPP's voltage and f the OPP's frequency.
> + */
> +static void _opp_estimate_power(struct dev_pm_opp *opp, unsigned long cap)
> +{
> +       unsigned long mV = opp->supplies[0].u_volt / 1000;
> +       unsigned long KHz = opp->rate / 1000;
> +
> +       opp->power_estimate_uw = cap * mV * mV * KHz / 1000000000;

Also, here you can do the multiples first and then the divides to get
better accuracy with lesser rounding.

- Joel
