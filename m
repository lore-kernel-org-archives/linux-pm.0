From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [RFC/RFT][PATCH 0/4] cpufreq / sched: iowait boost in
 intel_pstate and schedutil
Date: Wed, 07 Sep 2016 17:35:50 -0700
Message-ID: <1473294950.154359.38.camel@linux.intel.com>
References: <2730042.XLMy9dAKI1@vostro.rjw.lan>
         <20160908002226.GC15431@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:10317 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751288AbcIHAfv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Sep 2016 20:35:51 -0400
In-Reply-To: <20160908002226.GC15431@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Doug Smythies <doug.smythies@gmail.com>

On Wed, 2016-09-07 at 17:22 -0700, Steve Muckle wrote:
> On Sat, Sep 03, 2016 at 02:56:48AM +0200, Rafael J. Wysocki wrote:
> > 
> > Please let me know what you think and if you can run some
> > benchmarks you
> > care about and see if the changes make any difference (this way or
> > another),
> > please do that and let me know what you've found.
> 
> LGTM (I just reviewed the first and last patch, skipping the
> intel_pstate ones).
> 
> I was unable to see a conclusive power regression in Android audio,
> video or
> idle usecases on my hikey 96board.
Did you see any performance regression on Android workloads?

Thanks,
Srinivas
> 
> thanks,
> Steve
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
