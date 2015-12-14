From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v4 02/20] PM / devfreq: exynos: Add documentation for
 generic exynos bus frequency driver
Date: Mon, 14 Dec 2015 17:47:18 +0900
Message-ID: <566E8216.4020601@samsung.com>
References: <1393132421.659011450082398931.JavaMail.weblogic@epmlwas07b>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1393132421.659011450082398931.JavaMail.weblogic@epmlwas07b>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, =?UTF-8?B?7YGs7Ims7Iuc7Yag7ZSE?= <k.kozlowski@samsung.com>, "kgene@kernel.org" <kgene@kernel.org>
Cc: =?UTF-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "tjakobi@math.uni-bielefeld.de" <tjakobi@math.uni-bielefeld.de>, "linux.amoon@gmail.com" <linux.amoon@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2015=EB=85=84 12=EC=9B=94 14=EC=9D=BC 17:40, MyungJoo Ham wrote:
>>  =20
>>  This patch adds the documentation for generic exynos bus frequency
>> driver.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>=20
> A little changes following:
>=20
>> ---
>>  .../devicetree/bindings/devfreq/exynos-bus.txt     | 93 +++++++++++=
+++++++++++
>>  1 file changed, 93 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/devfreq/exynos=
-bus.txt
>>
>> diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.tx=
t b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>> new file mode 100644
>> index 000000000000..e32daef328da
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>> @@ -0,0 +1,93 @@
>> +* Generic Exynos Bus frequency device
>> +
>> +The Samsung Exynos SoC have many buses for data transfer between DR=
AM
>=20
> +The Samsung Exynos SoC has many buses for data transfer between DRAM
>=20
> or
>=20
> +The Samsung Exynos SoCs have many buses for data transfer between DR=
AM
> (because you intend to support mulitple Exynos SoCs)
>=20
>> +and sub-blocks in SoC. Almost Exynos SoC have the common architectu=
re
>=20
> +and sub-blocks in SoC. Most Exynos SoCs share the common architectur=
e
>=20
>> +for buses. Generally, the each bus of Exynos SoC includes the sourc=
e clock
>=20
> +for buses. Generally, each bus of Exynos SoC includes a source clock
>=20
>> +and power line and then is able to change the clock according to th=
e usage
>=20
> +and a power line, which are able to change the clock frequency=20
>=20
>> +of each buses on runtime. When gathering the usage of each buses on=
 runtime,
>=20
> +of the bus in runtime. To monitor the usage of each bus in runtime,
>=20
>> +the driver uses the PPMU (Platform Performance Monitoring Unit) whi=
ch
>=20
> +the driver uses the PPMU (Platform Performance Monitoring Unit), whi=
ch
>=20
>> +is able to measure the current load of sub-blocks.
>> +
>> +There are a little different composition among Exynos SoC because e=
ach Exynos
>> +SoC has the different sub-blocks. So, this difference should be spe=
cified
>=20
> +SoC has different sub-blocks. Therefore, such difference should be s=
pecified
>=20
>> +in devicetree file instead of each device driver. In result, this d=
river
>> +is able to support the bus frequency for all Exynos SoCs.
>> +

Okay. I'll modify it.

Regards,
Chanwoo Choi
