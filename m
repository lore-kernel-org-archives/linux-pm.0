From: Len Brown <lenb@kernel.org>
Subject: [PATCH 0/5] x86, cpufreq: consolidate APERF/MPERF calculation
Date: Wed,  7 Jun 2017 19:39:11 -0700
Message-ID: <1496889556-17923-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35798 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751203AbdFHCjY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2017 22:39:24 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: x86@kernel.org, srinivas.pandruvada@linux.intel.com, hpa@linux.intel.com, peterz@infradead.org, rafael@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

This patch series has 3 goals:

1. Make "cpu MHz" in /proc/cpufino supportable.

2. Make /sys/.../cpufreq/scaling_cur_freq meaningful
   and consistent on modern x86 systems.

3. Use 1. and 2. to remove scheduler and cpufreq overhead

There are 3 main changes since this series was proposed
about a year ago:

This update responds to distro feedback to make /proc/cpuinfo
"cpu MHz" constant.  Originally, we had proposed making it return
the exact same value as cpufreq sysfs.

Some community members suggested that sysfs MHz values should
be meaninful, even down to 10ms intervals.  So this has been
changed, versus the original proposal to not re-compute
at intervals shorter than 100ms.

(The recommendation remains to use turbostat(8) or other utility
to reliably measure concurrent intervals of arbitrary length)

The intel_pstate sampling mechanism has changed.
Originally this series removed an intel_pstate timer in HWP mode.
Now it removes the analogous scheduler call-back.

Please let me know if you see any issues with this series.

thanks!


[PATCH 1/5] x86: do not use cpufreq_quick_get() for /proc/cpuinfo "cpu MHz"
[PATCH 2/5] x86: use common aperfmperf_khz_on_cpu() to calculate KHz using APERF/MPERF
[PATCH 3/5] intel_pstate: remove intel_pstate.get()
[PATCH 4/5] intel_pstate: skip scheduler hook when in "performance" mode.
[PATCH 5/5] intel_pstate: delete scheduler hook in HWP mode

The following changes since commit 3c2993b8c6143d8a5793746a54eba8f86f95240f:

  Linux 4.12-rc4 (2017-06-04 16:47:43 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git x86

for you to fetch changes up to 8554c677900ad6bcb308f4afe1099aead3cfebd3:

  intel_pstate: delete scheduler hook in HWP mode (2017-06-07 19:20:45 -0700)

----------------------------------------------------------------
Len Brown (5):
      x86: do not use cpufreq_quick_get() for /proc/cpuinfo "cpu MHz"
      x86: use common aperfmperf_khz_on_cpu() to calculate KHz using APERF/MPERF
      intel_pstate: remove intel_pstate.get()
      intel_pstate: skip scheduler hook when in "performance" mode.
      intel_pstate: delete scheduler hook in HWP mode

 arch/x86/kernel/cpu/Makefile     |  1 +
 arch/x86/kernel/cpu/aperfmperf.c | 82 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/proc.c       | 10 +----
 drivers/cpufreq/cpufreq.c        |  7 +++-
 drivers/cpufreq/intel_pstate.c   | 34 +++--------------
 include/linux/cpufreq.h          | 13 +++++++
 6 files changed, 110 insertions(+), 37 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/aperfmperf.c
