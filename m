From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH v2 0/2] cpufreq: powernv: Ramp-down global pstate slower than local-pstate
Date: Fri, 15 Apr 2016 11:58:57 +0530
Message-ID: <1460701739-31549-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: ego@linux.vnet.ibm.com, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

The frequency transition latency from pmin to pmax is observed to be in few
millisecond granurality. And it usually happens to take a performance penalty
during sudden frequency rampup requests.

This patch set solves this problem by using a chip-level entity called "global
 pstates". Global pstate manages elements across other dependent core chiplets.
Typically, the element that needs to be managed is the voltage setting.
So by holding global pstates higher than local pstate for some amount of time
( ~5 seconds) the subsequent rampups could be made faster.

(1/2) patch removes the flag from cpufreq_policy->driver_data, so that it can
be used for tracking global pstates.

(2/2) patch adds code for global pstate management.

- The iozone results with this patchset, shows improvements in almost all cases.
- YCSB workload on redis with various  target operations per second shows 
better MaxLatency with this patch.

Changes from v1:
- Fixed coding style
- Added a routine to reset global_pstate_info instead of hacky memset
- Handled case when cpufreq_table_validate_and_show() fails
- changed int queue_gpstate_timer() to void queue_gpstate_timer()


Akshay Adiga (1):
  cpufreq: powernv: Ramp-down global pstate slower than local-pstate

Shilpasri G Bhat (1):
  cpufreq: powernv: Remove flag use-case of policy->driver_data

 drivers/cpufreq/powernv-cpufreq.c | 272 +++++++++++++++++++++++++++++++++++---
 1 file changed, 257 insertions(+), 15 deletions(-)

-- 
2.5.5
