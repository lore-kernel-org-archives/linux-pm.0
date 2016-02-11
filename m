From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3] cpufreq: Replace timers with utilization update callbacks
Date: Thu, 11 Feb 2016 20:04:54 +0100
Message-ID: <CAJZ5v0jiEkdA6HQEtabpcOPmsXDOKov46gZ=FyXjFmNf+9E9LQ@mail.gmail.com>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
	<56B93548.9090006@linaro.org>
	<CAJZ5v0gJwLVezLTLwGX=GDrsGeH6X040JmOaW6_uX2XzQwO9mg@mail.gmail.com>
	<5387313.xAhVpzgZCg@vostro.rjw.lan>
	<56BA8C29.4090905@linaro.org>
	<20160211115959.GI6357@twins.programming.kicks-ass.net>
	<56BCBF7C.2080404@linaro.org>
	<20160211173033.GP6357@twins.programming.kicks-ass.net>
	<56BCD864.6030207@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33907 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbcBKTE4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Feb 2016 14:04:56 -0500
In-Reply-To: <56BCD864.6030207@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Thomas Gleixner <tglx@linutronix.de>

On Thu, Feb 11, 2016 at 7:52 PM, Steve Muckle <steve.muckle@linaro.org> wrote:
> On 02/11/2016 09:30 AM, Peter Zijlstra wrote:
>>> My concern above is that pokes are guaranteed to keep occurring when
>>> > there is only RT or DL activity so nothing breaks.
>>
>> The hook in their respective tick handler should ensure stuff is called
>> sporadically and isn't stalled.
>
> But that's only true if the RT/DL tasks happen to be running when the
> tick arrives right?
>
> Couldn't we have RT/DL activity which doesn't overlap with the tick? And
> if no CFS tasks happen to be executing on that CPU, we'll never trigger
> the cpufreq update. This could go on for an arbitrarily long time
> depending on the periodicity of the work.

I'm thinking that two additional hooks in enqueue_task_rt/dl() might
help here.  Then, we will hit either the tick or enqueue and that
should do the trick.

Peter, what do you think?

Rafael
