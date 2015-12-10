From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 14/19] ARM: dts: Add bus nodes using VDD_INT for
 Exynos4x12
Date: Thu, 10 Dec 2015 16:12:13 +0900
Message-ID: <566925CD.4040205@samsung.com>
References: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
 <1449634091-1842-15-git-send-email-cw00.choi@samsung.com>
 <56691458.9000000@samsung.com> <566916E5.5060704@samsung.com>
 <56691C70.6080208@samsung.com> <56691F29.1020808@samsung.com>
 <5669215A.70104@samsung.com> <566924BA.2080103@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <566924BA.2080103@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10.12.2015 16:07, Chanwoo Choi wrote:
> On 2015=EB=85=84 12=EC=9B=94 10=EC=9D=BC 15:53, Krzysztof Kozlowski w=
rote:
>> On 10.12.2015 15:43, Chanwoo Choi wrote:
>>> On 2015=EB=85=84 12=EC=9B=94 10=EC=9D=BC 15:32, Krzysztof Kozlowski=
 wrote:
>>>> On 10.12.2015 15:08, Chanwoo Choi wrote:
>>>>> On 2015=EB=85=84 12=EC=9B=94 10=EC=9D=BC 14:57, Krzysztof Kozlows=
ki wrote:
>>>>>> On 09.12.2015 13:08, Chanwoo Choi wrote:
>>>>>>> This patch adds the bus noes using VDD_INT for Exynos4x12 SoC.
>>>>>>> Exynos4x12 has the following AXI buses to translate data betwee=
n
>>>>>>> DRAM and sub-blocks.
>>>>>>>
>>>>>>> Following list specifies the detailed relation between DRAM and=
 sub-blocks:
>>>>>>> - ACLK100 clock for PERIL/PERIR/MFC(PCLK)
>>>>>>> - ACLK160 clock for CAM/TV/LCD
>>>>>>> : The minimum clock of ACLK160 should be over 160MHz.
>>>>>>>   When drop the clock under 160MHz, show the broken image.
>>>>>>> - ACLK133 clock for FSYS
>>>>>>> - GDL clock for LEFTBUS
>>>>>>> - GDR clock for RIGHTBUS
>>>>>>> - SCLK_MFC clock for MFC
>>>>>>>
>>>>>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>>>>> ---
>>>>>>>  arch/arm/boot/dts/exynos4x12.dtsi | 112 ++++++++++++++++++++++=
++++++++++++++++
>>>>>>>  1 file changed, 112 insertions(+)
>>>>>>>
>>>>>>> diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/=
dts/exynos4x12.dtsi
>>>>>>> index 3bcf0939755e..8bc4aee156b5 100644
>>>>>>> --- a/arch/arm/boot/dts/exynos4x12.dtsi
>>>>>>> +++ b/arch/arm/boot/dts/exynos4x12.dtsi
>>>>>>> @@ -354,6 +354,118 @@
>>>>>>>  			opp-microvolt =3D <950000>;
>>>>>>>  		};
>>>>>>>  	};
>>>>>>> +
>>>>>>> +	bus_leftbus: bus_leftbus {
>>>>>>> +		compatible =3D "samsung,exynos-bus";
>>>>>>> +		clocks =3D <&clock CLK_DIV_GDL>;
>>>>>>> +		clock-names =3D "bus";
>>>>>>> +		operating-points-v2 =3D <&bus_leftbus_opp_table>;
>>>>>>> +		status =3D "disabled";
>>>>>>> +	};
>>>>>>> +
>>>>>>> +	bus_rightbus: bus_rightbus {
>>>>>>> +		compatible =3D "samsung,exynos-bus";
>>>>>>> +		clocks =3D <&clock CLK_DIV_GDR>;
>>>>>>> +		clock-names =3D "bus";
>>>>>>> +		operating-points-v2 =3D <&bus_leftbus_opp_table>;
>>>>>>> +		status =3D "disabled";
>>>>>>> +	};
>>>>>>
>>>>>> These two nodes are symmetrical. The MFC below and other buses i=
n other
>>>>>> DTS share opps. How about changing the binding so multiple clock=
s could
>>>>>> be specified at once ("bus0", "bus1")? I think there is no need =
for a
>>>>>> bus device for each clock.
>>>>>
>>>>> The your commented method is possible.
>>>>>
>>>>> But, I focus on implementing the generic bus frequency driver.
>>>>>
>>>>> If specific bus device-tree node includes the one more clocks,
>>>>> when adding the new Exynos SoC, the exynos-bus.c should be added
>>>>> for new Exynos SoC. Because, each Exynos SoC has the different
>>>>> set of bus device.
>>>>>
>>>>> If we use my approach, we don't need to modify the exynos-bus.c
>>>>> driver to support for the bus frequency of new Exynos SoC.
>>>>
>>>> This won't change. The driver will just support from 1 to N clocks=
 for
>>>> given bus device and set the same OPP to all of them. This will on=
ly
>>>> limit the number of duplicated entries. This won't affect the gene=
ric
>>>> approach of driver itself.
>>>
>>> You're right aspect of only implementation of device driver.
>>>
>>> But,
>>> If we use your commented approach, we can show the information
>>> of only parent device through sysfs. We cannot see the information
>>> of passive device. The some information includes the current
>>> frequency and correlation of parent device. (But, current patchset
>>> don' include the topology information between parent device and
>>> passive device. I'll do it on later patches).
>>>
>>> For example,=20
>>> We can see the following bus device through /sys/class/devfreq.
>>>
>>> drwxr-xr-x  2 root root 0 Dec 31 17:00 .
>>> drwxr-xr-x 44 root root 0 Dec 31 17:00 ..
>>> lrwxrwxrwx  1 root root 0 Dec 31 17:00 bus_display -> ../../devices=
/platform/bus_display/devfreq/bus_display
>>> lrwxrwxrwx  1 root root 0 Dec 31 17:00 bus_fsys -> ../../devices/pl=
atform/bus_fsys/devfreq/bus_fsys
>>> lrwxrwxrwx  1 root root 0 Dec 31 17:00 bus_leftbus -> ../../devices=
/platform/bus_leftbus/devfreq/bus_leftbus
>>> lrwxrwxrwx  1 root root 0 Dec 31 17:00 bus_peri -> ../../devices/pl=
atform/bus_peri/devfreq/bus_peri
>>>
>>>
>>> We don't see the following bus device because of following bus devi=
ce
>>> has the same frequency table with bus_leftbus device.
>>> lrwxrwxrwx  1 root root 0 Dec 31 17:00 bus_mfc -> ../../devices/pla=
tform/bus_mfc/devfreq/bus_mfc
>>> lrwxrwxrwx  1 root root 0 Dec 31 17:00 bus_rightbus -> ../../device=
s/platform/bus_rightbus/devfreq/bus_rightbus
>>
>> Right, but why do you want to see these bus devices? AFAIU, they wil=
l
>=20
> I think that the framework should show the accurate information of H/=
w device
> through sysfs. On the exynos-bus.c driver, it is important the show t=
he
> accurate set of handled bus devices which are included in Exynos SoC.
>=20
>> always behave exactly the same as LEFTBUS. Their PPMU counters will =
be
>> the same... or not? The MFC does not have its own PPMU counter. Ther=
e
>> are separate counters for left and right bus... but they are attache=
d to
>> the "&bus_leftbus" node. The "&bus_rightbus" does not use the PPMU
>> counter and it follows the parent governor decisions... so this is
>> purely an artificial creation just to handle one clock.
>>
>> I just can't see the benefit of such additional bus device.
>=20
> I agree about the behavior. Your description is right.
> There is no difference and benefit about behavior both your and my ap=
proach.
>=20
> But, We can provide the accurate information of handled bus devices
> to the user-space. I think that it is important information.
>=20
> Also, I have the plan that devfreq framework would show
> the topology about the correlation of bus devices as following:

Hmmm.... okay, fair enough. From hardware point of view these are
separate AXI buses so I guess it is good to model them in DT.

Best regards,
Krzysztof
