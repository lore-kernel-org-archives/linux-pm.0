From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v3 01/11] power: supplies: bq275xx: move overtemp tests to
 a switch statement.
Date: Mon, 9 Jan 2017 09:35:07 -0600
Message-ID: <68f9bea1-9910-5542-92d9-058b3ae35eea@ti.com>
References: <1482369743-79764-1-git-send-email-chris@lapa.com.au>
 <1483922865-96321-1-git-send-email-chris@lapa.com.au>
 <1483922865-96321-2-git-send-email-chris@lapa.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1483922865-96321-2-git-send-email-chris@lapa.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Lapa <chris@lapa.com.au>, pali.rohar@gmail.com, sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 01/08/2017 06:47 PM, Chris Lapa wrote:
> From: Chris Lapa <chris@lapa.com.au>
> 
> This is done for readability as the upcoming commits will add a lot of
> cases.
> 
> tested: no
> 
> Signed-off-by: Chris Lapa <chris@lapa.com.au>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 3b0dbc6..fd4cc4e 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -635,12 +635,17 @@ static int bq27xxx_battery_read_pwr_avg(struct bq27xxx_device_info *di)
>   */
>  static bool bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
>  {
> -	if (di->chip == BQ27500 || di->chip == BQ27541 || di->chip == BQ27545)
> +	switch (di->chip) {
> +	case BQ27500:
> +	case BQ27541:
> +	case BQ27545:

As some functions are not long enough to need this refactoring, I feel
we still have some code consistency issues in this driver. At some point
it may be better to add some additional fields to the device definition
structure, then we reference that and not use coded cases for selection.

For now, this and the rest of the series look correct to me:

Reviewed-by: Andrew F. Davis <afd@ti.com>

>  		return flags & (BQ27XXX_FLAG_OTC | BQ27XXX_FLAG_OTD);
> -	if (di->chip == BQ27530 || di->chip == BQ27421)
> +	case BQ27530:
> +	case BQ27421:
>  		return flags & BQ27XXX_FLAG_OT;
> -
> -	return false;
> +	default:
> +		return false;
> +	}
>  }
>  
>  /*
> 
