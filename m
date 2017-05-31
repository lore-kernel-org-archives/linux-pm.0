From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/7] driver core: fix automatic pinctrl management
Date: Wed, 31 May 2017 10:35:23 +0200
Message-ID: <20170531083523.GD6735@localhost>
References: <20170530162554.26159-1-johan@kernel.org>
 <20170530162554.26159-5-johan@kernel.org>
 <CACRpkda2PFrua01uKy3b2Zvqi3SH1i0tsxOfWhNP8bB7RCo45g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkda2PFrua01uKy3b2Zvqi3SH1i0tsxOfWhNP8bB7RCo45g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, May 31, 2017 at 02:39:28AM +0200, Linus Walleij wrote:
> On Tue, May 30, 2017 at 6:25 PM, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> 
> > Commit ab78029ecc34 ("drivers/pinctrl: grab default handles from device
> > core") added automatic pin-control management to driver core by looking
> > up and setting any default pinctrl state found in device tree while a
> > device is being probed.
> 
> Actually we do not just support device tree, but also passing pin control
> states from board files. It is handled by the core all the same.
> So it's not a device tree thing.
> 
> One of those days we will have ACPI passing state tables too...
> 
> But I understand what you mean.

Yes, I could have mentioned board files, but this problem only applies
to device-tree descriptions (for the time being at least).

> > Fix this by checking the new of_node_reused flag and skipping automatic
> > pinctrl configuration during probe if set.
> 
> Seems like a solid idea. I hope we don't need another quirk for ACPI.

We should be able to just generalise and rename the flag (or add a
second one) if it turns out ACPI needs this too.

> Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Thanks,
Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
