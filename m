From: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 0/5] thermal: rockchip: add tsadc support in thermal
 driver and IPA thermal control for rk3328 in dts
Date: Fri, 11 Aug 2017 12:51:35 +0800
Message-ID: <1502427095.2598.21.camel@intel.com>
References: <1501833976-1100-1-git-send-email-rocky.hao@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1501833976-1100-1-git-send-email-rocky.hao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rocky Hao <rocky.hao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org, william.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xxx-TNX95d0MmH7DzftRWevZcw@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2017-08-04 at 16:06 +0800, Rocky Hao wrote:
> This series patches add the tsadc support in thermal driver and in
> devicetree for rk3328.
> Also add thermal control with Intelligent Power Allocation (IPA)
> policy by default.  Please
> refer to https://developer.arm.com/open-source/intelligent-power-allo
> cation for more information
> about IPA.
> 
> Rocky Hao (5):
>   dt-bindings: rockchip-thermal: Support the RK3328 SoC compatible
>   thermal: rockchip: Support the RK3328 SOC in thermal driver
>   arm64: dts: rockchip: add tsadc node for rk3328 SoC
>   arm64: dts: rockchip: add thermal nodes for rk3328 SoC
>   arm64: dts: rockchip: Enable tsadc module on RK3328 eavluation
> board
> 
I can take this patch set if we have ACK for patch 3, 4 and 5.

thanks,
rui
>  .../bindings/thermal/rockchip-thermal.txt          |  1 +
>  arch/arm64/boot/dts/rockchip/rk3328-evb.dts        |  4 ++
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi           | 63
> +++++++++++++++++++++
>  drivers/thermal/rockchip_thermal.c                 | 65
> ++++++++++++++++++++++
>  4 files changed, 133 insertions(+)
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
