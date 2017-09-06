From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH][thermal-next] thermal: brcmstb: remove two redundant
 integer range checks
Date: Wed, 6 Sep 2017 11:40:46 -0700
Message-ID: <20170906184046.GB35422@google.com>
References: <20170903131619.6857-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36204 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbdIFSku (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Sep 2017 14:40:50 -0400
Content-Disposition: inline
In-Reply-To: <20170903131619.6857-1-colin.king@canonical.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Markus Mayer <mmayer@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>

Hi,

On Sun, Sep 03, 2017 at 02:16:19PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The comparisons for integer low on low > INT_MAX and also
> integer high > INT_MAX are never going to be true since an
> int type cannot be greater than INT_MAX.  Remove these redundant
> checks.
> 
> Detected by: CoverityScan CID#1455245, 1455248 ("Operands don't affect
>   result (CONSTANT_EXPRESSION_RESULT)")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/thermal/broadcom/brcmstb_thermal.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
> index 87b8e7a86ee3..bcb3945feea6 100644
> --- a/drivers/thermal/broadcom/brcmstb_thermal.c
> +++ b/drivers/thermal/broadcom/brcmstb_thermal.c
> @@ -278,8 +278,6 @@ static int brcmstb_set_trips(void *data, int low, int high)
>  	dev_dbg(priv->dev, "set trips %d <--> %d\n", low, high);
>  
>  	if (low) {
> -		if (low > INT_MAX)
> -			low = INT_MAX;
>  		avs_tmon_set_trip_temp(priv, TMON_TRIP_TYPE_LOW, low);
>  		avs_tmon_trip_enable(priv, TMON_TRIP_TYPE_LOW, 1);
>  	} else {
> @@ -287,8 +285,6 @@ static int brcmstb_set_trips(void *data, int low, int high)
>  	}
>  
>  	if (high < ULONG_MAX) {

Dan's robots noticed that the above condition is not useful either (on
architectures where INT_MAX < ULONG_MAX -- i.e., all?), since 'high' is
'int', not 'unsigned long'.

Should probably fix that

s/ULONG_MAX/INT_MAX/

?

Brian

> -		if (high > INT_MAX)
> -			high = INT_MAX;
>  		avs_tmon_set_trip_temp(priv, TMON_TRIP_TYPE_HIGH, high);
>  		avs_tmon_trip_enable(priv, TMON_TRIP_TYPE_HIGH, 1);
>  	} else {
> -- 
> 2.14.1
> 
