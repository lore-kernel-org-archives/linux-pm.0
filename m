From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq: Unable to set cpufreq to maximum
Date: Mon, 6 Oct 2014 15:46:18 +0530
Message-ID: <CAKohpon2VHvfCkGWYQyz1=jhiS4zifX6iY50WV71oGpa2TNSYQ@mail.gmail.com>
References: <936524880.154802.1412255867221.JavaMail.open-xchange@oxbaltgw07.schlund.de>
	<1412258352.4875.5.camel@pengutronix.de>
	<878902771.162556.1412262099998.JavaMail.open-xchange@oxbaltgw01.schlund.de>
	<1412263338.2313.1.camel@pengutronix.de>
	<CAKohpom_kJadzUiPAT9GBJjvcu=38L9fO1atoi24xGwrq9XDFg@mail.gmail.com>
	<54323990.6000401@i2se.com>
	<CAKohponTCFnOHeELg+vpz-=a3xR7xrppZiuss09a2UGCLCptnQ@mail.gmail.com>
	<54325D40.10604@i2se.com>
	<CAKohpokbWGu9KBixMTCUbv9RobfYmpZjNDdYEJ78V-5b9D7_Wg@mail.gmail.com>
	<54326985.2030207@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:46438 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbaJFKQT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Oct 2014 06:16:19 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo20so3667501obc.31
        for <linux-pm@vger.kernel.org>; Mon, 06 Oct 2014 03:16:19 -0700 (PDT)
In-Reply-To: <54326985.2030207@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Shawn Guo <shawn.guo@freescale.com>, Lucas Stach <l.stach@pengutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabio Estevam <festevam@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 6 October 2014 15:35, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Okay i.MX28 cpu is running initial on 454736842 Hz. 454736 kHz in the DT
> will make cpufreq core happy,

Probably you know why cpufreq-core would be happy but let me still
write it down.
policy->cur = cpufreq_generic_get(), i.e. clk_get_rate(policy->clk) / 1000
So, policy->cur = 454736842/1000 = 454736

This is == to the DT value and so cpufreq-core is happy.

> but cpufreq-cpu0 will select next lower

Where did this come from in the above theory ?

> frequency. 454737 kHz in the DT will make cpufreq sad, but it's
> selectable by cpufreq-cpu0.

I couldn't understand why you mentioned this here. It has nothing to
do with the warning you got..

> Is it possible cpufreq core round the clock frequency down?

Even this, sorry :(
