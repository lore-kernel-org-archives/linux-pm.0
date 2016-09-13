From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [Resend][PATCH 2/3] cpufreq: schedutil: Add iowait boosting
Date: Tue, 13 Sep 2016 09:44:20 +0200
Message-ID: <20160913074420.GE5008@twins.programming.kicks-ass.net>
References: <21371892.ALJNnHKoBY@vostro.rjw.lan>
 <1928525.UHD8eb6HiL@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:47506 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbcIMHo1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Sep 2016 03:44:27 -0400
Content-Disposition: inline
In-Reply-To: <1928525.UHD8eb6HiL@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steve Muckle <smuckle@linaro.org>, Doug Smythies <doug.smythies@gmail.com>

On Sat, Sep 10, 2016 at 12:00:31AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Modify the schedutil cpufreq governor to boost the CPU
> frequency if the SCHED_CPUFREQ_IOWAIT flag is passed to
> it via cpufreq_update_util().
> 
> If that happens, the frequency is set to the maximum during
> the first update after receiving the SCHED_CPUFREQ_IOWAIT flag
> and then the boost is reduced by half during each following update.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Looks-good-to: Steve Muckle <smuckle@linaro.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
