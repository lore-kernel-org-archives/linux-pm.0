From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: cpu0: Handle regulator_get_voltage() failure
Date: Mon, 6 Oct 2014 10:45:51 +0530
Message-ID: <CAKohpomUgU6V6P7AmSYadk+TrO0Gvi0qruRdN59PQbq4TL9G1w@mail.gmail.com>
References: <1412454365-17804-1-git-send-email-stefan.wahren@i2se.com>
	<1412454365-17804-3-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:32993 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528AbaJFFPv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Oct 2014 01:15:51 -0400
Received: by mail-oi0-f43.google.com with SMTP id u20so3119362oif.30
        for <linux-pm@vger.kernel.org>; Sun, 05 Oct 2014 22:15:51 -0700 (PDT)
In-Reply-To: <1412454365-17804-3-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@freescale.com>

On 5 October 2014 01:56, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> In error cases regulator_get_voltage() returns a negative value.
> So take care of it.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/cpufreq/cpufreq-cpu0.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
> index ef3d618..6aa2104 100644
> --- a/drivers/cpufreq/cpufreq-cpu0.c
> +++ b/drivers/cpufreq/cpufreq-cpu0.c
> @@ -77,7 +77,7 @@ static int cpu0_set_target(struct cpufreq_policy *policy, unsigned int index)
>         }
>
>         dev_dbg(cpu_dev, "%u MHz, %ld mV --> %u MHz, %ld mV\n",
> -               old_freq / 1000, volt_old ? volt_old / 1000 : -1,
> +               old_freq / 1000, (volt_old > 0) ? volt_old / 1000 : -1,
>                 new_freq / 1000, volt ? volt / 1000 : -1);
>
>         /* scaling up?  scale voltage before frequency */
> @@ -93,7 +93,7 @@ static int cpu0_set_target(struct cpufreq_policy *policy, unsigned int index)
>         ret = clk_set_rate(cpu_clk, freq_exact);
>         if (ret) {
>                 dev_err(cpu_dev, "failed to set clock rate: %d\n", ret);
> -               if (!IS_ERR(cpu_reg))
> +               if (!IS_ERR(cpu_reg) && volt_old > 0)
>                         regulator_set_voltage_tol(cpu_reg, volt_old, tol);
>                 return ret;
>         }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
