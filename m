From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V2] devfreq: rk3399_dmc: Don't use OPP structures outside
 of RCU locks
Date: Tue, 6 Dec 2016 23:40:18 +0100
Message-ID: <CAJZ5v0iL9wvMfwqvpKVMEig=7xcoFtvhbgjOVche1Y58WfHnLw@mail.gmail.com>
References: <dcd19eb862a0de24b441f4d43473a01ae90e20e9.1480908064.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34879 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751905AbcLFWkU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Dec 2016 17:40:20 -0500
Received: by mail-wm0-f66.google.com with SMTP id a20so24461869wme.2
        for <linux-pm@vger.kernel.org>; Tue, 06 Dec 2016 14:40:19 -0800 (PST)
In-Reply-To: <dcd19eb862a0de24b441f4d43473a01ae90e20e9.1480908064.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kyungmin Park <kyungmin.park@samsung.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>

Hi MyungJoo,

On Mon, Dec 5, 2016 at 4:23 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The OPP structures are abused to the best here, without understanding
> how the OPP core and RCU locks work.
>
> In short, the OPP pointer saved in 'rk3399_dmcfreq' can become invalid
> under your nose, as the OPP core may free it.
>
> Fix various abuses around OPP structures and calls.
>
> Compile tested only.
>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V1->V2:
> - Added Reviewed-by from Chanwoo.
> - Fixed an issue reported by buildbot.

I think this along with https://patchwork.kernel.org/patch/9455789/
and https://patchwork.kernel.org/patch/9455757/ should go into
4.10-rc1.

Are you going to send a pull request for this before the merge window
or do you want me to apply them directly?


>  drivers/devfreq/rk3399_dmc.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> index 5063ac1a5939..75333050cdea 100644
> --- a/drivers/devfreq/rk3399_dmc.c
> +++ b/drivers/devfreq/rk3399_dmc.c
> @@ -80,7 +80,6 @@ struct rk3399_dmcfreq {
>         struct regulator *vdd_center;
>         unsigned long rate, target_rate;
>         unsigned long volt, target_volt;
> -       struct dev_pm_opp *curr_opp;
>  };
>
>  static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
> @@ -102,9 +101,6 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
>         target_rate = dev_pm_opp_get_freq(opp);
>         target_volt = dev_pm_opp_get_voltage(opp);
>
> -       dmcfreq->rate = dev_pm_opp_get_freq(dmcfreq->curr_opp);
> -       dmcfreq->volt = dev_pm_opp_get_voltage(dmcfreq->curr_opp);
> -
>         rcu_read_unlock();
>
>         if (dmcfreq->rate == target_rate)
> @@ -165,7 +161,9 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
>         if (err)
>                 dev_err(dev, "Cannot to set vol %lu uV\n", target_volt);
>
> -       dmcfreq->curr_opp = opp;
> +       dmcfreq->rate = target_rate;
> +       dmcfreq->volt = target_volt;
> +
>  out:
>         mutex_unlock(&dmcfreq->lock);
>         return err;
> @@ -431,8 +429,9 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>                 rcu_read_unlock();
>                 return PTR_ERR(opp);
>         }
> +       data->rate = dev_pm_opp_get_freq(opp);
> +       data->volt = dev_pm_opp_get_voltage(opp);
>         rcu_read_unlock();
> -       data->curr_opp = opp;
>
>         rk3399_devfreq_dmc_profile.initial_freq = data->rate;
>
> --

Thanks,
Rafael
