From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH for 3.9] thermal: mvebu: Fix valid check for thermal
 register
Date: Tue, 26 Mar 2013 22:24:09 +0800
Message-ID: <1364307849.2821.22.camel@rzhang1-mobl4>
References: <1363898527-3660-1-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:14193 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934459Ab3CZOYc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 26 Mar 2013 10:24:32 -0400
In-Reply-To: <1363898527-3660-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Lior Amsalem <alior@marvell.com>

On Thu, 2013-03-21 at 17:42 -0300, Ezequiel Garcia wrote:
> The correct value is obtain by first shifting the register by the offset,
> later applying the valid mask and finally invert the result.
> This check was lacking an extra parenthesis to be strictly correct.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

applied to thermal -next.

thanks,
rui
> ---
> I've taken this fix out of the thermal patchset,
> so we can apply it earlier on v3.9.
> 
>  drivers/thermal/kirkwood_thermal.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
> index 65cb4f0..ee433b7 100644
> --- a/drivers/thermal/kirkwood_thermal.c
> +++ b/drivers/thermal/kirkwood_thermal.c
> @@ -41,8 +41,8 @@ static int kirkwood_get_temp(struct thermal_zone_device *thermal,
>  	reg = readl_relaxed(priv->sensor);
>  
>  	/* Valid check */
> -	if (!(reg >> KIRKWOOD_THERMAL_VALID_OFFSET) &
> -	    KIRKWOOD_THERMAL_VALID_MASK) {
> +	if (!((reg >> KIRKWOOD_THERMAL_VALID_OFFSET) &
> +	    KIRKWOOD_THERMAL_VALID_MASK)) {
>  		dev_err(&thermal->device,
>  			"Temperature sensor reading not valid\n");
>  		return -EIO;


