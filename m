From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH v4 0/3] DEVFREQ,
	DVFS framework for non-CPU devices
Date: Thu, 28 Jul 2011 21:46:29 -0700
Message-ID: <CAJOA=zNpmQpCyh0ow2q6gUTxkLMcWDsoMOaQEGzV4Sw__BszHg@mail.gmail.com>
References: <1310717510-19002-1-git-send-email-myungjoo.ham@samsung.com>
	<201107290010.53788.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107290010.53788.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 28, 2011 at 3:10 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, July 15, 2011, MyungJoo Ham wrote:
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
>> /arch/arm/mach-exynos4/devfreq_bus.c in the git tree.
>>
>> MyungJoo Ham (3):
>> =A0 PM: Introduce DEVFREQ: generic DVFS framework with device-specific
>> =A0 =A0 OPPs
>> =A0 PM / DEVFREQ: add example governors
>> =A0 PM / DEVFREQ: add sysfs interface (including user tickling)
>
> OK, I'm going to take the patches for 3.2.

Have any other platforms signed up to use this mechanism to manage
their peripheral DVFS?

Thanks,
Mike

> Thanks,
> Rafael
>
>
>> =A0Documentation/ABI/testing/sysfs-devices-power | =A0 50 ++
>> =A0Documentation/ABI/testing/sysfs-power =A0 =A0 =A0 =A0 | =A0 43 ++
>> =A0drivers/base/power/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A01 +
>> =A0drivers/base/power/devfreq.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
714 +++++++++++++++++++++++++
>> =A0drivers/base/power/opp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A09 +
>> =A0include/linux/devfreq.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0119 ++++
>> =A0kernel/power/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 34 ++
>> =A07 files changed, 970 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/base/power/devfreq.c
>> =A0create mode 100644 include/linux/devfreq.h
>>
>>
>
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>
