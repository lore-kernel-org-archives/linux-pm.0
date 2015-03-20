From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 0/3] 96boards: add thermal senor support to hikey board
Date: Fri, 20 Mar 2015 14:13:22 +0800
Message-ID: <20150320061322.GD18907@leoy-linaro>
References: <1426751849-10604-1-git-send-email-kong.kongxinwei@hisilicon.com>
 <20150319135946.GG18473@leverpostej>
 <550B8F98.3070701@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:32879 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbbCTGN2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2015 02:13:28 -0400
Received: by pdnc3 with SMTP id c3so99271171pdn.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2015 23:13:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <550B8F98.3070701@hisilicon.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kongxinwei <kong.kongxinwei@hisilicon.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linuxarm@huawei.com" <linuxarm@huawei.com>, "xuwei5@hisilicon.com" <xuwei5@hisilicon.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "edubezval@gmail.com" <edubezval@gmail.com>, jorge.ramirez-ortiz@linaro.org, "rui.zhuang@intel.com" <rui.zhuang@intel.com>, "liguozhu@hisilicon.com" <liguozhu@hisilicon.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Mar 20, 2015 at 11:10:16AM +0800, kongxinwei wrote:
> hi Mark Rutland:
>=20
> =E5=9C=A8 2015/3/19 21:59, Mark Rutland =E5=86=99=E9=81=93:
> > On Thu, Mar 19, 2015 at 07:57:26AM +0000, kongxinwei wrote:
> >> The Linaro connect introduce 96boards series in Hong Kong,The HiKe=
y board
> >> is the first board to be certified 96Boards Consumer Edition compa=
tible.
> >> This board is based on the HiSilicon SoC. you can get more informa=
tion
> >> from https://www.96boards.org.
> >>
> >> The hisilicon SoC contains thermal module, this thermal module has=
 4 sensors,
> >>
> >> 	- sensor 0: local sensor;
> >> 	- sensor 1: remote sensor for ACPU cluster 1;
> >> 	- sensor 2: remote sensor for ACPU cluster 2;
> >> 	- sensor 3: remote sensor for GPU;
> >>
> >> It can obtain this device temperature by operating this hardware. =
The new
> >> sensor driver satisfies thermal framework and to realize the ACPU =
,GPU and
> >> so on to cool function.
> >>
> >> kongxinwei (3):
> >>   thermal: hisilicon: add new hisilicon thermal sensor driver
> >>   dts: hi6220: enable thermal sensor for hisilicon SoC
> >>   dt-bindings: Document the hi6220 thermal sensor bindings
> >>
> >>  .../bindings/thermal/hisilicon-thermal.txt         |  51 ++
> >>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi          | 153 ++++++
> >>  drivers/thermal/Kconfig                            |   8 +
> >>  drivers/thermal/Makefile                           |   1 +
> >>  drivers/thermal/hisi_thermal.c                     | 531 ++++++++=
+++++++++++++
> >=20
> > Mainline does not have a hi6220 dtsi.
> >=20
> > Which tree is this against?
> >=20
> > What are your dependencies?
> >=20
> > Mark.
> >=20
> Hikey board code are being upstreamed by our team.If hi6220 dtsi be a=
ccepted, this patch is ok.

Xinwei, u could resend this patch after hi6220 dtsi related patches has
been merged. Suggest this patchset are only for thermal driver.

Thanks,
Leo Yan
