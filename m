From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/1] thermal: int3403: Delete a check before
 thermal_zone_device_unregister()
Date: Mon, 08 Dec 2014 12:15:03 +0800
Message-ID: <1418012103.19126.21.camel@rzhang1-toshiba>
References: <5307CAA2.8060406@users.sourceforge.net>
	 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
	 <530A086E.8010901@users.sourceforge.net>
	 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
	 <530A72AA.3000601@users.sourceforge.net>
	 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
	 <530B5FB6.6010207@users.sourceforge.net>
	 <alpine.DEB.2.10.1402241710370.2074@hadrien>
	 <530C5E18.1020800@users.sourceforge.net>
	 <alpine.DEB.2.10.1402251014170.2080@hadrien>
	 <530CD2C4.4050903@users.sourceforge.net>
	 <alpine.DEB.2.10.1402251840450.7035@hadrien>
	 <530CF8FF.8080600@users.sourceforge.net>
	 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
	 <530DD06F.4090703@users.sourceforge.net>
	 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
	 <5317A59D.4@users.sourceforge.net> <547BF398.8010407@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <547BF398.8010407@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-pm@vger.kernel.org

On Mon, 2014-12-01 at 05:50 +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 1 Dec 2014 05:45:42 +0100
> 
> The thermal_zone_device_unregister() function tests whether its argument
> is NULL and then returns immediately. Thus the test around the call
> is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

applied.

thanks,
rui
> ---
>  drivers/thermal/int340x_thermal/int3403_thermal.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/int340x_thermal/int3403_thermal.c b/drivers/thermal/int340x_thermal/int3403_thermal.c
> index 6e9fb62..790b8f6 100644
> --- a/drivers/thermal/int340x_thermal/int3403_thermal.c
> +++ b/drivers/thermal/int340x_thermal/int3403_thermal.c
> @@ -293,8 +293,7 @@ static int int3403_sensor_add(struct int3403_priv *priv)
>  	return 0;
>  
>   err_free_obj:
> -	if (obj->tzone)
> -		thermal_zone_device_unregister(obj->tzone);
> +	thermal_zone_device_unregister(obj->tzone);
>  	return result;
>  }
>  


