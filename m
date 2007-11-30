From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: WARNING: at kernel/resource.c:189 __release_resource
Date: Fri, 30 Nov 2007 23:49:55 +0100
Message-ID: <47509393.8000703__34739.2214498997$1196463076$gmane$org@gmail.com>
References: <4745F77C.7040402@gmail.com>
	<200711291640.38158.bjorn.helgaas@hp.com>
	<20071129164207.fd7bcd30.akpm@linux-foundation.org>
	<200711301408.13422.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711301408.13422.bjorn.helgaas@hp.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: drzeus@drzeus.cx, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, matthew@wil.cx
List-Id: linux-pm@vger.kernel.org

On 11/30/2007 10:08 PM, Bjorn Helgaas wrote:
> On Thursday 29 November 2007 05:42:07 pm Andrew Morton wrote:
>> On Thu, 29 Nov 2007 16:40:37 -0700
>>> Maybe we could either remove the pnp_{stop,start}_dev() calls
>>> from the suspend/resume path, or move the PNP resource management
>>> out of pnp_{start,stop}_dev().
>>>
>>> Bjorn
>>>
>>> [1] http://lkml.org/lkml/2005/11/30/39
>> So was this particular problem caused/exposed by
>> pnp-request-ioport-and-iomem-resources-used-by-active-devices.patch, or is
>> it in mainline?
> 
> I'm pretty sure this problem is caused by that patch, so we
> we shouldn't see this in mainline.
> 
> Jiri, can you try the additional patch below, please?
> 
> Index: linux-mm/drivers/pnp/driver.c
> ===================================================================
> --- linux-mm.orig/drivers/pnp/driver.c	2007-11-30 13:58:25.000000000 -0700
> +++ linux-mm/drivers/pnp/driver.c	2007-11-30 13:59:37.000000000 -0700
> @@ -161,13 +161,6 @@
>  			return error;
>  	}
>  
> -	if (!(pnp_drv->flags & PNP_DRIVER_RES_DO_NOT_CHANGE) &&
> -	    pnp_can_disable(pnp_dev)) {
> -		error = pnp_stop_dev(pnp_dev);
> -		if (error)
> -			return error;
> -	}
> -
>  	if (pnp_dev->protocol && pnp_dev->protocol->suspend)
>  		pnp_dev->protocol->suspend(pnp_dev, state);
>  	return 0;
> @@ -185,12 +178,6 @@
>  	if (pnp_dev->protocol && pnp_dev->protocol->resume)
>  		pnp_dev->protocol->resume(pnp_dev);
>  
> -	if (!(pnp_drv->flags & PNP_DRIVER_RES_DO_NOT_CHANGE)) {
> -		error = pnp_start_dev(pnp_dev);
> -		if (error)
> -			return error;
> -	}
> -
>  	if (pnp_drv->resume)
>  		return pnp_drv->resume(pnp_dev);
>  

No, it breaks suspend.

regards,
-- 
Jiri Slaby (jirislaby@gmail.com)
Faculty of Informatics, Masaryk University
