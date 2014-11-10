From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] PM / Domains: Fix initial default state of the
 need_restore flag
Date: Mon, 10 Nov 2014 10:32:24 -0800
Message-ID: <20141110183224.GA5626@dtor-ws>
References: <1415366847-4807-1-git-send-email-ulf.hansson@linaro.org>
 <7hr3xerdw6.fsf@deeprootsystems.com>
 <20141107215751.GA4439@dtor-ws>
 <CAPDyKFot-LZjazq190cY3-tawB_-ukdsmrLcD3vtidLvX68FOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFot-LZjazq190cY3-tawB_-ukdsmrLcD3vtidLvX68FOg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 10, 2014 at 04:18:50PM +0100, Ulf Hansson wrote:
> [...]
> 
> > I guess we do need it for 3.18, but when we are talking about 3.19,
> > before we make any more changes can we outline how power domains are
> > supposed to work?
> >
> > 1. How do we attach a device to power domain? Right now it seems that
> > individual buses are responsible for attaching their devices to power
> > domains. Should we move it into driver core (device_pm_add?) so that
> > device starts its life in its proper power domain?
> 
> That was the initial approach.
> 
> To my understanding, Rafael's primary reason for not accepting that
> was that it's not common, but it's platform-specific.
> http://marc.info/?l=linux-pm&m=140243462304669&w=2

I am not sure I agree with Rafael there:

 - when we are talking about the latest incarnation of power domains it
   is not really platform specific anymore (as it was when we were
   dealing with ACPI only case);

- I do not see why sirincling platform specific code around i2c, spi,
  etc bus code (which is not platform-specific) is OK, but a no-no for
  the driver ocre.

> 
> Now, even if we would reconsider doing as you propose, what would the
> actual benefit be? Obviously, we would get less amount of code to
> maintain, which is one reason, but are there more?

I think so - you would have complete picture of your power domain,
including data exposed in debugfs, etc.

> 
> >
> > 2. When do we power up the devices (and the domains)? Right now devices
> > in ACPI power domain are powered when they are attached to the power
> > domain (which coincides with probing), but generic power domains do not
> > do that. Can we add a separate API to explicitly power up the device (and
> > its domain if it is powered down) and do it again, either in device core
> > or in individual buses. This way, regardless of runtime PM or not, we
> > will have devices powered on when driver tries to bind to them. If
> > binding fails we can power down the device.
> 
> Isn't that exactly what I implemented in [1], what am I missing?

Hm, OK. I guess the title of the patch series thrown me off because as
far as I am concerned it is not a race, we simply were not powering the
domain properly for probing.

Thanks.

-- 
Dmitry
