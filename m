From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 2/2] cpuidle: exynos: add coupled cpuidle support for
 Exynos4210
Date: Wed, 12 Nov 2014 19:41:46 +0100
Message-ID: <4297709.zGrpcvcSeS@amdc1032>
References: <1415383252-20118-1-git-send-email-b.zolnierkie@samsung.com>
 <3813280.9hNcruz8Q6@amdc1032> <54638E28.6050304@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:19554 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbaKLSlv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Nov 2014 13:41:51 -0500
In-reply-to: <54638E28.6050304@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Colin Cross <ccross@google.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, Lukasz Majewski <l.majewski@samsung.com>


Hi,

On Wednesday, November 12, 2014 05:43:20 PM Daniel Lezcano wrote:
> On 11/12/2014 04:13 PM, Bartlomiej Zolnierkiewicz wrote:
> >
> 
> Hi Bartlomiej,
> 
> [ cut ]
> 
> >>> - using arch_send_wakeup_ipi_mask() instead of dsb_sev()
> >>>     (this matches CPU hotplug code in arch/arm/mach-exynos/platsmp.c)
> >>
> >> I am curious. You experienced very rare hangs after running the tests a
> >> few hours, right ? Is the SEV replaced by the IPI solving the issue ? If
> >> yes, how did you catch it ?
> >
> > Rare hangs showed up after about 30-40 minutes of testing with the attached
> > app and script (running of "./cpuidle_state1_test.sh script 2 500" has never
> > completed on the umodified driver).
> >
> > The problem turned out to be in the following loop waiting for CPU1 to get
> > stuck in the BOOT ROM:
> >
> > 		/*
> > 		 * Wait for cpu1 to get stuck in the boot rom
> > 		 */
> > 		while ((__raw_readl(BOOT_VECTOR) != 0) &&
> > 		       !atomic_read(&cpu1_wakeup))
> > 			cpu_relax();
> >
> > [ Removal of the loop fixed the problem. ]
> 
> Just for my personal information, do you know why ?

Unfortunately no.  I just suspect that sometimes the BOOT_VECTOR register
is not zeroed (or is zeroed and then overwritten) because of the bug in
the firmware.

> [ cut ]
> 
> >>> +#ifdef CONFIG_ARM_EXYNOS_CPUIDLE
> >>> +	if (of_machine_is_compatible("samsung,exynos4210"))
> >>> +		exynos_cpuidle.dev.platform_data = &cpuidle_coupled_exynos_data;
> >>> +#endif
> >>
> >> You should not add those #ifdef.
> >
> > Without those #ifdef I get:
> >
> >    LD      init/built-in.o
> > arch/arm/mach-exynos/built-in.o: In function `exynos_dt_machine_init':
> > /home/bzolnier/sam/linux-sprc/arch/arm/mach-exynos/exynos.c:334: undefined reference to `cpuidle_coupled_exynos_data'
> > make: *** [vmlinux] Error 1
> >
> > when CONFIG_EXYNOS_CPU_SUSPEND is disabled.
> 
> Here, we are introducing some dependencies I tried to drop in the 
> different drivers.
> 
> I looked more closely at the code and especially the 
> 'cpuidle_coupled_exynos_data'. I don't think it is worth to have it 
> because it adds more complexity and you have to define this structure to 
> be visible from the drivers/cpuidle files.
> 
> I suggest you create an simple function in "pm.c"
> 
> int exynos_coupled_aftr(int cpu)
> {
> 	pre_enter...
> 
> 	if (!cpu)
> 		cpu0_enter_aftr()
> 	else
> 		cpu1_powerdown()
> 
> 	post_enter...
> }
> 
> and in the cpuidle driver itself, you just use the already existing 
> anonymous callback 'exynos_enter_aftr' (and mutate it to conform the 
> parameters).
> 
> You won't have to share any structure between the arch code and the 
> cpuidle driver.

The reason why the separate callbacks are needed is that the cpuidle
driver code uses coupled cpuidle barriers (I cannot move them to pm.c):

+static int exynos_enter_coupled_lowpower(struct cpuidle_device *dev,
+					 struct cpuidle_driver *drv,
+					 int index)
+{
+	int ret;
+
+	exynos_cpuidle_pdata->pre_enter_aftr();
+
+	/*
+	 * Waiting all cpus to reach this point at the same moment
+	 */
+	cpuidle_coupled_parallel_barrier(dev, &exynos_idle_barrier);
+
+	/*
+	 * Both cpus will reach this point at the same time
+	 */
+	ret = dev->cpu ? exynos_cpuidle_pdata->cpu1_powerdown()
+		       : exynos_cpuidle_pdata->cpu0_enter_aftr();
+	if (ret)
+		index = ret;
+
+	/*
+	 * Waiting all cpus to finish the power sequence before going further
+	 */
+	cpuidle_coupled_parallel_barrier(dev, &exynos_idle_barrier);
+
+	exynos_cpuidle_pdata->post_enter_aftr();
+
+	return index;
+}

Could you please explain how the proposed pm.c::exynos_coupled_aftr()
would operate without these barriers?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

