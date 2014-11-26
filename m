From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 07/10] qcom: cpuidle: Add cpuidle driver for QCOM cpus
Date: Wed, 26 Nov 2014 14:48:27 -0800
Message-ID: <547658BB.9040300@codeaurora.org>
References: <1417040910-43290-1-git-send-email-lina.iyer@linaro.org> <1417040910-43290-8-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:36580 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656AbaKZWs3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 17:48:29 -0500
In-Reply-To: <1417040910-43290-8-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org

On 11/26/2014 02:28 PM, Lina Iyer wrote:
> +
> +static struct platform_driver qcom_cpuidle_plat_driver = {
> +	.probe	= qcom_cpuidle_probe,
> +	.driver = {
> +		.name = "qcom_cpuidle",
> +	},
> +};
> +
> +module_platform_driver(qcom_cpuidle_plat_driver);

Said this a few reviews ago...

MODULE_LICENSE()?
MODULE_ALIAS()?
MODULE_DESCRIPTION()?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

