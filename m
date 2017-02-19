From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2 2/2] ARM: dts: bcm283x: Add CPU thermal zone with 1
 trip point
Date: Sat, 18 Feb 2017 17:17:55 -0800
Message-ID: <20170219011753.GB21016@localhost.localdomain>
References: <1486928328-25870-1-git-send-email-stefan.wahren@i2se.com>
 <1486928328-25870-2-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1486928328-25870-2-git-send-email-stefan.wahren-eS4NqCHxEME@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Sun, Feb 12, 2017 at 07:38:48PM +0000, Stefan Wahren wrote:
> As suggested by Eduardo Valentin this adds the thermal zone for
> the bcm2835 SoC with its single thermal sensor. We start with
> the criticial trip point and leave the cooling devices empty
> since we don't have any at the moment.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
> ---
> 
> Changes in V2:
> - add missing thermal-sensor-cells property
> - change gpu-thermal to cpu-thermal
> 
>  arch/arm/boot/dts/bcm283x.dtsi |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
> index a3106aa..4dc74f6 100644
> --- a/arch/arm/boot/dts/bcm283x.dtsi
> +++ b/arch/arm/boot/dts/bcm283x.dtsi
> @@ -19,6 +19,25 @@
>  		bootargs = "earlyprintk console=ttyAMA0";
>  	};
>  
> +	thermal-zones {
> +		cpu_thermal: cpu-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <1000>;
> +

Check the diff I sent and also add the following for differentiating the
offsets and slopes depending on which chip the zone describes:
			coefficients = <-538 407000>; /* for the zone on bcm2835 and bcm2836 */

and

			coefficients = <-538 412000>; /* for the zone on bcm2837 */


Despite the changes mentioned for the driver and DT, I am ok with the driver and the DTS descriptors.

BR,
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
