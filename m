From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] ACPI and power management fixes for v3.9-rc5
Date: Thu, 28 Mar 2013 18:12:48 +0100
Message-ID: <2079293.xj33ftEVWq@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the git repository at

  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm+acpi-3.9-rc5

to receive ACPI and power management fixes for v3.9-rc5 with top-most commit
6125c2be96b941a08e05516cfa1125ca53945bb2

  Merge branch 'acpi-fixes' into fixes

on top of commit 8bb9660418e05bb1845ac1a2428444d78e322cc7

  Linux 3.9-rc5

Included are:

- Fix for a recent cpufreq regression related to acpi-cpufreq and
  suspend/resume from Viresh Kumar.

- cpufreq stats reference counting fix from Viresh Kumar.

- intel_pstate driver fixes from Dirk Brandewie and
  Konrad Rzeszutek Wilk.

- New ACPI suspend blacklist entry for Sony Vaio VGN-FW21M from
  Fabio Valentini.

- ACPI Platform Error Interface (APEI) fix from Chen Gong.

- Fix for the new PCI root bridge hotplug code to make it use
  acpi_scan_lock in analogy with the rest of the ACPI subsystem.
  From Yinghai Lu.

Thanks!


---------------

Chen Gong (1):
      ACPI / APEI: fix error status check condition for CPER

Dirk Brandewie (2):
      cpufreq / intel_pstate: Add function to check that all MSRs are valid
      cpufreq / intel_pstate: Fix calculation of current frequency

Fabio Valentini (1):
      ACPI / PM: fix suspend and resume on Sony Vaio VGN-FW21M

Konrad Rzeszutek Wilk (1):
      intel-pstate: Use #defines instead of hard-coded values.

Viresh Kumar (2):
      cpufreq: acpi-cpufreq: Don't set policy->related_cpus from .init()
      cpufreq: stats: do cpufreq_cpu_put() corresponding to cpufreq_cpu_get()

Yinghai Lu (1):
      PCI / ACPI: hold acpi_scan_lock during root bus hotplug

---------------

 arch/x86/include/uapi/asm/msr-index.h |    1 +
 drivers/acpi/apei/cper.c              |    2 +-
 drivers/acpi/pci_root.c               |    9 +++++++--
 drivers/acpi/sleep.c                  |    8 ++++++++
 drivers/cpufreq/acpi-cpufreq.c        |    2 --
 drivers/cpufreq/cpufreq_stats.c       |   12 ++++++++----
 drivers/cpufreq/intel_pstate.c        |   34 ++++++++++++++++++++++++++++++----
 7 files changed, 55 insertions(+), 13 deletions(-)

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
