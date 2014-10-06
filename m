From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq: Unable to set cpufreq to maximum
Date: Mon, 6 Oct 2014 14:20:24 +0530
Message-ID: <CAKohponTCFnOHeELg+vpz-=a3xR7xrppZiuss09a2UGCLCptnQ@mail.gmail.com>
References: <936524880.154802.1412255867221.JavaMail.open-xchange@oxbaltgw07.schlund.de>
	<1412258352.4875.5.camel@pengutronix.de>
	<878902771.162556.1412262099998.JavaMail.open-xchange@oxbaltgw01.schlund.de>
	<1412263338.2313.1.camel@pengutronix.de>
	<CAKohpom_kJadzUiPAT9GBJjvcu=38L9fO1atoi24xGwrq9XDFg@mail.gmail.com>
	<54323990.6000401@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:38239 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbaJFIuZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Oct 2014 04:50:25 -0400
Received: by mail-ob0-f177.google.com with SMTP id uy5so3459071obc.22
        for <linux-pm@vger.kernel.org>; Mon, 06 Oct 2014 01:50:24 -0700 (PDT)
In-Reply-To: <54323990.6000401@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>, Shawn Guo <shawn.guo@freescale.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabio Estevam <festevam@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 6 October 2014 12:11, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Ignoring errors isn't a solution. I have another idea. I've looked a
> little bit at the code in the cpufreq-(cpu0/dt). Usually the frequencies
> are rounded down, but in cpu0_set_target() with
> dev_pm_opp_find_freq_ceil(cpu_dev, &freq_Hz) they are rounded up. From
> my point of view that's wrong.

@Shawn ??

> I fixed the problem by decreasing frequency in DT and replacing
> dev_pm_opp_find_freq_ceil() with dev_pm_opp_find_freq_floor() in
> cpufreq-cpu0.c . Unfortunatelly this will break all other DTS files with
> roundings in OPPs.

I am still not sure how this fixed your problem..
