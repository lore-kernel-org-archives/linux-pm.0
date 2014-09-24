From: Pramod Gurav <pramod.gurav@smartplayin.com>
Subject: Re: [PATCH v6 2/5] arm: dts: qcom: Add SPM device bindings for 8974
Date: Wed, 24 Sep 2014 11:48:06 +0530
Message-ID: <5422621E.2050509@smartplayin.com>
References: <1411516281-58328-1-git-send-email-lina.iyer@linaro.org> <1411516281-58328-3-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp85.ord1c.emailsrvr.com ([108.166.43.85]:42747 "EHLO
	smtp85.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750744AbaIXGOp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Sep 2014 02:14:45 -0400
In-Reply-To: <1411516281-58328-3-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: galak@codeaurora.org, sboyd@codeaurora.org, daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@linaro.org, msivasub@codeaurora.org, lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org

Hi Lina,

On Wednesday 24 September 2014 05:21 AM, Lina Iyer wrote:
> Add SPM device bindings for QCOM 8974 based cpus. SPM is the sub-system
> power manager and controls the logic around the cores (cpu and L2).
> 
> Each core has an instance of SPM and controls only that core. Each cpu
> SPM is configured to support WFI and SPC (standalone-power collapse).
> 
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-msm8974-pm.dtsi | 69 ++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/qcom-msm8974.dtsi    | 10 +++--
>  2 files changed, 75 insertions(+), 4 deletions(-)
>  create mode 100644 arch/arm/boot/dts/qcom-msm8974-pm.dtsi

<snip>

> +};
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index 69dca2a..0580bc2 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -14,7 +14,7 @@
>  		#size-cells = <0>;
>  		interrupts = <1 9 0xf04>;
>  
> -		cpu@0 {
> +		CPU0: cpu@0 {
Lina, Stephen boyd has sent some DT change for krait-cpufreq which also
renames this node to "cpu0: cpu@0". If you both could sync up and agree
on a common naming('cpu0' with caps or not caps) for this node.

Best Regards
Pramod

>  			compatible = "qcom,krait";
>  			enable-method = "qcom,kpss-acc-v2";
>  			device_type = "cpu";
> @@ -23,7 +23,7 @@
>  			qcom,acc = <&acc0>;
>  		};
>  
> -		cpu@1 {
> +		CPU1: cpu@1 {
Ditto
>  			compatible = "qcom,krait";
>  			enable-method = "qcom,kpss-acc-v2";
>  			device_type = "cpu";
> @@ -32,7 +32,7 @@
>  			qcom,acc = <&acc1>;
>  		};
>  
> -		cpu@2 {
> +		CPU2: cpu@2 {
Ditto
>  			compatible = "qcom,krait";
>  			enable-method = "qcom,kpss-acc-v2";
>  			device_type = "cpu";
> @@ -41,7 +41,7 @@
>  			qcom,acc = <&acc2>;
>  		};
>  
> -		cpu@3 {
> +		CPU3: cpu@3 {
Ditto
>  			compatible = "qcom,krait";
>  			enable-method = "qcom,kpss-acc-v2";
>  			device_type = "cpu";
> @@ -238,3 +238,5 @@
>  		};
>  	};
>  };
> +
> +#include "qcom-msm8974-pm.dtsi"
> 
