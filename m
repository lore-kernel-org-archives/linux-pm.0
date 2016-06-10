From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 3/5] arm64: dts: msm8916: Add spc compat tag
Date: Fri, 10 Jun 2016 16:48:57 +0100
Message-ID: <20160610154857.GA6430@leverpostej>
References: <1463634020-17252-1-git-send-email-andy.gross@linaro.org>
 <1463634020-17252-4-git-send-email-andy.gross@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39295 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932214AbcFJPtX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 10 Jun 2016 11:49:23 -0400
Content-Disposition: inline
In-Reply-To: <1463634020-17252-4-git-send-email-andy.gross@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stanimir.varbanov@linaro.org, lorenzo.pieralisi@arm.com

[+ Lorenzo]

On Thu, May 19, 2016 at 12:00:18AM -0500, Andy Gross wrote:
> This patch adds the qcom,idle-state-spc compatible to the SPC idle
> state.  This compatible indicates that the state is one which supports
> freeze.
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 208af00..032e411 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -104,7 +104,7 @@
>  
>  		idle-states {
>  			CPU_SPC: spc {
> -				compatible = "arm,idle-state";
> +				compatible = "qcom,idle-state-spc", "arm,idle-state";
>  				arm,psci-suspend-param = <0x40000002>;
>  				entry-latency-us = <130>;
>  				exit-latency-us = <150>;

This looks suspicious.

This is a PSCI idle state, and we have a PSCI driver driven by the
generic ARM cpuidle driver.

Why do we need a qcom-specific compatible here?

Surely we should be able to use the idle code in a generic fashion to
driver suspend-to-idle?

Thank,
Mark.
