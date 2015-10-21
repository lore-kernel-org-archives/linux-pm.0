From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Alternative approach to solve the deferred probe
Date: Wed, 21 Oct 2015 09:18:47 +0100
Message-ID: <20151021081847.GB32532@n2100.arm.linux.org.uk>
References: <20151018195330.GB14956@sirena.org.uk>
 <CAAObsKB2BUZ-smid45wOdAQw6h2yNqCydk+azAFNk69ewHJtZQ@mail.gmail.com>
 <20151019131821.GA32532@n2100.arm.linux.org.uk>
 <CAAObsKDS_+AZ26P_fHc6pvAYrQotsuoO0DEGQUWC514t3DD_jQ@mail.gmail.com>
 <20151019143045.GE32532@n2100.arm.linux.org.uk>
 <CAAObsKDWM6A98tdKHqi4fe5DBf0BmB0JeghcZDWan_PYbyshag@mail.gmail.com>
 <20151019153548.GM32532@n2100.arm.linux.org.uk>
 <CAMuHMdVv=ieYM-Nehp0qV8CEggHEeJ22j-6i_N09rRA_U=2ePw@mail.gmail.com>
 <20151020154656.GY32532@n2100.arm.linux.org.uk>
 <56270D5B.5010902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56270D5B.5010902@gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwo>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 20, 2015 at 08:58:19PM -0700, Frank Rowand wrote:
> On 10/20/2015 8:46 AM, Russell King - ARM Linux wrote:
> > On Mon, Oct 19, 2015 at 06:21:40PM +0200, Geert Uytterhoeven wrote:
> >> Hi Russell,
> >>
> >> On Mon, Oct 19, 2015 at 5:35 PM, Russell King - ARM Linux
> >> <linux@arm.linux.org.uk> wrote:
> >>>>> What you can do is print those devices which have failed to probe at
> >>>>> late_initcall() time - possibly augmenting that with reports from
> >>>>> subsystems showing what resources are not available, but that's only
> >>>>> a guide, because of the "it might or might not be in a kernel module"
> >>>>> problem.
> >>>>
> >>>> Well, adding those reports would give you a changelog similar to the
> >>>> one in this series...
> >>>
> >>> I'm not sure about that, because what I was thinking of is adding
> >>> a flag which would be set at late_initcall() time prior to running
> >>> a final round of deferred device probing.
> >>
> >> Which round is the final round?
> >> That's the one which didn't manage to bind any new devices to drivers,
> >> which is something you only know _after_ the round has been run.
> >>
> >> So I think we need one extra round to handle this.
> >>
> >>> This flag would then be used in a deferred_warn() printk function
> >>> which would normally be silent, but when this flag is set, it would
> >>> print the reason for the deferral - and this would replace (or be
> >>> added) to the subsystems and drivers which return -EPROBE_DEFER.
> >>>
> >>> That has the effect of hiding all the deferrals up until just before
> >>> launching into userspace, which should then acomplish two things -
> >>> firstly, getting rid of the rather useless deferred messages up to
> >>> that point, and secondly printing the reason why the remaining
> >>> deferrals are happening.
> >>>
> >>> That should be a small number of new lines plus a one-line change
> >>> in subsystems and drivers.
> >>
> >> Apart from the extra round we probably can't get rid of, that sounds OK to me.
> > 
> > Something like this.  I haven't put a lot of effort into it to change all
> > the places which return an -EPROBE_DEFER, and it also looks like we need
> > some helpers to report when we have only an device_node (or should that
> > be fwnode?)  See the commented out of_warn_deferred() in
> > drivers/gpio/gpiolib-of.c.  Adding this stuff in the subsystems searching
> > for resources should make debugging why things are getting deferred easier.
> > 
> > We could make driver_deferred_probe_report something that can be
> > deactivated again after the last deferred probe run, and provide the
> > user with a knob that they can turn it back on again.
> > 
> > I've tried this out on two of my platforms, including forcing
> > driver_deferred_probe_report to be enabled, and I get exactly one
> > deferred probe, so not a particularly good test.
> > 
> > The patch won't apply as-is to mainline for all files; it's based on my
> > tree which has some 360 additional patches (which seems to be about
> > normal for my tree now.)
> 
> I like the concept (I have been thinking along similar lines lately).
> But I think this might make the console messages more confusing than
> they are now.

If messages end up being given from the subsystem rather than the driver,
surely they become more consistent?

> The problem is that debug, warn, and error messages
> come from a somewhat random set of locations at the moment.  Some
> come from the driver probe routines and some come from the subsystems
> that the probe routines call.  So the patch is suppressing some
> messages, but not others.

The patch is not complete (read the description above).

> > +void dev_warn_deferred(struct device *dev, const char *fmt, ...)
> > +{
> > +	if (driver_deferred_probe_report) {
> > +		struct va_format vaf;
> > +		va_list ap;
> > +
> > +		va_start(ap, fmt);
> > +		vaf.fmt = fmt;
> > +		vaf.va = &ap;
> > +
> > +		dev_warn(dev, "deferring probe: %pV", &vaf);
> > +		va_end(ap);
> > +	}
> > +}
> > +EXPORT_SYMBOL_GPL(dev_warn_deferred);
> 
> The places where dev_warn_deferred() replaces dev_dbg(), we lose the
> ability to turn on debugging and observe the driver reporting the
> specific reason the deferral is occurring. So it would be useful to
> add an "else dev_dbg()" in dev_warn_deferred() to retain that capability.

That's a possibility.

> 
> > +
> >  static bool driver_deferred_probe_enable = false;
> > +
> >  /**
> >   * driver_deferred_probe_trigger() - Kick off re-probing deferred devices
> >   *
> > @@ -188,6 +210,13 @@ static int deferred_probe_initcall(void)
> >  	driver_deferred_probe_trigger();
> 
> Couldn't you put the "driver_deferred_probe_report = true" here?  And then
> not add another round of probes.

The idea is not to report anything for drivers that were deferred
during the normal bootup.  The above is part of the normal bootup,
and the deferred activity should not be warned about.

If we have any devices still deferring after _this_ round, that must
indicate that some resource they want is not available, and that
should be warned about.

Of course, modules can defer too - and I made some suggestions in my
waffle above the patch about that.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
