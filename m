From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.10-rc3
Date: Fri, 6 Jan 2017 15:35:39 +0100
Message-ID: <CAJZ5v0gdCVHRv8h8Tqw6cYcNyn-UknqEBi5BQSP7zpPuYda7+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.10-rc3

with top-most commit 7e2b9d85550ee267ec3b5aba6362fdaeb1559f46

 Merge branches 'pm-domains', 'pm-docs' and 'pm-devfreq'

on top of commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88

 Linux 4.10-rc2

to receive power management fixes for v4.10-rc3.

They fix a few issues in the intel_pstate driver, a documetation issue,
a false-positive compiler warning in the generic power domains framework and
two problems in the devfreq subsystem.  They also update the MAINTAINERS
entry for devfreq and add a new "compatible" string to the generic cpufreq-dt
driver.

Specifics:

 - Fix a few intel_pstate driver issues: add missing locking it two places,
   avoid exposing a useless debugfs interface and keep the attribute
   values in sysfs in sync (Rafael Wysocki).

 - Drop confusing kernel-doc references related to power management and
   ACPI from the driver API manual (Rafael Wysocki).

 - Make a false-positive compiler warning in the generic power domains
   framework go away (Augusto Mecking Caringi).

 - Fix two initialization issues in the devfreq subsystem and update
   the MAINTAINERS entry for it (Chanwoo Choi).

 - Add a new "compatible" string for APM X-Gene 2 to the generic DT
   cpufreq driver (Hoan Tran).

Thanks!

---------------

Augusto Mecking Caringi (1):
      PM / domains: Fix 'may be used uninitialized' build warning

Chanwoo Choi (3):
      MAINTAINERS: Add myself as reviewer for DEVFREQ subsystem support
      PM / devfreq: Fix the bug of devfreq_add_device when governor is NULL
      PM / devfreq: exynos-bus: Fix the wrong return value

Hoan Tran (1):
      cpufreq: dt: Add support for APM X-Gene 2

Rafael J. Wysocki (5):
      cpufreq: intel_pstate: Do not expose PID parameters in passive mode
      cpufreq: intel_pstate: Use locking in intel_pstate_resume()
      cpufreq: intel_pstate: Use locking in intel_cpufreq_verify_policy()
      cpufreq: intel_pstate: Always keep all limits settings in sync
      PM / docs: Drop confusing kernel-doc references from infrastructure.rst

---------------

 Documentation/driver-api/infrastructure.rst | 15 --------
 MAINTAINERS                                 |  1 +
 drivers/base/power/domain.c                 |  1 +
 drivers/cpufreq/cpufreq-dt-platdev.c        |  2 ++
 drivers/cpufreq/intel_pstate.c              | 53 +++++++++++++++++------------
 drivers/devfreq/devfreq.c                   | 15 +++++---
 drivers/devfreq/exynos-bus.c                |  2 +-
 7 files changed, 46 insertions(+), 43 deletions(-)
