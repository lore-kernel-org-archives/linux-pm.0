From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V11 6/6] thermal: bcm2835: add thermal driver for bcm2835
 SoC
Date: Tue, 28 Mar 2017 21:58:09 -0700
Message-ID: <20170329045807.GC2582@localhost.localdomain>
References: <1489356665-3175-1-git-send-email-stefan.wahren@i2se.com>
 <1489356665-3175-7-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1489356665-3175-7-git-send-email-stefan.wahren-eS4NqCHxEME@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Sun, Mar 12, 2017 at 10:11:05PM +0000, Stefan Wahren wrote:
> Add basic thermal driver for bcm2835 SoC.
> 
> This driver currently make sure that tsense HW block is set up
> correctly.
> 
> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> Signed-off-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
> Acked-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>

I see no issue with this driver at this point.

As I mentioned, the full series needs to go together. You either get an
Ack from OF maintainers, and I take the series, or you can add my

Acked-by: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

after fixing the small comment from Nobuhiro.

> ---
>  drivers/thermal/Kconfig           |    8 +
>  drivers/thermal/Makefile          |    1 +
>  drivers/thermal/bcm2835_thermal.c |  315 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 324 insertions(+)
>  create mode 100644 drivers/thermal/bcm2835_thermal.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 776b343..3bd2406 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -453,4 +453,12 @@ config ZX2967_THERMAL
>  	  the primitive temperature sensor embedded in zx2967 SoCs.
>  	  This sensor generates the real time die temperature.
>  
> +config BCM2835_THERMAL
> +	tristate "Thermal sensors on bcm2835 SoC"
> +	depends on ARCH_BCM2835 || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	depends on THERMAL_OF
> +	help
> +	  Support for thermal sensors on Broadcom bcm2835 SoCs.

small suggestion here:

-If you are sending a new version fixing Nobuhiro comment, you could take
the opportunity to improve the driver Kconfig help description.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
