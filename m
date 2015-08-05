From: Andy Gross <agross@codeaurora.org>
Subject: Re: [PATCH RFC 06/10] drivers: qcom: Enable genpd on selecting
 QCOM_PM
Date: Wed, 5 Aug 2015 11:38:37 -0500
Message-ID: <20150805163837.GB14198@qualcomm.com>
References: <438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438792366-2737-1-git-send-email-lina.iyer@linaro.org>
 <1438792366-2737-7-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54780 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbbHEQij (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2015 12:38:39 -0400
Content-Disposition: inline
In-Reply-To: <1438792366-2737-7-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, msivasub@codeaurora.org, sboyd@codeaurora.org, robh@kernel.org

On Wed, Aug 05, 2015 at 10:32:42AM -0600, Lina Iyer wrote:
> Enable PM_CPU_DOMAIN and its PM_GENERIC_DOMAINS dependenciesd to provide
> cpu domain support for QCOM SoCs.

Fix dependencies <sic>

> 
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  drivers/soc/qcom/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index ba47b70..b6c2e5d 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -14,6 +14,10 @@ config QCOM_PM
>  	bool "Qualcomm Power Management"
>  	depends on ARCH_QCOM && !ARM64
>  	select QCOM_SCM
> +	select ARM_CPU_SUSPEND
> +	select PM_GENERIC_DOMAINS
> +	select PM_GENERIC_DOMAINS_SLEEP
> +	select PM_GENERIC_DOMAINS_OF
>  	help
>  	  QCOM Platform specific power driver to manage cores and L2 low power
>  	  modes. It interface with various system drivers to put the cores in
> -- 
> 2.1.4
> 

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

