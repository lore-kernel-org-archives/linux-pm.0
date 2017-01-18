From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/4] Fixes for limits enforcement
Date: Wed, 18 Jan 2017 10:48:21 -0800
Message-ID: <1484765305-185352-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:22799 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752336AbdARSuB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Jan 2017 13:50:01 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

This series includes fixes for sysfs limits enforcement. Only the
patch 1/4 is new in 4.10.rc, others are not new issues.

Srinivas Pandruvada (4):
  cpufreq: intel_pstate: Fix sysfs limits enforcement for performance
    policy
  cpufreq: intel_pstate: Lower frequency than expected under no_turbo
  cpufreq: intel_pstate: Make HWP limits compatible with legacy
  cpufreq: intel_pstate: Calculate guaranteed performance for HWP

 drivers/cpufreq/intel_pstate.c | 113 +++++++++++++++++++++++++++++------------
 1 file changed, 80 insertions(+), 33 deletions(-)

-- 
2.7.4

