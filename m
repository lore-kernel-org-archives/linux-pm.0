From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/8] cpufreq/schedutil: sysfs capacity margin tunable
Date: Wed, 16 Mar 2016 09:05:03 +0100
Message-ID: <20160316080503.GS6344@twins.programming.kicks-ass.net>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-5-git-send-email-mturquette+renesas@baylibre.com>
 <20160315212047.GE6344@twins.programming.kicks-ass.net>
 <20160315214043.30639.75507@quark.deferred.io>
 <20160315214821.GM6344@twins.programming.kicks-ass.net>
 <20160315223701.30639.43127@quark.deferred.io>
 <56E8D4D9.1060202@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:48106 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933246AbcCPIFF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 04:05:05 -0400
Content-Disposition: inline
In-Reply-To: <56E8D4D9.1060202@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>, Patrick Bellasi <patrick.bellasi@arm.com>

On Tue, Mar 15, 2016 at 08:36:57PM -0700, Steve Muckle wrote:
> > Then again, maybe this knob will be part of the mythical
> > power-vs-performance slider?
> 
> Patrick Bellasi's schedtune series [0] (which I think is the referenced
> mythical slider) aims to provide a more sophisticated interface for
> tuning scheduler-driven frequency selection. In addition to a global
> boost value it includes a cgroup controller as well for per-task tuning.
> 
> I would definitely expect the margin/boost value to be modified at
> runtime, for example if the battery is running low, or the user wants
> 100% performance for a while, or the userspace framework wants to
> temporarily tailor the performance level for a particular set of tasks, etc.

OK, so how about we start with it as a debug knob, and once we have
experience and feel like it is indeed a useful runtime knob, we upgrade
it to ABI.

The problem with starting out as ABI is that its hard to take away
again.
