From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Don't send callback pointer to cpufreq_add_update_util_hook()
Date: Thu, 17 Aug 2017 17:31:38 +0200
Message-ID: <2692371.TLU4a4PDeX@aspire.rjw.lan>
References: <fb914a5aef386f7c3ae6ea5ed53e1fc299f47869.1502971486.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:64737 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751561AbdHQPqp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Aug 2017 11:46:45 -0400
In-Reply-To: <fb914a5aef386f7c3ae6ea5ed53e1fc299f47869.1502971486.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org

On Thursday, August 17, 2017 2:04:48 PM CEST Viresh Kumar wrote:
> The callers already have the structure (struct update_util_data) where
> the function pointer is saved by cpufreq_add_update_util_hook(). And its
> better if the callers fill it themselves, as they can do it from the
> governor->init() callback then, which is called only once per policy
> lifetime rather than doing it from governor->start which can get called
> multiple times.

So what problem exactly is this addressing?

Thanks,
Rafael
