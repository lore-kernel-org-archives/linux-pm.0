From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 02/10] qcom: scm: Add SCM warmboot support for quad core
 SoCs
Date: Wed, 26 Nov 2014 14:36:28 -0800
Message-ID: <547655EC.2040401@codeaurora.org>
References: <1417040910-43290-1-git-send-email-lina.iyer@linaro.org> <1417040910-43290-3-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:35240 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbaKZWgb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 17:36:31 -0500
In-Reply-To: <1417040910-43290-3-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org

On 11/26/2014 02:28 PM, Lina Iyer wrote:
> Quad core SoCs like APQ8074, APQ8064, APQ8084 need SCM support set up
> warm boot addresses in the Secure Monitor. Extend the SCM flags to
> support warm boot addresses for secondary cores.
>
> We do not need to export the warmboot flags. Move them into the
> implementation file.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

> @@ -37,3 +54,20 @@ int scm_set_boot_addr(phys_addr_t addr, int flags)
>   			&cmd, sizeof(cmd), NULL, 0);
>   }
>   EXPORT_SYMBOL(scm_set_boot_addr);
> +
> +int scm_set_warm_boot_addr(void *entry, int cpu)
> +{
> +	int ret;
> +
> +	/* Reassign only if we are switching from hotplug entry point
> +	 * to cpuidle entry point or vice versa.
> +	 */

Multi-line comments are like this:

/*
  * Reassign only if we are ...
  */


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

