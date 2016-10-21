From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/4] cpufreq: intel_pstate: Per CPU performance control
Date: Fri, 21 Oct 2016 09:14:22 -0700
Message-ID: <1477066466-22367-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:14378 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753341AbcJUQOh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Oct 2016 12:14:37 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

v2
kernel command line to enable the feature
Global and per-cpu control are not available simultaneously
Global limits will be disabled when per cpu controls are selected


Srinivas Pandruvada (4):
  cpufreq: intel_pstate: Per CPU P-State limits
  cpufreq: intel_pstate: Reduce impact due to rounding error
  Documentation: intel_pstate: Update per core limits
  Documentation: kernel parameters: per core P-State control

 Documentation/cpu-freq/intel-pstate.txt |  23 ++-
 Documentation/kernel-parameters.txt     |   3 +
 drivers/cpufreq/intel_pstate.c          | 252 ++++++++++++++++++++++----------
 3 files changed, 196 insertions(+), 82 deletions(-)

-- 
2.7.4

