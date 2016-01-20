From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC PATCH 18/19] cpufreq: remove transition_lock
Date: Thu, 21 Jan 2016 00:33:28 +0100
Message-ID: <CAJZ5v0iGUbwDSUZDEcszeDaekqaF+Eq83TCkDpaDj9q2O1s5aw@mail.gmail.com>
References: <1452533760-13787-19-git-send-email-juri.lelli@arm.com>
	<20160119191734.GB6357@twins.programming.kicks-ass.net>
	<20160119192111.GC6373@twins.programming.kicks-ass.net>
	<10535878.57N9JsXUl5@vostro.rjw.lan>
	<20160120170448.GO6357@twins.programming.kicks-ass.net>
	<CAJZ5v0hB-HOLBggmih+ffZw=Rqpcdy9dMjh9AVfJKaQC-YHqxQ@mail.gmail.com>
	<20160120223809.GZ6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33497 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbcATXda (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 18:33:30 -0500
In-Reply-To: <20160120223809.GZ6357@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Michael Turquette <mturquette@baylibre.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, steve.muckle@linaro.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com

On Wed, Jan 20, 2016 at 11:38 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Jan 20, 2016 at 11:12:45PM +0100, Rafael J. Wysocki wrote:
>> > I would dangle _everything_ off the one driver pointer, that's much
>> > easier.
>>
>> I'm not sure how much easier it is in practice.
>>
>> Even if everything dangles out of the driver pointer, data structures
>> pointed to by those things need not be allocated all in one go by the
>> same entity.  Some of them are allocated by drivers, some of them by
>> the core, at different times.
>
> Yes, I've noticed, some of that is really bonkers.
>
>> The ordering between those allocations
>> and populating the pointers is what matters, not how all that is laid
>> out in memory.
>
> I'm thinking getting that ordering right is easier/more natural, if its
> all contained in one object. But this could be subjective.

I'm trying to look at this from the perspective of making changes.

It should be possible to change the ordering of how the data
structures are populated and pointers set without changing the
existing memory layout of them, which may allow us to minimize the
amount of changes to cpufreq drivers for old hardware (and therefore
generally difficult to test), for example.

Also, this way each individual change may be more limited in scope and
therefore less error prone IMO.
