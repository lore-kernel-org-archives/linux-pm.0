From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: Re: [PATCH v4 00/20] PM / devferq: Add generic exynos bus frequency
 driver and new passive governor
Date: Fri, 19 Feb 2016 16:05:35 +0100
Message-ID: <56C72F3F.3000603@math.uni-bielefeld.de>
References: <1450075104-13705-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060302010802040501000202"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1450075104-13705-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------060302010802040501000202
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Hello,

I've applied the patchset to 4.5-rc4 and I'm now encountering two
additional problems. The first related to debugfs entries, the second
cocerning RCU locking.

Here are the debugfs lines:
exynos-bus bus_dmc: device_opp_debug_create_link: Failed to create link
exynos-bus bus_dmc: _add_list_dev: Failed to register opp debugfs (-12)
exynos-bus bus_dmc: Looking up vdd-supply from device tree
exynos-bus: new bus device registered: bus_dmc (100000 KHz ~ 400000 KHz)
exynos-bus bus_acp: device_opp_debug_create_link: Failed to create link
exynos-bus bus_acp: _add_list_dev: Failed to register opp debugfs (-12)
exynos-bus: new bus device registered: bus_acp (100000 KHz ~ 267000 KHz)
exynos-bus bus_c2c: device_opp_debug_create_link: Failed to create link
exynos-bus bus_c2c: _add_list_dev: Failed to register opp debugfs (-12)
exynos-bus: new bus device registered: bus_c2c (100000 KHz ~ 400000 KHz)
exynos-bus bus_leftbus: device_opp_debug_create_link: Failed to create link
devfreq bus_dmc: Couldn't update frequency transition information.
exynos-bus bus_leftbus: _add_list_dev: Failed to register opp debugfs (-12)
exynos-bus bus_leftbus: Looking up vdd-supply from device tree


The RCU output is a bit longer, so I attached it.


With best wishes,
Tobias


Chanwoo Choi wrote:
> This patch-set includes the two features as following. The generic exynos bus
> frequency driver is able to support almost Exynos SoCs for bus frequency
> scaling. And the new passive governor is able to make the dependency on
> between devices for frequency/voltage scaling. I had posted the patch-set[2]
> with the similiar concept. This is is revised version for exynos bus frequency.
> - Generic exynos bus frequency driver
> - New passive governor of DEVFREQ framework
> 
> Depend on:
> - next-20151210 tag of linux-next (master branch).
> - Merge the latest devfreq patches on devfreq.git[2] (for-rafael branch).
> [1] https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git/ (branch: for-rafael)
> [2] https://lkml.org/lkml/2015/1/7/872
>    : [PATCHv3 0/8] devfreq: Add generic exynos memory-bus frequency driver
> 
> Changes from v3:
> (https://lkml.org/lkml/2015/12/11/75)
> - Add the reviewed-by tag from Krzysztof Kozlowski (patch2/3/13/14/15/16/17)
> - Fix typo of the description on patch14
> - Modify the subject and description of patch17
> - Reorder the 'bus_xxx' device tree node alphabetically in 
>   both exynos3250-rinato/monk.dts and exynos4412-trats/odroidu3
> 
> Changes from v2:
> (https://lkml.org/lkml/2015/12/8/869)
> - Fix typo on documentation
> - Modify the more appropriate sentence on patch description
> - Add the detailed description about both parent and passive bus device
> - Modify the DMC frequency for Exynos4x12 DMC bus (200MHz -> 267MHz)
> - Modify the voltage of 200MHz was included in Exynos3250 DMC bus (800mV -> 825mV)
> - Rename OPP nodes as 'opp@<opp-hz>'
> - Delete the duplicate 'opp-microvolt' property of passive devfreq device
> - Reorder the 'bus_xxx' device tree node alphabetically in exynos3250-rinato/monk.dts
> - Reorder the 'bus_xxx' device tree node alphabetically in exynos4412-trats/odroidu3
> - Add new exynos4412-ppmu-common.dtsi to remove the duplicate PPMU dt node
>   on rinato/monk/trats2/odroid-u3 board
> - Add the log message if bus device is registered to devfreq framework successfully
> - Add the reviewed-by tag from Krzysztof Kozlowski
> - Add the tested-by tag from Anand Moon on Odroid U3
> - Add 'SAMSUNG BUS FREQUENCY DRIVER' entry to MAINTAINERS
> 
> Changes from v1:
> (https://lkml.org/lkml/2015/11/26/260)
> - Check whether the instance of regulator is NULL or not
>   when executing regulator_disable() because of only parent
>   devfreq device has the regulator instance. After fixing it,
>   the wake-up from suspend state is well working. (patch1)
> - Fix bug which checks 'bus-clk' instead of 'bus->regulator'
>   after calling devm_clk_get() (on patch1)
> - Update the documentation to remove the description about
>   DEVFREQ-EVENT subsystem (on patch2)
> - Add the full name of DMC (Dynamic Memory Controller) (on patch2)
> - Modify the detailed correlation of buses for Exynos3250
>   on documentation (patch2)
> - Add the MFC bus node for Exynos3250 (on patch11, patch12)
> - Fix the duplicate frequency of bus_display on Exynos4x12.dtsi
> - Add the PPMU node for exynos4412-odroidu3
> - Add the support of bus frequency for exynos4412-odroidu3
> 
> Detailed descirption for patch-set:
> 1. Add generic exynos bus frequency driver
> : This patch-set adds the generic exynos bus frequency driver for AXI bus
> of sub-blocks in exynos SoC. The Samsung Exynos SoC have the common
> architecture for bus between DRAM and sub-blocks in SoC.
> 
>  There are the different buses according to Exynos SoC because Exynos SoC
> has the differnt sub-blocks and bus speed. In spite of this difference
> among Exynos SoCs, this driver is able to support almost Exynos SoC by adding
> unique data of each bus in the devicetree file.
> 
>  In devicetree, each bus node has a bus clock, regulator, operation-point
> and devfreq-event devices which measure the utilization of each bus block.
> 
> For example,
> - The bus of DMC block in exynos3250.dtsi are listed below:
> 
> 	bus_dmc: bus_dmc {
> 		compatible = "samsung,exynos-bus";
> 		clocks = <&cmu_dmc CLK_DIV_DMC>;
> 		clock-names = "bus";
> 		operating-points-v2 = <&bus_dmc_opp_table>;
> 		status = "disabled";
> 	};
> 
> 	bus_dmc_opp_table: opp_table1 {
> 		compatible = "operating-points-v2";
> 		opp-shared;
> 
> 		opp@50000000 {
> 			opp-hz = /bits/ 64 <50000000>;
> 			opp-microvolt = <800000>;
> 		};
> 		opp@100000000 {
> 			opp-hz = /bits/ 64 <100000000>;
> 			opp-microvolt = <800000>;
> 		};
> 		opp@134000000 {
> 			opp-hz = /bits/ 64 <134000000>;
> 			opp-microvolt = <800000>;
> 		};
> 		opp@200000000 {
> 			opp-hz = /bits/ 64 <200000000>;
> 			opp-microvolt = <825000>;
> 		};
> 		opp@400000000 {
> 			opp-hz = /bits/ 64 <400000000>;
> 			opp-microvolt = <875000>;
> 		};
> 	};
> 
> - Usage case to handle the frequency and voltage of bus on runtime
>   in exynos3250-rinato.dts are listed below:
> 
> 	&bus_dmc {
> 		devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
> 		vdd-supply = <&buck1_reg>;	/* VDD_MIF */
> 		status = "okay";
> 	};
> 
> 2. Add new passive governor of DEVFREQ framework (patch5-patch7)
> : This patch-set add the new passive governor for DEVFREQ framework.
> The existing governors (ondemand, performance and so on) are used for DVFS
> (Dynamic Voltage and Frequency Scaling) drivers. The existing governors
> are independently used for specific device driver which don't give the
> influence to other device drviers and also don't receive the effect from
> other device drivers.
> 
>  The passive governor depends on operation of parent driver with existing
> governors(ondemand, performance and so on) extremely and is not able to
> decide the new frequency by oneself. According to the decided new frequency
> of parent driver with governor, the passive governor uses it to decide
> the appropriate frequency for own device driver. The passive governor
> must need the following information from device tree:
> 
> For exameple,
>  There are one more bus device drivers in Exynos3250 which need to
> change their source clock according to their utilization on runtime.
> But, they share the same power line (e.g., regulator). So, LEFTBUS bus
> driver is operated as parent with ondemand governor and then the rest
> device driver with passive governor.
> 
>  The buses of Internal block in exynos3250.dtsi are listed below:
> When LEFTBUS bus driver (parent) changes the bus frequency with
> ondemand governor on runtime, the rest bus devices which sharing
> the same power line (VDD_INT) will change the each bus frequency
> according to the decision of LEFTBUS bus driver (parent).
> 
> - INT (Internal) block
> 	: VDD_INT |--- LEFTBUS
> 		  |--- PERIL
> 		  |--- MFC
> 		  |--- G3D
> 		  |--- RIGHTBUS
> 		  |--- FSYS
> 		  |--- LCD0
> 		  |--- PERIR
> 		  |--- ISP
> 		  |--- CAM
> 
> - The buss of INT block in exynos3250.dtsi are listed below:
> 	bus_leftbus: bus_leftbus {
> 		compatible = "samsung,exynos-bus";
> 		clocks = <&cmu CLK_DIV_GDL>;
> 		clock-names = "bus";
> 		operating-points-v2 = <&bus_leftbus_opp_table>;
> 		status = "disabled";
> 	};
> 
> 	bus_rightbus: bus_rightbus {
> 		compatible = "samsung,exynos-bus";
> 		clocks = <&cmu CLK_DIV_GDR>;
> 		clock-names = "bus";
> 		operating-points-v2 = <&bus_leftbus_opp_table>;
> 		status = "disabled";
> 	};
> 
> 	(Omit the rest bus dt node)
> 
> - Usage case to handle the frequency and voltage of bus on runtime
>   in exynos3250-rinato.dts are listed below:
> 	/* Parent bus device of VDD_INT */
> 	&bus_leftbus {
> 		devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
> 		vdd-supply = <&buck3_reg>;
> 		status = "okay";
> 	};
> 
> 	/* Passive bus device depend on LEFTBUS bus. */
> 	&bus_rightbus {
> 		devfreq = <&bus_leftbus>; /* 'devfreq' property indicates
> 					     the phandle of parent device. */
> 		status = "okay";
> 	};
> 
> 	(Omit the rest bus dt node)
> 
> Chanwoo Choi (20):
>   PM / devfreq: exynos: Add generic exynos bus frequency driver
>   PM / devfreq: exynos: Add documentation for generic exynos bus frequency driver
>   ARM: dts: Add DMC bus node for Exynos3250
>   ARM: dts: Add DMC bus frequency for exynos3250-rinato/monk
>   PM / devfreq: Add new passive governor
>   PM / devfreq: Add devfreq_get_devfreq_by_phandle()
>   PM / devfreq: Show the related information according to governor type
>   PM / devfreq: exynos: Add support of bus frequency of sub-blocks using passive governor
>   PM / devfreq: exynos: Update documentation for bus devices using passive governor
>   PM / devfreq: exynos: Add the detailed correlation between sub-blocks and power line
>   PM / devfreq: exynos: Remove unused exynos4/5 busfreq driver
>   MAINTAINERS: Add samsung bus frequency driver entry
>   ARM: dts: Add bus nodes using VDD_INT for Exynos3250
>   ARM: dts: Add bus nodes using VDD_MIF for Exynos4x12
>   ARM: dts: Add bus nodes using VDD_INT for Exynos4x12
>   ARM: dts: Add bus nodes using VDD_MIF for Exynos4210
>   ARM: dts: Add exynos4412-ppmu-common dtsi to delete duplicate PPMU nodes
>   ARM: dts: Add support of bus frequency using VDD_INT for exynos3250-rinato
>   ARM: dts: Expand the voltage range of buck1/3 regulator for exynos4412-odroidu3
>   ARM: dts: Add support of bus frequency for exynos4412-trats/odroidu3
> 
>  .../devicetree/bindings/devfreq/exynos-bus.txt     |  388 +++++++
>  MAINTAINERS                                        |    9 +
>  arch/arm/boot/dts/exynos3250-monk.dts              |   47 +-
>  arch/arm/boot/dts/exynos3250-rinato.dts            |   88 +-
>  arch/arm/boot/dts/exynos3250.dtsi                  |  181 ++++
>  arch/arm/boot/dts/exynos4210.dtsi                  |  159 +++
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   54 +-
>  arch/arm/boot/dts/exynos4412-ppmu-common.dtsi      |   50 +
>  arch/arm/boot/dts/exynos4412-trats2.dts            |   88 +-
>  arch/arm/boot/dts/exynos4x12.dtsi                  |  174 ++++
>  drivers/devfreq/Kconfig                            |   37 +-
>  drivers/devfreq/Makefile                           |    2 +
>  drivers/devfreq/devfreq.c                          |  120 ++-
>  drivers/devfreq/exynos/Makefile                    |    3 +-
>  drivers/devfreq/exynos/exynos-bus.c                |  556 +++++++++++
>  drivers/devfreq/exynos/exynos4_bus.c               | 1055 --------------------
>  drivers/devfreq/exynos/exynos4_bus.h               |  110 --
>  drivers/devfreq/exynos/exynos5_bus.c               |  431 --------
>  drivers/devfreq/exynos/exynos_ppmu.c               |  119 ---
>  drivers/devfreq/exynos/exynos_ppmu.h               |   86 --
>  drivers/devfreq/governor.h                         |    7 +
>  drivers/devfreq/governor_passive.c                 |  109 ++
>  drivers/devfreq/governor_performance.c             |    1 +
>  drivers/devfreq/governor_powersave.c               |    1 +
>  drivers/devfreq/governor_simpleondemand.c          |    1 +
>  drivers/devfreq/governor_userspace.c               |    1 +
>  include/linux/devfreq.h                            |   26 +
>  27 files changed, 1955 insertions(+), 1948 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>  create mode 100644 arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
>  create mode 100644 drivers/devfreq/exynos/exynos-bus.c
>  delete mode 100644 drivers/devfreq/exynos/exynos4_bus.c
>  delete mode 100644 drivers/devfreq/exynos/exynos4_bus.h
>  delete mode 100644 drivers/devfreq/exynos/exynos5_bus.c
>  delete mode 100644 drivers/devfreq/exynos/exynos_ppmu.c
>  delete mode 100644 drivers/devfreq/exynos/exynos_ppmu.h
>  create mode 100644 drivers/devfreq/governor_passive.c
> 


--------------060302010802040501000202
Content-Type: text/plain; charset=UTF-8;
 name="devfreq_rcu.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="devfreq_rcu.txt"

[    3.041556] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    3.041560] [ INFO: suspicious RCU usage. ]
[    3.041569] 4.5.0-rc4-debug+ #2 Tainted: G        W     =20
[    3.041572] -------------------------------
[    3.041578] drivers/base/power/opp/core.c:377 Missing rcu_read_lock() =
or dev_opp_list_lock protection!
[    3.041580]=20
               other info that might help us debug this:

[    3.041586]=20
               rcu_scheduler_active =3D 1, debug_locks =3D 0
[    3.041592] 3 locks held by kworker/u8:3/861:
[    3.041635]  #0:  ("%s"("devfreq_wq")){.+.+..}, at: [<c00463a0>] proce=
ss_one_work+0x134/0x7ac
[    3.041648]  #1:  ((&(&devfreq->work)->work)){+.+...}, at: [<c00463a0>=
] process_one_work+0x134/0x7ac
[    3.041675]  #2:  (&devfreq->lock){+.+.+.}, at: [<c0470c98>] devfreq_m=
onitor+0x24/0x80
[    3.041678]=20
               stack backtrace:
[    3.041686] CPU: 1 PID: 861 Comm: kworker/u8:3 Tainted: G        W    =
   4.5.0-rc4-debug+ #2
[    3.041688] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[    3.041699] Workqueue: devfreq_wq devfreq_monitor
[    3.041706] Backtrace:=20
[    3.041736] [<c0014818>] (dump_backtrace) from [<c0014a14>] (show_stac=
k+0x18/0x1c)
[    3.041749]  r6:c0845660 r5:60000053 r4:00000000 r3:dc8ba700
[    3.041773] [<c00149fc>] (show_stack) from [<c0283f9c>] (dump_stack+0x=
b0/0xdc)
[    3.041787] [<c0283eec>] (dump_stack) from [<c007435c>] (lockdep_rcu_s=
uspicious+0xe8/0x11c)
[    3.041800]  r8:ee381ea8 r7:c0757330 r6:00000179 r5:c0757350 r4:ee098c=
80 r3:00000000
[    3.041817] [<c0074274>] (lockdep_rcu_suspicious) from [<c0366bb4>] (d=
ev_pm_opp_find_freq_ceil+0xe8/0x100)
[    3.041827]  r7:ee932a00 r6:c0865ac0 r5:eeb43410 r4:ee381e1c
[    3.041835] [<c0366acc>] (dev_pm_opp_find_freq_ceil) from [<c0472928>]=
 (devfreq_recommended_opp+0x3c/0x54)
[    3.041845]  r6:ee381e1c r5:eeb43410 r4:ee381e1c r3:03c1f399
[    3.041852] [<c04728ec>] (devfreq_recommended_opp) from [<c0473568>] (=
devfreq_passive_get_target_freq+0xd8/0xfc)
[    3.041858]  r5:ee35e400 r4:ee35dc00
[    3.041864] [<c0473490>] (devfreq_passive_get_target_freq) from [<c047=
0950>] (update_devfreq_passive+0x48/0x94)
[    3.041875]  r6:03c1f399 r5:ee35df3c r4:ee35e400 r3:c0473490
[    3.041881] [<c0470908>] (update_devfreq_passive) from [<c0470b50>] (u=
pdate_devfreq+0x12c/0x168)
[    3.041889]  r6:00000000 r5:ee35df3c r4:ee35dc00
[    3.041895] [<c0470a24>] (update_devfreq) from [<c0470ca0>] (devfreq_m=
onitor+0x2c/0x80)
[    3.041904]  r6:ee35dc00 r5:ee35dc08 r4:ee35deb4
[    3.041910] [<c0470c74>] (devfreq_monitor) from [<c0046474>] (process_=
one_work+0x208/0x7ac)
[    3.041920]  r6:ee80ac00 r5:ee35deb4 r4:ee12d600 r3:c0470c74
[    3.041925] [<c004626c>] (process_one_work) from [<c0046a64>] (worker_=
thread+0x4c/0x514)
[    3.041938]  r10:ee12d600 r9:ee380000 r8:c0822100 r7:ee80ac34 r6:00000=
088 r5:ee12d618
[    3.041942]  r4:ee80ac00
[    3.041956] [<c0046a18>] (worker_thread) from [<c004d74c>] (kthread+0x=
108/0x120)
[    3.041969]  r10:00000000 r9:00000000 r8:00000000 r7:c0046a18 r6:ee12d=
600 r5:ee1ea340
[    3.041973]  r4:00000000
[    3.041982] [<c004d644>] (kthread) from [<c000ff30>] (ret_from_fork+0x=
14/0x24)
[    3.041992]  r7:00000000 r6:00000000 r5:c004d644 r4:ee1ea340
[    3.083806] devfreq bus_leftbus: Couldn't update frequency transition =
information.

--------------060302010802040501000202--
