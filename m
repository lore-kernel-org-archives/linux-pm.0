From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 3/7] ARM: dts: Add NoC Probe dt node for Exynos542x SoC
Date: Thu, 14 Apr 2016 14:48:22 +0900
Message-ID: <570F2F26.9030408@samsung.com>
References: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
 <1460091646-28701-4-git-send-email-cw00.choi@samsung.com>
 <570CAE67.4020001@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <570CAE67.4020001@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, kgene@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2016=EB=85=84 04=EC=9B=94 12=EC=9D=BC 17:14, Krzysztof Kozlowski wro=
te:
> On 04/08/2016 07:00 AM, Chanwoo Choi wrote:
>> This patch adds the NoCP (Network on Chip Probe) Device Tree node
>> to measure the bandwidth of memory and g3d in Exynos542x SoC.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos5420.dtsi | 36 ++++++++++++++++++++++++++++=
++++++++
>>  1 file changed, 36 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/e=
xynos5420.dtsi
>> index 7b99cb58d82d..d80f3b66f017 100644
>> --- a/arch/arm/boot/dts/exynos5420.dtsi
>> +++ b/arch/arm/boot/dts/exynos5420.dtsi
>> @@ -294,6 +294,42 @@
>>  		};
>>  	};
>> =20
>> +	nocp_mem0_0: nocp_mem0_0@10CA1000 {
>=20
> The node name should describe general class of device, so:
>=20
> 	nocp_mem0_0: nocp@10CA1000 {
> 		...
> 	}
> ?

I'll modify it.

>=20
>> +		compatible =3D "samsung,exynos5420-nocp";
>> +		reg =3D <0x10CA1000 0x200>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	nocp_mem0_1: nocp_mem0_1@10CA1400 {
>> +		compatible =3D "samsung,exynos5420-nocp";
>> +		reg =3D <0x10CA1400 0x200>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	nocp_mem0_2: nocp_mem0_2@10CA1800 {
>=20
> Shouldn't it be nocp_mem1_0?

I was mistaken. I'll fix it.

>=20
>> +		compatible =3D "samsung,exynos5420-nocp";
>> +		reg =3D <0x10CA1800 0x200>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	nocp_mem0_3: nocp_mem0_3@10CA1C00 {
>=20
> Shouldn't it be nocp_mem1_1?

ditto.

Best Regards,
Chanwoo Choi
