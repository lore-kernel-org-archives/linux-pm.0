From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 8/8] sched: prefer cpufreq_scale_freq_capacity
Date: Wed, 16 Mar 2016 21:07:52 +0100
Message-ID: <20160316200752.GJ6344@twins.programming.kicks-ass.net>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-9-git-send-email-mturquette+renesas@baylibre.com>
 <56E85EF6.5040005@arm.com>
 <20160315204630.30639.60702@quark.deferred.io>
 <56E9B7A1.5030806@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:40700 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967008AbcCPUH4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 16:07:56 -0400
Content-Disposition: inline
In-Reply-To: <56E9B7A1.5030806@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Michael Turquette <mturquette@baylibre.com>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>

On Wed, Mar 16, 2016 at 07:44:33PM +0000, Dietmar Eggemann wrote:
> intel_pstate (setpolicy()) is an exception but my humble guess is that
> systems with intel_pstate driver have X86_FEATURE_APERFMPERF support.

A quick browse of the Intel SDM says you're right. It looks like
everything after Pentium-M; so Core-Solo/Core-Duo and onwards have
APERF/MPERF.

And it looks like P6 class systems didn't have DVFS support at all,
which basically leaves P4 and Pentium-M as the only chips to have DVFS
support lacking APERF/MPERF.

And while I haven't got any P4 based space heaters left, I might still
have a Pentium-M class laptop somewhere (if it still boots).

