From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 01/20] PM / devfreq: exynos: Add generic exynos bus
 frequency driver
Date: Mon, 14 Dec 2015 16:14:01 +0900
Message-ID: <566E6C39.6080703@samsung.com>
References: <1449810479-14763-1-git-send-email-cw00.choi@samsung.com>
 <1449810479-14763-2-git-send-email-cw00.choi@samsung.com>
 <566A80D5.2070703@samsung.com> <566A834C.3040103@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <566A834C.3040103@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, myungjoo.ham@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof and Myungjoo,

On 2015=EB=85=84 12=EC=9B=94 11=EC=9D=BC 17:03, Krzysztof Kozlowski wro=
te:
> On 11.12.2015 16:52, Chanwoo Choi wrote:
>> Dear MyungJoo,
>>
>> Almost device tree patches in this series are reviewed by Exynos mai=
ntainer.
>> Could you please review this series?
>=20
> Are there any objections to merging DT patches through Samsung-soc?
>=20
> Looking at the code, there are no dependencies between DT and drivers=
,
> right?

Yes.
There is no dependency between exynos-bus.c patches and DT patches.
If the design concept of exynos-bus.c don't be changed,
there is no problem to merge the DT patches to samsung-soc tree.

Best Regards,
Chanwoo Choi

>=20
> Best regards,
> Krzysztof
>=20
>>
>> Best Regards,
>> Chanwoo Choi
>>
>> On 2015=EB=85=84 12=EC=9B=94 11=EC=9D=BC 14:07, Chanwoo Choi wrote:
>>> This patch adds the generic exynos bus frequency driver for AMBA AX=
I bus
>>> of sub-blocks in exynos SoC with DEVFREQ framework. The Samsung Exy=
nos SoC
>>> have the common architecture for bus between DRAM and sub-blocks in=
 SoC.
>>> This driver can support the generic bus frequency driver for Exynos=
 SoCs.
>>>
>>> In devicetree, Each bus block has a bus clock, regulator, operation=
-point
>>> and devfreq-event devices which measure the utilization of each bus=
 block.
>>>
>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> [linux.amoon: Tested on Odroid U3]
>>> Tested-by: Anand Moon <linux.amoon@gmail.com>
>>> ---
>>>  drivers/devfreq/Kconfig             |  15 ++
>>>  drivers/devfreq/Makefile            |   1 +
>>>  drivers/devfreq/exynos/Makefile     |   1 +
>>>  drivers/devfreq/exynos/exynos-bus.c | 449 ++++++++++++++++++++++++=
++++++++++++
>>>  4 files changed, 466 insertions(+)
>>>  create mode 100644 drivers/devfreq/exynos/exynos-bus.c
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsu=
ng-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
