From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [RFC PATCH] ARM: zynq: cpuidle: convert to platform driver
Date: Fri, 27 Sep 2013 07:12:20 +0200
Message-ID: <22edc518-27ad-4dcf-918a-def23df93bcc@DB9EHSMHS022.ehs.local>
References: <1380212138-4020-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-db9lp0250.outbound.messaging.microsoft.com ([213.199.154.250]:14576
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750820Ab3I0FMd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2013 01:12:33 -0400
In-Reply-To: <1380212138-4020-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

Hi Daniel,

On 09/26/2013 06:15 PM, Daniel Lezcano wrote:
> As the ux500 and the kirkwood driver, make the zynq driver a platform driver
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-zynq/common.c    |    7 +++++++
>  drivers/cpuidle/cpuidle-zynq.c |   15 ++++++++++-----
>  2 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
> index 5f25256..0f0d88f 100644
> --- a/arch/arm/mach-zynq/common.c
> +++ b/arch/arm/mach-zynq/common.c
> @@ -44,6 +44,10 @@ static struct of_device_id zynq_of_bus_ids[] __initdata = {
>  	{}
>  };
>  
> +static struct platform_device zynq_cpuidle_device = {
> +	.name = "cpuidle-zynq",
> +};
> +
>  /**
>   * zynq_init_machine - System specific initialization, intended to be
>   *		       called from board specific initialization.
> @@ -56,6 +60,9 @@ static void __init zynq_init_machine(void)
>  	l2x0_of_init(0x02060000, 0xF0F0FFFF);
>  
>  	of_platform_bus_probe(NULL, zynq_of_bus_ids, NULL);
> +
> +	if (of_machine_is_compatible("xlnx,zynq-7000"))

This is not needed because all zynq platforms have this compatibility string
and there is no any other clone.

The rest is fine.

Thanks,
Michal


