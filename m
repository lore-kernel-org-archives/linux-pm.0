From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq: Unable to set cpufreq to maximum
Date: Mon, 6 Oct 2014 09:51:30 +0530
Message-ID: <CAKohpom_kJadzUiPAT9GBJjvcu=38L9fO1atoi24xGwrq9XDFg@mail.gmail.com>
References: <936524880.154802.1412255867221.JavaMail.open-xchange@oxbaltgw07.schlund.de>
	<1412258352.4875.5.camel@pengutronix.de>
	<878902771.162556.1412262099998.JavaMail.open-xchange@oxbaltgw01.schlund.de>
	<1412263338.2313.1.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:57838 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbaJFEVa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Oct 2014 00:21:30 -0400
Received: by mail-ob0-f178.google.com with SMTP id wn1so3310284obc.23
        for <linux-pm@vger.kernel.org>; Sun, 05 Oct 2014 21:21:30 -0700 (PDT)
In-Reply-To: <1412263338.2313.1.camel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabio Estevam <festevam@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 2 October 2014 20:52, Lucas Stach <l.stach@pengutronix.de> wrote:
> It's harmless in your case. But to get rid of it you might try the
> attached patch which may be an acceptable solution.
>
> ------------------------------>8-----------------------------------
> From db9e708edf6451b619ee73f68c3fcde2eccd7b0c Mon Sep 17 00:00:00 2001
> From: Lucas Stach <l.stach@pengutronix.de>
> Date: Thu, 2 Oct 2014 17:20:09 +0200
> Subject: [PATCH] cpufreq: generic: try preserve some accuracy while
> converting
>  from Hz to kHz
>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index d9fdeddcef96..459830c6576f 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -187,7 +187,7 @@ unsigned int cpufreq_generic_get(unsigned int cpu)
>                 return 0;
>         }
>
> -       return clk_get_rate(policy->clk) / 1000;
> +       return DIV_ROUND_CLOSEST(clk_get_rate(policy->clk), 1000);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_generic_get);

Absolutely NOT..

This can't be an acceptable solution to the problem you have in your DT.
This routine is used for getting the current frequency of a CPU and we
can't play with that..

The problem that Stefan is getting is: The boot loader has programmed
cpu to a frequency which isn't present in your DT table. And so kernel
tries to adjust CPU frequency to one of the listed frequencies.

Solutions:
- Add another entry to your DT table to reflect the currently programmed
frequency.
- Just ignore the error, as that is just for information.
