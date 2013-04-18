From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: bltk-game regressions on snb laptop
Date: Thu, 18 Apr 2013 15:31:46 +0530
Message-ID: <CAKohpo=NGYadRubvBDLsE=oO1wuDSxnutYfZLm9vu4B6tcUw-g@mail.gmail.com>
References: <516CFA57.3060709@intel.com>
	<CAKohponOVZgAxdX5yv9qmn_56mgTdXEBPr-7o7_pA5GRF09J0w@mail.gmail.com>
	<516F42EE.6080802@intel.com>
	<CAKohpokju79Fx7TXTD1hKoG0JUmCsRm8Us381bhHeUrBvyOv6w@mail.gmail.com>
	<516F81BD.3030306@intel.com>
	<CAKohponG+F6ikVb2iY_Qg5E6NoCkPVj5VC12JqwXfamzsKLrXA@mail.gmail.com>
	<516FB4AF.6060009@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:50325 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755184Ab3DRKBr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Apr 2013 06:01:47 -0400
Received: by mail-oa0-f43.google.com with SMTP id l10so2564567oag.30
        for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2013 03:01:46 -0700 (PDT)
In-Reply-To: <516FB4AF.6060009@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alex Shi <alex.shi@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, LKP ML <lkp@linux.intel.com>

On 18 April 2013 14:24, Alex Shi <alex.shi@intel.com> wrote:
> On 04/18/2013 01:37 PM, Viresh Kumar wrote:
>>>> About your system: Can you give output of cpufreq-info for v3.8 and
>>>> >> v3.9-latestrc?
>>>> >> Your cpus share a clock line or not?
>>> >
>>> > Yes our cpu shares a clock line. So the cpufreq-info is same. SNB CPU
>>> > p-state is per cpu package, and hardware will coordinate the software
>>> > asking, then decide which cpufreq should be.
>> Can you paste cpufreq-info output, that will give us a better picture of your
>> system.
>>
>
> at the most of time with your patch cpufreq-info is 0.8GHz, without the
> patch, the cpufreq is varied from 1.0 to 2.8 Ghz.

I need full output of following command:

$ cpufreq-info

This has got lots of other details too.
