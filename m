From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/8] cpufreq/schedutil: sysfs capacity margin tunable
Date: Tue, 15 Mar 2016 22:20:47 +0100
Message-ID: <20160315212047.GE6344@twins.programming.kicks-ass.net>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-5-git-send-email-mturquette+renesas@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:38667 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbcCOVUu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Mar 2016 17:20:50 -0400
Content-Disposition: inline
In-Reply-To: <1457932932-28444-5-git-send-email-mturquette+renesas@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>

On Sun, Mar 13, 2016 at 10:22:08PM -0700, Michael Turquette wrote:
> With the addition of the global cfs capacity margin helpers in patch,
> "sched/cpufreq: new cfs capacity margin helpers", we can now export
> sysfs tunables from the schedutil governor. This allows privileged users
> to tune the value more easily.
> 
> The margin value is global to cfs, not per-policy. As such schedutil
> does not store any state about the margin. Schedutil restores the margin
> value to its default value when exiting.

Yuck sysfs.. I would really rather we did not expose this per default.
And certainly not in this weird form.
