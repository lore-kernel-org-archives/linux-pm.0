From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 5/9] cpufreq: integrator: move cpufreq driver to drivers/cpufreq
Date: Thu, 4 Apr 2013 13:40:43 +0200
Message-ID: <CACRpkdYeq38NfbDz2WbGhmWwQqaf2RgeX507OXQoq5mPGeH4hg@mail.gmail.com>
References: <cover.1364205812.git.viresh.kumar@linaro.org>
	<fae1030e861c5dfd00df8f03526b0bdc5156de4d.1364205812.git.viresh.kumar@linaro.org>
	<CAKohpo=yppB4o+_31dEfoo3Sd=7KnqK1ZfDoMBDTT1ONxkFyOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:53393 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758905Ab3DDLko (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Apr 2013 07:40:44 -0400
Received: by mail-ie0-f182.google.com with SMTP id at1so2870301iec.41
        for <linux-pm@vger.kernel.org>; Thu, 04 Apr 2013 04:40:44 -0700 (PDT)
In-Reply-To: <CAKohpo=yppB4o+_31dEfoo3Sd=7KnqK1ZfDoMBDTT1ONxkFyOA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arvind Chauhan <arvind.chauhan@arm.com>, Robin Randhawa <robin.randhawa@arm.com>, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, Charles Garcia-Tobin <charles.garcia-tobin@arm.com>, cpufreq@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linaro-kernel <linaro-kernel@lists.linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Thu, Apr 4, 2013 at 10:32 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 25 March 2013 15:41, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> This patch moves cpufreq driver of ARM based integrator platform to
>> drivers/cpufreq.
>>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  arch/arm/Kconfig                                              | 11 -----------
>>  arch/arm/mach-integrator/Makefile                             |  1 -
>>  drivers/cpufreq/Kconfig.arm                                   |  8 ++++++++
>>  drivers/cpufreq/Makefile                                      |  1 +
>>  .../cpu.c => drivers/cpufreq/integrator-cpufreq.c             |  2 --
>>  5 files changed, 9 insertions(+), 14 deletions(-)
>>  rename arch/arm/mach-integrator/cpu.c => drivers/cpufreq/integrator-cpufreq.c (99%)
>
> I didn't knew that you are maintaining integrator now a days.
> Can i have your comments/Ack for this patch?

Sure
Acked-by: Linus Walleij <linus.walleij@linaro.org>

This file still #includes a few <mach/*> headers, which stand in the
way for multiplatform, but whatever, it will need some heavy patching
anyway.

Yours,
Linus Walleij
