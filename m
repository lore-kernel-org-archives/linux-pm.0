From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] Exynos4: cpuidle: support dual CPUs with AFTR state
Date: Fri, 4 Apr 2014 15:25:56 +0100
Message-ID: <20140404142556.GA17431@red-moon>
References: <1396604925-18383-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1396604925-18383-1-git-send-email-daniel.lezcano@linaro.org>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "t.figa@samsung.com" <t.figa@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "ccross@google.com" <ccross@google.com>
List-Id: linux-pm@vger.kernel.org

Hi Daniel,

On Fri, Apr 04, 2014 at 10:48:45AM +0100, Daniel Lezcano wrote:
> The following driver is for exynos4210. I did not yet finished the other boards, so
> I created a specific driver for 4210 which could be merged later.
> 
> The driver is based on Colin Cross's driver found at:
> 
> https://android.googlesource.com/kernel/exynos/+/e686b1ec67423c40b4fdf811f9a4dfa3b393a010%5E%5E!/
> 
> This one was based on a 3.4 kernel and an old API.
> 
> It has been refreshed, simplified and based on the recent code cleanup I sent
> today.
> 
> The AFTR could be entered when all the cpus (except cpu0) are down. In order to
> reach this situation, the couple idle states are used.
> 
> There is a sync barrier at the entry and the exit of the low power function. So
> all cpus will enter and exit the function at the same time.
> 
> At this point, CPU0 knows the other cpu will power down itself. CPU0 waits for
> the CPU1 to be powered down and then initiate the AFTR power down sequence.
> 
> No interrupts are handled by CPU1, this is why we switch to the timer broadcast
> even if the local timer is not impacted by the idle state.

Can you elaborate on this please ? Is that because the local timers are
not wake-up capable (shutdown) ? Or because only the IRQs targeted at CPU with
MPIDR[7:0] == 0x0 are wake-up capable ?

> When CPU0 wakes up, it powers up CPU1 and waits for it to boot. Then they both
> exit the idle function.

Does this mean that once shutdown CPU1 is stuck solid till it is poked
by CPU0, right ? Again I think this should be handled with MPIDRs, not
with cpu logical indices.

> This driver allows the exynos4210 to have the same power consumption at idle
> time than the one when we have to unplug CPU1 in order to let CPU0 to reach
> the AFTR state.

Which is a good thing and that's the way the driver should have been
implemented in the first place, thanks for posting it.

[...]

> +static void (*exynos_aftr)(void);
> +
> +static int cpu_suspend_finish(unsigned long flags)
> +{
> +	if (flags)
> +		exynos_aftr();

This function pointer obfuscates things, not very easy to follow.
Is there a reason why you should pass flags and run that code in
the finisher instead of running this code in the enter method for
CPU0 ? Is that a timing issue ? I do not see why running those
commands before saving the context in cpu_suspend() can make any
difference (well, apart from timing as I said), the idle functions
are already different for CPU0 and CPU1.

> +
> +	cpu_do_idle();
> +
> +	return -1;
> +}
> +
> +static int exynos_cpu0_enter_aftr(void)
> +{
> +	int ret = -1;
> +
> +	/*
> +	 * If the other cpu is powered on, we have to power it off, because
> +	 * the AFTR state won't work otherwise
> +	 */
> +	if (cpu_online(1)) {

Again, this dependency on logical CPUs is not ideal, but I guess it is
impossible on Exynos to swap the boot CPU (or put it differently boot
on a different CPU), so we should live with that.

I've got to say MCPM could help make this code a bit more generic (I
know that already CPUs are coordinated through coupled C-states, but
this primary-secondary shutdown coordination could reuse the MCPM state
machine, I have to check).

> +
> +		/*
> +		 * We reach a sync point with the coupled idle state, we know
> +		 * the other cpu will power down itself or will abort the
> +		 * sequence, let's wait for one of these to happen
> +		 */
> +		while (__raw_readl(S5P_ARM_CORE1_STATUS) & 3) {
> +
> +			/*
> +			 * The other cpu may skip idle and boot back
> +			 * up again
> +			 */
> +			if (atomic_read(&cpu1_wakeup))
> +				goto abort;
> +
> +			/*
> +			 * The other cpu may bounce through idle and
> +			 * boot back up again, getting stuck in the
> +			 * boot rom code
> +			 */
> +			if (__raw_readl(BOOT_VECTOR) == 0)

Who clears the boot vector value ? FW ? Does this mean that CPU1 can be
reset if there is a pending IRQ for it ? That's "interesting". Since
IRQs are always affine to CPU0 and the local timer entered broadcast I
really would like to understand what IRQ can wake up CPU1 here (hardly
an IPI, CPU0 has hit the coupled barried already).

CPU1 is still in SMP mode though when it hits wfi (and it should not),
I wonder whether this plays a role here.

> +				goto abort;
> +
> +			cpu_relax();
> +		}
> +	}
> +
> +	cpu_pm_enter();
> +
> +	ret = cpu_suspend(1, cpu_suspend_finish);
> +

If we are executing here and the cluster has been shutdown, we must be sure
that CPU1 is off and I guess that's the case. If both CPUs are released
from reset and can run concurrently, there is a problem. It is related to
the enabling of the SCU, which, given your last series is supposed to be
executed in a CPU PM notifier. That code will work only if CPU1 is dead while
CPU0 reboots and I still think that enabling scu so late is a recipe for mayhem
and a bad example (not related to your clean-ups - this is true even in current
code). On platforms where all CPUs are reset on wake-up this will never ever
work, ie the SCU must be on by the time a CPU switches on its caches (because
there might be other CPUs running concurrently and they _have_ to be coherent).

> +	cpu_pm_exit();
> +
> +abort:
> +	if (cpu_online(1)) {
> +		/*
> +		 * Set the boot vector to something non-zero
> +		 */
> +		__raw_writel(virt_to_phys(s3c_cpu_resume),
> +			     BOOT_VECTOR);
> +		dsb();
> +
> +		/*
> +		 * Turn on cpu1 and wait for it to be on
> +		 */
> +		__raw_writel(0x3, S5P_ARM_CORE1_CONFIGURATION);
> +		while ((__raw_readl(S5P_ARM_CORE1_STATUS) & 3) != 3)
> +			cpu_relax();
> +
> +		/*
> +		 * Wait for cpu1 to get stuck in the boot rom
> +		 */
> +		while ((__raw_readl(BOOT_VECTOR) != 0) &&
> +		       !atomic_read(&cpu1_wakeup))
> +			cpu_relax();
> +
> +		if (!atomic_read(&cpu1_wakeup)) {
> +			/*
> +			 * Poke cpu1 out of the boot rom
> +			 */
> +			__raw_writel(virt_to_phys(s3c_cpu_resume),
> +				     BOOT_VECTOR);
> +			dsb_sev();
> +		}
> +
> +		/*
> +		 * Wait for cpu1 to finish booting
> +		 */
> +		while (!atomic_read(&cpu1_wakeup))
> +			cpu_relax();
> +	}
> +
> +	return ret;
> +}
> +
> +static int exynos_powerdown_cpu1(void)
> +{
> +	int ret = -1;
> +
> +	/*
> +	 * Idle sequence for cpu1
> +	 */
> +	if (cpu_pm_enter())
> +		goto cpu1_aborted;
> +
> +	/*
> +	 * Turn off cpu 1
> +	 */
> +	__raw_writel(0, S5P_ARM_CORE1_CONFIGURATION);
> +
> +	ret = cpu_suspend(0, cpu_suspend_finish);

To reiterate my point, CPU1 should execute this code if and only
if CPU0 has rebooted it (or idling it failed so it jumps back from
ROM code straight away and CPU0 bails out of idle too - scu is not
reset in that case).

This should be commented in detail.

More importantly, I do not see anywhere code that allows CPU1 to
clean its caches properly. While running cpu_suspend() the CPU cleans
its data cache using the LoUIS API, but it does that with the C bit
in SCTLR set, which means that it still allocates and could fetch
dirty lines from other CPUs, that's not 100% safe. So, as it is done in
arch/arm/mach-vexpress/tc2_pm.c - tc2_pm_down, core must clean its L1
with C bit in SCTLR cleared to stop allocations so that by the time
L1 cache clean is complete, the L1 data cache can't contain dirty lines.

> +
> +	cpu_pm_exit();
> +
> +cpu1_aborted:
> +	dsb();
> +	/*
> +	 * Notify cpu 0 that cpu 1 is awake
> +	 */
> +	atomic_set(&cpu1_wakeup, 1);
> +
> +	return ret;
> +}
> +
> +static int exynos_enter_aftr(struct cpuidle_device *dev,
> +			     struct cpuidle_driver *drv, int index)
> +{
> +	int ret;
> +
> +	__raw_writel(virt_to_phys(s3c_cpu_resume), BOOT_VECTOR);
> +
> +	/*
> +	 * Waiting all cpus to reach this point at the same moment
> +	 */
> +	cpuidle_coupled_parallel_barrier(dev, &exynos_idle_barrier);
> +
> +	/*
> +	 * Both cpus will reach this point at the same time
> +	 */
> +	ret = dev->cpu ? exynos_powerdown_cpu1() : exynos_cpu0_enter_aftr();
> +	if (ret)
> +		index = ret;
> +
> +	/*
> +	 * Waiting all cpus to finish the power sequence before going further
> +	 */
> +	cpuidle_coupled_parallel_barrier(dev, &exynos_idle_barrier);
> +
> +	atomic_set(&cpu1_wakeup, 0);
> +
> +	return index;
> +}
> +
> +static struct cpuidle_driver exynos_idle_driver = {
> +	.name		= "exynos4210_idle",
> +	.owner		= THIS_MODULE,
> +	.states = {
> +		ARM_CPUIDLE_WFI_STATE,
> +		[1] = {
> +			.enter			= exynos_enter_aftr,
> +			.exit_latency		= 5000,
> +			.target_residency	= 10000,
> +			.flags			= CPUIDLE_FLAG_TIME_VALID |
> +			CPUIDLE_FLAG_COUPLED | CPUIDLE_FLAG_TIMER_STOP,
> +			.name			= "C1",
> +			.desc			= "ARM power down",
> +		},
> +	},
> +	.state_count = 2,
> +	.safe_state_index = 0,
> +};
> +
> +static int exynos_cpuidle_probe(struct platform_device *pdev)
> +{
> +	exynos_aftr = (void *)(pdev->dev.platform_data);

This function pointer passing serves what purpose ? Removing platform
code dependency ? I do not see how you can avoid that given how tied
this code is to a specific platform.

BTW, you should check exynos_aftr != NULL, just in case.

Thank you !!
Lorenzo
