From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/3] cpufreq: schedutil: move slow path from workqueue to
 SCHED_FIFO task
Date: Fri, 11 Nov 2016 15:39:35 +0100
Message-ID: <20161111143935.GK3117@twins.programming.kicks-ass.net>
References: <cover.1478858983.git.viresh.kumar@linaro.org>
 <85bf45982709e06f7f42e1b8f8315945e9d9b6d0.1478858983.git.viresh.kumar@linaro.org>
 <d9caf98b-706d-d331-89c4-b75120589da3@sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:57278 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756217AbcKKOjn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Nov 2016 09:39:43 -0500
Content-Disposition: inline
In-Reply-To: <d9caf98b-706d-d331-89c4-b75120589da3@sssup.it>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tommaso Cucinotta <tommaso.cucinotta@sssup.it>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>

On Fri, Nov 11, 2016 at 03:32:04PM +0100, Tommaso Cucinotta wrote:
> >+	struct sched_param param = { .sched_priority = 50 };
> 
> won't you have a tunable here? (sysctl?)

You can use the regular userspace tools, like schedtool and chrt to set
priorities.
