From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 06/10] thermal: rockchip: consistently use int for
 temperatures
Date: Wed, 2 Dec 2015 10:38:51 -0800
Message-ID: <20151202183851.GA91131@google.com>
References: <1447044542-30859-1-git-send-email-wxt@rock-chips.com>
 <1447044542-30859-7-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1447044542-30859-7-git-send-email-wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Caesar,

On Mon, Nov 09, 2015 at 12:48:58PM +0800, Caesar Wang wrote:
> As Temperature is currently represented as int not long in the thermal
> framework since use int intead of unsigned long/long to represent
> temperature to avoid bogus overheat detection when negative temperature
> reported.
> 
> Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> 
> ---
> 
> Changes in v4:
> - fix the warning from the print message.
> 
> Changes in v3:
> - As the Patch v2 comments, Add a new patch to fix it.
> 
> Changes in v2: None
> Changes in v1: None
> 
>  drivers/thermal/rockchip_thermal.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index 7c5b784..73d47f8 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -88,7 +88,7 @@ struct rockchip_tsadc_chip {
>  	int chn_num;
>  
>  	/* The hardware-controlled tshut property */
> -	long tshut_temp;
> +	int tshut_temp;
>  	enum tshut_mode tshut_mode;
>  	enum tshut_polarity tshut_polarity;
>  

...

> @@ -126,7 +126,7 @@ struct rockchip_thermal_data {
>  
>  	void __iomem *regs;
>  
> -	long tshut_temp;
> +	int tshut_temp;

FYI, this change is triggering a new warning in Coverity, below:

>  	enum tshut_mode tshut_mode;
>  	enum tshut_polarity tshut_polarity;
>  };

...

> @@ -477,7 +477,7 @@ static int rockchip_configure_from_dt(struct device *dev,
>  	}
>  
>  	if (thermal->tshut_temp > INT_MAX) {

     CID 1341498:  Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
     "thermal->tshut_temp > 2147483647 /* (int)(~0U >> 1) */" is always false regardless of the values of its operands. This occurs as the logical operand of if.

I don't think this condition is even useful any more, so maybe we should
just kill the 'if' block.

> -		dev_err(dev, "Invalid tshut temperature specified: %ld\n",
> +		dev_err(dev, "Invalid tshut temperature specified: %d\n",
>  			thermal->tshut_temp);
>  		return -ERANGE;
>  	}

Brian
