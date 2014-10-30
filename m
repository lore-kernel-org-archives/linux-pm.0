From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFD PATCH 00/10] cpuidle: Predict the next events with the IO
 latencies
Date: Thu, 30 Oct 2014 15:38:53 +0100
Message-ID: <20141030143853.GF23531@worktop.programming.kicks-ass.net>
References: <1413986273-28522-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:53219 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760394AbaJ3Oi6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Oct 2014 10:38:58 -0400
Content-Disposition: inline
In-Reply-To: <1413986273-28522-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, axboe@kernel.dk, rafael.j.wysocki@intel.com, mingo@kernel.org, preeti@linux.vnet.ibm.com, Morten.Rasmussen@arm.com, mturquette@linaro.org, tuukka.tikkanen@linaro.org, nicolas.pitre@linaro.org, patches@linaro.org

On Wed, Oct 22, 2014 at 03:57:43PM +0200, Daniel Lezcano wrote:
> After discussing at the LPC2014 Dusseldorf, it appears the idea is
> good but the approach is wrong. The latency tracking must be done at
> the device level, per device and not in the task as what is doing this
> patchset.

end_page_writeback()->test_clear_page_writeback()->__bdi_writeout_inc()

Is the IO completion path that has a fair amount of statistics in, maybe
some of that is usable.

