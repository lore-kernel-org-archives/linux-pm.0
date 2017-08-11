From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: rockchip: fix error return code in
 rockchip_thermal_probe()
Date: Fri, 11 Aug 2017 11:08:27 +0800
Message-ID: <1502420907.2598.9.camel@intel.com>
References: <20170808043517.GA13356@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:15848 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751962AbdHKDIc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Aug 2017 23:08:32 -0400
In-Reply-To: <20170808043517.GA13356@embeddedgus>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Eduardo Valentin <edubezval@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org

On Mon, 2017-08-07 at 23:35 -0500, Gustavo A. R. Silva wrote:
> platform_get_irq() returns an error code, but the rockchip_thermal
> driver
> ignores it and always returns -EINVAL. This is not correct and,
> prevents
> -EPROBE_DEFER from being propagated properly.
> 
> Notice that platform_get_irq() no longer returns 0 on error:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co
> mmit/?id=e330b9a6bb35dc7097a4f02cb1ae7b6f96df92af
> 
> Print and propagate the return value of platform_get_irq on failure.
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.

thanks,
rui
> ---
>  drivers/thermal/rockchip_thermal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c
> b/drivers/thermal/rockchip_thermal.c
> index 4c77965..6ca9747 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -1068,8 +1068,8 @@ static int rockchip_thermal_probe(struct
> platform_device *pdev)
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> -		dev_err(&pdev->dev, "no irq resource?\n");
> -		return -EINVAL;
> +		dev_err(&pdev->dev, "no irq resource: %d\n", irq);
> +		return irq;
>  	}
>  
>  	thermal = devm_kzalloc(&pdev->dev, sizeof(struct
> rockchip_thermal_data),
