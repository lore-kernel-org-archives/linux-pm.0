From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 2/5] cpufreq: ondemand: update sampling rate immediately
Date: Wed, 28 Oct 2015 16:31:47 +0100
Message-ID: <3215277.8YKq8PWCpx@vostro.rjw.lan>
References: <cover.1444723240.git.viresh.kumar@linaro.org> <2498053.EX0k8RstLZ@vostro.rjw.lan> <20151028093109.GJ30039@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61199 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751008AbbJ1PCu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 11:02:50 -0400
In-Reply-To: <20151028093109.GJ30039@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On Wednesday, October 28, 2015 03:01:09 PM Viresh Kumar wrote:
> On 28-10-15, 07:28, Rafael J. Wysocki wrote:
> > Your argument seems to be that it should be OK to do the
> > cancel_delayed_work_sync()/gov_queue_work() combo in all cases, because
> > even if the new rate is greater than the old one, the user may actually
> > want it to take effect immediately and it shouldn't hurt to skip the next
> > sample anyway in that case.
> > 
> > Is this really the case, though?  What about the old rate is 1s, the new one
> > is 2s and the timer is just about to expire?  Won't the canceling effectively
> > move the next sample 3s away from the previous one which may not be desirable?
> > 
> > The current code just allows the timer to expire, unless that would prevent
> > the new rate from taking effect for too long, which seems perfectly reasonable
> > to me.
> 
> Okay, what about this case: old rate is 1s, new rate it 5s and we have
> just serviced the timer. With the current code we will receive
> evaluate again after 1 second instead of 5. Is that desirable ?

That is OK.

The change is not guaranteed to happen instantaneously and the old rate may
stay in effect for a longer while.

The case in which that may be annoying (but arguably not incorrect) is when
the new rate is much less than the old one, but that is currently optimized
for.

> I didn't wanted to keep special code for such corner cases. And then
> how many times are we going to update sampling rates ?
> 
> But if we want to do something special, then we may schedule the work
> for following delay:
> 
> delay = shared->time_stamp + new_sampling_rate.
> 
> shared->time_stamp is the last time we evaluated the load.
> 
> With this, we will be at shoot at the exact requested time, relative
> to the last time we evaluated the loads.

Is the current code really problematic?

Thanks,
Rafael

