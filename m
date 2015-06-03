From: Frans Klaver <frans.klaver@xsens.com>
Subject: Re: [PATCH] sbs-battery: add option to always register battery
Date: Wed, 3 Jun 2015 09:34:08 +0200
Message-ID: <20150603073401.GN9880@ci00147.xsens-tech.local>
References: <1433250883-32245-1-git-send-email-frans.klaver@xsens.com>
 <20150602195036.GD13930@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150602195036.GD13930@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 02, 2015 at 09:50:37PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Jun 02, 2015 at 03:14:43PM +0200, Frans Klaver wrote:
> >
> > In some of these cases you do want to register a battery, even if none
> > are attached at the moment. To facilitate this, add a configuration
> > option to try to talk to the device, defaulting to y, thus keeping the
> > current behavior. If unset, the battery will always be registered
> > without checking the sanity of the connection.
> 
> From my POV registering a power supply driver for an unconnected
> chip is wrong.  It implies to the system, that there actually is
> a battery connected.

I can see your point. The sbs-battery driver already is capable of
detecting whether or not the battery is present, so in a way the system
already knows there is no such battery. The communication test in probe
was added as a way to reduce lag (which our system doesn't suffer from),
and the optional and non-default behavior I propose isn't any different
from what the driver would have done before that patch.


> Also how do you know, that a sbs based battery is connected at some
> point and not some other battery (e.g. a bq27x00 based)?

We know because we specified so. Other batteries will simply not be
detected. Besides that, their controller might register to an i2c
address that is different from our current one, so I'm not sure what
you're aiming for here.

In a way we're implying to the system that a battery _could_ be
available. If there's going to be a battery, it's that one.

This is a situation that is currently easily triggered by booting up
with battery and removing the battery afterwards, by the way. So
behavior can be considered somewhat inconsistent there. How can we know
the sbs-battery will be attached again, rather than some other battery?

As I understand, i2c devices are expected to either be there or not be
there. A removable i2c battery doesn't really fit that expectation,
unless we can rely on the drivers ability to detect device presence,
which at least sbs-battery seems to be doing rather well. Besides that,
I already have to tell the kernel an sbs-battery may be available on
some i2c bus/address through device tree.


> How does the system know, that the battery becomes available?

The sbs-battery driver seems to detect that nicely. I don't know how
bq27x00 behaves, as I don't have that hardware available. That's why I
mentioned that I'd like to know if this should be something that affects
all power sources.


> Note, that userspace interaction does not mean missing hardware
> abstraction. It means missing support for automatic device
> identification. The same is true for serial connected bluetooth
> devices.

I'm not sure. User space interaction is quite broad. I would have much
less trouble accepting 'try to see if this battery is available', rather
than the current 'try to see if something is available on i2c bus 1
address 0x0b (that happens to be the battery that I've already
configured)'. I do not so much oppose the fact that userspace has to
tell when to try and probe. I do have a (conceptual) problem with
userspace having to know stuff that's already passed to the kernel by
different means.

Thanks,
Frans
