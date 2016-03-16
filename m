From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 6/8] cpufreq/schedutil: sum per-sched class utilization
Date: Wed, 16 Mar 2016 19:36:07 +0100
Message-ID: <20160316183607.GI6344@twins.programming.kicks-ass.net>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-7-git-send-email-mturquette+renesas@baylibre.com>
 <20160315212926.GG6344@twins.programming.kicks-ass.net>
 <20160315220951.30639.12872@quark.deferred.io>
 <20160316073850.GO6344@twins.programming.kicks-ass.net>
 <56E9A3FD.9050309@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:38642 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934328AbcCPSgK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 14:36:10 -0400
Content-Disposition: inline
In-Reply-To: <56E9A3FD.9050309@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>

On Wed, Mar 16, 2016 at 11:20:45AM -0700, Steve Muckle wrote:
> On 03/16/2016 12:38 AM, Peter Zijlstra wrote:
> > Somewhere in the giant discussions I mentioned that we should be looking
> > at a CPPC like interface and pass {min,max} tuples to the cpufreq
> > selection thingy.
> > 
> > In that same discussion I also mentioned that we must compute min as the
> > hard dl reservation, but that for max we can actually use the avg dl +
> > avg rt + avg cfs.
> > 
> > That way there is far more room for selecting a sensible frequency.
> 
> Doesn't the above min/max policy mean that the platform will likely
> underserve the task load? If avg dl+rt+cfs represents our best estimate
> of the work to be done, I would think that should be the min.

Can't be the min, avg_dl might (and typically will be) must lower than
the worst case utilization estimates.

However if we use that as our min, peaks in DL utilization will not
complete, because we run at too low a frequency.

Therefore, the min must be given by our worst case utilization
reservation, not by the actual avg consumed.
