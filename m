From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/2] PID debugfs files
Date: Thu, 20 Oct 2016 13:37:04 -0700
Message-ID: <1476995826-15536-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:21280 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755189AbcJTUhU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 20 Oct 2016 16:37:20 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

When PID is not used don't present PID parameters to tune.
Also update documentation.

Srinivas Pandruvada (2):
  cpufreq: intel_pstate: Remove PID debugfs when not used
  Documentation: intel_pstate: PID tuning is not always available

 Documentation/cpu-freq/intel-pstate.txt | 9 +++++----
 drivers/cpufreq/intel_pstate.c          | 4 +++-
 2 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.7.4

