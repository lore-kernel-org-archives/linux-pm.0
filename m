From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH v1 2/8] sched/deadline: move cpu frequency selection
 triggering points
Date: Fri, 7 Jul 2017 12:51:04 +0530
Message-ID: <20170707072104.GG1523@vireshk-i7>
References: <20170705085905.6558-1-juri.lelli@arm.com>
 <20170705085905.6558-3-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34533 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbdGGHVI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2017 03:21:08 -0400
Received: by mail-pf0-f172.google.com with SMTP id q85so13015595pfq.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Jul 2017 00:21:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170705085905.6558-3-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

On 05-07-17, 09:58, Juri Lelli wrote:
> Since SCHED_DEADLINE doesn't track utilization signal (but reserves a
> fraction of CPU bandwidth to tasks admitted to the system), there is no
> point in evaluating frequency changes during each tick event.
> 
> Move frequency selection triggering points to where running_bw changes.
> 
> Co-authored-by: Claudio Scordino <claudio@evidence.eu.com>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Luca Abeni <luca.abeni@santannapisa.it>
> ---
> Changes from RFCv0:
> 
>  - modify comment regarding periodic RT updates (Claudio)
> ---
>  kernel/sched/deadline.c |  7 ++++---
>  kernel/sched/sched.h    | 12 ++++++------
>  2 files changed, 10 insertions(+), 9 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
