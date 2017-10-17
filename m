From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 0/5] thermal: rockchip: add tsadc support in thermal
 driver and IPA thermal control for RV1108 in dts
Date: Mon, 16 Oct 2017 17:15:37 -0700
Message-ID: <20171017001535.GA16006@localhost.localdomain>
References: <1503570475-7850-1-git-send-email-rocky.hao@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1503570475-7850-1-git-send-email-rocky.hao@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rocky Hao <rocky.hao@rock-chips.com>
Cc: rui.zhang@intel.com, heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, shawn.lin@rock-chips.com, cl@rock-chips.com, william.wu@rock-chips.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, xxx@rock-chips.com, jay.xu@rock-chips.com, wxt@rock-chips.com, huangtao@rock-chips.com
List-Id: linux-pm@vger.kernel.org

Hello,

On Thu, Aug 24, 2017 at 06:27:50PM +0800, Rocky Hao wrote:
> This series patches add the tsadc support in thermal driver and in devicetree for RV1108.
> Also add thermal control with Intelligent Power Allocation (IPA) policy by default.  Please
> refer to https://developer.arm.com/open-source/intelligent-power-allocation for more information
> about IPA.
> 
> Rocky Hao (5):
>   dt-bindings: rockchip-thermal: Support the RV1108 SoC compatible
>   thermal: rockchip: Support the RV1108 SoC in thermal driver

Applied patches 1  and 2.

>   arm: dts: rockchip: add tsadc node for RV1108 SoC
>   arm: dts: rockchip: add thermal nodes for RV1108 SoC
>   arm: dts: rockchip: enable tsadc module on RV1108 evaluation board
> 

Acked-by: Eduardo Valentin <edubezval@gmail.com>

for the DT changes.

>  .../bindings/thermal/rockchip-thermal.txt          |  1 +
>  arch/arm/boot/dts/rv1108-evb.dts                   |  4 ++
>  arch/arm/boot/dts/rv1108.dtsi                      | 69 ++++++++++++++++++++++
>  drivers/thermal/rockchip_thermal.c                 | 67 +++++++++++++++++++++
>  4 files changed, 141 insertions(+)
> 
> -- 
> 1.9.1
> 
> 
