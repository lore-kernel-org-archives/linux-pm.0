From: dbasehore@chromium.org
Subject: [PATCH 0/5] Add suspend-to-idle validation for Intel SoCs
Date: Wed,  1 Jun 2016 21:33:24 -0700
Message-ID: <1464842009-21789-1-git-send-email-dbasehore@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: dbasehore@chromium.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, tglx@linutronix.de
List-Id: linux-pm@vger.kernel.org

From: Derek Basehore <dbasehore@chromium.org>

This patch set adds support for catching errors when entering freeze
on Intel Skylake SoCs. Support for this can be added to newer SoCs in
later patches.

Verification is done by waking up the CPU once every X (default 10)
seconds to check the residency of S0ix. This can't be verified before
attempting to enter S0ix through mwait, so we have to repeatedly
verify entry into that state. Successfully entering S0ix is no
guarantee that it will be entered on the next attempt, so we have to
schedule another check. This has a minimal power impact of <1% of the
total system power on our systems.

This relies on the recently added patch "platform/x86: Add PMC Driver
for Intel Core SoC"

Derek Basehore (5):
  x86: stub out pmc function
  clockevents: Add timed freeze
  x86, apic: Add timed freeze support
  freeze: Add error reporting
  intel_idle: Add S0ix validation

 arch/x86/include/asm/pmc_core.h |   6 +-
 arch/x86/kernel/apic/apic.c     |  25 +++++-
 drivers/acpi/processor_idle.c   |  10 ++-
 drivers/cpuidle/cpuidle.c       |  31 +++++--
 drivers/idle/intel_idle.c       | 185 +++++++++++++++++++++++++++++++++++++---
 include/linux/clockchips.h      |  10 +++
 include/linux/cpuidle.h         |  10 ++-
 include/linux/suspend.h         |  10 +++
 kernel/power/suspend.c          |  11 ++-
 kernel/time/clockevents.c       | 117 +++++++++++++++++++++++++
 10 files changed, 385 insertions(+), 30 deletions(-)

-- 
2.8.0.rc3.226.g39d4020
