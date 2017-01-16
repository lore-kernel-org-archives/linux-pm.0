From: Mark Greer <mgreer@animalcreek.com>
Subject: Re: [PATCH v2 2/6] power: bq24190_charger: Call set_mode_host() on
 pm_resume()
Date: Mon, 16 Jan 2017 10:49:35 -0700
Message-ID: <20170116174935.GC27262@animalcreek.com>
References: <CAKvHMgS_Es4CrTWCEiYZU1v9VC8pqVnqPfkNoj+g6b6t8wfvQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52783 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750747AbdAPRth (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jan 2017 12:49:37 -0500
Content-Disposition: inline
In-Reply-To: <CAKvHMgS_Es4CrTWCEiYZU1v9VC8pqVnqPfkNoj+g6b6t8wfvQQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt@ranostay.consulting>

On Sun, Jan 15, 2017 at 10:07:34PM -0800, Liam Breck wrote:
> 

> pm_resume() does a register_reset() which clears charger host mode.
> 
> Fix by calling set_mode_host() after the reset.
> 
> Fixes: d7bf353fd0aa3 ("bq24190_charger: Add support for TI BQ24190 Battery Charger")
> Cc: Mark A. Greer <mgreer@animalcreek.com>
> Cc: Matt Ranostay <matt@ranostay.consulting>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> ---
>  drivers/power/supply/bq24190_charger.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index f5746b9..e9e6fe9 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -1494,6 +1494,7 @@ static int bq24190_pm_resume(struct device *dev)
>  
>  	pm_runtime_get_sync(bdi->dev);
>  	bq24190_register_reset(bdi);
> +	bq24190_set_mode_host(bdi);
>  	pm_runtime_put_sync(bdi->dev);
>  
>  	/* Things may have changed while suspended so alert upper layer */

Acked-by: Mark Greer <mgreer@animalcreek.com>
