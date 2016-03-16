From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 8/8] sched: prefer cpufreq_scale_freq_capacity
Date: Wed, 16 Mar 2016 13:41:34 +0100
Message-ID: <20160316124134.GR6375@twins.programming.kicks-ass.net>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-9-git-send-email-mturquette+renesas@baylibre.com>
 <20160315213744.GJ6344@twins.programming.kicks-ass.net>
 <20160315222721.30639.28332@quark.deferred.io>
 <20160316074752.GQ6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:56010 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755048AbcCPMmD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 08:42:03 -0400
Content-Disposition: inline
In-Reply-To: <20160316074752.GQ6344@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>

On Wed, Mar 16, 2016 at 08:47:52AM +0100, Peter Zijlstra wrote:
> On Tue, Mar 15, 2016 at 03:27:21PM -0700, Michael Turquette wrote:

> > I'm happy with it as a stop-gap, because it will initially work for
> > arm{64} and x86, but we'll still need run-time selection of
> > arch_scale_freq_capacity some day. Once we have that, I think that we
> > should favor a run-time provided implementation over the arch-provided
> > one.
> 
> Also, I'm thinking we don't need any of this. Your
> cpufreq_scale_freq_capacity() is completely and utterly pointless. 

Scrap that, while true to instant utilization, this isn't true for our
case, since our utilization numbers carry history, and any frequency
change in that window is relevant.


