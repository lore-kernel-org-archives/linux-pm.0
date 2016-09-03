From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC/RFT][PATCH 0/4] cpufreq / sched: iowait boost in intel_pstate and schedutil
Date: Sat, 03 Sep 2016 02:56:48 +0200
Message-ID: <2730042.XLMy9dAKI1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:50781 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1752771AbcICA7P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Sep 2016 20:59:15 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steve Muckle <smuckle@linaro.org>, Doug Smythies <doug.smythies@gmail.com>

Hi Everyone,

This is a new version of the "iowait boost" series I posted a few weeks
ago.  Since the first two patches from that series have been reworked and
are in linux-next now, I've rebased this series on top of my linux-next
branch.

In addition to that I took the Doug's feedback into account in the
intel_pstate patches [2-3/4].

Please let me know what you think and if you can run some benchmarks you
care about and see if the changes make any difference (this way or another),
please do that and let me know what you've found.

Thanks,
Rafael

