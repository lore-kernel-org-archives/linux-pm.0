From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/3] Support of Energy Performance hints
Date: Tue,  6 Dec 2016 13:32:14 -0800
Message-ID: <1481059937-193048-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:30593 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751471AbcLFVco (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Dec 2016 16:32:44 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

v2:
- Order of patch 0001 and 0002 is changed.
"cpufreq: intel_pstate: Lock HWP requests" is the patch 0001 now.
- In the Documentation added comment to explain that threads can
migrate to different CPUs, so may not be executing with the same
preference on the new CPU.

Srinivas Pandruvada (3):
  cpufreq: intel_pstate: Lock HWP requests
  cpufreq: intel_pstate: Support of energy performance hint using HWP
  Documentation: intel_pstate: Add energy performance hint

 Documentation/cpu-freq/intel-pstate.txt |  24 +++
 drivers/cpufreq/intel_pstate.c          | 266 ++++++++++++++++++++++++++++----
 2 files changed, 260 insertions(+), 30 deletions(-)

-- 
2.7.4

