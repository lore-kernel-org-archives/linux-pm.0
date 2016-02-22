From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v10 1/3] cpufreq: Add mechanism for registering
 utilization update callbacks
Date: Mon, 22 Feb 2016 22:46:19 +0100
Message-ID: <CAJZ5v0gYH3usCAvEyhYZhy_H-oWjhk0e8m+jVMMcs__Sai2uuw@mail.gmail.com>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
	<2044559.7ypXocW9OZ@vostro.rjw.lan>
	<3499355.2JlaSruvOa@vostro.rjw.lan>
	<16016177.YFqb4gVNBo@vostro.rjw.lan>
	<CAJZ5v0jthTo8rXMp_ad=k5EcFBcwLgKRMnwPsznqDhois84uYA@mail.gmail.com>
	<20160219080917.GE22643@pablo>
	<1455900129.7375.231.camel@linux.intel.com>
	<56C750B7.6090701@linaro.org>
	<20160222105224.GE6356@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33596 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbcBVVqV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2016 16:46:21 -0500
In-Reply-To: <20160222105224.GE6356@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Mon, Feb 22, 2016 at 11:52 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Feb 19, 2016 at 09:28:23AM -0800, Steve Muckle wrote:
>> On 02/19/2016 08:42 AM, Srinivas Pandruvada wrote:
>> > We did experiments using util/max in intel_pstate. For some benchmarks
>> > there were regression of 4 to 5%, for some benchmarks it performed at
>> > par with getting utilization from the processor. Further optimization
>> > in the algorithm is possible and still in progress. Idea is that we can
>> > change P-State fast enough and be more reactive. Once I have good data,
>> > I will send to this list. The algorithm can be part of the cpufreq
>> > governor too.
>>
>> There has been a lot of work in the area of scheduler-driven CPU
>> frequency selection by Linaro and ARM as well. It was posted most
>> recently a couple months ago:
>>
>> http://thread.gmane.org/gmane.linux.power-management.general/69176
>>
>> It was also posted as part of the energy-aware scheduling series last
>> July. There's a new RFC series forthcoming which I had hoped (and
>> failed) to post prior to my business travel this week; it should be out
>> next week. It will address the feedback received thus far along with
>> locking and other things.
>
> Right, so I had a wee look at that again, and had a quick chat with Juri
> on IRC. So the main difference seems to be that you guys want to know
> why the utilization changed, as opposed to purely _that_ it changed.
>
> And hence you have callbacks all over the place.
>
> I'm not too sure I really like that too much, it bloats the code and
> somewhat obfuscates the point.
>
> So I would really like there to be just the one callback when we
> actually compute a new number, and that is update_load_avg().
>
> Now I think we can 'easily' propagate the information you want into
> update_load_avg() (see below), but I would like to see actual arguments
> for why you would need this.
>
> For one, the migration bits don't really make sense. We typically do not
> call migration code local on both cpus, typically just one, but possibly
> neither. That means you cannot actually update the relevant CPU state
> from these sites anyway.
>
>> The scheduler hooks for utilization-based cpufreq operation deserve a
>> lot more debate I think. They could quite possibly have different
>> requirements than hooks which are chosen just to guarantee periodic
>> callbacks into sampling-based governors.
>
> I'll repeat what Rafael said, the periodic callback nature is a
> 'temporary' hack, simply because current cpufreq depends on that.
>
> The idea is to wane cpufreq off of that requirement and then drop that
> part.

Right and I can see at least a couple of ways to do that, but it'll
depend on where the final hooks will be located and what arguments
they will pass.

Thanks,
Rafael
