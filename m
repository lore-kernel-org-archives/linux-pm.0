From: kongxinwei <kong.kongxinwei@hisilicon.com>
Subject: Re: [PATCH 0/3] 96boards: add thermal senor support to hikey board
Date: Fri, 20 Mar 2015 11:10:16 +0800
Message-ID: <550B8F98.3070701@hisilicon.com>
References: <1426751849-10604-1-git-send-email-kong.kongxinwei@hisilicon.com> <20150319135946.GG18473@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150319135946.GG18473@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "rui.zhuang@intel.com" <rui.zhuang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linuxarm@huawei.com" <linuxarm@huawei.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "liguozhu@hisilicon.com" <liguozhu@hisilicon.com>, "xuwei5@hisilicon.com" <xuwei5@hisilicon.com>, jorge.ramirez-ortiz@linaro.org
List-Id: linux-pm@vger.kernel.org

hi Mark Rutland:

=E5=9C=A8 2015/3/19 21:59, Mark Rutland =E5=86=99=E9=81=93:
> On Thu, Mar 19, 2015 at 07:57:26AM +0000, kongxinwei wrote:
>> The Linaro connect introduce 96boards series in Hong Kong,The HiKey =
board
>> is the first board to be certified 96Boards Consumer Edition compati=
ble.
>> This board is based on the HiSilicon SoC. you can get more informati=
on
>> from https://www.96boards.org.
>>
>> The hisilicon SoC contains thermal module, this thermal module has 4=
 sensors,
>>
>> 	- sensor 0: local sensor;
>> 	- sensor 1: remote sensor for ACPU cluster 1;
>> 	- sensor 2: remote sensor for ACPU cluster 2;
>> 	- sensor 3: remote sensor for GPU;
>>
>> It can obtain this device temperature by operating this hardware. Th=
e new
>> sensor driver satisfies thermal framework and to realize the ACPU ,G=
PU and
>> so on to cool function.
>>
>> kongxinwei (3):
>>   thermal: hisilicon: add new hisilicon thermal sensor driver
>>   dts: hi6220: enable thermal sensor for hisilicon SoC
>>   dt-bindings: Document the hi6220 thermal sensor bindings
>>
>>  .../bindings/thermal/hisilicon-thermal.txt         |  51 ++
>>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi          | 153 ++++++
>>  drivers/thermal/Kconfig                            |   8 +
>>  drivers/thermal/Makefile                           |   1 +
>>  drivers/thermal/hisi_thermal.c                     | 531 ++++++++++=
+++++++++++
>=20
> Mainline does not have a hi6220 dtsi.
>=20
> Which tree is this against?
>=20
> What are your dependencies?
>=20
> Mark.
>=20
Hikey board code are being upstreamed by our team.If hi6220 dtsi be acc=
epted, this patch is ok.

Xinwei

> .
>=20
