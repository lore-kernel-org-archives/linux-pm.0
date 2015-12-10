From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 00/19] PM / devferq: Add generic exynos bus frequency
 driver and new passive governor
Date: Thu, 10 Dec 2015 09:12:50 +0900
Message-ID: <5668C382.9030101@samsung.com>
References: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
 <CANAwSgS17rJW+ey3aFmR=uf54w9mjfW-drZr3=cQwvg7p0C9Lg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CANAwSgS17rJW+ey3aFmR=uf54w9mjfW-drZr3=cQwvg7p0C9Lg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: myungjoo.ham@samsung.com, =?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?= <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Anand,

=46irst of all, thanks for trying to test this series.

On 2015=EB=85=84 12=EC=9B=94 10=EC=9D=BC 04:05, Anand Moon wrote:
> Hi Chanwoo Choi,
>=20
> On 9 December 2015 at 09:37, Chanwoo Choi <cw00.choi@samsung.com> wro=
te:
>> This patch-set includes the two features as following. The generic e=
xynos bus
>> frequency driver is able to support almost Exynos SoCs for bus frequ=
ency
>> scaling. And the new passive governor is able to make the dependency=
 on
>> between devices for frequency/voltage scaling. I had posted the patc=
h-set[1]
>> with the similiar concept. This is is revised version for exynos bus=
 frequency.
>> - Generic exynos bus frequency driver
>> - New passive governor of DEVFREQ framework
>>
>> Depends on:
>> - This patch-set is based on devfreq.git[2].
>> [1] https://lkml.org/lkml/2015/1/7/872
>>    : [PATCHv3 0/8] devfreq: Add generic exynos memory-bus frequency =
driver
>> [2] https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git/ (b=
ranch: for-rafael)
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
>>         bus_dmc: bus_dmc {
>>                 compatible =3D "samsung,exynos-bus";
>>                 clocks =3D <&cmu_dmc CLK_DIV_DMC>;
>>                 clock-names =3D "bus";
>>                 operating-points-v2 =3D <&bus_dmc_opp_table>;
>>                 status =3D "disabled";
>>         };
>>
>>         bus_dmc_opp_table: opp_table0 {
>>                 compatible =3D "operating-points-v2";
>>                 opp-shared;
>>
>>                 opp00 {
>>                         opp-hz =3D /bits/ 64 <50000000>;
>>                         opp-microvolt =3D <800000>;
>>                 };
>>                 opp01 {
>>                         opp-hz =3D /bits/ 64 <100000000>;
>>                         opp-microvolt =3D <800000>;
>>                 };
>>                 opp02 {
>>                         opp-hz =3D /bits/ 64 <134000000>;
>>                         opp-microvolt =3D <800000>;
>>                 };
>>                 opp03 {
>>                         opp-hz =3D /bits/ 64 <200000000>;
>>                         opp-microvolt =3D <800000>;
>>                 };
>>                 opp04 {
>>                         opp-hz =3D /bits/ 64 <400000000>;
>>                         opp-microvolt =3D <875000>;
>>                 };
>>         };
>>
>> - Usage case to handle the frequency and voltage of bus on runtime
>>   in exynos3250-rinato.dts are listed below:
>>
>>         &bus_dmc {
>>                 devfreq-events =3D <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
>>                 vdd-supply =3D <&buck1_reg>;      /* VDD_MIF */
>>                 status =3D "okay";
>>         };
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
>>         : VDD_INT |--- LEFTBUS
>>                   |--- PERIL
>>                   |--- MFC
>>                   |--- G3D
>>                   |--- RIGHTBUS
>>                   |--- FSYS
>>                   |--- LCD0
>>                   |--- PERIR
>>                   |--- ISP
>>                   |--- CAM
>>
>> - The buss of INT block in exynos3250.dtsi are listed below:
>>         bus_leftbus: bus_leftbus {
>>                 compatible =3D "samsung,exynos-bus";
>>                 clocks =3D <&cmu CLK_DIV_GDL>;
>>                 clock-names =3D "bus";
>>                 operating-points-v2 =3D <&bus_leftbus_opp_table>;
>>                 status =3D "disabled";
>>         };
>>
>>         bus_rightbus: bus_rightbus {
>>                 compatible =3D "samsung,exynos-bus";
>>                 clocks =3D <&cmu CLK_DIV_GDR>;
>>                 clock-names =3D "bus";
>>                 operating-points-v2 =3D <&bus_leftbus_opp_table>;
>>                 status =3D "disabled";
>>         };
>>
>>         (Omit the rest bus dt node)
>>
>> - Usage case to handle the frequency and voltage of bus on runtime
>>   in exynos3250-rinato.dts are listed below:
>>         /* Parent bus device of VDD_INT */
>>         &bus_leftbus {
>>                 devfreq-events =3D <&ppmu_leftbus_3>, <&ppmu_rightbu=
s_3>;
>>                 vdd-supply =3D <&buck3_reg>;
>>                 status =3D "okay";
>>         };
>>
>>         /* Passive bus device depend on LEFTBUS bus. */
>>         &bus_rightbus {
>>                 devfreq =3D <&bus_leftbus>; /* 'devfreq' property in=
dicates
>>                                              the phandle of parent d=
evice. */
>>                 status =3D "okay";
>>         };
>>
>>         (Omit the rest bus dt node)
>>
>> Chanwoo Choi (19):
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
>>   ARM: dts: Add bus nodes using VDD_INT for Exynos3250
>>   ARM: dts: Add bus nodes using VDD_MIF for Exynos4x12
>>   ARM: dts: Add bus nodes using VDD_INT for Exynos4x12
>>   ARM: dts: Add bus nodes using VDD_MIF for Exynos4210
>>   ARM: dts: Add PPMU node for exynos4412-odroidu3
>>   ARM: dts: Add support of bus frequency using VDD_INT for exynos325=
0-rinato
>>   ARM: dts: Expand the voltage range of buck1/3 regulator for exynos=
4412-odroidu3
>>   ARM: dts: Add support of bus frequency for exynos4412-trats/odroid=
u3
>>
>>  .../devicetree/bindings/devfreq/exynos-bus.txt     |  383 +++++++
>>  arch/arm/boot/dts/exynos3250-monk.dts              |    6 +
>>  arch/arm/boot/dts/exynos3250-rinato.dts            |   47 +
>>  arch/arm/boot/dts/exynos3250.dtsi                  |  194 ++++
>>  arch/arm/boot/dts/exynos4210.dtsi                  |  172 ++++
>>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   93 +-
>>  arch/arm/boot/dts/exynos4412-trats2.dts            |   47 +
>>  arch/arm/boot/dts/exynos4x12.dtsi                  |  184 ++++
>>  drivers/devfreq/Kconfig                            |   37 +-
>>  drivers/devfreq/Makefile                           |    2 +
>>  drivers/devfreq/devfreq.c                          |  120 ++-
>>  drivers/devfreq/exynos/Makefile                    |    3 +-
>>  drivers/devfreq/exynos/exynos-bus.c                |  549 +++++++++=
+
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
>>  include/linux/devfreq.h                            |   28 +
>>  25 files changed, 1958 insertions(+), 1828 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/devfreq/exynos=
-bus.txt
>>  create mode 100644 drivers/devfreq/exynos/exynos-bus.c
>>  delete mode 100644 drivers/devfreq/exynos/exynos4_bus.c
>>  delete mode 100644 drivers/devfreq/exynos/exynos4_bus.h
>>  delete mode 100644 drivers/devfreq/exynos/exynos5_bus.c
>>  delete mode 100644 drivers/devfreq/exynos/exynos_ppmu.c
>>  delete mode 100644 drivers/devfreq/exynos/exynos_ppmu.h
>>  create mode 100644 drivers/devfreq/governor_passive.c
>>
>> --
>> 1.9.1
>>
>=20
> I could not get this series to work with my Odroid U3.
>=20
> [    4.602768] input: gpio_keys as /devices/platform/gpio_keys/input/=
input0
> [    4.605527] devfreq bus_leftbus: Couldn't update frequency
> transition information.
> [    4.607319] devfreq bus_dmc: Couldn't update frequency transition
> information.
> [    4.625096] usb 1-3: New USB device found, idVendor=3D0424, idProd=
uct=3D3503

This log indicates the problem of 'trats_stat' sysfs entry of devfreq f=
ramework
during kernel booting. But, this log don't affect the behavior of bus f=
requency
on Odroid-U3.

After completing kernel and platform booting, you can check the operati=
on
of Bus frequency with follwoing sysfs entry:

root@localhost:~# ls -al /sys/class/devfreq
total 0
drwxr-xr-x  2 root root 0 Dec 31 17:00 .
drwxr-xr-x 44 root root 0 Dec 31 17:00 ..
lrwxrwxrwx  1 root root 0 Dec 31 17:00 bus_acp -> ../../devices/platfor=
m/bus_acp/devfreq/bus_acp
lrwxrwxrwx  1 root root 0 Dec 31 17:00 bus_c2c -> ../../devices/platfor=
m/bus_c2c/devfreq/bus_c2c
lrwxrwxrwx  1 root root 0 Dec 31 17:00 bus_display -> ../../devices/pla=
tform/bus_display/devfreq/bus_display
lrwxrwxrwx  1 root root 0 Dec 31 17:00 bus_dmc -> ../../devices/platfor=
m/bus_dmc/devfreq/bus_dmc
lrwxrwxrwx  1 root root 0 Dec 31 17:00 bus_fsys -> ../../devices/platfo=
rm/bus_fsys/devfreq/bus_fsys
lrwxrwxrwx  1 root root 0 Dec 31 17:00 bus_leftbus -> ../../devices/pla=
tform/bus_leftbus/devfreq/bus_leftbus
lrwxrwxrwx  1 root root 0 Dec 31 17:00 bus_mfc -> ../../devices/platfor=
m/bus_mfc/devfreq/bus_mfc
lrwxrwxrwx  1 root root 0 Dec 31 17:00 bus_peri -> ../../devices/platfo=
rm/bus_peri/devfreq/bus_peri
lrwxrwxrwx  1 root root 0 Dec 31 17:00 bus_rightbus -> ../../devices/pl=
atform/bus_rightbus/devfreq/bus_rightbus

root@localhost:~# cat /sys/class/devfreq/bus_leftbus/trans_stat=20
     From  :   To
           : 100000000 134000000 160000000 200000000   time(ms)
  100000000:         0         0         0        24      2020
  134000000:         0         0         0        10      1190
  160000000:         0         0         0         0         0
* 200000000:        24        10         0         0    118160
Total transition : 68

Also, when changing the frequency of each bus, exynos-bus.c show
the debug message. If you need more detailed information,
you could check this log message.

Regards,
Chanwoo Choi
