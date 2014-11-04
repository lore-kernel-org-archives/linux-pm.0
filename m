From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 0/9] PM / Domains: Fix race conditions during boot
Date: Tue, 4 Nov 2014 10:29:20 -0800
Message-ID: <20141104182920.GB440@dtor-ws>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
 <20141104090521.GA13219@dtor-glaptop>
 <CAPDyKFrMMnOwOHuVcpxBWNARKUsVyq66yuH+=LcS3K7bBiUTVA@mail.gmail.com>
 <3036013.4SXEGIT6Kk@vostro.rjw.lan>
 <CAPDyKFr7fqwb77Xhnwf7ACFX7skrY2O+_-aB1T_yfShDA1jASA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFr7fqwb77Xhnwf7ACFX7skrY2O+_-aB1T_yfShDA1jASA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 04, 2014 at 06:01:44PM +0100, Ulf Hansson wrote:
> >>
> >> Devices that are created while "discoverable buses" are being probed
> >> can't be attached to a PM domain before the probing is done, because
> >> those simply doesn't exist.
> >
> > Honestly, I'm not sure what you're talking about.
> >
> > Devices on a "discoverable* bus (say PCI) are added when the *controller* is
> > probed, not when *they* are probed.
> 
> Okay, so maybe "discoverable buses" isn't the proper term.
> 
> >
> > You very much need to have a struct device registered to be able to call
> > really_probe() for it.
> 
> Yes. But my point is that the struct device may be created dynamically
> at some point in time.

And that is fine.

> 
> This is how mmc/sd/sdio cards are handled. We don't have the
> information about the card and thus not the struct device of it, until
> we have detected it. Maybe we could at that point try to add the
> device to its PM domain?

Well, I think we need to first define what PM domain they will fall
into. Do they have to be in one? The concept of power domain, as far as I
understand it, is needed when we need to form relations going outside
the standard parent/child relationship. Here we have a controller and
then one or more cards in it. To be able to use card you need to power
up parent and you can not power down parent until all children are
powered down.

But in any case, device discovery and binding them to drivers are 2
separate steps. You have a PCI bus. You enumerate it - new PCI devices
are created. Some of them may be put in a certain power domain. You then
bind drivers to PCI devices (not strictly 'then' but we could implement
driver core to postpone binding until current round of enumeration is
complete) - and you discover USB controller and maybe i2c controller.
Then you bind drivers to them which causes enumeration of the new bus
and new devices are created. But in all these cases enumeration and
creation of new 'struct device's, and driver binding are logically
separate steps.

> 
> >
> >> Now, I haven't yet seen a demand for such a cases, but it seems wrong
> >> to not consider them. The current solution cover these.
> >
> > Oh dear.  Please rethink this.
> 
> Currently, dev_pm_domain_attach() is being invoked at the point when a
> SDIO card has been found. From sdio_add_func(). How would that be
> solved?
> 

It is probably the one place where we currently doing it correctly (form
logical point of view, not implementation wise - implementation wise in
sdio we add device to power domain after calling device_add() which
means that probe() could have been called before we added the new device
to any power domain).

Thanks.

-- 
Dmitry
