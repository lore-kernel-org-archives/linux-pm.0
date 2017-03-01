From: Len Brown <lenb@kernel.org>
Subject: [GIT PULL] turbostat 17.02.24
Date: Wed,  1 Mar 2017 00:27:04 -0500
Message-ID: <20170301052748.27810-1-lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36173 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbdCAFjc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2017 00:39:32 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Hi Rafael,
Please pull these turbostat-related patches.

This patch series updates turbostat in the Linux kernel tree to
to the latest out-of-tree version -- 17.02.24.

There are several significant changes since the version that
shipped in the Linux-4.10 tree.

Default output is now verbose, --debug is no longer required
	to get all counters.  As a result, some options have
	been added to specify exactly what output is wanted.
Added --quiet to skip system configuration output
Added --list, --show and --hide parameters
Added --cpu parameter
Enhanced Baytrail SOC support
Added Gemini Lake SOC support
Added sysfs C-state columns

These changes are detailed on the updated turbostat.8 man page.

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit c470abd4fde40ea6a0846a2beab642a578c0b8cd:

  Linux 4.10 (2017-02-19 14:34:00 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

for you to fetch changes up to e3942ed8c66bcff496abee5182422cd542962d9e:

  tools/power turbostat: version 17.02.24 (2017-03-01 00:14:26 -0500)

----------------------------------------------------------------
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
      tools/power turbostat: move --Package and --processor into the --cpu option
      tools/power turbostat: support "--hide C1" etc.
      tools/power turbostat: show package number, even without --debug
      tools/power turbostat: dump p-state software config
      tools/power turbostat: show error on exec
      tools/power turbostat: bugfix: --add u32 was printed as u64
      tools/power turbostat: version 17.02.24

 arch/x86/include/asm/intel-family.h   |    1 +
 arch/x86/include/asm/msr-index.h      |   11 +-
 drivers/cpufreq/intel_pstate.c        |   15 +-
 drivers/idle/intel_idle.c             |    6 +-
 tools/power/x86/turbostat/turbostat.8 |  253 +++--
 tools/power/x86/turbostat/turbostat.c | 1880 ++++++++++++++++++++++++---------
 6 files changed, 1570 insertions(+), 596 deletions(-)
