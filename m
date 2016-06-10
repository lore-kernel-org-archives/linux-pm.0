From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 5/5] ARM: dts: qcom: pma8084: Add pwrkey entry
Date: Fri, 10 Jun 2016 13:29:14 -0700
Message-ID: <20160610202914.GQ1256@tuxbot>
References: <1463634020-17252-1-git-send-email-andy.gross@linaro.org>
 <1463634020-17252-6-git-send-email-andy.gross@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34809 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbcFJU3S (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2016 16:29:18 -0400
Received: by mail-pa0-f52.google.com with SMTP id bz2so26696014pad.1
        for <linux-pm@vger.kernel.org>; Fri, 10 Jun 2016 13:29:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1463634020-17252-6-git-send-email-andy.gross@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, stanimir.varbanov@linaro.org, linux-arm-kernel@lists.infradead.org

On Wed 18 May 22:00 PDT 2016, Andy Gross wrote:

> This patch adds the power key device tree node.
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  arch/arm/boot/dts/qcom-pma8084.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-pma8084.dtsi b/arch/arm/boot/dts/qcom-pma8084.dtsi
> index ea7fce3..82d2580 100644
> --- a/arch/arm/boot/dts/qcom-pma8084.dtsi
> +++ b/arch/arm/boot/dts/qcom-pma8084.dtsi
> @@ -18,6 +18,14 @@
>  			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
>  		};
>  
> +		pwrkey@800 {
> +			compatible = "qcom,pm8941-pwrkey";
> +			reg = <0x800>;
> +			interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
> +			debounce = <15625>;
> +			bias-pull-up;
> +		};
> +
>  		pma8084_gpios: gpios@c000 {
>  			compatible = "qcom,pma8084-gpio", "qcom,spmi-gpio";
>  			reg = <0xc000>;
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
