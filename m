From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: cpufreq: Unable to set cpufreq to maximum
Date: Thu, 2 Oct 2014 18:10:33 +0200 (CEST)
Message-ID: <325740080.166772.1412266233250.JavaMail.open-xchange@oxbaltgw03.schlund.de>
References: <936524880.154802.1412255867221.JavaMail.open-xchange@oxbaltgw07.schlund.de> <1412258352.4875.5.camel@pengutronix.de> <878902771.162556.1412262099998.JavaMail.open-xchange@oxbaltgw01.schlund.de> <1412263338.2313.1.camel@pengutronix.de>
Reply-To: Stefan Wahren <stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:64341 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129AbaJBQKh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Oct 2014 12:10:37 -0400
In-Reply-To: <1412263338.2313.1.camel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, gregkh@linuxfoundation.org, festevam@gmail.com, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

Hi Lucas,

> Lucas Stach <l.stach@pengutronix.de> hat am 2. Oktober 2014 um 17:22
> geschrieben:
>
> [...]
> >
> > >
> > > Does it work if you just change this OPP to 454737 kHz?
> > >
> >
> > Yes after that i can change it with userspace governor. But i get this
> > warning
> > during modprobe:
> >
> > root@duckbill:~# modprobe cpufreq-cpu0
> > [ 48.573808] cpufreq: __cpufreq_add_dev: CPU0: Running at unlisted freq:
> > 454736 KHz
> > [ 48.604871] cpufreq: __cpufreq_add_dev: CPU0: Unlisted initial frequency
> > changed to: 454737 KHz
> >
> > I'm not sure if it's okay.
> >
> It's harmless in your case. But to get rid of it you might try the
> attached patch which may be an acceptable solution.
>
 
thanks a lot. The warning disappear after apply this patch :)
 
Stefan

> ------------------------------>8-----------------------------------
> From db9e708edf6451b619ee73f68c3fcde2eccd7b0c Mon Sep 17 00:00:00 2001
> From: Lucas Stach <l.stach@pengutronix.de>
> Date: Thu, 2 Oct 2014 17:20:09 +0200
> Subject: [PATCH] cpufreq: generic: try preserve some accuracy while
> converting
> from Hz to kHz
>
> ---
> drivers/cpufreq/cpufreq.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index d9fdeddcef96..459830c6576f 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -187,7 +187,7 @@ unsigned int cpufreq_generic_get(unsigned int cpu)
> return 0;
> }
>
> - return clk_get_rate(policy->clk) / 1000;
> + return DIV_ROUND_CLOSEST(clk_get_rate(policy->clk), 1000);
> }
> EXPORT_SYMBOL_GPL(cpufreq_generic_get);
>
> --
> 2.1.0
>
> --
> Pengutronix e.K. | Lucas Stach |
> Industrial Linux Solutions | http://www.pengutronix.de/ |
>
