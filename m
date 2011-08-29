From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH v8 0/5] DEVFREQ,
	DVFS Framework for Non-CPU Devices.
Date: Mon, 29 Aug 2011 12:22:58 -0700
Message-ID: <CAJOA=zN_TqAz5tyXp3uRe4MezxLDAF5Dhzb6kst2xWi9zzr5dg@mail.gmail.com>
References: <1314086044-24659-1-git-send-email-myungjoo.ham@samsung.com>
	<1314174131-14194-1-git-send-email-myungjoo.ham@samsung.com>
	<201108272235.39334.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201108272235.39334.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

Rafael,

Locking doesn't seem safe in v8; I replied with my comments.

I should be free this week to review the next round a little more
quickly.  Last week was hectic.

Regards,
Mike

2011/8/27 Rafael J. Wysocki <rjw@sisk.pl>:
> Mike, are patches [3-5/5] in this revision fine by you?
>
> Rafael
>
>
> On Wednesday, August 24, 2011, MyungJoo Ham wrote:
>> The patchset revision v8 has minor updates since v7 and v6.
>> - Allow governors to have their own sysfs interface and init/exit callba=
cks.
>>
>> The patches 1/5 (OPP notifier) and 2/5 (DEVFREQ core) have no changes si=
nce v7.
>> There has been reordering between "add common sysfs interfaces" patch
>> and "add basic governors" (3/5 and 5/5)
>> "add internal interfaces for governors (4/5)" patch has been newly
>> introduced at v8 patchset.
>>
>> For a usage example, please look at
>> http://git.infradead.org/users/kmpark/linux-2.6-samsung/shortlog/refs/he=
ads/devfreq
>>
>> In the above git tree, DVFS (dynamic voltage and frequency scaling) mech=
anism
>> is applied to the memory bus of Exynos4210 for Exynos4210-NURI boards.
>> In the example, the LPDDR2 DRAM frequency changes between 133, 266, and =
400MHz
>> and other related clocks simply follow the determined DDR RAM clock.
>>
>> The DEVFREQ driver for Exynos4210 memory bus is at
>> /drivers/devfreq/exynos4210_memorybus.c in the git tree.
>>
>> In the dd (writing and reading 360MiB) test with NURI board, the memory
>> throughput was not changed (the performance is not deteriorated) while
>> the SoC power consumption has been reduced by 1%. When the memory access
>> is not that intense while the CPU is heavily used, the SoC power consump=
tion
>> has been reduced by 6%. The power consumption has been compared with the
>> case using the conventional Exynos4210 CPUFREQ driver, which sets memory
>> bus frequency according to the CPU core frequency. Besides, when the CPU=
 core
>> running slow and the memory access is intense, the performance (memory
>> throughput) has been increased by 11% (with higher SoC power consumption=
 of
>> 5%). The tested governor is "simple-ondemand".
>>
>> MyungJoo Ham (5):
>> =A0 PM / OPP: Add OPP availability change notifier.
>> =A0 PM: Introduce DEVFREQ: generic DVFS framework with device-specific
>> =A0 =A0 OPPs
>> =A0 PM / DEVFREQ: add common sysfs interfaces
>> =A0 PM / DEVFREQ: add internal interfaces for governors
>> =A0 PM / DEVFREQ: add basic governors
>>
>> =A0Documentation/ABI/testing/sysfs-devices-power | =A0 46 +++
>> =A0drivers/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 =A02 +
>> =A0drivers/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A02 +
>> =A0drivers/base/power/opp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 29 ++
>> =A0drivers/devfreq/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 75 ++++
>> =A0drivers/devfreq/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A05 +
>> =A0drivers/devfreq/devfreq.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0463 +++++++++++++++++++++++++
>> =A0drivers/devfreq/governor.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 20 +
>> =A0drivers/devfreq/governor_performance.c =A0 =A0 =A0 =A0| =A0 24 ++
>> =A0drivers/devfreq/governor_powersave.c =A0 =A0 =A0 =A0 =A0| =A0 24 ++
>> =A0drivers/devfreq/governor_simpleondemand.c =A0 =A0 | =A0 88 +++++
>> =A0drivers/devfreq/governor_userspace.c =A0 =A0 =A0 =A0 =A0| =A0119 ++++=
+++
>> =A0include/linux/devfreq.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0150 ++++++++
>> =A0include/linux/opp.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 12 +
>> =A014 files changed, 1059 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/devfreq/Kconfig
>> =A0create mode 100644 drivers/devfreq/Makefile
>> =A0create mode 100644 drivers/devfreq/devfreq.c
>> =A0create mode 100644 drivers/devfreq/governor.h
>> =A0create mode 100644 drivers/devfreq/governor_performance.c
>> =A0create mode 100644 drivers/devfreq/governor_powersave.c
>> =A0create mode 100644 drivers/devfreq/governor_simpleondemand.c
>> =A0create mode 100644 drivers/devfreq/governor_userspace.c
>> =A0create mode 100644 include/linux/devfreq.h
>>
>>
>
>
