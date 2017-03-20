From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] cpufreq: schedutil: Fix per-CPU structure initialization in sugov_start()
Date: Mon, 20 Mar 2017 13:36:06 +0100
Message-ID: <3822450.QzCeJBOUoJ@aspire.rjw.lan>
References: <4366682.tsferJN35u@aspire.rjw.lan> <2230625.Zj7J7bOCCf@aspire.rjw.lan> <20170320032840.GA25659@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49436 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753477AbdCTMlo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2017 08:41:44 -0400
In-Reply-To: <20170320032840.GA25659@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>

On Monday, March 20, 2017 08:58:40 AM Viresh Kumar wrote:
> On 19-03-17, 14:30, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > sugov_start() only initializes struct sugov_cpu per-CPU structures
> > for shared policies, but it should do that for single-CPU policies too.
> > 
> > That in particular makes the IO-wait boost mechanism work in the
> > cases when cpufreq policies correspond to individual CPUs.
> > 
> > Fixes: 21ca6d2c52f8 (cpufreq: schedutil: Add iowait boosting)
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Cc: 4.9+ <stable@vger.kernel.org> # 4.9+

"stable" checks Fixes: tags too, but yes.

> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks,
Rafael
