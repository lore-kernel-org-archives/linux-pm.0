From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 1/5] cpufreq: ondemand: Drop unnecessary locks from update_sampling_rate()
Date: Wed, 28 Oct 2015 05:05:06 +0100
Message-ID: <9152551.Va141R8GGE@vostro.rjw.lan>
References: <cover.1444723240.git.viresh.kumar@linaro.org> <56084623b2c27372a4c2c598151dd47176c3e26f.1444723240.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:48015 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751976AbbJ1DgK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2015 23:36:10 -0400
In-Reply-To: <56084623b2c27372a4c2c598151dd47176c3e26f.1444723240.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Preeti U Murthy <preeti@linux.vnet.ibm.com>, open list <linux-kernel@vger.kernel.org>

On Tuesday, October 13, 2015 01:39:01 PM Viresh Kumar wrote:
> 'timer_mutex' is required to sync work-handlers of policy->cpus.
> update_sampling_rate() is just canceling the works and queuing them
> again. This isn't protecting anything at all in update_sampling_rate()
> and is not gonna be of any use.
> 
> Even if a work-handler is already running for a CPU,
> cancel_delayed_work_sync() will wait for it to finish.
> 
> Drop these unnecessary locks.
> 
> Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

I'm queuing this up for 4.4, although I think that the changelog is not right.

While at it, what are the race conditions the lock is protecting against?

Thanks,
Rafael

