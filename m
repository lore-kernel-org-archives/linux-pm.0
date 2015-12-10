From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 03/19] ARM: dts: Add DMC bus node for Exynos3250
Date: Thu, 10 Dec 2015 10:09:10 +0900
Message-ID: <5668D0B6.1030902@samsung.com>
References: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
 <1449634091-1842-4-git-send-email-cw00.choi@samsung.com>
 <5668CADE.8090706@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <5668CADE.8090706@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, myungjoo.ham@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2015=EB=85=84 12=EC=9B=94 10=EC=9D=BC 09:44, Krzysztof Kozlowski wro=
te:
> On 09.12.2015 13:07, Chanwoo Choi wrote:
>> This patch adds the DMC (Dynamic Memory Controller) bus node for Exy=
nos3250 SoC.
>> The DMC is an AMBA AXI-compliant slave to interface external JEDEC s=
tandard
>> SDRAM devices. The bus includes the OPP tables and the source clock =
for DMC
>> block.
>>
>> Following list specifies the detailed relation between the clock and=
 DMC block:
>> - The source clock of DMC block : div_dmc
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos3250.dtsi | 34 ++++++++++++++++++++++++++++=
++++++
>>  1 file changed, 34 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/e=
xynos3250.dtsi
>> index 2f30d632f1cc..7214c5e42150 100644
>> --- a/arch/arm/boot/dts/exynos3250.dtsi
>> +++ b/arch/arm/boot/dts/exynos3250.dtsi
>> @@ -687,6 +687,40 @@
>>  			clock-names =3D "ppmu";
>>  			status =3D "disabled";
>>  		};
>> +
>> +		bus_dmc: bus_dmc {
>> +			compatible =3D "samsung,exynos-bus";
>> +			clocks =3D <&cmu_dmc CLK_DIV_DMC>;
>> +			clock-names =3D "bus";
>> +			operating-points-v2 =3D <&bus_dmc_opp_table>;
>> +			status =3D "disabled";
>> +		};
>> +
>> +		bus_dmc_opp_table: opp_table1 {
>=20
> This is the firsy opp_table, right? So:
> s/opp_table1/opp_table0/

Right. It is first opp_table in exynos3250.dtsi.
But, I'm considering the OPP table of CPU freqeuncy as opp_table0.
So, I have the plan that support the operation-points-v2 for Exynos3250=
 CPU.

>=20
>> +			compatible =3D "operating-points-v2";
>> +			opp-shared;
>> +
>> +			opp00 {
>> +				opp-hz =3D /bits/ 64 <50000000>;
>> +				opp-microvolt =3D <800000>;
>> +			};
>> +			opp01 {
>> +				opp-hz =3D /bits/ 64 <100000000>;
>> +				opp-microvolt =3D <800000>;
>> +			};
>> +			opp02 {
>> +				opp-hz =3D /bits/ 64 <134000000>;
>> +				opp-microvolt =3D <800000>;
>=20
> Why 134, not 133 MHz?

When I used the 133000000, the source clock is changed to 100Mhz instea=
d of 133MHz.
I add following test result on exynos3250-rinato board.

Case1.
When I use the 134 MHz, the source clock is changed to 133MHz
: exynos-bus soc:bus_dmc: old_freq(200000000) -> new_freq (134000000) (=
real: 133333334)

Case2.
When I use the 133 MHz, the source clock is changed to 100MHz
: exynos-bus soc:bus_dmc: old_freq(200000000) -> new_freq (133000000) (=
real: 100000000)

>=20
>> +			};
>> +			opp03 {
>> +				opp-hz =3D /bits/ 64 <200000000>;
>> +				opp-microvolt =3D <800000>;
>=20
> Shouldn't this be 825 mV, not 800? I think we used previously that va=
lue
> for our devices.

OK. I'll modify it.

Regards,
Chanwoo Choi
