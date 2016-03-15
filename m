From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/8] sched/cpufreq: remove cpufreq_trigger_update()
Date: Tue, 15 Mar 2016 22:14:48 +0100
Message-ID: <20160315211448.GB6344@twins.programming.kicks-ass.net>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-2-git-send-email-mturquette+renesas@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:38553 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbcCOVPR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Mar 2016 17:15:17 -0400
Content-Disposition: inline
In-Reply-To: <1457932932-28444-2-git-send-email-mturquette+renesas@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>

On Sun, Mar 13, 2016 at 10:22:05PM -0700, Michael Turquette wrote:
> cpufreq_trigger_update() was introduced in "cpufreq: Rework the
> scheduler hooks for triggering updates"[0]. Consensus is that this
> helper is not needed and removing it will aid in experimenting with
> deadline and rt capacity requests.
> 
> Instead of reverting the above patch, which includes useful renaming of
> data structures and related functions, simply remove the function,
> update affected kerneldoc and change rt.c and deadline.c to use
> cpufreq_update_util().

This fails to explain how the need for these hooks is dealt with.
