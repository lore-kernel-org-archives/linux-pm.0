From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: cpufreq: Unable to set cpufreq to maximum
Date: Thu, 02 Oct 2014 17:22:18 +0200
Message-ID: <1412263338.2313.1.camel@pengutronix.de>
References: <936524880.154802.1412255867221.JavaMail.open-xchange@oxbaltgw07.schlund.de>
	 <1412258352.4875.5.camel@pengutronix.de>
	 <878902771.162556.1412262099998.JavaMail.open-xchange@oxbaltgw01.schlund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52602 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754319AbaJBPWY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Oct 2014 11:22:24 -0400
In-Reply-To: <878902771.162556.1412262099998.JavaMail.open-xchange@oxbaltgw01.schlund.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, gregkh@linuxfoundation.org, festevam@gmail.com, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

Am Donnerstag, den 02.10.2014, 17:01 +0200 schrieb Stefan Wahren:
> Hi Lucas,
> 
> > Lucas Stach <l.stach@pengutronix.de> hat am 2. Oktober 2014 um 15:59
> > geschrieben:
> >
> >
> > Am Donnerstag, den 02.10.2014, 15:17 +0200 schrieb Stefan Wahren:
> > > Hi,
> > >
> > > i currently try to get cpufreq-cpu0 aka cpufreq-dt running on Freescale
> > > i.MX28
> > > (ARM). First i ported the regulator driver and now i want to test it with
> > > cpufreq-cpu0. Everything works fine except changing back to maximum
> > > frequency
> > > 454736 kHz. I get the following error:
> > >
> >> [...]
> > >
> > > Any ideas?
> >
> > Isn't your highest OPP just wrong? Apparently the CPU clock (which is a
> > fixed PLL plus a divider on MX28 if I'm not mistaken) is only able to
> > provide a slightly higher frequency than your OPP. cpufreq handles that
> > as an error, which is valid behavior as going higher than the defined
> > OPP may not be qualified by the vendor.
>  
> I hope so.
> 
> >
> > Does it work if you just change this OPP to 454737 kHz?
> >
>  
> Yes after that i can change it with userspace governor. But i get this warning
> during modprobe:
>  
> root@duckbill:~# modprobe cpufreq-cpu0
> [   48.573808] cpufreq: __cpufreq_add_dev: CPU0: Running at unlisted freq:
> 454736 KHz
> [   48.604871] cpufreq: __cpufreq_add_dev: CPU0: Unlisted initial frequency
> changed to: 454737 KHz
> 
> I'm not sure if it's okay.
>  
It's harmless in your case. But to get rid of it you might try the
attached patch which may be an acceptable solution.

------------------------------>8-----------------------------------
>From db9e708edf6451b619ee73f68c3fcde2eccd7b0c Mon Sep 17 00:00:00 2001
From: Lucas Stach <l.stach@pengutronix.de>
Date: Thu, 2 Oct 2014 17:20:09 +0200
Subject: [PATCH] cpufreq: generic: try preserve some accuracy while
converting
 from Hz to kHz

---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d9fdeddcef96..459830c6576f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -187,7 +187,7 @@ unsigned int cpufreq_generic_get(unsigned int cpu)
 		return 0;
 	}
 
-	return clk_get_rate(policy->clk) / 1000;
+	return DIV_ROUND_CLOSEST(clk_get_rate(policy->clk), 1000);
 }
 EXPORT_SYMBOL_GPL(cpufreq_generic_get);
 
-- 
2.1.0

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

