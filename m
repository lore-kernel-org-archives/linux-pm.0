From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.11-rc3
Date: Sat, 18 Mar 2017 01:21:28 +0100
Message-ID: <CAJZ5v0iFOzdZFqC9nVd0KhWcfzKRjvqh+3dtOJxNHMA9DGSqtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.11-rc3

with top-most commit 8b766e05d8ec80b6b1daa2675509adcab6519038

 Merge branch 'pm-cpufreq-fixes' and 'intel_pstate-fixes'

on top of commit 4495c08e84729385774601b5146d51d9e5849f81

 Linux 4.11-rc2

to receive power management fixes for v4.11-rc3.

These fix a few more intel_pstate issues and one small issue in the
cpufreq core.

Specifics:

 - Fix breakage in the intel_pstate's debugfs interface for PID
   controller tuning (Rafael Wysocki).

 - Fix computations related to P-state limits in intel_pstate to
   avoid excessive rounding errors leading to visible inaccuracies
   (Srinivas Pandruvada, Rafael Wysocki).

 - Add a missing newline to a message printed by one function in
   the cpufreq core and clean up that function (Rafael Wysocki).

Thanks!

---------------

Rafael J. Wysocki (3):
      cpufreq: intel_pstate: Update pid_params.sample_rate_ns in pid_param_set()
      cpufreq: intel_pstate: Avoid percentages in limits-related computations
      cpufreq: Fix and clean up show_cpuinfo_cur_freq()

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Correct frequency setting in the HWP mode

---------------

 drivers/cpufreq/cpufreq.c      |  8 ++++--
 drivers/cpufreq/intel_pstate.c | 64 ++++++++++++++++++++----------------------
 2 files changed, 36 insertions(+), 36 deletions(-)
