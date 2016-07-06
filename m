From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/3] x86: Remove duplicate turbo ratio MSRs
Date: Wed,  6 Jul 2016 16:07:54 -0700
Message-ID: <1467846477-13659-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

MSR_NHM_TURBO_RATIO_LIMIT and MSR_IVT_TURBO_RATIO_LIMIT are
duplicate MSRs with MSR_TURBO_RATIO_LIMIT and MSR_TURBO_RATIO_LIMIT1
respectively. So remove them by first removing their usage and then
from msr-index.h.

Srinivas Pandruvada (3):
  cpufreq: intel_pstate: Replace MSR_NHM_TURBO_RATIO_LIMIT
  tools/power turbostat: Replace MSR_NHM_TURBO_RATIO_LIMIT
  x86: remove duplicate turbo ratio limit MSRs

 arch/x86/include/asm/msr-index.h      | 2 --
 drivers/cpufreq/intel_pstate.c        | 4 ++--
 tools/power/x86/turbostat/turbostat.8 | 2 +-
 tools/power/x86/turbostat/turbostat.c | 2 +-
 4 files changed, 4 insertions(+), 6 deletions(-)

-- 
2.5.5
