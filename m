From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH 0/2] cpufreq: powernv: Ramp-down global pstate slower than local-pstate
Date: Tue, 12 Apr 2016 23:36:24 +0530
Message-ID: <1460484386-28389-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp02.in.ibm.com ([125.16.236.2]:46980 "EHLO
	e28smtp02.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964907AbcDLSHt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2016 14:07:49 -0400
Received: from localhost
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <akshay.adiga@linux.vnet.ibm.com>;
	Tue, 12 Apr 2016 23:37:46 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u3CI839S15925620
	for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2016 23:38:04 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u3CI7eLX025813
	for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2016 23:37:42 +0530
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: ego@linux.vnet.ibm.com, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>

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

Akshay Adiga (1):
  powernv: Ramp-down global pstate slower than local-pstate

Shilpasri G Bhat (1):
  cpufreq: powernv: Remove flag use-case of policy->driver_data

 drivers/cpufreq/powernv-cpufreq.c | 250 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 242 insertions(+), 8 deletions(-)

-- 
2.5.5

