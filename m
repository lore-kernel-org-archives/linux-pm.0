From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH 1/3] power: bq27xxx_battery: fix platform probe
Date: Fri, 16 Oct 2015 09:53:12 -0500
Message-ID: <56210F58.7040408@ti.com>
References: <1445003052-31373-1-git-send-email-sre@kernel.org>
 <1445003052-31373-2-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38788 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbbJPOxP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2015 10:53:15 -0400
In-Reply-To: <1445003052-31373-2-git-send-email-sre@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/16/2015 08:44 AM, Sebastian Reichel wrote:
> Add missing initialization of register mapping table to
> platform probe function.
>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>   drivers/power/bq27xxx_battery.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_battery.c
> index 994c78d9f426..69e6b371a51c 100644
> --- a/drivers/power/bq27xxx_battery.c
> +++ b/drivers/power/bq27xxx_battery.c
> @@ -1292,6 +1292,7 @@ static int bq27xxx_battery_platform_probe(struct platform_device *pdev)
>
>   	di->dev = &pdev->dev;
>   	di->chip = pdata->chip;
> +	di->regs = bq27xxx_regs[di->chip];
>
>   	name = pdata->name ?: dev_name(&pdev->dev);
>   	di->bus.read = &bq27xxx_battery_platform_read;
>

Acked-by: Andrew F. Davis <afd@ti.com>

-- 
Andrew F. Davis
