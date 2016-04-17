From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 0/2] Skylake PSys support
Date: Sun, 17 Apr 2016 15:02:59 -0700
Message-ID: <1460930581-29748-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net
Cc: x86@kernel.org, peterz@infradead.org, bp@alien8.de, linux-kernel@vger.kernel.org, jacob.jun.pan@linux.intel.com, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Skylake processor supports a new set of RAPL registers for controlling
entire SoC instead of just CPU package called PSys. This change adds
support in two sub systems:

x86/perf: Adds basic support for Skylake RAPL and PSys support

powercap/rapl: A new platform domain to the current power capping Intel
RAPL driver.

v4
Perf:
- Rebased the patch as msr-index file changed.
- Added a new Skylake H/L model
- Changed RAPL_IDX_SKL to RAPL_IDX_SKL_CLN to avoid clash
with SKL server domain once we add SKL server support

Powercap/rapl:
- Fix kbuild test robot compliant about invalid domain error in dmesg

v3:
As suggested by tglx adding support first in perf-rapl.
Perf RAPL was missing RAPL support for Skylake
Added support including Psys

v2:
Moved PSYS MSR defines to intel_rapl.c as suggested by Boris

Srinivas Pandruvada (2):
  perf/x86/intel/rapl: support Skylake RAPL domains
  powercap: intel_rapl: PSys support

 arch/x86/events/intel/rapl.c     | 51 +++++++++++++++++++++++++++--
 arch/x86/include/asm/msr-index.h |  2 ++
 drivers/powercap/intel_rapl.c    | 69 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+), 2 deletions(-)

-- 
1.9.1
