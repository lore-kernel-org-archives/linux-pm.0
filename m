From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 0/9] PM / Domains: Fix race conditions during boot
Date: Tue, 04 Nov 2014 14:56:14 +0100
Message-ID: <3036013.4SXEGIT6Kk@vostro.rjw.lan>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org> <20141104090521.GA13219@dtor-glaptop> <CAPDyKFrMMnOwOHuVcpxBWNARKUsVyq66yuH+=LcS3K7bBiUTVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrMMnOwOHuVcpxBWNARKUsVyq66yuH+=LcS3K7bBiUTVA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron
List-Id: linux-pm@vger.kernel.org

On Tuesday, November 04, 2014 10:24:35 AM Ulf Hansson wrote:
> On 4 November 2014 10:05, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > On Tue, Nov 04, 2014 at 09:54:19AM +0100, Ulf Hansson wrote:
> >> [...]
> >>
> >> > Generally, there are two or even three levels of runtime PM handling,
> >> > driver, (possibly) bus type and (possibly) PM domain (and multiple levels
> >> > of these are possible in principle).  All of them have to be initialized
> >> > at different times.
> >> >
> >> > Quite arguably, the PM domain and/or bus type runtime PM handling should
> >> > be initialized even before registerind the device or during device
> >> > registration.  Doing that later may be too late.  When the device has been
> >> > registered, runtime PM should work to an extent allowing the driver to access
> >> > the device and configure it further after calling pm_runtime_resume().
> >> >
> >> > Of course, if ->probe() is to call pm_runtime_resume() for this purpose,
> >> > it must take the fact that the driver's own ->runtime_resume() may be called
> >> > as a result of this into account.  That's why I'm asking whether or not the
> >> > core should call pm_runtime_resume() before calling really_probe() in a
> >> > followup branch of this thread.
> >>
> >> I am reading the other thread, let's see.
> >>
> >> >
> >> > The driver's own runtime PM handling must be initialized in the driver and
> >> > the only place suitable for that is ->probe().  However, it needs to be done
> >> > *before* the driver's own ->runtime_resume() or ->runtime_suspend() callback
> >> > is executed.  If that is done properly, it should be possible to cover
> >> > both the CONFIG_PM_RUNTIME set/unset cases in that code.
> >> >
> >> > And I wouldn't recommend anyone to do the runtime PM initialization in
> >> > ->runtime_resume() (when it is called for the first time), as that would be
> >> > error prone and fragile.
> >>
> >> Great! That's means we are at least aligned on this topic. :-)
> >>
> >> >
> >> >> The AMBA bus and some of its drivers a good example of how this has
> >> >> been implemented:
> >> >> driver/amba/bus.c
> >> >> drivers/mmc/host/mmci.c
> >> >> drivers/spi/spi-pl022.c
> >> >>
> >> >> This conclusion I have made from this is:
> >> >> - Using pm_runtime_get_sync() during the ->probe() path to explicitly
> >> >> power up a PM domain, is not suitable as the _common_ solution to
> >> >> solve the race condition. It certainly may work for some scenarios,
> >> >> but not for those I am looking at.
> >> >
> >> > I think, however, that it might work if the core calls pm_runtime_get_sync()
> >> > from driver_probe_device().
> >>
> >> Currently this won't work.
> >>
> >> That's because the buses' ->probe() are invoked in this path and they
> >> are doing the attachment of the device to its PM domain.
> >>
> >> In other words, we can't power up the PM domain using
> >> pm_runtime_get_sync(), until the device has been attached to its PM
> >> domain. Right?
> >
> >
> > I think this is one of the issues that we have there. Why do we conflate
> > probing and placing the device into a power domain? The latter should
> > happen when we register the device. The fact that a device was probed
> > and has a driver bound or not bound to it should have no bearing on
> > whether the device is member of power domain or not.
> 
> Devices that are created while "discoverable buses" are being probed
> can't be attached to a PM domain before the probing is done, because
> those simply doesn't exist.

Honestly, I'm not sure what you're talking about.

Devices on a "discoverable* bus (say PCI) are added when the *controller* is
probed, not when *they* are probed.

You very much need to have a struct device registered to be able to call
really_probe() for it.

> Now, I haven't yet seen a demand for such a cases, but it seems wrong
> to not consider them. The current solution cover these.

Oh dear.  Please rethink this.

Rafael
