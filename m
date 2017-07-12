From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 3/4] intel_pstate: Ignore scheduler cpufreq callbacks on remote CPUs
Date: Thu, 13 Jul 2017 01:27:28 +0200
Message-ID: <1553512.bSzUx8PIdH@aspire.rjw.lan>
References: <cover.1498712046.git.viresh.kumar@linaro.org> <a33ba3746dacce67a7c2e17b64e54ee89f64a3bc.1498712046.git.viresh.kumar@linaro.org> <1498771438.7952.118.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46164 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751176AbdGLXfL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2017 19:35:11 -0400
In-Reply-To: <1498771438.7952.118.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org

On Thursday, June 29, 2017 02:23:58 PM Srinivas Pandruvada wrote:
> On Thu, 2017-06-29 at 10:56 +0530, Viresh Kumar wrote:
> > From: Steve Muckle <smuckle.linux@gmail.com>
> > 
> > In preparation for the scheduler cpufreq callback happening on remote
> > CPUs, check for this case in intel_pstate which currently requires
> > the
> > callback run on the local CPU. Such callbacks are ignored for now.
> Is it possible that we miss a chance to calculate load periodically at
> a predefined interval (10ms default), because the callback happened on
> a different CPU?

We won't.

The callback will just be invoked more often after this series and the check
this patch is adding to it is actually there in the callers now, so effectively
this just moves the check down the callchain.

It is confusing, though, because the two complementary changes are made by
different patches.

Also, Viresh please note that we have more than one governor callback in
intel_pstate now.

Thanks,
Rafael
