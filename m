From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management turbostat utility updates for v4.11-rc1
Date: Fri, 3 Mar 2017 02:03:44 +0100
Message-ID: <CAJZ5v0hC0C6VLm4_FhHiZ8OFp-03Bb-EgibvaxmucYCLa=X-1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:33804 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbdCCBcr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Mar 2017 20:32:47 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-turbostat-4.11-rc1

with top-most commit 6bff9c609f3df4e325da08783f691cab9316d643

 Merge branch 'turbostat' of
git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux

on top of commit 02c3de1105228e367320e7fdeffbf511904f398c

 Merge tag 'pm-4.11-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive updates related to the turbostat utility for v4.11-rc1.

These update turbostat significantly and in particular:

 - Default output is now verbose, --debug is no longer required to
   get all counters.  As a result, some options have been added to
   specify exactly what output is wanted.
 - Added --quiet to skip system configuration output
 - Added --list, --show and --hide parameters
 - Added --cpu parameter
 - Enhanced Baytrail SoC support
 - Added Gemini Lake SoC support
 - Added sysfs C-state columns

Also the symbol definitions in arch/x86/include/asm/intel-family.h
and arch/x86/include/asm/msr-index.h are updated and the intel_idle
and intel_pstate drivers are modified to use the updated symbols.

Credits to Len Brown for all of these changes.

Thanks!

---------------

Len Brown (44):
      tools/power turbostat: fix bugs in --add option
      tools/power turbostat: Add --show and --hide parameters
      tools/power turbostat: BYT does not have MSR_MISC_PWR_MGMT
      tools/power turbostat: decode Baytrail CC6 and MC6 demotion configuration
      tools/power turbostat: Baytrail: remove debug line in quiet mode
      tools/power turbostat: update MSR_PKG_CST_CONFIG_CONTROL decoding
      x86: msr-index.h: Define MSR_PKG_CST_CONFIG_CONTROL
      intel_idle: use new name for MSR_PKG_CST_CONFIG_CONTROL
      tools/power turbostat: use new name for MSR_PKG_CST_CONFIG_CONTROL
      x86: msr-index.h: Remove unused MSR_NHM_SNB_PKG_CST_CFG_CTL
      tools/power turbostat: Baytrail c-state support
      tools/power turbostat: add precision to --debug frequency output
      tools/power turbostat: further decode MSR_IA32_MISC_ENABLE
      x86 msr-index.h: Define Atom specific core ratio MSR locations
      intel_pstate: use MSR_ATOM_RATIOS definitions from msr-index.h
      tools/power turbostat: dump Atom P-states correctly
      tools/power turbostat: decode CPUID(6).TURBO
      x86 msr_index.h: Define MSR_MISC_FEATURE_CONTROL
      tools/power turbostat: decode MSR_MISC_FEATURE_CONTROL
      tools/power turbostat: show all columns, independent of --debug
      tools/power turbostat: print system config, unless --quiet
      tools/power turbostat: use tsc_tweak everwhere it is needed
      tools/power turbostat: bug fixes to --add, --show/--hide features
      x86: intel-family.h: Add GEMINI_LAKE SOC
      tools/power turbostat: initial Gemini Lake SOC support
      tools/power turbostat: Denverton: use HW CC1 counter, skip C3, C7
      tools/power turbostat: skip unused counters on SKX
      tools/power turbostat: fix decoding for GLM, DNV, SKX turbo-ratio limits
      tools/power turbostat: skip unused counters on BDX
      tools/power turbostat: extend --add option to accept /sys path
      tools/power turbostat: print sysfs C-state stats
      tools/power turbostat: add --cpu parameter
      tools/power turbostat: fix zero IRQ count shown in one-shot command mode
      tools/power turbostat: Add --list option to show available header names
      tools/power turbostat: use wide columns to display large numbers
      tools/power turbostat: update --list feature
      tools/power turbostat: turbostat.8 update
      tools/power turbostat: move --Package and --processor into the
--cpu option
      tools/power turbostat: support "--hide C1" etc.
      tools/power turbostat: show package number, even without --debug
      tools/power turbostat: dump p-state software config
      tools/power turbostat: show error on exec
      tools/power turbostat: bugfix: --add u32 was printed as u64
      tools/power turbostat: version 17.02.24

---------------

 arch/x86/include/asm/intel-family.h   |    1 +
 arch/x86/include/asm/msr-index.h      |   11 +-
 drivers/cpufreq/intel_pstate.c        |   15 +-
 drivers/idle/intel_idle.c             |    6 +-
 tools/power/x86/turbostat/turbostat.8 |  253 +++--
 tools/power/x86/turbostat/turbostat.c | 1880 ++++++++++++++++++++++++---------
 6 files changed, 1570 insertions(+), 596 deletions(-)
