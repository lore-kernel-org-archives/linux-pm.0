From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] Power management and ACPI fixes for 3.7-rc3
Date: Fri, 26 Oct 2012 23:20:24 +0200
Message-ID: <20490446.pylUFvD5EM@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the git repository at

  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm+acpi-for-3.7-rc3

to receive power management and ACPI fixes for v3.7-rc3 with top-most commit
879dca019dc43a1622edca3e7dde644b14b5acc5

  ACPI: missing break

on top of commit 6f0c0580b70c89094b3422ba81118c7b959c7556

  Linux 3.7-rc2

Included are:

* Fix for a recently introduced memory leak in acpi_bind_one() from Jesper Juhl.

* PM domains fix for an error code path memory leak in pm_genpd_attach_cpuidle()
  from Jonghwan Choi.

* Fix for smp_processor_id() usage in preemptible code in powernow-k8 from
  Andreas Herrmann (stable material).

* Fix for a suspend-related memory leak in cpufreq stats from Xiaobing Tu.

* Freezer fix for failure to clear PF_NOFREEZE along with PF_KTHREAD
  in flush_old_exec() from Oleg Nesterov.

* One-liner acpi_processor_notify() fix from Alan Cox.

Thanks!


 drivers/acpi/glue.c             | 1 +
 drivers/acpi/processor_driver.c | 1 +
 drivers/base/power/domain.c     | 5 ++++-
 drivers/cpufreq/cpufreq_stats.c | 1 +
 drivers/cpufreq/powernow-k8.c   | 9 +--------
 fs/exec.c                       | 3 ++-
 6 files changed, 10 insertions(+), 10 deletions(-)

---------------

Alan Cox (1):
      ACPI: missing break

Andreas Herrmann (1):
      cpufreq / powernow-k8: Remove usage of smp_processor_id() in preemptible code

Jesper Juhl (1):
      ACPI: Fix memory leak in acpi_bind_one()

Oleg Nesterov (1):
      freezer: exec should clear PF_NOFREEZE along with PF_KTHREAD

Tu, Xiaobing (1):
      Fix memory leak in cpufreq stats.

jhbird.choi@samsung.com (1):
      PM / Domains: Fix memory leak on error path in pm_genpd_attach_cpuidle


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
