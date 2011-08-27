From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v8 0/5] DEVFREQ,
	DVFS Framework for Non-CPU Devices.
Date: Sat, 27 Aug 2011 22:35:39 +0200
Message-ID: <201108272235.39334.rjw@sisk.pl>
References: <1314086044-24659-1-git-send-email-myungjoo.ham@samsung.com>
	<1314174131-14194-1-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1314174131-14194-1-git-send-email-myungjoo.ham@samsung.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Mike Turquette <mturquette@ti.com>
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

Mike, are patches [3-5/5] in this revision fine by you?

Rafael


On Wednesday, August 24, 2011, MyungJoo Ham wrote:
> The patchset revision v8 has minor updates since v7 and v6.
> - Allow governors to have their own sysfs interface and init/exit callbacks.
> 
> The patches 1/5 (OPP notifier) and 2/5 (DEVFREQ core) have no changes since v7.
> There has been reordering between "add common sysfs interfaces" patch
> and "add basic governors" (3/5 and 5/5)
> "add internal interfaces for governors (4/5)" patch has been newly
> introduced at v8 patchset.
> 
> For a usage example, please look at
> http://git.infradead.org/users/kmpark/linux-2.6-samsung/shortlog/refs/heads/devfreq
> 
> In the above git tree, DVFS (dynamic voltage and frequency scaling) mechanism
> is applied to the memory bus of Exynos4210 for Exynos4210-NURI boards.
> In the example, the LPDDR2 DRAM frequency changes between 133, 266, and 400MHz
> and other related clocks simply follow the determined DDR RAM clock.
> 
> The DEVFREQ driver for Exynos4210 memory bus is at
> /drivers/devfreq/exynos4210_memorybus.c in the git tree.
> 
> In the dd (writing and reading 360MiB) test with NURI board, the memory
> throughput was not changed (the performance is not deteriorated) while
> the SoC power consumption has been reduced by 1%. When the memory access
> is not that intense while the CPU is heavily used, the SoC power consumption
> has been reduced by 6%. The power consumption has been compared with the
> case using the conventional Exynos4210 CPUFREQ driver, which sets memory
> bus frequency according to the CPU core frequency. Besides, when the CPU core
> running slow and the memory access is intense, the performance (memory
> throughput) has been increased by 11% (with higher SoC power consumption of
> 5%). The tested governor is "simple-ondemand".
> 
> MyungJoo Ham (5):
>   PM / OPP: Add OPP availability change notifier.
>   PM: Introduce DEVFREQ: generic DVFS framework with device-specific
>     OPPs
>   PM / DEVFREQ: add common sysfs interfaces
>   PM / DEVFREQ: add internal interfaces for governors
>   PM / DEVFREQ: add basic governors
> 
>  Documentation/ABI/testing/sysfs-devices-power |   46 +++
>  drivers/Kconfig                               |    2 +
>  drivers/Makefile                              |    2 +
>  drivers/base/power/opp.c                      |   29 ++
>  drivers/devfreq/Kconfig                       |   75 ++++
>  drivers/devfreq/Makefile                      |    5 +
>  drivers/devfreq/devfreq.c                     |  463 +++++++++++++++++++++++++
>  drivers/devfreq/governor.h                    |   20 +
>  drivers/devfreq/governor_performance.c        |   24 ++
>  drivers/devfreq/governor_powersave.c          |   24 ++
>  drivers/devfreq/governor_simpleondemand.c     |   88 +++++
>  drivers/devfreq/governor_userspace.c          |  119 +++++++
>  include/linux/devfreq.h                       |  150 ++++++++
>  include/linux/opp.h                           |   12 +
>  14 files changed, 1059 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/devfreq/Kconfig
>  create mode 100644 drivers/devfreq/Makefile
>  create mode 100644 drivers/devfreq/devfreq.c
>  create mode 100644 drivers/devfreq/governor.h
>  create mode 100644 drivers/devfreq/governor_performance.c
>  create mode 100644 drivers/devfreq/governor_powersave.c
>  create mode 100644 drivers/devfreq/governor_simpleondemand.c
>  create mode 100644 drivers/devfreq/governor_userspace.c
>  create mode 100644 include/linux/devfreq.h
> 
> 
