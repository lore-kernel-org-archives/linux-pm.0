From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [RFC PATCH 18/19] cpufreq: remove transition_lock
Date: Tue, 12 Jan 2016 16:54:52 -0800
Message-ID: <20160113005452.10884.77606@quark.deferred.io>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-19-git-send-email-juri.lelli@arm.com>
 <20160112112409.GJ1084@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34587 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735AbcAMBGN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 20:06:13 -0500
Received: by mail-pf0-f174.google.com with SMTP id q63so73637063pfb.1
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2016 17:06:13 -0800 (PST)
In-Reply-To: <20160112112409.GJ1084@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

Hi Viresh,

Quoting Viresh Kumar (2016-01-12 03:24:09)
> On 11-01-16, 17:35, Juri Lelli wrote:
> > From: Michael Turquette <mturquette@baylibre.com>
> > 
> > transition_lock was introduced to serialize cpufreq transition
> > notifiers. Instead of using a different lock for protecting concurrent
> > modifications of policy, it is better to require that callers of
> > transition notifiers implement appropriate locking (this is already the
> > case AFAICS). Removing transition_lock also simplifies current locking
> > scheme.
> 
> So, are you saying that the reasoning mentioned in this patch are all
> wrong?
> 
> commit 12478cf0c55e ("cpufreq: Make sure frequency transitions are
> serialized")

No, that's not what I'm saying. Quoting that patch:

"""
The key challenge is to allow drivers to begin the transition from one thread
and end it in a completely different thread (this is to enable drivers that do
asynchronous POSTCHANGE notification from bottom-halves, to also use the same
interface).

To achieve this, a 'transition_ongoing' flag, a 'transition_lock' spinlock and a
wait-queue are added per-policy. The flag and the wait-queue are used in
conjunction to create an "uninterrupted flow" from _begin() to _end(). The
spinlock is used to ensure that only one such "flow" is in flight at any given
time. Put together, this provides us all the necessary synchronization.
"""

So the transition_onging flag and wait-queue are all good. That stuff is
just great. This patch doesn't touch it.

What it does change is that it removes a superfluous spinlock that
should never have needed to exist in the first place.
cpufreq_freq_transition_begin is called directly by driver target
callbacks, and it is called by __cpufreq_driver_target.

__cpufreq_driver_target should be using a per-policy lock. Any other
behavior is just insane. I haven't gone through this thread to see if
that change has been made by Juri, but we need to get there either in
this series or the follow-up series that introduces some RCU locking.

Regards,
Mike

> 
> -- 
> viresh
