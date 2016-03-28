From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH v6 6/7][Resend] cpufreq: Support for fast frequency
 switching
Date: Mon, 28 Mar 2016 09:47:53 -0700
Message-ID: <56F96039.9070500@linaro.org>
References: <7262976.zPkLj56ATU@vostro.rjw.lan>
 <25154681.B5BGJ94JlQ@vostro.rjw.lan> <56F5E1EB.1050702@linaro.org>
 <CAJZ5v0inp178MJ=vxN-Qss1cBW5Ogmrq0xpccKfPB5Lky_i-Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36820 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020AbcC1Qr4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Mar 2016 12:47:56 -0400
Received: by mail-pa0-f52.google.com with SMTP id tt10so102492935pab.3
        for <linux-pm@vger.kernel.org>; Mon, 28 Mar 2016 09:47:56 -0700 (PDT)
In-Reply-To: <CAJZ5v0inp178MJ=vxN-Qss1cBW5Ogmrq0xpccKfPB5Lky_i-Wg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On 03/25/2016 06:46 PM, Rafael J. Wysocki wrote:
>>> @@ -1726,6 +1810,34 @@ EXPORT_SYMBOL(cpufreq_unregister_notifie
>>> >>   *                              GOVERNORS                            *
>>> >>   *********************************************************************/
>>> >>
>>> >> +/**
>>> >> + * cpufreq_driver_fast_switch - Carry out a fast CPU frequency switch.
>>> >> + * @policy: cpufreq policy to switch the frequency for.
>>> >> + * @target_freq: New frequency to set (may be approximate).
>>> >> + *
>>> >> + * Carry out a fast frequency switch from interrupt context.
>> >
>> > I think that should say atomic rather than interrupt as this might not
>> > be called from interrupt context.
>
> "Interrupt context" here means something like "context that cannot
> sleep" and it's sort of a traditional way of calling that.  I
> considered saying "atomic context" here, but then decided that it
> might suggest too much.
> 
> Maybe something like "Carry out a fast frequency switch without
> sleeping" would be better?

Yes I do think that's preferable. I also wonder if it makes sense to
state expectations of how long the operation should take - i.e. not only
will it not sleep, but it is expected to complete "quickly." However I
accept that it is not well defined what that means. Maybe a mention that
this may be called in scheduler hot paths.
