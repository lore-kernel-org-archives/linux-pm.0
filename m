From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH v5 00/21] PM / devferq: Add generic exynos bus frequency
 driver and new passive governor
Date: Thu, 24 Mar 2016 23:21:34 +0900
Message-ID: <CAGTfZH3oSWkcfCC691f8Y3H6e3zb8jSqYOki6x5GaPKjkGt3DA@mail.gmail.com>
References: <1458793530-31897-1-git-send-email-cw00.choi@samsung.com>
	<56F36D65.6030504@samsung.com>
	<56F3EE8E.3020308@fivetechno.de>
Reply-To: cw00.choi@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35717 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbcCXOVh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Mar 2016 10:21:37 -0400
In-Reply-To: <56F3EE8E.3020308@fivetechno.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Markus Reichl <m.reichl@fivetechno.de>
Cc: "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Anand Moon <linux.amoon@gmail.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>

Hi Makus,

On Thu, Mar 24, 2016 at 10:41 PM, Markus Reichl <m.reichl@fivetechno.de=
> wrote:
> Hi Chanwoo,
>
> Am 24.03.2016 um 05:30 schrieb Chanwoo Choi:
>> Dear Anand and Tobias,
>>
>> To Anand,
>> First of all, thanks to your test on previous patchset.
>> I removed the your tested-by tag from this version
>> because I modified the devfreq core using DEVFREQ_TRANSITION_NOTIFIE=
R notifier.
>> I think that this patch-set need to test with this patchset.
>> If you possible, could you please test this patch-set? Thanks in adv=
ance.
>>
>> To Tobias,
>> I fixed the following issues reported by you. Thanks your test and r=
eport.
>> - RCU locking issue
>> - debugfs error during kernel booting
>>
>> Best Regards,
>> Chanwoo Choi
>
> This set works fine on odroid U3 but gives the following with dmesg |=
grep devfreq:
>
> [    2.066890] devfreq bus_dmc: Couldn't update frequency transition =
information.
> [    2.190238] devfreq bus_leftbus: Couldn't update frequency transit=
ion information.

Tobias already replied it about this message. The devfreq core need to
be modified
about this issue. But, It is no problem for working exynos-bus.c driver=
=2E

If you possible, could you send the Tested-by tag reply about this patc=
h-set?

Best Regards,
Chanwoo Choi

>
> Thanks,
> --
> Markus Reichl
>
>>
>> On 2016=EB=85=84 03=EC=9B=94 24=EC=9D=BC 13:25, Chanwoo Choi wrote:
>>> Dear all,
>>>
>>> This patchset uses the DEVFREQ_TRANSITION_NOTIFIER notifier to conn=
ecth
>>> devfreq device using ondemand governor and devfreq device using pas=
sive
>>> governor. Also I fix the some issue reported by 'Tobias Jakobi' and=
 add the
>>> detailed issue information. But, this patchset don't modify the any=
thing of
>>> Device Tree patches (patch12 ~ patch21) which already got the revie=
wed-by
>>> from Exynos Soc Maintainer.
>>>
>>> I tested it on exynos3250-rinato and exynos4412-odroidu3 board.
>>>
>>> [Description]
>>> This patch-set includes the two features as following. The generic =
exynos bus
>>> frequency driver is able to support almost Exynos SoCs for bus freq=
uency
>>> scaling. And the new passive governor is able to make the dependenc=
y on
>>> between devices for frequency/voltage scaling. I had posted the pat=
ch-set[1]
>>> with the similiar concept. This is is revised version for exynos bu=
s frequency.
>>> - Generic exynos bus frequency driver
>>> - New passive governor of DEVFREQ framework
>>> [1] https://lkml.org/lkml/2015/1/7/872
>>> : [PATCHv3 0/8] devfreq: Add generic exynos memory-bus frequency dr=
iver
>>>
>>> Changes from v4:
>>> (https://lkml.org/lkml/2015/12/14/43)
>>> - Add new DEVFREQ_TRANSITION_NOTIFIER notifier. The passive
>>>   devfreq device recevie the changed frequency of parent
>>>   devfreq device through DEVFREQ_TRANSITION_NOTIFIER.
>>> - Add governor type to identify thme using the defined constant
>>> - Modify the passive governor using the DEVFREQ_TRANSITION_NOTIFIER=
 notifier.
>>> - Fix the RCU locking probrlm (Reported-by: Tobias Jakobi)
>>> - Fix the debugfs error during the kernel booting (Reported-by: Tob=
ias Jakobi)
>>>
>>> Changes from v3:
>>> (https://lkml.org/lkml/2015/12/11/75)
>>> - Add the reviewed-by tag from Krzysztof Kozlowski (patch2/3/13/14/=
15/16/17)
>>> - Fix typo of the description on patch14
>>> - Modify the subject and description of patch17
>>> - Reorder the 'bus_xxx' device tree node alphabetically in
>>>   both exynos3250-rinato/monk.dts and exynos4412-trats/odroidu3
>>>
>>> Changes from v2:
>>> (https://lkml.org/lkml/2015/12/8/869)
>>> - Fix typo on documentation
>>> - Modify the more appropriate sentence on patch description
>>> - Add the detailed description about both parent and passive bus de=
vice
>>> - Modify the DMC frequency for Exynos4x12 DMC bus (200MHz -> 267MHz=
)
>>> - Modify the voltage of 200MHz was included in Exynos3250 DMC bus (=
800mV -> 825mV)
>>> - Rename OPP nodes as 'opp@<opp-hz>'
>>> - Delete the duplicate 'opp-microvolt' property of passive devfreq =
device
>>> - Reorder the 'bus_xxx' device tree node alphabetically in exynos32=
50-rinato/monk.dts
>>> - Reorder the 'bus_xxx' device tree node alphabetically in exynos44=
12-trats/odroidu3
>>> - Add new exynos4412-ppmu-common.dtsi to remove the duplicate PPMU =
dt node
>>>   on rinato/monk/trats2/odroid-u3 board
>>> - Add the log message if bus device is registered to devfreq framew=
ork successfully
>>> - Add the reviewed-by tag from Krzysztof Kozlowski
>>> - Add the tested-by tag from Anand Moon on Odroid U3
>>> - Add 'SAMSUNG BUS FREQUENCY DRIVER' entry to MAINTAINERS
>>>
>>> Changes from v1:
>>> (https://lkml.org/lkml/2015/11/26/260)
>>> - Check whether the instance of regulator is NULL or not
>>>   when executing regulator_disable() because of only parent
>>>   devfreq device has the regulator instance. After fixing it,
>>>   the wake-up from suspend state is well working. (patch1)
>>> - Fix bug which checks 'bus-clk' instead of 'bus->regulator'
>>>   after calling devm_clk_get() (on patch1)
>>> - Update the documentation to remove the description about
>>>   DEVFREQ-EVENT subsystem (on patch2)
>>> - Add the full name of DMC (Dynamic Memory Controller) (on patch2)
>>> - Modify the detailed correlation of buses for Exynos3250
>>>   on documentation (patch2)
>>> - Add the MFC bus node for Exynos3250 (on patch11, patch12)
>>> - Fix the duplicate frequency of bus_display on Exynos4x12.dtsi
>>> - Add the PPMU node for exynos4412-odroidu3
>>> - Add the support of bus frequency for exynos4412-odroidu3
>>>
>>> Detailed descirption for patch-set:
>>> 1. Add generic exynos bus frequency driver
>>> : This patch-set adds the generic exynos bus frequency driver for A=
XI bus
>>> of sub-blocks in exynos SoC. The Samsung Exynos SoC have the common
>>> architecture for bus between DRAM and sub-blocks in SoC.
>>>
>>>  There are the different buses according to Exynos SoC because Exyn=
os SoC
>>> has the differnt sub-blocks and bus speed. In spite of this differe=
nce
>>> among Exynos SoCs, this driver is able to support almost Exynos SoC=
 by adding
>>> unique data of each bus in the devicetree file.
>>>
>>>  In devicetree, each bus node has a bus clock, regulator, operation=
-point
>>> and devfreq-event devices which measure the utilization of each bus=
 block.
>>>
>>> For example,
>>> - The bus of DMC block in exynos3250.dtsi are listed below:
>>>
>>>      bus_dmc: bus_dmc {
>>>              compatible =3D "samsung,exynos-bus";
>>>              clocks =3D <&cmu_dmc CLK_DIV_DMC>;
>>>              clock-names =3D "bus";
>>>              operating-points-v2 =3D <&bus_dmc_opp_table>;
>>>              status =3D "disabled";
>>>      };
>>>
>>>      bus_dmc_opp_table: opp_table1 {
>>>              compatible =3D "operating-points-v2";
>>>              opp-shared;
>>>
>>>              opp@50000000 {
>>>                      opp-hz =3D /bits/ 64 <50000000>;
>>>                      opp-microvolt =3D <800000>;
>>>              };
>>>              opp@100000000 {
>>>                      opp-hz =3D /bits/ 64 <100000000>;
>>>                      opp-microvolt =3D <800000>;
>>>              };
>>>              opp@134000000 {
>>>                      opp-hz =3D /bits/ 64 <134000000>;
>>>                      opp-microvolt =3D <800000>;
>>>              };
>>>              opp@200000000 {
>>>                      opp-hz =3D /bits/ 64 <200000000>;
>>>                      opp-microvolt =3D <825000>;
>>>              };
>>>              opp@400000000 {
>>>                      opp-hz =3D /bits/ 64 <400000000>;
>>>                      opp-microvolt =3D <875000>;
>>>              };
>>>      };
>>>
>>> - Usage case to handle the frequency and voltage of bus on runtime
>>>   in exynos3250-rinato.dts are listed below:
>>>
>>>      &bus_dmc {
>>>              devfreq-events =3D <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
>>>              vdd-supply =3D <&buck1_reg>;      /* VDD_MIF */
>>>              status =3D "okay";
>>>      };
>>>
>>> 2. Add new passive governor of DEVFREQ framework (patch5-patch7)
>>> : This patch-set add the new passive governor for DEVFREQ framework=
=2E
>>> The existing governors (ondemand, performance and so on) are used f=
or DVFS
>>> (Dynamic Voltage and Frequency Scaling) drivers. The existing gover=
nors
>>> are independently used for specific device driver which don't give =
the
>>> influence to other device drviers and also don't receive the effect=
 from
>>> other device drivers.
>>>
>>>  The passive governor depends on operation of parent driver with ex=
isting
>>> governors(ondemand, performance and so on) extremely and is not abl=
e to
>>> decide the new frequency by oneself. According to the decided new f=
requency
>>> of parent driver with governor, the passive governor uses it to dec=
ide
>>> the appropriate frequency for own device driver. The passive govern=
or
>>> must need the following information from device tree:
>>>
>>> For exameple,
>>>  There are one more bus device drivers in Exynos3250 which need to
>>> change their source clock according to their utilization on runtime=
=2E
>>> But, they share the same power line (e.g., regulator). So, LEFTBUS =
bus
>>> driver is operated as parent with ondemand governor and then the re=
st
>>> device driver with passive governor.
>>>
>>>  The buses of Internal block in exynos3250.dtsi are listed below:
>>> When LEFTBUS bus driver (parent) changes the bus frequency with
>>> ondemand governor on runtime, the rest bus devices which sharing
>>> the same power line (VDD_INT) will change the each bus frequency
>>> according to the decision of LEFTBUS bus driver (parent).
>>>
>>> - INT (Internal) block
>>>      : VDD_INT |--- LEFTBUS
>>>                |--- PERIL
>>>                |--- MFC
>>>                |--- G3D
>>>                |--- RIGHTBUS
>>>                |--- FSYS
>>>                |--- LCD0
>>>                |--- PERIR
>>>                |--- ISP
>>>                |--- CAM
>>>
>>> - The buss of INT block in exynos3250.dtsi are listed below:
>>>      bus_leftbus: bus_leftbus {
>>>              compatible =3D "samsung,exynos-bus";
>>>              clocks =3D <&cmu CLK_DIV_GDL>;
>>>              clock-names =3D "bus";
>>>              operating-points-v2 =3D <&bus_leftbus_opp_table>;
>>>              status =3D "disabled";
>>>      };
>>>
>>>      bus_rightbus: bus_rightbus {
>>>              compatible =3D "samsung,exynos-bus";
>>>              clocks =3D <&cmu CLK_DIV_GDR>;
>>>              clock-names =3D "bus";
>>>              operating-points-v2 =3D <&bus_leftbus_opp_table>;
>>>              status =3D "disabled";
>>>      };
>>>
>>>      (Omit the rest bus dt node)
>>>
>>> - Usage case to handle the frequency and voltage of bus on runtime
>>>   in exynos3250-rinato.dts are listed below:
>>>      /* Parent bus device of VDD_INT */
>>>      &bus_leftbus {
>>>              devfreq-events =3D <&ppmu_leftbus_3>, <&ppmu_rightbus_=
3>;
>>>              vdd-supply =3D <&buck3_reg>;
>>>              status =3D "okay";
>>>      };
>>>
>>>      /* Passive bus device depend on LEFTBUS bus. */
>>>      &bus_rightbus {
>>>              devfreq =3D <&bus_leftbus>; /* 'devfreq' property indi=
cates
>>>                                           the phandle of parent dev=
ice. */
>>>              status =3D "okay";
>>>      };
>>>
>>>      (Omit the rest bus dt node)
>>>
>>> Chanwoo Choi (21):
>>>   PM / devfreq: exynos: Add generic exynos bus frequency driver
>>>   PM / devfreq: exynos: Add documentation for generic exynos bus fr=
equency driver
>>>   PM / devfreq: Add devfreq_get_devfreq_by_phandle()
>>>   PM / devfreq: Add new DEVFREQ_TRANSITION_NOTIFIER notifier
>>>   PM / devfreq: Add governer type with unique number
>>>   PM / devfreq: Add new passive governor
>>>   PM / devfreq: exynos: Add support of bus frequency of sub-blocks =
using passive governor
>>>   PM / devfreq: exynos: Update documentation for bus devices using =
passive governor
>>>   PM / devfreq: exynos: Add the detailed correlation between sub-bl=
ocks and power line
>>>   PM / devfreq: exynos: Remove unused exynos4/5 busfreq driver
>>>   MAINTAINERS: Add samsung bus frequency driver entry
>>>   ARM: dts: Add DMC bus node for Exynos3250
>>>   ARM: dts: Add DMC bus frequency for exynos3250-rinato/monk
>>>   ARM: dts: Add bus nodes using VDD_INT for Exynos3250
>>>   ARM: dts: Add bus nodes using VDD_MIF for Exynos4x12
>>>   ARM: dts: Add bus nodes using VDD_INT for Exynos4x12
>>>   ARM: dts: Add bus nodes using VDD_MIF for Exynos4210
>>>   ARM: dts: Add exynos4412-ppmu-common dtsi to delete duplicate PPM=
U nodes
>>>   ARM: dts: Add support of bus frequency using VDD_INT for exynos32=
50-rinato
>>>   ARM: dts: Expand the voltage range of buck1/3 regulator for exyno=
s4412-odroidu3
>>>   ARM: dts: Add support of bus frequency for exynos4412-trats/odroi=
du3
>>>
>>>  .../devicetree/bindings/devfreq/exynos-bus.txt     |  390 ++++++++
>>>  MAINTAINERS                                        |    9 +
>>>  arch/arm/boot/dts/exynos3250-monk.dts              |   47 +-
>>>  arch/arm/boot/dts/exynos3250-rinato.dts            |   88 +-
>>>  arch/arm/boot/dts/exynos3250.dtsi                  |  181 ++++
>>>  arch/arm/boot/dts/exynos4210.dtsi                  |  159 +++
>>>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   56 +-
>>>  arch/arm/boot/dts/exynos4412-ppmu-common.dtsi      |   50 +
>>>  arch/arm/boot/dts/exynos4412-trats2.dts            |   88 +-
>>>  arch/arm/boot/dts/exynos4x12.dtsi                  |  174 ++++
>>>  drivers/devfreq/Kconfig                            |   35 +-
>>>  drivers/devfreq/Makefile                           |    4 +-
>>>  drivers/devfreq/devfreq.c                          |  224 ++++-
>>>  drivers/devfreq/exynos-bus.c                       |  561 ++++++++=
+++
>>>  drivers/devfreq/exynos/Makefile                    |    3 -
>>>  drivers/devfreq/exynos/exynos4_bus.c               | 1055 --------=
------------
>>>  drivers/devfreq/exynos/exynos4_bus.h               |  110 --
>>>  drivers/devfreq/exynos/exynos5_bus.c               |  431 --------
>>>  drivers/devfreq/exynos/exynos_ppmu.c               |  119 ---
>>>  drivers/devfreq/exynos/exynos_ppmu.h               |   86 --
>>>  drivers/devfreq/governor.h                         |   21 +
>>>  drivers/devfreq/governor_passive.c                 |  192 ++++
>>>  drivers/devfreq/governor_performance.c             |    1 +
>>>  drivers/devfreq/governor_powersave.c               |    1 +
>>>  drivers/devfreq/governor_simpleondemand.c          |    1 +
>>>  drivers/devfreq/governor_userspace.c               |    1 +
>>>  include/linux/devfreq.h                            |   70 ++
>>>  27 files changed, 2209 insertions(+), 1948 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/devfreq/exyno=
s-bus.txt
>>>  create mode 100644 arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
>>>  create mode 100644 drivers/devfreq/exynos-bus.c
>>>  delete mode 100644 drivers/devfreq/exynos/Makefile
>>>  delete mode 100644 drivers/devfreq/exynos/exynos4_bus.c
>>>  delete mode 100644 drivers/devfreq/exynos/exynos4_bus.h
>>>  delete mode 100644 drivers/devfreq/exynos/exynos5_bus.c
>>>  delete mode 100644 drivers/devfreq/exynos/exynos_ppmu.c
>>>  delete mode 100644 drivers/devfreq/exynos/exynos_ppmu.h
>>>  create mode 100644 drivers/devfreq/governor_passive.c
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-sams=
ung-soc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
