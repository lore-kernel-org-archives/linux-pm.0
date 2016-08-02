From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC][PATCH 5/7] cpufreq / sched: UUF_IO flag to indicate iowait condition
Date: Wed, 3 Aug 2016 00:38:20 +0200
Message-ID: <CAJZ5v0j_MrarqdXh8DHHnMm4EbzEksJ8f=BD_=VzPfSD00qRKg@mail.gmail.com>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan> <3009663.9YcxTKseiO@vostro.rjw.lan>
 <20160802012209.GB9332@graphite.smuckle.net> <CAJZ5v0hJL0qL6nYCWzyN4O0cqzjKCC0pprfo0tD8MZCtEj1==A@mail.gmail.com>
 <20160802220245.GA26555@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36717 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556AbcHBWjj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Aug 2016 18:39:39 -0400
In-Reply-To: <20160802220245.GA26555@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>

On Wed, Aug 3, 2016 at 12:02 AM, Steve Muckle <steve.muckle@linaro.org> wrote:
> On Tue, Aug 02, 2016 at 03:37:02AM +0200, Rafael J. Wysocki wrote:
>> On Tue, Aug 2, 2016 at 3:22 AM, Steve Muckle <steve.muckle@linaro.org> wrote:
>> > On Mon, Aug 01, 2016 at 01:37:23AM +0200, Rafael J. Wysocki wrote:
>> > ...
>> >> For this purpose, define a new cpufreq_update_util() flag
>> >> UUF_IO and modify enqueue_task_fair() to pass that flag to
>> >> cpufreq_update_util() in the in_iowait case.  That generally
>> >> requires cpufreq_update_util() to be called directly from there,
>> >> because update_load_avg() is not likely to be invoked in that
>> >> case.
>> >
>> > I didn't follow why the cpufreq hook won't likely be called if
>> > in_iowait is set? AFAICS update_load_avg() gets called in the second loop
>> > and calls update_cfs_rq_load_avg (triggers the hook).
>>
>> In practice it turns out that in the majority of cases when in_iowait
>> is set the second loop will not run.
>
> My understanding of enqueue_task_fair() is that the first loop walks up
> the portion of the sched_entity hierarchy that needs to be enqueued, and
> the second loop updates the rest of the hierarchy that was already
> enqueued.
>
> Even if the se corresponding to the root cfs_rq needs to be enqueued
> (meaning the whole hierarchy is traversed in the first loop and the
> second loop does nothing), enqueue_entity() on the root cfs_rq should
> result in the cpufreq hook being called, via enqueue_entity() ->
> enqueue_entity_load_avg() -> update_cfs_rq_load_avg().

But then it's rather difficult to pass the IO flag to this one, isn't it?

Essentially, the problem is to pass "IO" to cpufreq_update_util() when
p->in_iowait is set.

If you can find a clever way to do it without adding an extra call
site, that's fine by me, but in any case the extra
cpufreq_update_util() invocation should not be too expensive.

Thanks,
Rafael
