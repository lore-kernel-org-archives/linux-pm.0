From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: schedutil: Fix per-CPU structure
 initialization in sugov_start()
Date: Mon, 20 Mar 2017 08:58:40 +0530
Message-ID: <20170320032840.GA25659@vireshk-i7>
References: <4366682.tsferJN35u@aspire.rjw.lan>
 <2230625.Zj7J7bOCCf@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35456 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751877AbdCTD2u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Mar 2017 23:28:50 -0400
Received: by mail-pg0-f47.google.com with SMTP id t143so4386481pgb.2
        for <linux-pm@vger.kernel.org>; Sun, 19 Mar 2017 20:28:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2230625.Zj7J7bOCCf@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>

On 19-03-17, 14:30, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> sugov_start() only initializes struct sugov_cpu per-CPU structures
> for shared policies, but it should do that for single-CPU policies too.
> 
> That in particular makes the IO-wait boost mechanism work in the
> cases when cpufreq policies correspond to individual CPUs.
> 
> Fixes: 21ca6d2c52f8 (cpufreq: schedutil: Add iowait boosting)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Cc: 4.9+ <stable@vger.kernel.org> # 4.9+

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
