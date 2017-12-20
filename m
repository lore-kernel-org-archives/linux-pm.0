From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v3 0/6] cpufreq: schedutil: fixes for flags updates
Date: Wed, 20 Dec 2017 18:38:14 +0100
Message-ID: <20171220173814.GC22246@localhost.localdomain>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171220153029.dqrtjbyowhqdl56r@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34717 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755736AbdLTRiS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Dec 2017 12:38:18 -0500
Received: by mail-wr0-f195.google.com with SMTP id y21so22982151wrc.1
        for <linux-pm@vger.kernel.org>; Wed, 20 Dec 2017 09:38:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171220153029.dqrtjbyowhqdl56r@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On 20/12/17 16:30, Peter Zijlstra wrote:

[...]

> @@ -327,12 +331,7 @@ static unsigned int sugov_next_freq_shar
>  		if (delta_ns > TICK_NSEC) {
>  			j_sg_cpu->iowait_boost = 0;
>  			j_sg_cpu->iowait_boost_pending = false;
> -			j_sg_cpu->util_cfs = 0;
> -			if (j_sg_cpu->util_dl == 0)
> -				continue;
>  		}

This goes away because with Brendan/Vincent fix we don't need the
workaround for stale CFS util contribution for idle CPUs anymore?
