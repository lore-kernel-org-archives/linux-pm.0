From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v5 11/11] arm64: dts: msm8996: Add thermal zones, tsens
 and qfprom nodes
Date: Wed, 27 Apr 2016 17:03:47 -0700
Message-ID: <20160428000346.GE2590@localhost.localdomain>
References: <1460626319-14516-1-git-send-email-rnayak@codeaurora.org>
 <1460626319-14516-12-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33637 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbcD1ADv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2016 20:03:51 -0400
Content-Disposition: inline
In-Reply-To: <1460626319-14516-12-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rui.zhang@intel.com, sboyd@codeaurora.org, nrajan@codeaurora.org, lina.iyer@linaro.org, punit.agrawal@arm.com, Andy Gross <agross@codeaurora.org>

On Thu, Apr 14, 2016 at 03:01:59PM +0530, Rajendra Nayak wrote:
> Add thermal zones, tsens and qfprom nodes
> 
> Cc: Andy Gross <agross@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 92 +++++++++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 0506fb8..4b36929 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -97,6 +97,92 @@
>  		};
>  	};
>  
> +	thermal-zones {
> +		cpu-thermal0 {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 3>;
> +
> +			trips {
> +				cpu_alert0: trip@0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit0: trip@1 {
> +					temperature = <110000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};


cooling devices?
