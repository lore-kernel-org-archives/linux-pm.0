From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v5.1-rc3
Date: Sat, 30 Mar 2019 01:37:43 +0100
Message-ID: <CAJZ5v0jUqQz3hY6JONcWfuLG8Bnn9vtZQcWWPnyE=PYOpVXRJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.1-rc3

with top-most commit 31d4c528cea4023cf36f6148c03bb960cedefeef

 cpufreq: scpi: Fix use after free

on top of commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00

 Linux 5.1-rc2

to receive power management fixes for 5.1-rc3.

These fix CPU base frequency reporting in the intel_pstate
driver and a use-after-free in the scpi-cpufreq driver.

Specifics:

 - Fix the ACPI CPPC library to actually follow the specification
   when decoding the guaranteed performance register information and
   make the intel_pstate driver fall back to the nominal frequency
   when reporting the base frequency if the guaranteed performance
   register information is not there (Srinivas Pandruvada).

 - Fix use-after-free in the exit callback of scpi-cpufreq left after
   an update during the 5.0 development cycle (Vincent Stehlé).

Thanks!


---------------

Srinivas Pandruvada (2):
      ACPI / CPPC: Fix guaranteed performance handling
      cpufreq: intel_pstate: Also use CPPC nominal_perf for base_frequency

Vincent Stehlé (1):
      cpufreq: scpi: Fix use after free

---------------

 drivers/acpi/cppc_acpi.c       | 9 +++++++--
 drivers/cpufreq/intel_pstate.c | 5 ++++-
 drivers/cpufreq/scpi-cpufreq.c | 2 +-
 3 files changed, 12 insertions(+), 4 deletions(-)
