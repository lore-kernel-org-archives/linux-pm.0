From: Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH 00/11] OPP: Don't create multiple OPP tables for devices
 sharing OPP table
Date: Wed, 12 Sep 2018 15:55:37 +0200
Message-ID: <20180912135537.GA9985@centauri.ideon.se>
References: <cover.1536736872.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1536736872.git.viresh.kumar@linaro.org>
Sender: stable-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, "4.18" <stable@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 12, 2018 at 01:58:39PM +0530, Viresh Kumar wrote:
> Hello,
>
> Niklas Cassle recently reported some regressions with his Qcom cpufreq
> driver where he was getting some errors while creating the OPPs tables.
>
> After looking into it I realized that the OPP core incorrectly creates
> multiple OPP tables for the devices even if they are sharing the OPP
> table in DT. This happens when the request comes using different CPU
> devices. For example, dev_pm_opp_set_supported_hw() getting called using
> CPU0 and dev_pm_opp_of_add_table() getting called using CPU1.
>
> This series redesigns the internals of the OPP core to fix that. The
> redesign has simplified the core itself though.
>
> @Niklas: Can you please confirm that this series fixes the issues you
> have reported ? I have already tested it on Hikey960.

Hello Viresh,

This fixes the OPP error messages that I previously reported.

However, I also tested to add a duplicate OPP to the opp-table.

Before this series, I got the first two error prints.
After this series, I get the first two error prints + the use after free splat.

[    5.693273] cpu cpu0: _opp_is_duplicate: duplicate OPPs detected. Existing: freq: 307200000, volt: 905000, enabled: 1. New: freq: 307200000, volt: 904000, enabled: 1
[    5.695602] cpu cpu0: _of_add_opp_table_v2: Failed to add OPP, -17
[    5.713673] ------------[ cut here ]------------
[    5.715124] refcount_t: underflow; use-after-free.
[    5.720047] WARNING: CPU: 3 PID: 35 at lib/refcount.c:280 refcount_dec_not_one+0x9c/0xc0
[    5.723463] Modules linked in:
[    5.731461] CPU: 3 PID: 35 Comm: kworker/3:1 Tainted: G        W         4.19.0-rc3-00219-g
3f2e8f8e1fc5-dirty #63
[    5.734688] Hardware name: Qualcomm Technologies, Inc. DB820c (DT)
[    5.744940] Workqueue: events deferred_probe_work_func
[    5.750810] pstate: 40000005 (nZcv daif -PAN -UAO)
[    5.755973] pc : refcount_dec_not_one+0x9c/0xc0
[    5.760710] lr : refcount_dec_not_one+0x9c/0xc0
[    5.765018] sp : ffff000009f8b3a0
[    5.769469] x29: ffff000009f8b3a0 x28: 0000000000000000
[    5.773052] x27: 0000000000000000 x26: 0000000000000001                                    [    5.778428] x25: ffff8000d5347200 x24: ffff0000092f00e0
[    5.783722] x23: ffff0000092efcf8 x22: ffff000008f5d250
[    5.789023] x21: ffff0000094f9000 x20: ffff8000d5347264
[    5.794313] x19: ffff000009637960 x18: ffffffffffffffff
[    5.799605] x17: 0000000000000000 x16: 0000000000000000
[    5.804900] x15: ffff0000094f96c8 x14: 0720072007200720
[    5.810199] x13: 0720072007200720 x12: 0720072007200720
[    5.815491] x11: 0720072007200720 x10: 0720072007200720
[    5.820799] x9 : 0720072007200720 x8 : 072007200720072e
[    5.826081] x7 : 0765076507720766 x6 : ffff8000da028f00
[    5.831377] x5 : 0000000000000000 x4 : 0000000000000000
[    5.836666] x3 : ffffffffffffffff x2 : ffff000009512480
[    5.841971] x1 : a4c264660aaf4100 x0 : 0000000000000000
[    5.847274] Call trace:                                                                    [    5.852544]  refcount_dec_not_one+0x9c/0xc0
[    5.854792]  refcount_dec_and_mutex_lock+0x18/0x70
[    5.859055]  _put_opp_list_kref+0x28/0x50
[    5.863822]  _dev_pm_opp_find_and_remove_table+0x24/0x88
[    5.867996]  _dev_pm_opp_cpumask_remove_table+0x4c/0x98
[    5.873369]  dev_pm_opp_of_cpumask_add_table+0x98/0x100
[    5.878315]  cpufreq_init+0xe4/0x3a8
[    5.883376]  cpufreq_online+0xc4/0x6d0
[    5.887186]  cpufreq_add_dev+0xa8/0xb8
[    5.890835]  subsys_interface_register+0x9c/0x100
[    5.894540]  cpufreq_register_driver+0x190/0x278
[    5.899344]  dt_cpufreq_probe+0xa0/0x1e0
[    5.903969]  platform_drv_probe+0x50/0xa0
[    5.907840]  really_probe+0x260/0x3b8
[    5.911720]  driver_probe_device+0x5c/0x148
[    5.915398]  __device_attach_driver+0xa8/0x160
[    5.919456]  bus_for_each_drv+0x64/0xc8
[    5.923875]  __device_attach+0xd8/0x158
[    5.927625]  device_initial_probe+0x10/0x18
[    5.931450]  bus_probe_device+0x90/0x98
[    5.935650]  device_add+0x440/0x668
[    5.939416]  platform_device_add+0x124/0x2d0
[    5.942977]  platform_device_register_full+0xf8/0x118
[    5.947571]  qcom_cpufreq_kryo_probe+0x27c/0x320
[    5.952445]  platform_drv_probe+0x50/0xa0
[    5.957066]  really_probe+0x260/0x3b8
[    5.960939]  driver_probe_device+0x5c/0x148
[    5.964612]  __device_attach_driver+0xa8/0x160
[    5.968687]  bus_for_each_drv+0x64/0xc8
[    5.973086]  __device_attach+0xd8/0x158
[    5.976831]  device_initial_probe+0x10/0x18
[    5.980657]  bus_probe_device+0x90/0x98
[    5.984824]  deferred_probe_work_func+0x88/0xe0
[    5.988801]  process_one_work+0x1e0/0x318
[    5.993243]  worker_thread+0x228/0x450
[    5.997345]  kthread+0x128/0x130
[    6.000973]  ret_from_fork+0x10/0x18
[    6.004313] ---[ end trace 5715d70f8f823685 ]---


Kind regards,
Niklas

>
> --
> viresh
>
> Viresh Kumar (11):
>   OPP: Free OPP table properly on performance state irregularities
>   OPP: Protect dev_list with opp_table lock
>   OPP: Pass index to _of_init_opp_table()
>   OPP: Parse OPP table's DT properties from _of_init_opp_table()
>   OPP: Don't take OPP table's kref for static OPPs
>   OPP: Create separate kref for static OPPs list
>   cpufreq: mvebu: Remove OPPs using dev_pm_opp_remove()
>   OPP: Don't remove dynamic OPPs from _dev_pm_opp_remove_table()
>   OPP: Use a single mechanism to free the OPP table
>   OPP: Prevent creating multiple OPP tables for devices sharing OPP
>     nodes
>   OPP: Pass OPP table to _of_add_opp_table_v{1|2}()
>
>  drivers/cpufreq/mvebu-cpufreq.c |   9 +-
>  drivers/opp/core.c              | 147 ++++++++++++++++---------
>  drivers/opp/cpu.c               |  11 +-
>  drivers/opp/of.c                | 186 +++++++++++++++++---------------
>  drivers/opp/opp.h               |  19 ++--
>  include/linux/pm_opp.h          |   6 ++
>  6 files changed, 221 insertions(+), 157 deletions(-)
>
> --
> 2.18.0.rc1.242.g61856ae69a2c
>
