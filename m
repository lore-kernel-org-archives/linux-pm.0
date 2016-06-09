From: dbasehore@chromium.org
Subject: [PATCH v4 0/5] Add suspend-to-idle validation for Intel SoCs
Date: Thu,  9 Jun 2016 14:02:14 -0700
Message-ID: <1465506139-25981-1-git-send-email-dbasehore@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: dbasehore@chromium.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, tglx@linutronix.de, gnomes@lxorguk.ukuu.org.uk, peterz@infradead.org
List-Id: linux-pm@vger.kernel.org

From: Derek Basehore <dbasehore@chromium.org>

This patch set adds support for catching errors when entering freeze
on Intel Skylake SoCs. Support for this can be added to newer SoCs in
later patches.

Verification is done by waking up the CPU up to 1000 seconds later
based on base 10 exponential backoff from 1 second to check the
residency of S0ix. This can't be verified before attempting to enter
S0ix through mwait, so we have to repeatedly verify entry into that
state. Successfully entering S0ix is no guarantee that it will be
entered on the next attempt, so we have to schedule another check.
This has a minimal average power impact of ~3uW on Skylake systems.
This leaves plenty of room for additional overhead based on changes
to the system.

This relies on the recently added patch "platform/x86: Add PMC Driver
for Intel Core SoC"

Changes for v4:
- Fixed compilation warning for !CONFIG_SUSPEND

Changes for v3:
- Fixed compilation error for "freeze: Add error reporting"

Changes for v2:
- Moved to exponential backoff for the freeze duration with a max of
  1000 seconds
- Changed to make the feature default off
- Add module parameter for enabling/disabling the feature instead of
  a debugfs entry

Derek Basehore (5):
  x86: stub out pmc function
  clockevents: Add timed freeze
  x86, apic: Add timed freeze support
  freeze: Add error reporting
  intel_idle: Add S0ix validation

 arch/x86/include/asm/pmc_core.h |   6 +-
 arch/x86/kernel/apic/apic.c     |  25 ++++++-
 drivers/acpi/processor_idle.c   |  10 ++-
 drivers/cpuidle/cpuidle.c       |  32 ++++++--
 drivers/idle/intel_idle.c       | 161 +++++++++++++++++++++++++++++++++++++---
 include/linux/clockchips.h      |  10 +++
 include/linux/cpuidle.h         |  12 ++-
 include/linux/suspend.h         |  10 +++
 kernel/power/suspend.c          |  11 ++-
 kernel/time/clockevents.c       | 117 +++++++++++++++++++++++++++++
 10 files changed, 364 insertions(+), 30 deletions(-)

-- 
2.8.0.rc3.226.g39d4020
