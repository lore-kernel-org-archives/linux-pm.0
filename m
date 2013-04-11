From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [v2,03/14] thermal: mvebu: Move MODULE_DEVICE_TABLE upwards
Date: Thu, 11 Apr 2013 12:25:47 -0400
Message-ID: <5166E40B.3060901@ti.com>
References: <1363991114-4225-4-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43090 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754525Ab3DKQ0o (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Apr 2013 12:26:44 -0400
In-Reply-To: <1363991114-4225-4-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>, Lior Amsalem <alior@marvell.com>, Zhang Rui <rui.zhang@intel.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, eduardo.valentin@ti.com

Rui,

On 22-03-2013 18:25, Ezequiel Garcia wrote:
> This table will be needed by mvebu_thermal_probe() so we move
> it just below the declaration of the compatible device table.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>

This patch looks fine to me.

Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
> drivers/thermal/mvebu_thermal.c |    3 +--
>   1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/mvebu_thermal.c b/drivers/thermal/mvebu_thermal.c
> index 9ba9e4d..031f94d 100644
> --- a/drivers/thermal/mvebu_thermal.c
> +++ b/drivers/thermal/mvebu_thermal.c
> @@ -68,6 +68,7 @@ static const struct of_device_id mvebu_thermal_id_table[] = {
>   	{ .compatible = "marvell,kirkwood-thermal" },
>   	{}
>   };
> +MODULE_DEVICE_TABLE(of, mvebu_thermal_id_table);
>
>   static int mvebu_thermal_probe(struct platform_device *pdev)
>   {
> @@ -115,8 +116,6 @@ static int mvebu_thermal_exit(struct platform_device *pdev)
>   	return 0;
>   }
>
> -MODULE_DEVICE_TABLE(of, mvebu_thermal_id_table);
> -
>   static struct platform_driver mvebu_thermal_driver = {
>   	.probe = mvebu_thermal_probe,
>   	.remove = mvebu_thermal_exit,
>

