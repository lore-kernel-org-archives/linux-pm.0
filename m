From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] cpufreq: dt: disable unsupported OPPs
Date: Fri, 5 Dec 2014 10:47:59 +0530
Message-ID: <CAKohpokjgNEhEzq6-Pkkn_nt0=TxgK4Q4oDqa7LdL62rqfwe-g@mail.gmail.com>
References: <1414155955-13640-1-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:43159 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbaLEFR7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Dec 2014 00:17:59 -0500
Received: by mail-ob0-f179.google.com with SMTP id va2so5246obc.24
        for <linux-pm@vger.kernel.org>; Thu, 04 Dec 2014 21:17:59 -0800 (PST)
In-Reply-To: <1414155955-13640-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Mark Brown <broonie@kernel.org>

Hi Lucas,

On 24 October 2014 at 18:35, Lucas Stach <l.stach@pengutronix.de> wrote:

> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c

>         if (!IS_ERR(cpu_reg)) {
> -               struct dev_pm_opp *opp;
> -               unsigned long min_uV, max_uV;
> -               int i;
> +               unsigned long opp_freq = 0;
>
>                 /*
> -                * OPP is maintained in order of increasing frequency, and
> -                * freq_table initialised from OPP is therefore sorted in the
> -                * same order.
> +                * Disable any OPPs where the connected regulator isn't able to
> +                * provide the specified voltage and record minimum and maximum
> +                * voltage levels.
>                  */
> -               for (i = 0; freq_table[i].frequency != CPUFREQ_TABLE_END; i++)
> -                       ;
> -               rcu_read_lock();
> -               opp = dev_pm_opp_find_freq_exact(cpu_dev,
> -                               freq_table[0].frequency * 1000, true);
> -               min_uV = dev_pm_opp_get_voltage(opp);
> -               opp = dev_pm_opp_find_freq_exact(cpu_dev,
> -                               freq_table[i-1].frequency * 1000, true);
> -               max_uV = dev_pm_opp_get_voltage(opp);
> -               rcu_read_unlock();
> +               while (1) {
> +                       struct dev_pm_opp *opp;
> +                       unsigned long opp_uV, tol_uV;
> +
> +                       rcu_read_lock();
> +                       opp = dev_pm_opp_find_freq_ceil(cpu_dev, &opp_freq);
> +                       if (IS_ERR(opp)) {
> +                               rcu_read_unlock();
> +                               break;
> +                       }
> +                       opp_uV = dev_pm_opp_get_voltage(opp);
> +                       rcu_read_unlock();
> +
> +                       tol_uV = opp_uV * priv->voltage_tolerance / 100;
> +                       if (regulator_is_supported_voltage(cpu_reg, opp_uV,
> +                                                          opp_uV + tol_uV)) {

Sorry for opening an relatively old thread. Shouldn't we instead do this here:

                       if (regulator_is_supported_voltage(cpu_reg,
opp_uV - tol_uV,
                                                          opp_uV + tol_uV)) {

??

Because the minimum voltage we will try to set is: min_uV - tol_uV (as we
do it with help of: regulator_set_voltage_tol())..

> +                               if (opp_uV < min_uV)
> +                                       min_uV = opp_uV;
> +                               if (opp_uV > max_uV)
> +                                       max_uV = opp_uV;

Also the min/max _uV we are using here to calculate latency *may* also
include the tolerance voltage ? i.e. min_uV = min_uV - tol_uV and
max_uV = max_uV + tol_volt ??

> +                       } else {
> +                               dev_pm_opp_disable(cpu_dev, opp_freq);
> +                       }
> +
> +                       opp_freq++;
> +               }
> +
>                 ret = regulator_set_voltage_time(cpu_reg, min_uV, max_uV);
>                 if (ret > 0)
>                         transition_latency += ret * 1000;
>         }
