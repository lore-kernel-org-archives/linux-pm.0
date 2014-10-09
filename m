From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v8 4/7] qcom: pm: Add cpu low power mode functions
Date: Wed, 08 Oct 2014 18:17:57 -0700
Message-ID: <5435E245.1090507@codeaurora.org>
References: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org> <1412718106-17049-5-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:50291 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbaJIBR7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Oct 2014 21:17:59 -0400
In-Reply-To: <1412718106-17049-5-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org

On 10/07/2014 02:41 PM, Lina Iyer wrote:

> +
> +static struct platform_device qcom_cpuidle_device = {
> +	.name              = "qcom_cpuidle",
> +	.id                = -1,
> +	.dev.platform_data = qcom_cpu_pm_enter_sleep,
> +};
> +

Same comment as last time, doesn't need to be static.

> +static int __init qcom_pm_device_init(void)
> +{
> +	platform_device_register(&qcom_cpuidle_device);
> +

This is wrong. We're going to register a platform device whenever this 
file is included in a kernel. This is then going to try and probe the 
qcom_cpuidle device which is going to fail and print an error message if 
we're not running on a qcom device. This is one reason why I've been 
arguing to get rid of this file and just put it inside the spm driver. 
That way we don't ever add the cpuidle device and:

  a) We know the SPM hardware is configured and ready to be used
  b) We don't get this annoying warning and have some weird device in 
sysfs on non-qcom devices


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

