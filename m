From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3] cpufreq: qoriq: Register cooling device based on device tree
Date: Sat, 27 Feb 2016 00:16:35 +0100
Message-ID: <3593471.QAyZdAuTcW@wuerfel>
References: <1448529671-48216-1-git-send-email-hongtao.jia@freescale.com> <2396230.MApG9VTrxr@wuerfel> <CADRPPNTeBXJBybGwm4jkS64nSyWg+oaod3KJbE_SqfdSuUCA_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:51622 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919AbcBZXQr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2016 18:16:47 -0500
In-Reply-To: <CADRPPNTeBXJBybGwm4jkS64nSyWg+oaod3KJbE_SqfdSuUCA_Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Li Yang <leoli@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, devicetree@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jia Hongtao <hongtao.jia@freescale.com>, Eduardo Valentin <edubezval@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Scott Wood <scottwood@freescale.com>

On Friday 26 February 2016 17:07:09 Li Yang wrote:
> 
> I don't have a perfect solution either.  But I think this is still
> better than making cpufreq not usable.  The cpufreq driver will print
> out an error message if thermal is not reachable.  Maybe this can
> relief the confusion a little bit?

With my patch, the configuration will just force the cpufreq
driver to be a loadable module as well if thermal is a module,
so the dependency can be resolved by loading the thermal module first.

I think that is really the best way around the problem, and it
matches what other platforms do for the same problem.

	Arnd
