From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V3] cpufreq: qoriq: Register cooling device based on
 device tree
Date: Mon, 29 Feb 2016 15:33:37 +0100
Message-ID: <CAJZ5v0joCpaPNxPzW2xpJ5Vt4MYgWdCvXE0PZb90S46pFhJH8w@mail.gmail.com>
References: <1448529671-48216-1-git-send-email-hongtao.jia@freescale.com>
	<1456531704.5360.53.camel@buserror.net>
	<CADRPPNQhmb3bET9fV072ad5FEHAPrjuXSze1HwnRnKMRmFi8cg@mail.gmail.com>
	<8056913.EWiGLtcdOV@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34446 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbcB2Odj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Feb 2016 09:33:39 -0500
In-Reply-To: <8056913.EWiGLtcdOV@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Li Yang <leoli@freescale.com>, Scott Wood <oss@buserror.net>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jia Hongtao <hongtao.jia@freescale.com>, Eduardo Valentin <edubezval@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>

On Mon, Feb 29, 2016 at 11:05 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 26 February 2016 18:41:06 Li Yang wrote:
>> >> >
>> >> > It would be perfect if this it true.  But I tried with the following
>> >> > change, it just makes QORIQ_CPUFREQ non-selectable if THERMAL=m.
>> >> >
>> >> > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
>> >> > index dcb972a38fbc..ca05037dd565 100644
>> >> > --- a/drivers/cpufreq/Kconfig
>> >> > +++ b/drivers/cpufreq/Kconfig
>> >> > @@ -297,6 +297,7 @@ endif
>> >> >  config QORIQ_CPUFREQ
>> >> >         tristate "CPU frequency scaling driver for Freescale QorIQ SoCs"
>> >> >         depends on OF && COMMON_CLK && (PPC_E500MC || ARM)
>> >> > +       depends on !CPU_THERMAL || THERMAL=y
>> >> >         select CLK_QORIQ
>> >> >         help
>> >> >           This adds the CPUFreq driver support for Freescale QorIQ SoCs
>> >>
>
> Oops.
>
>> >> I find we can achieve your desired result with the following change instead:
>> >>
>> >> +       depends on (THERMAL=m && m) || THERMAL=y || THERMAL=n
>> >
>> > "depends on THERMAL || !THERMAL" should also work.
>>
>> Right.  And this is more simpler.
>
>
> Note the check on !CPU_THERMAL rather than !THERMAL in my patch, that
> part was correct. I think the line should be
>
>         depends on !CPU_THERMAL || THERMAL
>
> as some other drivers do. I must have copied the line
> from ARM_MT8173_CPUFREQ, which is a 'bool' symbol, when
> it should have been the same as ARM_BIG_LITTLE_CPUFREQ and
> CPUFREQ_DT.

OK, so any chance to update the patch?

Thanks,
Rafael
