From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 3/5] cpufreq: ondemand: queue work for policy->cpus
 together
Date: Wed, 28 Oct 2015 12:16:35 +0530
Message-ID: <20151028064635.GC30039@ubuntu>
References: <cover.1444723240.git.viresh.kumar@linaro.org>
 <b98689db34097553ee142bbb2efda2612af553e5.1444723240.git.viresh.kumar@linaro.org>
 <1864040.ba6Ezq0vlE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34151 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754777AbbJ1Gqt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 02:46:49 -0400
Received: by padhk11 with SMTP id hk11so247721143pad.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2015 23:46:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1864040.ba6Ezq0vlE@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On 28-10-15, 07:38, Rafael J. Wysocki wrote:
> On Tuesday, October 13, 2015 01:39:03 PM Viresh Kumar wrote:
> > Currently update_sampling_rate() runs over each online CPU and
> > cancels/queues work on it. Its very inefficient for the case where a
> > single policy manages multiple CPUs, as they can be processed together.
> 
> In the case of one policy object shared between multiple CPUs, I'm
> wondering why we don't use a single delayed work function for all of them
> in the first place.  That would address the problem at the source instead
> of dealing with the symptoms.

That's what we had long back. The problem is that the timers queued
for cpufreq are deferrable and if the CPU, on which the timer is
queued, goes idle, then the governor would halt. And there can be
other CPUs in the policy->cpus group which are still running.

> > Also drop the unnecessary cancel_delayed_work_sync() as we are doing a
> > mod_delayed_work_on() in gov_queue_work(), which will take care of
> > pending works for us.
> 
> I'd prefer a separate patch for that if poss.

okay.

-- 
viresh
