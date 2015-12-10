From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 14/19] ARM: dts: Add bus nodes using VDD_INT for
 Exynos4x12
Date: Thu, 10 Dec 2015 15:43:53 +0900
Message-ID: <56691F29.1020808@samsung.com>
References: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
 <1449634091-1842-15-git-send-email-cw00.choi@samsung.com>
 <56691458.9000000@samsung.com> <566916E5.5060704@samsung.com>
 <56691C70.6080208@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <56691C70.6080208@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, myungjoo.ham@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2015=EB=85=84 12=EC=9B=94 10=EC=9D=BC 15:32, Krzysztof Kozlowski wro=
te:
> On 10.12.2015 15:08, Chanwoo Choi wrote:
>> On 2015=EB=85=84 12=EC=9B=94 10=EC=9D=BC 14:57, Krzysztof Kozlowski =
wrote:
>>> On 09.12.2015 13:08, Chanwoo Choi wrote:
>>>> This patch adds the bus noes using VDD_INT for Exynos4x12 SoC.
>>>> Exynos4x12 has the following AXI buses to translate data between
>>>> DRAM and sub-blocks.
>>>>
>>>> Following list specifies the detailed relation between DRAM and su=
b-blocks:
>>>> - ACLK100 clock for PERIL/PERIR/MFC(PCLK)
>>>> - ACLK160 clock for CAM/TV/LCD
>>>> : The minimum clock of ACLK160 should be over 160MHz.
>>>>   When drop the clock under 160MHz, show the broken image.
>>>> - ACLK133 clock for FSYS
>>>> - GDL clock for LEFTBUS
>>>> - GDR clock for RIGHTBUS
>>>> - SCLK_MFC clock for MFC
>>>>
>>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> ---
>>>>  arch/arm/boot/dts/exynos4x12.dtsi | 112 +++++++++++++++++++++++++=
+++++++++++++
>>>>  1 file changed, 112 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts=
/exynos4x12.dtsi
>>>> index 3bcf0939755e..8bc4aee156b5 100644
>>>> --- a/arch/arm/boot/dts/exynos4x12.dtsi
>>>> +++ b/arch/arm/boot/dts/exynos4x12.dtsi
>>>> @@ -354,6 +354,118 @@
>>>>  			opp-microvolt =3D <950000>;
>>>>  		};
>>>>  	};
>>>> +
>>>> +	bus_leftbus: bus_leftbus {
>>>> +		compatible =3D "samsung,exynos-bus";
>>>> +		clocks =3D <&clock CLK_DIV_GDL>;
>>>> +		clock-names =3D "bus";
>>>> +		operating-points-v2 =3D <&bus_leftbus_opp_table>;
>>>> +		status =3D "disabled";
>>>> +	};
>>>> +
>>>> +	bus_rightbus: bus_rightbus {
>>>> +		compatible =3D "samsung,exynos-bus";
>>>> +		clocks =3D <&clock CLK_DIV_GDR>;
>>>> +		clock-names =3D "bus";
>>>> +		operating-points-v2 =3D <&bus_leftbus_opp_table>;
>>>> +		status =3D "disabled";
>>>> +	};
>>>
>>> These two nodes are symmetrical. The MFC below and other buses in o=
ther
>>> DTS share opps. How about changing the binding so multiple clocks c=
ould
>>> be specified at once ("bus0", "bus1")? I think there is no need for=
 a
>>> bus device for each clock.
>>
>> The your commented method is possible.
>>
>> But, I focus on implementing the generic bus frequency driver.
>>
>> If specific bus device-tree node includes the one more clocks,
>> when adding the new Exynos SoC, the exynos-bus.c should be added
>> for new Exynos SoC. Because, each Exynos SoC has the different
>> set of bus device.
>>
>> If we use my approach, we don't need to modify the exynos-bus.c
>> driver to support for the bus frequency of new Exynos SoC.
>=20
> This won't change. The driver will just support from 1 to N clocks fo=
r
> given bus device and set the same OPP to all of them. This will only
> limit the number of duplicated entries. This won't affect the generic
> approach of driver itself.

You're right aspect of only implementation of device driver.

But,
If we use your commented approach, we can show the information
of only parent device through sysfs. We cannot see the information
of passive device. The some information includes the current
frequency and correlation of parent device. (But, current patchset
don' include the topology information between parent device and
passive device. I'll do it on later patches).

=46or example,=20
We can see the following bus device through /sys/class/devfreq.

drwxr-xr-x  2 root root 0 Dec 31 17:00 .
drwxr-xr-x 44 root root 0 Dec 31 17:00 ..
lrwxrwxrwx  1 root root 0 Dec 31 17:00 bus_display -> ../../devices/pla=
tform/bus_display/devfreq/bus_display
lrwxrwxrwx  1 root root 0 Dec 31 17:00 bus_fsys -> ../../devices/platfo=
rm/bus_fsys/devfreq/bus_fsys
lrwxrwxrwx  1 root root 0 Dec 31 17:00 bus_leftbus -> ../../devices/pla=
tform/bus_leftbus/devfreq/bus_leftbus
lrwxrwxrwx  1 root root 0 Dec 31 17:00 bus_peri -> ../../devices/platfo=
rm/bus_peri/devfreq/bus_peri


We don't see the following bus device because of following bus device
has the same frequency table with bus_leftbus device.
lrwxrwxrwx  1 root root 0 Dec 31 17:00 bus_mfc -> ../../devices/platfor=
m/bus_mfc/devfreq/bus_mfc
lrwxrwxrwx  1 root root 0 Dec 31 17:00 bus_rightbus -> ../../devices/pl=
atform/bus_rightbus/devfreq/bus_rightbus

Best Regards,
Chanwoo Choi
