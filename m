From: Len Brown <lenb@kernel.org>
Subject: [GIT PULL] x86,cpufreq: unify APERF/MPERF computation
Date: Fri, 16 Jun 2017 20:03:10 -0700
Message-ID: <1497668594-9266-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33434 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbdFQDDX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jun 2017 23:03:23 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael@kernel.org
Cc: x86@kernel.org, srinivas.pandruvada@linux.intel.com, peterz@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


In-Reply-To: 

Hi Rafael,

This patch series has 3 goals:

1. Make "cpu MHz" in /proc/cpuinfo supportable.

2. Make /sys/.../cpufreq/scaling_cur_freq meaningful
   and consistent on modern x86 systems.

3. Use 1. and 2. to remove scheduler and cpufreq overhead

There are 3 main changes since this series was proposed
about a year ago:

This update responds to distro feedback to make /proc/cpuinfo
"cpu MHz" constant.  Originally, we had proposed making it return
the same dynamic value as cpufreq sysfs.

Some community members suggested that sysfs MHz values should
be meaninful, even down to 10ms intervals.  So this has been
changed, versus the original proposal to not re-compute
at intervals shorter than 100ms.

(For those who really care about observing frequency, the
 recommendation remains to use turbostat(8) or equivalent utility,
 which can reliably measure concurrent intervals of arbitrary length)

The intel_pstate sampling mechanism has changed.
Originally this series removed an intel_pstate timer in HWP mode.
Now it removes the analogous scheduler call-back.

Most recently, in response to posting this patch on the list
about 10-days ago, the patch to remove frequency calculation
from inside intel_pstate was dropped, in order to maintain compatibility
with tracing scripts.  Also, the order of the last two patches
has been exchanged.

Please let me know if you see any issues with this series.

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit 3c2993b8c6143d8a5793746a54eba8f86f95240f:

  Linux 4.12-rc4 (2017-06-04 16:47:43 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git x86

for you to fetch changes up to d020eed98440faa4a529c621f881aa9fda296956:

  intel_pstate: skip scheduler hook when in "performance" mode. (2017-06-16 19:11:13 -0700)

----------------------------------------------------------------
Len Brown (4):
      x86: do not use cpufreq_quick_get() for /proc/cpuinfo "cpu MHz"
      x86: use common aperfmperf_khz_on_cpu() to calculate KHz using APERF/MPERF
      intel_pstate: delete scheduler hook in HWP mode
      intel_pstate: skip scheduler hook when in "performance" mode.

 arch/x86/kernel/cpu/Makefile     |  1 +
 arch/x86/kernel/cpu/aperfmperf.c | 82 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/proc.c       | 10 +----
 drivers/cpufreq/cpufreq.c        |  7 +++-
 drivers/cpufreq/intel_pstate.c   | 18 +++------
 include/linux/cpufreq.h          | 13 +++++++
 6 files changed, 109 insertions(+), 22 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/aperfmperf.c
