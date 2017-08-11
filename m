From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 0/5] thermal: rockchip: add tsadc support in thermal driver and IPA thermal control for rk3328 in dts
Date: Fri, 11 Aug 2017 08:27:43 +0200
Message-ID: <3025917.NAhhjSz36M@phil>
References: <1501833976-1100-1-git-send-email-rocky.hao@rock-chips.com> <1502427095.2598.21.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:46308 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750909AbdHKG2G (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Aug 2017 02:28:06 -0400
In-Reply-To: <1502427095.2598.21.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Rocky Hao <rocky.hao@rock-chips.com>, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, shawn.lin@rock-chips.com, cl@rock-chips.com, william.wu@rock-chips.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, xxx@rock-chips.com, jay.xu@rock-chips.com, wxt@rock-chips.com, huangtao@rock-chips.com

Hi,

Am Freitag, 11. August 2017, 12:51:35 CEST schrieb Zhang Rui:
> On Fri, 2017-08-04 at 16:06 +0800, Rocky Hao wrote:
> > This series patches add the tsadc support in thermal driver and in
> > devicetree for rk3328.
> > Also add thermal control with Intelligent Power Allocation (IPA)
> > policy by default.  Please
> > refer to https://developer.arm.com/open-source/intelligent-power-allo
> > cation for more information
> > about IPA.
> > 
> > Rocky Hao (5):
> >   dt-bindings: rockchip-thermal: Support the RK3328 SoC compatible
> >   thermal: rockchip: Support the RK3328 SOC in thermal driver
> >   arm64: dts: rockchip: add tsadc node for rk3328 SoC
> >   arm64: dts: rockchip: add thermal nodes for rk3328 SoC
> >   arm64: dts: rockchip: Enable tsadc module on RK3328 eavluation
> > board
> > 
> I can take this patch set if we have ACK for patch 3, 4 and 5.

I would prefer if you would just apply patches 1+2 alone and I'd take
the devicetree patches through my tree.

Having devicetree stuff mingle in a lot of trees produces unnecessary
conflicts, so the general best practice is having code + binding.txt
going through the driver tree and devicetree stuff through the platform
tree.


Thanks
Heiko
