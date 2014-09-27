From: Pramod Gurav <pramod.gurav@smartplayin.com>
Subject: Re: [PATCH v7 5/7] qcom: cpuidle: Add cpuidle driver for QCOM cpus
Date: Sat, 27 Sep 2014 13:48:04 +0530
Message-ID: <542672BC.3040306@smartplayin.com>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org> <1411779495-39724-6-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp101.ord1c.emailsrvr.com ([108.166.43.101]:44202 "EHLO
	smtp101.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751255AbaI0ISQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 27 Sep 2014 04:18:16 -0400
In-Reply-To: <1411779495-39724-6-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>, daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org



On 27-09-2014 06:28 AM, Lina Iyer wrote:
..

> +}
> +
> +static struct platform_driver qcom_cpuidle_plat_driver = {
> +	.probe	= qcom_cpuidle_probe,
> +	.driver = {
> +		.name = "qcom_cpuidle",
> +		.owner = THIS_MODULE,
.owner field can be removed here, as for drivers which
use the module_platform_driver API, this is overriden in
platform_driver_register anyway.
> +	},
> +};
> +
> +module_platform_driver(qcom_cpuidle_plat_driver);
> 
