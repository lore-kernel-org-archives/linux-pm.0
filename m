From: dbasehore@chromium.org
Subject: [PATCH v3 0/5] Add suspend-to-idle validation for Intel SoCs
Date: Wed,  8 Jun 2016 20:08:53 -0700
Message-ID: <1465441738-7972-1-git-send-email-dbasehore@chromium.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34185 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933254AbcFIDJE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jun 2016 23:09:04 -0400
Received: by mail-pf0-f174.google.com with SMTP id 62so8675024pfd.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Jun 2016 20:09:04 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: dbasehore@chromium.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, tglx@linutronix.de, gnomes@lxorguk.ukuu.org.uk, peterz@infradead.org

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
 drivers/cpuidle/cpuidle.c       |  31 ++++++--
 drivers/idle/intel_idle.c       | 161 +++++++++++++++++++++++++++++++++++++---
 include/linux/clockchips.h      |  10 +++
 include/linux/cpuidle.h         |  12 ++-
 include/linux/suspend.h         |  10 +++
 kernel/power/suspend.c          |  11 ++-
 kernel/time/clockevents.c       | 117 +++++++++++++++++++++++++++++
 10 files changed, 363 insertions(+), 30 deletions(-)

-- 
2.8.0.rc3.226.g39d4020

