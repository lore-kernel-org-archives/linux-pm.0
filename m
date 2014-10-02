From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: cpufreq: Unable to set cpufreq to maximum
Date: Thu, 2 Oct 2014 17:01:39 +0200 (CEST)
Message-ID: <878902771.162556.1412262099998.JavaMail.open-xchange@oxbaltgw01.schlund.de>
References: <936524880.154802.1412255867221.JavaMail.open-xchange@oxbaltgw07.schlund.de> <1412258352.4875.5.camel@pengutronix.de>
Reply-To: Stefan Wahren <stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:60714 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615AbaJBPBo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Oct 2014 11:01:44 -0400
In-Reply-To: <1412258352.4875.5.camel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, gregkh@linuxfoundation.org, festevam@gmail.com, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

Hi Lucas,

> Lucas Stach <l.stach@pengutronix.de> hat am 2. Oktober 2014 um 15:59
> geschrieben:
>
>
> Am Donnerstag, den 02.10.2014, 15:17 +0200 schrieb Stefan Wahren:
> > Hi,
> >
> > i currently try to get cpufreq-cpu0 aka cpufreq-dt running on Freescale
> > i.MX28
> > (ARM). First i ported the regulator driver and now i want to test it with
> > cpufreq-cpu0. Everything works fine except changing back to maximum
> > frequency
> > 454736 kHz. I get the following error:
> >
>> [...]
> >
> > Any ideas?
>
> Isn't your highest OPP just wrong? Apparently the CPU clock (which is a
> fixed PLL plus a divider on MX28 if I'm not mistaken) is only able to
> provide a slightly higher frequency than your OPP. cpufreq handles that
> as an error, which is valid behavior as going higher than the defined
> OPP may not be qualified by the vendor.
 
I hope so.

>
> Does it work if you just change this OPP to 454737 kHz?
>
 
Yes after that i can change it with userspace governor. But i get this warning
during modprobe:
 
root@duckbill:~# modprobe cpufreq-cpu0
[   48.573808] cpufreq: __cpufreq_add_dev: CPU0: Running at unlisted freq:
454736 KHz
[   48.604871] cpufreq: __cpufreq_add_dev: CPU0: Unlisted initial frequency
changed to: 454737 KHz

I'm not sure if it's okay.
 
>
> Regards,
> Lucas
> --
> Pengutronix e.K. | Lucas Stach |
> Industrial Linux Solutions | http://www.pengutronix.de/ |
>

Stefan
