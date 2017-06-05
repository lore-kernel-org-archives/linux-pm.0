From: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/7] USB: core: fix device node leak
Date: Mon, 5 Jun 2017 11:35:30 +0800
Message-ID: <20170605033530.GA20014@b29397-desktop>
References: <20170530162554.26159-1-johan@kernel.org>
 <20170530162554.26159-2-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170530162554.26159-2-johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, May 30, 2017 at 06:25:48PM +0200, Johan Hovold wrote:
> Make sure to release any OF device-node reference taken when creating
> the USB device.
> 
> Note that we currently do not hold a reference to the root hub
> device-tree node (i.e. the parent controller node).
> 
> Fixes: 69bec7259853 ("USB: core: let USB device know device node")
> Cc: stable <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>	# v4.6
> Cc: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
> Signed-off-by: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  drivers/usb/core/usb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> index 28b053cacc90..62e1906bb2f3 100644
> --- a/drivers/usb/core/usb.c
> +++ b/drivers/usb/core/usb.c
> @@ -416,6 +416,8 @@ static void usb_release_dev(struct device *dev)
>  
>  	usb_destroy_configuration(udev);
>  	usb_release_bos_descriptor(udev);
> +	if (udev->parent)
> +		of_node_put(dev->of_node);
>  	usb_put_hcd(hcd);
>  	kfree(udev->product);
>  	kfree(udev->manufacturer);

Acked-by: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
