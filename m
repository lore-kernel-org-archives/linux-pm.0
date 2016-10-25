From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 0/4] cpufreq: intel_pstate: Per CPU performance control
Date: Tue, 25 Oct 2016 13:20:39 -0700
Message-ID: <1477426843-63821-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2438 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932301AbcJYUUz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Oct 2016 16:20:55 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

v3
Code and documentation based on comments from Rafael on v2 version

v2
kernel command line to enable the feature
Global and per-cpu control are not available simultaneously
Global limits will be disabled when per cpu controls are selected


Srinivas Pandruvada (4):
  cpufreq: intel_pstate: Per CPU P-State limits
  cpufreq: intel_pstate: Reduce impact due to rounding error
  Documentation: intel_pstate: Update per core limits
  Documentation: kernel parameters: per core P-State control

 Documentation/cpu-freq/intel-pstate.txt |  21 ++-
 Documentation/kernel-parameters.txt     |   3 +
 drivers/cpufreq/intel_pstate.c          | 242 +++++++++++++++++++++-----------
 3 files changed, 185 insertions(+), 81 deletions(-)

-- 
2.7.4

