From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [RFC PATCH 09/15] PM / devfreq: exynos: Update documentation for
 bus devices using passive governor
Date: Wed, 02 Dec 2015 10:41:47 +0900
Message-ID: <565E4C5B.7040000@samsung.com>
References: <1448545659-32287-1-git-send-email-cw00.choi@samsung.com>
 <1448545659-32287-10-git-send-email-cw00.choi@samsung.com>
 <20151130211453.GA29423@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20151130211453.GA29423@rob-hp-laptop>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, kgene@kernel.org, k.kozlowski@samsung.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Rob,

I'm sorry for delay reply due to the problem of email system
on the company.

On 2015=EB=85=84 12=EC=9B=94 01=EC=9D=BC 06:14, Rob Herring wrote:
> On Thu, Nov 26, 2015 at 10:47:33PM +0900, Chanwoo Choi wrote:
>> This patch updates the documentation for passive bus devices and add=
s the
>> detailed example of Exynos3250.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  .../devicetree/bindings/devfreq/exynos-bus.txt     | 226 ++++++++++=
++++++++++-
>>  1 file changed, 223 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.tx=
t b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>> index 5d90623bd173..c4a6fe30075e 100644
>> --- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>> +++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>> @@ -12,18 +12,23 @@ SoC has the different sub-blocks. So, this diffe=
rence should be specified
>>  in devicetree file instead of each device driver. In result, this d=
river
>>  is able to support the bus frequency for all Exynos SoCs.
>> =20
>> -Required properties for bus device:
>> +Required properties for all bus devices:
>>  - compatible: Should be "samsung,exynos-bus".
>>  - clock-names : the name of clock used by the bus, "bus".
>>  - clocks : phandles for clock specified in "clock-names" property.
>>  - #clock-cells: should be 1.
>>  - operating-points-v2: the OPP table including frequency/voltage in=
formation
>>    to support DVFS (Dynamic Voltage/Frequency Scaling) feature.
>> +
>> +Required properties for only parent bus device:
>>  - vdd-supply: the regulator to provide the buses with the voltage.
>>  - devfreq-events: the devfreq-event device to monitor the curret ut=
ilization
>>    of buses.
>> =20
>> -Optional properties for bus device:
>> +Required properties for only passive bus device:
>> +- devfreq: the parent bus device.
>> +
>> +Optional properties for only parent bus device:
>>  - exynos,saturation-ratio: the percentage value which is used to ca=
librate
>>                     the performance count againt total cycle count.
>> =20
>> @@ -32,7 +37,19 @@ Example1:
>>  	power line (regulator). The MIF (Memory Interface) AXI bus is used=
 to
>>  	transfer data between DRAM and CPU and uses the VDD_MIF regualtor.
>> =20
>> -	- power line(VDD_MIF) --> bus for DMC block (dmc clock)
>> +	- MIF (Memory Interface) block
>> +	: VDD_MIF |--- DMC
>> +
>> +	- INT (Internal) block
>> +	: VDD_INT |--- LEFTBUS  |--- PERIL
>> +		  |    (parent) |--- MFC
>> +		  |             |--- G3D
>> +		  |
>> +		  |--- RIGHTBUS |--- FSYS
>> +				|--- LCD0
>> +				|--- PERIR
>> +				|--- ISP
>> +				|--- CAM
>=20
> I would expect the DT to mirror this topology which doesn't seem to b=
e=20
> the case in the example.

You're right. The above topology is not appropriate to show the correla=
tion
between power line and sub blocks. I'll modify it as following.

The all blocks which are included in the INT (internal) block
share the one power line (VDD_INT).


	VDD_MIF |--- DMC

	VDD_INT |--- LEFTBUS
		|--- PERIL
		|--- MFC
		|--- G3D
		|--- RIGHTBUS
		|--- FSYS
		|--- LCD0
		|--- PERIR
		|--- ISP
		|--- CAM

>=20
>=20
>>  	- MIF bus's frequency/voltage table
>>  	-----------------------
>> @@ -45,6 +62,20 @@ Example1:
>>  	|L5| 400000 |875000   |
>>  	-----------------------
>> =20
>> +	- INT bus's frequency/voltage table
>> +	------------------------------------------------------------------=
-----
>> +	|Lv| Freq                                                   | Volt=
age |
>> +	------------------------------------------------------------------=
-----
>> +	|  |LEFTBUS|RIGHTBUS|LCD0   |FSYS   |MCUISP |ISP    |PERIL  |VDD_I=
NT  |
>> +	|  |*parent|passive |passive|passive|passive|passive|passive|     =
    |
>> +	------------------------------------------------------------------=
-----
>> +	|L1|50000  |50000   |50000  |50000  |50000  |50000  |50000  |90000=
0   |
>> +	|L2|80000  |80000   |80000  |80000  |80000  |80000  |80000  |90000=
0   |
>> +	|L3|100000 |100000  |100000 |100000 |100000 |100000 |100000 |10000=
00  |
>> +	|L4|133000 |133000  |133000 |133000 |200000 |200000 |       |10000=
00  |
>> +	|L5|200000 |200000  |200000 |200000 |400000 |300000 |       |10000=
00  |
>> +	------------------------------------------------------------------=
-----
>=20
> Do you really have 5 states? It look like there are 2 to me because t=
he=20
> OPP tables only really need to have the max freq at each voltage poin=
t.=20

I'm sure. The OPP allow OPP table to add the same voltage for each OPP =
entry.
Instead, OPP don't permit adding the duplicate frequency. If OPP table =
includes
the different frequency as OPP entry, there is no problem. It is tested=
=2E

Regards,
Chanwoo Choi
