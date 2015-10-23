From: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: Re: [GIT PULL] On-demand device probing
Date: Fri, 23 Oct 2015 14:28:58 +0200
Message-ID: <562A280A.3040002@collabora.com>
References: <20151018195330.GB14956@sirena.org.uk>
 <CAAObsKB2BUZ-smid45wOdAQw6h2yNqCydk+azAFNk69ewHJtZQ@mail.gmail.com>
 <5627B677.5090109@gmail.com> <20151021162758.GP32054@sirena.org.uk>
 <5627D6E0.5020708@gmail.com>
 <CAL_Jsq+FPtCuBnte2HTgbdpNYM=v_kLaCRcOC1kMaCQwVC=5Kw@mail.gmail.com>
 <562808AF.7090406@gmail.com>
 <CAAObsKAkyjdvNOS3+nuT0N9sudUFLsZXFtcm6Y038p+HSdsZsg@mail.gmail.com>
 <20151022144405.GC21861@kroah.com> <562930AB.1070203@gmail.com>
 <20151022192639.GC27248@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010301030807040007030702"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151022192639.GC27248-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, =?UTF-8?Q?Terje_Bergstr=c3=b6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones>
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------010301030807040007030702
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit

On 10/22/2015 09:26 PM, Greg Kroah-Hartman wrote:
> On Thu, Oct 22, 2015 at 11:53:31AM -0700, Frank Rowand wrote:
>> On 10/22/2015 7:44 AM, Greg Kroah-Hartman wrote:
>>> <oops, sent too early...>
>>>
>>> On Thu, Oct 22, 2015 at 11:05:11AM +0200, Tomeu Vizoso wrote:
>>>> But that's moot currently because Greg believes that the time spent
>>>> probing devices at boot time could be reduced enough so that the order
>>>> in which devices are probed becomes irrelevant. IME that would have to
>>>> be under 200ms so that the user doesn't notice and that's unicorn-far
>>>> from any bootlog I have ever seen.
>>>
>>> But as no one has actually produced a bootlog, how do you know that?
>>> Where exactly is your time being spent?  What driver is causing long
>>> delays?  Why is the long-delay-drivers not being done in their own
>>> thread?  And most importantly, why are you ignoring the work that people
>>> did back in 2008 to solve the issue on other hardware platforms?
>>>
>>>> Given that downstreams are already carrying as many hacks as they
>>>> could think of to speed total boot up, I think this is effectively
>>>> telling them to go away.
>>>
>>> No I'm not, I'm asking for real data, not hand-wavy-this-is-going-to
>>> solve-the-random-issue-i'm-having type patch by putting random calls in
>>> semi-random subsystems all over the kernel.
>>>
>>> And when I ask for real data, you respond with the fact that you aren't
>>> trying to speed up boot time here at all, so what am I supposed to think
>>
>> I also had the understanding that this patch series was about improving
>> boot time.  But I was kindly corrected that the behavior change was
>> getting the panel displaying stuff at an earlier point in the boot sequence,
>> _not_ completing the entire boot faster. 
>>
>> The claim for the current series, in patch 0 in v7 is:
>>
>>    With this series I get the kernel to output to the panel in 0.5s,
>>    instead of 2.8s.
>>
>> Just to get side-tracked, one other approach at ordering to reduce
>> deferrals reported a modest boot time reduction for four boards and a
>> very slight boot time increase for one other board.) The report of boot
>> times with that approach was in:
>>
>>   http://article.gmane.org/gmane.linux.drivers.devicetree/133010
>>
>> from Alexander Holler.
>>
>> I have not searched further to see if there is more data of boot time
>> reductions from any of the other attempts to change driver binding
>> order to move dependencies before use of a resource.  But whether
>> there is a performance improvement or not, there continues to be
>> a stream of developers creatively impacting the binding order for
>> their specific driver(s) or board.  So it seems that maybe there
>> is an underlying problem, or we don't have adequate documentation
>> explaining how to avoid a need to order bindings, or the
>> documentation exists and is not being read.
>>
>> I have been defaulting to the position that has been asserted by
>> the device tree maintainters, that probe deferrals work just fine
>> for at least the majority of cases (and is the message I have been
>> sharing in my conference presentations about device tree).  But I
>> suspect that there is at least a small minority of cases that are not
>> well served by probe deferral.  (Not to be read as an endorsement of
>> this specific patch series, just a generic observation.)
> 
> I agree, there might be some small numbers that this is a problem for,
> and if so, great, show us the boot logs where things are taking up all
> of the time, and we can work on resolving those issues.
> 
> But without hard numbers / details, this all is just random hand-waving,
> and I don't like making core kernel changes on that basis.  And no one
> else should ever want us to do that either.

Hi,

have found the board in which Stéphane had the original issue on
(exynos5250-snow), and I'm attaching the bootlog of
next-20151013+exynos_defconfig with initcall_debug and DEBUG in dd.c.

As can be seen, 145b0000.dp-controller is tried reasonably early (at
0.25s), but is deferred and only retried at 0.9s, with the display
finally coming up at 1.35s.

But I'm not sure what's the point in discussing this further if you have
already said that it's fine if downstreams have to change the probing
order by moving files around in the makefiles and by fiddling with
initcall levels.

To give a better understanding of what's going on here, I wasn't
involved in the bringup of this board, but was tasked with fixing this
issue in mainline so it doesn't have to be worked around in every product.

Regards,

Tomeu

> thanks,
> 
> greg k-h
> 


--------------010301030807040007030702
Content-Type: text/plain; charset=UTF-8;
 name="snow.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="snow.txt"

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.3.0-rc5-next-20151013-dirty (tomeu@cizrna)=
 (gcc version 5.2.1 20150716 (Red Hat Cross 5.2.1-3) (GCC) ) #3491 SMP PR=
EEMPT Fri Oct 23 11:17:16 CEST 2015
[    0.000000] CPU: ARMv7 Processor [410fc0f4] revision 4 (ARMv7), cr=3D1=
0c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction =
cache
[    0.000000] Machine model: Google Snow
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] cma: Reserved 64 MiB at 0xbc000000
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] Samsung CPU ID: 0x43520010
[    0.000000] On node 0 totalpages: 524288
[    0.000000] free_area_init_node: node 0, pgdat c083cc40, node_mem_map =
eeff7000
[    0.000000]   Normal zone: 1536 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 196608 pages, LIFO batch:31
[    0.000000]   HighMem zone: 327680 pages, LIFO batch:31
[    0.000000] PERCPU: Embedded 12 pages/cpu @eefa7000 s18880 r8192 d2208=
0 u49152
[    0.000000] pcpu-alloc: s18880 r8192 d22080 u49152 alloc=3D12*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1=20
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  To=
tal pages: 522752
[    0.000000] Kernel command line: console=3Dtty1 initcall_debug rw root=
wait root=3D/dev/nfs nfsroot=3D10.42.0.1:/home/tomeu/nfsroot,vers=3D3 ip=3D=
dhcp ignore_loglevel log_buf_len=3D16M drm.debug=3D0x00 no_console_suspen=
d
[    0.000000] log_buf_len: 16777216 bytes
[    0.000000] early log buf free: 129580(98%)
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 =
bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 by=
tes)
[    0.000000] Memory: 1988920K/2097152K available (5722K kernel code, 23=
8K rwdata, 2016K rodata, 428K init, 315K bss, 42696K reserved, 65536K cma=
-reserved, 1245184K highmem)
[    0.000000] Virtual kernel memory layout:
                   vector  : 0xffff0000 - 0xffff1000   (   4 kB)
                   fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
                   vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
                   lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
                   pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
                   modules : 0xbf000000 - 0xbfe00000   (  14 MB)
                     .text : 0xc0008000 - 0xc0796ad4   (7739 kB)
                     .init : 0xc0797000 - 0xc0802000   ( 428 kB)
                     .data : 0xc0802000 - 0xc083dbc0   ( 239 kB)
                      .bss : 0xc0840000 - 0xc088ec90   ( 316 kB)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D2,=
 Nodes=3D1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 32.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=3D8 to nr_cpu_ids=3D2.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D32, nr_cpu_i=
ds=3D2
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] GIC physical location is 0x10481000
[    0.000000] L2C: failed to init: -19
[    0.000000] Exynos5250: clock setup completed, armclk=3D1700000000
[    0.000000] Architected cp15 timer(s) running at 24.00MHz (virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_=
cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000002] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps ever=
y 4398046511097ns
[    0.000009] Switching to timer-based delay loop, resolution 41ns
[    0.000170] Ignoring duplicate/late registration of read_current_timer=
 delay
[    0.000178] clocksource: mct-frc: mask: 0xffffffff max_cycles: 0xfffff=
fff, max_idle_ns: 79635851949 ns
[    0.000187] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps ever=
y 89478484971ns
[    0.000484] Console: colour dummy device 80x30
[    0.000824] console [tty1] enabled
[    0.000838] Calibrating delay loop (skipped), value calculated using t=
imer frequency.. 48.00 BogoMIPS (lpj=3D120000)
[    0.000858] pid_max: default: 32768 minimum: 301
[    0.000937] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes=
)
[    0.000950] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 =
bytes)
[    0.001289] CPU: Testing write buffer coherency: ok
[    0.001421] CPU0: update cpu_capacity 1024
[    0.001433] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.001492] calling  cpu_suspend_alloc_sp+0x0/0x9c @ 1
[    0.001507] initcall cpu_suspend_alloc_sp+0x0/0x9c returned 0 after 0 =
usecs
[    0.001527] calling  init_static_idmap+0x0/0x114 @ 1
[    0.001545] Setting up static identity map for 0x40008280 - 0x400082d8=

[    0.001564] initcall init_static_idmap+0x0/0x114 returned 0 after 0 us=
ecs
[    0.001583] calling  exynos_mcpm_init+0x0/0x168 @ 1
[    0.001729] initcall exynos_mcpm_init+0x0/0x168 returned -19 after 0 u=
secs
[    0.001747] calling  spawn_ksoftirqd+0x0/0x34 @ 1
[    0.004936] initcall spawn_ksoftirqd+0x0/0x34 returned 0 after 4882 us=
ecs
[    0.004955] calling  init_workqueues+0x0/0x3dc @ 1
[    0.019997] initcall init_workqueues+0x0/0x3dc returned 0 after 14648 =
usecs
[    0.020016] calling  migration_init+0x0/0x6c @ 1
[    0.020034] initcall migration_init+0x0/0x6c returned 0 after 0 usecs
[    0.020049] calling  check_cpu_stall_init+0x0/0x20 @ 1
[    0.020062] initcall check_cpu_stall_init+0x0/0x20 returned 0 after 0 =
usecs
[    0.020077] calling  rcu_spawn_gp_kthread+0x0/0x104 @ 1
[    0.020195] initcall rcu_spawn_gp_kthread+0x0/0x104 returned 0 after 0=
 usecs
[    0.020213] calling  cpu_stop_init+0x0/0xac @ 1
[    0.024982] initcall cpu_stop_init+0x0/0xac returned 0 after 4882 usec=
s
[    0.025000] calling  cci_init+0x0/0x18 @ 1
[    0.025080] initcall cci_init+0x0/0x18 returned -19 after 0 usecs
[    0.025098] calling  rand_initialize+0x0/0x2c @ 1
[    0.025214] initcall rand_initialize+0x0/0x2c returned 0 after 0 usecs=

[    0.025232] calling  dummy_timer_register+0x0/0x48 @ 1
[    0.025247] initcall dummy_timer_register+0x0/0x48 returned 0 after 0 =
usecs
[    0.045065] CPU1: update cpu_capacity 1024
[    0.045069] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.045119] Brought up 2 CPUs
[    0.045146] SMP: Total of 2 processors activated (96.00 BogoMIPS).
[    0.045156] CPU: All CPU(s) started in SVC mode.
[    0.045767] devtmpfs: initialized
[    0.055547] calling  ipc_ns_init+0x0/0x3c @ 1
[    0.055566] initcall ipc_ns_init+0x0/0x3c returned 0 after 0 usecs
[    0.055580] calling  init_mmap_min_addr+0x0/0x20 @ 1
[    0.055592] initcall init_mmap_min_addr+0x0/0x20 returned 0 after 0 us=
ecs
[    0.055608] calling  init_cpufreq_transition_notifier_list+0x0/0x24 @ =
1
[    0.055625] initcall init_cpufreq_transition_notifier_list+0x0/0x24 re=
turned 0 after 0 usecs
[    0.055647] calling  net_ns_init+0x0/0x14c @ 1
[    0.055754] initcall net_ns_init+0x0/0x14c returned 0 after 0 usecs
[    0.055833] calling  vfp_init+0x0/0x1b8 @ 1
[    0.055847] VFP support v0.3: implementor 41 architecture 4 part 30 va=
riant f rev 0
[    0.055871] initcall vfp_init+0x0/0x1b8 returned 0 after 0 usecs
[    0.055885] calling  ptrace_break_init+0x0/0x2c @ 1
[    0.055898] initcall ptrace_break_init+0x0/0x2c returned 0 after 0 use=
cs
[    0.055913] calling  register_cpufreq_notifier+0x0/0x10 @ 1
[    0.055926] initcall register_cpufreq_notifier+0x0/0x10 returned 0 aft=
er 0 usecs
[    0.055945] calling  v6_userpage_init+0x0/0x8 @ 1
[    0.055957] initcall v6_userpage_init+0x0/0x8 returned 0 after 0 usecs=

[    0.055973] calling  exynos4_pm_init_power_domain+0x0/0x2e0 @ 1
[    0.056176] initcall exynos4_pm_init_power_domain+0x0/0x2e0 returned 0=
 after 0 usecs
[    0.056197] calling  cpu_hotplug_pm_sync_init+0x0/0x18 @ 1
[    0.056210] initcall cpu_hotplug_pm_sync_init+0x0/0x18 returned 0 afte=
r 0 usecs
[    0.056230] calling  alloc_frozen_cpus+0x0/0x8 @ 1
[    0.056241] initcall alloc_frozen_cpus+0x0/0x8 returned 0 after 0 usec=
s
[    0.056257] calling  wq_sysfs_init+0x0/0x30 @ 1
[    0.056444] initcall wq_sysfs_init+0x0/0x30 returned 0 after 0 usecs
[    0.056462] calling  ksysfs_init+0x0/0xa4 @ 1
[    0.056494] initcall ksysfs_init+0x0/0xa4 returned 0 after 0 usecs
[    0.056511] calling  pm_init+0x0/0x78 @ 1
[    0.056565] initcall pm_init+0x0/0x78 returned 0 after 0 usecs
[    0.056579] calling  init_jiffies_clocksource+0x0/0x14 @ 1
[    0.056592] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffff=
fff, max_idle_ns: 9556302231375000 ns
[    0.056610] initcall init_jiffies_clocksource+0x0/0x14 returned 0 afte=
r 0 usecs
[    0.056628] calling  cgroup_wq_init+0x0/0x80 @ 1
[    0.056665] initcall cgroup_wq_init+0x0/0x80 returned 0 after 0 usecs
[    0.056680] calling  cpu_pm_init+0x0/0x18 @ 1
[    0.056692] initcall cpu_pm_init+0x0/0x18 returned 0 after 0 usecs
[    0.056707] calling  init_zero_pfn+0x0/0x40 @ 1
[    0.056718] initcall init_zero_pfn+0x0/0x40 returned 0 after 0 usecs
[    0.056734] calling  cma_init_reserved_areas+0x0/0x1d4 @ 1
[    0.057256] initcall cma_init_reserved_areas+0x0/0x1d4 returned 0 afte=
r 0 usecs
[    0.057278] calling  fsnotify_init+0x0/0x24 @ 1
[    0.057294] initcall fsnotify_init+0x0/0x24 returned 0 after 0 usecs
[    0.057310] calling  filelock_init+0x0/0xc4 @ 1
[    0.057335] initcall filelock_init+0x0/0xc4 returned 0 after 0 usecs
[    0.057351] calling  init_script_binfmt+0x0/0x1c @ 1
[    0.057364] initcall init_script_binfmt+0x0/0x1c returned 0 after 0 us=
ecs
[    0.057379] calling  init_elf_binfmt+0x0/0x1c @ 1
[    0.057391] initcall init_elf_binfmt+0x0/0x1c returned 0 after 0 usecs=

[    0.057407] calling  configfs_init+0x0/0xb0 @ 1
[    0.057437] initcall configfs_init+0x0/0xb0 returned 0 after 0 usecs
[    0.057451] calling  debugfs_init+0x0/0x68 @ 1
[    0.057467] initcall debugfs_init+0x0/0x68 returned 0 after 0 usecs
[    0.057480] calling  securityfs_init+0x0/0x58 @ 1
[    0.057495] initcall securityfs_init+0x0/0x58 returned 0 after 0 usecs=

[    0.057509] calling  prandom_init+0x0/0xe4 @ 1
[    0.057521] initcall prandom_init+0x0/0xe4 returned 0 after 0 usecs
[    0.057535] calling  cci_platform_init+0x0/0x8 @ 1
[    0.057546] initcall cci_platform_init+0x0/0x8 returned 0 after 0 usec=
s
[    0.057560] calling  pinctrl_init+0x0/0xd4 @ 1
[    0.057569] pinctrl core: initialized pinctrl subsystem
[    0.057622] initcall pinctrl_init+0x0/0xd4 returned 0 after 0 usecs
[    0.057638] calling  regulator_init+0x0/0xa4 @ 1
[    0.057836] bus: 'platform': driver_probe_device: matched device reg-d=
ummy with driver reg-dummy
[    0.057855] bus: 'platform': really_probe: probing driver reg-dummy wi=
th device reg-dummy
[    0.058019] driver: 'reg-dummy': driver_bound: bound to device 'reg-du=
mmy'
[    0.058033] bus: 'platform': really_probe: bound device reg-dummy to d=
river reg-dummy
[    0.058097] initcall regulator_init+0x0/0xa4 returned 0 after 0 usecs
[    0.058114] calling  cpufreq_core_init+0x0/0x50 @ 1
[    0.058126] initcall cpufreq_core_init+0x0/0x50 returned 0 after 0 use=
cs
[    0.058140] calling  cpuidle_init+0x0/0x58 @ 1
[    0.058163] initcall cpuidle_init+0x0/0x58 returned 0 after 0 usecs
[    0.058177] calling  cpuidle_coupled_init+0x0/0xc @ 1
[    0.058190] initcall cpuidle_coupled_init+0x0/0xc returned 0 after 0 u=
secs
[    0.058207] calling  exynos_audss_clk_init+0x0/0x10 @ 1
[    0.058265] initcall exynos_audss_clk_init+0x0/0x10 returned 0 after 0=
 usecs
[    0.058282] calling  sock_init+0x0/0x94 @ 1
[    0.058334] initcall sock_init+0x0/0x94 returned 0 after 0 usecs
[    0.058351] calling  net_inuse_init+0x0/0x24 @ 1
[    0.058365] initcall net_inuse_init+0x0/0x24 returned 0 after 0 usecs
[    0.058379] calling  netlink_proto_init+0x0/0x148 @ 1
[    0.058490] NET: Registered protocol family 16
[    0.058519] initcall netlink_proto_init+0x0/0x148 returned 0 after 0 u=
secs
[    0.058604] calling  atomic_pool_init+0x0/0x168 @ 1
[    0.059145] DMA: preallocated 256 KiB pool for atomic coherent allocat=
ions
[    0.059160] initcall atomic_pool_init+0x0/0x168 returned 0 after 0 use=
cs
[    0.059177] calling  exynos_pmu_init+0x0/0x10 @ 1
[    0.059247] initcall exynos_pmu_init+0x0/0x10 returned 0 after 0 usecs=

[    0.059265] calling  bdi_class_init+0x0/0x5c @ 1
[    0.059317] initcall bdi_class_init+0x0/0x5c returned 0 after 0 usecs
[    0.059333] calling  mm_sysfs_init+0x0/0x38 @ 1
[    0.059349] initcall mm_sysfs_init+0x0/0x38 returned 0 after 0 usecs
[    0.059364] calling  kobject_uevent_init+0x0/0xc @ 1
[    0.059383] initcall kobject_uevent_init+0x0/0xc returned 0 after 0 us=
ecs
[    0.059398] calling  samsung_pinctrl_drv_register+0x0/0x24 @ 1
[    0.059457] initcall samsung_pinctrl_drv_register+0x0/0x24 returned 0 =
after 0 usecs
[    0.059477] calling  exynos5440_pinctrl_drv_register+0x0/0x10 @ 1
[    0.059533] initcall exynos5440_pinctrl_drv_register+0x0/0x10 returned=
 0 after 0 usecs
[    0.059553] calling  lcd_class_init+0x0/0x58 @ 1
[    0.059601] initcall lcd_class_init+0x0/0x58 returned 0 after 0 usecs
[    0.059616] calling  backlight_class_init+0x0/0xa4 @ 1
[    0.059661] initcall backlight_class_init+0x0/0xa4 returned 0 after 0 =
usecs
[    0.059677] calling  amba_init+0x0/0xc @ 1
[    0.059741] initcall amba_init+0x0/0xc returned 0 after 0 usecs
[    0.059757] calling  tty_class_init+0x0/0x40 @ 1
[    0.059800] initcall tty_class_init+0x0/0x40 returned 0 after 0 usecs
[    0.059817] calling  vtconsole_class_init+0x0/0xec @ 1
[    0.059947] initcall vtconsole_class_init+0x0/0xec returned 0 after 0 =
usecs
[    0.059965] calling  mipi_dsi_bus_init+0x0/0xc @ 1
[    0.060052] initcall mipi_dsi_bus_init+0x0/0xc returned 0 after 4882 u=
secs
[    0.060070] calling  wakeup_sources_debugfs_init+0x0/0x38 @ 1
[    0.060104] initcall wakeup_sources_debugfs_init+0x0/0x38 returned 0 a=
fter 0 usecs
[    0.060123] calling  regmap_initcall+0x0/0x10 @ 1
[    0.060141] initcall regmap_initcall+0x0/0x10 returned 0 after 0 usecs=

[    0.060157] calling  sram_init+0x0/0x10 @ 1
[    0.060218] initcall sram_init+0x0/0x10 returned 0 after 0 usecs
[    0.060235] calling  syscon_init+0x0/0x10 @ 1
[    0.060291] initcall syscon_init+0x0/0x10 returned 0 after 0 usecs
[    0.060307] calling  spi_init+0x0/0x94 @ 1
[    0.060403] initcall spi_init+0x0/0x94 returned 0 after 0 usecs
[    0.060418] calling  i2c_init+0x0/0xb8 @ 1
[    0.060538] initcall i2c_init+0x0/0xb8 returned 0 after 0 usecs
[    0.060553] calling  init_ladder+0x0/0xc @ 1
[    0.075090] cpuidle: using governor ladder
[    0.075103] initcall init_ladder+0x0/0xc returned 0 after 14648 usecs
[    0.075116] calling  init_menu+0x0/0xc @ 1
[    0.095118] cpuidle: using governor menu
[    0.095131] initcall init_menu+0x0/0xc returned 0 after 19531 usecs
[    0.095207] calling  gate_vma_init+0x0/0x24 @ 1
[    0.095219] initcall gate_vma_init+0x0/0x24 returned 0 after 0 usecs
[    0.095233] calling  customize_machine+0x0/0x40 @ 1
[    0.097232] bus: 'platform': driver_probe_device: matched device 20200=
00.sysram with driver sram
[    0.097251] bus: 'platform': really_probe: probing driver sram with de=
vice 2020000.sysram
[    0.097318] driver: 'sram': driver_bound: bound to device '2020000.sys=
ram'
[    0.097332] bus: 'platform': really_probe: bound device 2020000.sysram=
 to driver sram
[    0.097885] bus: 'platform': driver_probe_device: matched device 38100=
00.audss-clock-controller with driver exynos-audss-clk
[    0.097903] bus: 'platform': really_probe: probing driver exynos-audss=
-clk with device 3810000.audss-clock-controller
[    0.098183] exynos-audss-clk 3810000.audss-clock-controller: setup com=
pleted
[    0.098197] driver: 'exynos-audss-clk': driver_bound: bound to device =
'3810000.audss-clock-controller'
[    0.098213] bus: 'platform': really_probe: bound device 3810000.audss-=
clock-controller to driver exynos-audss-clk
[    0.098911] bus: 'platform': driver_probe_device: matched device 11400=
000.pinctrl with driver samsung-pinctrl
[    0.098929] bus: 'platform': really_probe: probing driver samsung-pinc=
trl with device 11400000.pinctrl
[    0.099063] gpiochip_add: registered GPIOs 0 to 7 on device: gpa0
[    0.099077] gpiochip_add: registered GPIOs 8 to 13 on device: gpa1
[    0.099090] gpiochip_add: registered GPIOs 14 to 21 on device: gpa2
[    0.099102] gpiochip_add: registered GPIOs 22 to 26 on device: gpb0
[    0.099114] gpiochip_add: registered GPIOs 27 to 31 on device: gpb1
[    0.099127] gpiochip_add: registered GPIOs 32 to 35 on device: gpb2
[    0.099138] gpiochip_add: registered GPIOs 36 to 39 on device: gpb3
[    0.099150] gpiochip_add: registered GPIOs 40 to 46 on device: gpc0
[    0.099162] gpiochip_add: registered GPIOs 47 to 50 on device: gpc1
[    0.099177] gpiochip_add: registered GPIOs 51 to 57 on device: gpc2
[    0.099188] gpiochip_add: registered GPIOs 58 to 64 on device: gpc3
[    0.099201] gpiochip_add: registered GPIOs 65 to 68 on device: gpd0
[    0.099213] gpiochip_add: registered GPIOs 69 to 76 on device: gpd1
[    0.099225] gpiochip_add: registered GPIOs 77 to 83 on device: gpc4
[    0.099237] gpiochip_add: registered GPIOs 84 to 89 on device: gpy0
[    0.099249] gpiochip_add: registered GPIOs 90 to 93 on device: gpy1
[    0.099261] gpiochip_add: registered GPIOs 94 to 99 on device: gpy2
[    0.099274] gpiochip_add: registered GPIOs 100 to 107 on device: gpy3
[    0.099286] gpiochip_add: registered GPIOs 108 to 115 on device: gpy4
[    0.099298] gpiochip_add: registered GPIOs 116 to 123 on device: gpy5
[    0.099311] gpiochip_add: registered GPIOs 124 to 131 on device: gpy6
[    0.099323] gpiochip_add: registered GPIOs 132 to 139 on device: gpx0
[    0.099336] gpiochip_add: registered GPIOs 140 to 147 on device: gpx1
[    0.099348] gpiochip_add: registered GPIOs 148 to 155 on device: gpx2
[    0.099360] gpiochip_add: registered GPIOs 156 to 163 on device: gpx3
[    0.100001] driver: 'samsung-pinctrl': driver_bound: bound to device '=
11400000.pinctrl'
[    0.100019] bus: 'platform': really_probe: bound device 11400000.pinct=
rl to driver samsung-pinctrl
[    0.100207] bus: 'platform': driver_probe_device: matched device 13400=
000.pinctrl with driver samsung-pinctrl
[    0.100225] bus: 'platform': really_probe: probing driver samsung-pinc=
trl with device 13400000.pinctrl
[    0.100290] gpiochip_add: registered GPIOs 164 to 171 on device: gpe0
[    0.100304] gpiochip_add: registered GPIOs 172 to 173 on device: gpe1
[    0.100317] gpiochip_add: registered GPIOs 174 to 177 on device: gpf0
[    0.100330] gpiochip_add: registered GPIOs 178 to 181 on device: gpf1
[    0.100342] gpiochip_add: registered GPIOs 182 to 189 on device: gpg0
[    0.100355] gpiochip_add: registered GPIOs 190 to 197 on device: gpg1
[    0.100367] gpiochip_add: registered GPIOs 198 to 199 on device: gpg2
[    0.100379] gpiochip_add: registered GPIOs 200 to 203 on device: gph0
[    0.100392] gpiochip_add: registered GPIOs 204 to 211 on device: gph1
[    0.100580] driver: 'samsung-pinctrl': driver_bound: bound to device '=
13400000.pinctrl'
[    0.100597] bus: 'platform': really_probe: bound device 13400000.pinct=
rl to driver samsung-pinctrl
[    0.100751] bus: 'platform': driver_probe_device: matched device 10d10=
000.pinctrl with driver samsung-pinctrl
[    0.100769] bus: 'platform': really_probe: probing driver samsung-pinc=
trl with device 10d10000.pinctrl
[    0.100825] gpiochip_add: registered GPIOs 212 to 219 on device: gpv0
[    0.100838] gpiochip_add: registered GPIOs 220 to 227 on device: gpv1
[    0.100851] gpiochip_add: registered GPIOs 228 to 235 on device: gpv2
[    0.100863] gpiochip_add: registered GPIOs 236 to 243 on device: gpv3
[    0.100876] gpiochip_add: registered GPIOs 244 to 245 on device: gpv4
[    0.101006] driver: 'samsung-pinctrl': driver_bound: bound to device '=
10d10000.pinctrl'
[    0.101023] bus: 'platform': really_probe: bound device 10d10000.pinct=
rl to driver samsung-pinctrl
[    0.101175] bus: 'platform': driver_probe_device: matched device 38600=
00.pinctrl with driver samsung-pinctrl
[    0.101192] bus: 'platform': really_probe: probing driver samsung-pinc=
trl with device 3860000.pinctrl
[    0.101237] gpiochip_add: registered GPIOs 246 to 252 on device: gpz
[    0.101330] driver: 'samsung-pinctrl': driver_bound: bound to device '=
3860000.pinctrl'
[    0.101347] bus: 'platform': really_probe: bound device 3860000.pinctr=
l to driver samsung-pinctrl
[    0.101472] bus: 'platform': driver_probe_device: matched device 10040=
000.system-controller with driver exynos-pmu
[    0.101490] bus: 'platform': really_probe: probing driver exynos-pmu w=
ith device 10040000.system-controller
[    0.101531] driver: 'exynos-pmu': driver_bound: bound to device '10040=
000.system-controller'
[    0.101547] bus: 'platform': really_probe: bound device 10040000.syste=
m-controller to driver exynos-pmu
[    0.109998] initcall customize_machine+0x0/0x40 returned 0 after 9765 =
usecs
[    0.110020] calling  vdso_init+0x0/0x1a4 @ 1
[    0.110049] initcall vdso_init+0x0/0x1a4 returned 0 after 0 usecs
[    0.110064] calling  exceptions_init+0x0/0x9c @ 1
[    0.110077] initcall exceptions_init+0x0/0x9c returned 0 after 0 usecs=

[    0.110093] calling  s3c_arch_init+0x0/0x40 @ 1
[    0.110106] initcall s3c_arch_init+0x0/0x40 returned 0 after 0 usecs
[    0.110121] calling  dma_bus_init+0x0/0xa8 @ 1
[    0.110212] initcall dma_bus_init+0x0/0xa8 returned 0 after 0 usecs
[    0.110230] calling  dma_channel_table_init+0x0/0xf0 @ 1
[    0.110255] initcall dma_channel_table_init+0x0/0xf0 returned 0 after =
0 usecs
[    0.110337] calling  topology_init+0x0/0x74 @ 1
[    0.110517] initcall topology_init+0x0/0x74 returned 0 after 0 usecs
[    0.110535] calling  uid_cache_init+0x0/0xa4 @ 1
[    0.110550] initcall uid_cache_init+0x0/0xa4 returned 0 after 0 usecs
[    0.110567] calling  param_sysfs_init+0x0/0x1d8 @ 1
[    0.119328] initcall param_sysfs_init+0x0/0x1d8 returned 0 after 4882 =
usecs
[    0.119354] calling  pm_sysrq_init+0x0/0x1c @ 1
[    0.130217] initcall pm_sysrq_init+0x0/0x1c returned 0 after 14648 use=
cs
[    0.130237] calling  hung_task_init+0x0/0x58 @ 1
[    0.130296] initcall hung_task_init+0x0/0x58 returned 0 after 0 usecs
[    0.130312] calling  default_bdi_init+0x0/0x58 @ 1
[    0.130493] initcall default_bdi_init+0x0/0x58 returned 0 after 0 usec=
s
[    0.130510] calling  percpu_enable_async+0x0/0x18 @ 1
[    0.130522] initcall percpu_enable_async+0x0/0x18 returned 0 after 0 u=
secs
[    0.130539] calling  init_reserve_notifier+0x0/0x8 @ 1
[    0.130552] initcall init_reserve_notifier+0x0/0x8 returned 0 after 0 =
usecs
[    0.130573] calling  init_admin_reserve+0x0/0x30 @ 1
[    0.130586] initcall init_admin_reserve+0x0/0x30 returned 0 after 0 us=
ecs
[    0.130602] calling  init_user_reserve+0x0/0x30 @ 1
[    0.130614] initcall init_user_reserve+0x0/0x30 returned 0 after 0 use=
cs
[    0.130628] calling  crypto_wq_init+0x0/0x44 @ 1
[    0.130696] initcall crypto_wq_init+0x0/0x44 returned 0 after 0 usecs
[    0.130711] calling  cryptomgr_init+0x0/0xc @ 1
[    0.130722] initcall cryptomgr_init+0x0/0xc returned 0 after 0 usecs
[    0.130735] calling  init_bio+0x0/0xc0 @ 1
[    0.130824] initcall init_bio+0x0/0xc0 returned 0 after 0 usecs
[    0.130839] calling  blk_settings_init+0x0/0x38 @ 1
[    0.130850] initcall blk_settings_init+0x0/0x38 returned 0 after 0 use=
cs
[    0.130863] calling  blk_ioc_init+0x0/0x40 @ 1
[    0.130877] initcall blk_ioc_init+0x0/0x40 returned 0 after 0 usecs
[    0.130890] calling  blk_softirq_init+0x0/0x80 @ 1
[    0.130903] initcall blk_softirq_init+0x0/0x80 returned 0 after 0 usec=
s
[    0.130917] calling  blk_iopoll_setup+0x0/0x80 @ 1
[    0.130928] initcall blk_iopoll_setup+0x0/0x80 returned 0 after 0 usec=
s
[    0.130941] calling  blk_mq_init+0x0/0x1c @ 1
[    0.130953] initcall blk_mq_init+0x0/0x1c returned 0 after 0 usecs
[    0.130967] calling  genhd_device_init+0x0/0x80 @ 1
[    0.131085] initcall genhd_device_init+0x0/0x80 returned 0 after 0 use=
cs
[    0.131102] calling  gpiolib_debugfs_init+0x0/0x38 @ 1
[    0.131123] initcall gpiolib_debugfs_init+0x0/0x38 returned 0 after 0 =
usecs
[    0.131138] calling  pwm_debugfs_init+0x0/0x38 @ 1
[    0.131153] initcall pwm_debugfs_init+0x0/0x38 returned 0 after 0 usec=
s
[    0.131168] calling  pwm_sysfs_init+0x0/0x14 @ 1
[    0.131215] initcall pwm_sysfs_init+0x0/0x14 returned 0 after 0 usecs
[    0.131230] calling  fbmem_init+0x0/0xb4 @ 1
[    0.131285] initcall fbmem_init+0x0/0xb4 returned 0 after 0 usecs
[    0.131302] calling  regulator_fixed_voltage_init+0x0/0x10 @ 1
[    0.131427] bus: 'platform': driver_probe_device: matched device vbat-=
fixed-regulator with driver reg-fixed-voltage
[    0.131445] bus: 'platform': really_probe: probing driver reg-fixed-vo=
ltage with device vbat-fixed-regulator
[    0.131498] of_get_named_gpiod_flags: can't parse 'gpio' property of n=
ode '/vbat-fixed-regulator[0]'
[    0.131664] driver: 'reg-fixed-voltage': driver_bound: bound to device=
 'vbat-fixed-regulator'
[    0.131682] bus: 'platform': really_probe: bound device vbat-fixed-reg=
ulator to driver reg-fixed-voltage
[    0.131704] bus: 'platform': driver_probe_device: matched device regul=
ator-usb3 with driver reg-fixed-voltage
[    0.131722] bus: 'platform': really_probe: probing driver reg-fixed-vo=
ltage with device regulator-usb3
[    0.131832] of_get_named_gpiod_flags: parsed 'gpio' property of node '=
/regulator-usb3[0]' - status (0)
[    0.132003] driver: 'reg-fixed-voltage': driver_bound: bound to device=
 'regulator-usb3'
[    0.132021] bus: 'platform': really_probe: bound device regulator-usb3=
 to driver reg-fixed-voltage
[    0.132089] initcall regulator_fixed_voltage_init+0x0/0x10 returned 0 =
after 0 usecs
[    0.132109] calling  gpio_regulator_init+0x0/0x10 @ 1
[    0.132241] initcall gpio_regulator_init+0x0/0x10 returned 0 after 0 u=
secs
[    0.132258] calling  max14577_regulator_init+0x0/0x10 @ 1
[    0.132344] initcall max14577_regulator_init+0x0/0x10 returned 0 after=
 0 usecs
[    0.132364] calling  max8997_pmic_init+0x0/0x10 @ 1
[    0.132445] initcall max8997_pmic_init+0x0/0x10 returned 0 after 0 use=
cs
[    0.132461] calling  max77686_pmic_init+0x0/0x10 @ 1
[    0.132548] initcall max77686_pmic_init+0x0/0x10 returned 0 after 0 us=
ecs
[    0.132564] calling  max77693_pmic_init+0x0/0x10 @ 1
[    0.132650] initcall max77693_pmic_init+0x0/0x10 returned 0 after 0 us=
ecs
[    0.132666] calling  s2mps11_pmic_init+0x0/0x10 @ 1
[    0.132751] initcall s2mps11_pmic_init+0x0/0x10 returned 0 after 0 use=
cs
[    0.132767] calling  s5m8767_pmic_init+0x0/0x10 @ 1
[    0.132850] initcall s5m8767_pmic_init+0x0/0x10 returned 0 after 0 use=
cs
[    0.132866] calling  tps65090_regulator_init+0x0/0x10 @ 1
[    0.132952] initcall tps65090_regulator_init+0x0/0x10 returned 0 after=
 0 usecs
[    0.132972] calling  misc_init+0x0/0xe0 @ 1
[    0.133025] initcall misc_init+0x0/0xe0 returned 0 after 0 usecs
[    0.133040] calling  tpm_init+0x0/0x8c @ 1
[    0.133086] initcall tpm_init+0x0/0x8c returned 0 after 0 usecs
[    0.133104] calling  max14577_i2c_init+0x0/0x10 @ 1
[    0.133160] initcall max14577_i2c_init+0x0/0x10 returned 0 after 0 use=
cs
[    0.133177] calling  max77686_i2c_init+0x0/0x10 @ 1
[    0.133232] initcall max77686_i2c_init+0x0/0x10 returned 0 after 0 use=
cs
[    0.133249] calling  max77693_i2c_init+0x0/0x10 @ 1
[    0.133303] initcall max77693_i2c_init+0x0/0x10 returned 0 after 0 use=
cs
[    0.133320] calling  max8997_i2c_init+0x0/0x10 @ 1
[    0.133375] initcall max8997_i2c_init+0x0/0x10 returned 0 after 0 usec=
s
[    0.133392] calling  tps65090_init+0x0/0x10 @ 1
[    0.133447] initcall tps65090_init+0x0/0x10 returned 0 after 0 usecs
[    0.133463] calling  sec_pmic_init+0x0/0x10 @ 1
[    0.133518] initcall sec_pmic_init+0x0/0x10 returned 0 after 0 usecs
[    0.133534] calling  dma_buf_init+0x0/0x84 @ 1
[    0.133555] initcall dma_buf_init+0x0/0x84 returned 0 after 0 usecs
[    0.133571] calling  init_scsi+0x0/0x8c @ 1
[    0.133795] SCSI subsystem initialized
[    0.133810] initcall init_scsi+0x0/0x8c returned 0 after 0 usecs
[    0.133826] calling  phy_init+0x0/0x3c @ 1
[    0.134005] initcall phy_init+0x0/0x3c returned 0 after 0 usecs
[    0.134022] calling  usb_init+0x0/0x17c @ 1
[    0.134159] usbcore: registered new interface driver usbfs
[    0.134230] usbcore: registered new interface driver hub
[    0.134308] usbcore: registered new device driver usb
[    0.134322] initcall usb_init+0x0/0x17c returned 0 after 0 usecs
[    0.134339] calling  usb_udc_init+0x0/0x58 @ 1
[    0.134384] initcall usb_udc_init+0x0/0x58 returned 0 after 0 usecs
[    0.134398] calling  serio_init+0x0/0x30 @ 1
[    0.134459] initcall serio_init+0x0/0x30 returned 0 after 0 usecs
[    0.134473] calling  input_init+0x0/0x11c @ 1
[    0.134525] initcall input_init+0x0/0x11c returned 0 after 0 usecs
[    0.134539] calling  rtc_init+0x0/0x58 @ 1
[    0.134584] initcall rtc_init+0x0/0x58 returned 0 after 0 usecs
[    0.134598] calling  i2c_gpio_init+0x0/0x34 @ 1
[    0.134740] initcall i2c_gpio_init+0x0/0x34 returned 0 after 0 usecs
[    0.134754] calling  i2c_adap_s3c_init+0x0/0x10 @ 1
[    0.134821] bus: 'platform': driver_probe_device: matched device 12c60=
000.i2c with driver s3c-i2c
[    0.134838] bus: 'platform': really_probe: probing driver s3c-i2c with=
 device 12c60000.i2c
[    0.134973] s3c-i2c 12c60000.i2c: slave address 0x00
[    0.134988] s3c-i2c 12c60000.i2c: bus frequency set to 378 KHz
[    0.135315] bus: 'i2c': driver_probe_device: matched device 0-0009 wit=
h driver max77686
[    0.135335] bus: 'i2c': really_probe: probing driver max77686 with dev=
ice 0-0009
[    0.135750] bus: 'i2c': driver_probe_device: matched device 0-0006 wit=
h driver dummy
[    0.135769] bus: 'i2c': really_probe: probing driver dummy with device=
 0-0006
[    0.135796] driver: 'dummy': driver_bound: bound to device '0-0006'
[    0.135808] bus: 'i2c': really_probe: bound device 0-0006 to driver du=
mmy
[    0.136613] bus: 'platform': driver_probe_device: matched device max77=
686-pmic with driver max77686-pmic
[    0.136631] bus: 'platform': really_probe: probing driver max77686-pmi=
c with device max77686-pmic
[    0.155437] of_get_named_gpiod_flags: can't parse 'maxim,ena-gpios' pr=
operty of node '/i2c@12C60000/max77686@09/voltage-regulators/BUCK8[0]'
[    0.156487] driver: 'max77686-pmic': driver_bound: bound to device 'ma=
x77686-pmic'
[    0.156505] bus: 'platform': really_probe: bound device max77686-pmic =
to driver max77686-pmic
[    0.156702] driver: 'max77686': driver_bound: bound to device '0-0009'=

[    0.156715] bus: 'i2c': really_probe: bound device 0-0009 to driver ma=
x77686
[    0.156737] s3c-i2c 12c60000.i2c: i2c-0: S3C I2C adapter
[    0.156748] driver: 's3c-i2c': driver_bound: bound to device '12c60000=
=2Ei2c'
[    0.156760] bus: 'platform': really_probe: bound device 12c60000.i2c t=
o driver s3c-i2c
[    0.156781] bus: 'platform': driver_probe_device: matched device 12c70=
000.i2c with driver s3c-i2c
[    0.156797] bus: 'platform': really_probe: probing driver s3c-i2c with=
 device 12c70000.i2c
[    0.156922] s3c-i2c 12c70000.i2c: slave address 0x00
[    0.156937] s3c-i2c 12c70000.i2c: bus frequency set to 378 KHz
[    0.157205] s3c-i2c 12c70000.i2c: i2c-1: S3C I2C adapter
[    0.157218] driver: 's3c-i2c': driver_bound: bound to device '12c70000=
=2Ei2c'
[    0.157231] bus: 'platform': really_probe: bound device 12c70000.i2c t=
o driver s3c-i2c
[    0.157251] bus: 'platform': driver_probe_device: matched device 12c80=
000.i2c with driver s3c-i2c
[    0.157267] bus: 'platform': really_probe: probing driver s3c-i2c with=
 device 12c80000.i2c
[    0.157352] s3c-i2c 12c80000.i2c: slave address 0x00
[    0.157366] s3c-i2c 12c80000.i2c: bus frequency set to 65 KHz
[    0.157617] s3c-i2c 12c80000.i2c: i2c-2: S3C I2C adapter
[    0.157629] driver: 's3c-i2c': driver_bound: bound to device '12c80000=
=2Ei2c'
[    0.157641] bus: 'platform': really_probe: bound device 12c80000.i2c t=
o driver s3c-i2c
[    0.157660] bus: 'platform': driver_probe_device: matched device 12c90=
000.i2c with driver s3c-i2c
[    0.157676] bus: 'platform': really_probe: probing driver s3c-i2c with=
 device 12c90000.i2c
[    0.157763] s3c-i2c 12c90000.i2c: slave address 0x00
[    0.157776] s3c-i2c 12c90000.i2c: bus frequency set to 65 KHz
[    0.157929] s3c-i2c 12c90000.i2c: i2c-3: S3C I2C adapter
[    0.157941] driver: 's3c-i2c': driver_bound: bound to device '12c90000=
=2Ei2c'
[    0.157953] bus: 'platform': really_probe: bound device 12c90000.i2c t=
o driver s3c-i2c
[    0.157972] bus: 'platform': driver_probe_device: matched device 12ca0=
000.i2c with driver s3c-i2c
[    0.157988] bus: 'platform': really_probe: probing driver s3c-i2c with=
 device 12ca0000.i2c
[    0.158063] s3c-i2c 12ca0000.i2c: slave address 0x00
[    0.158077] s3c-i2c 12ca0000.i2c: bus frequency set to 65 KHz
[    0.158230] s3c-i2c 12ca0000.i2c: i2c-4: S3C I2C adapter
[    0.158241] driver: 's3c-i2c': driver_bound: bound to device '12ca0000=
=2Ei2c'
[    0.158253] bus: 'platform': really_probe: bound device 12ca0000.i2c t=
o driver s3c-i2c
[    0.158272] bus: 'platform': driver_probe_device: matched device 12cb0=
000.i2c with driver s3c-i2c
[    0.158289] bus: 'platform': really_probe: probing driver s3c-i2c with=
 device 12cb0000.i2c
[    0.158365] s3c-i2c 12cb0000.i2c: slave address 0x00
[    0.158379] s3c-i2c 12cb0000.i2c: bus frequency set to 65 KHz
[    0.158538] s3c-i2c 12cb0000.i2c: i2c-5: S3C I2C adapter
[    0.158550] driver: 's3c-i2c': driver_bound: bound to device '12cb0000=
=2Ei2c'
[    0.158562] bus: 'platform': really_probe: bound device 12cb0000.i2c t=
o driver s3c-i2c
[    0.158581] bus: 'platform': driver_probe_device: matched device 12cd0=
000.i2c with driver s3c-i2c
[    0.158598] bus: 'platform': really_probe: probing driver s3c-i2c with=
 device 12cd0000.i2c
[    0.158676] s3c-i2c 12cd0000.i2c: slave address 0x00
[    0.158690] s3c-i2c 12cd0000.i2c: bus frequency set to 65 KHz
[    0.159023] s3c-i2c 12cd0000.i2c: i2c-7: S3C I2C adapter
[    0.159035] driver: 's3c-i2c': driver_bound: bound to device '12cd0000=
=2Ei2c'
[    0.159046] bus: 'platform': really_probe: bound device 12cd0000.i2c t=
o driver s3c-i2c
[    0.159066] bus: 'platform': driver_probe_device: matched device 12ce0=
000.i2c with driver s3c-i2c
[    0.159082] bus: 'platform': really_probe: probing driver s3c-i2c with=
 device 12ce0000.i2c
[    0.159140] s3c-i2c 12ce0000.i2c: slave address 0x00
[    0.159153] s3c-i2c 12ce0000.i2c: bus frequency set to 378 KHz
[    0.159404] s3c-i2c 12ce0000.i2c: i2c-8: S3C I2C adapter
[    0.159416] driver: 's3c-i2c': driver_bound: bound to device '12ce0000=
=2Ei2c'
[    0.159428] bus: 'platform': really_probe: bound device 12ce0000.i2c t=
o driver s3c-i2c
[    0.159600] initcall i2c_adap_s3c_init+0x0/0x10 returned 0 after 24414=
 usecs
[    0.159617] calling  power_supply_class_init+0x0/0x50 @ 1
[    0.159665] initcall power_supply_class_init+0x0/0x50 returned 0 after=
 0 usecs
[    0.159684] calling  hwmon_init+0x0/0x34 @ 1
[    0.159728] initcall hwmon_init+0x0/0x34 returned 0 after 0 usecs
[    0.159743] calling  mmc_init+0x0/0x88 @ 1
[    0.159906] initcall mmc_init+0x0/0x88 returned 0 after 0 usecs
[    0.159921] calling  leds_init+0x0/0x4c @ 1
[    0.159966] initcall leds_init+0x0/0x4c returned 0 after 0 usecs
[    0.159983] calling  s2mps11_clk_init+0x0/0x10 @ 1
[    0.160082] initcall s2mps11_clk_init+0x0/0x10 returned 0 after 0 usec=
s
[    0.160099] calling  exynos3250_cmu_platform_init+0x0/0x18 @ 1
[    0.160321] initcall exynos3250_cmu_platform_init+0x0/0x18 returned -1=
9 after 4882 usecs
[    0.160345] calling  iio_init+0x0/0x94 @ 1
[    0.160421] initcall iio_init+0x0/0x94 returned 0 after 0 usecs
[    0.160437] calling  init_soundcore+0x0/0x40 @ 1
[    0.160483] initcall init_soundcore+0x0/0x40 returned 0 after 0 usecs
[    0.160500] calling  alsa_sound_init+0x0/0xb0 @ 1
[    0.160527] Advanced Linux Sound Architecture Driver Initialized.
[    0.160540] initcall alsa_sound_init+0x0/0xb0 returned 0 after 0 usecs=

[    0.160556] calling  proto_init+0x0/0xc @ 1
[    0.160573] initcall proto_init+0x0/0xc returned 0 after 0 usecs
[    0.160589] calling  net_dev_init+0x0/0x1e8 @ 1
[    0.161022] initcall net_dev_init+0x0/0x1e8 returned 0 after 0 usecs
[    0.161040] calling  neigh_init+0x0/0xa4 @ 1
[    0.161052] initcall neigh_init+0x0/0xa4 returned 0 after 0 usecs
[    0.161066] calling  genl_init+0x0/0x80 @ 1
[    0.161089] initcall genl_init+0x0/0x80 returned 0 after 0 usecs
[    0.161104] calling  cfg80211_init+0x0/0xe4 @ 1
[    0.161431] initcall cfg80211_init+0x0/0xe4 returned 0 after 0 usecs
[    0.161448] calling  watchdog_init+0x0/0xc0 @ 1
[    0.161497] initcall watchdog_init+0x0/0xc0 returned 0 after 0 usecs
[    0.161583] calling  proc_cpu_init+0x0/0x24 @ 1
[    0.161598] initcall proc_cpu_init+0x0/0x24 returned 0 after 0 usecs
[    0.161614] calling  dma_debug_do_init+0x0/0x8 @ 1
[    0.161625] initcall dma_debug_do_init+0x0/0x8 returned 0 after 0 usec=
s
[    0.161641] calling  alignment_init+0x0/0xe8 @ 1
[    0.161657] initcall alignment_init+0x0/0xe8 returned 0 after 0 usecs
[    0.161671] calling  clocksource_done_booting+0x0/0x44 @ 1
[    0.161708] clocksource: Switched to clocksource arch_sys_counter
[    0.161721] initcall clocksource_done_booting+0x0/0x44 returned 0 afte=
r 19 usecs
[    0.161742] calling  init_pipe_fs+0x0/0x58 @ 1
[    0.161776] initcall init_pipe_fs+0x0/0x58 returned 0 after 21 usecs
[    0.161792] calling  inotify_user_setup+0x0/0x54 @ 1
[    0.161808] initcall inotify_user_setup+0x0/0x54 returned 0 after 3 us=
ecs
[    0.161823] calling  eventpoll_init+0x0/0xfc @ 1
[    0.161841] initcall eventpoll_init+0x0/0xfc returned 0 after 6 usecs
[    0.161857] calling  anon_inode_init+0x0/0x6c @ 1
[    0.161893] initcall anon_inode_init+0x0/0x6c returned 0 after 22 usec=
s
[    0.161910] calling  proc_cmdline_init+0x0/0x38 @ 1
[    0.161926] initcall proc_cmdline_init+0x0/0x38 returned 0 after 3 use=
cs
[    0.161942] calling  proc_consoles_init+0x0/0x38 @ 1
[    0.161957] initcall proc_consoles_init+0x0/0x38 returned 0 after 2 us=
ecs
[    0.161973] calling  proc_cpuinfo_init+0x0/0x38 @ 1
[    0.161989] initcall proc_cpuinfo_init+0x0/0x38 returned 0 after 3 use=
cs
[    0.162005] calling  proc_devices_init+0x0/0x38 @ 1
[    0.162020] initcall proc_devices_init+0x0/0x38 returned 0 after 2 use=
cs
[    0.162036] calling  proc_interrupts_init+0x0/0x38 @ 1
[    0.162051] initcall proc_interrupts_init+0x0/0x38 returned 0 after 2 =
usecs
[    0.162067] calling  proc_loadavg_init+0x0/0x38 @ 1
[    0.162081] initcall proc_loadavg_init+0x0/0x38 returned 0 after 2 use=
cs
[    0.162097] calling  proc_meminfo_init+0x0/0x38 @ 1
[    0.162112] initcall proc_meminfo_init+0x0/0x38 returned 0 after 2 use=
cs
[    0.162128] calling  proc_stat_init+0x0/0x38 @ 1
[    0.162142] initcall proc_stat_init+0x0/0x38 returned 0 after 2 usecs
[    0.162158] calling  proc_uptime_init+0x0/0x38 @ 1
[    0.162173] initcall proc_uptime_init+0x0/0x38 returned 0 after 2 usec=
s
[    0.162189] calling  proc_version_init+0x0/0x38 @ 1
[    0.162204] initcall proc_version_init+0x0/0x38 returned 0 after 2 use=
cs
[    0.162220] calling  proc_softirqs_init+0x0/0x38 @ 1
[    0.162234] initcall proc_softirqs_init+0x0/0x38 returned 0 after 2 us=
ecs
[    0.162250] calling  proc_kmsg_init+0x0/0x38 @ 1
[    0.162265] initcall proc_kmsg_init+0x0/0x38 returned 0 after 2 usecs
[    0.162280] calling  proc_page_init+0x0/0x58 @ 1
[    0.162297] initcall proc_page_init+0x0/0x58 returned 0 after 4 usecs
[    0.162313] calling  init_ramfs_fs+0x0/0x34 @ 1
[    0.162325] initcall init_ramfs_fs+0x0/0x34 returned 0 after 0 usecs
[    0.162339] calling  blk_scsi_ioctl_init+0x0/0xdc @ 1
[    0.162351] initcall blk_scsi_ioctl_init+0x0/0xdc returned 0 after 0 u=
secs
[    0.162365] calling  fb_console_init+0x0/0x140 @ 1
[    0.162476] initcall fb_console_init+0x0/0x140 returned 0 after 95 use=
cs
[    0.162493] calling  chr_dev_init+0x0/0xc8 @ 1
[    0.170806] initcall chr_dev_init+0x0/0xc8 returned 0 after 8100 usecs=

[    0.170829] calling  firmware_class_init+0x0/0xc8 @ 1
[    0.170844] initcall firmware_class_init+0x0/0xc8 returned 0 after 2 u=
secs
[    0.170858] calling  thermal_init+0x0/0xb4 @ 1
[    0.171140] initcall thermal_init+0x0/0xb4 returned 0 after 262 usecs
[    0.171157] calling  cpufreq_gov_performance_init+0x0/0xc @ 1
[    0.171171] initcall cpufreq_gov_performance_init+0x0/0xc returned 0 a=
fter 1 usecs
[    0.171189] calling  cpufreq_gov_dbs_init+0x0/0xc @ 1
[    0.171202] initcall cpufreq_gov_dbs_init+0x0/0xc returned 0 after 0 u=
secs
[    0.171220] calling  sysctl_core_init+0x0/0x30 @ 1
[    0.171251] initcall sysctl_core_init+0x0/0x30 returned 0 after 17 use=
cs
[    0.171265] calling  eth_offload_init+0x0/0x18 @ 1
[    0.171276] initcall eth_offload_init+0x0/0x18 returned 0 after 0 usec=
s
[    0.171290] calling  inet_init+0x0/0x250 @ 1
[    0.171333] NET: Registered protocol family 2
[    0.171618] TCP established hash table entries: 8192 (order: 3, 32768 =
bytes)
[    0.171673] TCP bind hash table entries: 8192 (order: 5, 163840 bytes)=

[    0.171813] TCP: Hash tables configured (established 8192 bind 8192)
[    0.171862] UDP hash table entries: 512 (order: 2, 24576 bytes)
[    0.171891] UDP-Lite hash table entries: 512 (order: 2, 24576 bytes)
[    0.171998] initcall inet_init+0x0/0x250 returned 0 after 677 usecs
[    0.172015] calling  ipv4_offload_init+0x0/0x68 @ 1
[    0.172027] initcall ipv4_offload_init+0x0/0x68 returned 0 after 0 use=
cs
[    0.172041] calling  af_unix_init+0x0/0x54 @ 1
[    0.172054] NET: Registered protocol family 1
[    0.172075] initcall af_unix_init+0x0/0x54 returned 0 after 21 usecs
[    0.172089] calling  ipv6_offload_init+0x0/0x88 @ 1
[    0.172103] initcall ipv6_offload_init+0x0/0x88 returned 0 after 1 use=
cs
[    0.172117] calling  init_sunrpc+0x0/0x6c @ 1
[    0.172265] RPC: Registered named UNIX socket transport module.
[    0.172278] RPC: Registered udp transport module.
[    0.172287] RPC: Registered tcp transport module.
[    0.172297] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.172310] initcall init_sunrpc+0x0/0x6c returned 0 after 175 usecs
[    0.172325] calling  populate_rootfs+0x0/0x25c @ 1
[    0.172448] initcall populate_rootfs+0x0/0x25c returned 0 after 106 us=
ecs
[    0.172540] calling  bL_switcher_dummy_if_init+0x0/0xc @ 1
[    0.172686] initcall bL_switcher_dummy_if_init+0x0/0xc returned 0 afte=
r 128 usecs
[    0.172709] calling  proc_execdomains_init+0x0/0x38 @ 1
[    0.172727] initcall proc_execdomains_init+0x0/0x38 returned 0 after 4=
 usecs
[    0.172744] calling  ioresources_init+0x0/0x58 @ 1
[    0.172762] initcall ioresources_init+0x0/0x58 returned 0 after 5 usec=
s
[    0.172780] calling  init_sched_debug_procfs+0x0/0x3c @ 1
[    0.172796] initcall init_sched_debug_procfs+0x0/0x3c returned 0 after=
 3 usecs
[    0.172813] calling  irq_gc_init_ops+0x0/0x18 @ 1
[    0.172825] initcall irq_gc_init_ops+0x0/0x18 returned 0 after 1 usecs=

[    0.172838] calling  irq_pm_init_ops+0x0/0x18 @ 1
[    0.172849] initcall irq_pm_init_ops+0x0/0x18 returned 0 after 0 usecs=

[    0.172862] calling  init_posix_timers+0x0/0x210 @ 1
[    0.172882] initcall init_posix_timers+0x0/0x210 returned 0 after 8 us=
ecs
[    0.172895] calling  init_posix_cpu_timers+0x0/0xdc @ 1
[    0.172907] initcall init_posix_cpu_timers+0x0/0xdc returned 0 after 0=
 usecs
[    0.172921] calling  timekeeping_init_ops+0x0/0x18 @ 1
[    0.172933] initcall timekeeping_init_ops+0x0/0x18 returned 0 after 0 =
usecs
[    0.172946] calling  init_clocksource_sysfs+0x0/0x74 @ 1
[    0.173133] initcall init_clocksource_sysfs+0x0/0x74 returned 0 after =
169 usecs
[    0.173152] calling  init_timer_list_procfs+0x0/0x3c @ 1
[    0.173168] initcall init_timer_list_procfs+0x0/0x3c returned 0 after =
3 usecs
[    0.173182] calling  alarmtimer_init+0x0/0x1a8 @ 1
[    0.173394] bus: 'platform': driver_probe_device: matched device alarm=
timer with driver alarmtimer
[    0.173412] bus: 'platform': really_probe: probing driver alarmtimer w=
ith device alarmtimer
[    0.173453] alarmtimer: probe of alarmtimer rejects match -19
[    0.173471] initcall alarmtimer_init+0x0/0x1a8 returned 0 after 271 us=
ecs
[    0.173486] calling  clockevents_init_sysfs+0x0/0xdc @ 1
[    0.173809] initcall clockevents_init_sysfs+0x0/0xdc returned 0 after =
301 usecs
[    0.173828] calling  sched_clock_syscore_init+0x0/0x18 @ 1
[    0.173840] initcall sched_clock_syscore_init+0x0/0x18 returned 0 afte=
r 0 usecs
[    0.173857] calling  futex_init+0x0/0x108 @ 1
[    0.173870] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.173899] initcall futex_init+0x0/0x108 returned 0 after 29 usecs
[    0.173913] calling  proc_modules_init+0x0/0x38 @ 1
[    0.173929] initcall proc_modules_init+0x0/0x38 returned 0 after 4 use=
cs
[    0.173943] calling  kallsyms_init+0x0/0x38 @ 1
[    0.173957] initcall kallsyms_init+0x0/0x38 returned 0 after 3 usecs
[    0.173971] calling  pid_namespaces_init+0x0/0x40 @ 1
[    0.173987] initcall pid_namespaces_init+0x0/0x40 returned 0 after 4 u=
secs
[    0.174002] calling  utsname_sysctl_init+0x0/0x18 @ 1
[    0.174026] initcall utsname_sysctl_init+0x0/0x18 returned 0 after 12 =
usecs
[    0.174041] calling  init_per_zone_wmark_min+0x0/0xbc @ 1
[    0.174059] initcall init_per_zone_wmark_min+0x0/0xbc returned 0 after=
 5 usecs
[    0.174077] calling  kswapd_init+0x0/0x24 @ 1
[    0.174134] initcall kswapd_init+0x0/0x24 returned 0 after 43 usecs
[    0.174150] calling  extfrag_debug_init+0x0/0x94 @ 1
[    0.174181] initcall extfrag_debug_init+0x0/0x94 returned 0 after 17 u=
secs
[    0.174196] calling  setup_vmstat+0x0/0x1b4 @ 1
[    0.174219] initcall setup_vmstat+0x0/0x1b4 returned 0 after 12 usecs
[    0.174234] calling  mm_compute_batch_init+0x0/0x5c @ 1
[    0.174246] initcall mm_compute_batch_init+0x0/0x5c returned 0 after 0=
 usecs
[    0.174261] calling  slab_proc_init+0x0/0x38 @ 1
[    0.174275] initcall slab_proc_init+0x0/0x38 returned 0 after 2 usecs
[    0.174290] calling  workingset_init+0x0/0x50 @ 1
[    0.174302] initcall workingset_init+0x0/0x50 returned 0 after 1 usecs=

[    0.174317] calling  proc_vmalloc_init+0x0/0x38 @ 1
[    0.174332] initcall proc_vmalloc_init+0x0/0x38 returned 0 after 3 use=
cs
[    0.174348] calling  memblock_init_debugfs+0x0/0x78 @ 1
[    0.174372] initcall memblock_init_debugfs+0x0/0x78 returned 0 after 1=
1 usecs
[    0.174387] calling  procswaps_init+0x0/0x38 @ 1
[    0.174402] initcall procswaps_init+0x0/0x38 returned 0 after 2 usecs
[    0.174418] calling  slab_sysfs_init+0x0/0x11c @ 1
[    0.180816] initcall slab_sysfs_init+0x0/0x11c returned 0 after 6232 u=
secs
[    0.180838] calling  fcntl_init+0x0/0x40 @ 1
[    0.180858] initcall fcntl_init+0x0/0x40 returned 0 after 7 usecs
[    0.180874] calling  proc_filesystems_init+0x0/0x38 @ 1
[    0.180892] initcall proc_filesystems_init+0x0/0x38 returned 0 after 5=
 usecs
[    0.180909] calling  start_dirtytime_writeback+0x0/0x34 @ 1
[    0.180923] initcall start_dirtytime_writeback+0x0/0x34 returned 0 aft=
er 1 usecs
[    0.180942] calling  dio_init+0x0/0x40 @ 1
[    0.180961] initcall dio_init+0x0/0x40 returned 0 after 6 usecs
[    0.180977] calling  fsnotify_mark_init+0x0/0x40 @ 1
[    0.181031] initcall fsnotify_mark_init+0x0/0x40 returned 0 after 39 u=
secs
[    0.181049] calling  dnotify_init+0x0/0x84 @ 1
[    0.181074] initcall dnotify_init+0x0/0x84 returned 0 after 12 usecs
[    0.181089] calling  aio_setup+0x0/0x88 @ 1
[    0.181137] initcall aio_setup+0x0/0x88 returned 0 after 34 usecs
[    0.181154] calling  proc_locks_init+0x0/0x38 @ 1
[    0.181170] initcall proc_locks_init+0x0/0x38 returned 0 after 3 usecs=

[    0.181186] calling  init_mbcache+0x0/0x18 @ 1
[    0.181198] initcall init_mbcache+0x0/0x18 returned 0 after 0 usecs
[    0.181213] calling  init_grace+0x0/0xc @ 1
[    0.181227] initcall init_grace+0x0/0xc returned 0 after 2 usecs
[    0.181242] calling  init_devpts_fs+0x0/0x70 @ 1
[    0.181281] initcall init_devpts_fs+0x0/0x70 returned 0 after 25 usecs=

[    0.181298] calling  init_ext2_fs+0x0/0x78 @ 1
[    0.181444] initcall init_ext2_fs+0x0/0x78 returned 0 after 128 usecs
[    0.181462] calling  ext4_init_fs+0x0/0x1ac @ 1
[    0.182207] initcall ext4_init_fs+0x0/0x1ac returned 0 after 714 usecs=

[    0.182226] calling  journal_init+0x0/0x118 @ 1
[    0.182652] initcall journal_init+0x0/0x118 returned 0 after 401 usecs=

[    0.182670] calling  init_cramfs_fs+0x0/0x38 @ 1
[    0.182700] initcall init_cramfs_fs+0x0/0x38 returned 0 after 16 usecs=

[    0.182717] calling  init_fat_fs+0x0/0x64 @ 1
[    0.182984] initcall init_fat_fs+0x0/0x64 returned 0 after 247 usecs
[    0.183003] calling  init_vfat_fs+0x0/0xc @ 1
[    0.183017] initcall init_vfat_fs+0x0/0xc returned 0 after 1 usecs
[    0.183033] calling  init_msdos_fs+0x0/0xc @ 1
[    0.183046] initcall init_msdos_fs+0x0/0xc returned 0 after 1 usecs
[    0.183062] calling  init_nfs_fs+0x0/0x160 @ 1
[    0.183598] initcall init_nfs_fs+0x0/0x160 returned 0 after 509 usecs
[    0.183613] calling  init_nfs_v2+0x0/0x18 @ 1
[    0.183625] initcall init_nfs_v2+0x0/0x18 returned 0 after 0 usecs
[    0.183638] calling  init_nfs_v3+0x0/0x18 @ 1
[    0.183649] initcall init_nfs_v3+0x0/0x18 returned 0 after 0 usecs
[    0.183662] calling  init_nlm+0x0/0x70 @ 1
[    0.183686] initcall init_nlm+0x0/0x70 returned 0 after 12 usecs
[    0.183699] calling  init_nls_cp437+0x0/0x10 @ 1
[    0.183711] initcall init_nls_cp437+0x0/0x10 returned 0 after 0 usecs
[    0.183724] calling  init_nls_ascii+0x0/0x10 @ 1
[    0.183735] initcall init_nls_ascii+0x0/0x10 returned 0 after 0 usecs
[    0.183748] calling  init_nls_iso8859_1+0x0/0x10 @ 1
[    0.183759] initcall init_nls_iso8859_1+0x0/0x10 returned 0 after 0 us=
ecs
[    0.183772] calling  init_romfs_fs+0x0/0x98 @ 1
[    0.183781] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
[    0.183926] initcall init_romfs_fs+0x0/0x98 returned 0 after 138 usecs=

[    0.183941] calling  ipc_init+0x0/0x18 @ 1
[    0.183961] initcall ipc_init+0x0/0x18 returned 0 after 9 usecs
[    0.183974] calling  ipc_sysctl_init+0x0/0x18 @ 1
[    0.183996] initcall ipc_sysctl_init+0x0/0x18 returned 0 after 10 usec=
s
[    0.184010] calling  crypto_algapi_init+0x0/0x10 @ 1
[    0.184024] initcall crypto_algapi_init+0x0/0x10 returned 0 after 3 us=
ecs
[    0.184038] calling  chainiv_module_init+0x0/0xc @ 1
[    0.184051] initcall chainiv_module_init+0x0/0xc returned 0 after 2 us=
ecs
[    0.184065] calling  eseqiv_module_init+0x0/0xc @ 1
[    0.184076] initcall eseqiv_module_init+0x0/0xc returned 0 after 0 use=
cs
[    0.184089] calling  crypto_null_mod_init+0x0/0x4c @ 1
[    0.184291] initcall crypto_null_mod_init+0x0/0x4c returned 0 after 18=
4 usecs
[    0.184307] calling  sha256_generic_mod_init+0x0/0x10 @ 1
[    0.184402] initcall sha256_generic_mod_init+0x0/0x10 returned 0 after=
 79 usecs
[    0.184421] calling  crypto_cbc_module_init+0x0/0xc @ 1
[    0.184433] initcall crypto_cbc_module_init+0x0/0xc returned 0 after 0=
 usecs
[    0.184446] calling  aes_init+0x0/0xc @ 1
[    0.184503] initcall aes_init+0x0/0xc returned 0 after 43 usecs
[    0.184517] calling  crc32c_mod_init+0x0/0xc @ 1
[    0.184574] initcall crc32c_mod_init+0x0/0xc returned 0 after 43 usecs=

[    0.184588] calling  proc_genhd_init+0x0/0x58 @ 1
[    0.184606] initcall proc_genhd_init+0x0/0x58 returned 0 after 6 usecs=

[    0.184621] calling  init_emergency_pool+0x0/0x78 @ 1
[    0.184654] bounce: pool size: 64 pages
[    0.184665] initcall init_emergency_pool+0x0/0x78 returned 0 after 32 =
usecs
[    0.184679] calling  noop_init+0x0/0xc @ 1
[    0.184690] io scheduler noop registered
[    0.184701] initcall noop_init+0x0/0xc returned 0 after 10 usecs
[    0.184714] calling  deadline_init+0x0/0xc @ 1
[    0.184724] io scheduler deadline registered
[    0.184735] initcall deadline_init+0x0/0xc returned 0 after 9 usecs
[    0.184748] calling  cfq_init+0x0/0xa4 @ 1
[    0.184908] io scheduler cfq registered (default)
[    0.184922] initcall cfq_init+0x0/0xa4 returned 0 after 157 usecs
[    0.184936] calling  percpu_counter_startup+0x0/0x1c @ 1
[    0.184950] initcall percpu_counter_startup+0x0/0x1c returned 0 after =
2 usecs
[    0.184965] calling  phy_core_init+0x0/0x58 @ 1
[    0.185013] initcall phy_core_init+0x0/0x58 returned 0 after 35 usecs
[    0.185030] calling  exynos_dp_video_phy_driver_init+0x0/0x10 @ 1
[    0.185148] bus: 'platform': driver_probe_device: matched device video=
-phy@10040720 with driver exynos-dp-video-phy
[    0.185167] bus: 'platform': really_probe: probing driver exynos-dp-vi=
deo-phy with device video-phy@10040720
[    0.185389] driver: 'exynos-dp-video-phy': driver_bound: bound to devi=
ce 'video-phy@10040720'
[    0.185409] bus: 'platform': really_probe: bound device video-phy@1004=
0720 to driver exynos-dp-video-phy
[    0.185524] initcall exynos_dp_video_phy_driver_init+0x0/0x10 returned=
 0 after 468 usecs
[    0.185546] calling  exynos_mipi_video_phy_driver_init+0x0/0x10 @ 1
[    0.185682] initcall exynos_mipi_video_phy_driver_init+0x0/0x10 return=
ed 0 after 119 usecs
[    0.185702] calling  exynos_sata_phy_driver_init+0x0/0x10 @ 1
[    0.185835] initcall exynos_sata_phy_driver_init+0x0/0x10 returned 0 a=
fter 115 usecs
[    0.185856] calling  samsung_usb2_phy_driver_init+0x0/0x10 @ 1
[    0.185943] bus: 'platform': driver_probe_device: matched device 12130=
000.phy with driver samsung-usb2-phy
[    0.185961] bus: 'platform': really_probe: probing driver samsung-usb2=
-phy with device 12130000.phy
[    0.186427] driver: 'samsung-usb2-phy': driver_bound: bound to device =
'12130000.phy'
[    0.186444] bus: 'platform': really_probe: bound device 12130000.phy t=
o driver samsung-usb2-phy
[    0.186562] initcall samsung_usb2_phy_driver_init+0x0/0x10 returned 0 =
after 675 usecs
[    0.186582] calling  exynos5_usb3drd_phy_init+0x0/0x10 @ 1
[    0.186667] bus: 'platform': driver_probe_device: matched device 12100=
000.phy with driver exynos5_usb3drd_phy
[    0.186684] bus: 'platform': really_probe: probing driver exynos5_usb3=
drd_phy with device 12100000.phy
[    0.186848] 12100000.phy supply vbus-boost not found, using dummy regu=
lator
[    0.187098] driver: 'exynos5_usb3drd_phy': driver_bound: bound to devi=
ce '12100000.phy'
[    0.187116] bus: 'platform': really_probe: bound device 12100000.phy t=
o driver exynos5_usb3drd_phy
[    0.187243] initcall exynos5_usb3drd_phy_init+0x0/0x10 returned 0 afte=
r 631 usecs
[    0.187264] calling  pwm_samsung_driver_init+0x0/0x10 @ 1
[    0.187360] bus: 'platform': driver_probe_device: matched device 12dd0=
000.pwm with driver samsung-pwm
[    0.187377] bus: 'platform': really_probe: probing driver samsung-pwm =
with device 12dd0000.pwm
[    0.187536] driver: 'samsung-pwm': driver_bound: bound to device '12dd=
0000.pwm'
[    0.187554] bus: 'platform': really_probe: bound device 12dd0000.pwm t=
o driver samsung-pwm
[    0.187674] initcall pwm_samsung_driver_init+0x0/0x10 returned 0 after=
 386 usecs
[    0.187693] calling  platform_lcd_driver_init+0x0/0x10 @ 1
[    0.187816] initcall platform_lcd_driver_init+0x0/0x10 returned 0 afte=
r 106 usecs
[    0.187836] calling  genericbl_driver_init+0x0/0x10 @ 1
[    0.187926] initcall genericbl_driver_init+0x0/0x10 returned 0 after 7=
4 usecs
[    0.187943] calling  pwm_backlight_driver_init+0x0/0x10 @ 1
[    0.188023] bus: 'platform': driver_probe_device: matched device backl=
ight with driver pwm-backlight
[    0.188040] bus: 'platform': really_probe: probing driver pwm-backligh=
t with device backlight
[    0.188109] pwm-backlight backlight: GPIO lookup for consumer enable
[    0.188121] pwm-backlight backlight: using device tree for GPIO lookup=

[    0.188140] of_get_named_gpiod_flags: parsed 'enable-gpios' property o=
f node '/backlight[0]' - status (0)
[    0.188208] platform backlight: Driver pwm-backlight requests probe de=
ferral
[    0.188221] platform backlight: Added to deferred list
[    0.188283] initcall pwm_backlight_driver_init+0x0/0x10 returned 0 aft=
er 318 usecs
[    0.188304] calling  exynos_mipi_dsi_driver_init+0x0/0x10 @ 1
[    0.188393] initcall exynos_mipi_dsi_driver_init+0x0/0x10 returned 0 a=
fter 73 usecs
[    0.188413] calling  pl330_driver_init+0x0/0xc @ 1
[    0.188432] bus: 'amba': driver_probe_device: matched device 121a0000.=
pdma with driver dma-pl330
[    0.188449] bus: 'amba': really_probe: probing driver dma-pl330 with d=
evice 121a0000.pdma
[    0.191215] dma-pl330 121a0000.pdma: Loaded driver for PL330 DMAC-2413=
30
[    0.191232] dma-pl330 121a0000.pdma: 	DBUFF-32x4bytes Num_Chans-8 Num_=
Peri-32 Num_Events-32
[    0.191253] driver: 'dma-pl330': driver_bound: bound to device '121a00=
00.pdma'
[    0.191269] bus: 'amba': really_probe: bound device 121a0000.pdma to d=
river dma-pl330
[    0.191298] bus: 'amba': driver_probe_device: matched device 121b0000.=
pdma with driver dma-pl330
[    0.191315] bus: 'amba': really_probe: probing driver dma-pl330 with d=
evice 121b0000.pdma
[    0.194244] dma-pl330 121b0000.pdma: Loaded driver for PL330 DMAC-2413=
30
[    0.194262] dma-pl330 121b0000.pdma: 	DBUFF-32x4bytes Num_Chans-8 Num_=
Peri-32 Num_Events-32
[    0.194282] driver: 'dma-pl330': driver_bound: bound to device '121b00=
00.pdma'
[    0.194298] bus: 'amba': really_probe: bound device 121b0000.pdma to d=
river dma-pl330
[    0.194327] bus: 'amba': driver_probe_device: matched device 10800000.=
mdma with driver dma-pl330
[    0.194344] bus: 'amba': really_probe: probing driver dma-pl330 with d=
evice 10800000.mdma
[    0.195148] dma-pl330 10800000.mdma: Loaded driver for PL330 DMAC-2413=
30
[    0.195164] dma-pl330 10800000.mdma: 	DBUFF-64x8bytes Num_Chans-8 Num_=
Peri-1 Num_Events-32
[    0.195183] driver: 'dma-pl330': driver_bound: bound to device '108000=
00.mdma'
[    0.195198] bus: 'amba': really_probe: bound device 10800000.mdma to d=
river dma-pl330
[    0.195225] bus: 'amba': driver_probe_device: matched device 11c10000.=
mdma with driver dma-pl330
[    0.195241] bus: 'amba': really_probe: probing driver dma-pl330 with d=
evice 11c10000.mdma
[    0.196010] dma-pl330 11c10000.mdma: Loaded driver for PL330 DMAC-2413=
30
[    0.196024] dma-pl330 11c10000.mdma: 	DBUFF-64x8bytes Num_Chans-8 Num_=
Peri-1 Num_Events-32
[    0.196042] driver: 'dma-pl330': driver_bound: bound to device '11c100=
00.mdma'
[    0.196057] bus: 'amba': really_probe: bound device 11c10000.mdma to d=
river dma-pl330
[    0.196127] initcall pl330_driver_init+0x0/0xc returned 0 after 7517 u=
secs
[    0.196144] calling  max77802_pmic_driver_init+0x0/0x10 @ 1
[    0.196257] initcall max77802_pmic_driver_init+0x0/0x10 returned 0 aft=
er 96 usecs
[    0.196278] calling  s2mpa01_pmic_driver_init+0x0/0x10 @ 1
[    0.196366] initcall s2mpa01_pmic_driver_init+0x0/0x10 returned 0 afte=
r 72 usecs
[    0.196385] calling  pty_init+0x0/0x3dc @ 1
[    0.249310] initcall pty_init+0x0/0x3dc returned 0 after 51665 usecs
[    0.249336] calling  sysrq_init+0x0/0xa0 @ 1
[    0.249359] initcall sysrq_init+0x0/0xa0 returned 0 after 9 usecs
[    0.249376] calling  serial8250_init+0x0/0x144 @ 1
[    0.249387] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.250295] bus: 'platform': driver_probe_device: matched device seria=
l8250 with driver serial8250
[    0.250315] bus: 'platform': really_probe: probing driver serial8250 w=
ith device serial8250
[    0.250352] driver: 'serial8250': driver_bound: bound to device 'seria=
l8250'
[    0.250365] bus: 'platform': really_probe: bound device serial8250 to =
driver serial8250
[    0.250428] initcall serial8250_init+0x0/0x144 returned 0 after 1012 u=
secs
[    0.250446] calling  samsung_serial_driver_init+0x0/0x10 @ 1
[    0.250478] bus: 'platform': driver_probe_device: matched device 12c00=
000.serial with driver samsung-uart
[    0.250496] bus: 'platform': really_probe: probing driver samsung-uart=
 with device 12c00000.serial
[    0.250603] 12c00000.serial: ttySAC0 at MMIO 0x12c00000 (irq =3D 56, b=
ase_baud =3D 0) is a S3C6400/10
[    0.250823] driver: 'samsung-uart': driver_bound: bound to device '12c=
00000.serial'
[    0.250840] bus: 'platform': really_probe: bound device 12c00000.seria=
l to driver samsung-uart
[    0.250861] bus: 'platform': driver_probe_device: matched device 12c10=
000.serial with driver samsung-uart
[    0.250879] bus: 'platform': really_probe: probing driver samsung-uart=
 with device 12c10000.serial
[    0.250943] 12c10000.serial: ttySAC1 at MMIO 0x12c10000 (irq =3D 57, b=
ase_baud =3D 0) is a S3C6400/10
[    0.251144] driver: 'samsung-uart': driver_bound: bound to device '12c=
10000.serial'
[    0.251161] bus: 'platform': really_probe: bound device 12c10000.seria=
l to driver samsung-uart
[    0.251181] bus: 'platform': driver_probe_device: matched device 12c20=
000.serial with driver samsung-uart
[    0.251198] bus: 'platform': really_probe: probing driver samsung-uart=
 with device 12c20000.serial
[    0.251264] 12c20000.serial: ttySAC2 at MMIO 0x12c20000 (irq =3D 58, b=
ase_baud =3D 0) is a S3C6400/10
[    0.251468] driver: 'samsung-uart': driver_bound: bound to device '12c=
20000.serial'
[    0.251484] bus: 'platform': really_probe: bound device 12c20000.seria=
l to driver samsung-uart
[    0.251505] bus: 'platform': driver_probe_device: matched device 12c30=
000.serial with driver samsung-uart
[    0.251522] bus: 'platform': really_probe: probing driver samsung-uart=
 with device 12c30000.serial
[    0.251585] 12c30000.serial: ttySAC3 at MMIO 0x12c30000 (irq =3D 59, b=
ase_baud =3D 0) is a S3C6400/10
[    0.251852] driver: 'samsung-uart': driver_bound: bound to device '12c=
30000.serial'
[    0.251870] bus: 'platform': really_probe: bound device 12c30000.seria=
l to driver samsung-uart
[    0.252163] initcall samsung_serial_driver_init+0x0/0x10 returned 0 af=
ter 1660 usecs
[    0.252185] calling  of_platform_serial_driver_init+0x0/0x10 @ 1
[    0.252481] initcall of_platform_serial_driver_init+0x0/0x10 returned =
0 after 273 usecs
[    0.252502] calling  hwrng_modinit+0x0/0xc @ 1
[    0.252635] initcall hwrng_modinit+0x0/0xc returned 0 after 116 usecs
[    0.252652] calling  exynos_rng_driver_init+0x0/0x10 @ 1
[    0.252744] initcall exynos_rng_driver_init+0x0/0x10 returned 0 after =
76 usecs
[    0.252765] calling  rng_init+0x0/0xc @ 1
[    0.252780] initcall rng_init+0x0/0xc returned 0 after 3 usecs
[    0.252795] calling  tpm_tis_i2c_driver_init+0x0/0x10 @ 1
[    0.252884] initcall tpm_tis_i2c_driver_init+0x0/0x10 returned 0 after=
 72 usecs
[    0.252904] calling  drm_core_init+0x0/0x104 @ 1
[    0.252967] [drm] Initialized drm 1.1.0 20060810
[    0.252981] initcall drm_core_init+0x0/0x104 returned 0 after 63 usecs=

[    0.252996] calling  exynos_drm_init+0x0/0xc0 @ 1
[    0.253134] bus: 'platform': driver_probe_device: matched device 14400=
000.fimd with driver exynos4-fb
[    0.253152] bus: 'platform': really_probe: probing driver exynos4-fb w=
ith device 14400000.fimd
[    0.253290] driver: 'exynos4-fb': driver_bound: bound to device '14400=
000.fimd'
[    0.253307] bus: 'platform': really_probe: bound device 14400000.fimd =
to driver exynos4-fb
[    0.253551] bus: 'platform': driver_probe_device: matched device 145b0=
000.dp-controller with driver exynos-dp
[    0.253570] bus: 'platform': really_probe: probing driver exynos-dp wi=
th device 145b0000.dp-controller
[    0.254151] platform 145b0000.dp-controller: Driver exynos-dp requests=
 probe deferral
[    0.254168] platform 145b0000.dp-controller: Added to deferred list
[    0.254605] bus: 'platform': driver_probe_device: matched device 14450=
000.mixer with driver exynos-mixer
[    0.254623] bus: 'platform': really_probe: probing driver exynos-mixer=
 with device 14450000.mixer
[    0.255125] driver: 'exynos-mixer': driver_bound: bound to device '144=
50000.mixer'
[    0.255142] bus: 'platform': really_probe: bound device 14450000.mixer=
 to driver exynos-mixer
[    0.255358] bus: 'platform': driver_probe_device: matched device 14530=
000.hdmi with driver exynos-hdmi
[    0.255376] bus: 'platform': really_probe: probing driver exynos-hdmi =
with device 14530000.hdmi
[    0.255911] of_get_named_gpiod_flags: parsed 'hpd-gpio' property of no=
de '/hdmi[0]' - status (0)
[    0.256608] [drm:hdmi_probe] *ERROR* failed to get hdmi-en regulator
[    0.256623] [drm:hdmi_probe] *ERROR* hdmi_resources_init failed
[    0.256796] platform 14530000.hdmi: Driver exynos-hdmi requests probe =
deferral
[    0.256813] platform 14530000.hdmi: Added to deferred list
[    0.256978] bus: 'platform': driver_probe_device: matched device exyno=
s-drm with driver exynos-drm
[    0.256996] bus: 'platform': really_probe: probing driver exynos-drm w=
ith device exynos-drm
[    0.257649] driver: 'exynos-drm': driver_bound: bound to device 'exyno=
s-drm'
[    0.257661] bus: 'platform': really_probe: bound device exynos-drm to =
driver exynos-drm
[    0.257723] initcall exynos_drm_init+0x0/0xc0 returned 0 after 4604 us=
ecs
[    0.257742] calling  panel_simple_init+0x0/0x34 @ 1
[    0.258146] bus: 'platform': driver_probe_device: matched device panel=
 with driver panel-simple
[    0.258162] bus: 'platform': really_probe: probing driver panel-simple=
 with device panel
[    0.258232] platform panel: Driver panel-simple requests probe deferra=
l
[    0.258244] platform panel: Added to deferred list
[    0.258358] initcall panel_simple_init+0x0/0x34 returned 0 after 586 u=
secs
[    0.258376] calling  s6e8aa0_driver_init+0x0/0x10 @ 1
[    0.258433] initcall s6e8aa0_driver_init+0x0/0x10 returned 0 after 42 =
usecs
[    0.258450] calling  ptn3460_driver_init+0x0/0x10 @ 1
[    0.258476] bus: 'i2c': driver_probe_device: matched device 7-0020 wit=
h driver nxp,ptn3460
[    0.258497] bus: 'i2c': really_probe: probing driver nxp,ptn3460 with =
device 7-0020
[    0.258554] i2c 7-0020: Driver nxp,ptn3460 requests probe deferral
[    0.258566] i2c 7-0020: Added to deferred list
[    0.258641] initcall ptn3460_driver_init+0x0/0x10 returned 0 after 173=
 usecs
[    0.258659] calling  ps8622_driver_init+0x0/0x10 @ 1
[    0.258732] initcall ps8622_driver_init+0x0/0x10 returned 0 after 58 u=
secs
[    0.258751] calling  topology_sysfs_init+0x0/0x7c @ 1
[    0.258812] initcall topology_sysfs_init+0x0/0x7c returned 0 after 47 =
usecs
[    0.258828] calling  cacheinfo_sysfs_init+0x0/0x94 @ 1
[    0.258841] initcall cacheinfo_sysfs_init+0x0/0x94 returned -2 after 1=
 usecs
[    0.258857] calling  devcoredump_init+0x0/0x14 @ 1
[    0.258911] initcall devcoredump_init+0x0/0x14 returned 0 after 39 use=
cs
[    0.258928] calling  brd_init+0x0/0x170 @ 1
[    0.266174] brd: module loaded
[    0.266198] initcall brd_init+0x0/0x170 returned 0 after 7083 usecs
[    0.266215] calling  loop_init+0x0/0x12c @ 1
[    0.270220] loop: module loaded
[    0.270243] initcall loop_init+0x0/0x12c returned 0 after 3917 usecs
[    0.270261] calling  init_cryptoloop+0x0/0x2c @ 1
[    0.270274] initcall init_cryptoloop+0x0/0x2c returned 0 after 0 usecs=

[    0.270290] calling  cros_ec_driver_init+0x0/0x10 @ 1
[    0.270378] initcall cros_ec_driver_init+0x0/0x10 returned 0 after 72 =
usecs
[    0.270396] calling  cros_ec_driver_spi_init+0x0/0xc @ 1
[    0.270455] initcall cros_ec_driver_spi_init+0x0/0xc returned 0 after =
43 usecs
[    0.270475] calling  init_sd+0x0/0x164 @ 1
[    0.270603] initcall init_sd+0x0/0x164 returned 0 after 111 usecs
[    0.270620] calling  init_sg+0x0/0x134 @ 1
[    0.270697] initcall init_sg+0x0/0x134 returned 0 after 61 usecs
[    0.270714] calling  s3c64xx_spi_driver_init+0x0/0x10 @ 1
[    0.270835] bus: 'platform': driver_probe_device: matched device 12d30=
000.spi with driver s3c64xx-spi
[    0.270853] bus: 'platform': really_probe: probing driver s3c64xx-spi =
with device 12d30000.spi
[    0.271044] of_get_named_gpiod_flags: parsed 'cs-gpios' property of no=
de '/spi@12d30000[0]' - status (0)
[    0.271294] driver: 's3c64xx-spi': driver_bound: bound to device '12d3=
0000.spi'
[    0.271312] bus: 'platform': really_probe: bound device 12d30000.spi t=
o driver s3c64xx-spi
[    0.271506] initcall s3c64xx_spi_driver_init+0x0/0x10 returned 0 after=
 758 usecs
[    0.271529] calling  net_olddevs_init+0x0/0x6c @ 1
[    0.271546] initcall net_olddevs_init+0x0/0x6c returned 0 after 4 usec=
s
[    0.271562] calling  smsc911x_init_module+0x0/0x10 @ 1
[    0.271697] initcall smsc911x_init_module+0x0/0x10 returned 0 after 11=
8 usecs
[    0.271770] calling  rtl8152_driver_init+0x0/0x18 @ 1
[    0.271867] usbcore: registered new interface driver r8152
[    0.271883] initcall rtl8152_driver_init+0x0/0x18 returned 0 after 96 =
usecs
[    0.271900] calling  asix_driver_init+0x0/0x18 @ 1
[    0.271987] usbcore: registered new interface driver asix
[    0.272002] initcall asix_driver_init+0x0/0x18 returned 0 after 86 use=
cs
[    0.272019] calling  ax88179_178a_driver_init+0x0/0x18 @ 1
[    0.272086] usbcore: registered new interface driver ax88179_178a
[    0.272102] initcall ax88179_178a_driver_init+0x0/0x18 returned 0 afte=
r 67 usecs
[    0.272122] calling  cdc_driver_init+0x0/0x18 @ 1
[    0.272192] usbcore: registered new interface driver cdc_ether
[    0.272207] initcall cdc_driver_init+0x0/0x18 returned 0 after 69 usec=
s
[    0.272223] calling  smsc75xx_driver_init+0x0/0x18 @ 1
[    0.272305] usbcore: registered new interface driver smsc75xx
[    0.272321] initcall smsc75xx_driver_init+0x0/0x18 returned 0 after 82=
 usecs
[    0.272338] calling  smsc95xx_driver_init+0x0/0x18 @ 1
[    0.272415] usbcore: registered new interface driver smsc95xx
[    0.272430] initcall smsc95xx_driver_init+0x0/0x18 returned 0 after 76=
 usecs
[    0.272447] calling  net1080_driver_init+0x0/0x18 @ 1
[    0.272510] usbcore: registered new interface driver net1080
[    0.272525] initcall net1080_driver_init+0x0/0x18 returned 0 after 63 =
usecs
[    0.272541] calling  cdc_subset_driver_init+0x0/0x18 @ 1
[    0.272602] usbcore: registered new interface driver cdc_subset
[    0.272617] initcall cdc_subset_driver_init+0x0/0x18 returned 0 after =
61 usecs
[    0.272637] calling  zaurus_driver_init+0x0/0x18 @ 1
[    0.272697] usbcore: registered new interface driver zaurus
[    0.272712] initcall zaurus_driver_init+0x0/0x18 returned 0 after 60 u=
secs
[    0.272728] calling  usbnet_init+0x0/0x30 @ 1
[    0.272747] initcall usbnet_init+0x0/0x30 returned 0 after 6 usecs
[    0.272763] calling  cdc_ncm_driver_init+0x0/0x18 @ 1
[    0.272837] usbcore: registered new interface driver cdc_ncm
[    0.272852] initcall cdc_ncm_driver_init+0x0/0x18 returned 0 after 73 =
usecs
[    0.272868] calling  dwc3_driver_init+0x0/0x10 @ 1
[    0.273026] initcall dwc3_driver_init+0x0/0x10 returned 0 after 140 us=
ecs
[    0.273044] calling  dwc3_exynos_driver_init+0x0/0x10 @ 1
[    0.273110] bus: 'platform': driver_probe_device: matched device usb@1=
2000000 with driver exynos-dwc3
[    0.273127] bus: 'platform': really_probe: probing driver exynos-dwc3 =
with device usb@12000000
[    0.273407] exynos-dwc3 usb@12000000: no suspend clk specified
[    0.273446] usb@12000000 supply vdd33 not found, using dummy regulator=

[    0.273499] usb@12000000 supply vdd10 not found, using dummy regulator=

[    0.273738] bus: 'platform': driver_probe_device: matched device 12000=
000.dwc3 with driver dwc3
[    0.273756] bus: 'platform': really_probe: probing driver dwc3 with de=
vice 12000000.dwc3
[    0.474148] driver: 'dwc3': driver_bound: bound to device '12000000.dw=
c3'
[    0.474163] bus: 'platform': really_probe: bound device 12000000.dwc3 =
to driver dwc3
[    0.474182] driver: 'exynos-dwc3': driver_bound: bound to device 'usb@=
12000000'
[    0.474198] bus: 'platform': really_probe: bound device usb@12000000 t=
o driver exynos-dwc3
[    0.474322] initcall dwc3_exynos_driver_init+0x0/0x10 returned 0 after=
 196544 usecs
[    0.474345] calling  dwc2_platform_driver_init+0x0/0x10 @ 1
[    0.474531] initcall dwc2_platform_driver_init+0x0/0x10 returned 0 aft=
er 167 usecs
[    0.474554] calling  xhci_plat_init+0x0/0x2c @ 1
[    0.474694] bus: 'platform': driver_probe_device: matched device xhci-=
hcd.2.auto with driver xhci-hcd
[    0.474712] bus: 'platform': really_probe: probing driver xhci-hcd wit=
h device xhci-hcd.2.auto
[    0.474759] xhci-hcd xhci-hcd.2.auto: xHCI Host Controller
[    0.474785] xhci-hcd xhci-hcd.2.auto: new USB bus registered, assigned=
 bus number 1
[    0.475001] xhci-hcd xhci-hcd.2.auto: hcc params 0x0220f04c hci versio=
n 0x100 quirks 0x00010010
[    0.475044] xhci-hcd xhci-hcd.2.auto: irq 144, io mem 0x12000000
[    0.475153] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    0.475166] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[    0.475182] usb usb1: Product: xHCI Host Controller
[    0.475192] usb usb1: Manufacturer: Linux 4.3.0-rc5-next-20151013-dirt=
y xhci-hcd
[    0.475207] usb usb1: SerialNumber: xhci-hcd.2.auto
[    0.475534] bus: 'usb': driver_probe_device: matched device usb1 with =
driver usb
[    0.475551] bus: 'usb': really_probe: probing driver usb with device u=
sb1
[    0.475689] bus: 'usb': driver_probe_device: matched device 1-0:1.0 wi=
th driver hub
[    0.475706] bus: 'usb': really_probe: probing driver hub with device 1=
-0:1.0
[    0.475736] hub 1-0:1.0: USB hub found
[    0.475764] hub 1-0:1.0: 1 port detected
[    0.475881] driver: 'hub': driver_bound: bound to device '1-0:1.0'
[    0.475895] bus: 'usb': really_probe: bound device 1-0:1.0 to driver h=
ub
[    0.475967] driver: 'usb': driver_bound: bound to device 'usb1'
[    0.475979] bus: 'usb': really_probe: bound device usb1 to driver usb
[    0.476058] xhci-hcd xhci-hcd.2.auto: xHCI Host Controller
[    0.476077] xhci-hcd xhci-hcd.2.auto: new USB bus registered, assigned=
 bus number 2
[    0.476132] usb usb2: We don't know the algorithms for LPM for this ho=
st, disabling LPM.
[    0.476211] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003
[    0.476224] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[    0.476239] usb usb2: Product: xHCI Host Controller
[    0.476250] usb usb2: Manufacturer: Linux 4.3.0-rc5-next-20151013-dirt=
y xhci-hcd
[    0.476265] usb usb2: SerialNumber: xhci-hcd.2.auto
[    0.476551] bus: 'usb': driver_probe_device: matched device usb2 with =
driver usb
[    0.476568] bus: 'usb': really_probe: probing driver usb with device u=
sb2
[    0.476739] bus: 'usb': driver_probe_device: matched device 2-0:1.0 wi=
th driver hub
[    0.476757] bus: 'usb': really_probe: probing driver hub with device 2=
-0:1.0
[    0.476786] hub 2-0:1.0: USB hub found
[    0.476811] hub 2-0:1.0: 1 port detected
[    0.476926] driver: 'hub': driver_bound: bound to device '2-0:1.0'
[    0.476938] bus: 'usb': really_probe: bound device 2-0:1.0 to driver h=
ub
[    0.477007] driver: 'usb': driver_bound: bound to device 'usb2'
[    0.477019] bus: 'usb': really_probe: bound device usb2 to driver usb
[    0.477098] driver: 'xhci-hcd': driver_bound: bound to device 'xhci-hc=
d.2.auto'
[    0.477114] bus: 'platform': really_probe: bound device xhci-hcd.2.aut=
o to driver xhci-hcd
[    0.477176] initcall xhci_plat_init+0x0/0x2c returned 0 after 2546 use=
cs
[    0.477194] calling  ehci_hcd_init+0x0/0x70 @ 1
[    0.477204] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver=

[    0.477217] initcall ehci_hcd_init+0x0/0x70 returned 0 after 10 usecs
[    0.477233] calling  ehci_exynos_init+0x0/0x54 @ 1
[    0.477243] ehci-exynos: EHCI EXYNOS driver
[    0.477322] bus: 'platform': driver_probe_device: matched device 12110=
000.usb with driver exynos-ehci
[    0.477340] bus: 'platform': really_probe: probing driver exynos-ehci =
with device 12110000.usb
[    0.477387] of_get_named_gpiod_flags: parsed 'samsung,vbus-gpio' prope=
rty of node '/usb@12110000[0]' - status (0)
[    0.477587] exynos-ehci 12110000.usb: EHCI Host Controller
[    0.477613] exynos-ehci 12110000.usb: new USB bus registered, assigned=
 bus number 3
[    0.477724] exynos-ehci 12110000.usb: irq 108, io mem 0x12110000
[    0.486728] exynos-ehci 12110000.usb: USB 2.0 started, EHCI 1.00
[    0.486832] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    0.486846] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[    0.486861] usb usb3: Product: EHCI Host Controller
[    0.486871] usb usb3: Manufacturer: Linux 4.3.0-rc5-next-20151013-dirt=
y ehci_hcd
[    0.486886] usb usb3: SerialNumber: 12110000.usb
[    0.487180] bus: 'usb': driver_probe_device: matched device usb3 with =
driver usb
[    0.487197] bus: 'usb': really_probe: probing driver usb with device u=
sb3
[    0.487328] bus: 'usb': driver_probe_device: matched device 3-0:1.0 wi=
th driver hub
[    0.487345] bus: 'usb': really_probe: probing driver hub with device 3=
-0:1.0
[    0.487374] hub 3-0:1.0: USB hub found
[    0.487398] hub 3-0:1.0: 3 ports detected
[    0.487630] driver: 'hub': driver_bound: bound to device '3-0:1.0'
[    0.487643] bus: 'usb': really_probe: bound device 3-0:1.0 to driver h=
ub
[    0.487710] driver: 'usb': driver_bound: bound to device 'usb3'
[    0.487723] bus: 'usb': really_probe: bound device usb3 to driver usb
[    0.487796] driver: 'exynos-ehci': driver_bound: bound to device '1211=
0000.usb'
[    0.487812] bus: 'platform': really_probe: bound device 12110000.usb t=
o driver exynos-ehci
[    0.487937] initcall ehci_exynos_init+0x0/0x54 returned 0 after 10437 =
usecs
[    0.487955] calling  ohci_hcd_mod_init+0x0/0x80 @ 1
[    0.487965] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.487985] initcall ohci_hcd_mod_init+0x0/0x80 returned 0 after 17 us=
ecs
[    0.488002] calling  ohci_exynos_init+0x0/0x54 @ 1
[    0.488011] ohci-exynos: OHCI EXYNOS driver
[    0.488085] bus: 'platform': driver_probe_device: matched device 12120=
000.usb with driver exynos-ohci
[    0.488103] bus: 'platform': really_probe: probing driver exynos-ohci =
with device 12120000.usb
[    0.488179] exynos-ohci 12120000.usb: USB Host Controller
[    0.488204] exynos-ohci 12120000.usb: new USB bus registered, assigned=
 bus number 4
[    0.488279] exynos-ohci 12120000.usb: irq 108, io mem 0x12120000
[    0.545832] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    0.545845] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[    0.545861] usb usb4: Product: USB Host Controller
[    0.545871] usb usb4: Manufacturer: Linux 4.3.0-rc5-next-20151013-dirt=
y ohci_hcd
[    0.545886] usb usb4: SerialNumber: 12120000.usb
[    0.546171] bus: 'usb': driver_probe_device: matched device usb4 with =
driver usb
[    0.546188] bus: 'usb': really_probe: probing driver usb with device u=
sb4
[    0.546322] bus: 'usb': driver_probe_device: matched device 4-0:1.0 wi=
th driver hub
[    0.546339] bus: 'usb': really_probe: probing driver hub with device 4=
-0:1.0
[    0.546368] hub 4-0:1.0: USB hub found
[    0.546394] hub 4-0:1.0: 3 ports detected
[    0.546583] driver: 'hub': driver_bound: bound to device '4-0:1.0'
[    0.546596] bus: 'usb': really_probe: bound device 4-0:1.0 to driver h=
ub
[    0.546667] driver: 'usb': driver_bound: bound to device 'usb4'
[    0.546679] bus: 'usb': really_probe: bound device usb4 to driver usb
[    0.546777] driver: 'exynos-ohci': driver_bound: bound to device '1212=
0000.usb'
[    0.546793] bus: 'platform': really_probe: bound device 12120000.usb t=
o driver exynos-ohci
[    0.546905] initcall ohci_exynos_init+0x0/0x54 returned 0 after 57508 =
usecs
[    0.546923] calling  xhci_hcd_init+0x0/0x8 @ 1
[    0.546935] initcall xhci_hcd_init+0x0/0x8 returned 0 after 0 usecs
[    0.546951] calling  usb_storage_driver_init+0x0/0x38 @ 1
[    0.547053] usbcore: registered new interface driver usb-storage
[    0.547068] initcall usb_storage_driver_init+0x0/0x38 returned 0 after=
 100 usecs
[    0.547089] calling  usb3503_init+0x0/0x54 @ 1
[    0.547304] initcall usb3503_init+0x0/0x54 returned 0 after 196 usecs
[    0.547322] calling  gadget_cfs_init+0x0/0x20 @ 1
[    0.547369] initcall gadget_cfs_init+0x0/0x20 returned 0 after 31 usec=
s
[    0.547386] calling  ecmmod_init+0x0/0xc @ 1
[    0.547399] initcall ecmmod_init+0x0/0xc returned 0 after 1 usecs
[    0.547415] calling  gethmod_init+0x0/0xc @ 1
[    0.547427] initcall gethmod_init+0x0/0xc returned 0 after 0 usecs
[    0.547443] calling  rndismod_init+0x0/0xc @ 1
[    0.547455] initcall rndismod_init+0x0/0xc returned 0 after 0 usecs
[    0.547468] calling  eth_driver_init+0x0/0xc @ 1
[    0.547480] initcall eth_driver_init+0x0/0xc returned -19 after 1 usec=
s
[    0.547492] calling  serport_init+0x0/0x30 @ 1
[    0.547504] initcall serport_init+0x0/0x30 returned 0 after 0 usecs
[    0.547516] calling  input_leds_init+0x0/0xc @ 1
[    0.547529] initcall input_leds_init+0x0/0xc returned 0 after 1 usecs
[    0.547542] calling  mousedev_init+0x0/0x88 @ 1
[    0.547799] mousedev: PS/2 mouse device common for all mice
[    0.547813] initcall mousedev_init+0x0/0x88 returned 0 after 254 usecs=

[    0.547827] calling  evdev_init+0x0/0xc @ 1
[    0.547839] initcall evdev_init+0x0/0xc returned 0 after 1 usecs
[    0.547851] calling  atkbd_init+0x0/0x18 @ 1
[    0.547929] initcall atkbd_init+0x0/0x18 returned 0 after 63 usecs
[    0.547944] calling  cros_ec_keyb_driver_init+0x0/0x10 @ 1
[    0.548078] initcall cros_ec_keyb_driver_init+0x0/0x10 returned 0 afte=
r 118 usecs
[    0.548097] calling  samsung_keypad_driver_init+0x0/0x10 @ 1
[    0.548243] initcall samsung_keypad_driver_init+0x0/0x10 returned 0 af=
ter 129 usecs
[    0.548261] calling  cyapa_driver_init+0x0/0x10 @ 1
[    0.548283] bus: 'i2c': driver_probe_device: matched device 1-0067 wit=
h driver cyapa
[    0.548304] bus: 'i2c': really_probe: probing driver cyapa with device=
 1-0067
[    0.548768] 1-0067 supply vcc not found, using dummy regulator
[    0.597006] input: Cypress APA Trackpad (cyapa) as /devices/platform/1=
2c70000.i2c/i2c-1/1-0067/input/input0
[    0.597269] driver: 'cyapa': driver_bound: bound to device '1-0067'
[    0.597282] bus: 'i2c': really_probe: bound device 1-0067 to driver cy=
apa
[    0.597360] initcall cyapa_driver_init+0x0/0x10 returned 0 after 47935=
 usecs
[    0.597376] calling  mxt_driver_init+0x0/0x10 @ 1
[    0.597448] initcall mxt_driver_init+0x0/0x10 returned 0 after 57 usec=
s
[    0.597463] calling  max77686_rtc_driver_init+0x0/0x10 @ 1
[    0.597521] bus: 'platform': driver_probe_device: matched device max77=
686-rtc with driver max77686-rtc
[    0.597539] bus: 'platform': really_probe: probing driver max77686-rtc=
 with device max77686-rtc
[    0.597572] max77686-rtc max77686-rtc: max77686_rtc_probe
[    0.697208] max77686-rtc max77686-rtc: rtc core: registered max77686-r=
tc as rtc0
[    0.697535] driver: 'max77686-rtc': driver_bound: bound to device 'max=
77686-rtc'
[    0.697552] bus: 'platform': really_probe: bound device max77686-rtc t=
o driver max77686-rtc
[    0.697626] initcall max77686_rtc_driver_init+0x0/0x10 returned 0 afte=
r 97801 usecs
[    0.697645] calling  max77802_rtc_driver_init+0x0/0x10 @ 1
[    0.697741] initcall max77802_rtc_driver_init+0x0/0x10 returned 0 afte=
r 80 usecs
[    0.697759] calling  s3c_rtc_driver_init+0x0/0x10 @ 1
[    0.697795] bus: 'platform': driver_probe_device: matched device 101e0=
000.rtc with driver s3c-rtc
[    0.697812] bus: 'platform': really_probe: probing driver s3c-rtc with=
 device 101e0000.rtc
[    0.697909] s3c-rtc 101e0000.rtc: failed to find rtc source clock
[    0.697936] platform 101e0000.rtc: Driver s3c-rtc requests probe defer=
ral
[    0.697949] platform 101e0000.rtc: Added to deferred list
[    0.698141] initcall s3c_rtc_driver_init+0x0/0x10 returned 0 after 359=
 usecs
[    0.698156] calling  s5m_rtc_driver_init+0x0/0x10 @ 1
[    0.698246] initcall s5m_rtc_driver_init+0x0/0x10 returned 0 after 74 =
usecs
[    0.698260] calling  i2c_dev_init+0x0/0xe0 @ 1
[    0.698270] i2c /dev entries driver
[    0.699243] initcall i2c_dev_init+0x0/0xe0 returned 0 after 946 usecs
[    0.699259] calling  exynos5_i2c_driver_init+0x0/0x10 @ 1
[    0.699457] initcall exynos5_i2c_driver_init+0x0/0x10 returned 0 after=
 180 usecs
[    0.699477] calling  ec_i2c_tunnel_driver_init+0x0/0x10 @ 1
[    0.699602] initcall ec_i2c_tunnel_driver_init+0x0/0x10 returned 0 aft=
er 109 usecs
[    0.699621] calling  i2c_arbitrator_driver_init+0x0/0x10 @ 1
[    0.699699] bus: 'platform': driver_probe_device: matched device i2c-a=
rbitrator with driver i2c-arb-gpio-challenge
[    0.699718] bus: 'platform': really_probe: probing driver i2c-arb-gpio=
-challenge with device i2c-arbitrator
[    0.699808] of_get_named_gpiod_flags: parsed 'our-claim-gpio' property=
 of node '/i2c-arbitrator[0]' - status (0)
[    0.699839] of_get_named_gpiod_flags: parsed 'their-claim-gpios' prope=
rty of node '/i2c-arbitrator[0]' - status (0)
[    0.699866] of_get_named_gpiod_flags: can't parse 'their-claim-gpios' =
property of node '/i2c-arbitrator[1]'
[    0.700358] bus: 'i2c': driver_probe_device: matched device 104-001e w=
ith driver cros-ec-i2c
[    0.700375] bus: 'i2c': really_probe: probing driver cros-ec-i2c with =
device 104-001e
[    0.708772] bus: 'platform': driver_probe_device: matched device i2c-a=
rbitrator:i2c@0:embedded-controller:keyboard-controller with driver cros-=
ec-keyb
[    0.708793] bus: 'platform': really_probe: probing driver cros-ec-keyb=
 with device i2c-arbitrator:i2c@0:embedded-controller:keyboard-controller=

[    0.709002] input: cros_ec as /devices/platform/12ca0000.i2c/i2c-4/i2c=
-104/104-001e/i2c-arbitrator:i2c@0:embedded-controller:keyboard-controlle=
r/input/input1
[    0.709218] driver: 'cros-ec-keyb': driver_bound: bound to device 'i2c=
-arbitrator:i2c@0:embedded-controller:keyboard-controller'
[    0.709238] bus: 'platform': really_probe: bound device i2c-arbitrator=
:i2c@0:embedded-controller:keyboard-controller to driver cros-ec-keyb
[    0.709261] cros-ec-i2c 104-001e: Chrome EC device registered
[    0.709272] driver: 'cros-ec-i2c': driver_bound: bound to device '104-=
001e'
[    0.709284] bus: 'i2c': really_probe: bound device 104-001e to driver =
cros-ec-i2c
[    0.709397] bus: 'i2c': driver_probe_device: matched device 104-0048 w=
ith driver tps65090
[    0.709414] bus: 'i2c': really_probe: probing driver tps65090 with dev=
ice 104-0048
[    0.709500] tps65090 104-0048: No cache defaults, reading back from HW=

[    0.713554] bus: 'platform': driver_probe_device: matched device tps65=
090-pmic with driver tps65090-pmic
[    0.713572] bus: 'platform': really_probe: probing driver tps65090-pmi=
c with device tps65090-pmic
[    0.713701] of_get_named_gpiod_flags: can't parse 'dcdc-ext-control-gp=
ios' property of node '/i2c-arbitrator/i2c@0/power-regulator[0]'
[    0.713719] of_get_named_gpiod_flags: can't parse 'dcdc-ext-control-gp=
ios' property of node '/i2c-arbitrator/i2c@0/power-regulator[0]'
[    0.713737] of_get_named_gpiod_flags: can't parse 'dcdc-ext-control-gp=
ios' property of node '/i2c-arbitrator/i2c@0/power-regulator[0]'
[    0.727363] driver: 'tps65090-pmic': driver_bound: bound to device 'tp=
s65090-pmic'
[    0.727384] bus: 'platform': really_probe: bound device tps65090-pmic =
to driver tps65090-pmic
[    0.727564] driver: 'tps65090': driver_bound: bound to device '104-004=
8'
[    0.727578] bus: 'i2c': really_probe: bound device 104-0048 to driver =
tps65090
[    0.727614] i2c i2c-4: Added multiplexed i2c bus 104
[    0.727624] driver: 'i2c-arb-gpio-challenge': driver_bound: bound to d=
evice 'i2c-arbitrator'
[    0.727640] bus: 'platform': really_probe: bound device i2c-arbitrator=
 to driver i2c-arb-gpio-challenge
[    0.727716] initcall i2c_arbitrator_driver_init+0x0/0x10 returned 0 af=
ter 27422 usecs
[    0.727737] calling  sbs_battery_driver_init+0x0/0x10 @ 1
[    0.727771] bus: 'i2c': driver_probe_device: matched device 104-000b w=
ith driver sbs-battery
[    0.727788] bus: 'i2c': really_probe: probing driver sbs-battery with =
device 104-000b
[    0.730061] sbs-battery 104-000b: sbs-battery: battery gas gauge devic=
e registered
[    0.730078] driver: 'sbs-battery': driver_bound: bound to device '104-=
000b'
[    0.730090] bus: 'i2c': really_probe: bound device 104-000b to driver =
sbs-battery
[    0.730159] initcall sbs_battery_driver_init+0x0/0x10 returned 0 after=
 2352 usecs
[    0.730178] calling  max17040_i2c_driver_init+0x0/0x10 @ 1
[    0.730248] initcall max17040_i2c_driver_init+0x0/0x10 returned 0 afte=
r 55 usecs
[    0.730267] calling  max17042_i2c_driver_init+0x0/0x10 @ 1
[    0.730344] initcall max17042_i2c_driver_init+0x0/0x10 returned 0 afte=
r 62 usecs
[    0.730363] calling  max14577_charger_driver_init+0x0/0x10 @ 1
[    0.730471] initcall max14577_charger_driver_init+0x0/0x10 returned 0 =
after 92 usecs
[    0.730490] calling  max77693_charger_driver_init+0x0/0x10 @ 1
[    0.730583] initcall max77693_charger_driver_init+0x0/0x10 returned 0 =
after 78 usecs
[    0.730602] calling  tps65090_charger_driver_init+0x0/0x10 @ 1
[    0.730712] bus: 'platform': driver_probe_device: matched device tps65=
090-charger with driver tps65090-charger
[    0.730731] bus: 'platform': really_probe: probing driver tps65090-cha=
rger with device tps65090-charger
[    0.732656] driver: 'tps65090-charger': driver_bound: bound to device =
'tps65090-charger'
[    0.732674] bus: 'platform': really_probe: bound device tps65090-charg=
er to driver tps65090-charger
[    0.732735] initcall tps65090_charger_driver_init+0x0/0x10 returned 0 =
after 2068 usecs
[    0.732754] calling  ina2xx_driver_init+0x0/0x10 @ 1
[    0.732829] initcall ina2xx_driver_init+0x0/0x10 returned 0 after 60 u=
secs
[    0.732844] calling  lm90_driver_init+0x0/0x10 @ 1
[    0.732917] initcall lm90_driver_init+0x0/0x10 returned 0 after 59 use=
cs
[    0.732932] calling  ntc_thermistor_driver_init+0x0/0x10 @ 1
[    0.733197] initcall ntc_thermistor_driver_init+0x0/0x10 returned 0 af=
ter 245 usecs
[    0.733216] calling  pwm_fan_driver_init+0x0/0x10 @ 1
[    0.733344] initcall pwm_fan_driver_init+0x0/0x10 returned 0 after 111=
 usecs
[    0.733359] calling  exynos_tmu_driver_init+0x0/0x10 @ 1
[    0.733457] bus: 'platform': driver_probe_device: matched device 10060=
000.tmu with driver exynos-tmu
[    0.733474] bus: 'platform': really_probe: probing driver exynos-tmu w=
ith device 10060000.tmu
[    0.733535] thermal thermal_zone0: failed to read out thermal zone (-2=
2)
[    0.733583] 10060000.tmu supply vtmu not found, using dummy regulator
[    0.733713] driver: 'exynos-tmu': driver_bound: bound to device '10060=
000.tmu'
[    0.733730] bus: 'platform': really_probe: bound device 10060000.tmu t=
o driver exynos-tmu
[    0.733960] initcall exynos_tmu_driver_init+0x0/0x10 returned 0 after =
573 usecs
[    0.733981] calling  s3c2410wdt_driver_init+0x0/0x10 @ 1
[    0.734041] bus: 'platform': driver_probe_device: matched device 101d0=
000.watchdog with driver s3c2410-wdt
[    0.734059] bus: 'platform': really_probe: probing driver s3c2410-wdt =
with device 101d0000.watchdog
[    0.734400] s3c2410-wdt 101d0000.watchdog: watchdog inactive, reset di=
sabled, irq disabled
[    0.734418] driver: 's3c2410-wdt': driver_bound: bound to device '101d=
0000.watchdog'
[    0.734433] bus: 'platform': really_probe: bound device 101d0000.watch=
dog to driver s3c2410-wdt
[    0.734587] initcall s3c2410wdt_driver_init+0x0/0x10 returned 0 after =
579 usecs
[    0.734606] calling  dm_init+0x0/0x54 @ 1
[    0.734926] device-mapper: ioctl: 4.33.0-ioctl (2015-8-18) initialised=
: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    0.734945] initcall dm_init+0x0/0x54 returned 0 after 319 usecs
[    0.734960] calling  cpufreq_stats_init+0x0/0xe8 @ 1
[    0.734974] initcall cpufreq_stats_init+0x0/0xe8 returned 0 after 2 us=
ecs
[    0.734989] calling  dt_cpufreq_platdrv_init+0x0/0x10 @ 1
[    0.735012] bus: 'platform': driver_probe_device: matched device cpufr=
eq-dt with driver cpufreq-dt
[    0.735029] bus: 'platform': really_probe: probing driver cpufreq-dt w=
ith device cpufreq-dt
[    0.736234] driver: 'cpufreq-dt': driver_bound: bound to device 'cpufr=
eq-dt'
[    0.736249] bus: 'platform': really_probe: bound device cpufreq-dt to =
driver cpufreq-dt
[    0.736348] initcall dt_cpufreq_platdrv_init+0x0/0x10 returned 0 after=
 1313 usecs
[    0.736368] calling  exynos_cpufreq_platdrv_init+0x0/0x10 @ 1
[    0.736517] initcall exynos_cpufreq_platdrv_init+0x0/0x10 returned 0 a=
fter 131 usecs
[    0.736537] calling  exynos_cpuidle_driver_init+0x0/0x10 @ 1
[    0.736558] bus: 'platform': driver_probe_device: matched device exyno=
s_cpuidle with driver exynos_cpuidle
[    0.736576] bus: 'platform': really_probe: probing driver exynos_cpuid=
le with device exynos_cpuidle
[    0.736860] driver: 'exynos_cpuidle': driver_bound: bound to device 'e=
xynos_cpuidle'
[    0.736878] bus: 'platform': really_probe: bound device exynos_cpuidle=
 to driver exynos_cpuidle
[    0.736979] initcall exynos_cpuidle_driver_init+0x0/0x10 returned 0 af=
ter 418 usecs
[    0.736999] calling  mmc_blk_init+0x0/0x98 @ 1
[    0.737056] initcall mmc_blk_init+0x0/0x98 returned 0 after 43 usecs
[    0.737072] calling  sdhci_drv_init+0x0/0x24 @ 1
[    0.737082] sdhci: Secure Digital Host Controller Interface driver
[    0.737092] sdhci: Copyright(c) Pierre Ossman
[    0.737103] initcall sdhci_drv_init+0x0/0x24 returned 0 after 18 usecs=

[    0.737124] calling  sdhci_s3c_driver_init+0x0/0x10 @ 1
[    0.737293] initcall sdhci_s3c_driver_init+0x0/0x10 returned 0 after 1=
51 usecs
[    0.737312] calling  dw_mci_init+0x0/0x18 @ 1
[    0.737321] Synopsys Designware Multimedia Card Interface Driver
[    0.737333] initcall dw_mci_init+0x0/0x18 returned 0 after 9 usecs
[    0.737348] calling  dw_mci_pltfm_driver_init+0x0/0x10 @ 1
[    0.737504] initcall dw_mci_pltfm_driver_init+0x0/0x10 returned 0 afte=
r 139 usecs
[    0.737523] calling  dw_mci_exynos_pltfm_driver_init+0x0/0x10 @ 1
[    0.737752] bus: 'platform': driver_probe_device: matched device 12200=
000.mmc with driver dwmmc_exynos
[    0.737770] bus: 'platform': really_probe: probing driver dwmmc_exynos=
 with device 12200000.mmc
[    0.738028] dwmmc_exynos 12200000.mmc: IDMAC supports 32-bit address m=
ode.
[    0.738082] dwmmc_exynos 12200000.mmc: Using internal DMA controller.
[    0.738098] dwmmc_exynos 12200000.mmc: Version ID is 241a
[    0.738136] dwmmc_exynos 12200000.mmc: DW MMC controller at irq 105,32=
 bit host data width,128 deep fifo
[    0.738208] dwmmc_exynos 12200000.mmc: No vmmc regulator found
[    0.738220] dwmmc_exynos 12200000.mmc: No vqmmc regulator found
[    0.738237] dwmmc_exynos 12200000.mmc: GPIO lookup for consumer cd
[    0.738248] dwmmc_exynos 12200000.mmc: using device tree for GPIO look=
up
[    0.738261] of_get_named_gpiod_flags: can't parse 'cd-gpios' property =
of node '/mmc@12200000[0]'
[    0.738277] of_get_named_gpiod_flags: can't parse 'cd-gpio' property o=
f node '/mmc@12200000[0]'
[    0.738293] dwmmc_exynos 12200000.mmc: using lookup tables for GPIO lo=
okup
[    0.738305] dwmmc_exynos 12200000.mmc: lookup for GPIO cd failed
[    0.738317] dwmmc_exynos 12200000.mmc: GPIO lookup for consumer wp
[    0.738328] dwmmc_exynos 12200000.mmc: using device tree for GPIO look=
up
[    0.738344] of_get_named_gpiod_flags: can't parse 'wp-gpios' property =
of node '/mmc@12200000[0]'
[    0.738359] of_get_named_gpiod_flags: can't parse 'wp-gpio' property o=
f node '/mmc@12200000[0]'
[    0.738375] dwmmc_exynos 12200000.mmc: using lookup tables for GPIO lo=
okup
[    0.738386] dwmmc_exynos 12200000.mmc: lookup for GPIO wp failed
[    0.766769] dwmmc_exynos 12200000.mmc: 1 slots initialized
[    0.766782] driver: 'dwmmc_exynos': driver_bound: bound to device '122=
00000.mmc'
[    0.766799] bus: 'platform': really_probe: bound device 12200000.mmc t=
o driver dwmmc_exynos
[    0.766820] bus: 'platform': driver_probe_device: matched device 12220=
000.mmc with driver dwmmc_exynos
[    0.766837] bus: 'platform': really_probe: probing driver dwmmc_exynos=
 with device 12220000.mmc
[    0.767133] dwmmc_exynos 12220000.mmc: IDMAC supports 32-bit address m=
ode.
[    0.767170] dwmmc_exynos 12220000.mmc: Using internal DMA controller.
[    0.767186] dwmmc_exynos 12220000.mmc: Version ID is 241a
[    0.767220] dwmmc_exynos 12220000.mmc: DW MMC controller at irq 106,32=
 bit host data width,128 deep fifo
[    0.767287] dwmmc_exynos 12220000.mmc: No vmmc regulator found
[    0.767298] dwmmc_exynos 12220000.mmc: No vqmmc regulator found
[    0.767315] dwmmc_exynos 12220000.mmc: GPIO lookup for consumer cd
[    0.767326] dwmmc_exynos 12220000.mmc: using device tree for GPIO look=
up
[    0.767338] of_get_named_gpiod_flags: can't parse 'cd-gpios' property =
of node '/mmc@12220000[0]'
[    0.767355] of_get_named_gpiod_flags: can't parse 'cd-gpio' property o=
f node '/mmc@12220000[0]'
[    0.767370] dwmmc_exynos 12220000.mmc: using lookup tables for GPIO lo=
okup
[    0.767382] dwmmc_exynos 12220000.mmc: lookup for GPIO cd failed
[    0.767394] dwmmc_exynos 12220000.mmc: GPIO lookup for consumer wp
[    0.767405] dwmmc_exynos 12220000.mmc: using device tree for GPIO look=
up
[    0.767420] of_get_named_gpiod_flags: parsed 'wp-gpios' property of no=
de '/mmc@12220000[0]' - status (0)
[    0.767449] dwmmc_exynos 12220000.mmc: Got WP GPIO
[    0.781730] usb 1-1: new high-speed USB device number 2 using xhci-hcd=

[    0.796758] dwmmc_exynos 12220000.mmc: 1 slots initialized
[    0.796773] driver: 'dwmmc_exynos': driver_bound: bound to device '122=
20000.mmc'
[    0.796789] bus: 'platform': really_probe: bound device 12220000.mmc t=
o driver dwmmc_exynos
[    0.796810] bus: 'platform': driver_probe_device: matched device 12230=
000.mmc with driver dwmmc_exynos
[    0.796827] bus: 'platform': really_probe: probing driver dwmmc_exynos=
 with device 12230000.mmc
[    0.797098] dwmmc_exynos 12230000.mmc: IDMAC supports 32-bit address m=
ode.
[    0.797138] dwmmc_exynos 12230000.mmc: Using internal DMA controller.
[    0.797154] dwmmc_exynos 12230000.mmc: Version ID is 241a
[    0.797188] dwmmc_exynos 12230000.mmc: DW MMC controller at irq 107,32=
 bit host data width,128 deep fifo
[    0.797250] dwmmc_exynos 12230000.mmc: No vmmc regulator found
[    0.797261] dwmmc_exynos 12230000.mmc: No vqmmc regulator found
[    0.797277] dwmmc_exynos 12230000.mmc: GPIO lookup for consumer cd
[    0.797289] dwmmc_exynos 12230000.mmc: using device tree for GPIO look=
up
[    0.797301] of_get_named_gpiod_flags: can't parse 'cd-gpios' property =
of node '/mmc@12230000[0]'
[    0.797318] of_get_named_gpiod_flags: can't parse 'cd-gpio' property o=
f node '/mmc@12230000[0]'
[    0.797333] dwmmc_exynos 12230000.mmc: using lookup tables for GPIO lo=
okup
[    0.797345] dwmmc_exynos 12230000.mmc: lookup for GPIO cd failed
[    0.797357] dwmmc_exynos 12230000.mmc: GPIO lookup for consumer wp
[    0.797368] dwmmc_exynos 12230000.mmc: using device tree for GPIO look=
up
[    0.797379] of_get_named_gpiod_flags: can't parse 'wp-gpios' property =
of node '/mmc@12230000[0]'
[    0.797395] of_get_named_gpiod_flags: can't parse 'wp-gpio' property o=
f node '/mmc@12230000[0]'
[    0.797410] dwmmc_exynos 12230000.mmc: using lookup tables for GPIO lo=
okup
[    0.797422] dwmmc_exynos 12230000.mmc: lookup for GPIO wp failed
[    0.797554] platform 12230000.mmc: Driver dwmmc_exynos requests probe =
deferral
[    0.797570] platform 12230000.mmc: Added to deferred list
[    0.797714] initcall dw_mci_exynos_pltfm_driver_init+0x0/0x10 returned=
 0 after 58764 usecs
[    0.797735] calling  gpio_led_driver_init+0x0/0x10 @ 1
[    0.797862] initcall gpio_led_driver_init+0x0/0x10 returned 0 after 11=
1 usecs
[    0.797879] calling  led_pwm_driver_init+0x0/0x10 @ 1
[    0.797990] initcall led_pwm_driver_init+0x0/0x10 returned 0 after 95 =
usecs
[    0.798006] calling  heartbeat_trig_init+0x0/0x40 @ 1
[    0.798021] initcall heartbeat_trig_init+0x0/0x40 returned 0 after 2 u=
secs
[    0.798035] calling  hid_init+0x0/0x54 @ 1
[    0.798086] initcall hid_init+0x0/0x54 returned 0 after 38 usecs
[    0.798101] calling  hid_generic_init+0x0/0x18 @ 1
[    0.798146] initcall hid_generic_init+0x0/0x18 returned 0 after 32 use=
cs
[    0.798161] calling  a4_driver_init+0x0/0x18 @ 1
[    0.798201] initcall a4_driver_init+0x0/0x18 returned 0 after 26 usecs=

[    0.798216] calling  apple_driver_init+0x0/0x18 @ 1
[    0.798266] initcall apple_driver_init+0x0/0x18 returned 0 after 37 us=
ecs
[    0.798282] calling  belkin_driver_init+0x0/0x18 @ 1
[    0.798326] initcall belkin_driver_init+0x0/0x18 returned 0 after 31 u=
secs
[    0.798342] calling  ch_driver_init+0x0/0x18 @ 1
[    0.798380] initcall ch_driver_init+0x0/0x18 returned 0 after 25 usecs=

[    0.798395] calling  ch_driver_init+0x0/0x18 @ 1
[    0.798432] initcall ch_driver_init+0x0/0x18 returned 0 after 25 usecs=

[    0.798447] calling  cp_driver_init+0x0/0x18 @ 1
[    0.798484] initcall cp_driver_init+0x0/0x18 returned 0 after 25 usecs=

[    0.798499] calling  ez_driver_init+0x0/0x18 @ 1
[    0.798538] initcall ez_driver_init+0x0/0x18 returned 0 after 26 usecs=

[    0.798553] calling  ks_driver_init+0x0/0x18 @ 1
[    0.798590] initcall ks_driver_init+0x0/0x18 returned 0 after 25 usecs=

[    0.798605] calling  lg_driver_init+0x0/0x18 @ 1
[    0.798642] initcall lg_driver_init+0x0/0x18 returned 0 after 25 usecs=

[    0.798657] calling  ms_driver_init+0x0/0x18 @ 1
[    0.798695] initcall ms_driver_init+0x0/0x18 returned 0 after 25 usecs=

[    0.798710] calling  mr_driver_init+0x0/0x18 @ 1
[    0.798750] initcall mr_driver_init+0x0/0x18 returned 0 after 28 usecs=

[    0.798765] calling  hid_init+0x0/0x5c @ 1
[    0.798829] usbcore: registered new interface driver usbhid
[    0.798840] usbhid: USB HID core driver
[    0.798851] initcall hid_init+0x0/0x5c returned 0 after 72 usecs
[    0.798866] calling  cros_ec_dev_init+0x0/0xd4 @ 1
[    0.798938] bus: 'platform': driver_probe_device: matched device cros-=
ec-ctl.3.auto with driver cros-ec-ctl
[    0.798956] bus: 'platform': really_probe: probing driver cros-ec-ctl =
with device cros-ec-ctl.3.auto
[    0.799149] driver: 'cros-ec-ctl': driver_bound: bound to device 'cros=
-ec-ctl.3.auto'
[    0.799167] bus: 'platform': really_probe: bound device cros-ec-ctl.3.=
auto to driver cros-ec-ctl
[    0.799207] initcall cros_ec_dev_init+0x0/0xd4 returned 0 after 320 us=
ecs
[    0.799224] calling  max77686_clk_driver_init+0x0/0x10 @ 1
[    0.799282] bus: 'platform': driver_probe_device: matched device max77=
686-clk with driver max77686-clk
[    0.799300] bus: 'platform': really_probe: probing driver max77686-clk=
 with device max77686-clk
[    0.799407] driver: 'max77686-clk': driver_bound: bound to device 'max=
77686-clk'
[    0.799423] bus: 'platform': really_probe: bound device max77686-clk t=
o driver max77686-clk
[    0.799475] initcall max77686_clk_driver_init+0x0/0x10 returned 0 afte=
r 230 usecs
[    0.799495] calling  max77802_clk_driver_init+0x0/0x10 @ 1
[    0.799570] initcall max77802_clk_driver_init+0x0/0x10 returned 0 afte=
r 60 usecs
[    0.799593] calling  extcon_class_init+0x0/0x20 @ 1
[    0.799622] initcall extcon_class_init+0x0/0x20 returned 0 after 15 us=
ecs
[    0.799639] calling  max14577_muic_driver_init+0x0/0x10 @ 1
[    0.799714] initcall max14577_muic_driver_init+0x0/0x10 returned 0 aft=
er 59 usecs
[    0.799736] calling  max77693_muic_driver_init+0x0/0x10 @ 1
[    0.799811] initcall max77693_muic_driver_init+0x0/0x10 returned 0 aft=
er 61 usecs
[    0.799832] calling  exynos_adc_driver_init+0x0/0x10 @ 1
[    0.800196] initcall exynos_adc_driver_init+0x0/0x10 returned 0 after =
341 usecs
[    0.800219] calling  alsa_timer_init+0x0/0x200 @ 1
[    0.800366] initcall alsa_timer_init+0x0/0x200 returned 0 after 129 us=
ecs
[    0.800385] calling  alsa_pcm_init+0x0/0x6c @ 1
[    0.800402] initcall alsa_pcm_init+0x0/0x6c returned 0 after 4 usecs
[    0.800419] calling  snd_compress_init+0x0/0x8 @ 1
[    0.800431] initcall snd_compress_init+0x0/0x8 returned 0 after 0 usec=
s
[    0.800447] calling  snd_soc_init+0x0/0x11c @ 1
[    0.800636] bus: 'platform': driver_probe_device: matched device snd-s=
oc-dummy with driver snd-soc-dummy
[    0.800654] bus: 'platform': really_probe: probing driver snd-soc-dumm=
y with device snd-soc-dummy
[    0.800697] driver: 'snd-soc-dummy': driver_bound: bound to device 'sn=
d-soc-dummy'
[    0.800714] bus: 'platform': really_probe: bound device snd-soc-dummy =
to driver snd-soc-dummy
[    0.800818] initcall snd_soc_init+0x0/0x11c returned 0 after 349 usecs=

[    0.800845] calling  max98090_i2c_driver_init+0x0/0x10 @ 1
[    0.800912] initcall max98090_i2c_driver_init+0x0/0x10 returned 0 afte=
r 51 usecs
[    0.800934] calling  max98095_i2c_driver_init+0x0/0x10 @ 1
[    0.800958] bus: 'i2c': driver_probe_device: matched device 7-0011 wit=
h driver max98095
[    0.800979] bus: 'i2c': really_probe: probing driver max98095 with dev=
ice 7-0011
[    0.801145] driver: 'max98095': driver_bound: bound to device '7-0011'=

[    0.801159] bus: 'i2c': really_probe: bound device 7-0011 to driver ma=
x98095
[    0.801212] initcall max98095_i2c_driver_init+0x0/0x10 returned 0 afte=
r 256 usecs
[    0.801234] calling  asoc_simple_card_init+0x0/0x10 @ 1
[    0.801356] initcall asoc_simple_card_init+0x0/0x10 returned 0 after 1=
05 usecs
[    0.801378] calling  samsung_i2s_driver_init+0x0/0x10 @ 1
[    0.801468] bus: 'platform': driver_probe_device: matched device 38300=
00.i2s with driver samsung-i2s
[    0.801485] bus: 'platform': really_probe: probing driver samsung-i2s =
with device 3830000.i2s
[    0.801739] bus: 'platform': driver_probe_device: matched device samsu=
ng-i2s-sec with driver samsung-i2s
[    0.801758] bus: 'platform': really_probe: probing driver samsung-i2s =
with device samsung-i2s-sec
[    0.801798] driver: 'samsung-i2s': driver_bound: bound to device 'sams=
ung-i2s-sec'
[    0.801814] bus: 'platform': really_probe: bound device samsung-i2s-se=
c to driver samsung-i2s
[    0.801840] driver: 'samsung-i2s': driver_bound: bound to device '3830=
000.i2s'
[    0.801855] bus: 'platform': really_probe: bound device 3830000.i2s to=
 driver samsung-i2s
[    0.801982] initcall samsung_i2s_driver_init+0x0/0x10 returned 0 after=
 574 usecs
[    0.802004] calling  asoc_idma_driver_init+0x0/0x10 @ 1
[    0.802078] initcall asoc_idma_driver_init+0x0/0x10 returned 0 after 5=
9 usecs
[    0.802096] calling  snow_driver_init+0x0/0x10 @ 1
[    0.802200] bus: 'platform': driver_probe_device: matched device sound=
 with driver snow-audio
[    0.802217] bus: 'platform': really_probe: probing driver snow-audio w=
ith device sound
[    0.825682] mmc0: MAN_BKOPS_EN bit is not set
[    0.828300] mmc_host mmc0: Bus speed (slot 0) =3D 50000000Hz (slot req=
 52000000Hz, actual 50000000HZ div =3D 0)
[    0.829748] mmc_host mmc0: Bus speed (slot 0) =3D 100000000Hz (slot re=
q 52000000Hz, actual 50000000HZ div =3D 1)
[    0.830247] mmc0: new DDR MMC card at address 0001
[    0.830645] bus: 'mmc': driver_probe_device: matched device mmc0:0001 =
with driver mmcblk
[    0.830694] bus: 'mmc': really_probe: probing driver mmcblk with devic=
e mmc0:0001
[    0.831127] mmcblk0: mmc0:0001 SEM16G 14.6 GiB=20
[    0.831432] mmcblk0boot0: mmc0:0001 SEM16G partition 1 2.00 MiB
[    0.831814] mmcblk0boot1: mmc0:0001 SEM16G partition 2 2.00 MiB
[    0.832102] mmcblk0rpmb: mmc0:0001 SEM16G partition 3 128 KiB
[    0.836941]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12
[    0.844786] driver: 'mmcblk': driver_bound: bound to device 'mmc0:0001=
'
[    0.844826] bus: 'mmc': really_probe: bound device mmc0:0001 to driver=
 mmcblk
[    0.870562] max98095 7-0011: Hardware revision: C
[    0.879992] snow-audio sound: HiFi <-> 3830000.i2s mapping ok
[    0.880747] max98095 7-0011: ASoC: mux External MIC has no paths
[    0.880794] max98095 7-0011: ASoC: mux Linein Mux has no paths
[    0.883662] driver: 'snow-audio': driver_bound: bound to device 'sound=
'
[    0.883702] bus: 'platform': really_probe: bound device sound to drive=
r snow-audio
[    0.883860] initcall snow_driver_init+0x0/0x10 returned 0 after 79820 =
usecs
[    0.883913] calling  odroidx2_audio_driver_init+0x0/0x10 @ 1
[    0.884323] initcall odroidx2_audio_driver_init+0x0/0x10 returned 0 af=
ter 361 usecs
[    0.884375] calling  sock_diag_init+0x0/0x50 @ 1
[    0.884457] initcall sock_diag_init+0x0/0x50 returned 0 after 46 usecs=

[    0.884500] calling  gre_offload_init+0x0/0x10 @ 1
[    0.884533] initcall gre_offload_init+0x0/0x10 returned 0 after 1 usec=
s
[    0.884571] calling  sysctl_ipv4_init+0x0/0x54 @ 1
[    0.884768] initcall sysctl_ipv4_init+0x0/0x54 returned 0 after 160 us=
ecs
[    0.884808] calling  xfrm4_beet_init+0x0/0x10 @ 1
[    0.884842] initcall xfrm4_beet_init+0x0/0x10 returned 0 after 2 usecs=

[    0.884880] calling  tunnel4_init+0x0/0x70 @ 1
[    0.884911] initcall tunnel4_init+0x0/0x70 returned 0 after 1 usecs
[    0.884949] calling  xfrm4_transport_init+0x0/0x10 @ 1
[    0.884981] initcall xfrm4_transport_init+0x0/0x10 returned 0 after 1 =
usecs
[    0.885020] calling  xfrm4_mode_tunnel_init+0x0/0x10 @ 1
[    0.885053] initcall xfrm4_mode_tunnel_init+0x0/0x10 returned 0 after =
1 usecs
[    0.885091] calling  inet_diag_init+0x0/0x88 @ 1
[    0.885128] initcall inet_diag_init+0x0/0x88 returned 0 after 6 usecs
[    0.885165] calling  tcp_diag_init+0x0/0xc @ 1
[    0.885197] initcall tcp_diag_init+0x0/0xc returned 0 after 2 usecs
[    0.885234] calling  cubictcp_register+0x0/0x64 @ 1
[    0.885267] initcall cubictcp_register+0x0/0x64 returned 0 after 2 use=
cs
[    0.885305] calling  inet6_init+0x0/0x2c0 @ 1
[    0.887211] NET: Registered protocol family 10
[    0.893144] initcall inet6_init+0x0/0x2c0 returned 0 after 7619 usecs
[    0.893192] calling  xfrm6_transport_init+0x0/0x10 @ 1
[    0.893227] initcall xfrm6_transport_init+0x0/0x10 returned 0 after 1 =
usecs
[    0.893268] calling  xfrm6_mode_tunnel_init+0x0/0x10 @ 1
[    0.893302] initcall xfrm6_mode_tunnel_init+0x0/0x10 returned 0 after =
1 usecs
[    0.893343] calling  xfrm6_beet_init+0x0/0x10 @ 1
[    0.893375] initcall xfrm6_beet_init+0x0/0x10 returned 0 after 1 usecs=

[    0.893414] calling  sit_init+0x0/0xc8 @ 1
[    0.893439] sit: IPv6 over IPv4 tunneling driver
[    0.894527] initcall sit_init+0x0/0xc8 returned 0 after 1052 usecs
[    0.894570] calling  packet_init+0x0/0x48 @ 1
[    0.894600] NET: Registered protocol family 17
[    0.894648] initcall packet_init+0x0/0x48 returned 0 after 43 usecs
[    0.894688] calling  ipsec_pfkey_init+0x0/0x78 @ 1
[    0.894731] NET: Registered protocol family 15
[    0.894764] initcall ipsec_pfkey_init+0x0/0x78 returned 0 after 42 use=
cs
[    0.894987] calling  init_machine_late+0x0/0x98 @ 1
[    0.895378] initcall init_machine_late+0x0/0x98 returned 0 after 349 u=
secs
[    0.895422] calling  swp_emulation_init+0x0/0x6c @ 1
[    0.895465] Registering SWP/SWPB emulation handler
[    0.895500] initcall swp_emulation_init+0x0/0x6c returned 0 after 44 u=
secs
[    0.895544] calling  bL_switcher_init+0x0/0xb8 @ 1
[    0.895578] initcall bL_switcher_init+0x0/0xb8 returned -19 after 1 us=
ecs
[    0.895616] calling  init_oops_id+0x0/0x40 @ 1
[    0.895657] initcall init_oops_id+0x0/0x40 returned 0 after 10 usecs
[    0.895704] calling  sched_init_debug+0x0/0x3c @ 1
[    0.895754] initcall sched_init_debug+0x0/0x3c returned 0 after 15 use=
cs
[    0.895800] calling  pm_qos_power_init+0x0/0xb0 @ 1
[    0.896866] initcall pm_qos_power_init+0x0/0xb0 returned 0 after 1004 =
usecs
[    0.896919] calling  pm_debugfs_init+0x0/0x38 @ 1
[    0.896966] initcall pm_debugfs_init+0x0/0x38 returned 0 after 12 usec=
s
[    0.897004] calling  printk_late_init+0x0/0x5c @ 1
[    0.897041] initcall printk_late_init+0x0/0x5c returned 0 after 6 usec=
s
[    0.897080] calling  tk_debug_sleep_time_init+0x0/0x50 @ 1
[    0.897124] initcall tk_debug_sleep_time_init+0x0/0x50 returned 0 afte=
r 11 usecs
[    0.897177] calling  fault_around_debugfs+0x0/0x4c @ 1
[    0.897234] initcall fault_around_debugfs+0x0/0x4c returned 0 after 23=
 usecs
[    0.897280] calling  max_swapfiles_check+0x0/0x8 @ 1
[    0.897313] initcall max_swapfiles_check+0x0/0x8 returned 0 after 0 us=
ecs
[    0.897351] calling  prandom_reseed+0x0/0x44 @ 1
[    0.897410] initcall prandom_reseed+0x0/0x44 returned 0 after 25 usecs=

[    0.897451] calling  fb_logo_late_init+0x0/0x18 @ 1
[    0.897483] initcall fb_logo_late_init+0x0/0x18 returned 0 after 0 use=
cs
[    0.897528] calling  deferred_probe_initcall+0x0/0x88 @ 1
[    0.897706] platform backlight: Retrying from deferred list
[    0.897819] bus: 'platform': driver_probe_device: matched device backl=
ight with driver pwm-backlight
[    0.897867] bus: 'platform': really_probe: probing driver pwm-backligh=
t with device backlight
[    0.898052] pwm-backlight backlight: GPIO lookup for consumer enable
[    0.898087] pwm-backlight backlight: using device tree for GPIO lookup=

[    0.898134] of_get_named_gpiod_flags: parsed 'enable-gpios' property o=
f node '/backlight[0]' - status (0)
[    0.898298] vcd_led: supplied by vbat-supply
[    0.900171] driver: 'pwm-backlight': driver_bound: bound to device 'ba=
cklight'
[    0.900227] bus: 'platform': really_probe: bound device backlight to d=
river pwm-backlight
[    0.900283] platform 145b0000.dp-controller: Retrying from deferred li=
st
[    0.900416] bus: 'platform': driver_probe_device: matched device 145b0=
000.dp-controller with driver exynos-dp
[    0.900462] bus: 'platform': really_probe: probing driver exynos-dp wi=
th device 145b0000.dp-controller
[    0.901117] platform 145b0000.dp-controller: Driver exynos-dp requests=
 probe deferral
[    0.901165] platform 145b0000.dp-controller: Added to deferred list
[    0.901386] platform 14530000.hdmi: Retrying from deferred list
[    0.901527] bus: 'platform': driver_probe_device: matched device 14530=
000.hdmi with driver exynos-hdmi
[    0.901572] bus: 'platform': really_probe: probing driver exynos-hdmi =
with device 14530000.hdmi
[    0.902450] of_get_named_gpiod_flags: parsed 'hpd-gpio' property of no=
de '/hdmi[0]' - status (0)
[    0.903637] video_mid_1a: supplied by vbat-supply
[    0.905765] driver: 'exynos-hdmi': driver_bound: bound to device '1453=
0000.hdmi'
[    0.905817] bus: 'platform': really_probe: bound device 14530000.hdmi =
to driver exynos-hdmi
[    0.905899] platform panel: Retrying from deferred list
[    0.906062] bus: 'platform': driver_probe_device: matched device panel=
 with driver panel-simple
[    0.906109] bus: 'platform': really_probe: probing driver panel-simple=
 with device panel
[    0.906306] lcd_vdd: supplied by vbat-supply
[    0.907007] usb 1-1: New USB device found, idVendor=3D0424, idProduct=3D=
9514
[    0.907046] usb 1-1: New USB device strings: Mfr=3D0, Product=3D0, Ser=
ialNumber=3D0
[    0.907234] panel-simple panel: GPIO lookup for consumer enable
[    0.907272] panel-simple panel: using device tree for GPIO lookup
[    0.907306] of_get_named_gpiod_flags: can't parse 'enable-gpios' prope=
rty of node '/panel[0]'
[    0.907351] of_get_named_gpiod_flags: can't parse 'enable-gpio' proper=
ty of node '/panel[0]'
[    0.907394] panel-simple panel: using lookup tables for GPIO lookup
[    0.907427] panel-simple panel: lookup for GPIO enable failed
[    0.907558] driver: 'panel-simple': driver_bound: bound to device 'pan=
el'
[    0.907595] bus: 'platform': really_probe: bound device panel to drive=
r panel-simple
[    0.907651] i2c 7-0020: Retrying from deferred list
[    0.907661] bus: 'usb': driver_probe_device: matched device 1-1 with d=
river usb
[    0.907669] bus: 'usb': really_probe: probing driver usb with device 1=
-1
[    0.907785] bus: 'i2c': driver_probe_device: matched device 7-0020 wit=
h driver nxp,ptn3460
[    0.907831] bus: 'i2c': really_probe: probing driver nxp,ptn3460 with =
device 7-0020
[    0.907981] nxp,ptn3460 7-0020: GPIO lookup for consumer powerdown
[    0.908014] nxp,ptn3460 7-0020: using device tree for GPIO lookup
[    0.908056] of_get_named_gpiod_flags: parsed 'powerdown-gpios' propert=
y of node '/i2c@12CD0000/lvds-bridge@20[0]' - status (0)
[    0.908120] nxp,ptn3460 7-0020: GPIO lookup for consumer reset
[    0.908150] nxp,ptn3460 7-0020: using device tree for GPIO lookup
[    0.908190] of_get_named_gpiod_flags: parsed 'reset-gpios' property of=
 node '/i2c@12CD0000/lvds-bridge@20[0]' - status (0)
[    0.908252] driver: 'nxp,ptn3460': driver_bound: bound to device '7-00=
20'
[    0.908286] bus: 'i2c': really_probe: bound device 7-0020 to driver nx=
p,ptn3460
[    0.908373] platform 101e0000.rtc: Retrying from deferred list
[    0.908572] bus: 'platform': driver_probe_device: matched device 101e0=
000.rtc with driver s3c-rtc
[    0.908616] bus: 'platform': really_probe: probing driver s3c-rtc with=
 device 101e0000.rtc
[    0.909091] s3c-rtc 101e0000.rtc: rtc disabled, re-enabling
[    0.909614] s3c-rtc 101e0000.rtc: rtc core: registered s3c as rtc1
[    0.909765] driver: 's3c-rtc': driver_bound: bound to device '101e0000=
=2Ertc'
[    0.909803] bus: 'platform': really_probe: bound device 101e0000.rtc t=
o driver s3c-rtc
[    0.909858] platform 12230000.mmc: Retrying from deferred list
[    0.910111] bus: 'platform': driver_probe_device: matched device 12230=
000.mmc with driver dwmmc_exynos
[    0.910156] bus: 'platform': really_probe: probing driver dwmmc_exynos=
 with device 12230000.mmc
[    0.910775] dwmmc_exynos 12230000.mmc: IDMAC supports 32-bit address m=
ode.
[    0.910892] dwmmc_exynos 12230000.mmc: Using internal DMA controller.
[    0.910929] dwmmc_exynos 12230000.mmc: Version ID is 241a
[    0.910983] dwmmc_exynos 12230000.mmc: DW MMC controller at irq 107,32=
 bit host data width,128 deep fifo
[    0.911167] dwmmc_exynos 12230000.mmc: No vmmc regulator found
[    0.911198] dwmmc_exynos 12230000.mmc: No vqmmc regulator found
[    0.911241] dwmmc_exynos 12230000.mmc: GPIO lookup for consumer cd
[    0.911273] dwmmc_exynos 12230000.mmc: using device tree for GPIO look=
up
[    0.911306] of_get_named_gpiod_flags: can't parse 'cd-gpios' property =
of node '/mmc@12230000[0]'
[    0.911352] of_get_named_gpiod_flags: can't parse 'cd-gpio' property o=
f node '/mmc@12230000[0]'
[    0.911394] dwmmc_exynos 12230000.mmc: using lookup tables for GPIO lo=
okup
[    0.911427] dwmmc_exynos 12230000.mmc: lookup for GPIO cd failed
[    0.911461] dwmmc_exynos 12230000.mmc: GPIO lookup for consumer wp
[    0.911492] dwmmc_exynos 12230000.mmc: using device tree for GPIO look=
up
[    0.911524] of_get_named_gpiod_flags: can't parse 'wp-gpios' property =
of node '/mmc@12230000[0]'
[    0.911567] of_get_named_gpiod_flags: can't parse 'wp-gpio' property o=
f node '/mmc@12230000[0]'
[    0.911609] dwmmc_exynos 12230000.mmc: using lookup tables for GPIO lo=
okup
[    0.911641] dwmmc_exynos 12230000.mmc: lookup for GPIO wp failed
[    0.911898] platform mmc3_pwrseq: GPIO lookup for consumer reset
[    0.911930] platform mmc3_pwrseq: using device tree for GPIO lookup
[    0.911970] of_get_named_gpiod_flags: parsed 'reset-gpios' property of=
 node '/mmc3_pwrseq[0]' - status (0)
[    0.912030] platform mmc3_pwrseq: GPIO lookup for consumer reset
[    0.912059] platform mmc3_pwrseq: using device tree for GPIO lookup
[    0.912102] of_get_named_gpiod_flags: parsed 'reset-gpios' property of=
 node '/mmc3_pwrseq[1]' - status (0)
[    0.912160] dwmmc_exynos 12230000.mmc: allocated mmc-pwrseq
[    0.924495] bus: 'usb': driver_probe_device: matched device 1-1:1.0 wi=
th driver hub
[    0.924546] bus: 'usb': really_probe: probing driver hub with device 1=
-1:1.0
[    0.924638] hub 1-1:1.0: USB hub found
[    0.924777] hub 1-1:1.0: 5 ports detected
[    0.941824] dwmmc_exynos 12230000.mmc: 1 slots initialized
[    0.941859] driver: 'dwmmc_exynos': driver_bound: bound to device '122=
30000.mmc'
[    0.941905] bus: 'platform': really_probe: bound device 12230000.mmc t=
o driver dwmmc_exynos
[    0.941961] platform 145b0000.dp-controller: Retrying from deferred li=
st
[    0.942096] bus: 'platform': driver_probe_device: matched device 145b0=
000.dp-controller with driver exynos-dp
[    0.942142] bus: 'platform': really_probe: probing driver exynos-dp wi=
th device 145b0000.dp-controller
[    0.944121] exynos-drm exynos-drm: bound 14400000.fimd (ops fimd_compo=
nent_ops)
[    0.944279] of_get_named_gpiod_flags: parsed 'samsung,hpd-gpio' proper=
ty of node '/dp-controller@145B0000[0]' - status (0)
[    0.945111] exynos-drm exynos-drm: bound 145b0000.dp-controller (ops e=
xynos_dp_ops)
[    0.945297] exynos-drm exynos-drm: bound 14450000.mixer (ops mixer_com=
ponent_ops)
[    0.945776] exynos-drm exynos-drm: bound 14530000.hdmi (ops hdmi_compo=
nent_ops)
[    0.945820] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013)=
=2E
[    0.945849] [drm] No driver support for vblank timestamp query.
[    0.957614] driver: 'hub': driver_bound: bound to device '1-1:1.0'
[    0.957657] bus: 'usb': really_probe: bound device 1-1:1.0 to driver h=
ub
[    0.957699] driver: 'usb': driver_bound: bound to device '1-1'
[    0.957735] bus: 'usb': really_probe: bound device 1-1 to driver usb
[    0.998673] mmc_host mmc2: Bus speed (slot 0) =3D 50000000Hz (slot req=
 50000000Hz, actual 50000000HZ div =3D 0)
[    1.005565] mmc2: new high speed SDIO card at address 0001
[    1.005772] bus: 'mmc': driver_probe_device: matched device mmc2:0001 =
with driver mmcblk
[    1.005819] bus: 'mmc': really_probe: probing driver mmcblk with devic=
e mmc2:0001
[    1.005927] mmcblk: probe of mmc2:0001 rejects match -19
[    1.164353] exynos-dp 145b0000.dp-controller: EDID data does not inclu=
de any extensions.
[    1.173729] exynos-dp 145b0000.dp-controller: Link Training Clock Reco=
very success
[    1.175695] exynos-dp 145b0000.dp-controller: Link Training success!
[    1.241824] usb 1-1.1: new high-speed USB device number 3 using xhci-h=
cd
[    1.282317] exynos-dp 145b0000.dp-controller: Timeout of video streamc=
lk ok
[    1.282333] exynos-dp 145b0000.dp-controller: unable to config video
[    1.306078] Console: switching to colour frame buffer device 195x54
[    1.339302] exynos-drm exynos-drm: fb0:  frame buffer device
[    1.342018] usb 1-1.1: New USB device found, idVendor=3D0424, idProduc=
t=3Dec00
[    1.342191] usb 1-1.1: New USB device strings: Mfr=3D0, Product=3D0, S=
erialNumber=3D0
[    1.343034] bus: 'usb': driver_probe_device: matched device 1-1.1 with=
 driver usb
[    1.343214] bus: 'usb': really_probe: probing driver usb with device 1=
-1.1
[    1.351767] [drm] Initialized exynos 1.0.0 20110530 on minor 0
[    1.351924] driver: 'exynos-dp': driver_bound: bound to device '145b00=
00.dp-controller'
[    1.352113] bus: 'platform': really_probe: bound device 145b0000.dp-co=
ntroller to driver exynos-dp
[    1.352373] initcall deferred_probe_initcall+0x0/0x88 returned 0 after=
 444139 usecs
[    1.352579] calling  genpd_poweroff_unused+0x0/0x10 @ 1
[    1.352731] initcall genpd_poweroff_unused+0x0/0x10 returned 0 after 1=
7 usecs
[    1.352905] calling  gpio_keys_init+0x0/0x10 @ 1
[    1.353304] bus: 'platform': driver_probe_device: matched device gpio-=
keys with driver gpio-keys
[    1.353507] bus: 'platform': really_probe: probing driver gpio-keys wi=
th device gpio-keys
[    1.353969] of_get_named_gpiod_flags: parsed 'gpios' property of node =
'/gpio-keys/power[0]' - status (0)
[    1.354210] of_get_named_gpiod_flags: parsed 'gpios' property of node =
'/gpio-keys/lid-switch[0]' - status (0)
[    1.354489] gpio-143 (Power): gpiod_set_debounce: missing set() or set=
_debounce() operations
[    1.354806] gpio-161 (Lid): gpiod_set_debounce: missing set() or set_d=
ebounce() operations
[    1.362148] input: gpio-keys as /devices/platform/gpio-keys/input/inpu=
t2
[    1.369136] driver: 'gpio-keys': driver_bound: bound to device 'gpio-k=
eys'
[    1.375754] bus: 'platform': really_probe: bound device gpio-keys to d=
river gpio-keys
[    1.382625] bus: 'usb': driver_probe_device: matched device 1-1.1:1.0 =
with driver smsc95xx
[    1.389262] initcall gpio_keys_init+0x0/0x10 returned 0 after 35386 us=
ecs
[    1.395759] bus: 'usb': really_probe: probing driver smsc95xx with dev=
ice 1-1.1:1.0
[    1.402265] calling  rtc_hctosys+0x0/0xf4 @ 1
[    1.408772] smsc95xx v1.0.4
[    1.437322] max77686-rtc max77686-rtc: setting system clock to 2000-01=
-01 01:57:26 UTC (946691846)
[    1.443937] initcall rtc_hctosys+0x0/0xf4 returned 0 after 28140 usecs=

[    1.451588] calling  of_fdt_raw_init+0x0/0x74 @ 1
[    1.458493] initcall of_fdt_raw_init+0x0/0x74 returned 0 after 434 use=
cs
[    1.461689] calling  clk_debug_init+0x0/0x138 @ 1
[    1.477872] initcall clk_debug_init+0x0/0x138 returned 0 after 12672 u=
secs
[    1.481044] calling  register_sk_filter_ops+0x0/0x8 @ 1
[    1.484255] initcall register_sk_filter_ops+0x0/0x8 returned 0 after 0=
 usecs
[    1.487492] calling  tcp_congestion_default+0x0/0xc @ 1
[    1.490691] initcall tcp_congestion_default+0x0/0xc returned 0 after 1=
 usecs
[    1.493899] calling  ip_auto_config+0x0/0x10b0 @ 1
[    1.514042] smsc95xx 1-1.1:1.0 eth0: register 'smsc95xx' at usb-xhci-h=
cd.2.auto-1.1, smsc95xx USB 2.0 Ethernet, 94:eb:2c:00:00:a7
[    1.517308] driver: 'smsc95xx': driver_bound: bound to device '1-1.1:1=
=2E0'
[    1.520535] bus: 'usb': really_probe: bound device 1-1.1:1.0 to driver=
 smsc95xx
[    1.523776] driver: 'usb': driver_bound: bound to device '1-1.1'
[    1.527000] bus: 'usb': really_probe: bound device 1-1.1 to driver usb=

[    2.550550] smsc95xx 1-1.1:1.0 eth0: hardware isn't capable of remote =
wakeup
[    2.567181] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    4.068149] smsc95xx 1-1.1:1.0 eth0: link up, 100Mbps, full-duplex, lp=
a 0xCDE1
[    4.084229] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[    4.087043] Sending DHCP requests ., OK
[    4.126806] IP-Config: Got DHCP answer from 10.42.0.1, my address is 1=
0.42.0.61
[    4.135375] IP-Config: Complete:
[    4.143386]      device=3Deth0, hwaddr=3D94:eb:2c:00:00:a7, ipaddr=3D1=
0.42.0.61, mask=3D255.255.255.0, gw=3D10.42.0.1
[    4.151607]      host=3D10.42.0.61, domain=3D, nis-domain=3D(none)
[    4.159839]      bootserver=3D10.42.0.1, rootserver=3D10.42.0.1, rootp=
ath=3D
[    4.160031]      nameserver0=3D10.42.0.1

[    4.176184] initcall ip_auto_config+0x0/0x10b0 returned 0 after 261629=
2 usecs
[    4.184459] calling  regulator_init_complete+0x0/0x48 @ 1
[    4.192736] TPS65090_RAILSDCDC1: disabling
[    4.200927] TPS65090_RAILSDCDC2: disabling
[    4.208995] TPS65090_RAILSDCDC3: disabling
[    4.217785] TPS65090_RAILSLDO1: disabling
[    4.225673] TPS65090_RAILSLDO2: disabling
[    4.233409] initcall regulator_init_complete+0x0/0x48 returned 0 after=
 39771 usecs
[    4.241321] calling  clk_disable_unused+0x0/0x138 @ 1
[    4.251036] initcall clk_disable_unused+0x0/0x138 returned 0 after 186=
9 usecs
[    4.253336] calling  alsa_sound_last_init+0x0/0x6c @ 1
[    4.255606] ALSA device list:
[    4.257859]   #0: Snow-I2S-MAX98095
[    4.260076] initcall alsa_sound_last_init+0x0/0x6c returned 0 after 43=
60 usecs
[    4.262337] calling  init_default_flow_dissectors+0x0/0x3c @ 1
[    4.264559] initcall init_default_flow_dissectors+0x0/0x3c returned 0 =
after 0 usecs
[    4.280283] VFS: Mounted root (nfs filesystem) on device 0:15.
[    4.283182] devtmpfs: mounted
[    4.285506] Freeing unused kernel memory: 428K (c0797000 - c0802000)
[    4.612617] random: systemd urandom read with 60 bits of entropy avail=
able
[    4.620773] systemd[1]: systemd 215 running in system mode. (+PAM +AUD=
IT +SELINUX +IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ -SECCOMP -APPA=
RMOR)
[    4.624141] systemd[1]: Detected architecture 'arm'.
[    4.669694] systemd[1]: Failed to insert module 'autofs4'
[    4.675496] systemd[1]: Set hostname to <singularity>.
[    5.336213] systemd[1]: Cannot add dependency job for unit fstrim.time=
r, ignoring: Unit fstrim.timer failed to load: No such file or directory.=

[    5.340944] systemd[1]: Cannot add dependency job for unit display-man=
ager.service, ignoring: Unit display-manager.service failed to load: No s=
uch file or directory.
[    5.347662] systemd[1]: Starting Forward Password Requests to Wall Dir=
ectory Watch.
[    5.352548] systemd[1]: Started Forward Password Requests to Wall Dire=
ctory Watch.
[    5.357117] systemd[1]: Starting Remote File Systems (Pre).
[    5.366583] systemd[1]: Reached target Remote File Systems (Pre).
[    5.371155] systemd[1]: Starting Encrypted Volumes.
[    5.380536] systemd[1]: Reached target Encrypted Volumes.
[    5.385193] systemd[1]: Set up automount Arbitrary Executable File For=
mats File System Automount Point.
[    5.389753] systemd[1]: Starting Swap.
[    5.398864] systemd[1]: Reached target Swap.
[    5.403226] systemd[1]: Starting Root Slice.
[    5.412250] systemd[1]: Created slice Root Slice.
[    5.416473] systemd[1]: Starting Delayed Shutdown Socket.
[    5.425353] systemd[1]: Listening on Delayed Shutdown Socket.
[    5.429611] systemd[1]: Starting /dev/initctl Compatibility Named Pipe=
=2E
[    5.439356] systemd[1]: Listening on /dev/initctl Compatibility Named =
Pipe.
[    5.443581] systemd[1]: Starting Journal Socket (/dev/log).
[    5.453105] systemd[1]: Listening on Journal Socket (/dev/log).
[    5.457315] systemd[1]: Starting udev Control Socket.
[    5.466584] systemd[1]: Listening on udev Control Socket.
[    5.470751] systemd[1]: Starting udev Kernel Socket.
[    5.478879] systemd[1]: Listening on udev Kernel Socket.
[    5.480820] systemd[1]: Starting User and Session Slice.
[    5.484988] systemd[1]: Created slice User and Session Slice.
[    5.486955] systemd[1]: Starting Journal Socket.
[    5.491019] systemd[1]: Listening on Journal Socket.
[    5.492991] systemd[1]: Starting System Slice.
[    5.497088] systemd[1]: Created slice System Slice.
[    5.503932] systemd[1]: Started Set Up Additional Binary Formats.
[    5.505876] systemd[1]: Mounted POSIX Message Queue File System.
[    5.507955] systemd[1]: Mounting Debug File System...
[    5.535382] systemd[1]: Starting Load Kernel Modules...
[    5.541341] systemd[1]: Starting Create list of required static device=
 nodes for the current kernel...
[    5.546898] systemd[1]: Starting udev Coldplug all Devices...
[    5.553220] systemd[1]: Mounted Huge Pages File System.
[    5.555445] systemd[1]: Starting system-getty.slice.
[    5.560549] systemd[1]: Created slice system-getty.slice.
[    5.562837] systemd[1]: Starting Journal Service...
[    5.584166] systemd[1]: Started Journal Service.
[    5.863752] systemd-udevd[1824]: starting version 215
[    6.460842] random: nonblocking pool is initialized
[    7.142323] calling  mwifiex_init_module+0x0/0x10 [mwifiex] @ 2870
[    7.144261] initcall mwifiex_init_module+0x0/0x10 [mwifiex] returned 0=
 after 11 usecs
[    7.194574] calling  mwifiex_sdio_init_module+0x0/0x54 [mwifiex_sdio] =
@ 2870
[    7.198388] bus: 'sdio': driver_probe_device: matched device mmc2:0001=
:1 with driver mwifiex_sdio
[    7.203684] bus: 'sdio': really_probe: probing driver mwifiex_sdio wit=
h device mmc2:0001:1
[    7.228437] mwifiex: rx work enabled, cpus 2
[    7.253138] driver: 'mwifiex_sdio': driver_bound: bound to device 'mmc=
2:0001:1'
[    7.255160] bus: 'sdio': really_probe: bound device mmc2:0001:1 to dri=
ver mwifiex_sdio
[    7.265718] initcall mwifiex_sdio_init_module+0x0/0x54 [mwifiex_sdio] =
returned 0 after 65757 usecs
[    7.956437] mwifiex_sdio mmc2:0001:1: info: FW download over, size 458=
108 bytes
[    8.271818] mwifiex_sdio mmc2:0001:1: WLAN FW is active
[    8.667367] mwifiex_sdio mmc2:0001:1: info: MWIFIEX VERSION: mwifiex 1=
=2E0 (14.66.11.p151)=20
[    8.672804] mwifiex_sdio mmc2:0001:1: driver_version =3D mwifiex 1.0 (=
14.66.11.p151)=20
[   11.532582] systemd-journald[1590]: Received request to flush runtime =
journal from PID 1
[   18.478513] systemd-journald[1590]: Failed to read ACL on /var/log/jou=
rnal/becefd5da725413ebc34ab1a301f3fc7/user-1001.journal, ignoring: Operat=
ion not supported

--------------010301030807040007030702--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
