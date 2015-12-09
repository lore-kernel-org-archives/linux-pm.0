From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 00/19] PM / devferq: Add generic exynos bus frequency driver
 and new passive governor
Date: Wed, 09 Dec 2015 13:07:52 +0900
Message-ID: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch-set includes the two features as following. The generic exynos bus
frequency driver is able to support almost Exynos SoCs for bus frequency
scaling. And the new passive governor is able to make the dependency on
between devices for frequency/voltage scaling. I had posted the patch-set[1]
with the similiar concept. This is is revised version for exynos bus frequency.
- Generic exynos bus frequency driver
- New passive governor of DEVFREQ framework

Depends on:
- This patch-set is based on devfreq.git[2].
[1] https://lkml.org/lkml/2015/1/7/872
   : [PATCHv3 0/8] devfreq: Add generic exynos memory-bus frequency driver
[2] https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git/ (branch: for-rafael)

Changes from v1:
(https://lkml.org/lkml/2015/11/26/260)
- Check whether the instance of regulator is NULL or not
  when executing regulator_disable() because of only parent
  devfreq device has the regulator instance. After fixing it,
  the wake-up from suspend state is well working. (patch1)
- Fix bug which checks 'bus-clk' instead of 'bus->regulator'
  after calling devm_clk_get() (on patch1)
- Update the documentation to remove the description about
  DEVFREQ-EVENT subsystem (on patch2)
- Add the full name of DMC (Dynamic Memory Controller) (on patch2)
- Modify the detailed correlation of buses for Exynos3250
  on documentation (patch2)
- Add the MFC bus node for Exynos3250 (on patch11, patch12)
- Fix the duplicate frequency of bus_display on Exynos4x12.dtsi
- Add the PPMU node for exynos4412-odroidu3
- Add the support of bus frequency for exynos4412-odroidu3

Detailed descirption for patch-set:
1. Add generic exynos bus frequency driver
: This patch-set adds the generic exynos bus frequency driver for AXI bus
of sub-blocks in exynos SoC. The Samsung Exynos SoC have the common
architecture for bus between DRAM and sub-blocks in SoC.

 There are the different buses according to Exynos SoC because Exynos SoC
has the differnt sub-blocks and bus speed. In spite of this difference
among Exynos SoCs, this driver is able to support almost Exynos SoC by adding
unique data of each bus in the devicetree file.

 In devicetree, each bus node has a bus clock, regulator, operation-point
and devfreq-event devices which measure the utilization of each bus block.

For example,
- The bus of DMC block in exynos3250.dtsi are listed below:

	bus_dmc: bus_dmc {
		compatible = "samsung,exynos-bus";
		clocks = <&cmu_dmc CLK_DIV_DMC>;
		clock-names = "bus";
		operating-points-v2 = <&bus_dmc_opp_table>;
		status = "disabled";
	};

	bus_dmc_opp_table: opp_table0 {
		compatible = "operating-points-v2";
		opp-shared;

		opp00 {
			opp-hz = /bits/ 64 <50000000>;
			opp-microvolt = <800000>;
		};
		opp01 {
			opp-hz = /bits/ 64 <100000000>;
			opp-microvolt = <800000>;
		};
		opp02 {
			opp-hz = /bits/ 64 <134000000>;
			opp-microvolt = <800000>;
		};
		opp03 {
			opp-hz = /bits/ 64 <200000000>;
			opp-microvolt = <800000>;
		};
		opp04 {
			opp-hz = /bits/ 64 <400000000>;
			opp-microvolt = <875000>;
		};
	};

- Usage case to handle the frequency and voltage of bus on runtime
  in exynos3250-rinato.dts are listed below:

	&bus_dmc {
		devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
		vdd-supply = <&buck1_reg>;	/* VDD_MIF */
		status = "okay";
	};

2. Add new passive governor of DEVFREQ framework (patch5-patch7)
: This patch-set add the new passive governor for DEVFREQ framework.
The existing governors (ondemand, performance and so on) are used for DVFS
(Dynamic Voltage and Frequency Scaling) drivers. The existing governors
are independently used for specific device driver which don't give the
influence to other device drviers and also don't receive the effect from
other device drivers.

 The passive governor depends on operation of parent driver with existing
governors(ondemand, performance and so on) extremely and is not able to
decide the new frequency by oneself. According to the decided new frequency
of parent driver with governor, the passive governor uses it to decide
the appropriate frequency for own device driver. The passive governor
must need the following information from device tree:

For exameple,
 There are one more bus device drivers in Exynos3250 which need to
change their source clock according to their utilization on runtime.
But, they share the same power line (e.g., regulator). So, LEFTBUS bus
driver is operated as parent with ondemand governor and then the rest
device driver with passive governor.

 The buses of Internal block in exynos3250.dtsi are listed below:
When LEFTBUS bus driver (parent) changes the bus frequency with
ondemand governor on runtime, the rest bus devices which sharing
the same power line (VDD_INT) will change the each bus frequency
according to the decision of LEFTBUS bus driver (parent).

- INT (Internal) block
	: VDD_INT |--- LEFTBUS
		  |--- PERIL
		  |--- MFC
		  |--- G3D
		  |--- RIGHTBUS
		  |--- FSYS
		  |--- LCD0
		  |--- PERIR
		  |--- ISP
		  |--- CAM

- The buss of INT block in exynos3250.dtsi are listed below:
	bus_leftbus: bus_leftbus {
		compatible = "samsung,exynos-bus";
		clocks = <&cmu CLK_DIV_GDL>;
		clock-names = "bus";
		operating-points-v2 = <&bus_leftbus_opp_table>;
		status = "disabled";
	};

	bus_rightbus: bus_rightbus {
		compatible = "samsung,exynos-bus";
		clocks = <&cmu CLK_DIV_GDR>;
		clock-names = "bus";
		operating-points-v2 = <&bus_leftbus_opp_table>;
		status = "disabled";
	};

	(Omit the rest bus dt node)

- Usage case to handle the frequency and voltage of bus on runtime
  in exynos3250-rinato.dts are listed below:
	/* Parent bus device of VDD_INT */
	&bus_leftbus {
		devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
		vdd-supply = <&buck3_reg>;
		status = "okay";
	};

	/* Passive bus device depend on LEFTBUS bus. */
	&bus_rightbus {
		devfreq = <&bus_leftbus>; /* 'devfreq' property indicates
					     the phandle of parent device. */
		status = "okay";
	};

	(Omit the rest bus dt node)

Chanwoo Choi (19):
  PM / devfreq: exynos: Add generic exynos bus frequency driver
  PM / devfreq: exynos: Add documentation for generic exynos bus frequency driver
  ARM: dts: Add DMC bus node for Exynos3250
  ARM: dts: Add DMC bus frequency for exynos3250-rinato/monk
  PM / devfreq: Add new passive governor
  PM / devfreq: Add devfreq_get_devfreq_by_phandle()
  PM / devfreq: Show the related information according to governor type
  PM / devfreq: exynos: Add support of bus frequency of sub-blocks using passive governor
  PM / devfreq: exynos: Update documentation for bus devices using passive governor
  PM / devfreq: exynos: Add the detailed correlation between sub-blocks and power line
  PM / devfreq: exynos: Remove unused exynos4/5 busfreq driver
  ARM: dts: Add bus nodes using VDD_INT for Exynos3250
  ARM: dts: Add bus nodes using VDD_MIF for Exynos4x12
  ARM: dts: Add bus nodes using VDD_INT for Exynos4x12
  ARM: dts: Add bus nodes using VDD_MIF for Exynos4210
  ARM: dts: Add PPMU node for exynos4412-odroidu3
  ARM: dts: Add support of bus frequency using VDD_INT for exynos3250-rinato
  ARM: dts: Expand the voltage range of buck1/3 regulator for exynos4412-odroidu3
  ARM: dts: Add support of bus frequency for exynos4412-trats/odroidu3

 .../devicetree/bindings/devfreq/exynos-bus.txt     |  383 +++++++
 arch/arm/boot/dts/exynos3250-monk.dts              |    6 +
 arch/arm/boot/dts/exynos3250-rinato.dts            |   47 +
 arch/arm/boot/dts/exynos3250.dtsi                  |  194 ++++
 arch/arm/boot/dts/exynos4210.dtsi                  |  172 ++++
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   93 +-
 arch/arm/boot/dts/exynos4412-trats2.dts            |   47 +
 arch/arm/boot/dts/exynos4x12.dtsi                  |  184 ++++
 drivers/devfreq/Kconfig                            |   37 +-
 drivers/devfreq/Makefile                           |    2 +
 drivers/devfreq/devfreq.c                          |  120 ++-
 drivers/devfreq/exynos/Makefile                    |    3 +-
 drivers/devfreq/exynos/exynos-bus.c                |  549 ++++++++++
 drivers/devfreq/exynos/exynos4_bus.c               | 1055 --------------------
 drivers/devfreq/exynos/exynos4_bus.h               |  110 --
 drivers/devfreq/exynos/exynos5_bus.c               |  431 --------
 drivers/devfreq/exynos/exynos_ppmu.c               |  119 ---
 drivers/devfreq/exynos/exynos_ppmu.h               |   86 --
 drivers/devfreq/governor.h                         |    7 +
 drivers/devfreq/governor_passive.c                 |  109 ++
 drivers/devfreq/governor_performance.c             |    1 +
 drivers/devfreq/governor_powersave.c               |    1 +
 drivers/devfreq/governor_simpleondemand.c          |    1 +
 drivers/devfreq/governor_userspace.c               |    1 +
 include/linux/devfreq.h                            |   28 +
 25 files changed, 1958 insertions(+), 1828 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/devfreq/exynos-bus.txt
 create mode 100644 drivers/devfreq/exynos/exynos-bus.c
 delete mode 100644 drivers/devfreq/exynos/exynos4_bus.c
 delete mode 100644 drivers/devfreq/exynos/exynos4_bus.h
 delete mode 100644 drivers/devfreq/exynos/exynos5_bus.c
 delete mode 100644 drivers/devfreq/exynos/exynos_ppmu.c
 delete mode 100644 drivers/devfreq/exynos/exynos_ppmu.h
 create mode 100644 drivers/devfreq/governor_passive.c

-- 
1.9.1
