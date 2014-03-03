From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Generic PM domains - too noisy?
Date: Mon, 3 Mar 2014 12:12:04 +0000
Message-ID: <20140303121204.GH21483@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:36113 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753541AbaCCMMJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Mar 2014 07:12:09 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

Rafael,

I've been trying out the generic PM domains support with a small driver
on Marvell Dove.  At the moment, I have just one domain with one device
in it, and it's quite basic in that all it does is provide a power_on
and power_off hook.

Both of these hooks read/write three registers in sequence under a spin
lock, so nothing too heavy.  The lock is only taken by this code, so at
the moment there's no contention on that lock.

However, what I find is that it's very noisy in the kernel log, printing
much of this at warning level:

ap510-vmeta ap510-vmeta.0: start latency exceeded, new value 2352 ns
ap510-vmeta ap510-vmeta.0: state restore latency exceeded, new value 3594 ns
ap510-vmeta ap510-vmeta.0: stop latency exceeded, new value 2784 ns
ap510-vmeta ap510-vmeta.0: state save latency exceeded, new value 3234 ns
vpu: Power-off latency exceeded, new value 12025 ns
vpu: Power-on latency exceeded, new value 12156 ns
ap510-vmeta ap510-vmeta.0: state save latency exceeded, new value 3342 ns
ap510-vmeta ap510-vmeta.0: state restore latency exceeded, new value 3840 ns
ap510-vmeta ap510-vmeta.0: state save latency exceeded, new value 3564 ns
vpu: Power-off latency exceeded, new value 104996 ns
ap510-vmeta ap510-vmeta.0: state save latency exceeded, new value 3570 ns
ap510-vmeta ap510-vmeta.0: state save latency exceeded, new value 3612 ns
ap510-vmeta ap510-vmeta.0: stop latency exceeded, new value 2790 ns
ap510-vmeta ap510-vmeta.0: stop latency exceeded, new value 2808 ns
ap510-vmeta ap510-vmeta.0: state save latency exceeded, new value 3636 ns
ap510-vmeta ap510-vmeta.0: state restore latency exceeded, new value 3924 ns
vpu: Power-on latency exceeded, new value 21000 ns
ap510-vmeta ap510-vmeta.0: state save latency exceeded, new value 3732 ns
vpu: Power-on latency exceeded, new value 5066544 ns
ap510-vmeta ap510-vmeta.0: state restore latency exceeded, new value 3942 ns
ap510-vmeta ap510-vmeta.0: stop latency exceeded, new value 27006 ns
ap510-vmeta ap510-vmeta.0: state save latency exceeded, new value 27072 ns
ap510-vmeta ap510-vmeta.0: stop latency exceeded, new value 130850 ns
ap510-vmeta ap510-vmeta.0: state restore latency exceeded, new value 59821 ns
ap510-vmeta ap510-vmeta.0: state restore latency exceeded, new value 181628 ns
vpu: Power-off latency exceeded, new value 215840 ns
ap510-vmeta ap510-vmeta.0: start latency exceeded, new value 73057 ns
ap510-vmeta ap510-vmeta.0: state save latency exceeded, new value 86659 ns
ap510-vmeta ap510-vmeta.0: stop latency exceeded, new value 155288 ns
ap510-vmeta ap510-vmeta.0: start latency exceeded, new value 143629 ns
ap510-vmeta ap510-vmeta.0: stop latency exceeded, new value 156973 ns
ap510-vmeta ap510-vmeta.0: state save latency exceeded, new value 135715 ns
ap510-vmeta ap510-vmeta.0: state save latency exceeded, new value 364768 ns
ap510-vmeta ap510-vmeta.0: state restore latency exceeded, new value 484019 ns
ap510-vmeta ap510-vmeta.0: stop latency exceeded, new value 355288 ns
ap510-vmeta ap510-vmeta.0: state restore latency exceeded, new value 1981264 ns
ap510-vmeta ap510-vmeta.0: start latency exceeded, new value 521765 ns
ap510-vmeta ap510-vmeta.0: start latency exceeded, new value 616560 ns
vpu: Power-off latency exceeded, new value 495882 ns
vpu: Power-off latency exceeded, new value 501834 ns
ap510-vmeta ap510-vmeta.0: stop latency exceeded, new value 436259 ns

Rerally, the power on/power off latency should be small - which it would
be if only this code was being run and measured.

However, when you factor in interrupts, context switches due to preemption,
etc, it quickly becomes apparent that measuring the absolute time that it
takes for a handler to complete is nonsense - not only are you measuring
the latency of that handler to complete, but if the kernel ends up by way
of preemption switching to another thread, your latency includes the time
it takes for the system to return back to running the handler.  The more
the system is loaded, the longer these latency measurements will be.

So, here's the question: what use is this information which can be wrong
by a factor of 300x or more, and why does it need to be printed at
warning level?

Here's my code:

struct pmu_data {
        spinlock_t lock;
};

struct pmu_domain {
        struct pmu_data *pmu;
        unsigned int pwr_mask;
        unsigned int rst_mask;
        unsigned int iso_mask;
        struct generic_pm_domain base;
};

#define to_pmu_domain(dom) container_of(dom, struct pmu_domain, base)

static int pmu_domain_power_off(struct generic_pm_domain *domain)
{
        struct pmu_domain *pmu_dom = to_pmu_domain(domain);
        struct pmu_data *pmu = pmu_dom->pmu;
        unsigned long flags;
        unsigned int val;

        spin_lock_irqsave(&pmu->lock, flags);

        /* Enable isolators */
        if (pmu_dom->iso_mask) {
                val = readl(PMU_ISO_CTRL_REG);
                val &= ~pmu_dom->iso_mask;
                writel(val, PMU_ISO_CTRL_REG);
        }

        /* Reset unit */
        if (pmu_dom->rst_mask) {
                val = readl(PMU_SW_RST_CTRL_REG);
                val &= ~pmu_dom->rst_mask;
                writel(val, PMU_SW_RST_CTRL_REG);
        }

        /* Power down */
        val = readl(PMU_PWR_SUPLY_CTRL_REG);
        val |= pmu_dom->pwr_mask;
        writel(val, PMU_PWR_SUPLY_CTRL_REG);

        spin_unlock_irqrestore(&pmu->lock, flags);

        return 0;
}

static int pmu_domain_power_on(struct generic_pm_domain *domain)
{
        struct pmu_domain *pmu_dom = to_pmu_domain(domain);
        struct pmu_data *pmu = pmu_dom->pmu;
        unsigned long flags;
        unsigned int val;

        spin_lock_irqsave(&pmu->lock, flags);

        /* Power on */
        val = readl(PMU_PWR_SUPLY_CTRL_REG);
        val &= ~pmu_dom->pwr_mask;
        writel(val, PMU_PWR_SUPLY_CTRL_REG);

        /* Release reset */
        if (pmu_dom->rst_mask) {
                val = readl(PMU_SW_RST_CTRL_REG);
                val |= pmu_dom->rst_mask;
                writel(val, PMU_SW_RST_CTRL_REG);
        }

        /* Disable isolators */
        if (pmu_dom->iso_mask) {
                val = readl(PMU_ISO_CTRL_REG);
                val |= pmu_dom->iso_mask;
                writel(val, PMU_ISO_CTRL_REG);
        }

        spin_unlock_irqrestore(&pmu->lock, flags);

        return 0;
}

static struct pmu_data pmu = {
        .lock   = __SPIN_LOCK_UNLOCKED(&pmu.lock),
};

static struct pmu_domain vpu_domain = {
        .pmu = &pmu,
        .pwr_mask = PMU_PWR_VPU_PWR_DWN_MASK,
        .rst_mask = PMU_SW_RST_VIDEO_MASK,
        .iso_mask = PMU_ISO_VIDEO_MASK,
        .base = {
                .name = "vpu",
                .dev_irq_safe = true,
                .power_off = pmu_domain_power_off,
                .power_on = pmu_domain_power_on,
        },
};

static void pmu_domain_register(struct pmu_domain *pmu_dom)
{
        unsigned int val;

        val = readl(PMU_PWR_SUPLY_CTRL_REG);

        return pm_genpd_init(&pmu_dom->base, NULL, !(val & pmu_dom->pwr_mask));
}
...

        pmu_domain_register(&vpu_domain);
        pm_genpd_poweroff_unused();

In the driver, on probe:

        pm_runtime_use_autosuspend(&pdev->dev);
        pm_runtime_enable(&pdev->dev);

and then I'm calling pm_runtime_get_sync(), pm_runtime_mark_last_busy()
and pm_runtime_put_autosuspend() at appropriate points - yes, I'm aware
that the autosuspend delay will be zero at this point which means
immediate suspend on put_autosuspend().

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
