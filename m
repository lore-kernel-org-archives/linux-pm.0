From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 02/19] PM / devfreq: exynos: Add documentation for
 generic exynos bus frequency driver
Date: Thu, 10 Dec 2015 09:49:59 +0900
Message-ID: <5668CC37.1090300@samsung.com>
References: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
 <1449634091-1842-3-git-send-email-cw00.choi@samsung.com>
 <5668C9BE.7050900@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <5668C9BE.7050900-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org, linux.amoon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 2015=EB=85=84 12=EC=9B=94 10=EC=9D=BC 09:39, Krzysztof Kozlowski wro=
te:
> On 09.12.2015 13:07, Chanwoo Choi wrote:
>> This patch adds the documentation for generic exynos bus frequency
>> driver.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> ---
>>  .../devicetree/bindings/devfreq/exynos-bus.txt     | 94 +++++++++++=
+++++++++++
>>  1 file changed, 94 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/devfreq/exynos=
-bus.txt
>>
>> diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.tx=
t b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>> new file mode 100644
>> index 000000000000..54a1f9c46c88
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>> @@ -0,0 +1,94 @@
>> +* Generic Exynos Bus frequency device
>> +
>> +The Samsung Exynos SoC have many buses for data transfer between DR=
AM
>> +and sub-blocks in SoC. Almost Exynos SoC have the common architectu=
re
>> +for buses. Generally, the each bus of Exynos SoC includes the sourc=
e clock
>> +and power line and then is able to change the clock according to th=
e usage
>> +of each buses on runtime. When gathering the usage of each buses on=
 runtime,
>> +thie driver uses the PPMU (Platform Performance Monitoring Unit) wh=
ich
>=20
> s/thie/the/

OK.

>=20
>> +is able to measure the current load of sub-blocks.
>> +
>> +There are a little different composition among Exynos SoC because e=
ach Exynos
>> +SoC has the different sub-blocks. So, this difference should be spe=
cified
>> +in devicetree file instead of each device driver. In result, this d=
river
>> +is able to support the bus frequency for all Exynos SoCs.
>> +
>> +Required properties for bus device:
>> +- compatible: Should be "samsung,exynos-bus".
>> +- clock-names : the name of clock used by the bus, "bus".
>> +- clocks : phandles for clock specified in "clock-names" property.
>> +- #clock-cells: should be 1.
>=20
> This is a clock consumer, right? So the clock-cells is not valid here=
=2E

You're right. I'll remove '#clock-cells'.

>=20
>> +- operating-points-v2: the OPP table including frequency/voltage in=
formation
>> +  to support DVFS (Dynamic Voltage/Frequency Scaling) feature.
>> +- vdd-supply: the regulator to provide the buses with the voltage.
>> +- devfreq-events: the devfreq-event device to monitor the curret ut=
ilization
>=20
> s/curret/current/
>=20
>> +  of buses.
>> +
>> +Optional properties for bus device:
>> +- exynos,saturation-ratio: the percentage value which is used to ca=
librate
>> +                   the performance count againt total cycle count.
>=20
> s/againt/against/

OK.

>=20
>> +
>> +Example1:
>> +	Show the AXI buses of Exynos3250 SoC. Exynos3250 divides the buses=
 to
>> +	power line (regulator). The MIF (Memory Interface) AXI bus is used=
 to
>> +	transfer data between DRAM and CPU and uses the VDD_MIF regualtor.
>> +
>> +	- power line(VDD_MIF) --> bus for DMC (Dynamic Memory Controller) =
block
>> +
>> +	- MIF bus's frequency/voltage table
>> +	-----------------------
>> +	|Lv| Freq   | Voltage |
>> +	-----------------------
>> +	|L1| 50000  |800000   |
>> +	|L2| 100000 |800000   |
>> +	|L3| 134000 |800000   |
>> +	|L4| 200000 |800000   |
>> +	|L5| 400000 |875000   |
>> +	-----------------------
>> +
>> +Example2 :
>> +	The bus of DMC (Dynamic Memory Controller) block in exynos3250.dts=
i
>> +	are listed below:
>=20
> s/are/is/ (one bus is listed)

OK.

>=20
>> +
>> +	bus_dmc: bus_dmc {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&cmu_dmc CLK_DIV_DMC>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_dmc_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_dmc_opp_table: opp_table0 {
>> +		compatible =3D "operating-points-v2";
>> +		opp-shared;
>> +
>> +		opp00 {
>=20
> Maybe use convention with frequency, like:
> 	opp@50000000
> This also used in opp.txt examples.

In the Documentations/devicetree/bindings/opp/opp.txt,
the example uses the 'opp@0x'. I check the opp.txt of Linux 4.4-rc4.

>=20
>=20
>> +			opp-hz =3D /bits/ 64 <50000000>;
>> +			opp-microvolt =3D <800000>;
>> +		};
>> +		opp01 {
>> +			opp-hz =3D /bits/ 64 <100000000>;
>> +			opp-microvolt =3D <800000>;
>> +		};
>> +		opp02 {
>> +			opp-hz =3D /bits/ 64 <134000000>;
>> +			opp-microvolt =3D <800000>;
>> +		};
>> +		opp03 {
>> +			opp-hz =3D /bits/ 64 <200000000>;
>> +			opp-microvolt =3D <800000>;
>> +		};
>> +		opp04 {
>> +			opp-hz =3D /bits/ 64 <400000000>;
>> +			opp-microvolt =3D <875000>;
>> +		};
>> +	};
>> +
>> +	Usage case to handle the frequency and voltage of bus on runtime
>> +	in exynos3250-rinato.dts are listed below:
>=20
> s/are/is/

OK.

>=20
>> +
>> +	&bus_dmc {
>> +		devfreq-events =3D <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
>> +		vdd-supply =3D <&buck1_reg>;	/* VDD_MIF */
>> +		status =3D "okay";
>> +	};

Thanks for your review.

Regards,
Chanwoo Choi

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
