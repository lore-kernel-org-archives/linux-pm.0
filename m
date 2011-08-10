From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v5 0/3] DEVFREQ,
	DVFS Framework for Non-CPU Devices.
Date: Wed, 10 Aug 2011 23:09:25 +0200
Message-ID: <201108102309.25274.rjw@sisk.pl>
References: <1312794188-9823-1-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1312794188-9823-1-git-send-email-myungjoo.ham@samsung.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Monday, August 08, 2011, MyungJoo Ham wrote:
> For a usage example, please look at
> http://git.infradead.org/users/kmpark/linux-2.6-samsung/shortlog/refs/heads/devfreq
> 
> In the above git tree, DVFS (dynamic voltage and frequency scaling) mechanism
> is applied to the memory bus of Exynos4210 for Exynos4210-NURI boards.
> In the example, the LPDDR2 DRAM frequency changes between 133, 266, and 400MHz
> and other related clocks simply follow the determined DDR RAM clock.
> 
> The DEVFREQ driver for Exynos4210 memory bus is at
> /arch/arm/mach-exynos4/devfreq_bus.c in the git tree.
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
> MyungJoo Ham (3):
>   PM: Introduce DEVFREQ: generic DVFS framework with device-specific
>     OPPs
>   PM / DEVFREQ: add basic governors
>   PM / DEVFREQ: add sysfs interface
> 
>  Documentation/ABI/testing/sysfs-devices-power |   45 ++
>  drivers/base/power/Makefile                   |    1 +
>  drivers/base/power/devfreq.c                  |  555 +++++++++++++++++++++++++
>  drivers/base/power/opp.c                      |    9 +
>  include/linux/devfreq.h                       |  111 +++++
>  kernel/power/Kconfig                          |   34 ++
>  6 files changed, 755 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/base/power/devfreq.c
>  create mode 100644 include/linux/devfreq.h

Are there still any objections to this version of the patchset?

Rafael
