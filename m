From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFD PATCH 4/5] sched/cpufreq_schedutil: always consider all CPUs when deciding next freq
Date: Thu, 30 Mar 2017 00:41:36 +0200
Message-ID: <2348394.hDdCk9fbgK@aspire.rjw.lan>
References: <20170324140900.7334-1-juri.lelli@arm.com> <20170324140900.7334-5-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46057 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932172AbdC2WrU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Mar 2017 18:47:20 -0400
In-Reply-To: <20170324140900.7334-5-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, Ingo Molnar <mingo@kernel.org>

On Friday, March 24, 2017 02:08:59 PM Juri Lelli wrote:
> No assumption can be made upon the rate at which frequency updates get
> triggered, as there are scheduling policies (like SCHED_DEADLINE) which
> don't trigger them so frequently.
> 
> Remove such assumption from the code.

But the util/max values for idle CPUs may be stale, no?

Thanks,
Rafael
