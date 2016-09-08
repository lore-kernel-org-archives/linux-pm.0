From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC/RFT][PATCH 0/4] cpufreq / sched: iowait boost in intel_pstate and schedutil
Date: Thu, 08 Sep 2016 02:37:28 +0200
Message-ID: <1545936.F2oyWdN6Zx@vostro.rjw.lan>
References: <2730042.XLMy9dAKI1@vostro.rjw.lan> <20160908002226.GC15431@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:52408 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1751673AbcIHAba (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Sep 2016 20:31:30 -0400
In-Reply-To: <20160908002226.GC15431@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Doug Smythies <doug.smythies@gmail.com>

On Wednesday, September 07, 2016 05:22:26 PM Steve Muckle wrote:
> On Sat, Sep 03, 2016 at 02:56:48AM +0200, Rafael J. Wysocki wrote:
> > Please let me know what you think and if you can run some benchmarks you
> > care about and see if the changes make any difference (this way or another),
> > please do that and let me know what you've found.
> 
> LGTM (I just reviewed the first and last patch, skipping the
> intel_pstate ones).
> 
> I was unable to see a conclusive power regression in Android audio, video or
> idle usecases on my hikey 96board.

Cool, thanks!

