From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH 0/3] cpufreq: Replace timers with utilization update callbacks
Date: Fri, 12 Feb 2016 11:53:45 -0500
Message-ID: <CAJ5Y-ebO2MU3=ifh6MxSBd2PE0GOf8B3ZDV6-toA5h-5SG6WEg@mail.gmail.com>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan> <56B93548.9090006@linaro.org>
 <CAJZ5v0gJwLVezLTLwGX=GDrsGeH6X040JmOaW6_uX2XzQwO9mg@mail.gmail.com>
 <5387313.xAhVpzgZCg@vostro.rjw.lan> <56BA8C29.4090905@linaro.org>
 <20160211115959.GI6357@twins.programming.kicks-ass.net> <56BCBF7C.2080404@linaro.org>
 <20160211173033.GP6357@twins.programming.kicks-ass.net> <56BCD864.6030207@linaro.org>
 <20160212141009.GT6357@twins.programming.kicks-ass.net> <CAJZ5v0giM=CMkQN770TLv5wgdUQ2o0D152HFG6-nX-rr483G+A@mail.gmail.com>
 <CAJZ5v0jrA1ESksVUyTNeiuArdr7T1U2iXtw3RBSSaz+dRCVeeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35252 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbcBLQyH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Feb 2016 11:54:07 -0500
Received: by mail-lb0-f174.google.com with SMTP id bc4so48616346lbc.2
        for <linux-pm@vger.kernel.org>; Fri, 12 Feb 2016 08:54:05 -0800 (PST)
In-Reply-To: <CAJZ5v0jrA1ESksVUyTNeiuArdr7T1U2iXtw3RBSSaz+dRCVeeA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Thomas Gleixner <tglx@linutronix.de>

On 12 February 2016 at 11:15, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Feb 12, 2016 at 5:01 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Fri, Feb 12, 2016 at 3:10 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>>> On Thu, Feb 11, 2016 at 10:52:20AM -0800, Steve Muckle wrote:
>>>> On 02/11/2016 09:30 AM, Peter Zijlstra wrote:
>>>> >> My concern above is that pokes are guaranteed to keep occurring when
>>>> >> > there is only RT or DL activity so nothing breaks.
>>>> >
>>>> > The hook in their respective tick handler should ensure stuff is called
>>>> > sporadically and isn't stalled.
>>>>
>>>> But that's only true if the RT/DL tasks happen to be running when the
>>>> tick arrives right?
>>>>
>>>> Couldn't we have RT/DL activity which doesn't overlap with the tick? And
>>>> if no CFS tasks happen to be executing on that CPU, we'll never trigger
>>>> the cpufreq update. This could go on for an arbitrarily long time
>>>> depending on the periodicity of the work.
>>>
>>> Possible yes, but why do we care? Such a CPU would be so much idle that
>>> cpufreq doesn't matter one way or another, right?
>>
>> Well, in theory you can get 50% or so of the time active in bursts
>> that happen to fit between ticks.  If we happen to do those in the
>> lowest P-state, we may burn more energy than necessary on platforms
>> where more idle is preferred.
>
> At least intel_pstate should be able to figure out which P-state to
> use then on the APERF/MPERF basis.

Speaking for the generic case, it would be great to make use of such
feedback counters for selecting the next freq request. Use (num of
cycles used/total cycles) to figure out %ON time for the CPU. I
understand its not the goal for this patch series, but in the future
if we can do this in your callbacks where possible, then I think we
will do better than Ondemand.

Regards,
Ashwin.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
