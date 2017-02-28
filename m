From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 3/3] cpufreq: intel_pstate: Fix intel_pstate_verify_policy()
Date: Wed, 01 Mar 2017 00:11:05 +0100
Message-ID: <2160593.qOyP8m7930@aspire.rjw.lan>
References: <2694426.SgxlQuL17D@aspire.rjw.lan> <2326598.n0dkg1GrdM@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:63145 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751877AbdB1XZF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Feb 2017 18:25:05 -0500
In-Reply-To: <2326598.n0dkg1GrdM@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The code added to intel_pstate_verify_policy() by commit 1443ebbacfd7
(cpufreq: intel_pstate: Fix sysfs limits enforcement for performance
policy) should use perf_limits instead of limits, because otherwise
setting global limits via sysfs may affect policies inconsistently.

For example, in the sequence of shell commands below, the
scaling_min_freq attribute for policy1 and policy2 should be
affected in the same way, because scaling_governor is set in
the same way for both of them:

 # cat cpufreq/policy1/scaling_governor
 powersave
 # cat cpufreq/policy2/scaling_governor
 powersave
 # echo performance > cpufreq/policy0/scaling_governor
 # echo 94 > intel_pstate/min_perf_pct
 # cat cpufreq/policy0/scaling_min_freq
 2914000
 # cat cpufreq/policy1/scaling_min_freq
 2914000
 # cat cpufreq/policy2/scaling_min_freq
 800000

The are affected differently, because intel_pstate_verify_policy()
is invoked with limits set to &performance_limits (left behind by
policy0) for policy1 and with limits set to &powersave_limits (left
behind by policy1) for policy2.  Since perf_limits is set to the
set of limits matching the policy being updated, using it instead
of limits fixes the inconsistency.

Fixes: 1443ebbacfd7 (cpufreq: intel_pstate: Fix sysfs limits enforcement for performance policy)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2208,9 +2208,9 @@ static int intel_pstate_verify_policy(st
 		unsigned int max_freq, min_freq;
 
 		max_freq = policy->cpuinfo.max_freq *
-						limits->max_sysfs_pct / 100;
+					perf_limits->max_sysfs_pct / 100;
 		min_freq = policy->cpuinfo.max_freq *
-						limits->min_sysfs_pct / 100;
+					perf_limits->min_sysfs_pct / 100;
 		cpufreq_verify_within_limits(policy, min_freq, max_freq);
 	}
 
