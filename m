From: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH V3] cpufreq: qoriq: Register cooling device based on
 device tree
Date: Fri, 26 Feb 2016 12:04:59 -0600
Message-ID: <CADRPPNSqXBqD0of0ZorXFOKQc1OQaaJCPFUTMUezJexkegHY9A@mail.gmail.com>
References: <1448529671-48216-1-git-send-email-hongtao.jia@freescale.com>
	<1697588.dLcbZBRWO4@vostro.rjw.lan>
	<3550740.QzZi28fbXg@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35040 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754760AbcBZSFB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2016 13:05:01 -0500
In-Reply-To: <3550740.QzZi28fbXg@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jia Hongtao <hongtao.jia@freescale.com>, edubezval@gmail.com, viresh.kumar@linaro.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, devicetree@vger.kernel.org, Scott Wood <scottwood@freescale.com>

On Fri, Dec 18, 2015 at 4:32 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 15 December 2015 00:58:26 Rafael J. Wysocki wrote:
>> On Thursday, November 26, 2015 05:21:11 PM Jia Hongtao wrote:
>> > Register the qoriq cpufreq driver as a cooling device, based on the
>> > thermal device tree framework. When temperature crosses the passive trip
>> > point cpufreq is used to throttle CPUs.
>> >
>> > Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
>> > Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
>>
>> Applied, thanks!
>>
>
> I got a randconfig build error today:
>
> drivers/built-in.o: In function `qoriq_cpufreq_ready':
> debugfs.c:(.text+0x1f4688): undefined reference to `of_cpufreq_cooling_register'
>
> CONFIG_OF=y
> CONFIG_QORIQ_CPUFREQ=y
> CONFIG_THERMAL=m
> CONFIG_THERMAL_OF=y
>
> I think you need a 'depends on THERMAL' to prevent the driver from
> being built-in when THERMAL=m.

Maybe this is not the best approach.  The cpufreq feature itself
should be working independently without thermal framework.  I think we
should make the qoriq_cpufreq_ready() defined as null function if
THERMAL is not defined.

Regards,
Leo
