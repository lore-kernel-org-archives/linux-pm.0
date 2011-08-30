From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v8 0/5] DEVFREQ,
	DVFS Framework for Non-CPU Devices.
Date: Tue, 30 Aug 2011 16:32:15 -0700
Message-ID: <871uw2lbls.fsf@ti.com>
References: <1314086044-24659-1-git-send-email-myungjoo.ham@samsung.com>
	<1314174131-14194-1-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1314174131-14194-1-git-send-email-myungjoo.ham@samsung.com>
	(MyungJoo Ham's message of "Wed, 24 Aug 2011 17:22:06 +0900")
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

MyungJoo Ham <myungjoo.ham@samsung.com> writes:

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

Minor nit: you continue to use DEVFREQ (all caps) throughout subjects
and changelogs etc. when it should be called devfreq since it's not an
acryonym.

Kevin
