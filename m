From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [v2,04/14] thermal: mvebu: Remove unneeded variable initialization
Date: Thu, 11 Apr 2013 12:29:22 -0400
Message-ID: <5166E4E2.1080606@ti.com>
References: <1363991114-4225-5-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58237 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761402Ab3DKQa3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 11 Apr 2013 12:30:29 -0400
In-Reply-To: <1363991114-4225-5-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>, Lior Amsalem <alior@marvell.com>, Zhang Rui <rui.zhang@intel.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, eduardo.valentin@ti.com

Rui, Ezequiel,

On 22-03-2013 18:25, Ezequiel Garcia wrote:
> This variable is used only after it's properly initialized,
> so there's no need to set it to NULL in its declaration.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>

I am fine with this patch. Though it doesn t hurt to have this 
initialization, the code looks cleaner though.

Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>


> ---
> drivers/thermal/mvebu_thermal.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/thermal/mvebu_thermal.c b/drivers/thermal/mvebu_thermal.c
> index 031f94d..1f502ed 100644
> --- a/drivers/thermal/mvebu_thermal.c
> +++ b/drivers/thermal/mvebu_thermal.c
> @@ -72,7 +72,7 @@ MODULE_DEVICE_TABLE(of, mvebu_thermal_id_table);
>
>   static int mvebu_thermal_probe(struct platform_device *pdev)
>   {
> -	struct thermal_zone_device *thermal = NULL;
> +	struct thermal_zone_device *thermal;
>   	struct mvebu_thermal_priv *priv;
>   	struct resource *res;
>
>

