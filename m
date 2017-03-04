From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/3] cpufreq: schedutil: remove redundant code from sugov_next_freq_shared()
Date: Sat, 04 Mar 2017 01:11:32 +0100
Message-ID: <1668614.4zDQWLsnmH@aspire.rjw.lan>
References: <cover.1488437503.git.viresh.kumar@linaro.org> <639aad743bac7f3292146738f44dbd1480169c8e.1488437503.git.viresh.kumar@linaro.org> <1772276.4tCnP8C0XV@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49149 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752146AbdCDAQ4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Mar 2017 19:16:56 -0500
In-Reply-To: <1772276.4tCnP8C0XV@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On Saturday, March 04, 2017 01:03:17 AM Rafael J. Wysocki wrote:
> On Thursday, March 02, 2017 02:03:22 PM Viresh Kumar wrote:
> > The same code is present both within and outside the loop and it doesn't
> > look like it provides any additional benefit.
> 
> Well, not quite.  This is on purpose.
> 
> Note the "if (j == smp_processor_id())" condition within the loop and think
> about how the current CPU is taken into account. :-)

Ah OK, you did that, sorry.

So one idea is that if SCHED_CPUFREQ_RT_DL is set in flags, we don't even
need to start the loop which is quite a cost to simply notice that there's
nothing to do.

Also I don't quite agree with adding an extra pair of integer multiplications
to that loop just to get rid of the extra args.  That aside from chasing extra
pointers, of course.

Thanks,
Rafael
