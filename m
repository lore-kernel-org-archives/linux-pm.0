From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 0/2][Resend] Skylake PSys support
Date: Sun, 20 Mar 2016 16:26:30 -0700
Message-ID: <1458516392-2130-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:12878 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955AbcCTX0Y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 20 Mar 2016 19:26:24 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net
Cc: bp@alien8.de, ak@linux.intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jacob.jun.pan@linux.intel.com, x86@kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Sorry, I had typo in Mingo's email address. So resending.

v3:
As suggested by tglx adding support first in perf-rapl.
Perf RAPL was missing RAPL support for Skylake
Added support including Psys

v2:
Moved PSYS MSR defines to intel_rapl.c as suggested by Boris

Srinivas Pandruvada (2):
  perf/x86/intel/rapl: support Skylake RAPL domains
  powercap: intel_rapl: PSys support

 arch/x86/events/intel/rapl.c     | 50 ++++++++++++++++++++++++++++--
 arch/x86/include/asm/msr-index.h |  2 ++
 drivers/powercap/intel_rapl.c    | 66 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+), 2 deletions(-)

-- 
2.5.0

