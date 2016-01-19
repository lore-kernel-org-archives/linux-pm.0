From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: Re: [PATCH v4 00/20] PM / devferq: Add generic exynos bus frequency
 driver and new passive governor
Date: Tue, 19 Jan 2016 10:13:54 +0100
Message-ID: <569DFE52.107@math.uni-bielefeld.de>
References: <1450075104-13705-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.math.uni-bielefeld.de ([129.70.45.10]:59837 "EHLO
	smtp.math.uni-bielefeld.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757697AbcASJWv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2016 04:22:51 -0500
In-Reply-To: <1450075104-13705-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hello,

I've tested this on my Odroid-X2 but ran into issues. Patch 08/20
introduces some pr_info() to exynos_bus_probe().

In my case both max_state and freq_table are zero though, so getting
{min,max}_freq triggers an kernel oops. If I just remove the code the
drivers probes correctly.

With best wishes,
Tobias



Chanwoo Choi wrote:
> This patch-set includes the two features as following. The generic
> exynos bus frequency driver is able to support almost Exynos SoCs
> for bus frequency scaling. And the new passive governor is able to
> make the dependency on between devices for frequency/voltage
> scaling. I had posted the patch-set[2] with the similiar concept.
> This is is revised version for exynos bus frequency. - Generic
> exynos bus frequency driver - New passive governor of DEVFREQ
> framework
> 
> Depend on: - next-20151210 tag of linux-next (master branch). -
> Merge the latest devfreq patches on devfreq.git[2] (for-rafael
> branch). [1]
> https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git/
> (branch: for-rafael) [2] https://lkml.org/lkml/2015/1/7/872 :
> [PATCHv3 0/8] devfreq: Add generic exynos memory-bus frequency
> driver
> 
> Changes from v3: (https://lkml.org/lkml/2015/12/11/75) - Add the
> reviewed-by tag from Krzysztof Kozlowski (patch2/3/13/14/15/16/17) 
> - Fix typo of the description on patch14 - Modify the subject and
> description of patch17 - Reorder the 'bus_xxx' device tree node
> alphabetically in both exynos3250-rinato/monk.dts and
> exynos4412-trats/odroidu3
> 
> Changes from v2: (https://lkml.org/lkml/2015/12/8/869) - Fix typo
> on documentation - Modify the more appropriate sentence on patch
> description - Add the detailed description about both parent and
> passive bus device - Modify the DMC frequency for Exynos4x12 DMC
> bus (200MHz -> 267MHz) - Modify the voltage of 200MHz was included
> in Exynos3250 DMC bus (800mV -> 825mV) - Rename OPP nodes as
> 'opp@<opp-hz>' - Delete the duplicate 'opp-microvolt' property of
> passive devfreq device - Reorder the 'bus_xxx' device tree node
> alphabetically in exynos3250-rinato/monk.dts - Reorder the
> 'bus_xxx' device tree node alphabetically in
> exynos4412-trats/odroidu3 - Add new exynos4412-ppmu-common.dtsi to
> remove the duplicate PPMU dt node on rinato/monk/trats2/odroid-u3
> board - Add the log message if bus device is registered to devfreq
> framework successfully - Add the reviewed-by tag from Krzysztof
> Kozlowski - Add the tested-by tag from Anand Moon on Odroid U3 -
> Add 'SAMSUNG BUS FREQUENCY DRIVER' entry to MAINTAINERS
> 
> Changes from v1: (https://lkml.org/lkml/2015/11/26/260) - Check
> whether the instance of regulator is NULL or not when executing
> regulator_disable() because of only parent devfreq device has the
> regulator instance. After fixing it, the wake-up from suspend state
> is well working. (patch1) - Fix bug which checks 'bus-clk' instead
> of 'bus->regulator' after calling devm_clk_get() (on patch1) -
> Update the documentation to remove the description about 
> DEVFREQ-EVENT subsystem (on patch2) - Add the full name of DMC
> (Dynamic Memory Controller) (on patch2) - Modify the detailed
> correlation of buses for Exynos3250 on documentation (patch2) - Add
> the MFC bus node for Exynos3250 (on patch11, patch12) - Fix the
> duplicate frequency of bus_display on Exynos4x12.dtsi - Add the
> PPMU node for exynos4412-odroidu3 - Add the support of bus
> frequency for exynos4412-odroidu3
> 
> Detailed descirption for patch-set: 1. Add generic exynos bus
> frequency driver : This patch-set adds the generic exynos bus
> frequency driver for AXI bus of sub-blocks in exynos SoC. The
> Samsung Exynos SoC have the common architecture for bus between
> DRAM and sub-blocks in SoC.
> 
> There are the different buses according to Exynos SoC because
> Exynos SoC has the differnt sub-blocks and bus speed. In spite of
> this difference among Exynos SoCs, this driver is able to support
> almost Exynos SoC by adding unique data of each bus in the
> devicetree file.
> 
> In devicetree, each bus node has a bus clock, regulator,
> operation-point and devfreq-event devices which measure the
> utilization of each bus block.
> 
> For example, - The bus of DMC block in exynos3250.dtsi are listed
> below:
> 
> bus_dmc: bus_dmc { compatible = "samsung,exynos-bus"; clocks =
> <&cmu_dmc CLK_DIV_DMC>; clock-names = "bus"; operating-points-v2 =
> <&bus_dmc_opp_table>; status = "disabled"; };
> 
> bus_dmc_opp_table: opp_table1 { compatible =
> "operating-points-v2"; opp-shared;
> 
> opp@50000000 { opp-hz = /bits/ 64 <50000000>; opp-microvolt =
> <800000>; }; opp@100000000 { opp-hz = /bits/ 64 <100000000>; 
> opp-microvolt = <800000>; }; opp@134000000 { opp-hz = /bits/ 64
> <134000000>; opp-microvolt = <800000>; }; opp@200000000 { opp-hz =
> /bits/ 64 <200000000>; opp-microvolt = <825000>; }; opp@400000000
> { opp-hz = /bits/ 64 <400000000>; opp-microvolt = <875000>; }; };
> 
> - Usage case to handle the frequency and voltage of bus on runtime 
> in exynos3250-rinato.dts are listed below:
> 
> &bus_dmc { devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>; 
> vdd-supply = <&buck1_reg>;	/* VDD_MIF */ status = "okay"; };
> 
> 2. Add new passive governor of DEVFREQ framework (patch5-patch7) :
> This patch-set add the new passive governor for DEVFREQ framework. 
> The existing governors (ondemand, performance and so on) are used
> for DVFS (Dynamic Voltage and Frequency Scaling) drivers. The
> existing governors are independently used for specific device
> driver which don't give the influence to other device drviers and
> also don't receive the effect from other device drivers.
> 
> The passive governor depends on operation of parent driver with
> existing governors(ondemand, performance and so on) extremely and
> is not able to decide the new frequency by oneself. According to
> the decided new frequency of parent driver with governor, the
> passive governor uses it to decide the appropriate frequency for
> own device driver. The passive governor must need the following
> information from device tree:
> 
> For exameple, There are one more bus device drivers in Exynos3250
> which need to change their source clock according to their
> utilization on runtime. But, they share the same power line (e.g.,
> regulator). So, LEFTBUS bus driver is operated as parent with
> ondemand governor and then the rest device driver with passive
> governor.
> 
> The buses of Internal block in exynos3250.dtsi are listed below: 
> When LEFTBUS bus driver (parent) changes the bus frequency with 
> ondemand governor on runtime, the rest bus devices which sharing 
> the same power line (VDD_INT) will change the each bus frequency 
> according to the decision of LEFTBUS bus driver (parent).
> 
> - INT (Internal) block : VDD_INT |--- LEFTBUS |--- PERIL |--- MFC 
> |--- G3D |--- RIGHTBUS |--- FSYS |--- LCD0 |--- PERIR |--- ISP |---
> CAM
> 
> - The buss of INT block in exynos3250.dtsi are listed below: 
> bus_leftbus: bus_leftbus { compatible = "samsung,exynos-bus"; 
> clocks = <&cmu CLK_DIV_GDL>; clock-names = "bus"; 
> operating-points-v2 = <&bus_leftbus_opp_table>; status =
> "disabled"; };
> 
> bus_rightbus: bus_rightbus { compatible = "samsung,exynos-bus"; 
> clocks = <&cmu CLK_DIV_GDR>; clock-names = "bus"; 
> operating-points-v2 = <&bus_leftbus_opp_table>; status =
> "disabled"; };
> 
> (Omit the rest bus dt node)
> 
> - Usage case to handle the frequency and voltage of bus on runtime 
> in exynos3250-rinato.dts are listed below: /* Parent bus device of
> VDD_INT */ &bus_leftbus { devfreq-events = <&ppmu_leftbus_3>,
> <&ppmu_rightbus_3>; vdd-supply = <&buck3_reg>; status = "okay"; };
> 
> /* Passive bus device depend on LEFTBUS bus. */ &bus_rightbus { 
> devfreq = <&bus_leftbus>; /* 'devfreq' property indicates the
> phandle of parent device. */ status = "okay"; };
> 
> (Omit the rest bus dt node)
> 
> Chanwoo Choi (20): PM / devfreq: exynos: Add generic exynos bus
> frequency driver PM / devfreq: exynos: Add documentation for
> generic exynos bus frequency driver ARM: dts: Add DMC bus node for
> Exynos3250 ARM: dts: Add DMC bus frequency for
> exynos3250-rinato/monk PM / devfreq: Add new passive governor PM /
> devfreq: Add devfreq_get_devfreq_by_phandle() PM / devfreq: Show
> the related information according to governor type PM / devfreq:
> exynos: Add support of bus frequency of sub-blocks using passive
> governor PM / devfreq: exynos: Update documentation for bus devices
> using passive governor PM / devfreq: exynos: Add the detailed
> correlation between sub-blocks and power line PM / devfreq: exynos:
> Remove unused exynos4/5 busfreq driver MAINTAINERS: Add samsung bus
> frequency driver entry ARM: dts: Add bus nodes using VDD_INT for
> Exynos3250 ARM: dts: Add bus nodes using VDD_MIF for Exynos4x12 
> ARM: dts: Add bus nodes using VDD_INT for Exynos4x12 ARM: dts: Add
> bus nodes using VDD_MIF for Exynos4210 ARM: dts: Add
> exynos4412-ppmu-common dtsi to delete duplicate PPMU nodes ARM:
> dts: Add support of bus frequency using VDD_INT for
> exynos3250-rinato ARM: dts: Expand the voltage range of buck1/3
> regulator for exynos4412-odroidu3 ARM: dts: Add support of bus
> frequency for exynos4412-trats/odroidu3
> 
> .../devicetree/bindings/devfreq/exynos-bus.txt     |  388 +++++++ 
> MAINTAINERS                                        |    9 + 
> arch/arm/boot/dts/exynos3250-monk.dts              |   47 +- 
> arch/arm/boot/dts/exynos3250-rinato.dts            |   88 +- 
> arch/arm/boot/dts/exynos3250.dtsi                  |  181 ++++ 
> arch/arm/boot/dts/exynos4210.dtsi                  |  159 +++ 
> arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   54 +- 
> arch/arm/boot/dts/exynos4412-ppmu-common.dtsi      |   50 + 
> arch/arm/boot/dts/exynos4412-trats2.dts            |   88 +- 
> arch/arm/boot/dts/exynos4x12.dtsi                  |  174 ++++ 
> drivers/devfreq/Kconfig                            |   37 +- 
> drivers/devfreq/Makefile                           |    2 + 
> drivers/devfreq/devfreq.c                          |  120 ++- 
> drivers/devfreq/exynos/Makefile                    |    3 +- 
> drivers/devfreq/exynos/exynos-bus.c                |  556
> +++++++++++ drivers/devfreq/exynos/exynos4_bus.c               |
> 1055 -------------------- drivers/devfreq/exynos/exynos4_bus.h
> |  110 -- drivers/devfreq/exynos/exynos5_bus.c               |  431
> -------- drivers/devfreq/exynos/exynos_ppmu.c               |  119
> --- drivers/devfreq/exynos/exynos_ppmu.h               |   86 -- 
> drivers/devfreq/governor.h                         |    7 + 
> drivers/devfreq/governor_passive.c                 |  109 ++ 
> drivers/devfreq/governor_performance.c             |    1 + 
> drivers/devfreq/governor_powersave.c               |    1 + 
> drivers/devfreq/governor_simpleondemand.c          |    1 + 
> drivers/devfreq/governor_userspace.c               |    1 + 
> include/linux/devfreq.h                            |   26 + 27
> files changed, 1955 insertions(+), 1948 deletions(-) create mode
> 100644 Documentation/devicetree/bindings/devfreq/exynos-bus.txt 
> create mode 100644 arch/arm/boot/dts/exynos4412-ppmu-common.dtsi 
> create mode 100644 drivers/devfreq/exynos/exynos-bus.c delete mode
> 100644 drivers/devfreq/exynos/exynos4_bus.c delete mode 100644
> drivers/devfreq/exynos/exynos4_bus.h delete mode 100644
> drivers/devfreq/exynos/exynos5_bus.c delete mode 100644
> drivers/devfreq/exynos/exynos_ppmu.c delete mode 100644
> drivers/devfreq/exynos/exynos_ppmu.h create mode 100644
> drivers/devfreq/governor_passive.c
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWnf5NAAoJED7hu3+zyiIosLoP/0Axz84pD1ZE5Ctd1LK7dR4A
QiKq1fxbrryCiIJLqIjl4VVEGiDoPh0ofl9FbhX/qn6u+iu18O0CBsyr+LkaxH0Y
xA1fZK5N/4FbsMaCrbmu+52o4bdHYjZGGLahClLHAQ8K3ADkqJtwsoADCI+XbCVx
Yut5HI6WCc4wmItAOKW3N5nTU9SCWJ+V2N1dcC4qUShx2XEU8jJOsLgJcALNJB6g
p1OdFtdY7kLUgL51pFrtHuuchEfnqaoJtuKZx+dW8TM8/yD34NzSufOyU9Pdw1zN
1hiXSbgPSZTVzlUH2CmbKxAmSxdPDuh9sAMpiJyy1iFst3N0zsSw7hH7QH3goj8y
Epsc1/TisBmvFw+ILbBVnFXCJWpfebzjB+4z0HsqvPcjfy/JNAl0rWigDo5EbdT9
N/hJj5QeCxkv6zqGY0/MKKDFZlti5ecUBW/GzKqsZ730x8SvBvHK77ikJryFYLXT
HUhAHrYvsvZ/yZYQpRvsCUlcDykhaOT6JFdvbNJZ6mIPWc+AxU2pu72GfhjE5y7o
S2NcskLzRhcadQDRjn8Gt8fUwqry1xv+brzscn1n1wtdwPi+T2ltH6gRJs9r00UT
ZqxEH8LmLNpK0wpeEyG9i2LnJN3pH9C56//PVLzej9JJM8cWLL/4nwHh7zH5QAT4
0/4ww0+Zn24h1nbEZjbt
=mWFs
-----END PGP SIGNATURE-----
