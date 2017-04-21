From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Performance of low-cpu utilisation benchmark regressed severely since 4.6
Date: Fri, 21 Apr 2017 03:12:21 +0200
Message-ID: <4801571.0BMNcJV3bj@aspire.rjw.lan>
References: <20170410084117.rjh3mtdx7hd2i5ze@techsingularity.net> <003101d2b573$16b28370$44178a50$@net> <20170419081537.byeqli7qrnqqvyue@techsingularity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57118 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1034024AbdDUBSd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2017 21:18:33 -0400
In-Reply-To: <20170419081537.byeqli7qrnqqvyue@techsingularity.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Doug Smythies <dsmythies@telus.net>, 'Rafael Wysocki' <rafael.j.wysocki@intel.com>, =?ISO-8859-1?Q?=27J=F6rg?= Otte' <jrg.otte@gmail.com>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>

On Wednesday, April 19, 2017 09:15:37 AM Mel Gorman wrote:
> On Fri, Apr 14, 2017 at 04:01:40PM -0700, Doug Smythies wrote:
> > Hi Mel,
> > 
> > Thanks for the "how to" information.
> > This is a very interesting use case.
> > From trace data, I see a lot of minimal durations with
> > virtually no load on the CPU, typically more consistent
> > with some type of light duty periodic (~~100 Hz) work flow
> > (where we would prefer to not ramp up frequencies, or more
> > accurately keep them ramped up).
> 
> This broadly matches my expectations in terms of behaviour. It is a
> low duty workload but while I accept that a laptop may not want the
> frequencies to ramp up, it's not universally true. Long periods at low
> frequency to complete a workload is not necessarily better than using a
> high frequency to race to idle. Effectively, a low utilisation test suite
> could be considered as a "foreground task of high priority" and not a
> "background task of little interest".

That's fair enough, but somewhat hard to tell from within a scaling governor. :-)

[cut]

> 
> I have no reason to believe this is a methodology error and is due to a
> difference in CPU. Consider the following reports
> 
> http://beta.suse.com/private/mgorman/results/home/marvin/openSUSE-LEAP-42.2/global-dhp__workload_shellscripts-xfs/delboy/#gitsource
> http://beta.suse.com/private/mgorman/results/home/marvin/openSUSE-LEAP-42.2/global-dhp__workload_shellscripts-xfs/ivy/#gitsource
> 
> The first one (delboy) shows a gain of 1.35% and it's only for 4.11
> (kernel shown is 4.11-rc1 with vmscan-related patches on top that do not
> affect this test case) of -17.51% which is very similar to yours. The
> CPU there is a Xeon E3-1230 v5.
> 
> The second report (ivy) is the machine I'm based the original complain
> on and shows the large regression in elapsed time.
> 
> So, different CPUs have different behaviours which is no surprise at all
> considering that at the very least, exit latencies will be different.
> While there may not be a universally correct answer to how to do this
> automatically, is it possible to tune intel_pstate such that it ramps up
> quickly regardless of recent utilisation and reduces relatively slowly?
> That would be better from a power consumption perspective than setting the
> "performance" governor.

It should be, theoretically.

The way the load-based P-state selection algorithm works is based on computing
average utilization periodically and setting the frequency proportional to it with
a couple of twists.  The first twist is that the frequency will be bumped up for
tasks that have waited on I/O ("IO-wait boost").  The second one is that if the
frequency is to be reduced, it will not go down proportionally to the computed
average utilization, but to the frequency between the current (measured) one
and the one proportional to the utilization (so it will go down asymptotically
rather than in one go).

Now, of course, what matters is how often the average utilization is computed,
because if we average several small spikes over a broad sampling window, they
will just almost vanish in the average and the resulting frequency will be small.
If, in turn, the sampling interval is reduced, some intervals will get the spikes
(and for them the average utilization will be greater) and some of them will
get nothing (leading to average utilization close to zero) and now all depends
on the distribution of the spikes along the time axis.

You can actually try to test that on top of my linux-next branch by reducing
INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL (in intel_pstate.c) by, say, 1/2.

Thanks,
Rafael
