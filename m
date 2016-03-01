From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC/RFT][PATCH 1/1] cpufreq: New governor using utilization data
 from the scheduler
Date: Tue, 1 Mar 2016 21:26:24 +0100
Message-ID: <CAJZ5v0h+KxP8qf--XiVutwiE+DTMn2D2sX8nmERTaTZONLM=jQ@mail.gmail.com>
References: <5059413.77KZsd2lep@vostro.rjw.lan>
	<CAJZ5v0j7jScr8TStyVHPDgd5qHaFDzUO3KnfxtEoYjrfc8gOQA@mail.gmail.com>
	<20160225110120.GF3680@pablo>
	<1770063.xTkquAS3z6@vostro.rjw.lan>
	<20160301145649.GM18792@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34528 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbcCAU01 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2016 15:26:27 -0500
In-Reply-To: <20160301145649.GM18792@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@kernel.org>

On Tue, Mar 1, 2016 at 3:56 PM, Juri Lelli <juri.lelli@arm.com> wrote:
> On 26/02/16 03:36, Rafael J. Wysocki wrote:
>> On Thursday, February 25, 2016 11:01:20 AM Juri Lelli wrote:
>
> [...]
>
>> >
>> > That is right. But, can't an higher priority class eat all the needed
>> > capacity. I mean, suppose that both CFS and DL need 30% of CPU capacity
>> > on the same CPU. DL wins and gets its 30% of capacity. When CFS gets to
>> > run it's too late for requesting anything more (w.r.t. the same time
>> > window). If we somehow aggregate requests instead, we could request 60%
>> > and both classes can have their capacity to run. It seems to me that
>> > this is what governors were already doing by using the 1 - idle metric.
>>
>> That's interesting, because it is about a few different things at a time. :-)
>>
>> So first of all the "old" governors only collect information about what
>> happened in the past and make decisions on that basis (kind of in the hope
>> that what happened once will happen again), while the idea behind what
>> you're describing seems to be to attempt to project future needs for
>> capacity and use that to make decisions (just for the very near future,
>> but that should be sufficient).  If successful, that would be the most
>> suitable approach IMO.
>>
>
> Right, this is a key difference.
>
>> Of course, the $subject patch is not aspiring to anything of that kind.
>> It only uses information about current needs that's already available to
>> it in a very straightforward way.
>>
>
> But, using utilization of CFS tasks (based on PELT) has already some
> notion of "future needs" (even if it is true that tasks might have
> phases). And this will be true for DL as well, once we will have a
> corresponding utilization signal that we can consume. I think you are
> already consuming information about the future in some sense. :-)

That's because the already available numbers include that information.
I don't do any projections myself.

>> But there's more to it.  In the sampling, or rate-limiting if you will,
>> situation you really have a window in which many things can happen and
>> making a good decision at the beginning of it is important.  However, if
>> you just can handle *every* request and really switch frequencies on the
>> fly, then each of them may come with a "currently needed capacity" number
>> and you can just give it what it asks for every time.
>>
>
> True. Rate-limiting poses interesting problems.
>
>> My point is that there are quite a few things to consider here and I'm
>> expecting a learning process to happen before we are happy with what we
>> have.  So my approach would be (and is) to start very simple and then
>> add more complexity over time as needed instead of just trying to address
>> every issue I can think about from the outset.
>>
>
> I perfectly understand that, and I agree that there is value in starting
> simple. I simply fear that aggregation of utilization signals will be one
> of the few things that will pop out fairly soon. :-)

That's OK.  If it is demonstrably better than the super-simple initial
approach, there won't be any reason to reject it.

Thanks,
Rafael
