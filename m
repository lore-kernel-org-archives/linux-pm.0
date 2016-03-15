From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 7/8] cpufreq: Frequency invariant scheduler load-tracking
 support
Date: Tue, 15 Mar 2016 22:32:53 +0100
Message-ID: <20160315213253.GH6344@twins.programming.kicks-ass.net>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-8-git-send-email-mturquette+renesas@baylibre.com>
 <56E85EEA.5000604@arm.com>
 <20160315201917.30639.2415@quark.deferred.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:38919 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbcCOVdU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Mar 2016 17:33:20 -0400
Content-Disposition: inline
In-Reply-To: <20160315201917.30639.2415@quark.deferred.io>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>

On Tue, Mar 15, 2016 at 01:19:17PM -0700, Michael Turquette wrote:
> That's what I had in mind. I guess that some day there will be a need to
> select implementations at run-time for both cpufreq (e.g. different
> cpufreq drivers might implement arch_scale_freq_capacity) and for the
> !CONFIG_CPU_FREQ case (e.g. different platforms might implement
> arch_scale_freq_capcity within the same arch).

No, no runtime selection. That gets us function pointers and other
indirect mess.

We should be trying very hard to get rid of that cpufreq_util_update()
pointer, not add more of that gunk.

Use self modifying code if you have to do something.
