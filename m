From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: cpufreq: Unable to set cpufreq to maximum
Date: Mon, 06 Oct 2014 12:05:57 +0200
Message-ID: <54326985.2030207@i2se.com>
References: <936524880.154802.1412255867221.JavaMail.open-xchange@oxbaltgw07.schlund.de>	<1412258352.4875.5.camel@pengutronix.de>	<878902771.162556.1412262099998.JavaMail.open-xchange@oxbaltgw01.schlund.de>	<1412263338.2313.1.camel@pengutronix.de>	<CAKohpom_kJadzUiPAT9GBJjvcu=38L9fO1atoi24xGwrq9XDFg@mail.gmail.com>	<54323990.6000401@i2se.com>	<CAKohponTCFnOHeELg+vpz-=a3xR7xrppZiuss09a2UGCLCptnQ@mail.gmail.com>	<54325D40.10604@i2se.com> <CAKohpokbWGu9KBixMTCUbv9RobfYmpZjNDdYEJ78V-5b9D7_Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:52736 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276AbaJFKGR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Oct 2014 06:06:17 -0400
In-Reply-To: <CAKohpokbWGu9KBixMTCUbv9RobfYmpZjNDdYEJ78V-5b9D7_Wg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Shawn Guo <shawn.guo@freescale.com>, Lucas Stach <l.stach@pengutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabio Estevam <festevam@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Am 06.10.2014 um 11:26 schrieb Viresh Kumar:
> On 6 October 2014 14:43, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>> Sorry, about the confusion. The main problem about setting cpufreq to
>> maximum has been fixed by DT settings. Above i talked about an idea to
>> fix the confusing warning after fixing the main problem:
>>
>> root@duckbill:~# modprobe cpufreq-cpu0
>> [   48.573808] cpufreq: __cpufreq_add_dev: CPU0: Running at unlisted
>> freq: 454736 KHz
>> [   48.604871] cpufreq: __cpufreq_add_dev: CPU0: Unlisted initial
>> frequency changed to: 454737 KHz
>>
>> But the best solution would be a more intelligent function like
>> dev_pm_opp_find_freq_nearest() which find the OPP with the smallest
>> frequency distance. So nobody of the DTS users has to care about
>> frequency rounding.
>>
>> Currently i'm trying to adapt the DTS file to the driver and that's not
>> the intention of devicetree.
> It looks that one of us hasn't understood how things are working :)

I think i know him ;-)

>
>  So here is my part of theory:
> - Search for CPUFREQ_NEED_INITIAL_FREQ_CHECK in cpufreq.c
> - When starting cpufreq core for every CPU we check if the current
> frequency at which is running is mentioned in DT. If not, we throw above
> warnings and fix the freq.

Okay i.MX28 cpu is running initial on 454736842 Hz. 454736 kHz in the DT
will make cpufreq core happy, but cpufreq-cpu0 will select next lower
frequency. 454737 kHz in the DT will make cpufreq sad, but it's
selectable by cpufreq-cpu0.

Is it possible cpufreq core round the clock frequency down?

> - Until this time cpufreq-driver's ->target_index() routine hasn't come
> into picture and so NO opp routine will fix that..
>
> Does this sound reasonable ?

Thanks for your explanation.

Stefan
