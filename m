From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3] cpufreq: Replace timers with utilization update callbacks
Date: Thu, 11 Feb 2016 18:34:05 +0100
Message-ID: <CAJZ5v0hKjgmnTtxD5nHZfixFCPVoFhG6H_VnUJUkhaJ4wJef-Q@mail.gmail.com>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
	<56B93548.9090006@linaro.org>
	<CAJZ5v0gJwLVezLTLwGX=GDrsGeH6X040JmOaW6_uX2XzQwO9mg@mail.gmail.com>
	<5387313.xAhVpzgZCg@vostro.rjw.lan>
	<56BA8C29.4090905@linaro.org>
	<20160211115959.GI6357@twins.programming.kicks-ass.net>
	<56BCBF7C.2080404@linaro.org>
	<20160211173033.GP6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:32907 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbcBKReH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Feb 2016 12:34:07 -0500
In-Reply-To: <20160211173033.GP6357@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Thomas Gleixner <tglx@linutronix.de>

On Thu, Feb 11, 2016 at 6:30 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Feb 11, 2016 at 09:06:04AM -0800, Steve Muckle wrote:
>> Hi Peter,
>>
>> >> > I think additional hooks such as enqueue/dequeue would be needed in
>> >> > RT/DL.
>
> That is what I reacted to mostly. Enqueue/dequeue hooks don't really
> make much sense for RT / DL.
>
>> Rafael's changes aren't specifying particular frequencies/capacities in
>> the scheduler hooks. They're just pokes to get cpufreq to run, in order
>> to eliminate cpufreq's timers.
>>
>> My concern above is that pokes are guaranteed to keep occurring when
>> there is only RT or DL activity so nothing breaks.
>
> The hook in their respective tick handler should ensure stuff is called
> sporadically and isn't stalled.

I've updated the patch in the meantime
(https://patchwork.kernel.org/patch/8283431/).

Should I move the RT/DL hooks to task_tick_rt/dl(), respectively?

Thanks,
Rafael
