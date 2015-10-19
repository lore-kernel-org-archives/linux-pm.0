From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [GIT PULL] On-demand device probing
Date: Mon, 19 Oct 2015 17:45:14 +0100
Message-ID: <20151019164513.GP32532@n2100.arm.linux.org.uk>
References: <20151018192931.GY14956@sirena.org.uk>
 <20151018193757.GA9147@kroah.com>
 <20151018195330.GB14956@sirena.org.uk>
 <CAAObsKB2BUZ-smid45wOdAQw6h2yNqCydk+azAFNk69ewHJtZQ@mail.gmail.com>
 <20151019131821.GA32532@n2100.arm.linux.org.uk>
 <CAAObsKDS_+AZ26P_fHc6pvAYrQotsuoO0DEGQUWC514t3DD_jQ@mail.gmail.com>
 <20151019143045.GE32532@n2100.arm.linux.org.uk>
 <CAAObsKDWM6A98tdKHqi4fe5DBf0BmB0JeghcZDWan_PYbyshag@mail.gmail.com>
 <20151019153548.GM32532@n2100.arm.linux.org.uk>
 <CAMuHMdVv=ieYM-Nehp0qV8CEggHEeJ22j-6i_N09rRA_U=2ePw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdVv=ieYM-Nehp0qV8CEggHEeJ22j-6i_N09rRA_U=2ePw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@g>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 19, 2015 at 06:21:40PM +0200, Geert Uytterhoeven wrote:
> Hi Russell,
> 
> On Mon, Oct 19, 2015 at 5:35 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >> > What you can do is print those devices which have failed to probe at
> >> > late_initcall() time - possibly augmenting that with reports from
> >> > subsystems showing what resources are not available, but that's only
> >> > a guide, because of the "it might or might not be in a kernel module"
> >> > problem.
> >>
> >> Well, adding those reports would give you a changelog similar to the
> >> one in this series...
> >
> > I'm not sure about that, because what I was thinking of is adding
> > a flag which would be set at late_initcall() time prior to running
> > a final round of deferred device probing.
> 
> Which round is the final round?

I said "a" not "the".  Maybe I should've said "one last round of deferred
probing before entering userspace".

> That's the one which didn't manage to bind any new devices to drivers,
> which is something you only know _after_ the round has been run.
> 
> So I think we need one extra round to handle this.

Yes - because the idea is that we do everything we do today without
printing anything about deferred probes.  We then set a flag which
indicates we should report defers, and then we trigger another round
of probes.

If everything probed successfully, the deferred probe list will be
empty and nothing will be seen.  Otherwise, we should end up with a
report of all the devices that weren't able to be bound to their
drivers due to -EPROBE_DEFER.

> 
> > This flag would then be used in a deferred_warn() printk function
> > which would normally be silent, but when this flag is set, it would
> > print the reason for the deferral - and this would replace (or be
> > added) to the subsystems and drivers which return -EPROBE_DEFER.
> >
> > That has the effect of hiding all the deferrals up until just before
> > launching into userspace, which should then acomplish two things -
> > firstly, getting rid of the rather useless deferred messages up to
> > that point, and secondly printing the reason why the remaining
> > deferrals are happening.
> >
> > That should be a small number of new lines plus a one-line change
> > in subsystems and drivers.
> 
> Apart from the extra round we probably can't get rid of, that sounds
> OK to me.

Yes, it means a little longer to boot, but if there's nothing pending
this _should_ only be microseconds - it should be nothing more than
setting the flag, possibly taking and releasing a lock, and checking
that the deferred probe list is empty.

Of course, if the deferred probe list isn't empty, then there'll be
more expense - but I'm willing to bet that for those developers with
serial console enabled, the kernel boot will be faster overall due
to the reduced number of characters printed during the boot.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
