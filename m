From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V4] cpufreq: governor: Quit work-handlers early if governor is stopped
Date: Thu, 05 Nov 2015 23:41:36 +0100
Message-ID: <10826143.ebnrY1EVJN@vostro.rjw.lan>
References: <133510f34e89a9be81766bea3c7ddc1605198ee6.1446086230.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50611 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751046AbbKEWMY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2015 17:12:24 -0500
In-Reply-To: <133510f34e89a9be81766bea3c7ddc1605198ee6.1446086230.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On Thursday, October 29, 2015 08:08:38 AM Viresh Kumar wrote:
> gov_queue_work() acquires cpufreq_governor_lock to allow
> cpufreq_governor_stop() to drain delayed work items possibly scheduled
> on CPUs that share the policy with a CPU being taken offline.
> 
> However, the same goal may be achieved in a more straightforward way if
> the policy pointer in the struct cpu_dbs_info matching the policy CPU is
> reset upfront by cpufreq_governor_stop() under the timer_mutex belonging
> to it and checked against NULL, under the same lock, at the beginning of
> dbs_timer().
> 
> In that case every instance of dbs_timer() run for a struct cpu_dbs_info
> sharing the policy pointer in question after cpufreq_governor_stop() has
> started will notice that that pointer is NULL and bail out immediately
> without queuing up any new work items.  In turn, gov_cancel_work()
> called by cpufreq_governor_stop() before destroying timer_mutex will
> wait for all of the delayed work items currently running on the CPUs
> sharing the policy to drop the mutex, so it may be destroyed safely.
> 
> Make cpufreq_governor_stop() and dbs_timer() work as described and
> modify gov_queue_work() so it does not acquire cpufreq_governor_lock any
> more.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

Rafael

