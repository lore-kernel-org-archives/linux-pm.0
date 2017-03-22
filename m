From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] cpufreq: schedutil: Always trace frequency if it does
 not change
Date: Wed, 22 Mar 2017 10:29:51 +0100
Message-ID: <20170322092951.GX5680@worktop>
References: <10655562.4O9KtquB0A@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:44144 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759040AbdCVJ37 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2017 05:29:59 -0400
Content-Disposition: inline
In-Reply-To: <10655562.4O9KtquB0A@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>

On Wed, Mar 22, 2017 at 01:56:53AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> sugov_update_commit() calls trace_cpu_frequency() to record the
> current CPU frequency if it has not changed in the fast switch case
> to prevent utilities from getting confused (they may report that the
> CPU is idle if the frequency has not been recorded for too long, for
> example).

That seems like buggy tools; we should then fix the tools, not the
kernel to emit more superfluous information.

> However, the same problem may occur for a cpufreq driver that doesn't
> support fast frequency switching and implements the ->target callback
> (that is, it doesn't use frequency tables), but trace_cpu_frequency()
> is not called if frequency updates are skipped in that case.

I'm having trouble parsing that; am I right in understanding this is the
exact same scenario where only superfluous changes are omitted?

> For this reason, modify sugov_update_commit() to always call
> trace_cpu_frequency() when the new frequency to be set is equal to
> the one that was set previously and reorganize the code in there to
> reduce duplication somewhat.

So why not fix the tools?
