From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [RFC/RFT][PATCH 0/4] cpufreq / sched: iowait boost in
 intel_pstate and schedutil
Date: Thu, 08 Sep 2016 12:49:30 -0700
Message-ID: <1473364170.154359.68.camel@linux.intel.com>
References: <2730042.XLMy9dAKI1@vostro.rjw.lan>
         <20160908002226.GC15431@graphite.smuckle.net>
         <1473294950.154359.38.camel@linux.intel.com>
         <20160908192615.GD15431@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:41231 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750992AbcIHTtb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Sep 2016 15:49:31 -0400
In-Reply-To: <20160908192615.GD15431@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Doug Smythies <doug.smythies@gmail.com>

On Thu, 2016-09-08 at 12:26 -0700, Steve Muckle wrote:
> On Wed, Sep 07, 2016 at 05:35:50PM -0700, Srinivas Pandruvada wrote:
> > 
> > Did you see any performance regression on Android workloads?
> 
> I did a few AnTuTU runs and did not observe a regression.
Thanks.

-Srinivas


> thanks,
> Steve
