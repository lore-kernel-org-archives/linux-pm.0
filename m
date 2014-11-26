From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v10 04/10] arm: dts: qcom: Add power-controller device
 node for 8074 Krait CPUs
Date: Wed, 26 Nov 2014 12:01:28 -0800
Message-ID: <54763198.7070800@codeaurora.org>
References: <1416593037-27527-1-git-send-email-lina.iyer@linaro.org> <1416593037-27527-5-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:48711 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540AbaKZUBa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 15:01:30 -0500
In-Reply-To: <1416593037-27527-5-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org

On 11/21/2014 10:03 AM, Lina Iyer wrote:
> @@ -144,7 +148,27 @@
>   			};
>   		};
>   
> -		saw_l2: regulator@f9012000 {
> +		saw0: power-controller@f9089000 {
> +			compatible = "qcom,msm8974-saw2-v2.1-cpu";
> +			reg = <0xf9089000 0x1000>;
> +		};
> +
> +		saw1: power-controller@f9099000 {
> +			compatible = "qcom,msm8974-saw2-v2.1-cpu";
> +			reg = <0xf9099000 0x1000>;
> +		};
> +
> +		saw2: power-controller@f90a9000 {
> +			compatible = "qcom,msm8974-saw2-v2.1-cpu";
> +			reg = <0xf90a9000 0x1000>;
> +		};
> +
> +		saw3: power-controller@f90b9000 {
> +			compatible = "qcom,msm8974-saw2-v2.1-cpu";
> +			reg = <0xf90b9000 0x1000>;
> +		};

All these nodes need to follow the binding and have two reg properties. 
Please add the second one.


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

