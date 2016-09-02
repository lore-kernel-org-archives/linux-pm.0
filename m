From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/5] Documentation: bindings: add dt documentation for dfi
 controller
Date: Fri, 02 Sep 2016 17:50:54 +0900
Message-ID: <57C93D6E.8090600@samsung.com>
References: <1472769085-20715-1-git-send-email-hl@rock-chips.com>
 <CGME20160901223311epcas1p35e5c0ad56cd8604a8e48bd4edef8b13a@epcas1p3.samsung.com>
 <1472769085-20715-2-git-send-email-hl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1472769085-20715-2-git-send-email-hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org
Cc: myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, mark.yao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tixy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, typ-TNX95d0MmH7DzftRWevZcw@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 2016년 09월 02일 07:31, Lin Huang wrote:
> This patch adds the documentation for rockchip dfi devfreq-event driver.
> 
> Signed-off-by: Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> Changes in v8:
> - delete a unuse blank line
> 
> Changes in v7:
> - None
> 
> Changes in v6:
> - None
> 
> Changes in v5:
> - None
> 
> Changes in v4:
> - None
> 
> Changes in v3:
> - None
> 
> Changes in v2:
> - None 
> 
> Changes in v1:
> - None
> 
>  .../bindings/devfreq/event/rockchip-dfi.txt           | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt b/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
> new file mode 100644
> index 0000000..d66aca6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
> @@ -0,0 +1,19 @@
> +
> +* Rockchip rk3399 DFI device
> +
> +Required properties:
> +- compatible: Must be "rockchip,rk3399-dfi".
> +- reg: physical base address of each DFI and length of memory mapped region
> +- rockchip,pmu: phandle to the syscon managing the "pmu general register files"
> +- clocks: phandles for clock specified in "clock-names" property
> +- clock-names : the name of clock used by the DFI, must be "pclk_ddr_mon";
> +
> +Example:
> +	dfi: dfi@0xff630000 {
> +		reg = <0x00 0xff630000 0x00 0x4000>;
> +		compatible = "rockchip,rk3399-dfi";

As I already commented, you need to reorder between compatible and reg property.

> +		rockchip,pmu = <&pmugrf>;
> +		clocks = <&cru PCLK_DDR_MON>;
> +		clock-names = "pclk_ddr_mon";
> +		status = "disabled";
> +	};
> 


-- 
Best Regards,
Chanwoo Choi
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
