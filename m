From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v7 5/8] CPPC: Add a CPUFreq driver for use with CPPC
Date: Mon, 20 Jul 2015 15:22:09 +0100
Message-ID: <55AD0411.4000603@arm.com>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org> <e8464849d98e4a4f64e9b23501d84b1f843aa994.1436464513.git.ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55962 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932678AbbGTOWN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 20 Jul 2015 10:22:13 -0400
In-Reply-To: <e8464849d98e4a4f64e9b23501d84b1f843aa994.1436464513.git.ashwin.chaugule@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>



On 09/07/15 19:04, Ashwin Chaugule wrote:
> This driver utilizes the methods introduced in the previous
> patch - "ACPI: Introduce CPU performance controls using CPPC"
> and enables usage with existing CPUFreq governors.
>
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> Reviewed-by: Al Stone <al.stone@linaro.org>
> ---
>   drivers/cpufreq/Kconfig.arm    |  16 ++++
>   drivers/cpufreq/Makefile       |   2 +
>   drivers/cpufreq/cppc_cpufreq.c | 197 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 215 insertions(+)
>   create mode 100644 drivers/cpufreq/cppc_cpufreq.c
>
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 4f3dbc8..578384d 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -272,3 +272,19 @@ config ARM_PXA2xx_CPUFREQ
>   	  This add the CPUFreq driver support for Intel PXA2xx SOCs.
>
>   	  If in doubt, say N.
> +
> +config ACPI_CPPC_CPUFREQ
> +	tristate "CPUFreq driver based on the ACPI CPPC spec"
> +	depends on ACPI_CPPC_LIB
> +	default n
> +	help
> +	  This adds a CPUFreq driver which uses CPPC methods
> +	  as described in the ACPIv5.1 spec. CPPC stands for
> +	  Collaborative Processor Performance Controls. It
> +	  is based on an abstract continuous scale of CPU
> +	  performance values which allows the remote power
> +	  processor to flexibly optimize for power and
> +	  performance. CPPC relies on power management firmware
> +	  for its operation.

Why is this ARM specific ? It might be used only on ARM but doesn't mean
it should be visible only on ARM ACPI systems.

Regards,
Sudeep
