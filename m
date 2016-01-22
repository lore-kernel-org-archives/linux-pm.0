From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: Re: [PATCH v4 00/20] PM / devferq: Add generic exynos bus frequency
 driver and new passive governor
Date: Fri, 22 Jan 2016 12:01:30 +0100
Message-ID: <56A20C0A.8000107@math.uni-bielefeld.de>
References: <1450075104-13705-1-git-send-email-cw00.choi@samsung.com>
 <569DFE52.107@math.uni-bielefeld.de> <569EDE4F.6020702@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000202010808090108010705"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.math.uni-bielefeld.de ([129.70.45.10]:50122 "EHLO
	smtp.math.uni-bielefeld.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753223AbcAVLBl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2016 06:01:41 -0500
In-Reply-To: <569EDE4F.6020702@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, myungjoo.ham@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org

This is a multi-part message in MIME format.
--------------000202010808090108010705
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey Chanwoo,


Chanwoo Choi wrote:
> Hi Tobias,
> 
> On 2016년 01월 19일 18:13, Tobias Jakobi wrote:
> Hello,
> 
> I've tested this on my Odroid-X2 but ran into issues. Patch 08/20
> introduces some pr_info() to exynos_bus_probe().
> 
> In my case both max_state and freq_table are zero though, so getting
> {min,max}_freq triggers an kernel oops. If I just remove the code the
> drivers probes correctly.
> 
>> Thanks for your test. If you ok, could you give me a kernel oops message?
>> It is helpful to remove the corner case of this driver.
sure, I've sttached the kernel oops.

- Tobias


>> Best Regards,
>> Chanwoo Choi
> 
> 
> 
> 
> Chanwoo Choi wrote:
>>>> This patch-set includes the two features as following. The generic
>>>> exynos bus frequency driver is able to support almost Exynos SoCs
>>>> for bus frequency scaling. And the new passive governor is able to
>>>> make the dependency on between devices for frequency/voltage
>>>> scaling. I had posted the patch-set[2] with the similiar concept.
>>>> This is is revised version for exynos bus frequency. - Generic
>>>> exynos bus frequency driver - New passive governor of DEVFREQ
>>>> framework
>>>>
>>>> Depend on: - next-20151210 tag of linux-next (master branch). -
>>>> Merge the latest devfreq patches on devfreq.git[2] (for-rafael
>>>> branch). [1]
>>>> https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git/
>>>> (branch: for-rafael) [2] https://lkml.org/lkml/2015/1/7/872 :
>>>> [PATCHv3 0/8] devfreq: Add generic exynos memory-bus frequency
>>>> driver
>>>>
>>>> Changes from v3: (https://lkml.org/lkml/2015/12/11/75) - Add the
>>>> reviewed-by tag from Krzysztof Kozlowski (patch2/3/13/14/15/16/17) 
>>>> - Fix typo of the description on patch14 - Modify the subject and
>>>> description of patch17 - Reorder the 'bus_xxx' device tree node
>>>> alphabetically in both exynos3250-rinato/monk.dts and
>>>> exynos4412-trats/odroidu3
>>>>
>>>> Changes from v2: (https://lkml.org/lkml/2015/12/8/869) - Fix typo
>>>> on documentation - Modify the more appropriate sentence on patch
>>>> description - Add the detailed description about both parent and
>>>> passive bus device - Modify the DMC frequency for Exynos4x12 DMC
>>>> bus (200MHz -> 267MHz) - Modify the voltage of 200MHz was included
>>>> in Exynos3250 DMC bus (800mV -> 825mV) - Rename OPP nodes as
>>>> 'opp@<opp-hz>' - Delete the duplicate 'opp-microvolt' property of
>>>> passive devfreq device - Reorder the 'bus_xxx' device tree node
>>>> alphabetically in exynos3250-rinato/monk.dts - Reorder the
>>>> 'bus_xxx' device tree node alphabetically in
>>>> exynos4412-trats/odroidu3 - Add new exynos4412-ppmu-common.dtsi to
>>>> remove the duplicate PPMU dt node on rinato/monk/trats2/odroid-u3
>>>> board - Add the log message if bus device is registered to devfreq
>>>> framework successfully - Add the reviewed-by tag from Krzysztof
>>>> Kozlowski - Add the tested-by tag from Anand Moon on Odroid U3 -
>>>> Add 'SAMSUNG BUS FREQUENCY DRIVER' entry to MAINTAINERS
>>>>
>>>> Changes from v1: (https://lkml.org/lkml/2015/11/26/260) - Check
>>>> whether the instance of regulator is NULL or not when executing
>>>> regulator_disable() because of only parent devfreq device has the
>>>> regulator instance. After fixing it, the wake-up from suspend state
>>>> is well working. (patch1) - Fix bug which checks 'bus-clk' instead
>>>> of 'bus->regulator' after calling devm_clk_get() (on patch1) -
>>>> Update the documentation to remove the description about 
>>>> DEVFREQ-EVENT subsystem (on patch2) - Add the full name of DMC
>>>> (Dynamic Memory Controller) (on patch2) - Modify the detailed
>>>> correlation of buses for Exynos3250 on documentation (patch2) - Add
>>>> the MFC bus node for Exynos3250 (on patch11, patch12) - Fix the
>>>> duplicate frequency of bus_display on Exynos4x12.dtsi - Add the
>>>> PPMU node for exynos4412-odroidu3 - Add the support of bus
>>>> frequency for exynos4412-odroidu3
>>>>
>>>> Detailed descirption for patch-set: 1. Add generic exynos bus
>>>> frequency driver : This patch-set adds the generic exynos bus
>>>> frequency driver for AXI bus of sub-blocks in exynos SoC. The
>>>> Samsung Exynos SoC have the common architecture for bus between
>>>> DRAM and sub-blocks in SoC.
>>>>
>>>> There are the different buses according to Exynos SoC because
>>>> Exynos SoC has the differnt sub-blocks and bus speed. In spite of
>>>> this difference among Exynos SoCs, this driver is able to support
>>>> almost Exynos SoC by adding unique data of each bus in the
>>>> devicetree file.
>>>>
>>>> In devicetree, each bus node has a bus clock, regulator,
>>>> operation-point and devfreq-event devices which measure the
>>>> utilization of each bus block.
>>>>
>>>> For example, - The bus of DMC block in exynos3250.dtsi are listed
>>>> below:
>>>>
>>>> bus_dmc: bus_dmc { compatible = "samsung,exynos-bus"; clocks =
>>>> <&cmu_dmc CLK_DIV_DMC>; clock-names = "bus"; operating-points-v2 =
>>>> <&bus_dmc_opp_table>; status = "disabled"; };
>>>>
>>>> bus_dmc_opp_table: opp_table1 { compatible =
>>>> "operating-points-v2"; opp-shared;
>>>>
>>>> opp@50000000 { opp-hz = /bits/ 64 <50000000>; opp-microvolt =
>>>> <800000>; }; opp@100000000 { opp-hz = /bits/ 64 <100000000>; 
>>>> opp-microvolt = <800000>; }; opp@134000000 { opp-hz = /bits/ 64
>>>> <134000000>; opp-microvolt = <800000>; }; opp@200000000 { opp-hz =
>>>> /bits/ 64 <200000000>; opp-microvolt = <825000>; }; opp@400000000
>>>> { opp-hz = /bits/ 64 <400000000>; opp-microvolt = <875000>; }; };
>>>>
>>>> - Usage case to handle the frequency and voltage of bus on runtime 
>>>> in exynos3250-rinato.dts are listed below:
>>>>
>>>> &bus_dmc { devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>; 
>>>> vdd-supply = <&buck1_reg>;	/* VDD_MIF */ status = "okay"; };
>>>>
>>>> 2. Add new passive governor of DEVFREQ framework (patch5-patch7) :
>>>> This patch-set add the new passive governor for DEVFREQ framework. 
>>>> The existing governors (ondemand, performance and so on) are used
>>>> for DVFS (Dynamic Voltage and Frequency Scaling) drivers. The
>>>> existing governors are independently used for specific device
>>>> driver which don't give the influence to other device drviers and
>>>> also don't receive the effect from other device drivers.
>>>>
>>>> The passive governor depends on operation of parent driver with
>>>> existing governors(ondemand, performance and so on) extremely and
>>>> is not able to decide the new frequency by oneself. According to
>>>> the decided new frequency of parent driver with governor, the
>>>> passive governor uses it to decide the appropriate frequency for
>>>> own device driver. The passive governor must need the following
>>>> information from device tree:
>>>>
>>>> For exameple, There are one more bus device drivers in Exynos3250
>>>> which need to change their source clock according to their
>>>> utilization on runtime. But, they share the same power line (e.g.,
>>>> regulator). So, LEFTBUS bus driver is operated as parent with
>>>> ondemand governor and then the rest device driver with passive
>>>> governor.
>>>>
>>>> The buses of Internal block in exynos3250.dtsi are listed below: 
>>>> When LEFTBUS bus driver (parent) changes the bus frequency with 
>>>> ondemand governor on runtime, the rest bus devices which sharing 
>>>> the same power line (VDD_INT) will change the each bus frequency 
>>>> according to the decision of LEFTBUS bus driver (parent).
>>>>
>>>> - INT (Internal) block : VDD_INT |--- LEFTBUS |--- PERIL |--- MFC 
>>>> |--- G3D |--- RIGHTBUS |--- FSYS |--- LCD0 |--- PERIR |--- ISP |---
>>>> CAM
>>>>
>>>> - The buss of INT block in exynos3250.dtsi are listed below: 
>>>> bus_leftbus: bus_leftbus { compatible = "samsung,exynos-bus"; 
>>>> clocks = <&cmu CLK_DIV_GDL>; clock-names = "bus"; 
>>>> operating-points-v2 = <&bus_leftbus_opp_table>; status =
>>>> "disabled"; };
>>>>
>>>> bus_rightbus: bus_rightbus { compatible = "samsung,exynos-bus"; 
>>>> clocks = <&cmu CLK_DIV_GDR>; clock-names = "bus"; 
>>>> operating-points-v2 = <&bus_leftbus_opp_table>; status =
>>>> "disabled"; };
>>>>
>>>> (Omit the rest bus dt node)
>>>>
>>>> - Usage case to handle the frequency and voltage of bus on runtime 
>>>> in exynos3250-rinato.dts are listed below: /* Parent bus device of
>>>> VDD_INT */ &bus_leftbus { devfreq-events = <&ppmu_leftbus_3>,
>>>> <&ppmu_rightbus_3>; vdd-supply = <&buck3_reg>; status = "okay"; };
>>>>
>>>> /* Passive bus device depend on LEFTBUS bus. */ &bus_rightbus { 
>>>> devfreq = <&bus_leftbus>; /* 'devfreq' property indicates the
>>>> phandle of parent device. */ status = "okay"; };
>>>>
>>>> (Omit the rest bus dt node)
>>>>
>>>> Chanwoo Choi (20): PM / devfreq: exynos: Add generic exynos bus
>>>> frequency driver PM / devfreq: exynos: Add documentation for
>>>> generic exynos bus frequency driver ARM: dts: Add DMC bus node for
>>>> Exynos3250 ARM: dts: Add DMC bus frequency for
>>>> exynos3250-rinato/monk PM / devfreq: Add new passive governor PM /
>>>> devfreq: Add devfreq_get_devfreq_by_phandle() PM / devfreq: Show
>>>> the related information according to governor type PM / devfreq:
>>>> exynos: Add support of bus frequency of sub-blocks using passive
>>>> governor PM / devfreq: exynos: Update documentation for bus devices
>>>> using passive governor PM / devfreq: exynos: Add the detailed
>>>> correlation between sub-blocks and power line PM / devfreq: exynos:
>>>> Remove unused exynos4/5 busfreq driver MAINTAINERS: Add samsung bus
>>>> frequency driver entry ARM: dts: Add bus nodes using VDD_INT for
>>>> Exynos3250 ARM: dts: Add bus nodes using VDD_MIF for Exynos4x12 
>>>> ARM: dts: Add bus nodes using VDD_INT for Exynos4x12 ARM: dts: Add
>>>> bus nodes using VDD_MIF for Exynos4210 ARM: dts: Add
>>>> exynos4412-ppmu-common dtsi to delete duplicate PPMU nodes ARM:
>>>> dts: Add support of bus frequency using VDD_INT for
>>>> exynos3250-rinato ARM: dts: Expand the voltage range of buck1/3
>>>> regulator for exynos4412-odroidu3 ARM: dts: Add support of bus
>>>> frequency for exynos4412-trats/odroidu3
>>>>
>>>> .../devicetree/bindings/devfreq/exynos-bus.txt     |  388 +++++++ 
>>>> MAINTAINERS                                        |    9 + 
>>>> arch/arm/boot/dts/exynos3250-monk.dts              |   47 +- 
>>>> arch/arm/boot/dts/exynos3250-rinato.dts            |   88 +- 
>>>> arch/arm/boot/dts/exynos3250.dtsi                  |  181 ++++ 
>>>> arch/arm/boot/dts/exynos4210.dtsi                  |  159 +++ 
>>>> arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   54 +- 
>>>> arch/arm/boot/dts/exynos4412-ppmu-common.dtsi      |   50 + 
>>>> arch/arm/boot/dts/exynos4412-trats2.dts            |   88 +- 
>>>> arch/arm/boot/dts/exynos4x12.dtsi                  |  174 ++++ 
>>>> drivers/devfreq/Kconfig                            |   37 +- 
>>>> drivers/devfreq/Makefile                           |    2 + 
>>>> drivers/devfreq/devfreq.c                          |  120 ++- 
>>>> drivers/devfreq/exynos/Makefile                    |    3 +- 
>>>> drivers/devfreq/exynos/exynos-bus.c                |  556
>>>> +++++++++++ drivers/devfreq/exynos/exynos4_bus.c               |
>>>> 1055 -------------------- drivers/devfreq/exynos/exynos4_bus.h
>>>> |  110 -- drivers/devfreq/exynos/exynos5_bus.c               |  431
>>>> -------- drivers/devfreq/exynos/exynos_ppmu.c               |  119
>>>> --- drivers/devfreq/exynos/exynos_ppmu.h               |   86 -- 
>>>> drivers/devfreq/governor.h                         |    7 + 
>>>> drivers/devfreq/governor_passive.c                 |  109 ++ 
>>>> drivers/devfreq/governor_performance.c             |    1 + 
>>>> drivers/devfreq/governor_powersave.c               |    1 + 
>>>> drivers/devfreq/governor_simpleondemand.c          |    1 + 
>>>> drivers/devfreq/governor_userspace.c               |    1 + 
>>>> include/linux/devfreq.h                            |   26 + 27
>>>> files changed, 1955 insertions(+), 1948 deletions(-) create mode
>>>> 100644 Documentation/devicetree/bindings/devfreq/exynos-bus.txt 
>>>> create mode 100644 arch/arm/boot/dts/exynos4412-ppmu-common.dtsi 
>>>> create mode 100644 drivers/devfreq/exynos/exynos-bus.c delete mode
>>>> 100644 drivers/devfreq/exynos/exynos4_bus.c delete mode 100644
>>>> drivers/devfreq/exynos/exynos4_bus.h delete mode 100644
>>>> drivers/devfreq/exynos/exynos5_bus.c delete mode 100644
>>>> drivers/devfreq/exynos/exynos_ppmu.c delete mode 100644
>>>> drivers/devfreq/exynos/exynos_ppmu.h create mode 100644
>>>> drivers/devfreq/governor_passive.c
>>>>
> 
>>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


--------------000202010808090108010705
Content-Type: text/plain; charset=UTF-8;
 name="oops.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="oops.txt"

WyAgICAzLjk3NjkwNl0gczNjLXJ0YyAxMDA3MDAwMC5ydGM6IHMzYzI0MTBfcnRjOiB0aWNr
IGlycSA2NSwgYWxhcm0gaXJxIDY0ClsgICAgMy45ODI2NjNdIHMzYy1ydGMgMTAwNzAwMDAu
cnRjOiBzM2MyNDEwX3J0YzogUlRDQ09OPTAxClsgICAgMy45ODc3MDRdIHMzYy1ydGMgMTAw
NzAwMDAucnRjOiByZWFkIHRpbWUgMjAxNS4wNC4wOCAxNjoyOToyNQpbICAgIDMuOTkzNTcx
XSBzM2MtcnRjIDEwMDcwMDAwLnJ0YzogcmVhZCB0aW1lIDIwMTUuMDQuMDggMTY6Mjk6MjUK
WyAgICAzLjk5OTQ1Nl0gczNjLXJ0YyAxMDA3MDAwMC5ydGM6IHJlYWQgYWxhcm0gMCwgMTkw
MC4wMC4wMCAwMDowMDowMApbICAgIDQuMDA1NzA4XSBzM2MtcnRjIDEwMDcwMDAwLnJ0Yzog
cmVhZCB0aW1lIDIwMTUuMDQuMDggMTY6Mjk6MjUKWyAgICA0LjAxMTYwNF0gcnRjIHJ0YzE6
IGFsYXJtIHJvbGxvdmVyOiBkYXkKWyAgICA0LjAxNTU5OV0gczNjLXJ0YyAxMDA3MDAwMC5y
dGM6IHJlYWQgdGltZSAyMDE1LjA0LjA4IDE2OjI5OjI1ClsgICAgNC4wMjE3MzRdIHJ0YyBy
dGMxOiBzM2M6IGRldiAoMjU0OjEpClsgICAgNC4wMjQzNzFdIG1tYzA6IG5ldyBoaWdoIHNw
ZWVkIFNEWEMgY2FyZCBhdCBhZGRyZXNzIGFhYWEKWyAgICA0LjAyNDg1Nl0gbW1jYmxrMDog
bW1jMDphYWFhIFNFNjRHIDU5LjQgR2lCIApbICAgIDQuMDI1OTU5XSAgbW1jYmxrMDogcDEg
cDIgcDMKWyAgICA0LjAzODE1Nl0gczNjLXJ0YyAxMDA3MDAwMC5ydGM6IHJ0YyBjb3JlOiBy
ZWdpc3RlcmVkIHMzYyBhcyBydGMxClsgICAgNC4wNDQ3MDRdIGV4eW5vcy1idXMgYnVzX2Rt
YzogTG9va2luZyB1cCB2ZGQtc3VwcGx5IGZyb20gZGV2aWNlIHRyZWUKWyAgICA0LjA1MTMy
Ml0gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgcGFnaW5nIHJlcXVlc3QgYXQgdmlydHVhbCBh
ZGRyZXNzIGZmZmZmZmZjClsgICAgNC4wNTgwNDVdIHBnZCA9IGMwMDA0MDAwClsgICAgNC4w
NjA3MjRdIFtmZmZmZmZmY10gKnBnZD02ZmZmZDg2MSwgKnB0ZT0wMDAwMDAwMCwgKnBwdGU9
MDAwMDAwMDAKWyAgICA0LjA2Njk2MV0gSW50ZXJuYWwgZXJyb3I6IE9vcHM6IDM3IFsjMV0g
UFJFRU1QVCBTTVAgQVJNClsgICAgNC4wNzIzNDFdIE1vZHVsZXMgbGlua2VkIGluOgpbICAg
IDQuMDc1MzgxXSBDUFU6IDIgUElEOiAyOSBDb21tOiBrd29ya2VyL3U4OjEgTm90IHRhaW50
ZWQgNC40LjAtZGVidWcrICMyClsgICAgNC4wNzkwNjddIHVzYiAxLTIuMTogbmV3IGhpZ2gt
c3BlZWQgVVNCIGRldmljZSBudW1iZXIgMyB1c2luZyBleHlub3MtZWhjaQpbICAgIDQuMDg5
MDkzXSBIYXJkd2FyZSBuYW1lOiBTQU1TVU5HIEVYWU5PUyAoRmxhdHRlbmVkIERldmljZSBU
cmVlKQpbICAgIDQuMDk1MTc2XSBXb3JrcXVldWU6IGRlZmVyd3EgZGVmZXJyZWRfcHJvYmVf
d29ya19mdW5jClsgICAgNC4xMDAzNzddIHRhc2s6IGVlOWU4YmMwIHRpOiBlZWEwYzAwMCB0
YXNrLnRpOiBlZWEwYzAwMApbICAgIDQuMTA1NzYzXSBQQyBpcyBhdCBleHlub3NfYnVzX3By
b2JlKzB4MjIwLzB4NmM4ClsgICAgNC4xMTA0NTBdIExSIGlzIGF0IHRyYWNlX2hhcmRpcnFz
X29uKzB4MTQvMHgxOApbICAgIDQuMTE1MDQ3XSBwYyA6IFs8YzA0NThhNjg+XSAgICBsciA6
IFs8YzAwNzQ5ZGM+XSAgICBwc3I6IDYwMDAwMDUzClsgICAgNC4xMTUwNDddIHNwIDogZWVh
MGRkMzAgIGlwIDogZWVhMGRjYzAgIGZwIDogZWVhMGRkN2MKWyAgICA0LjEyNjUwNF0gcjEw
OiBlZWJmNmMxMCAgcjkgOiBlZWZjYzhjNCAgcjggOiBlZTk0NjRkMApbICAgIDQuMTMxNzEy
XSByNyA6IGVlYmY2YzAwICByNiA6IGVlYmY2YzEwICByNSA6IDAwMDAwMDAwICByNCA6IDEw
NjI0ZGQzClsgICAgNC4xMzgyMjJdIHIzIDogM2ZmZmZmZmYgIHIyIDogMDAwMDAwMDAgIHIx
IDogZWViYTg0ODAgIHIwIDogYzA3NjE0MWMKWyAgICA0LjE0NDczM10gRmxhZ3M6IG5aQ3Yg
IElSUXMgb24gIEZJUXMgb2ZmICBNb2RlIFNWQ18zMiAgSVNBIEFSTSAgU2VnbWVudCBub25l
ClsgICAgNC4xNTE5MzZdIENvbnRyb2w6IDEwYzUzODdkICBUYWJsZTogNDAwMDQwNGEgIERB
QzogMDAwMDAwNTEKWyAgICA0LjE1NzY2NV0gUHJvY2VzcyBrd29ya2VyL3U4OjEgKHBpZDog
MjksIHN0YWNrIGxpbWl0ID0gMHhlZWEwYzIxOCkKWyAgICA0LjE2NDAwMl0gU3RhY2s6ICgw
eGVlYTBkZDMwIHRvIDB4ZWVhMGUwMDApClsgICAgNC4xNjgzNDNdIGRkMjA6ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAwMDAwMDAwIDAwMDAwMDAwIGMwNDU4OGU0
IGMwMzM4NWM4ClsgICAgNC4xNzY1MDNdIGRkNDA6IDAwMDAwMDAyIGVlOTQ2MjUwIGMxMDIw
M2I0IDE3ZDc4NDAwIGMwODJlODIwIGZmZmZmZmZlIGVlYmY2YzEwIGMwODJlODIwClsgICAg
NC4xODQ0MjddIHVzYiAxLTIuMTogTmV3IFVTQiBkZXZpY2UgZm91bmQsIGlkVmVuZG9yPTA0
MjQsIGlkUHJvZHVjdD05NTE0ClsgICAgNC4xODQ0MzJdIHVzYiAxLTIuMTogTmV3IFVTQiBk
ZXZpY2Ugc3RyaW5nczogTWZyPTAsIFByb2R1Y3Q9MCwgU2VyaWFsTnVtYmVyPTAKWyAgICA0
LjE4NTEzMV0gaHViIDEtMi4xOjEuMDogVVNCIGh1YiBmb3VuZApbICAgIDQuMTg1Mjk3XSBo
dWIgMS0yLjE6MS4wOiA1IHBvcnRzIGRldGVjdGVkClsgICAgNC4yMDY4ODNdIGRkNjA6IGZm
ZmZmZGZiIDAwMDAwMDAzIGMwODNiMjU4IDAwMDAwMDAxIGVlYTBkZDljIGVlYTBkZDgwIGMw
MzNkYzc4IGMwNDU4ODU0ClsgICAgNC4yMTUwNDJdIGRkODA6IGMxMDIwM2I0IGVlYmY2YzEw
IDAwMDAwMDAwIGMwODJlODIwIGVlYTBkZGM0IGVlYTBkZGEwIGMwMzNiYWQ0IGMwMzNkYzJj
ClsgICAgNC4yMjMyMDFdIGRkYTA6IDAwMDAwMDAwIGMwODJlODIwIGVlYTBkZTEwIGVlYmY2
YzEwIDAwMDAwMDAxIGVlYTBkZWE4IGVlYTBkZGU0IGVlYTBkZGM4ClsgICAgNC4yMzEzNjBd
IGRkYzA6IGMwMzNiZDMwIGMwMzNiOGQwIGVlMmJiYTYwIDAwMDAwMDAwIGVlYTBkZTEwIGMw
MzNiY2E4IGVlYTBkZTBjIGVlYTBkZGU4ClsgICAgNC4yMzk1MjBdIGRkZTA6IGMwMzM5ZGNj
IGMwMzNiY2I0IGVlODAzNmQ0IGVlMmJiYTU0IGVlYmY2YzEwIGVlYmY2YzEwIGVlYmY2YzEw
IGVlYmY2YzQ0ClsgICAgNC4yNDc2NzldIGRlMDA6IGVlYTBkZTM0IGVlYTBkZTEwIGMwMzNi
ODIwIGMwMzM5ZDZjIGVlYmY2YzEwIDAwMDAwMDAxIGVlYmY2YzEwIGVlYmY2YzEwClsgICAg
NC4yNTU4MzhdIGRlMjA6IGMwODIzN2M4IGVlMjFhZTAwIGVlYTBkZTQ0IGVlYTBkZTM4IGMw
MzNiZThjIGMwMzNiNzdjIGVlYTBkZTY0IGVlYTBkZTQ4ClsgICAgNC4yNjM5OTddIGRlNDA6
IGMwMzNhZTc4IGMwMzNiZTg0IDAwMDAwMDAwIGVlYmY2YzEwIGMwODIzNDg4IGMwODIzNGNj
IGVlYTBkZTg0IGVlYTBkZTY4ClsgICAgNC4yNjkwNjFdIHVzYiAxLTIuMjogbmV3IGhpZ2gt
c3BlZWQgVVNCIGRldmljZSBudW1iZXIgNCB1c2luZyBleHlub3MtZWhjaQpbICAgIDQuMjc5
MTAxXSBkZTYwOiBjMDMzYjJjOCBjMDMzYWRmNCBjMDMzYjI1OCBjMDgyMzUwNCBlZTg2NzEw
MCBlZTgwYWMwMCBlZWEwZGVlNCBlZWEwZGU4OApbICAgIDQuMjg3MjYwXSBkZTgwOiBjMDA0
NTViYyBjMDMzYjI2NCAwMDAwMDAwMSAwMDAwMDAwMCBjMDA0NTRlMCBlZTgwYWMwMCBlZTgw
YWMwMCAwMDAwMDAwMApbICAgIDQuMjk1NDE5XSBkZWEwOiAwMDAwMDAwMCAwMDAwMDAwMCBj
MDgyMzUwNCAwMDAwMDAwMCAwMDAwMDAwMCBjMDcyZTFmNCBjMDViNjE1OCBlZTgwYWMwMApb
ICAgIDQuMzAzNTc4XSBkZWMwOiBlZTg2NzExOCBlZTgwYWMzMCAwMDAwMDA4OCBjMDA0NWJj
NCBlZTgwYWMwMCBlZTg2NzEwMCBlZWEwZGYyNCBlZWEwZGVlOApbICAgIDQuMzExNzM3XSBk
ZWUwOiBjMDA0NWI0YyBjMDA0NTNiYyBlZThmZTA0MCBlZTgwYWRhMCBjMDdmODEwMCBjMDgz
YTc5NiAwMDAwMDAwMCAwMDAwMDAwMApbICAgIDQuMzE5ODk2XSBkZjAwOiBlZThmZTA0MCBl
ZTg2NzEwMCBjMDA0NWFmYyAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCBlZWEwZGZhYyBl
ZWEwZGYyOApbICAgIDQuMzI4MDU2XSBkZjIwOiBjMDA0YzNhYyBjMDA0NWIwOCAwMDAwMDAw
MCBlZWEwZGYzOCBlZTg2NzEwMCAwMDAwMDAwMCAwMDAwMDAwMCBkZWFkNGVhZApbICAgIDQu
MzM2MjE1XSBkZjQwOiBmZmZmZmZmZiBmZmZmZmZmZiBjMDg0MTA0MCAwMDAwMDAwMCAwMDAw
MDAwMCBjMDZmM2MyMCBlZWEwZGY1OCBlZWEwZGY1OApbICAgIDQuMzQ0Mzc0XSBkZjYwOiAw
MDAwMDAwMCAwMDAwMDAwMCBkZWFkNGVhZCBmZmZmZmZmZiBmZmZmZmZmZiBjMDg0MTA0MCAw
MDAwMDAwMCAwMDAwMDAwMApbICAgIDQuMzUyNTMzXSBkZjgwOiBjMDZmM2MyMCBlZWEwZGY4
NCBlZWEwZGY4NCBkYzhiYTYwMCBlZThmZTA0MCBjMDA0YzJhNCAwMDAwMDAwMCAwMDAwMDAw
MApbICAgIDQuMzYwNjkyXSBkZmEwOiAwMDAwMDAwMCBlZWEwZGZiMCBjMDAwZmViMCBjMDA0
YzJiMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMApbICAgIDQuMzY4ODUx
XSBkZmMwOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAw
MDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMApbICAgIDQuMzc3MDExXSBkZmUwOiAwMDAwMDAw
MCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAxMyAwMDAwMDAwMCBlZWEwZGZm
NCAwMDAwMDAwMApbICAgIDQuMzc5NjY0XSB1c2IgMS0yLjI6IE5ldyBVU0IgZGV2aWNlIGZv
dW5kLCBpZFZlbmRvcj04NTY0LCBpZFByb2R1Y3Q9MTAwMApbICAgIDQuMzc5NjY5XSB1c2Ig
MS0yLjI6IE5ldyBVU0IgZGV2aWNlIHN0cmluZ3M6IE1mcj0xLCBQcm9kdWN0PTIsIFNlcmlh
bE51bWJlcj0zClsgICAgNC4zNzk2NzJdIHVzYiAxLTIuMjogUHJvZHVjdDogTWFzcyBTdG9y
YWdlIERldmljZQpbICAgIDQuMzc5Njc2XSB1c2IgMS0yLjI6IE1hbnVmYWN0dXJlcjogSmV0
Rmxhc2gKWyAgICA0LjM3OTY3OV0gdXNiIDEtMi4yOiBTZXJpYWxOdW1iZXI6IDA1OUZLSTNP
TU5IMjRGVjQKWyAgICA0LjQxMzU1MF0gQmFja3RyYWNlOiAKWyAgICA0LjQxNTk5MF0gWzxj
MDQ1ODg0OD5dIChleHlub3NfYnVzX3Byb2JlKSBmcm9tIFs8YzAzM2RjNzg+XSAocGxhdGZv
cm1fZHJ2X3Byb2JlKzB4NTgvMHhiNCkKWyAgICA0LjQyNDQwMV0gIHIxMDowMDAwMDAwMSBy
OTpjMDgzYjI1OCByODowMDAwMDAwMyByNzpmZmZmZmRmYiByNjpjMDgyZTgyMCByNTplZWJm
NmMxMApbICAgIDQuNDMyMjEyXSAgcjQ6ZmZmZmZmZmUKWyAgICA0LjQzNDczNV0gWzxjMDMz
ZGMyMD5dIChwbGF0Zm9ybV9kcnZfcHJvYmUpIGZyb20gWzxjMDMzYmFkND5dIChkcml2ZXJf
cHJvYmVfZGV2aWNlKzB4MjEwLzB4MzA0KQpbICAgIDQuNDQzNTgzXSAgcjc6YzA4MmU4MjAg
cjY6MDAwMDAwMDAgcjU6ZWViZjZjMTAgcjQ6YzEwMjAzYjQKWyAgICA0LjQ0OTIyOV0gWzxj
MDMzYjhjND5dIChkcml2ZXJfcHJvYmVfZGV2aWNlKSBmcm9tIFs8YzAzM2JkMzA+XSAoX19k
ZXZpY2VfYXR0YWNoX2RyaXZlcisweDg4LzB4OTQpClsgICAgNC40NTgyNTNdICByODplZWEw
ZGVhOCByNzowMDAwMDAwMSByNjplZWJmNmMxMCByNTplZWEwZGUxMCByNDpjMDgyZTgyMCBy
MzowMDAwMDAwMApbICAgIDQuNDY1OTgyXSBbPGMwMzNiY2E4Pl0gKF9fZGV2aWNlX2F0dGFj
aF9kcml2ZXIpIGZyb20gWzxjMDMzOWRjYz5dIChidXNfZm9yX2VhY2hfZHJ2KzB4NmMvMHhh
MCkKWyAgICA0LjQ2OTA2MF0gdXNiIDEtMi4xLjE6IG5ldyBoaWdoLXNwZWVkIFVTQiBkZXZp
Y2UgbnVtYmVyIDUgdXNpbmcgZXh5bm9zLWVoY2kKWyAgICA0LjQ4MTg2Ml0gIHI2OmMwMzNi
Y2E4IHI1OmVlYTBkZTEwIHI0OjAwMDAwMDAwIHIzOmVlMmJiYTYwClsgICAgNC40ODc1MDdd
IFs8YzAzMzlkNjA+XSAoYnVzX2Zvcl9lYWNoX2RydikgZnJvbSBbPGMwMzNiODIwPl0gKF9f
ZGV2aWNlX2F0dGFjaCsweGIwLzB4MTEwKQpbICAgIDQuNDk1NzUwXSAgcjY6ZWViZjZjNDQg
cjU6ZWViZjZjMTAgcjQ6ZWViZjZjMTAKWyAgICA0LjUwMDM1M10gWzxjMDMzYjc3MD5dIChf
X2RldmljZV9hdHRhY2gpIGZyb20gWzxjMDMzYmU4Yz5dIChkZXZpY2VfaW5pdGlhbF9wcm9i
ZSsweDE0LzB4MTgpClsgICAgNC41MDg4NTddICByNzplZTIxYWUwMCByNjpjMDgyMzdjOCBy
NTplZWJmNmMxMCByNDplZWJmNmMxMApbICAgIDQuNTE0NTAyXSBbPGMwMzNiZTc4Pl0gKGRl
dmljZV9pbml0aWFsX3Byb2JlKSBmcm9tIFs8YzAzM2FlNzg+XSAoYnVzX3Byb2JlX2Rldmlj
ZSsweDkwLzB4OTgpClsgICAgNC41MjMwOTVdIFs8YzAzM2FkZTg+XSAoYnVzX3Byb2JlX2Rl
dmljZSkgZnJvbSBbPGMwMzNiMmM4Pl0gKGRlZmVycmVkX3Byb2JlX3dvcmtfZnVuYysweDcw
LzB4YTQpClsgICAgNC41MzIwMzNdICByNjpjMDgyMzRjYyByNTpjMDgyMzQ4OCByNDplZWJm
NmMxMCByMzowMDAwMDAwMApbICAgIDQuNTM3NjgwXSBbPGMwMzNiMjU4Pl0gKGRlZmVycmVk
X3Byb2JlX3dvcmtfZnVuYykgZnJvbSBbPGMwMDQ1NWJjPl0gKHByb2Nlc3Nfb25lX3dvcmsr
MHgyMGMvMHg3NGMpClsgICAgNC41NDY3ODldICByNjplZTgwYWMwMCByNTplZTg2NzEwMCBy
NDpjMDgyMzUwNCByMzpjMDMzYjI1OApbICAgIDQuNTUyNDMzXSBbPGMwMDQ1M2IwPl0gKHBy
b2Nlc3Nfb25lX3dvcmspIGZyb20gWzxjMDA0NWI0Yz5dICh3b3JrZXJfdGhyZWFkKzB4NTAv
MHg0ZjApClsgICAgNC41NjA1MDNdICByMTA6ZWU4NjcxMDAgcjk6ZWU4MGFjMDAgcjg6YzAw
NDViYzQgcjc6MDAwMDAwODggcjY6ZWU4MGFjMzAgcjU6ZWU4NjcxMTgKWyAgICA0LjU2ODMx
NV0gIHI0OmVlODBhYzAwClsgICAgNC41NzA4MzZdIFs8YzAwNDVhZmM+XSAod29ya2VyX3Ro
cmVhZCkgZnJvbSBbPGMwMDRjM2FjPl0gKGt0aHJlYWQrMHgxMDgvMHgxMjApClsgICAgNC41
NzQ0MjFdIHVzYiAxLTIuMS4xOiBOZXcgVVNCIGRldmljZSBmb3VuZCwgaWRWZW5kb3I9MDQy
NCwgaWRQcm9kdWN0PWVjMDAKWyAgICA0LjU3NDQyNl0gdXNiIDEtMi4xLjE6IE5ldyBVU0Ig
ZGV2aWNlIHN0cmluZ3M6IE1mcj0wLCBQcm9kdWN0PTAsIFNlcmlhbE51bWJlcj0wClsgICAg
NC41NzcxMjhdIHNtc2M5NXh4IHYxLjAuNApbICAgIDQuNTk1NDg0XSAgcjEwOjAwMDAwMDAw
IHI5OjAwMDAwMDAwIHI4OjAwMDAwMDAwIHI3OmMwMDQ1YWZjIHI2OmVlODY3MTAwIHI1OmVl
OGZlMDQwClsgICAgNC42MDMyOTVdICByNDowMDAwMDAwMApbICAgIDQuNjA1ODE5XSBbPGMw
MDRjMmE0Pl0gKGt0aHJlYWQpIGZyb20gWzxjMDAwZmViMD5dIChyZXRfZnJvbV9mb3JrKzB4
MTQvMHgyNCkKWyAgICA0LjYxMzAxN10gIHI3OjAwMDAwMDAwIHI2OjAwMDAwMDAwIHI1OmMw
MDRjMmE0IHI0OmVlOGZlMDQwClsgICAgNC42MTg2NjJdIENvZGU6IGU1OTIyMDE4IGUzNGMw
MDc2IGUyNDMzMTA3IDA1OTcxMDE4IChlNzkyMzEwMykgClsgICAgNC42MjQ4MDZdIERFQlVH
OiBpbiBleHlub3NfYnVzX3RhcmdldCgpClsgICAgNC42MjQ4MzBdIC0tLVsgZW5kIHRyYWNl
IDk2M2EzOTY1Njc0MjQ4MjcgXS0tLQpbICAgIDQuNjI0ODYyXSBVbmFibGUgdG8gaGFuZGxl
IGtlcm5lbCBwYWdpbmcgcmVxdWVzdCBhdCB2aXJ0dWFsIGFkZHJlc3MgZmZmZmZmZDAKWyAg
ICA0LjYyNDg2NF0gcGdkID0gYzAwMDQwMDAKWyAgICA0LjYyNDg3MF0gW2ZmZmZmZmQwXSAq
cGdkPTZmZmZkODYxLCAqcHRlPTAwMDAwMDAwLCAqcHB0ZT0wMDAwMDAwMApbICAgIDQuNjI0
ODc0XSBJbnRlcm5hbCBlcnJvcjogT29wczogMzcgWyMyXSBQUkVFTVBUIFNNUCBBUk0KWyAg
ICA0LjYyNDg3OF0gTW9kdWxlcyBsaW5rZWQgaW46ClsgICAgNC42MjQ4ODJdIENQVTogMiBQ
SUQ6IDI5IENvbW06IGt3b3JrZXIvdTg6MSBUYWludGVkOiBHICAgICAgRCAgICAgICAgIDQu
NC4wLWRlYnVnKyAjMgpbICAgIDQuNjI0ODg0XSBIYXJkd2FyZSBuYW1lOiBTQU1TVU5HIEVY
WU5PUyAoRmxhdHRlbmVkIERldmljZSBUcmVlKQpbICAgIDQuNjI0ODkxXSB0YXNrOiBlZTll
OGJjMCB0aTogZWVhMGMwMDAgdGFzay50aTogZWVhMGMwMDAKWyAgICA0LjYyNDg5Nl0gUEMg
aXMgYXQga3RocmVhZF9kYXRhKzB4MTAvMHgxOApbICAgIDQuNjI0OTAwXSBMUiBpcyBhdCB3
cV93b3JrZXJfc2xlZXBpbmcrMHgxNC8weGQ4ClsgICAgNC42MjQ5MDNdIHBjIDogWzxjMDA0
Y2RkYz5dICAgIGxyIDogWzxjMDA0NjliND5dICAgIHBzcjogMDAwMDAxZDMKWyAgICA0LjYy
NDkwM10gc3AgOiBlZWEwZGE2OCAgaXAgOiBlZWEwZGE3OCAgZnAgOiBlZWEwZGE3NApbICAg
IDQuNjI0OTA2XSByMTA6IDAwMDAwMDAwICByOSA6IGMwN2Y4NmJjICByOCA6IDAwMDAwMDAy
ClsgICAgNC42MjQ5MDhdIHI3IDogZWU5ZThlODggIHI2IDogYzA3ZjM0ODAgIHI1IDogZWU5
ZThiYzAgIHI0IDogMDAwMDAwMDIKWyAgICA0LjYyNDkxMV0gcjMgOiAwMDAwMDAwMCAgcjIg
OiAwMDAwMDAwMCAgcjEgOiAwMDAwMDAwMiAgcjAgOiBlZTllOGJjMApbICAgIDQuNjI0OTE0
XSBGbGFnczogbnpjdiAgSVJRcyBvZmYgIEZJUXMgb2ZmICBNb2RlIFNWQ18zMiAgSVNBIEFS
TSAgU2VnbWVudCBub25lClsgICAgNC42MjQ5MTZdIENvbnRyb2w6IDEwYzUzODdkICBUYWJs
ZTogNDAwMDQwNGEgIERBQzogMDAwMDAwNTEKWyAgICA0LjYyNDkxOV0gUHJvY2VzcyBrd29y
a2VyL3U4OjEgKHBpZDogMjksIHN0YWNrIGxpbWl0ID0gMHhlZWEwYzIxOCkKWyAgICA0LjYy
NDkyMl0gU3RhY2s6ICgweGVlYTBkYTY4IHRvIDB4ZWVhMGUwMDApClsgICAgNC42MjQ5Mjdd
IGRhNjA6ICAgICAgICAgICAgICAgICAgIGVlYTBkYThjIGVlYTBkYTc4IGMwMDQ2OWI0IGMw
MDRjZGQ4IGVlZjg3NDgwIGVlOWU4YmMwClsgICAgNC42MjQ5MzJdIGRhODA6IGVlYTBkYWU0
IGVlYTBkYTkwIGMwNWFmZmVjIGMwMDQ2OWFjIGMwMDE0MzIwIGMwMDEyNzAwIGMwMDEyNzI0
IDAwMDAwMDAwClsgICAgNC42MjQ5MzddIGRhYTA6IGVlYTBkOGQwIGVlYTBkYjEwIGVlYTBk
YWU0IGVlYTBkYWI4IGMwNWIwNzBjIGVlZjg3NDkwIDAwMDAwMDAwIGVlYTBjMDAwClsgICAg
NC42MjQ5NDFdIGRhYzA6IGVlYTBkOGQwIGVlYTBkYjEwIGVlOWU4ZGU0IGMwNDU4YTZhIGVl
ODc4MDAwIDAwMDAwMDAwIGVlYTBkYWZjIGVlYTBkYWU4ClsgICAgNC42MjQ5NDZdIGRhZTA6
IGMwNWIwNzBjIGMwNWFmYjc4IDA0MjA4MDZjIGVlOWU4YmMwIGVlYTBkYjJjIGVlYTBkYjAw
IGMwMDJjOTVjIGMwNWIwNmM4ClsgICAgNC42MjQ5NTFdIGRiMDA6IGMwNDU4YTZjIGMwNDU4
YTZhIDAwMDAwMDAxIDAwMDAwMDAxIGVlYTBkYjEwIGVlYTBkYjEwIGMwMDI5YTJjIGMwNDU4
YTZjClsgICAgNC42MjQ5NTZdIGRiMjA6IGVlYTBkYmJjIGVlYTBkYjMwIGMwMDE0ZGUwIGMw
MDJjMjE4IGVlYTBjMjE4IDAwMDAwMDBiIGMwNmVmZTE4IDAwMDAwMDA4ClsgICAgNC42MjQ5
NjFdIGRiNDA6IDAwMDAwMDAwIGVlYTBjMDAwIDAwMDAwMDAwIDYwMDAwMTUzIGMwMDgzNThj
IDY1MDgyZGNjIDMyMzIzOTM1IDIwMzgzMTMwClsgICAgNC42MjQ5NjVdIGRiNjA6IDYzMzQz
MzY1IDM2MzczMDMwIDM0MzI2NTIwIDMwMzEzMzMzIDM1MzAyMDM3IDMwMzEzNzM5IDI4MjAz
ODMxIDMyMzkzNzY1ClsgICAgNC42MjQ5NzBdIGRiODA6IDMzMzAzMTMzIGVlMDAyMDI5IGMw
MDFmNWJjIGRjOGJhNjAwIGMwNzRjNDFjIGZmZmZmZmZjIDAwMDAwMDM3IGVlYTBkY2UwClsg
ICAgNC42MjQ5NzVdIGRiYTA6IDAwMDAwMDAwIGZmZmZmZmZjIGVlZmNjOGM0IGVlYmY2YzEw
IGVlYTBkYmQ0IGVlYTBkYmMwIGMwMDIzZWU0IGMwMDE0OTc0ClsgICAgNC42MjQ5ODBdIGRi
YzA6IGVlYTBkY2UwIDAwMDAwMDM3IGVlYTBkYzJjIGVlYTBkYmQ4IGMwMDFmOTZjIGMwMDIz
ZTg0IDAwMDAwMDAwIDAwMDAwMDAyClsgICAgNC42MjQ5ODVdIGRiZTA6IGVlYTBkYmZjIGVl
YTBkYmYwIGMwMDcxNDgwIGMwMDcxM2E4IDAwMDAwMDAwIGVlYTBkYzAwIDAwMDAwMDAwIGMw
MDUyODA0ClsgICAgNC42MjQ5ODldIGRjMDA6IGVlZjgzNDQwIGMwN2ZkNTI0IDAwMDAwMDM3
IGMwMDFmNWQwIGZmZmZmZmZjIGVlYTBkY2UwIGVlZmNjOGM0IGVlYmY2YzEwClsgICAgNC42
MjQ5OTRdIGRjMjA6IGVlYTBkY2RjIGVlYTBkYzMwIGMwMDA5MzkwIGMwMDFmNWRjIGMwODNi
NDg4IGVlMzY1MjdjIDAwMDAwMDAwIDAwMDAwMDAwClsgICAgNC42MjQ5OTldIGRjNDA6IDAw
MDAwMDAwIDYwMDAwMDUzIGVlYTBkY2E0IGVlYTBkYzU4IGMwMDc3NmI4IGMwMDc0ZDQ0IDAw
MDAwMDAxIDAwMDAwMDAwClsgICAgNC42MjUwMDRdIGRjNjA6IGVlYTBkY2NjIGVlYTBkYzcw
IGMwMDc3ODk4IGMwMDhkM2UwIGMwMDU2MTgwIGMwMDc4ZmNjIDAwMDAwMDA1IGVlMzY1MjRj
ClsgICAgNC42MjUwMDhdIGRjODA6IDYwMDAwMDUzIGMxMDEwMzJjIGVlYTBkY2E0IGVlYTBk
Yzk4IGMwMDc0OWRjIGMwMDc0N2Q0IDYwMDAwMGQzIGVlYTBkY2E4ClsgICAgNC42MjUwMTNd
IGRjYTA6IDAwMDAwMDA2IGVlMzY1MjQ4IGVlMzY1MjZjIDYwMDAwMDUzIGVlYTBkY2NjIGVl
YTBkY2MwIGMwMDc0OWRjIGMwNDU4YTY4ClsgICAgNC42MjUwMThdIGRjYzA6IDYwMDAwMDUz
IGZmZmZmZmZmIGVlYTBkZDE0IGVlOTQ2NGQwIGVlYTBkZDdjIGVlYTBkY2UwIGMwMDE1NGE0
IGMwMDA5MzVjClsgICAgNC42MjUwMjNdIGRjZTA6IGMwNzYxNDFjIGVlYmE4NDgwIDAwMDAw
MDAwIDNmZmZmZmZmIDEwNjI0ZGQzIDAwMDAwMDAwIGVlYmY2YzEwIGVlYmY2YzAwClsgICAg
NC42MjUwMjhdIGRkMDA6IGVlOTQ2NGQwIGVlZmNjOGM0IGVlYmY2YzEwIGVlYTBkZDdjIGVl
YTBkY2MwIGVlYTBkZDMwIGMwMDc0OWRjIGMwNDU4YTY4ClsgICAgNC42MjUwMzNdIGRkMjA6
IDYwMDAwMDUzIGZmZmZmZmZmIDAwMDAwMDUxIGMwNDU4MGYwIDAwMDAwMDAwIDAwMDAwMDAw
IGMwNDU4OGU0IGMwMzM4NWM4ClsgICAgNC42MjUwMzddIGRkNDA6IDAwMDAwMDAyIGVlOTQ2
MjUwIGMxMDIwM2I0IDE3ZDc4NDAwIGMwODJlODIwIGZmZmZmZmZlIGVlYmY2YzEwIGMwODJl
ODIwClsgICAgNC42MjUwNDJdIGRkNjA6IGZmZmZmZGZiIDAwMDAwMDAzIGMwODNiMjU4IDAw
MDAwMDAxIGVlYTBkZDljIGVlYTBkZDgwIGMwMzNkYzc4IGMwNDU4ODU0ClsgICAgNC42MjUw
NDddIGRkODA6IGMxMDIwM2I0IGVlYmY2YzEwIDAwMDAwMDAwIGMwODJlODIwIGVlYTBkZGM0
IGVlYTBkZGEwIGMwMzNiYWQ0IGMwMzNkYzJjClsgICAgNC42MjUwNTJdIGRkYTA6IDAwMDAw
MDAwIGMwODJlODIwIGVlYTBkZTEwIGVlYmY2YzEwIDAwMDAwMDAxIGVlYTBkZWE4IGVlYTBk
ZGU0IGVlYTBkZGM4ClsgICAgNC42MjUwNTZdIGRkYzA6IGMwMzNiZDMwIGMwMzNiOGQwIGVl
MmJiYTYwIDAwMDAwMDAwIGVlYTBkZTEwIGMwMzNiY2E4IGVlYTBkZTBjIGVlYTBkZGU4Clsg
ICAgNC42MjUwNjFdIGRkZTA6IGMwMzM5ZGNjIGMwMzNiY2I0IGVlODAzNmQ0IGVlMmJiYTU0
IGVlYmY2YzEwIGVlYmY2YzEwIGVlYmY2YzEwIGVlYmY2YzQ0ClsgICAgNC42MjUwNjZdIGRl
MDA6IGVlYTBkZTM0IGVlYTBkZTEwIGMwMzNiODIwIGMwMzM5ZDZjIGVlYmY2YzEwIDAwMDAw
MDAxIGVlYmY2YzEwIGVlYmY2YzEwClsgICAgNC42MjUwNzFdIGRlMjA6IGMwODIzN2M4IGVl
MjFhZTAwIGVlYTBkZTQ0IGVlYTBkZTM4IGMwMzNiZThjIGMwMzNiNzdjIGVlYTBkZTY0IGVl
YTBkZTQ4ClsgICAgNC42MjUwNzVdIGRlNDA6IGMwMzNhZTc4IGMwMzNiZTg0IDAwMDAwMDAw
IGVlYmY2YzEwIGMwODIzNDg4IGMwODIzNGNjIGVlYTBkZTg0IGVlYTBkZTY4ClsgICAgNC42
MjUwODBdIGRlNjA6IGMwMzNiMmM4IGMwMzNhZGY0IGMwMzNiMjU4IGMwODIzNTA0IGVlODY3
MTAwIGVlODBhYzAwIGVlYTBkZWU0IGVlYTBkZTg4ClsgICAgNC42MjUwODVdIGRlODA6IGMw
MDQ1NWJjIGMwMzNiMjY0IDAwMDAwMDAxIDAwMDAwMDAwIGMwMDQ1NGUwIGVlODBhYzAwIGVl
ODBhYzAwIDAwMDAwMDAwClsgICAgNC42MjUwOTBdIGRlYTA6IDAwMDAwMDAwIDAwMDAwMDAw
IGMwODIzNTA0IDAwMDAwMDAwIDAwMDAwMDAwIGMwNzJlMWY0IGMwNWI2MTU4IGVlODBhYzAw
ClsgICAgNC42MjUwOTRdIGRlYzA6IGVlODY3MTE4IGVlODBhYzMwIDAwMDAwMDg4IGMwMDQ1
YmM0IGVlODBhYzAwIGVlODY3MTAwIGVlYTBkZjI0IGVlYTBkZWU4ClsgICAgNC42MjUwOTld
IGRlZTA6IGMwMDQ1YjRjIGMwMDQ1M2JjIGVlOGZlMDQwIGVlODBhZGEwIGMwN2Y4MTAwIGMw
ODNhNzk2IDAwMDAwMDAwIDAwMDAwMDAwClsgICAgNC42MjUxMDRdIGRmMDA6IGVlOGZlMDQw
IGVlODY3MTAwIGMwMDQ1YWZjIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIGVlYTBkZmFj
IGVlYTBkZjI4ClsgICAgNC42MjUxMDldIGRmMjA6IGMwMDRjM2FjIGMwMDQ1YjA4IDAwMDAw
MDAwIGVlYTBkZjM4IGVlODY3MTAwIDAwMDAwMDAwIDAwMDAwMDAwIGRlYWQ0ZWFkClsgICAg
NC42MjUxMTNdIGRmNDA6IGZmZmZmZmZmIGZmZmZmZmZmIGMwODQxMDQwIDAwMDAwMDAwIDAw
MDAwMDAwIGMwNmYzYzIwIGVlYTBkZjU4IGVlYTBkZjU4ClsgICAgNC42MjUxMThdIGRmNjA6
IDAwMDAwMDAxIDAwMDEwMDAxIGRlYWQ0ZWFkIGZmZmZmZmZmIGZmZmZmZmZmIGMwODQxMDQw
IDAwMDAwMDAwIDAwMDAwMDAwClsgICAgNC42MjUxMjNdIGRmODA6IGMwNmYzYzIwIGVlYTBk
Zjg0IGVlYTBkZjg0IGRjOGJhNjAwIGVlOGZlMDQwIGMwMDRjMmE0IDAwMDAwMDAwIDAwMDAw
MDAwClsgICAgNC42MjUxMjddIGRmYTA6IDAwMDAwMDAwIGVlYTBkZmIwIGMwMDBmZWIwIGMw
MDRjMmIwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwClsgICAgNC42MjUx
MzJdIGRmYzA6IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAw
IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwClsgICAgNC42MjUxMzZdIGRmZTA6IDAwMDAw
MDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDEzIDAwMDAwMDAwIGVlYTBk
ZmY0IDAwMDAwMDAwClsgICAgNC42MjUxMzldIEJhY2t0cmFjZTogClsgICAgNC42MjUxNDVd
IFs8YzAwNGNkY2M+XSAoa3RocmVhZF9kYXRhKSBmcm9tIFs8YzAwNDY5YjQ+XSAod3Ffd29y
a2VyX3NsZWVwaW5nKzB4MTQvMHhkOCkKWyAgICA0LjYyNTE1M10gWzxjMDA0NjlhMD5dICh3
cV93b3JrZXJfc2xlZXBpbmcpIGZyb20gWzxjMDVhZmZlYz5dIChfX3NjaGVkdWxlKzB4NDgw
LzB4OTk0KQpbICAgIDQuNjI1MTU3XSAgcjU6ZWU5ZThiYzAgcjQ6ZWVmODc0ODAKWyAgICA0
LjYyNTE2Ml0gWzxjMDVhZmI2Yz5dIChfX3NjaGVkdWxlKSBmcm9tIFs8YzA1YjA3MGM+XSAo
c2NoZWR1bGUrMHg1MC8weGIwKQpbICAgIDQuNjI1MTcxXSAgcjEwOjAwMDAwMDAwIHI5OmVl
ODc4MDAwIHI4OmMwNDU4YTZhIHI3OmVlOWU4ZGU0IHI2OmVlYTBkYjEwIHI1OmVlYTBkOGQw
ClsgICAgNC42MjUxNzRdICByNDplZWEwYzAwMApbICAgIDQuNjI1MTgwXSBbPGMwNWIwNmJj
Pl0gKHNjaGVkdWxlKSBmcm9tIFs8YzAwMmM5NWM+XSAoZG9fZXhpdCsweDc1MC8weGJlOCkK
WyAgICA0LjYyNTE4NF0gIHI0OmVlOWU4YmMwIHIzOjA0MjA4MDZjClsgICAgNC42MjUxODld
IFs8YzAwMmMyMGM+XSAoZG9fZXhpdCkgZnJvbSBbPGMwMDE0ZGUwPl0gKGRpZSsweDQ3OC8w
eDQ5MCkKWyAgICA0LjYyNTE5Ml0gIHI3OmMwNDU4YTZjClsgICAgNC42MjUyMDBdIFs8YzAw
MTQ5Njg+XSAoZGllKSBmcm9tIFs8YzAwMjNlZTQ+XSAoX19kb19rZXJuZWxfZmF1bHQucGFy
dC4wKzB4NmMvMHgxZWMpClsgICAgNC42MjUyMDldICByMTA6ZWViZjZjMTAgcjk6ZWVmY2M4
YzQgcjg6ZmZmZmZmZmMgcjc6MDAwMDAwMDAgcjY6ZWVhMGRjZTAgcjU6MDAwMDAwMzcKWyAg
ICA0LjYyNTIxMl0gIHI0OmZmZmZmZmZjClsgICAgNC42MjUyMTddIFs8YzAwMjNlNzg+XSAo
X19kb19rZXJuZWxfZmF1bHQucGFydC4wKSBmcm9tIFs8YzAwMWY5NmM+XSAoZG9fcGFnZV9m
YXVsdCsweDM5Yy8weDNhYykKWyAgICA0LjYyNTIyMV0gIHI3OjAwMDAwMDM3IHIzOmVlYTBk
Y2UwClsgICAgNC42MjUyMjZdIFs8YzAwMWY1ZDA+XSAoZG9fcGFnZV9mYXVsdCkgZnJvbSBb
PGMwMDA5MzkwPl0gKGRvX0RhdGFBYm9ydCsweDQwLzB4YmMpClsgICAgNC42MjUyMzRdICBy
MTA6ZWViZjZjMTAgcjk6ZWVmY2M4YzQgcjg6ZWVhMGRjZTAgcjc6ZmZmZmZmZmMgcjY6YzAw
MWY1ZDAgcjU6MDAwMDAwMzcKWyAgICA0LjYyNTIzN10gIHI0OmMwN2ZkNTI0ClsgICAgNC42
MjUyNDFdIFs8YzAwMDkzNTA+XSAoZG9fRGF0YUFib3J0KSBmcm9tIFs8YzAwMTU0YTQ+XSAo
X19kYWJ0X3N2YysweDQ0LzB4ODApClsgICAgNC42MjUyNDRdIEV4Y2VwdGlvbiBzdGFjaygw
eGVlYTBkY2UwIHRvIDB4ZWVhMGRkMjgpClsgICAgNC42MjUyNDldIGRjZTA6IGMwNzYxNDFj
IGVlYmE4NDgwIDAwMDAwMDAwIDNmZmZmZmZmIDEwNjI0ZGQzIDAwMDAwMDAwIGVlYmY2YzEw
IGVlYmY2YzAwClsgICAgNC42MjUyNTRdIGRkMDA6IGVlOTQ2NGQwIGVlZmNjOGM0IGVlYmY2
YzEwIGVlYTBkZDdjIGVlYTBkY2MwIGVlYTBkZDMwIGMwMDc0OWRjIGMwNDU4YTY4ClsgICAg
NC42MjUyNTddIGRkMjA6IDYwMDAwMDUzIGZmZmZmZmZmClsgICAgNC42MjUyNjVdICByODpl
ZTk0NjRkMCByNzplZWEwZGQxNCByNjpmZmZmZmZmZiByNTo2MDAwMDA1MyByNDpjMDQ1OGE2
OApbICAgIDQuNjI1MjcyXSBbPGMwNDU4ODQ4Pl0gKGV4eW5vc19idXNfcHJvYmUpIGZyb20g
WzxjMDMzZGM3OD5dIChwbGF0Zm9ybV9kcnZfcHJvYmUrMHg1OC8weGI0KQpbICAgIDQuNjI1
MjgxXSAgcjEwOjAwMDAwMDAxIHI5OmMwODNiMjU4IHI4OjAwMDAwMDAzIHI3OmZmZmZmZGZi
IHI2OmMwODJlODIwIHI1OmVlYmY2YzEwClsgICAgNC42MjUyODRdICByNDpmZmZmZmZmZQpb
ICAgIDQuNjI1Mjg5XSBbPGMwMzNkYzIwPl0gKHBsYXRmb3JtX2Rydl9wcm9iZSkgZnJvbSBb
PGMwMzNiYWQ0Pl0gKGRyaXZlcl9wcm9iZV9kZXZpY2UrMHgyMTAvMHgzMDQpClsgICAgNC42
MjUyOTZdICByNzpjMDgyZTgyMCByNjowMDAwMDAwMCByNTplZWJmNmMxMCByNDpjMTAyMDNi
NApbICAgIDQuNjI1MzAxXSBbPGMwMzNiOGM0Pl0gKGRyaXZlcl9wcm9iZV9kZXZpY2UpIGZy
b20gWzxjMDMzYmQzMD5dIChfX2RldmljZV9hdHRhY2hfZHJpdmVyKzB4ODgvMHg5NCkKWyAg
ICA0LjYyNTMwOV0gIHI4OmVlYTBkZWE4IHI3OjAwMDAwMDAxIHI2OmVlYmY2YzEwIHI1OmVl
YTBkZTEwIHI0OmMwODJlODIwIHIzOjAwMDAwMDAwClsgICAgNC42MjUzMTRdIFs8YzAzM2Jj
YTg+XSAoX19kZXZpY2VfYXR0YWNoX2RyaXZlcikgZnJvbSBbPGMwMzM5ZGNjPl0gKGJ1c19m
b3JfZWFjaF9kcnYrMHg2Yy8weGEwKQpbICAgIDQuNjI1MzIwXSAgcjY6YzAzM2JjYTggcjU6
ZWVhMGRlMTAgcjQ6MDAwMDAwMDAgcjM6ZWUyYmJhNjAKWyAgICA0LjYyNTMyNV0gWzxjMDMz
OWQ2MD5dIChidXNfZm9yX2VhY2hfZHJ2KSBmcm9tIFs8YzAzM2I4MjA+XSAoX19kZXZpY2Vf
YXR0YWNoKzB4YjAvMHgxMTApClsgICAgNC42MjUzMzBdICByNjplZWJmNmM0NCByNTplZWJm
NmMxMCByNDplZWJmNmMxMApbICAgIDQuNjI1MzM0XSBbPGMwMzNiNzcwPl0gKF9fZGV2aWNl
X2F0dGFjaCkgZnJvbSBbPGMwMzNiZThjPl0gKGRldmljZV9pbml0aWFsX3Byb2JlKzB4MTQv
MHgxOCkKWyAgICA0LjYyNTM0MV0gIHI3OmVlMjFhZTAwIHI2OmMwODIzN2M4IHI1OmVlYmY2
YzEwIHI0OmVlYmY2YzEwClsgICAgNC42MjUzNDVdIFs8YzAzM2JlNzg+XSAoZGV2aWNlX2lu
aXRpYWxfcHJvYmUpIGZyb20gWzxjMDMzYWU3OD5dIChidXNfcHJvYmVfZGV2aWNlKzB4OTAv
MHg5OCkKWyAgICA0LjYyNTM1MF0gWzxjMDMzYWRlOD5dIChidXNfcHJvYmVfZGV2aWNlKSBm
cm9tIFs8YzAzM2IyYzg+XSAoZGVmZXJyZWRfcHJvYmVfd29ya19mdW5jKzB4NzAvMHhhNCkK
WyAgICA0LjYyNTM1Nl0gIHI2OmMwODIzNGNjIHI1OmMwODIzNDg4IHI0OmVlYmY2YzEwIHIz
OjAwMDAwMDAwClsgICAgNC42MjUzNjFdIFs8YzAzM2IyNTg+XSAoZGVmZXJyZWRfcHJvYmVf
d29ya19mdW5jKSBmcm9tIFs8YzAwNDU1YmM+XSAocHJvY2Vzc19vbmVfd29yaysweDIwYy8w
eDc0YykKWyAgICA0LjYyNTM2OF0gIHI2OmVlODBhYzAwIHI1OmVlODY3MTAwIHI0OmMwODIz
NTA0IHIzOmMwMzNiMjU4ClsgICAgNC42MjUzNzJdIFs8YzAwNDUzYjA+XSAocHJvY2Vzc19v
bmVfd29yaykgZnJvbSBbPGMwMDQ1YjRjPl0gKHdvcmtlcl90aHJlYWQrMHg1MC8weDRmMCkK
WyAgICA0LjYyNTM4MF0gIHIxMDplZTg2NzEwMCByOTplZTgwYWMwMCByODpjMDA0NWJjNCBy
NzowMDAwMDA4OCByNjplZTgwYWMzMCByNTplZTg2NzExOApbICAgIDQuNjI1MzgzXSAgcjQ6
ZWU4MGFjMDAKWyAgICA0LjYyNTM4OF0gWzxjMDA0NWFmYz5dICh3b3JrZXJfdGhyZWFkKSBm
cm9tIFs8YzAwNGMzYWM+XSAoa3RocmVhZCsweDEwOC8weDEyMCkKWyAgICA0LjYyNTM5N10g
IHIxMDowMDAwMDAwMCByOTowMDAwMDAwMCByODowMDAwMDAwMCByNzpjMDA0NWFmYyByNjpl
ZTg2NzEwMCByNTplZThmZTA0MApbICAgIDQuNjI1Mzk5XSAgcjQ6MDAwMDAwMDAKWyAgICA0
LjYyNTQwNV0gWzxjMDA0YzJhND5dIChrdGhyZWFkKSBmcm9tIFs8YzAwMGZlYjA+XSAocmV0
X2Zyb21fZm9yaysweDE0LzB4MjQpClsgICAgNC42MjU0MTJdICByNzowMDAwMDAwMCByNjow
MDAwMDAwMCByNTpjMDA0YzJhNCByNDplZThmZTA0MApbICAgIDQuNjI1NDE2XSBDb2RlOiBl
MWEwYzAwZCBlOTJkZDgwMCBlMjRjYjAwNCBlNTkwMzI3YyAoZTUxMzAwMzApIApbICAgIDQu
NjI1NDE5XSAtLS1bIGVuZCB0cmFjZSA5NjNhMzk2NTY3NDI0ODI4IF0tLS0KWyAgICA0LjYy
NTQyMl0gRml4aW5nIHJlY3Vyc2l2ZSBmYXVsdCBidXQgcmVib290IGlzIG5lZWRlZCEKWyAg
IDM4LjMyNDg1Nl0gQlVHOiBzcGlubG9jayBsb2NrdXAgc3VzcGVjdGVkIG9uIENQVSMyLCBr
d29ya2VyL3U4OjEvMjkKWyAgIDM4LjMyNTU3M10gIGxvY2s6IDB4ZWVmODc0ODAsIC5tYWdp
YzogZGVhZDRlYWQsIC5vd25lcjoga3dvcmtlci91ODoxLzI5LCAub3duZXJfY3B1OiAyClsg
ICAzOC4zMzE2MjJdIEJVRzogc3BpbmxvY2sgbG9ja3VwIHN1c3BlY3RlZCBvbiBDUFUjMywg
a3dvcmtlci91ODowLzYKWyAgIDM4LjMzMTYzMF0gIGxvY2s6IDB4ZWVmODc0ODAsIC5tYWdp
YzogZGVhZDRlYWQsIC5vd25lcjoga3dvcmtlci91ODoxLzI5LCAub3duZXJfY3B1OiAyClsg
ICAzOC4zMzE2MzddIENQVTogMyBQSUQ6IDYgQ29tbToga3dvcmtlci91ODowIFRhaW50ZWQ6
IEcgICAgICBEICAgICAgICAgNC40LjAtZGVidWcrICMyClsgICAzOC4zMzE2MzldIEhhcmR3
YXJlIG5hbWU6IFNBTVNVTkcgRVhZTk9TIChGbGF0dGVuZWQgRGV2aWNlIFRyZWUpClsgICAz
OC4zMzE2NjNdIFdvcmtxdWV1ZTogZXZlbnRzX3VuYm91bmQgY2FsbF91c2VybW9kZWhlbHBl
cl9leGVjX3dvcmsKWyAgIDM4LjMzMTY2N10gQmFja3RyYWNlOiAKWyAgIDM4LjMzMTY4MF0g
WzxjMDAxNDc2OD5dIChkdW1wX2JhY2t0cmFjZSkgZnJvbSBbPGMwMDE0OTY0Pl0gKHNob3df
c3RhY2srMHgxOC8weDFjKQpbICAgMzguMzMxNjg5XSAgcjY6YzA4MWE4MGMgcjU6YzA4MWE4
MGMgcjQ6MDAwMDAwMDAgcjM6ZGM4YmE2MDAKWyAgIDM4LjMzMTcwM10gWzxjMDAxNDk0Yz5d
IChzaG93X3N0YWNrKSBmcm9tIFs8YzAyNzFiMzg+XSAoZHVtcF9zdGFjaysweDhjLzB4Y2Mp
ClsgICAzOC4zMzE3MTddIFs8YzAyNzFhYWM+XSAoZHVtcF9zdGFjaykgZnJvbSBbPGMwMDdi
MGQ4Pl0gKHNwaW5fZHVtcCsweDg0LzB4YTQpClsgICAzOC4zMzE3MjVdICByNjowMjcwMDYw
MCByNTplZWY4NzQ4MCByNDplZTllOGJjMCByMzowMDAwMDAwMApbICAgMzguMzMxNzMwXSBb
PGMwMDdiMDU0Pl0gKHNwaW5fZHVtcCkgZnJvbSBbPGMwMDdiMjk0Pl0gKGRvX3Jhd19zcGlu
X2xvY2srMHgxMDQvMHgxYjgpClsgICAzOC4zMzE3MzVdICByNTpjMDgxYTdmNCByNDplZWY4
NzQ4MApbICAgMzguMzMxNzQ3XSBbPGMwMDdiMTkwPl0gKGRvX3Jhd19zcGluX2xvY2spIGZy
b20gWzxjMDViNWYyYz5dIChfcmF3X3NwaW5fbG9jaysweDRjLzB4NTQpClsgICAzOC4zMzE3
NTZdICByOTpjMDdmODZiYyByODo0MDAwMDA1MyByNzplZTE2NTYwMCByNjpjMDdmMzQ4MCBy
NTpjMDA1NTk0NCByNDplZWY4NzQ4MApbICAgMzguMzMxNzc0XSBbPGMwNWI1ZWUwPl0gKF9y
YXdfc3Bpbl9sb2NrKSBmcm9tIFs8YzAwNTU5NDQ+XSAod2FrZV91cF9uZXdfdGFzaysweGY4
LzB4M2M0KQpbICAgMzguMzMxNzc4XSBCVUc6IHNwaW5sb2NrIGxvY2t1cCBzdXNwZWN0ZWQg
b24gQ1BVIzAsIGt3b3JrZXIvdTg6My80NwpbICAgMzguMzMxNzg1XSAgcjU6ZWVmODc0ODAK
WyAgIDM4LjMzMTc4Nl0gIGxvY2s6IDB4ZWVmODc0ODAsIC5tYWdpYzogZGVhZDRlYWQsIC5v
d25lcjoga3dvcmtlci91ODoxLzI5LCAub3duZXJfY3B1OiAyClsgICAzOC4zMzE3ODldICBy
NDplZTE2NTI0MApbICAgMzguMzMxNzk3XSBbPGMwMDU1ODRjPl0gKHdha2VfdXBfbmV3X3Rh
c2spIGZyb20gWzxjMDAyODhiND5dIChfZG9fZm9yaysweDEzMC8weDdjNCkKWyAgIDM4LjMz
MTgwNl0gIHIxMDowMDAwMDAwMSByOTplZWJjOTNjMCByODowMDAwMDAwMCByNzowMDAwMDM1
YSByNjpjMDdmODQ0OCByNTowMDAwMDAwMApbICAgMzguMzMxODA5XSAgcjQ6ZWUxNjUyNDAK
WyAgIDM4LjMzMTgxNF0gWzxjMDAyODc4ND5dIChfZG9fZm9yaykgZnJvbSBbPGMwMDI4ZmE4
Pl0gKGtlcm5lbF90aHJlYWQrMHgzOC8weDQwKQpbICAgMzguMzMxODIzXSAgcjEwOjAwMDAw
MDAxIHI5OmMwODNiMjU4IHI4OmVlOGE1ZWE4IHI3OmVlODBjYzAwIHI2OmVlODBhYzAwIHI1
OmVlODQ5ZjgwClsgICAzOC4zMzE4MjZdICByNDplZTM3ZmM4MApbICAgMzguMzMxODMyXSBb
PGMwMDI4ZjcwPl0gKGtlcm5lbF90aHJlYWQpIGZyb20gWzxjMDA0MTgyND5dIChjYWxsX3Vz
ZXJtb2RlaGVscGVyX2V4ZWNfd29yaysweDM0LzB4YzQpClsgICAzOC4zMzE4MzddIFs8YzAw
NDE3ZjA+XSAoY2FsbF91c2VybW9kZWhlbHBlcl9leGVjX3dvcmspIGZyb20gWzxjMDA0NTVi
Yz5dIChwcm9jZXNzX29uZV93b3JrKzB4MjBjLzB4NzRjKQpbICAgMzguMzMxODQwXSAgcjQ6
ZWUzN2ZjODAKWyAgIDM4LjMzMTg0NF0gWzxjMDA0NTNiMD5dIChwcm9jZXNzX29uZV93b3Jr
KSBmcm9tIFs8YzAwNDViNGM+XSAod29ya2VyX3RocmVhZCsweDUwLzB4NGYwKQpbICAgMzgu
MzMxODUzXSAgcjEwOmVlODQ5ZjgwIHI5OmVlODBhYzAwIHI4OmMwMDQ1YmM0IHI3OjAwMDAw
MDg4IHI2OmVlODBhYzMwIHI1OmVlODQ5Zjk4ClsgICAzOC4zMzE4NTZdICByNDplZTgwYWMw
MApbICAgMzguMzMxODYyXSBbPGMwMDQ1YWZjPl0gKHdvcmtlcl90aHJlYWQpIGZyb20gWzxj
MDA0YzNhYz5dIChrdGhyZWFkKzB4MTA4LzB4MTIwKQpbICAgMzguMzMxODcwXSAgcjEwOjAw
MDAwMDAwIHI5OjAwMDAwMDAwIHI4OjAwMDAwMDAwIHI3OmMwMDQ1YWZjIHI2OmVlODQ5Zjgw
IHI1OmVlODRiNzAwClsgICAzOC4zMzE4NzNdICByNDowMDAwMDAwMApbICAgMzguMzMxODc5
XSBbPGMwMDRjMmE0Pl0gKGt0aHJlYWQpIGZyb20gWzxjMDAwZmViMD5dIChyZXRfZnJvbV9m
b3JrKzB4MTQvMHgyNCkKWyAgIDM4LjMzMTg4Nl0gIHI3OjAwMDAwMDAwIHI2OjAwMDAwMDAw
IHI1OmMwMDRjMmE0IHI0OmVlODRiNzAwClsgICAzOC4zMzE4OTBdIENQVTogMCBQSUQ6IDQ3
IENvbW06IGt3b3JrZXIvdTg6MyBUYWludGVkOiBHICAgICAgRCAgICAgICAgIDQuNC4wLWRl
YnVnKyAjMgpbICAgMzguMzMxODkyXSBTZW5kaW5nIE5NSSB0byBhbGwgQ1BVczoKWyAgIDM4
LjMzMTg5NF0gSGFyZHdhcmUgbmFtZTogU0FNU1VORyBFWFlOT1MgKEZsYXR0ZW5lZCBEZXZp
Y2UgVHJlZSkKWyAgIDM4LjMzMTkwMl0gV29ya3F1ZXVlOiBldmVudHNfdW5ib3VuZCBjYWxs
X3VzZXJtb2RlaGVscGVyX2V4ZWNfd29yawpbICAgMzguMzMxOTA1XSBCYWNrdHJhY2U6IApb
ICAgMzguMzMxOTEzXSBbPGMwMDE0NzY4Pl0gKGR1bXBfYmFja3RyYWNlKSBmcm9tIFs8YzAw
MTQ5NjQ+XSAoc2hvd19zdGFjaysweDE4LzB4MWMpClsgICAzOC4zMzE5MjJdICByNjpjMDgx
YTgwYyByNTpjMDgxYTgwYyByNDowMDAwMDAwMCByMzpkYzhiYTYwMApbICAgMzguMzMxOTI4
XSBbPGMwMDE0OTRjPl0gKHNob3dfc3RhY2spIGZyb20gWzxjMDI3MWIzOD5dIChkdW1wX3N0
YWNrKzB4OGMvMHhjYykKWyAgIDM4LjMzMTkzM10gWzxjMDI3MWFhYz5dIChkdW1wX3N0YWNr
KSBmcm9tIFs8YzAwN2IwZDg+XSAoc3Bpbl9kdW1wKzB4ODQvMHhhNCkKWyAgIDM4LjMzMTk0
MV0gIHI2OjAyNzAwNjAwIHI1OmVlZjg3NDgwIHI0OmVlOWU4YmMwIHIzOjAwMDAwMDAwClsg
ICAzOC4zMzE5NDZdIFs8YzAwN2IwNTQ+XSAoc3Bpbl9kdW1wKSBmcm9tIFs8YzAwN2IyOTQ+
XSAoZG9fcmF3X3NwaW5fbG9jaysweDEwNC8weDFiOCkKWyAgIDM4LjMzMTk1MV0gIHI1OmMw
ODFhN2Y0IHI0OmVlZjg3NDgwClsgICAzOC4zMzE5NTddIFs8YzAwN2IxOTA+XSAoZG9fcmF3
X3NwaW5fbG9jaykgZnJvbSBbPGMwNWI1ZjJjPl0gKF9yYXdfc3Bpbl9sb2NrKzB4NGMvMHg1
NCkKWyAgIDM4LjMzMTk2Nl0gIHI5OmMwN2Y4NmJjIHI4OjQwMDAwMDUzIHI3OmVlMDhhNzAw
IHI2OmMwN2YzNDgwIHI1OmMwMDU1OTQ0IHI0OmVlZjg3NDgwClsgICAzOC4zMzE5NzJdIFs8
YzA1YjVlZTA+XSAoX3Jhd19zcGluX2xvY2spIGZyb20gWzxjMDA1NTk0ND5dICh3YWtlX3Vw
X25ld190YXNrKzB4ZjgvMHgzYzQpClsgICAzOC4zMzE5NzddICByNTplZWY4NzQ4MCByNDpl
ZTA4YTM0MApbICAgMzguMzMxOTgzXSBbPGMwMDU1ODRjPl0gKHdha2VfdXBfbmV3X3Rhc2sp
IGZyb20gWzxjMDAyODhiND5dIChfZG9fZm9yaysweDEzMC8weDdjNCkKWyAgIDM4LjMzMTk5
Ml0gIHIxMDowMDAwMDAwMSByOTplZTNhMjA4MCByODowMDAwMDAwMCByNzowMDAwMDM1YiBy
NjpjMDdmODQ0OCByNTowMDAwMDAwMApbICAgMzguMzMxOTk1XSAgcjQ6ZWUwOGEzNDAKWyAg
IDM4LjMzMTk5OV0gWzxjMDAyODc4ND5dIChfZG9fZm9yaykgZnJvbSBbPGMwMDI4ZmE4Pl0g
KGtlcm5lbF90aHJlYWQrMHgzOC8weDQwKQpbICAgMzguMzMyMDA4XSAgcjEwOjAwMDAwMDAx
IHI5OmMwODNiMjU4IHI4OmVlYTE3ZWE4IHI3OmVlODBjYzAwIHI2OmVlODBhYzAwIHI1OmVl
ODY3MjgwClsgICAzOC4zMzIwMTJdICByNDplZTM3ZmQwMApbICAgMzguMzMyMDE4XSBbPGMw
MDI4ZjcwPl0gKGtlcm5lbF90aHJlYWQpIGZyb20gWzxjMDA0MTgyND5dIChjYWxsX3VzZXJt
b2RlaGVscGVyX2V4ZWNfd29yaysweDM0LzB4YzQpClsgICAzOC4zMzIwMjRdIFs8YzAwNDE3
ZjA+XSAoY2FsbF91c2VybW9kZWhlbHBlcl9leGVjX3dvcmspIGZyb20gWzxjMDA0NTViYz5d
IChwcm9jZXNzX29uZV93b3JrKzB4MjBjLzB4NzRjKQpbICAgMzguMzMyMDI3XSAgcjQ6ZWUz
N2ZkMDAKWyAgIDM4LjMzMjAzMl0gWzxjMDA0NTNiMD5dIChwcm9jZXNzX29uZV93b3JrKSBm
cm9tIFs8YzAwNDViNGM+XSAod29ya2VyX3RocmVhZCsweDUwLzB4NGYwKQpbICAgMzguMzMy
MDQxXSAgcjEwOmVlODY3MjgwIHI5OjAwMDAwMDAwIHI4OmMwMDQ1YmM0IHI3OjAwMDAwMDg4
IHI2OmVlODBhYzMwIHI1OmVlODY3Mjk4ClsgICAzOC4zMzIwNDRdICByNDplZTgwYWMwMApb
ICAgMzguMzMyMDQ5XSBbPGMwMDQ1YWZjPl0gKHdvcmtlcl90aHJlYWQpIGZyb20gWzxjMDA0
YzNhYz5dIChrdGhyZWFkKzB4MTA4LzB4MTIwKQpbICAgMzguMzMyMDU4XSAgcjEwOjAwMDAw
MDAwIHI5OjAwMDAwMDAwIHI4OjAwMDAwMDAwIHI3OmMwMDQ1YWZjIHI2OmVlODY3MjgwIHI1
OmVlOGZlMDgwClsgICAzOC4zMzIwNjFdICByNDowMDAwMDAwMApbICAgMzguMzMyMDY2XSBb
PGMwMDRjMmE0Pl0gKGt0aHJlYWQpIGZyb20gWzxjMDAwZmViMD5dIChyZXRfZnJvbV9mb3Jr
KzB4MTQvMHgyNCkKWyAgIDM4LjMzMjA3M10gIHI3OjAwMDAwMDAwIHI2OjAwMDAwMDAwIHI1
OmMwMDRjMmE0IHI0OmVlOGZlMDgwClsgICAzOC43NjgyNDZdIENQVTogMiBQSUQ6IDI5IENv
bW06IGt3b3JrZXIvdTg6MSBUYWludGVkOiBHICAgICAgRCAgICAgICAgIDQuNC4wLWRlYnVn
KyAjMgpbICAgMzguNzc2MjMwXSBIYXJkd2FyZSBuYW1lOiBTQU1TVU5HIEVYWU5PUyAoRmxh
dHRlbmVkIERldmljZSBUcmVlKQpbICAgMzguNzgyMzExXSBCYWNrdHJhY2U6IApbICAgMzgu
Nzg0NzQyXSBbPGMwMDE0NzY4Pl0gKGR1bXBfYmFja3RyYWNlKSBmcm9tIFs8YzAwMTQ5NjQ+
XSAoc2hvd19zdGFjaysweDE4LzB4MWMpClsgICAzOC43OTIyODhdICByNjpjMDgxYTgwYyBy
NTpjMDgxYTgwYyByNDowMDAwMDAwMCByMzpkYzhiYTYwMApbICAgMzguNzk3OTMzXSBbPGMw
MDE0OTRjPl0gKHNob3dfc3RhY2spIGZyb20gWzxjMDI3MWIzOD5dIChkdW1wX3N0YWNrKzB4
OGMvMHhjYykKWyAgIDM4LjgwNTEzOF0gWzxjMDI3MWFhYz5dIChkdW1wX3N0YWNrKSBmcm9t
IFs8YzAwN2IwZDg+XSAoc3Bpbl9kdW1wKzB4ODQvMHhhNCkKWyAgIDM4LjgxMjI1Ml0gIHI2
OjAyNzAwNjAwIHI1OmVlZjg3NDgwIHI0OmVlOWU4YmMwIHIzOjAwMDAwMDAwClsgICAzOC44
MTc4OTddIFs8YzAwN2IwNTQ+XSAoc3Bpbl9kdW1wKSBmcm9tIFs8YzAwN2IyOTQ+XSAoZG9f
cmF3X3NwaW5fbG9jaysweDEwNC8weDFiOCkKWyAgIDM4LjgyNTcwNl0gIHI1OmMwODFhN2Y0
IHI0OmVlZjg3NDgwClsgICAzOC44MjkyNjldIFs8YzAwN2IxOTA+XSAoZG9fcmF3X3NwaW5f
bG9jaykgZnJvbSBbPGMwNWI2MTU4Pl0gKF9yYXdfc3Bpbl9sb2NrX2lycSsweDU0LzB4NWMp
ClsgICAzOC44Mzc2ODRdICByOTpjMDdmODZiYyByODowMDAwMDAwMiByNzpjMDA0Y2RlMCBy
NjpjMDdmMzQ4MCByNTpjMDVhZmM0MCByNDplZWY4NzQ4MApbICAgMzguODQ1NDEzXSBbPGMw
NWI2MTA0Pl0gKF9yYXdfc3Bpbl9sb2NrX2lycSkgZnJvbSBbPGMwNWFmYzQwPl0gKF9fc2No
ZWR1bGUrMHhkNC8weDk5NCkKWyAgIDM4Ljg1MzM5NV0gIHI1OmVlOWU4YmMwIHI0OmVlZjg3
NDgwClsgICAzOC44NTY5NTZdIFs8YzA1YWZiNmM+XSAoX19zY2hlZHVsZSkgZnJvbSBbPGMw
NWIwNzBjPl0gKHNjaGVkdWxlKzB4NTAvMHhiMCkKWyAgIDM4Ljg2Mzk4NF0gIHIxMDpjMDg0
MDJjNCByOTowMDAwMDAwMSByODpjMDA0Y2RkZSByNzpjMDA0Y2RlMCByNjowMDAwMDAwYiBy
NTowMDAwMDAwYgpbICAgMzguODcxNzk2XSAgcjQ6ZWVhMGMwMDAKWyAgIDM4Ljg3NDMxOV0g
WzxjMDViMDZiYz5dIChzY2hlZHVsZSkgZnJvbSBbPGMwMDJjYjRjPl0gKGRvX2V4aXQrMHg5
NDAvMHhiZTgpClsgICAzOC44ODEyNThdICByNDplZTllOGJjMCByMzplZTllOGJjMApbICAg
MzguODg0ODE5XSBbPGMwMDJjMjBjPl0gKGRvX2V4aXQpIGZyb20gWzxjMDAxNGRlMD5dIChk
aWUrMHg0NzgvMHg0OTApClsgICAzOC44OTEzMjZdICByNzpjMDA0Y2RlMApbICAgMzguODkz
ODUxXSBbPGMwMDE0OTY4Pl0gKGRpZSkgZnJvbSBbPGMwMDIzZWU0Pl0gKF9fZG9fa2VybmVs
X2ZhdWx0LnBhcnQuMCsweDZjLzB4MWVjKQpbICAgMzguOTAxNzQyXSAgcjEwOjAwMDAwMDAw
IHI5OmMwN2Y4NmJjIHI4OmZmZmZmZmQwIHI3OjAwMDAwMDAwIHI2OmVlYTBkYTE4IHI1OjAw
MDAwMDM3ClsgICAzOC45MDk1NTRdICByNDpmZmZmZmZkMApbICAgMzguOTEyMDc2XSBbPGMw
MDIzZTc4Pl0gKF9fZG9fa2VybmVsX2ZhdWx0LnBhcnQuMCkgZnJvbSBbPGMwMDFmOTZjPl0g
KGRvX3BhZ2VfZmF1bHQrMHgzOWMvMHgzYWMpClsgICAzOC45MjA5MjVdICByNzowMDAwMDAz
NyByMzplZWEwZGExOApbICAgMzguOTI0NDg2XSBbPGMwMDFmNWQwPl0gKGRvX3BhZ2VfZmF1
bHQpIGZyb20gWzxjMDAwOTM5MD5dIChkb19EYXRhQWJvcnQrMHg0MC8weGJjKQpbICAgMzgu
OTMyMTIyXSAgcjEwOjAwMDAwMDAwIHI5OmMwN2Y4NmJjIHI4OmVlYTBkYTE4IHI3OmZmZmZm
ZmQwIHI2OmMwMDFmNWQwIHI1OjAwMDAwMDM3ClsgICAzOC45Mzk5MzRdICByNDpjMDdmZDUy
NApbICAgMzguOTQyNDU0XSBbPGMwMDA5MzUwPl0gKGRvX0RhdGFBYm9ydCkgZnJvbSBbPGMw
MDE1NGE0Pl0gKF9fZGFidF9zdmMrMHg0NC8weDgwKQpbICAgMzguOTQ5ODMwXSBFeGNlcHRp
b24gc3RhY2soMHhlZWEwZGExOCB0byAweGVlYTBkYTYwKQpbICAgMzguOTU0ODY3XSBkYTAw
OiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBlZTllOGJjMCAwMDAwMDAwMgpbICAgMzguOTYzMDI3XSBkYTIwOiAwMDAwMDAwMCAwMDAw
MDAwMCAwMDAwMDAwMiBlZTllOGJjMCBjMDdmMzQ4MCBlZTllOGU4OCAwMDAwMDAwMiBjMDdm
ODZiYwpbICAgMzguOTcxMTg2XSBkYTQwOiAwMDAwMDAwMCBlZWEwZGE3NCBlZWEwZGE3OCBl
ZWEwZGE2OCBjMDA0NjliNCBjMDA0Y2RkYyAwMDAwMDFkMyBmZmZmZmZmZgpbICAgMzguOTc5
MzQxXSAgcjg6MDAwMDAwMDIgcjc6ZWVhMGRhNGMgcjY6ZmZmZmZmZmYgcjU6MDAwMDAxZDMg
cjQ6YzAwNGNkZGMKWyAgIDM4Ljk4NjAyOV0gWzxjMDA0Y2RjYz5dIChrdGhyZWFkX2RhdGEp
IGZyb20gWzxjMDA0NjliND5dICh3cV93b3JrZXJfc2xlZXBpbmcrMHgxNC8weGQ4KQpbICAg
MzguOTk0MTAwXSBbPGMwMDQ2OWEwPl0gKHdxX3dvcmtlcl9zbGVlcGluZykgZnJvbSBbPGMw
NWFmZmVjPl0gKF9fc2NoZWR1bGUrMHg0ODAvMHg5OTQpClsgICAzOS4wMDIxNzBdICByNTpl
ZTllOGJjMCByNDplZWY4NzQ4MApbICAgMzkuMDA1NzMxXSBbPGMwNWFmYjZjPl0gKF9fc2No
ZWR1bGUpIGZyb20gWzxjMDViMDcwYz5dIChzY2hlZHVsZSsweDUwLzB4YjApClsgICAzOS4w
MTI3NjBdICByMTA6MDAwMDAwMDAgcjk6ZWU4NzgwMDAgcjg6YzA0NThhNmEgcjc6ZWU5ZThk
ZTQgcjY6ZWVhMGRiMTAgcjU6ZWVhMGQ4ZDAKWyAgIDM5LjAyMDU3MV0gIHI0OmVlYTBjMDAw
ClsgICAzOS4wMjMwOTJdIFs8YzA1YjA2YmM+XSAoc2NoZWR1bGUpIGZyb20gWzxjMDAyYzk1
Yz5dIChkb19leGl0KzB4NzUwLzB4YmU4KQpbICAgMzkuMDMwMDMzXSAgcjQ6ZWU5ZThiYzAg
cjM6MDQyMDgwNmMKWyAgIDM5LjAzMzU5NF0gWzxjMDAyYzIwYz5dIChkb19leGl0KSBmcm9t
IFs8YzAwMTRkZTA+XSAoZGllKzB4NDc4LzB4NDkwKQpbICAgMzkuMDQwMTAyXSAgcjc6YzA0
NThhNmMKWyAgIDM5LjA0MjYyMl0gWzxjMDAxNDk2OD5dIChkaWUpIGZyb20gWzxjMDAyM2Vl
ND5dIChfX2RvX2tlcm5lbF9mYXVsdC5wYXJ0LjArMHg2Yy8weDFlYykKWyAgIDM5LjA1MDUx
N10gIHIxMDplZWJmNmMxMCByOTplZWZjYzhjNCByODpmZmZmZmZmYyByNzowMDAwMDAwMCBy
NjplZWEwZGNlMCByNTowMDAwMDAzNwpbICAgMzkuMDU4MzI5XSAgcjQ6ZmZmZmZmZmMKWyAg
IDM5LjA2MDg1Ml0gWzxjMDAyM2U3OD5dIChfX2RvX2tlcm5lbF9mYXVsdC5wYXJ0LjApIGZy
b20gWzxjMDAxZjk2Yz5dIChkb19wYWdlX2ZhdWx0KzB4MzljLzB4M2FjKQpbICAgMzkuMDY5
NzAwXSAgcjc6MDAwMDAwMzcgcjM6ZWVhMGRjZTAKWyAgIDM5LjA3MzI2Ml0gWzxjMDAxZjVk
MD5dIChkb19wYWdlX2ZhdWx0KSBmcm9tIFs8YzAwMDkzOTA+XSAoZG9fRGF0YUFib3J0KzB4
NDAvMHhiYykKWyAgIDM5LjA4MDg5OF0gIHIxMDplZWJmNmMxMCByOTplZWZjYzhjNCByODpl
ZWEwZGNlMCByNzpmZmZmZmZmYyByNjpjMDAxZjVkMCByNTowMDAwMDAzNwpbICAgMzkuMDg4
NzA5XSAgcjQ6YzA3ZmQ1MjQKWyAgIDM5LjA5MTIyOV0gWzxjMDAwOTM1MD5dIChkb19EYXRh
QWJvcnQpIGZyb20gWzxjMDAxNTRhND5dIChfX2RhYnRfc3ZjKzB4NDQvMHg4MCkKWyAgIDM5
LjA5ODYwNV0gRXhjZXB0aW9uIHN0YWNrKDB4ZWVhMGRjZTAgdG8gMHhlZWEwZGQyOCkKWyAg
IDM5LjEwMzY0M10gZGNlMDogYzA3NjE0MWMgZWViYTg0ODAgMDAwMDAwMDAgM2ZmZmZmZmYg
MTA2MjRkZDMgMDAwMDAwMDAgZWViZjZjMTAgZWViZjZjMDAKWyAgIDM5LjExMTgwMl0gZGQw
MDogZWU5NDY0ZDAgZWVmY2M4YzQgZWViZjZjMTAgZWVhMGRkN2MgZWVhMGRjYzAgZWVhMGRk
MzAgYzAwNzQ5ZGMgYzA0NThhNjgKWyAgIDM5LjExOTk1OF0gZGQyMDogNjAwMDAwNTMgZmZm
ZmZmZmYKWyAgIDM5LjEyMzQzMF0gIHI4OmVlOTQ2NGQwIHI3OmVlYTBkZDE0IHI2OmZmZmZm
ZmZmIHI1OjYwMDAwMDUzIHI0OmMwNDU4YTY4ClsgICAzOS4xMzAxMjddIFs8YzA0NTg4NDg+
XSAoZXh5bm9zX2J1c19wcm9iZSkgZnJvbSBbPGMwMzNkYzc4Pl0gKHBsYXRmb3JtX2Rydl9w
cm9iZSsweDU4LzB4YjQpClsgICAzOS4xMzg1MzNdICByMTA6MDAwMDAwMDEgcjk6YzA4M2Iy
NTggcjg6MDAwMDAwMDMgcjc6ZmZmZmZkZmIgcjY6YzA4MmU4MjAgcjU6ZWViZjZjMTAKWyAg
IDM5LjE0NjM0NV0gIHI0OmZmZmZmZmZlClsgICAzOS4xNDg4NjddIFs8YzAzM2RjMjA+XSAo
cGxhdGZvcm1fZHJ2X3Byb2JlKSBmcm9tIFs8YzAzM2JhZDQ+XSAoZHJpdmVyX3Byb2JlX2Rl
dmljZSsweDIxMC8weDMwNCkKWyAgIDM5LjE1NzcxNl0gIHI3OmMwODJlODIwIHI2OjAwMDAw
MDAwIHI1OmVlYmY2YzEwIHI0OmMxMDIwM2I0ClsgICAzOS4xNjMzNjBdIFs8YzAzM2I4YzQ+
XSAoZHJpdmVyX3Byb2JlX2RldmljZSkgZnJvbSBbPGMwMzNiZDMwPl0gKF9fZGV2aWNlX2F0
dGFjaF9kcml2ZXIrMHg4OC8weDk0KQpbICAgMzkuMTcyMzg1XSAgcjg6ZWVhMGRlYTggcjc6
MDAwMDAwMDEgcjY6ZWViZjZjMTAgcjU6ZWVhMGRlMTAgcjQ6YzA4MmU4MjAgcjM6MDAwMDAw
MDAKWyAgIDM5LjE4MDExNV0gWzxjMDMzYmNhOD5dIChfX2RldmljZV9hdHRhY2hfZHJpdmVy
KSBmcm9tIFs8YzAzMzlkY2M+XSAoYnVzX2Zvcl9lYWNoX2RydisweDZjLzB4YTApClsgICAz
OS4xODg4NzddICByNjpjMDMzYmNhOCByNTplZWEwZGUxMCByNDowMDAwMDAwMCByMzplZTJi
YmE2MApbICAgMzkuMTk0NTIxXSBbPGMwMzM5ZDYwPl0gKGJ1c19mb3JfZWFjaF9kcnYpIGZy
b20gWzxjMDMzYjgyMD5dIChfX2RldmljZV9hdHRhY2grMHhiMC8weDExMCkKWyAgIDM5LjIw
Mjc2NV0gIHI2OmVlYmY2YzQ0IHI1OmVlYmY2YzEwIHI0OmVlYmY2YzEwClsgICAzOS4yMDcz
NjhdIFs8YzAzM2I3NzA+XSAoX19kZXZpY2VfYXR0YWNoKSBmcm9tIFs8YzAzM2JlOGM+XSAo
ZGV2aWNlX2luaXRpYWxfcHJvYmUrMHgxNC8weDE4KQpbICAgMzkuMjE1ODcyXSAgcjc6ZWUy
MWFlMDAgcjY6YzA4MjM3YzggcjU6ZWViZjZjMTAgcjQ6ZWViZjZjMTAKWyAgIDM5LjIyMTUx
Nl0gWzxjMDMzYmU3OD5dIChkZXZpY2VfaW5pdGlhbF9wcm9iZSkgZnJvbSBbPGMwMzNhZTc4
Pl0gKGJ1c19wcm9iZV9kZXZpY2UrMHg5MC8weDk4KQpbICAgMzkuMjMwMTExXSBbPGMwMzNh
ZGU4Pl0gKGJ1c19wcm9iZV9kZXZpY2UpIGZyb20gWzxjMDMzYjJjOD5dIChkZWZlcnJlZF9w
cm9iZV93b3JrX2Z1bmMrMHg3MC8weGE0KQpbICAgMzkuMjM5MDQ3XSAgcjY6YzA4MjM0Y2Mg
cjU6YzA4MjM0ODggcjQ6ZWViZjZjMTAgcjM6MDAwMDAwMDAKWyAgIDM5LjI0NDY5Ml0gWzxj
MDMzYjI1OD5dIChkZWZlcnJlZF9wcm9iZV93b3JrX2Z1bmMpIGZyb20gWzxjMDA0NTViYz5d
IChwcm9jZXNzX29uZV93b3JrKzB4MjBjLzB4NzRjKQpbICAgMzkuMjUzODAzXSAgcjY6ZWU4
MGFjMDAgcjU6ZWU4NjcxMDAgcjQ6YzA4MjM1MDQgcjM6YzAzM2IyNTgKWyAgIDM5LjI1OTQ0
OF0gWzxjMDA0NTNiMD5dIChwcm9jZXNzX29uZV93b3JrKSBmcm9tIFs8YzAwNDViNGM+XSAo
d29ya2VyX3RocmVhZCsweDUwLzB4NGYwKQpbICAgMzkuMjY3NTE4XSAgcjEwOmVlODY3MTAw
IHI5OmVlODBhYzAwIHI4OmMwMDQ1YmM0IHI3OjAwMDAwMDg4IHI2OmVlODBhYzMwIHI1OmVl
ODY3MTE4ClsgICAzOS4yNzUzMzBdICByNDplZTgwYWMwMApbICAgMzkuMjc3ODUwXSBbPGMw
MDQ1YWZjPl0gKHdvcmtlcl90aHJlYWQpIGZyb20gWzxjMDA0YzNhYz5dIChrdGhyZWFkKzB4
MTA4LzB4MTIwKQpbICAgMzkuMjg1MjI1XSAgcjEwOjAwMDAwMDAwIHI5OjAwMDAwMDAwIHI4
OjAwMDAwMDAwIHI3OmMwMDQ1YWZjIHI2OmVlODY3MTAwIHI1OmVlOGZlMDQwClsgICAzOS4y
OTMwMzZdICByNDowMDAwMDAwMApbICAgMzkuMjk1NTU4XSBbPGMwMDRjMmE0Pl0gKGt0aHJl
YWQpIGZyb20gWzxjMDAwZmViMD5dIChyZXRfZnJvbV9mb3JrKzB4MTQvMHgyNCkKWyAgIDM5
LjMwMjc1OF0gIHI3OjAwMDAwMDAwIHI2OjAwMDAwMDAwIHI1OmMwMDRjMmE0IHI0OmVlOGZl
MDQwClsgICA0OC4zMzc3NDVdIE5NSSBiYWNrdHJhY2UgZm9yIGNwdSAxClsgICA0OC4zMzc4
MDddIENQVTogMSBQSUQ6IDAgQ29tbTogc3dhcHBlci8xIFRhaW50ZWQ6IEcgICAgICBEICAg
ICAgICAgNC40LjAtZGVidWcrICMyClsgICA0OC4zNDMyMjFdIEhhcmR3YXJlIG5hbWU6IFNB
TVNVTkcgRVhZTk9TIChGbGF0dGVuZWQgRGV2aWNlIFRyZWUpClsgICA0OC4zNDkyOTddIHRh
c2s6IGVlOGIwYmMwIHRpOiBlZThiODAwMCB0YXNrLnRpOiBlZThiODAwMApbICAgNDguMzU0
Njc5XSBQQyBpcyBhdCBhcmNoX2NwdV9pZGxlKzB4MmMvMHg0NApbICAgNDguMzU4OTMyXSBM
UiBpcyBhdCB0cmFjZV9oYXJkaXJxc19vbisweDE0LzB4MTgKWyAgIDQ4LjM2MzUzMl0gcGMg
OiBbPGMwMDEwOTY0Pl0gICAgbHIgOiBbPGMwMDc0OWRjPl0gICAgcHNyOiA2MDAwMDA1Mwpb
ICAgNDguMzY5NzgyXSBzcCA6IGVlOGI5Zjk4ICBpcCA6IGVlOGI5Zjg4ICBmcCA6IGVlOGI5
ZmE0ClsgICA0OC4zNzQ5OTBdIHIxMDogMDAwMDAwMDAgIHI5IDogMDAwMDAwMDAgIHI4IDog
YzA4M2E4MmUKWyAgIDQ4LjM4MDE5OV0gcjcgOiBjMDViOWVkMCAgcjYgOiBjMDgzYjdkMCAg
cjUgOiBjMDdmODUyMCAgcjQgOiBlZThiODAwMApbICAgNDguMzg2NzA4XSByMyA6IGMwMDIy
YzIwICByMiA6IDAwMDAwMDAwICByMSA6IDAwMDAwMDAwICByMCA6IGMwMDEwOTYwClsgICA0
OC4zOTMyMThdIEZsYWdzOiBuWkN2ICBJUlFzIG9uICBGSVFzIG9mZiAgTW9kZSBTVkNfMzIg
IElTQSBBUk0gIFNlZ21lbnQgbm9uZQpbICAgNDguNDAwNDIyXSBDb250cm9sOiAxMGM1Mzg3
ZCAgVGFibGU6IDQwMDA0MDRhICBEQUM6IDAwMDAwMDUxClsgICA0OC40MDYxNTFdIENQVTog
MSBQSUQ6IDAgQ29tbTogc3dhcHBlci8xIFRhaW50ZWQ6IEcgICAgICBEICAgICAgICAgNC40
LjAtZGVidWcrICMyClsgICA0OC40MTM3OTBdIEhhcmR3YXJlIG5hbWU6IFNBTVNVTkcgRVhZ
Tk9TIChGbGF0dGVuZWQgRGV2aWNlIFRyZWUpClsgICA0OC40MTk4NjVdIEJhY2t0cmFjZTog
ClsgICA0OC40MjIyOTZdIFs8YzAwMTQ3Njg+XSAoZHVtcF9iYWNrdHJhY2UpIGZyb20gWzxj
MDAxNDk2ND5dIChzaG93X3N0YWNrKzB4MTgvMHgxYykKWyAgIDQ4LjQyOTg0OF0gIHI2OmMw
ODFhODBjIHI1OmMwODFhODBjIHI0OjAwMDAwMDAwIHIzOmRjOGJhNjAwClsgICA0OC40MzU0
OTFdIFs8YzAwMTQ5NGM+XSAoc2hvd19zdGFjaykgZnJvbSBbPGMwMjcxYjM4Pl0gKGR1bXBf
c3RhY2srMHg4Yy8weGNjKQpbICAgNDguNDQyNjk1XSBbPGMwMjcxYWFjPl0gKGR1bXBfc3Rh
Y2spIGZyb20gWzxjMDAxMGJlYz5dIChzaG93X3JlZ3MrMHgxNC8weDE4KQpbICAgNDguNDQ5
ODExXSAgcjY6YzA3ZWYzZjAgcjU6MDAwMDAwMDEgcjQ6ZWU4YjlmNDggcjM6ZGM4YmE2MDAK
WyAgIDQ4LjQ1NTQ1NF0gWzxjMDAxMGJkOD5dIChzaG93X3JlZ3MpIGZyb20gWzxjMDI3Njc0
Yz5dIChubWlfY3B1X2JhY2t0cmFjZSsweGQ0LzB4MTFjKQpbICAgNDguNDYzMjY2XSBbPGMw
Mjc2Njc4Pl0gKG5taV9jcHVfYmFja3RyYWNlKSBmcm9tIFs8YzAwMTZlY2M+XSAoaGFuZGxl
X0lQSSsweDE0NC8weDNiNCkKWyAgIDQ4LjQ3MTI1MV0gIHI3OmVlOGI5ZjQ4IHI2OmMwN2Yw
NjRjIHI1OmMwN2YwNjRjIHI0OjAwMDAwMDBmClsgICA0OC40NzY4OTNdIFs8YzAwMTZkODg+
XSAoaGFuZGxlX0lQSSkgZnJvbSBbPGMwMDA5NTQ0Pl0gKGdpY19oYW5kbGVfaXJxKzB4OTgv
MHg5YykKWyAgIDQ4LjQ4NDQ0NV0gIHIxMDowMDAwMDAwMCByOTpmMDgyNTAwMCByODpmMDgy
NDAwMCByNzplZThiOWY0OCByNjpmMDgyNDAwYyByNTpjMDgxYWNmNApbICAgNDguNDkyMjU3
XSAgcjQ6YzA3Zjg4NDQKWyAgIDQ4LjQ5NDc3NF0gWzxjMDAwOTRhYz5dIChnaWNfaGFuZGxl
X2lycSkgZnJvbSBbPGMwMDE1NTM4Pl0gKF9faXJxX3N2YysweDU4LzB4OTgpClsgICA0OC41
MDIyMzldIEV4Y2VwdGlvbiBzdGFjaygweGVlOGI5ZjQ4IHRvIDB4ZWU4YjlmOTApClsgICA0
OC41MDcyNzRdIDlmNDA6ICAgICAgICAgICAgICAgICAgIGMwMDEwOTYwIDAwMDAwMDAwIDAw
MDAwMDAwIGMwMDIyYzIwIGVlOGI4MDAwIGMwN2Y4NTIwClsgICA0OC41MTU0MzNdIDlmNjA6
IGMwODNiN2QwIGMwNWI5ZWQwIGMwODNhODJlIDAwMDAwMDAwIDAwMDAwMDAwIGVlOGI5ZmE0
IGVlOGI5Zjg4IGVlOGI5Zjk4ClsgICA0OC41MjM1OTFdIDlmODA6IGMwMDc0OWRjIGMwMDEw
OTY0IDYwMDAwMDUzIGZmZmZmZmZmClsgICA0OC41Mjg2MjZdICByOTowMDAwMDAwMCByODpj
MDgzYTgyZSByNzplZThiOWY3YyByNjpmZmZmZmZmZiByNTo2MDAwMDA1MyByNDpjMDAxMDk2
NApbICAgNDguNTM2MzUxXSBbPGMwMDEwOTM4Pl0gKGFyY2hfY3B1X2lkbGUpIGZyb20gWzxj
MDA2ZTU3OD5dIChkZWZhdWx0X2lkbGVfY2FsbCsweDI4LzB4MzgpClsgICA0OC41NDQ0MjRd
IFs8YzAwNmU1NTA+XSAoZGVmYXVsdF9pZGxlX2NhbGwpIGZyb20gWzxjMDA2ZTlhOD5dIChj
cHVfc3RhcnR1cF9lbnRyeSsweDNjOC8weDQzNCkKWyAgIDQ4LjU1MzAxN10gWzxjMDA2ZTVl
MD5dIChjcHVfc3RhcnR1cF9lbnRyeSkgZnJvbSBbPGMwMDE2YjkwPl0gKHNlY29uZGFyeV9z
dGFydF9rZXJuZWwrMHhmNC8weGZjKQpbICAgNDguNTYxODcwXSAgcjc6YzA4NDAzMjgKWyAg
IDQ4LjU2NDM4OF0gWzxjMDAxNmE5Yz5dIChzZWNvbmRhcnlfc3RhcnRfa2VybmVsKSBmcm9t
IFs8NDAwMDk1ZWM+XSAoMHg0MDAwOTVlYykKWyAgIDQ4LjU3MTc2NV0gIHI1OjAwMDAwMDUx
IHI0OjZlODk0MDZhClsgICA0OC41NzUzMjZdIE5NSSBiYWNrdHJhY2UgZm9yIGNwdSAzClsg
ICA0OC41Nzg3OTddIENQVTogMyBQSUQ6IDYgQ29tbToga3dvcmtlci91ODowIFRhaW50ZWQ6
IEcgICAgICBEICAgICAgICAgNC40LjAtZGVidWcrICMyClsgICA0OC41ODY2OTVdIEhhcmR3
YXJlIG5hbWU6IFNBTVNVTkcgRVhZTk9TIChGbGF0dGVuZWQgRGV2aWNlIFRyZWUpClsgICA0
OC41OTI3NzFdIFdvcmtxdWV1ZTogZXZlbnRzX3VuYm91bmQgY2FsbF91c2VybW9kZWhlbHBl
cl9leGVjX3dvcmsKWyAgIDQ4LjU5OTAyMF0gQmFja3RyYWNlOiAKWyAgIDQ4LjYwMTQ1Ml0g
WzxjMDAxNDc2OD5dIChkdW1wX2JhY2t0cmFjZSkgZnJvbSBbPGMwMDE0OTY0Pl0gKHNob3df
c3RhY2srMHgxOC8weDFjKQpbICAgNDguNjA5MDAzXSAgcjY6YzA4MWE4MGMgcjU6YzA4MWE4
MGMgcjQ6MDAwMDAwMDAgcjM6ZGM4YmE2MDAKWyAgIDQ4LjYxNDY0NV0gWzxjMDAxNDk0Yz5d
IChzaG93X3N0YWNrKSBmcm9tIFs8YzAyNzFiMzg+XSAoZHVtcF9zdGFjaysweDhjLzB4Y2Mp
ClsgICA0OC42MjE4NDldIFs8YzAyNzFhYWM+XSAoZHVtcF9zdGFjaykgZnJvbSBbPGMwMjc2
NzkwPl0gKG5taV9jcHVfYmFja3RyYWNlKzB4MTE4LzB4MTFjKQpbICAgNDguNjI5ODM1XSAg
cjY6YzA3ZWYzZjAgcjU6MDAwMDAwMDMgcjQ6MDAwMDAwMDAgcjM6ZWU4YTQwMDAKWyAgIDQ4
LjYzNTQ3N10gWzxjMDI3NjY3OD5dIChubWlfY3B1X2JhY2t0cmFjZSkgZnJvbSBbPGMwMDE2
NzQ4Pl0gKHJhaXNlX25taSsweDVjLzB4NjApClsgICA0OC42NDMyMDJdICByNzpjMDdmODVh
MCByNjpjMDdmODZiYyByNTpjMDdmODgxOCByNDpjMDdmODgxOApbICAgNDguNjQ4ODQ1XSBb
PGMwMDE2NmVjPl0gKHJhaXNlX25taSkgZnJvbSBbPGMwMjc2NjZjPl0gKG5taV90cmlnZ2Vy
X2FsbF9jcHVfYmFja3RyYWNlKzB4MjljLzB4MmE4KQpbICAgNDguNjU3Nzg0XSAgcjQ6YzA3
ZjA2NTAgcjM6YzAwMTY2ZWMKWyAgIDQ4LjY2MTM0NF0gWzxjMDI3NjNkMD5dIChubWlfdHJp
Z2dlcl9hbGxfY3B1X2JhY2t0cmFjZSkgZnJvbSBbPGMwMDE3MjU4Pl0gKGFyY2hfdHJpZ2dl
cl9hbGxfY3B1X2JhY2t0cmFjZSsweDE4LzB4MWMpClsgICA0OC42NzE5MzNdICByMTA6MDAw
MDAwMDEgcjk6MDAwMDAwMDAgcjg6MDI3MDA2MDAgcjc6MDAwMDAwMDAgcjY6MDI3MDA2MDAg
cjU6YzA4MWE3ZjQKWyAgIDQ4LjY3OTc0NV0gIHI0OmVlZjg3NDgwClsgICA0OC42ODIyNjJd
IFs8YzAwMTcyNDA+XSAoYXJjaF90cmlnZ2VyX2FsbF9jcHVfYmFja3RyYWNlKSBmcm9tIFs8
YzAwN2IyOWM+XSAoZG9fcmF3X3NwaW5fbG9jaysweDEwYy8weDFiOCkKWyAgIDQ4LjY5MTg5
N10gWzxjMDA3YjE5MD5dIChkb19yYXdfc3Bpbl9sb2NrKSBmcm9tIFs8YzA1YjVmMmM+XSAo
X3Jhd19zcGluX2xvY2srMHg0Yy8weDU0KQpbICAgNDguNjk5OTY5XSAgcjk6YzA3Zjg2YmMg
cjg6NDAwMDAwNTMgcjc6ZWUxNjU2MDAgcjY6YzA3ZjM0ODAgcjU6YzAwNTU5NDQgcjQ6ZWVm
ODc0ODAKWyAgIDQ4LjcwNzY5NV0gWzxjMDViNWVlMD5dIChfcmF3X3NwaW5fbG9jaykgZnJv
bSBbPGMwMDU1OTQ0Pl0gKHdha2VfdXBfbmV3X3Rhc2srMHhmOC8weDNjNCkKWyAgIDQ4Ljcx
NTg1M10gIHI1OmVlZjg3NDgwIHI0OmVlMTY1MjQwClsgICA0OC43MTk0MTNdIFs8YzAwNTU4
NGM+XSAod2FrZV91cF9uZXdfdGFzaykgZnJvbSBbPGMwMDI4OGI0Pl0gKF9kb19mb3JrKzB4
MTMwLzB4N2M0KQpbICAgNDguNzI3MTM4XSAgcjEwOjAwMDAwMDAxIHI5OmVlYmM5M2MwIHI4
OjAwMDAwMDAwIHI3OjAwMDAwMzVhIHI2OmMwN2Y4NDQ4IHI1OjAwMDAwMDAwClsgICA0OC43
MzQ5NDldICByNDplZTE2NTI0MApbICAgNDguNzM3NDY3XSBbPGMwMDI4Nzg0Pl0gKF9kb19m
b3JrKSBmcm9tIFs8YzAwMjhmYTg+XSAoa2VybmVsX3RocmVhZCsweDM4LzB4NDApClsgICA0
OC43NDQ3NThdICByMTA6MDAwMDAwMDEgcjk6YzA4M2IyNTggcjg6ZWU4YTVlYTggcjc6ZWU4
MGNjMDAgcjY6ZWU4MGFjMDAgcjU6ZWU4NDlmODAKWyAgIDQ4Ljc1MjU3MF0gIHI0OmVlMzdm
YzgwClsgICA0OC43NTUwODddIFs8YzAwMjhmNzA+XSAoa2VybmVsX3RocmVhZCkgZnJvbSBb
PGMwMDQxODI0Pl0gKGNhbGxfdXNlcm1vZGVoZWxwZXJfZXhlY193b3JrKzB4MzQvMHhjNCkK
WyAgIDQ4Ljc2NDIwMV0gWzxjMDA0MTdmMD5dIChjYWxsX3VzZXJtb2RlaGVscGVyX2V4ZWNf
d29yaykgZnJvbSBbPGMwMDQ1NWJjPl0gKHByb2Nlc3Nfb25lX3dvcmsrMHgyMGMvMHg3NGMp
ClsgICA0OC43NzM3NDldICByNDplZTM3ZmM4MApbICAgNDguNzc2MjY4XSBbPGMwMDQ1M2Iw
Pl0gKHByb2Nlc3Nfb25lX3dvcmspIGZyb20gWzxjMDA0NWI0Yz5dICh3b3JrZXJfdGhyZWFk
KzB4NTAvMHg0ZjApClsgICA0OC43ODQzNDBdICByMTA6ZWU4NDlmODAgcjk6ZWU4MGFjMDAg
cjg6YzAwNDViYzQgcjc6MDAwMDAwODggcjY6ZWU4MGFjMzAgcjU6ZWU4NDlmOTgKWyAgIDQ4
Ljc5MjE1MF0gIHI0OmVlODBhYzAwClsgICA0OC43OTQ2NzBdIFs8YzAwNDVhZmM+XSAod29y
a2VyX3RocmVhZCkgZnJvbSBbPGMwMDRjM2FjPl0gKGt0aHJlYWQrMHgxMDgvMHgxMjApClsg
ICA0OC44MDIwNDZdICByMTA6MDAwMDAwMDAgcjk6MDAwMDAwMDAgcjg6MDAwMDAwMDAgcjc6
YzAwNDVhZmMgcjY6ZWU4NDlmODAgcjU6ZWU4NGI3MDAKWyAgIDQ4LjgwOTg1OF0gIHI0OjAw
MDAwMDAwClsgICA0OC44MTIzNzVdIFs8YzAwNGMyYTQ+XSAoa3RocmVhZCkgZnJvbSBbPGMw
MDBmZWIwPl0gKHJldF9mcm9tX2ZvcmsrMHgxNC8weDI0KQpbICAgNDguODE5NTc5XSAgcjc6
MDAwMDAwMDAgcjY6MDAwMDAwMDAgcjU6YzAwNGMyYTQgcjQ6ZWU4NGI3MDAK
--------------000202010808090108010705--
