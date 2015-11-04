From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH] PM / OPP: Protect updates to list_dev with mutex
Date: Wed, 04 Nov 2015 02:22:13 -0800
Message-ID: <20151104102213.22783.81575@quantum>
References: <5f8fac4ad84716ef68fc50ab0b78e11ad2837524.1446205160.git.viresh.kumar@linaro.org>
 <20151030170604.GD19782@codeaurora.org> <20151031021409.GT3716@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151031021409.GT3716@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dan Carpenter <dan.carpenter@oracle.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Quoting Viresh Kumar (2015-10-30 19:14:09)
> On 30-10-15, 10:06, Stephen Boyd wrote:
> > On 10/30, Viresh Kumar wrote:
> > > dev_opp_list_lock is used everywhere to protect device and OPP lists,
> > > but dev_pm_opp_set_sharing_cpus() is missed somehow. And instead we used
> > > rcu-lock, which wouldn't help here as we are adding a new list_dev.
> > > 
> > > This also fixes a problem where we have called kzalloc(..., GFP_KERNEL)
> > > from within rcu-lock, which isn't allowed as kzalloc can sleep when
> > > called with GFP_KERNEL.
> > 
> > Care to share the splat here?
> 
> I don't know what is wrong (or right) with my exynos 5250 board, but I
> didn't got any splat here even with the right config options (yes I
> should have mentioned that earlier). I have seen this at other times
> as well, while we were running after some cpufreq traces..
> 
> But, the case in hand is pretty straight forward and Mike T. did get a
> splat as that's what he told me. We are calling a sleep-able function
> from rcu_lock and that's obviously wrong.

Splat:

[    2.461883] ===============================
[    2.466278] [ INFO: suspicious RCU usage. ]
[    2.470703] 4.3.0-rc7-00004-g7f16d90-dirty #11 Not tainted
[    2.476501] -------------------------------
[    2.480895] include/linux/rcupdate.h:578 Illegal context switch in RCU read-side critical section!
[    2.490325]
[    2.490325] other info that might help us debug this:
[    2.490325]
[    2.498779]
[    2.498779] rcu_scheduler_active = 1, debug_locks = 1
[    2.505645] 4 locks held by swapper/0/1:
[    2.509796]  #0:  (&dev->mutex){......}, at: [<c0678e1c>] __device_attach+0x20/0x10c
[    2.518066]  #1:  (cpu_hotplug.lock){++++++}, at: [<c024c204>] get_online_cpus+0x40/0xb0
[    2.526672]  #2:  (subsys mutex#5){+.+.+.}, at: [<c0677900>] subsys_interface_register+0x44/0xdc
[    2.535980]  #3:  (rcu_read_lock){......}, at: [<c0687bc8>] set_cpus_sharing_opps+0x0/0x1d4
[    2.544860]
[    2.544860] stack backtrace:
[    2.549499] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.3.0-rc7-00004-g7f16d90-dirty #11
[    2.558013] Hardware name: Generic OMAP4 (Flattened Device Tree)
[    2.564361] [<c0219c34>] (unwind_backtrace) from [<c0215228>] (show_stack+0x10/0x14)
[    2.572570] [<c0215228>] (show_stack) from [<c04c2af0>] (dump_stack+0x98/0xc0)
[    2.580200] [<c04c2af0>] (dump_stack) from [<c0270a84>] (___might_sleep+0x24c/0x298)
[    2.588378] [<c0270a84>] (___might_sleep) from [<c0328ccc>] (kmem_cache_alloc+0xe8/0x164)
[    2.597015] [<c0328ccc>] (kmem_cache_alloc) from [<c068706c>] (_add_list_dev+0x20/0x48)
[    2.605468] [<c068706c>] (_add_list_dev) from [<c0687c98>] (set_cpus_sharing_opps+0xd0/0x1d4)
[    2.614471] [<c0687c98>] (set_cpus_sharing_opps) from [<c086b9b4>] (cpufreq_init+0x4cc/0x62c)
[    2.623474] [<c086b9b4>] (cpufreq_init) from [<c0867780>] (cpufreq_online+0xc8/0x704)
[    2.631713] [<c0867780>] (cpufreq_online) from [<c0677954>] (subsys_interface_register+0x98/0xdc)
[    2.641082] [<c0677954>] (subsys_interface_register) from [<c08682b4>] (cpufreq_register_driver+0x110/0x17c)
[    2.651458] [<c08682b4>] (cpufreq_register_driver) from [<c086bb74>] (dt_cpufreq_probe+0x60/0x8c)
[    2.660827] [<c086bb74>] (dt_cpufreq_probe) from [<c067a9f8>] (platform_drv_probe+0x44/0xa4)
[    2.669708] [<c067a9f8>] (platform_drv_probe) from [<c0679134>] (driver_probe_device+0x208/0x2f4)
[    2.679077] [<c0679134>] (driver_probe_device) from [<c0677630>] (bus_for_each_drv+0x60/0x94)
[    2.688079] [<c0677630>] (bus_for_each_drv) from [<c0678ea4>] (__device_attach+0xa8/0x10c)
[    2.696777] [<c0678ea4>] (__device_attach) from [<c0678584>] (bus_probe_device+0x88/0x90)
[    2.705413] [<c0678584>] (bus_probe_device) from [<c0676934>] (device_add+0x3e8/0x574)
[    2.713775] [<c0676934>] (device_add) from [<c067a70c>] (platform_device_add+0xb4/0x20c)
[    2.722320] [<c067a70c>] (platform_device_add) from [<c067af70>] (platform_device_register_full+0xc4/0xe8)
[    2.732482] [<c067af70>] (platform_device_register_full) from [<c0eaccf0>] (omap2_common_pm_late_init+0x108/0x114)
[    2.743377] [<c0eaccf0>] (omap2_common_pm_late_init) from [<c0ea9f18>] (omap_common_late_init+0xc/0x14)
[    2.753295] [<c0ea9f18>] (omap_common_late_init) from [<c0eaa3d8>] (omap4430_init_late+0x8/0x14)
[    2.762542] [<c0eaa3d8>] (omap4430_init_late) from [<c0e9e8cc>] (init_machine_late+0x20/0x94)
[    2.771545] [<c0e9e8cc>] (init_machine_late) from [<c020ad50>] (do_one_initcall+0x8c/0x1d8)
[    2.780395] [<c020ad50>] (do_one_initcall) from [<c0e9ce08>] (kernel_init_freeable+0x158/0x1f8)
[    2.789581] [<c0e9ce08>] (kernel_init_freeable) from [<c0a4ac04>] (kernel_init+0xc/0xe8)
[    2.798126] [<c0a4ac04>] (kernel_init) from [<c0210dd0>] (ret_from_fork+0x14/0x24)

Regards,
Mike

> 
> > > diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
> > > index 7654c5606307..91f15b2e25ee 100644
> > > --- a/drivers/base/power/opp/cpu.c
> > > +++ b/drivers/base/power/opp/cpu.c
> > > @@ -124,12 +124,12 @@ int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
> > >     struct device *dev;
> > >     int cpu, ret = 0;
> > >  
> > > -   rcu_read_lock();
> > > +   mutex_lock(&dev_opp_list_lock);
> > >  
> > >     dev_opp = _find_device_opp(cpu_dev);
> > 
> > So does _find_device_opp() need to be called with rcu_read_lock()
> > held or not? The comment above the function makes it sound like
> > we need RCU, but we don't do that here anymore.
> 
> That is more for the readers, as this function is going to return a
> pointer to the device OPP, and to make sure it isn't freed behind
> their back, they need to take the RCU lock.
> 
> There are other writer code paths as well, like add-opp, where we just
> take the mutex as there can't be anything stronger than that :)
> 
> -- 
> viresh
