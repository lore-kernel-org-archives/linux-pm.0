From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/7] USB: core: fix device node leak
Date: Wed, 31 May 2017 10:25:47 +0200
Message-ID: <20170531082547.GB6735@localhost>
References: <20170530162554.26159-1-johan@kernel.org>
 <20170530162554.26159-2-johan@kernel.org>
 <9aff0d42-ff3e-963a-7aaa-752c2f592d0d@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9aff0d42-ff3e-963a-7aaa-752c2f592d0d-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tyrel Datwyler <tyreld-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, May 30, 2017 at 03:55:56PM -0700, Tyrel Datwyler wrote:
> On 05/30/2017 09:25 AM, Johan Hovold wrote:
> > Make sure to release any OF device-node reference taken when creating
> > the USB device.
> > 
> > Note that we currently do not hold a reference to the root hub
> > device-tree node (i.e. the parent controller node).
> > 
> > Fixes: 69bec7259853 ("USB: core: let USB device know device node")
> > Cc: stable <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>	# v4.6
> > Cc: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
> > Signed-off-by: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > ---
> >  drivers/usb/core/usb.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> > index 28b053cacc90..62e1906bb2f3 100644
> > --- a/drivers/usb/core/usb.c
> > +++ b/drivers/usb/core/usb.c
> > @@ -416,6 +416,8 @@ static void usb_release_dev(struct device *dev)
> >  
> >  	usb_destroy_configuration(udev);
> >  	usb_release_bos_descriptor(udev);
> > +	if (udev->parent)
> > +		of_node_put(dev->of_node);
> 
> If I'm following the root hub doesn't hold an of_node reference, so
> does that guarantee that dev->of_node is NULL for the root hub?

No, it may be non-NULL.

> If so of_node_put() is safely called with a NULL reference, making the
> if(udev->parent) unnecessary, and further no need to remove it in
> follow-up patch #5.

So this one is still needed.

Thanks,
Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
