From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] Exynos4: cpuidle: support dual CPUs with AFTR state
Date: Thu, 14 Aug 2014 12:55:03 +0200
Message-ID: <1929175.yd8jnLbgsd@amdc1032>
References: <1396604925-18383-1-git-send-email-daniel.lezcano@linaro.org>
 <2337363.gvYnZM7kuD@amdc1032> <53CCF438.8000805@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <53CCF438.8000805@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Tomasz Figa <t.figa@samsung.com>, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, ccross@google.com, k.kozlowski@samsung.com
List-Id: linux-pm@vger.kernel.org


Hi,

On Monday, July 21, 2014 01:06:32 PM Daniel Lezcano wrote:
> On 07/16/2014 07:34 PM, Bartlomiej Zolnierkiewicz wrote:
> >
> > Hi,
> >
> > On Friday, May 30, 2014 03:53:09 PM Bartlomiej Zolnierkiewicz wrote:
> >>
> >> Hi,
> >>
> >> On Friday, May 30, 2014 01:34:45 PM Tomasz Figa wrote:
> >>> Hi Daniel,
> >>>
> >>> On 30.05.2014 11:30, Daniel Lezcano wrote:
> >>>> On 04/24/2014 07:42 PM, Tomasz Figa wrote:
> >>>>> Hi Daniel,
> >>>>>
> >>>>> Please see my comments inline.
> >>>>>
> >>>>> Btw. Please fix your e-mail composer to properly wrap your messages
> >>>>> around 7xth column, as otherwise they're hard to read.
> >>>>>
> >>>>> On 04.04.2014 11:48, Daniel Lezcano wrote:
> >>>>>> The following driver is for exynos4210. I did not yet finished the
> >>>>>> other boards, so
> >>>>>> I created a specific driver for 4210 which could be merged later.
> >>>>>>
> >>>>>> The driver is based on Colin Cross's driver found at:
> >>>>>>
> >>>>>> https://android.googlesource.com/kernel/exynos/+/e686b1ec67423c40b4fdf811f9a4dfa3b393a010%5E%5E!/
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> This one was based on a 3.4 kernel and an old API.
> >>>>>>
> >>>>>> It has been refreshed, simplified and based on the recent code cleanup
> >>>>>> I sent
> >>>>>> today.
> >>>>>>
> >>>>>> The AFTR could be entered when all the cpus (except cpu0) are down. In
> >>>>>> order to
> >>>>>> reach this situation, the couple idle states are used.
> >>>>>>
> >>>>>> There is a sync barrier at the entry and the exit of the low power
> >>>>>> function. So
> >>>>>> all cpus will enter and exit the function at the same time.
> >>>>>>
> >>>>>> At this point, CPU0 knows the other cpu will power down itself. CPU0
> >>>>>> waits for
> >>>>>> the CPU1 to be powered down and then initiate the AFTR power down
> >>>>>> sequence.
> >>>>>>
> >>>>>> No interrupts are handled by CPU1, this is why we switch to the timer
> >>>>>> broadcast
> >>>>>> even if the local timer is not impacted by the idle state.
> >>>>>>
> >>>>>> When CPU0 wakes up, it powers up CPU1 and waits for it to boot. Then
> >>>>>> they both
> >>>>>> exit the idle function.
> >>>>>>
> >>>>>> This driver allows the exynos4210 to have the same power consumption
> >>>>>> at idle
> >>>>>> time than the one when we have to unplug CPU1 in order to let CPU0 to
> >>>>>> reach
> >>>>>> the AFTR state.
> >>>>>>
> >>>>>> This patch is a RFC because, we have to find a way to remove the macros
> >>>>>> definitions and cpu powerdown function without pulling the arch
> >>>>>> dependent
> >>>>>> headers.
> >>>>>>
> >>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>>>>> ---
> >>>>>>    arch/arm/mach-exynos/common.c        |   11 +-
> >>>>>>    drivers/cpuidle/Kconfig.arm          |    8 ++
> >>>>>>    drivers/cpuidle/Makefile             |    1 +
> >>>>>>    drivers/cpuidle/cpuidle-exynos4210.c |  226
> >>>>>> ++++++++++++++++++++++++++++++++++
> >>>>
> >>>> [ ... ]
> >>>>
> >>>>
> >>>>> Otherwise, I quite like the whole idea. I need to play a bit with CPU
> >>>>> hotplug and PMU to verify that things couldn't really be simplified a
> >>>>> bit, but in general this looks reasonably.
> >>>>
> >>>> Hi Tomasz,
> >>>>
> >>>> did you have time to look at this simplification ?
> >>>
> >>> Unfortunately I got preempted with other things to do and now I'm on
> >>> vacation. I worked a bit with Bart (added on CC) on this and generally
> >>> the conclusion was that all the things are necessary. He was also
> >>> working to extend the driver to support Exynos4x12.
> >>>
> >>> Bart, has anything interesting showed up since we talked about this last
> >>> time?
> >>
> >> Since we last looked into this I have fixed the "standard" AFTR support
> >> for Exynos3250 and started to work on adding Exynos3250 support to this
> >> driver (as Exynos3250 support has bigger priority than Exynos4x12 one).
> >> Unfortunately I also got preempted with other things so it is still
> >> unfinished and doesn't work yet.  Moreover I had no possibility to test
> >> the new driver on Exynos4210 based Origen yet (I hope to do this next
> >> week).
> >
> > I have tested this patch on Origen board (Exynos4210 rev 1.1) and it
> > causes system lockup (it seems that the code gets stuck on waiting for
> > CPU1 to wake up).
> >
> > The kernels I have tried:
> > * current -next + this patch + few fixes to bring it up to date
> > * commit cd245f5 + this patch + some fixes
> > * next-20140403 + your Exynos cpuidle patch series + this patch
> >
> > I have also tried with S5P_VA_SYSRAM replaced by S5P_INFORM5 to
> > match Exynos 4210 rev 1.1 but it didn't help.
> >
> > U-Boot version used is:
> > U-Boot 2012.07 (Sep 22 2012 - 05:12:41) for ORIGEN
> >
> > Could you please tell me which hardware/bootloader/kernel exactly
> > have you used to test this patch?
> 
> When I used it, it was on top of 3.15-rc1:
> 
> https://git.linaro.org/people/daniel.lezcano/linux.git/shortlog/refs/heads/cpuidle/samsung-next
> 
> The hardware was a exynos-4210 origen board ver A.

I need the following patch to make this driver work on my hardware.

[ Unfortunately even with this patch the driver doesn't work reliably.
  After 30-40 minutes of stress testing it lockups the system (I can
  send you testing app+script if needed). ]

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] cpuidle: Exynos4210: make coupled driver work on Revision 1.1

* Add static inline helper cpu_boot_reg_base() and use it instead of
  BOOT_VECTOR macro.

* Use S5P_INFORM register instead of S5P_VA_SYSRAM one on Revison 1.1
  (this matches platform code in arch/arm/mach-exynos/platsmp.c).

* Retry poking CPU1 out of the BOOT ROM if necessary
  (this matches platform code in arch/arm/mach-exynos/platsmp.c).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/cpuidle/cpuidle-exynos4210.c |   27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

Index: b/drivers/cpuidle/cpuidle-exynos4210.c
===================================================================
--- a/drivers/cpuidle/cpuidle-exynos4210.c	2014-07-22 15:42:11.580365939 +0200
+++ b/drivers/cpuidle/cpuidle-exynos4210.c	2014-07-22 16:11:01.112369130 +0200
@@ -29,12 +29,19 @@
 static atomic_t exynos_idle_barrier;
 static atomic_t cpu1_wakeup = ATOMIC_INIT(0);
 
-#define BOOT_VECTOR S5P_VA_SYSRAM
 #define S5P_VA_PMU                  S3C_ADDR(0x02180000)
 #define S5P_PMUREG(x)              (S5P_VA_PMU + (x))
+#define S5P_INFORM5                 S5P_PMUREG(0x0814)
 #define S5P_ARM_CORE1_CONFIGURATION S5P_PMUREG(0x2080)
 #define S5P_ARM_CORE1_STATUS        S5P_PMUREG(0x2084)
 
+static inline void __iomem *cpu_boot_reg_base(void)
+{
+	if (samsung_rev() == EXYNOS4210_REV_1_1)
+		return S5P_INFORM5;
+	return S5P_VA_SYSRAM;
+}
+
 static void (*exynos_aftr)(void);
 extern void exynos_cpu_resume(void);
 static int cpu_suspend_finish(unsigned long flags)
@@ -76,7 +83,7 @@ static int exynos_cpu0_enter_aftr(void)
 			 * boot back up again, getting stuck in the
 			 * boot rom code
 			 */
-			if (__raw_readl(BOOT_VECTOR) == 0)
+			if (__raw_readl(cpu_boot_reg_base()) == 0)
 				goto abort;
 
 			cpu_relax();
@@ -95,7 +102,7 @@ abort:
 		 * Set the boot vector to something non-zero
 		 */
 		__raw_writel(virt_to_phys(exynos_cpu_resume),
-			     BOOT_VECTOR);
+			     cpu_boot_reg_base());
 		dsb();
 
 		/*
@@ -108,24 +115,18 @@ abort:
 		/*
 		 * Wait for cpu1 to get stuck in the boot rom
 		 */
-		while ((__raw_readl(BOOT_VECTOR) != 0) &&
+		while ((__raw_readl(cpu_boot_reg_base()) != 0) &&
 		       !atomic_read(&cpu1_wakeup))
 			cpu_relax();
 
-		if (!atomic_read(&cpu1_wakeup)) {
+		while (!atomic_read(&cpu1_wakeup)) {
 			/*
 			 * Poke cpu1 out of the boot rom
 			 */
 			__raw_writel(virt_to_phys(exynos_cpu_resume),
-				     BOOT_VECTOR);
+				     cpu_boot_reg_base());
 			dsb_sev();
 		}
-
-		/*
-		 * Wait for cpu1 to finish booting
-		 */
-		while (!atomic_read(&cpu1_wakeup))
-			cpu_relax();
 	}
 
 	return ret;
@@ -165,7 +166,7 @@ static int exynos_enter_aftr(struct cpui
 {
 	int ret;
 
-	__raw_writel(virt_to_phys(exynos_cpu_resume), BOOT_VECTOR);
+	__raw_writel(virt_to_phys(exynos_cpu_resume), cpu_boot_reg_base());
 
 	/*
 	 * Waiting all cpus to reach this point at the same moment
