From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 0/6] cpufreq: schedutil: fixes for flags updates
Date: Thu, 21 Dec 2017 16:13:17 +0530
Message-ID: <20171221104317.GB8312@vireshk-i7>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171220153029.dqrtjbyowhqdl56r@hirez.programming.kicks-ass.net>
 <20171220154358.663yoodeoxkqghx7@hirez.programming.kicks-ass.net>
 <20171221091502.GE19815@vireshk-i7>
 <20171221102530.all2hqoyh77mffmf@hirez.programming.kicks-ass.net>
 <20171221103022.GA8312@vireshk-i7>
 <20171221103941.ykehmki7m32r4pyr@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pl0-f47.google.com ([209.85.160.47]:36326 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753267AbdLUKnV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Dec 2017 05:43:21 -0500
Received: by mail-pl0-f47.google.com with SMTP id b12so10742180plm.3
        for <linux-pm@vger.kernel.org>; Thu, 21 Dec 2017 02:43:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171221103941.ykehmki7m32r4pyr@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On 21-12-17, 11:39, Peter Zijlstra wrote:
> The difference is that we apply the per-cpu boost on the per-cpu util
> value and _then_ find the overall maximum.
> 
> Instead of finding the overall maximum and then apply the per-cpu boost
> to that.

Okay, so it is just about the right sequencing of these comparisons but the
outcome will still be same, i.e. max of the 3 util/max values. Thanks.

-- 
viresh
