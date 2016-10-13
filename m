From: Piotr Luc <piotr.luc@intel.com>
Subject: [RESEND PATCH 00/11] Add Knights Mill CPU ID
Date: Thu, 13 Oct 2016 17:30:54 +0200
Message-ID: <20161013153105.2517-1-piotr.luc@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Doug Thompson <dougthompson@xmission.com>, Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Resending patches related to KNM CPU ID in one patchset for
more convenient pick up.

This series of patches enables support for Knights Mill (KNM).

First two patches improve code style by replacing raw numbers
of CPUID with descriptive macros of processor names.

The third one introduces KNM CPU ID to Intel family.

The other patches add KNM CPU ID to several modules and depend on
the third one. Because KNM is closely related to Knights Landing (KNL)
it reuses KNL code.
The turbostat patch (tools/power turbostat: Use Intel family processor
macros) comes in v2 with fixed compilation (missed including of
intel-family.h).

Regards,
Piotr

Piotr Luc (11):
  EDAC, sb_edac: Use Intel family processor macros
  tools/power turbostat: Use Intel family processor macros
  x86/cpu/intel: Add Knights Mill to Intel family
  x86/intel_idle: Add Knights Mill CPUID
  EDAC, sb_edac: Add Knights Mill CPUID
  cpufreq: intel_pstate: Add Knights Mill CPUID
  perf/x86/intel: Add Knights Mill CPUID
  perf/x86/intel/rapl: Add Knights Mill CPUID
  perf/x86/intel/uncore: Add Knights Mill CPUID
  powercap / RAPL: Add Knights Mill CPUID
  tools/power turbostat: enable turbostat to support Knights Mill (KNM)

 arch/x86/events/intel/core.c          |   3 +-
 arch/x86/events/intel/rapl.c          |   1 +
 arch/x86/events/intel/uncore.c        |   1 +
 arch/x86/include/asm/intel-family.h   |   1 +
 drivers/cpufreq/intel_pstate.c        |   1 +
 drivers/edac/sb_edac.c                |  14 +-
 drivers/idle/intel_idle.c             |   1 +
 drivers/powercap/intel_rapl.c         |   1 +
 tools/power/x86/turbostat/Makefile    |   3 +-
 tools/power/x86/turbostat/turbostat.c | 250 ++++++++++++++++++----------------
 10 files changed, 147 insertions(+), 129 deletions(-)

--
2.10.1
