From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v7 4/8] Documentation: bindings: add dt documentation for
 dfi controller
Date: Tue, 23 Aug 2016 14:23:11 +0900
Message-ID: <57BBDDBF.8040105@samsung.com>
References: <1471836984-6316-1-git-send-email-hl@rock-chips.com>
 <CGME20160822033904epcas1p1405876f336a41f2ba346ad68e665e3a0@epcas1p1.samsung.com>
 <1471836984-6316-5-git-send-email-hl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:49962 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752299AbcHWFXS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2016 01:23:18 -0400
In-reply-to: <1471836984-6316-5-git-send-email-hl@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lin Huang <hl@rock-chips.com>, heiko@sntech.de, myungjoo.ham@samsung.com
Cc: tixy@linaro.org, mark.rutland@arm.com, typ@rock-chips.com, linux-rockchip@lists.infradead.org, airlied@linux.ie, mturquette@baylibre.com, dbasehore@chromium.org, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, dianders@chromium.org, kyungmin.park@samsung.com, sudeep.holla@arm.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mark.yao@rock-chips.com

Hi Lin,

On 2016년 08월 22일 12:36, Lin Huang wrote:
> This patch adds the documentation for rockchip dfi devfreq-event driver.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v7:
> -None
> 
> Changes in v6:
> -None
> 
> Changes in v5:
> -None
> 
> Changes in v4:
> -None
> 
> Changes in v3:
> -None
> 
> Changes in v2:
> -None 
> 
> Changes in v1:
> -None
>  .../bindings/devfreq/event/rockchip-dfi.txt          | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt b/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
> new file mode 100644
> index 0000000..bf42255
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
> @@ -0,0 +1,20 @@
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
> +		rockchip,pmu = <&pmugrf>;
> +		clocks = <&cru PCLK_DDR_MON>;
> +		clock-names = "pclk_ddr_mon";
> +		status = "disabled";
> +	};
> +
> 

I reviewed this patch on previous version[1] already.
[1] https://lkml.org/lkml/2016/8/16/913

There are minor requirement. If you modify it,
I'll finish the review of this patch.

-- 
Best Regards,
Chanwoo Choi
