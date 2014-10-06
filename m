From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq: Unable to set cpufreq to maximum
Date: Mon, 6 Oct 2014 14:56:22 +0530
Message-ID: <CAKohpokbWGu9KBixMTCUbv9RobfYmpZjNDdYEJ78V-5b9D7_Wg@mail.gmail.com>
References: <936524880.154802.1412255867221.JavaMail.open-xchange@oxbaltgw07.schlund.de>
	<1412258352.4875.5.camel@pengutronix.de>
	<878902771.162556.1412262099998.JavaMail.open-xchange@oxbaltgw01.schlund.de>
	<1412263338.2313.1.camel@pengutronix.de>
	<CAKohpom_kJadzUiPAT9GBJjvcu=38L9fO1atoi24xGwrq9XDFg@mail.gmail.com>
	<54323990.6000401@i2se.com>
	<CAKohponTCFnOHeELg+vpz-=a3xR7xrppZiuss09a2UGCLCptnQ@mail.gmail.com>
	<54325D40.10604@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:36882 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbaJFJ0W (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Oct 2014 05:26:22 -0400
Received: by mail-ob0-f175.google.com with SMTP id wn1so3590110obc.34
        for <linux-pm@vger.kernel.org>; Mon, 06 Oct 2014 02:26:22 -0700 (PDT)
In-Reply-To: <54325D40.10604@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Shawn Guo <shawn.guo@freescale.com>, Lucas Stach <l.stach@pengutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabio Estevam <festevam@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 6 October 2014 14:43, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Sorry, about the confusion. The main problem about setting cpufreq to
> maximum has been fixed by DT settings. Above i talked about an idea to
> fix the confusing warning after fixing the main problem:
>
> root@duckbill:~# modprobe cpufreq-cpu0
> [   48.573808] cpufreq: __cpufreq_add_dev: CPU0: Running at unlisted
> freq: 454736 KHz
> [   48.604871] cpufreq: __cpufreq_add_dev: CPU0: Unlisted initial
> frequency changed to: 454737 KHz
>
> But the best solution would be a more intelligent function like
> dev_pm_opp_find_freq_nearest() which find the OPP with the smallest
> frequency distance. So nobody of the DTS users has to care about
> frequency rounding.
>
> Currently i'm trying to adapt the DTS file to the driver and that's not
> the intention of devicetree.

It looks that one of us hasn't understood how things are working :)

 So here is my part of theory:
- Search for CPUFREQ_NEED_INITIAL_FREQ_CHECK in cpufreq.c
- When starting cpufreq core for every CPU we check if the current
frequency at which is running is mentioned in DT. If not, we throw above
warnings and fix the freq.

- Until this time cpufreq-driver's ->target_index() routine hasn't come
into picture and so NO opp routine will fix that..

Does this sound reasonable ?
