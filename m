From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: [PATCH 00/20] Introduce new cpufreq helper macros
Date: Tue, 15 Apr 2014 00:07:32 +0300
Message-ID: <534C4E14.3080509@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Dirk Brandewie <dirk.j.brandewie@intel.com>, Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi all,

This patch set introduces two freq_table helper macros which
can be used for iteration over cpufreq_frequency_table and
makes the necessary changes to cpufreq core and drivers that
use such an iteration procedure.

The motivation was a usage of common procedure to iterate over
cpufreq_frequency_table across all drivers and cpufreq core.

This was tested on a x86_64 platform.
Patches 4-17 compiled successfully but unfortunately I was not
able to compile test patches 18-20.


Stratos Karafotis (20):
  cpufreq: Introduce macros for cpufreq_frequency_table iteration
  cpufreq: acpi-cpufreq: Use cpufreq_for_each_entry macro for iteration
  cpufreq: stats: Use cpufreq_for_each_valid_entry macro for iteration
  cpufreq: arm_big_little: Use cpufreq_for_each_entry macro for
    iteration
  cpufreq: dbx500: Use cpufreq_for_each_entry macro for iteration
  cpufreq: elanfreq: Use cpufreq_for_each_entry macro for iteration
  cpufreq: exynos: Use cpufreq_for_each_entry macro for iteration
  cpufreq: exynos5440: Use cpufreq_for_each_entry macro for iteration
  cpufreq: longhaul: Use cpufreq_for_each_entry macro for iteration
  cpufreq: powernow-k6: Use cpufreq_for_each_entry macro for iteration
  cpufreq: s3c2416: Use cpufreq_for_each_valid_entry macro for iteration
  cpufreq: s3c64xx: Use cpufreq_for_each_valid_entry macro for iteration
  sh: clk: Use cpufreq_for_each_valid_entry macro for iteration
  thermal: cpu_cooling: Use cpufreq_for_each_valid_entry macro for
    iteration
  mfd: db8500-prcmu: Use cpufreq_for_each_entry macro for iteration
  mips: lemote 2f: se cpufreq_for_each_entry macro for iteration
  davinci: da850: Use cpufreq_for_each_entry macro for iteration
  cpufreq: pasemi: Use cpufreq_for_each_entry macro for iteration
  cpufreq: pcc_cbe: Use cpufreq_for_each_entry macro for iteration
  irda: sh_sir: Use cpufreq_for_each_valid_entry macro for iteration

 Documentation/cpu-freq/cpu-drivers.txt | 16 ++++++++++
 arch/arm/mach-davinci/da850.c          |  9 +++---
 arch/mips/loongson/lemote-2f/clock.c   | 15 ++++------
 drivers/cpufreq/acpi-cpufreq.c         | 10 +++----
 drivers/cpufreq/arm_big_little.c       | 18 ++++++-----
 drivers/cpufreq/cpufreq.c              | 11 +++++++
 drivers/cpufreq/cpufreq_stats.c        | 22 +++++---------
 drivers/cpufreq/dbx500-cpufreq.c       |  7 ++---
 drivers/cpufreq/elanfreq.c             |  8 ++---
 drivers/cpufreq/exynos-cpufreq.c       | 14 ++++-----
 drivers/cpufreq/exynos5440-cpufreq.c   | 30 +++++++++----------
 drivers/cpufreq/freq_table.c           | 55 ++++++++++++++++------------------
 drivers/cpufreq/longhaul.c             | 13 ++++----
 drivers/cpufreq/pasemi-cpufreq.c       | 10 +++----
 drivers/cpufreq/powernow-k6.c          | 13 ++++----
 drivers/cpufreq/ppc_cbe_cpufreq.c      |  9 +++---
 drivers/cpufreq/s3c2416-cpufreq.c      | 40 +++++++++++--------------
 drivers/cpufreq/s3c64xx-cpufreq.c      | 15 ++++------
 drivers/mfd/db8500-prcmu.c             | 18 +++++------
 drivers/net/irda/sh_sir.c              | 14 ++++-----
 drivers/sh/clk/core.c                  | 19 ++++--------
 drivers/thermal/cpu_cooling.c          | 33 ++++++++------------
 include/linux/cpufreq.h                | 21 +++++++++++++
 23 files changed, 211 insertions(+), 209 deletions(-)

-- 
1.9.0
