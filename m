From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 3/3] cpufreq: schedutil: map raw required frequency to
 driver frequency
Date: Sun, 29 May 2016 02:40:14 +0200
Message-ID: <CAJZ5v0gxfRBeQTyHACVtRpon50N_t3qytrFPT4ga2zwPhVYYdw@mail.gmail.com>
References: <1464231181-30741-1-git-send-email-smuckle@linaro.org>
	<1464231181-30741-4-git-send-email-smuckle@linaro.org>
	<20160526071629.GW17585@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35742 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbcE2AkQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 28 May 2016 20:40:16 -0400
In-Reply-To: <20160526071629.GW17585@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On Thu, May 26, 2016 at 9:16 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 25-05-16, 19:53, Steve Muckle wrote:
>> The slow-path frequency transition path is relatively expensive as it
>> requires waking up a thread to do work. Should support be added for
>> remote CPU cpufreq updates that is also expensive since it requires an
>> IPI. These activities should be avoided if they are not necessary.
>>
>> To that end, calculate the actual driver-supported frequency required by
>> the new utilization value in schedutil by using the recently added
>> cpufreq_driver_resolve_freq callback. If it is the same as the
>> previously requested driver frequency then there is no need to continue
>> with the update assuming the cpu frequency limits have not changed. This
>> will have additional benefits should the semantics of the rate limit be
>> changed to apply solely to frequency transitions rather than to
>> frequency calculations in schedutil.

[cut]

> I also have a doubt (I am quite sure Rafael will have a reason for
> that, which I am failing to understand now), on why we are doing
> next_freq == UINT_MAX in sugov_should_update_freq().
>
> I understand that because the limits might have changed,
> need_freq_update would have been set to true. We should evaluate
> next-freq again without worrying about the load or the time since last
> evaluation.

This is in response to the "limits" event (or to the ->limits call
after my recent patches).  That event basically means "something has
changed, so if you have cached anything, invalidate it" to the
governor.  Accordingly, it invalidates next_freq, because that's a
cached value.

> But what will happen by forcefully calling the cpufreq routines to
> change the frequency, if next_freq hasn't changed even after limits
> updates?

I can't really parse the above question, so I'm not going to try to
answer it. :-)

> Wouldn't that call always return early because the new freq
> and the current freq are going to be same ?
>
> @Rafael: Sorry for asking this so late :(

It is not too late.  If there's a problem somewhere, it needs to be
fixed, but at this point I have no idea what you are asking about.
