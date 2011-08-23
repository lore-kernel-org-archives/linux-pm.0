From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH v7 0/4] DEVFREQ,
	DVFS Framework for Non-CPU Devices.
Date: Tue, 23 Aug 2011 16:53:59 +0900
Message-ID: <1314086044-24659-1-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

For a usage example, please look at
http://git.infradead.org/users/kmpark/linux-2.6-samsung/shortlog/refs/heads/devfreq

In the above git tree, DVFS (dynamic voltage and frequency scaling) mechanism
is applied to the memory bus of Exynos4210 for Exynos4210-NURI boards.
In the example, the LPDDR2 DRAM frequency changes between 133, 266, and 400MHz
and other related clocks simply follow the determined DDR RAM clock.

The DEVFREQ driver for Exynos4210 memory bus is at
/drivers/devfreq/exynos4210_memorybus.c in the git tree.

In the dd (writing and reading 360MiB) test with NURI board, the memory
throughput was not changed (the performance is not deteriorated) while
the SoC power consumption has been reduced by 1%. When the memory access
is not that intense while the CPU is heavily used, the SoC power consumption
has been reduced by 6%. The power consumption has been compared with the
case using the conventional Exynos4210 CPUFREQ driver, which sets memory
bus frequency according to the CPU core frequency. Besides, when the CPU core
running slow and the memory access is intense, the performance (memory
throughput) has been increased by 11% (with higher SoC power consumption of
5%). The tested governor is "simple-ondemand".

There are no major changes since the last revision (v6 / v6-resubmit)
The followings are the minor changes
- type changed for timing variables (signed->unsigned) (2/4)
- removed unnecessary code and variable (2/4)
- added sysfs store function for polling interval (4/4)

In the patchset, the patch 1/4 has no changes and 3/4 has only changes
in the line numbers due to changes in 2/4 patch.

MyungJoo Ham (4):
  PM / OPP: Add OPP availability change notifier.
  PM: Introduce DEVFREQ: generic DVFS framework with device-specific
    OPPs
  PM / DEVFREQ: add basic governors
  PM / DEVFREQ: add sysfs interface

 Documentation/ABI/testing/sysfs-devices-power |   47 +++
 drivers/Kconfig                               |    2 +
 drivers/Makefile                              |    2 +
 drivers/base/power/opp.c                      |   29 ++
 drivers/devfreq/Kconfig                       |   75 ++++
 drivers/devfreq/Makefile                      |    5 +
 drivers/devfreq/devfreq.c                     |  482 +++++++++++++++++++++++++
 drivers/devfreq/governor_performance.c        |   24 ++
 drivers/devfreq/governor_powersave.c          |   24 ++
 drivers/devfreq/governor_simpleondemand.c     |   88 +++++
 drivers/devfreq/governor_userspace.c          |   27 ++
 include/linux/devfreq.h                       |  148 ++++++++
 include/linux/opp.h                           |   12 +
 13 files changed, 965 insertions(+), 0 deletions(-)
 create mode 100644 drivers/devfreq/Kconfig
 create mode 100644 drivers/devfreq/Makefile
 create mode 100644 drivers/devfreq/devfreq.c
 create mode 100644 drivers/devfreq/governor_performance.c
 create mode 100644 drivers/devfreq/governor_powersave.c
 create mode 100644 drivers/devfreq/governor_simpleondemand.c
 create mode 100644 drivers/devfreq/governor_userspace.c
 create mode 100644 include/linux/devfreq.h

-- 
1.7.4.1
