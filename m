From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] Power: Supply: sbs-charger: simplfied bool function
Date: Tue, 14 Feb 2017 05:58:02 -0800
Message-ID: <1487080682.6214.25.camel@perches.com>
References: <1487079790-724-1-git-send-email-danielperezdeandres@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487079790-724-1-git-send-email-danielperezdeandres@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Perez <danielperezdeandres@gmail.com>, sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolassaenzj@gmail.com
List-Id: linux-pm@vger.kernel.org

On Tue, 2017-02-14 at 14:43 +0100, Daniel Perez wrote:
> Simplified the syntax of a simple bool return value function.
> 
> Signed-off-by: Daniel Perez <danielperezdeandres@gmail.com>
> ---
>  drivers/power/supply/sbs-charger.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/power/supply/sbs-charger.c b/drivers/power/supply/sbs-charger.c
> index 353765a..3e40553 100644
> --- a/drivers/power/supply/sbs-charger.c
> +++ b/drivers/power/supply/sbs-charger.c
> @@ -137,10 +137,7 @@ static enum power_supply_property sbs_properties[] = {
>  
>  static bool sbs_readable_reg(struct device *dev, unsigned int reg)
>  {
> -	if (reg < SBS_CHARGER_REG_SPEC_INFO)
> -		return false;
> -	else
> -		return true;
> +	return reg < SBS_CHARGER_REG_SPEC_INFO ? false : true;

Any ternary with true false could be simplified.
Why not just

	return reg >= SBS_CHARGER_REG_SPEC_INFO;
