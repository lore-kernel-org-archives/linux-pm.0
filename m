From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 3/5] cpufreq: ondemand: queue work for policy->cpus together
Date: Wed, 28 Oct 2015 08:33:51 +0100
Message-ID: <1726178.nnqopTm3i6@vostro.rjw.lan>
References: <cover.1444723240.git.viresh.kumar@linaro.org> <1864040.ba6Ezq0vlE@vostro.rjw.lan> <20151028064635.GC30039@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:43991 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754527AbbJ1HEz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 03:04:55 -0400
In-Reply-To: <20151028064635.GC30039@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On Wednesday, October 28, 2015 12:16:35 PM Viresh Kumar wrote:
> On 28-10-15, 07:38, Rafael J. Wysocki wrote:
> > On Tuesday, October 13, 2015 01:39:03 PM Viresh Kumar wrote:
> > > Currently update_sampling_rate() runs over each online CPU and
> > > cancels/queues work on it. Its very inefficient for the case where a
> > > single policy manages multiple CPUs, as they can be processed together.
> > 
> > In the case of one policy object shared between multiple CPUs, I'm
> > wondering why we don't use a single delayed work function for all of them
> > in the first place.  That would address the problem at the source instead
> > of dealing with the symptoms.
> 
> That's what we had long back. The problem is that the timers queued
> for cpufreq are deferrable and if the CPU, on which the timer is
> queued, goes idle, then the governor would halt. And there can be
> other CPUs in the policy->cpus group which are still running.

It looks like we shouldn't be using delayed works for this, really.

We should be using timer functions and normal work items.  Schedule the
timer function on all CPUs sharing the policy and then queue up the
work item from the first one that executes the timer.  Then make the
timer function bail out immediately until the work has completed and
re-schedule the timers from the work item.

Thanks,
Rafael

