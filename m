From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH v2 3/3] cpufreq: schedutil: map raw required frequency to
 driver frequency
Date: Mon, 30 May 2016 09:48:33 -0700
Message-ID: <20160530164833.GH9864@graphite.smuckle.net>
References: <1464231181-30741-1-git-send-email-smuckle@linaro.org>
 <1464231181-30741-4-git-send-email-smuckle@linaro.org>
 <CANRm+Cyfi=u32ZWqqPfo+FxbTKayGhQZ5C97pQ5EBSRi84PA_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:32810 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161656AbcE3Qsh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 May 2016 12:48:37 -0400
Received: by mail-pf0-f172.google.com with SMTP id b124so65978140pfb.0
        for <linux-pm@vger.kernel.org>; Mon, 30 May 2016 09:48:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANRm+Cyfi=u32ZWqqPfo+FxbTKayGhQZ5C97pQ5EBSRi84PA_w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wanpeng Li <kernellwp@gmail.com>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On Fri, May 27, 2016 at 01:41:02PM +0800, Wanpeng Li wrote:
> 2016-05-26 10:53 GMT+08:00 Steve Muckle <steve.muckle@linaro.org>:
> > The slow-path frequency transition path is relatively expensive as it
> > requires waking up a thread to do work. Should support be added for
> > remote CPU cpufreq updates that is also expensive since it requires an
> > IPI. These activities should be avoided if they are not necessary.
> >
> > To that end, calculate the actual driver-supported frequency required by
> > the new utilization value in schedutil by using the recently added
> > cpufreq_driver_resolve_freq callback. If it is the same as the
> > previously requested driver frequency then there is no need to continue
> > with the update assuming the cpu frequency limits have not changed. This
> > will have additional benefits should the semantics of the rate limit be
> > changed to apply solely to frequency transitions rather than to
> > frequency calculations in schedutil.
> 
> sugov_should_update_freq() still be called before get_nex_freq() after
> the patch applied, so rate limit still apply to both frequency
> transitions and frequency calculations, right?

Yes this series does not change the semantics of the rate limit. It
only includes the changes required for resolving raw target frequencies
to driver-supported frequencies so redundant operations can be avoided.

FWIW the approach I took to change the rate_limit semantics [0] just
moves where last_freq_update_time is set. I was going to return to that
once these changes are complete.

[0]: https://lkml.org/lkml/2016/5/9/857

thanks,
Steve
