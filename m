From: Mason <mpeg.blue@free.fr>
Subject: Re: RFC on cpufreq implementation
Date: Tue, 03 Feb 2015 16:07:18 -0800
Message-ID: <54D162B6.2050602@free.fr>
References: <54B7F7CD.7030903@free.fr>	<54CA6327.5070707@free.fr>	<CAKohponrzDb4ZGvRtJ5jtGTPAy4RCfRsYGvdjR5fx51K2=evCg@mail.gmail.com>	<54CC174F.10703@free.fr> <CAKohpomzCEjXUrxUJjypaA77=r4j_ZPa+x3gM=cNN0kc3ux0uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:55627 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbbBDAHe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Feb 2015 19:07:34 -0500
In-Reply-To: <CAKohpomzCEjXUrxUJjypaA77=r4j_ZPa+x3gM=cNN0kc3ux0uQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>

Viresh Kumar wrote:

> Mason wrote:
>
>> If it's supposed to go in drivers/cpufreq, I suppose there are naming
>> conventions to follow?
>
> You can check existing drivers.

All of them?

~/linux-3.19-rc7$ wc drivers/cpufreq/*
  31542  95730 813482 total

Are there perhaps 1 or 2 "golden standard" drivers that are well-written
and up-to-date with respect to current conventions?

>> Also, if it's in drivers/cpufreq, we are not supposed to include
>> any machine-specific includes? And I'm back to my original question
>> where am I supposed to store machine-specific information, such as
>> register descriptions and MMIO addresses and offsets?
>
> Define registers/etc in your driver only or somewhere in include/ .

Like Samsung did with include/dt-bindings/clock/exynos*.h ?

> Also, try to see if you can reuse cpufreq-dt.c, your driver wouldn't make
> it to the kernel otherwise.

Are you saying that use of DeviceTree is mandatory for new ARM ports?

In other words, ports using "board files" will not be accepted into
mainline, nor will drivers not using DT?

If that is correct, then my proposed cpufreq driver has exactly 0%
chance of being mainlined as-is, right?

I took a look at cpufreq-dt.c but I think it doesn't quite fit my use-case.
In my driver, I define "clock dividers" (typically 1,2,3,5,9) and these are
used to divide some baseline frequency that the cpufreq code doesn't need to
know. The baseline frequency is set by the boot loader, and Linux is not
supposed to change that, only apply the dividers if necessary.

What do you think of this use-case?

Regards.

