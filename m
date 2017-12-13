From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/4] sched/fair: add util_est on top of PELT
Date: Wed, 13 Dec 2017 17:05:37 +0100
Message-ID: <20171213160537.uqa423dyt5wrpgll@hirez.programming.kicks-ass.net>
References: <20171205171018.9203-1-patrick.bellasi@arm.com>
 <20171205171018.9203-3-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:57093 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752860AbdLMQFn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Dec 2017 11:05:43 -0500
Content-Disposition: inline
In-Reply-To: <20171205171018.9203-3-patrick.bellasi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On Tue, Dec 05, 2017 at 05:10:16PM +0000, Patrick Bellasi wrote:
> +	if (cfs_rq->nr_running > 0) {
> +		util_est  = cfs_rq->util_est_runnable;
> +		util_est -= task_util_est(p);
> +		if (util_est < 0)
> +			util_est = 0;
> +		cfs_rq->util_est_runnable = util_est;
> +	} else {

I'm thinking that's an explicit load-store to avoid intermediate values
landing in cfs_rq->util_esp_runnable, right?

That would need READ_ONCE() / WRITE_ONCE() I think, without that the
compiler is free to munge the lot together.
