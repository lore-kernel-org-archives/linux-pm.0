From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 0/6] cpufreq: schedutil: fixes for flags updates
Date: Wed, 20 Dec 2017 16:56:25 +0100
Message-ID: <20171220155625.lopjlsbvss3qgb4d@hirez.programming.kicks-ass.net>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171220153029.dqrtjbyowhqdl56r@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:47166 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755085AbdLTP4g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Dec 2017 10:56:36 -0500
Content-Disposition: inline
In-Reply-To: <20171220153029.dqrtjbyowhqdl56r@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On Wed, Dec 20, 2017 at 04:30:29PM +0100, Peter Zijlstra wrote:
> 
> So I ended up with the below (on top of Juri's cpufreq-dl patches).
> 
> It compiles, but that's about all the testing it had.

Should all be available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/core

compile tested only, I suppose the 0day bot will let me know soon enough
:-)
