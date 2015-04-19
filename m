From: Len Brown <lenb@kernel.org>
Subject: [GIT PULL] turbostat update for Linux-4.1
Date: Sat, 18 Apr 2015 22:24:58 -0400
Message-ID: <CAJvTdKk4iuoW1sw_zQYAaJ+ETy5RWkKcB4FLUyQ+eu3bkoOMOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull these updates to the turbostat utility.
Just one kernel dependency in this batch -- added a #define to msr-index.h

thanks!
Len Brown, Intel Open Source Technology Center


The following changes since commit 39a8804455fb23f09157341d3ba7db6d7ae6ee76:

  Linux 4.0 (2015-04-12 15:12:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

for you to fetch changes up to e9257f5fa48cc296d7eed35acf9f2ad195184122:

  tools/power turbostat: correct dumped pkg-cstate-limit value
(2015-04-18 14:20:52 -0400)

----------------------------------------------------------------
Andrey Semin (1):
      tools/power turbostat: correct DRAM RAPL units on recent Xeon processors

Len Brown (10):
      tools/power turbostat: simplify default output
      tools/power turbostat: update PERF_LIMIT_REASONS decoding
      tools/power turbostat: label base frequency
      x86 msr-index: define MSR_TURBO_RATIO_LIMIT,1,2
      tools/power turbostat: use new MSR_TURBO_RATIO_LIMIT names
      tools/power turbostat: dump MSR_TURBO_RATIO_LIMIT2
      tools/power turbostat: modprobe msr, if needed
      tools/power turbostat: Initial Skylake support
      tools/power turbostat: calculate TSC frequency from CPUID(0x15) on SKL
      tools/power turbostat: correct dumped pkg-cstate-limit value

Thomas D (1):
      tools/power turbostat: Use $(CURDIR) instead of $(PWD) and add
support for O= option in Makefile

 arch/x86/include/uapi/asm/msr-index.h |   8 +
 tools/power/x86/turbostat/Makefile    |   6 +-
 tools/power/x86/turbostat/turbostat.8 | 138 ++++++-----
 tools/power/x86/turbostat/turbostat.c | 436 ++++++++++++++++++++++++++--------
 4 files changed, 427 insertions(+), 161 deletions(-)
