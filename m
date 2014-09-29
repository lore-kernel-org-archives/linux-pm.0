From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v7 2/7] arm: dts: qcom: Add SPM device bindings for 8974
Date: Mon, 29 Sep 2014 16:02:03 -0700
Message-ID: <5429E4EB.2050708@codeaurora.org>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org> <1411779495-39724-3-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:51228 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbaI2XCG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Sep 2014 19:02:06 -0400
In-Reply-To: <1411779495-39724-3-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>, daniel.lezcano@linaro.org, khilman@linaro.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org

On 09/26/14 17:58, Lina Iyer wrote:
> @@ -144,7 +148,27 @@
>  			};
>  		};
>  
> -		saw_l2: regulator@f9012000 {
> +		saw0: saw@f9089000 {
> +			compatible = "qcom,msm8974-saw2-v2.1-cpu";
> +			reg = <0xf9089000 0x1000>;

There is another reg property as part of the binding that should be
specified here.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

