From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFC][PATCH 5/7] cpufreq / sched: UUF_IO flag to indicate iowait
 condition
Date: Tue, 2 Aug 2016 15:02:45 -0700
Message-ID: <20160802220245.GA26555@graphite.smuckle.net>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan>
 <3009663.9YcxTKseiO@vostro.rjw.lan>
 <20160802012209.GB9332@graphite.smuckle.net>
 <CAJZ5v0hJL0qL6nYCWzyN4O0cqzjKCC0pprfo0tD8MZCtEj1==A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36301 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754915AbcHBWIq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Aug 2016 18:08:46 -0400
Received: by mail-pa0-f54.google.com with SMTP id pp5so67030548pac.3
        for <linux-pm@vger.kernel.org>; Tue, 02 Aug 2016 15:07:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hJL0qL6nYCWzyN4O0cqzjKCC0pprfo0tD8MZCtEj1==A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>

On Tue, Aug 02, 2016 at 03:37:02AM +0200, Rafael J. Wysocki wrote:
> On Tue, Aug 2, 2016 at 3:22 AM, Steve Muckle <steve.muckle@linaro.org> wrote:
> > On Mon, Aug 01, 2016 at 01:37:23AM +0200, Rafael J. Wysocki wrote:
> > ...
> >> For this purpose, define a new cpufreq_update_util() flag
> >> UUF_IO and modify enqueue_task_fair() to pass that flag to
> >> cpufreq_update_util() in the in_iowait case.  That generally
> >> requires cpufreq_update_util() to be called directly from there,
> >> because update_load_avg() is not likely to be invoked in that
> >> case.
> >
> > I didn't follow why the cpufreq hook won't likely be called if
> > in_iowait is set? AFAICS update_load_avg() gets called in the second loop
> > and calls update_cfs_rq_load_avg (triggers the hook).
> 
> In practice it turns out that in the majority of cases when in_iowait
> is set the second loop will not run.

My understanding of enqueue_task_fair() is that the first loop walks up
the portion of the sched_entity hierarchy that needs to be enqueued, and
the second loop updates the rest of the hierarchy that was already
enqueued.

Even if the se corresponding to the root cfs_rq needs to be enqueued
(meaning the whole hierarchy is traversed in the first loop and the
second loop does nothing), enqueue_entity() on the root cfs_rq should
result in the cpufreq hook being called, via enqueue_entity() ->
enqueue_entity_load_avg() -> update_cfs_rq_load_avg().

I'll keep looking to see if I've misunderstood something in here.

thanks,
Steve
