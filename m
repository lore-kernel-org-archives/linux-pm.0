From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 00/11] cpufreq: Keep policy->freq_table sorted
Date: Thu,  2 Jun 2016 19:49:00 +0530
Message-ID: <cover.1464876460.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Shawn Guo <shawn.guo@freescale.com>, Steven Miao <realmz6@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

This series fixes all cpufreq drivers that provide a 'target_index'
callback or in other words, which provide a freq-table to cpufreq core,
to make sure they *only* use the 'index' argument to ->target_index()
with the policy->freq_table.

This change allows us to remove the (duplicate) sorted-freq-table, which
was added by following series:

[PATCH V2 0/2] cpufreq: Use sorted frequency tables

The final code looks like this:
- drivers provide a freq table to the cpufreq core
- core makes a copy of that and sort that in ascending order of
  frequencies. This is what we get from policy->freq_table.
- drivers can now free the freq-table they provided earlier.
- ->target_index() contains the 'index' to this sorted
  policy->freq_table.

This is based of the two series I have posted until now:

[PATCH V2 0/6] cpufreq: cleanups and reorganization
[PATCH V2 0/2] cpufreq: Use sorted frequency tables

All the patches are pushed here for testing in case anyone wants to try:

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/sorted-freq-table

The 3 series combined makes freq-table traversing to find a match really
fast and efficient. Which will also allow us to use it for new governors
like schedutil.

--
viresh

Viresh Kumar (11):
  ARM: davinci: Sort frequency table
  cpufreq: davinci: Reuse cpufreq_generic_frequency_table_verify()
  cpufreq: Use policy->freq_table in ->target_index()
  cpufreq: blackfin: Use 'index' only to index into policy->freq_table
  cpufreq: elanfreq: Use 'index' only to index into policy->freq_table
  cpufreq: exynos: Use 'index' only to index into policy->freq_table
  cpufreq: ia64: Use 'index' only to index into policy->freq_table
  cpufreq: imx: Use 'index' only to index into policy->freq_table
  cpufreq: maple: Use 'index' only to index into policy->freq_table
  cpufreq: Keep a single (sorted) freq_table
  cpufreq: drivers: Free frequency tables after being used

 arch/arm/mach-davinci/da850.c          | 16 ++++++++-------
 drivers/cpufreq/acpi-cpufreq.c         |  7 +++----
 drivers/cpufreq/arm_big_little.c       |  2 +-
 drivers/cpufreq/at32ap-cpufreq.c       |  8 ++++----
 drivers/cpufreq/blackfin-cpufreq.c     | 17 +++++++++++-----
 drivers/cpufreq/cpufreq-dt.c           |  9 ++++-----
 drivers/cpufreq/cpufreq.c              |  6 +-----
 drivers/cpufreq/cris-artpec3-cpufreq.c |  2 +-
 drivers/cpufreq/cris-etraxfs-cpufreq.c |  2 +-
 drivers/cpufreq/davinci-cpufreq.c      | 22 +--------------------
 drivers/cpufreq/dbx500-cpufreq.c       |  3 ++-
 drivers/cpufreq/e_powersaver.c         | 26 +++++++++++++-----------
 drivers/cpufreq/elanfreq.c             |  8 +++++++-
 drivers/cpufreq/exynos5440-cpufreq.c   | 13 ++++++++----
 drivers/cpufreq/freq_table.c           | 36 +++++++++++++---------------------
 drivers/cpufreq/ia64-acpi-cpufreq.c    | 16 ++++++++++-----
 drivers/cpufreq/imx6q-cpufreq.c        | 13 +++++++++---
 drivers/cpufreq/kirkwood-cpufreq.c     |  2 +-
 drivers/cpufreq/loongson1-cpufreq.c    | 10 +---------
 drivers/cpufreq/loongson2_cpufreq.c    |  5 ++---
 drivers/cpufreq/maple-cpufreq.c        |  6 ++++++
 include/linux/cpufreq.h                |  9 ++-------
 22 files changed, 117 insertions(+), 121 deletions(-)

-- 
2.7.1.410.g6faf27b
