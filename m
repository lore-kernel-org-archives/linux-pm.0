From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq: Unable to set cpufreq to maximum
Date: Mon, 6 Oct 2014 16:48:14 +0530
Message-ID: <CAKohponQY7O+Pn4KP4NAsQ0a12TEZDGtb93c=Qt3rCfR7hAYgg@mail.gmail.com>
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
	<CAKohpon2VHvfCkGWYQyz1=jhiS4zifX6iY50WV71oGpa2TNSYQ@mail.gmail.com>
	<54327924.9090600@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:52629 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbaJFLSP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Oct 2014 07:18:15 -0400
Received: by mail-ob0-f176.google.com with SMTP id m8so3636142obr.35
        for <linux-pm@vger.kernel.org>; Mon, 06 Oct 2014 04:18:14 -0700 (PDT)
In-Reply-To: <54327924.9090600@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Shawn Guo <shawn.guo@freescale.com>, Lucas Stach <l.stach@pengutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabio Estevam <festevam@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 6 October 2014 16:42, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Am 06.10.2014 um 12:16 schrieb Viresh Kumar:
>> On 6 October 2014 15:35, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>>> but cpufreq-cpu0 will select next lower
>> Where did this come from in the above theory ?
>>
>
> I was wrong. cpufreq-cpu0 will search for a higher OPP than 454736842
> and fails:
>
> [ 1111.226006] cpu cpu0: failed to find OPP for 454736842

I have been talking about this error all this time:

[   48.573808] cpufreq: __cpufreq_add_dev: CPU0: Running at unlisted freq:
454736 KHz
[   48.604871] cpufreq: __cpufreq_add_dev: CPU0: Unlisted initial frequency
changed to: 454737 KHz

And this has nothing to do with the error you just pasted. For the above two
errors cpufreq-cpu0's ->target_index() isn't called at all and so it doesn't
make a difference..
