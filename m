From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: cpufreq: Unable to set cpufreq to maximum
Date: Mon, 06 Oct 2014 13:12:36 +0200
Message-ID: <54327924.9090600@i2se.com>
References: <936524880.154802.1412255867221.JavaMail.open-xchange@oxbaltgw07.schlund.de>	<1412258352.4875.5.camel@pengutronix.de>	<878902771.162556.1412262099998.JavaMail.open-xchange@oxbaltgw01.schlund.de>	<1412263338.2313.1.camel@pengutronix.de>	<CAKohpom_kJadzUiPAT9GBJjvcu=38L9fO1atoi24xGwrq9XDFg@mail.gmail.com>	<54323990.6000401@i2se.com>	<CAKohponTCFnOHeELg+vpz-=a3xR7xrppZiuss09a2UGCLCptnQ@mail.gmail.com>	<54325D40.10604@i2se.com>	<CAKohpokbWGu9KBixMTCUbv9RobfYmpZjNDdYEJ78V-5b9D7_Wg@mail.gmail.com>	<54326985.2030207@i2se.com> <CAKohpon2VHvfCkGWYQyz1=jhiS4zifX6iY50WV71oGpa2TNSYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:59455 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbaJFLMt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Oct 2014 07:12:49 -0400
In-Reply-To: <CAKohpon2VHvfCkGWYQyz1=jhiS4zifX6iY50WV71oGpa2TNSYQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Shawn Guo <shawn.guo@freescale.com>, Lucas Stach <l.stach@pengutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabio Estevam <festevam@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Am 06.10.2014 um 12:16 schrieb Viresh Kumar:
> On 6 October 2014 15:35, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>> but cpufreq-cpu0 will select next lower
> Where did this come from in the above theory ?
>

I was wrong. cpufreq-cpu0 will search for a higher OPP than 454736842
and fails:

[ 1111.226006] cpu cpu0: failed to find OPP for 454736842

May be Shawn has an idea or solution.

Sorry for that noise.

Stefan


