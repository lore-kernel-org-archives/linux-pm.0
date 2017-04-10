From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC/RFT][PATCH 1/2] cpufreq: schedutil: Use policy-dependent
 latency multupliers
Date: Mon, 10 Apr 2017 13:03:11 +0200
Message-ID: <CAJZ5v0jevmTrw5qaymUBdYhSwa+Nar3a-1jNSCPtm_4cG+qvbQ@mail.gmail.com>
References: <3498238.liCqOyIkGA@aspire.rjw.lan> <2407280.n9qVSLCrF5@aspire.rjw.lan>
 <87k26sv96o.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36168 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752144AbdDJLDM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2017 07:03:12 -0400
In-Reply-To: <87k26sv96o.fsf@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brendan Jackman <brendan.jackman@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>

On Mon, Apr 10, 2017 at 12:38 PM, Brendan Jackman
<brendan.jackman@arm.com> wrote:
> Hi Rafael,
>
> On Mon, Apr 10 2017 at 00:10, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Make the schedutil governor compute the initial (default) value of
>> the rate_limit_us sysfs attribute by multiplying the transition
>> latency by a multiplier depending on the policy and set by the
>> scaling driver (instead of using a constant for this purpose).
>>
>> That will allow scaling drivers to make schedutil use smaller default
>> values of rate_limit_us and reduce the default average time interval
>> between consecutive frequency changes.
>>
>
> I've been thinking about this over the last couple of days, and I'm
> thinking (in opposition to what I said at OSPM Pisa) that allowing
> drivers to specify a _multiplier_ isn't ideal, since you lose
> granularity when you want your rate limit to be close to your transition
> latency (i.e. if your multiplier would be 2.5 or something).
>
> Can we instead just have an independent field
> policy->default_rate_limit_us or similar?

Yes, we can.

Let me cut a v2 of this, shouldn't be too hard. :-)

Thanks,
Rafael
