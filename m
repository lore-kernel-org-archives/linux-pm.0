From: Len Brown <lenb@kernel.org>
Subject: [GIT PULL] power utilities update
Date: Thu, 11 May 2017 22:00:18 -0400
Message-ID: <20170512020023.23204-1-lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

Please pull these power utilities patches.

The x86_energy_perf_policy(8) utility grows the ability
to manage HWP.EPP (and Hardware P-states, in-general),
on top of its previous ability to manage EPB.

Linux-4.11 grew the ability to disable the cpufreq sub-system entirely
with "cpufreq.off=1". On such a system, this utility
is a convenient way to enable HWP with no kernel cpufreq overhead:

sudo x86_energy_perf_policy --cpu all normal

During this effort, we noticed the EPP defaults hard-coded
into the intel_state driver were not optimal, so those are updated too.

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit c470abd4fde40ea6a0846a2beab642a578c0b8cd:

  Linux 4.10 (2017-02-19 14:34:00 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git utilities

for you to fetch changes up to 3cedbc5a6d7f7c5539e139f89ec9f6e1ed668418:

  intel_pstate: use updated msr-index.h HWP.EPP values (2017-05-11 21:27:53 -0400)

----------------------------------------------------------------
Len Brown (5):
      x86: msr-index.h: define EPB mid-points
      x86: msr-index.h: define HWP.EPP values
      x86: msr-index.h: fix shifts to ULL results in HWP macros.
      tools/power x86_energy_perf_policy: support HWP.EPP
      intel_pstate: use updated msr-index.h HWP.EPP values

 arch/x86/include/asm/msr-index.h                   |   18 +-
 drivers/cpufreq/intel_pstate.c                     |   34 +-
 tools/power/x86/x86_energy_perf_policy/Makefile    |   27 +-
 .../x86_energy_perf_policy.8                       |  241 +++-
 .../x86_energy_perf_policy.c                       | 1504 +++++++++++++++++---
 5 files changed, 1527 insertions(+), 297 deletions(-)
