From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5 00/11] Add HW throttle for Tegra soctherm
Date: Wed, 31 Aug 2016 11:07:14 +0800
Message-ID: <57C649E2.30608@nvidia.com>
References: <1462962026-19653-1-git-send-email-wni@nvidia.com>   <5746C4FD.9070909@nvidia.com> <1471590924.2691.34.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471590924.2691.34.camel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 08/19/2016 03:15 PM, Zhang Rui wrote:
> On 四, 2016-05-26 at 17:42 +0800, Wei Ni wrote:
>> Hi,
>> Does there have any comments on this series?
>> Let me know if someone has suggestions.
>>
> I have no objections to this patch set.
> As 10 patches out of 11, in this patch series, contain changes out of
> thermal scope, if you prefer this patch set go through thermal tree, I
> still need ACKs for the changes out of thermal scope.

Rui, thanks for your comments.

Thierry & Matt could you ACK this series ?

Thanks.
Wei.

> 
> thanks,
> rui
> 
>> Thanks.
>> Wei.
>>
>> On 05/11/2016 06:20 PM, Wei Ni wrote:
>>>
>>> This series add following functions for Tegra soctherm:
>>> 1. add HW throttle function.
>>> 2. enable soctherm node for Tegra124, Tegra132, Tegra210, and
>>> set "critical", "hot" trips for them.
>>>
>>> Main changes from v4:
>>> 1. drop the "nvidia" prefix from the node name, per Rob's comments.
>>>
>>> Main changes from v3:
>>> 1. change some properties'name and descriptions, per Rob's
>>> comments.
>>> 2. change the corresponding driver codes.
>>>
>>> Main changes from v2:
>>> 1. improve the of-binding, per Eduardo's comments, and
>>> change the corresponding driver codes.
>>> 2. move two setting critical trip patches in this series,
>>> 3. fix some bugs in dts changes.
>>>
>>> Main changes from v1:
>>> 1. use readl/writel instead of __raw_readl/__raw_writel.
>>> 2. rebase on the linux-next.
>>>
>>> The v1 series is in:
>>> https://lkml.org/lkml/2016/3/31/230
>>>
>>> The v2 series is in:
>>> https://lkml.org/lkml/2016/4/26/1577
>>>
>>> The v3 series is in:
>>> https://lkml.org/lkml/2016/5/3/274
>>>
>>> The v4 series is in:
>>> https://lkml.org/lkml/2016/5/9/45
>>>
>>> Wei Ni (11):
>>>   of: Add bindings of hw throttle for Tegra soctherm
>>>   thermal: tegra: add hw-throttle function
>>>   thermal: tegra: add hw-throttle for Tegra132
>>>   arm: tegra: set critical trips for Tegra124
>>>   arm: tegra: set hot trips for Tegra124
>>>   arm64: tegra: use tegra132-soctherm for Tegra132
>>>   arm64: tegra: set critical trips for Tegra132
>>>   arm64: tegra: set hot trips for Tegra132
>>>   arm64: tegra: add soctherm node for Tegra210
>>>   arm64: tegra: set critical trips for Tegra210
>>>   arm64: tegra: set hot trips for Tegra210
>>>
>>>  .../bindings/thermal/nvidia,tegra124-soctherm.txt  | 121 ++-
>>>  arch/arm/boot/dts/tegra124-jetson-tk1.dts          |  18 +-
>>>  arch/arm/boot/dts/tegra124.dtsi                    |  83 +-
>>>  arch/arm64/boot/dts/nvidia/tegra132.dtsi           | 119 ++-
>>>  arch/arm64/boot/dts/nvidia/tegra210.dtsi           | 127 ++++
>>>  drivers/thermal/tegra/soctherm.c                   | 842
>>> ++++++++++++++++++++-
>>>  drivers/thermal/tegra/soctherm.h                   |  10 +
>>>  drivers/thermal/tegra/tegra124-soctherm.c          |  18 +
>>>  drivers/thermal/tegra/tegra132-soctherm.c          |  18 +
>>>  drivers/thermal/tegra/tegra210-soctherm.c          |  18 +
>>>  include/dt-bindings/thermal/tegra124-soctherm.h    |   5 +
>>>  11 files changed, 1344 insertions(+), 35 deletions(-)
>>>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
