From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v4 00/20] PM / devferq: Add generic exynos bus frequency
 driver and new passive governor
Date: Mon, 22 Feb 2016 10:00:30 +0900
Message-ID: <56CA5DAE.50602@samsung.com>
References: <1450075104-13705-1-git-send-email-cw00.choi@samsung.com>
 <56C72F3F.3000603@math.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:60179 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304AbcBVBAd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 21 Feb 2016 20:00:33 -0500
In-reply-to: <56C72F3F.3000603@math.uni-bielefeld.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, myungjoo.ham@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org

Hello Tobias,

On 2016=EB=85=84 02=EC=9B=94 20=EC=9D=BC 00:05, Tobias Jakobi wrote:
> Hello,
>=20
> I've applied the patchset to 4.5-rc4 and I'm now encountering two
> additional problems. The first related to debugfs entries, the second
> cocerning RCU locking.
>=20
> Here are the debugfs lines:
> exynos-bus bus_dmc: device_opp_debug_create_link: Failed to create li=
nk
> exynos-bus bus_dmc: _add_list_dev: Failed to register opp debugfs (-1=
2)
> exynos-bus bus_dmc: Looking up vdd-supply from device tree
> exynos-bus: new bus device registered: bus_dmc (100000 KHz ~ 400000 K=
Hz)
> exynos-bus bus_acp: device_opp_debug_create_link: Failed to create li=
nk
> exynos-bus bus_acp: _add_list_dev: Failed to register opp debugfs (-1=
2)
> exynos-bus: new bus device registered: bus_acp (100000 KHz ~ 267000 K=
Hz)
> exynos-bus bus_c2c: device_opp_debug_create_link: Failed to create li=
nk
> exynos-bus bus_c2c: _add_list_dev: Failed to register opp debugfs (-1=
2)
> exynos-bus: new bus device registered: bus_c2c (100000 KHz ~ 400000 K=
Hz)
> exynos-bus bus_leftbus: device_opp_debug_create_link: Failed to creat=
e link
> devfreq bus_dmc: Couldn't update frequency transition information.
> exynos-bus bus_leftbus: _add_list_dev: Failed to register opp debugfs=
 (-12)
> exynos-bus bus_leftbus: Looking up vdd-supply from device tree
>=20
>=20
> The RCU output is a bit longer, so I attached it.

Thanks for your test and report.

I'm re-implementing this patchset related to devfreq core.
I'll check the issue and resolve it.

Best Regards,
Chanwoo Choi

>=20
>=20
> With best wishes,
> Tobias
>=20
>=20
> Chanwoo Choi wrote:
>> This patch-set includes the two features as following. The generic e=
xynos bus
>> frequency driver is able to support almost Exynos SoCs for bus frequ=
ency
>> scaling. And the new passive governor is able to make the dependency=
 on
>> between devices for frequency/voltage scaling. I had posted the patc=
h-set[2]
>> with the similiar concept. This is is revised version for exynos bus=
 frequency.
>> - Generic exynos bus frequency driver
>> - New passive governor of DEVFREQ framework
>>
>> Depend on:
>> - next-20151210 tag of linux-next (master branch).
>> - Merge the latest devfreq patches on devfreq.git[2] (for-rafael bra=
nch).
>> [1] https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git/ (b=
ranch: for-rafael)
>> [2] https://lkml.org/lkml/2015/1/7/872
>>    : [PATCHv3 0/8] devfreq: Add generic exynos memory-bus frequency =
driver
>>
>> Changes from v3:
>> (https://lkml.org/lkml/2015/12/11/75)
>> - Add the reviewed-by tag from Krzysztof Kozlowski (patch2/3/13/14/1=
5/16/17)
>> - Fix typo of the description on patch14
>> - Modify the subject and description of patch17
>> - Reorder the 'bus_xxx' device tree node alphabetically in=20
>>   both exynos3250-rinato/monk.dts and exynos4412-trats/odroidu3
>>
>> Changes from v2:
>> (https://lkml.org/lkml/2015/12/8/869)
>> - Fix typo on documentation
>> - Modify the more appropriate sentence on patch description
>> - Add the detailed description about both parent and passive bus dev=
ice
>> - Modify the DMC frequency for Exynos4x12 DMC bus (200MHz -> 267MHz)
>> - Modify the voltage of 200MHz was included in Exynos3250 DMC bus (8=
00mV -> 825mV)
>> - Rename OPP nodes as 'opp@<opp-hz>'
>> - Delete the duplicate 'opp-microvolt' property of passive devfreq d=
evice
>> - Reorder the 'bus_xxx' device tree node alphabetically in exynos325=
0-rinato/monk.dts
>> - Reorder the 'bus_xxx' device tree node alphabetically in exynos441=
2-trats/odroidu3
>> - Add new exynos4412-ppmu-common.dtsi to remove the duplicate PPMU d=
t node
>>   on rinato/monk/trats2/odroid-u3 board
>> - Add the log message if bus device is registered to devfreq framewo=
rk successfully
>> - Add the reviewed-by tag from Krzysztof Kozlowski
>> - Add the tested-by tag from Anand Moon on Odroid U3
>> - Add 'SAMSUNG BUS FREQUENCY DRIVER' entry to MAINTAINERS
>>
>> Changes from v1:
>> (https://lkml.org/lkml/2015/11/26/260)
>> - Check whether the instance of regulator is NULL or not
>>   when executing regulator_disable() because of only parent
>>   devfreq device has the regulator instance. After fixing it,
>>   the wake-up from suspend state is well working. (patch1)
>> - Fix bug which checks 'bus-clk' instead of 'bus->regulator'
>>   after calling devm_clk_get() (on patch1)
>> - Update the documentation to remove the description about
>>   DEVFREQ-EVENT subsystem (on patch2)
>> - Add the full name of DMC (Dynamic Memory Controller) (on patch2)
>> - Modify the detailed correlation of buses for Exynos3250
>>   on documentation (patch2)
>> - Add the MFC bus node for Exynos3250 (on patch11, patch12)
>> - Fix the duplicate frequency of bus_display on Exynos4x12.dtsi
>> - Add the PPMU node for exynos4412-odroidu3
>> - Add the support of bus frequency for exynos4412-odroidu3
>>
>> Detailed descirption for patch-set:
>> 1. Add generic exynos bus frequency driver
>> : This patch-set adds the generic exynos bus frequency driver for AX=
I bus
>> of sub-blocks in exynos SoC. The Samsung Exynos SoC have the common
>> architecture for bus between DRAM and sub-blocks in SoC.
>>
>>  There are the different buses according to Exynos SoC because Exyno=
s SoC
>> has the differnt sub-blocks and bus speed. In spite of this differen=
ce
>> among Exynos SoCs, this driver is able to support almost Exynos SoC =
by adding
>> unique data of each bus in the devicetree file.
>>
>>  In devicetree, each bus node has a bus clock, regulator, operation-=
point
>> and devfreq-event devices which measure the utilization of each bus =
block.
>>
>> For example,
>> - The bus of DMC block in exynos3250.dtsi are listed below:
>>
>> 	bus_dmc: bus_dmc {
>> 		compatible =3D "samsung,exynos-bus";
>> 		clocks =3D <&cmu_dmc CLK_DIV_DMC>;
>> 		clock-names =3D "bus";
>> 		operating-points-v2 =3D <&bus_dmc_opp_table>;
>> 		status =3D "disabled";
>> 	};
>>
>> 	bus_dmc_opp_table: opp_table1 {
>> 		compatible =3D "operating-points-v2";
>> 		opp-shared;
>>
>> 		opp@50000000 {
>> 			opp-hz =3D /bits/ 64 <50000000>;
>> 			opp-microvolt =3D <800000>;
>> 		};
>> 		opp@100000000 {
>> 			opp-hz =3D /bits/ 64 <100000000>;
>> 			opp-microvolt =3D <800000>;
>> 		};
>> 		opp@134000000 {
>> 			opp-hz =3D /bits/ 64 <134000000>;
>> 			opp-microvolt =3D <800000>;
>> 		};
>> 		opp@200000000 {
>> 			opp-hz =3D /bits/ 64 <200000000>;
>> 			opp-microvolt =3D <825000>;
>> 		};
>> 		opp@400000000 {
>> 			opp-hz =3D /bits/ 64 <400000000>;
>> 			opp-microvolt =3D <875000>;
>> 		};
>> 	};
>>
>> - Usage case to handle the frequency and voltage of bus on runtime
>>   in exynos3250-rinato.dts are listed below:
>>
>> 	&bus_dmc {
>> 		devfreq-events =3D <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
>> 		vdd-supply =3D <&buck1_reg>;	/* VDD_MIF */
>> 		status =3D "okay";
>> 	};
>>
>> 2. Add new passive governor of DEVFREQ framework (patch5-patch7)
>> : This patch-set add the new passive governor for DEVFREQ framework.
>> The existing governors (ondemand, performance and so on) are used fo=
r DVFS
>> (Dynamic Voltage and Frequency Scaling) drivers. The existing govern=
ors
>> are independently used for specific device driver which don't give t=
he
>> influence to other device drviers and also don't receive the effect =
from
>> other device drivers.
>>
>>  The passive governor depends on operation of parent driver with exi=
sting
>> governors(ondemand, performance and so on) extremely and is not able=
 to
>> decide the new frequency by oneself. According to the decided new fr=
equency
>> of parent driver with governor, the passive governor uses it to deci=
de
>> the appropriate frequency for own device driver. The passive governo=
r
>> must need the following information from device tree:
>>
>> For exameple,
>>  There are one more bus device drivers in Exynos3250 which need to
>> change their source clock according to their utilization on runtime.
>> But, they share the same power line (e.g., regulator). So, LEFTBUS b=
us
>> driver is operated as parent with ondemand governor and then the res=
t
>> device driver with passive governor.
>>
>>  The buses of Internal block in exynos3250.dtsi are listed below:
>> When LEFTBUS bus driver (parent) changes the bus frequency with
>> ondemand governor on runtime, the rest bus devices which sharing
>> the same power line (VDD_INT) will change the each bus frequency
>> according to the decision of LEFTBUS bus driver (parent).
>>
>> - INT (Internal) block
>> 	: VDD_INT |--- LEFTBUS
>> 		  |--- PERIL
>> 		  |--- MFC
>> 		  |--- G3D
>> 		  |--- RIGHTBUS
>> 		  |--- FSYS
>> 		  |--- LCD0
>> 		  |--- PERIR
>> 		  |--- ISP
>> 		  |--- CAM
>>
>> - The buss of INT block in exynos3250.dtsi are listed below:
>> 	bus_leftbus: bus_leftbus {
>> 		compatible =3D "samsung,exynos-bus";
>> 		clocks =3D <&cmu CLK_DIV_GDL>;
>> 		clock-names =3D "bus";
>> 		operating-points-v2 =3D <&bus_leftbus_opp_table>;
>> 		status =3D "disabled";
>> 	};
>>
>> 	bus_rightbus: bus_rightbus {
>> 		compatible =3D "samsung,exynos-bus";
>> 		clocks =3D <&cmu CLK_DIV_GDR>;
>> 		clock-names =3D "bus";
>> 		operating-points-v2 =3D <&bus_leftbus_opp_table>;
>> 		status =3D "disabled";
>> 	};
>>
>> 	(Omit the rest bus dt node)
>>
>> - Usage case to handle the frequency and voltage of bus on runtime
>>   in exynos3250-rinato.dts are listed below:
>> 	/* Parent bus device of VDD_INT */
>> 	&bus_leftbus {
>> 		devfreq-events =3D <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
>> 		vdd-supply =3D <&buck3_reg>;
>> 		status =3D "okay";
>> 	};
>>
>> 	/* Passive bus device depend on LEFTBUS bus. */
>> 	&bus_rightbus {
>> 		devfreq =3D <&bus_leftbus>; /* 'devfreq' property indicates
>> 					     the phandle of parent device. */
>> 		status =3D "okay";
>> 	};
>>
>> 	(Omit the rest bus dt node)
>>
>> Chanwoo Choi (20):
>>   PM / devfreq: exynos: Add generic exynos bus frequency driver
>>   PM / devfreq: exynos: Add documentation for generic exynos bus fre=
quency driver
>>   ARM: dts: Add DMC bus node for Exynos3250
>>   ARM: dts: Add DMC bus frequency for exynos3250-rinato/monk
>>   PM / devfreq: Add new passive governor
>>   PM / devfreq: Add devfreq_get_devfreq_by_phandle()
>>   PM / devfreq: Show the related information according to governor t=
ype
>>   PM / devfreq: exynos: Add support of bus frequency of sub-blocks u=
sing passive governor
>>   PM / devfreq: exynos: Update documentation for bus devices using p=
assive governor
>>   PM / devfreq: exynos: Add the detailed correlation between sub-blo=
cks and power line
>>   PM / devfreq: exynos: Remove unused exynos4/5 busfreq driver
>>   MAINTAINERS: Add samsung bus frequency driver entry
>>   ARM: dts: Add bus nodes using VDD_INT for Exynos3250
>>   ARM: dts: Add bus nodes using VDD_MIF for Exynos4x12
>>   ARM: dts: Add bus nodes using VDD_INT for Exynos4x12
>>   ARM: dts: Add bus nodes using VDD_MIF for Exynos4210
>>   ARM: dts: Add exynos4412-ppmu-common dtsi to delete duplicate PPMU=
 nodes
>>   ARM: dts: Add support of bus frequency using VDD_INT for exynos325=
0-rinato
>>   ARM: dts: Expand the voltage range of buck1/3 regulator for exynos=
4412-odroidu3
>>   ARM: dts: Add support of bus frequency for exynos4412-trats/odroid=
u3
>>
>>  .../devicetree/bindings/devfreq/exynos-bus.txt     |  388 +++++++
>>  MAINTAINERS                                        |    9 +
>>  arch/arm/boot/dts/exynos3250-monk.dts              |   47 +-
>>  arch/arm/boot/dts/exynos3250-rinato.dts            |   88 +-
>>  arch/arm/boot/dts/exynos3250.dtsi                  |  181 ++++
>>  arch/arm/boot/dts/exynos4210.dtsi                  |  159 +++
>>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   54 +-
>>  arch/arm/boot/dts/exynos4412-ppmu-common.dtsi      |   50 +
>>  arch/arm/boot/dts/exynos4412-trats2.dts            |   88 +-
>>  arch/arm/boot/dts/exynos4x12.dtsi                  |  174 ++++
>>  drivers/devfreq/Kconfig                            |   37 +-
>>  drivers/devfreq/Makefile                           |    2 +
>>  drivers/devfreq/devfreq.c                          |  120 ++-
>>  drivers/devfreq/exynos/Makefile                    |    3 +-
>>  drivers/devfreq/exynos/exynos-bus.c                |  556 +++++++++=
++
>>  drivers/devfreq/exynos/exynos4_bus.c               | 1055 ---------=
-----------
>>  drivers/devfreq/exynos/exynos4_bus.h               |  110 --
>>  drivers/devfreq/exynos/exynos5_bus.c               |  431 --------
>>  drivers/devfreq/exynos/exynos_ppmu.c               |  119 ---
>>  drivers/devfreq/exynos/exynos_ppmu.h               |   86 --
>>  drivers/devfreq/governor.h                         |    7 +
>>  drivers/devfreq/governor_passive.c                 |  109 ++
>>  drivers/devfreq/governor_performance.c             |    1 +
>>  drivers/devfreq/governor_powersave.c               |    1 +
>>  drivers/devfreq/governor_simpleondemand.c          |    1 +
>>  drivers/devfreq/governor_userspace.c               |    1 +
>>  include/linux/devfreq.h                            |   26 +
>>  27 files changed, 1955 insertions(+), 1948 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/devfreq/exynos=
-bus.txt
>>  create mode 100644 arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
>>  create mode 100644 drivers/devfreq/exynos/exynos-bus.c
>>  delete mode 100644 drivers/devfreq/exynos/exynos4_bus.c
>>  delete mode 100644 drivers/devfreq/exynos/exynos4_bus.h
>>  delete mode 100644 drivers/devfreq/exynos/exynos5_bus.c
>>  delete mode 100644 drivers/devfreq/exynos/exynos_ppmu.c
>>  delete mode 100644 drivers/devfreq/exynos/exynos_ppmu.h
>>  create mode 100644 drivers/devfreq/governor_passive.c
>>
>=20

