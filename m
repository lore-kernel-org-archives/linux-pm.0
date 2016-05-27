From: Wanpeng Li <kernellwp@gmail.com>
Subject: Re: [PATCH v2 3/3] cpufreq: schedutil: map raw required frequency to
 driver frequency
Date: Fri, 27 May 2016 13:41:02 +0800
Message-ID: <CANRm+Cyfi=u32ZWqqPfo+FxbTKayGhQZ5C97pQ5EBSRi84PA_w@mail.gmail.com>
References: <1464231181-30741-1-git-send-email-smuckle@linaro.org>
	<1464231181-30741-4-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34818 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbcE0FlE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 May 2016 01:41:04 -0400
In-Reply-To: <1464231181-30741-4-git-send-email-smuckle@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

2016-05-26 10:53 GMT+08:00 Steve Muckle <steve.muckle@linaro.org>:
> The slow-path frequency transition path is relatively expensive as it
> requires waking up a thread to do work. Should support be added for
> remote CPU cpufreq updates that is also expensive since it requires an
> IPI. These activities should be avoided if they are not necessary.
>
> To that end, calculate the actual driver-supported frequency required by
> the new utilization value in schedutil by using the recently added
> cpufreq_driver_resolve_freq callback. If it is the same as the
> previously requested driver frequency then there is no need to continue
> with the update assuming the cpu frequency limits have not changed. This
> will have additional benefits should the semantics of the rate limit be
> changed to apply solely to frequency transitions rather than to
> frequency calculations in schedutil.

sugov_should_update_freq() still be called before get_nex_freq() after
the patch applied, so rate limit still apply to both frequency
transitions and frequency calculations, right?

Regards,
Wanpeng Li
