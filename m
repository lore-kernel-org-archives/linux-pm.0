From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] cpufreq: schedutil: Fix and optimization
Date: Sun, 19 Mar 2017 14:21:21 +0100
Message-ID: <4366682.tsferJN35u@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

Hi,

Patch [1/2] in this series fixes an initialization issue in schedutil.

Patch [2/2] is an optimization, but it also might be regarded as a fix or at
least a problem workaround.

Namely, while playing with the passive mode in intel_pstate lately I noticed
that schedutil evidently underestimated CPU utilization at high loads.  I guess
it has been known for a while, but this is the first time I've seen that so
clearly (actually by looking at the values written to the P-state request
register and not via frequencies).

After some investigation I can quite confidently attribute that to a PELT
metric issue, as everything else has been ruled out with high confidence,
and hence the patch (which also works around the problem adding even more
condifence to the observation that PELT underestimates CPU utilization at
least sometimes).

Thanks,
Rafael
