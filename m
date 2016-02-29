From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3] cpufreq: qoriq: Register cooling device based on device tree
Date: Mon, 29 Feb 2016 11:05:37 +0100
Message-ID: <8056913.EWiGLtcdOV@wuerfel>
References: <1448529671-48216-1-git-send-email-hongtao.jia@freescale.com> <1456531704.5360.53.camel@buserror.net> <CADRPPNQhmb3bET9fV072ad5FEHAPrjuXSze1HwnRnKMRmFi8cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:51335 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbcB2KF5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Feb 2016 05:05:57 -0500
In-Reply-To: <CADRPPNQhmb3bET9fV072ad5FEHAPrjuXSze1HwnRnKMRmFi8cg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Li Yang <leoli@freescale.com>
Cc: Scott Wood <oss@buserror.net>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, devicetree@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jia Hongtao <hongtao.jia@freescale.com>, Eduardo Valentin <edubezval@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>

On Friday 26 February 2016 18:41:06 Li Yang wrote:
> >> >
> >> > It would be perfect if this it true.  But I tried with the following
> >> > change, it just makes QORIQ_CPUFREQ non-selectable if THERMAL=m.
> >> >
> >> > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> >> > index dcb972a38fbc..ca05037dd565 100644
> >> > --- a/drivers/cpufreq/Kconfig
> >> > +++ b/drivers/cpufreq/Kconfig
> >> > @@ -297,6 +297,7 @@ endif
> >> >  config QORIQ_CPUFREQ
> >> >         tristate "CPU frequency scaling driver for Freescale QorIQ SoCs"
> >> >         depends on OF && COMMON_CLK && (PPC_E500MC || ARM)
> >> > +       depends on !CPU_THERMAL || THERMAL=y
> >> >         select CLK_QORIQ
> >> >         help
> >> >           This adds the CPUFreq driver support for Freescale QorIQ SoCs
> >>

Oops.

> >> I find we can achieve your desired result with the following change instead:
> >>
> >> +       depends on (THERMAL=m && m) || THERMAL=y || THERMAL=n
> >
> > "depends on THERMAL || !THERMAL" should also work.
> 
> Right.  And this is more simpler.


Note the check on !CPU_THERMAL rather than !THERMAL in my patch, that
part was correct. I think the line should be

	depends on !CPU_THERMAL || THERMAL

as some other drivers do. I must have copied the line
from ARM_MT8173_CPUFREQ, which is a 'bool' symbol, when
it should have been the same as ARM_BIG_LITTLE_CPUFREQ and
CPUFREQ_DT.

	Arnd
