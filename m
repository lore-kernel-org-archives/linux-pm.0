From: kongxinwei <kong.kongxinwei@hisilicon.com>
Subject: Re: [PATCH 0/3] 96boards: add thermal senor support to hikey board
Date: Fri, 20 Mar 2015 15:41:37 +0800
Message-ID: <550BCF31.2000009@hisilicon.com>
References: <1426751849-10604-1-git-send-email-kong.kongxinwei@hisilicon.com> <20150319135946.GG18473@leverpostej> <550B8F98.3070701@hisilicon.com> <20150320061322.GD18907@leoy-linaro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150320061322.GD18907@leoy-linaro>
Sender: linux-kernel-owner@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linuxarm@huawei.com" <linuxarm@huawei.com>, "xuwei5@hisilicon.com" <xuwei5@hisilicon.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "edubezval@gmail.com" <edubezval@gmail.com>, jorge.ramirez-ortiz@linaro.org, "rui.zhuang@intel.com" <rui.zhuang@intel.com>, "liguozhu@hisilicon.com" <liguozhu@hisilicon.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org



=E5=9C=A8 2015/3/20 14:13, Leo Yan =E5=86=99=E9=81=93:
> On Fri, Mar 20, 2015 at 11:10:16AM +0800, kongxinwei wrote:
>> hi Mark Rutland:
>>
>> =E5=9C=A8 2015/3/19 21:59, Mark Rutland =E5=86=99=E9=81=93:
>>> On Thu, Mar 19, 2015 at 07:57:26AM +0000, kongxinwei wrote:
>>>> The Linaro connect introduce 96boards series in Hong Kong,The HiKe=
y board
>>>> is the first board to be certified 96Boards Consumer Edition compa=
tible.
>>>> This board is based on the HiSilicon SoC. you can get more informa=
tion
>>>> from https://www.96boards.org.
>>>>
>>>> The hisilicon SoC contains thermal module, this thermal module has=
 4 sensors,
>>>>
>>>> 	- sensor 0: local sensor;
>>>> 	- sensor 1: remote sensor for ACPU cluster 1;
>>>> 	- sensor 2: remote sensor for ACPU cluster 2;
>>>> 	- sensor 3: remote sensor for GPU;
>>>>
>>>> It can obtain this device temperature by operating this hardware. =
The new
>>>> sensor driver satisfies thermal framework and to realize the ACPU =
,GPU and
>>>> so on to cool function.
>>>>
>>>> kongxinwei (3):
>>>>   thermal: hisilicon: add new hisilicon thermal sensor driver
>>>>   dts: hi6220: enable thermal sensor for hisilicon SoC
>>>>   dt-bindings: Document the hi6220 thermal sensor bindings
>>>>
>>>>  .../bindings/thermal/hisilicon-thermal.txt         |  51 ++
>>>>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi          | 153 ++++++
>>>>  drivers/thermal/Kconfig                            |   8 +
>>>>  drivers/thermal/Makefile                           |   1 +
>>>>  drivers/thermal/hisi_thermal.c                     | 531 ++++++++=
+++++++++++++
>>>
>>> Mainline does not have a hi6220 dtsi.
>>>
>>> Which tree is this against?
>>>
>>> What are your dependencies?
>>>
>>> Mark.
>>>
>> Hikey board code are being upstreamed by our team.If hi6220 dtsi be =
accepted, this patch is ok.
>=20
> Xinwei, u could resend this patch after hi6220 dtsi related patches h=
as
> been merged. Suggest this patchset are only for thermal driver.
>=20
> Thanks,
> Leo Yan
>=20

Oh,i wish that many persons review it and give some comments, then i wi=
ll
send v2 patch and reduce dts file.

Thanks,
Xin Wei
> .
>=20
