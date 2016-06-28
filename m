From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] Documentation: Add sbs-manager device tree node
 documentation
Date: Tue, 28 Jun 2016 15:54:56 -0500
Message-ID: <20160628205456.GB3737@rob-hp-laptop>
References: <1466622436-27963-1-git-send-email-karl-heinz@schneider-inet.de>
 <1466622436-27963-2-git-send-email-karl-heinz@schneider-inet.de>
 <20160624175014.GA29990@rob-hp-laptop>
 <9ccbeeb9-3612-fe07-3396-48da7c832bc6@electromag.com.au>
 <CAL_JsqL38hnQpchy8q+yk1rZQ1ngF4JUwFgN0V=mGyAyAq1GVg@mail.gmail.com>
 <1467061824.9121.33.camel@amnesix>
 <a91f060f-15bf-9506-067e-7e96cb726458@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a91f060f-15bf-9506-067e-7e96cb726458@electromag.com.au>
Sender: linux-acpi-owner@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Rosin <peda@axentia.se>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 28, 2016 at 09:13:21AM +0800, Phil Reid wrote:
> G'day Rob,
> 
> On 28/06/2016 05:10, Karl-Heinz Schneider wrote:
> >Am Sonntag, den 26.06.2016, 09:05 -0500 schrieb Rob Herring:
> >>On Sun, Jun 26, 2016 at 12:21 AM, Phil Reid <preid@electromag.com.au> wrote:
> 
> *Snip*
> 
> 
> >>>>>+- reg: integer, i2c address of the device. Should be <0xa>.
> >>>>>+
> >>>>>+Optional properties:
> >>>>>+- sbsm,i2c-retry-count: integer, number of retries for trying to read or
> >>>>>write
> >>>>>+    to registers. Default: 1
> >>>>
> >>>>
> >>>>Seems like a driver setting. Is having a retry in the driver a problem
> >>>>if the h/w works and never actually needs it?
> >>>
> >>>Similarly the sbs-battery driver specifies the same same retry behaviour.
> >>>And is a model for this implementation.
> >>>
> >>>I've found the ltc1760 and sbs batteries to be problematic when
> >>>communicating to them.
> >>>A lot of drivers (and the associated hardware) don't handle multiple bus
> >>>masters well.
> >>>The bus arbitation doesn't seem to work correctly.
> >>>Retries where the only thing I could do to to get things to work reliably.
> >>>Mostly means the driver needs fixing, but in one case the designware core
> >>>hardware seemed to be the problem for me.
> >>
> >>I'm not questioning the need for a retry. I'm questioning the need to
> >>limit the retries and tune per platform. What would be the issue if
> >>the driver hardcodes the number of retries to 10? This will work for
> >>any h/w that needs 0, 1, 2, ..., or 10 retries. The only issue would
> >>be how long until it errors out.
> >>
> >>And yes, I can confirm DW i2c h/w is a POS at least for some versions.
> >>
> 
> So your suggesting we hardcode the retry value in the driver and not provide a
> configuration option in the binding?

Yes.

> My only thought with allowing a dt setitng to customise the value is it allows the
> integrator to select how many retires they want to try before failing, which kind of
> limits the elapse time until a failure is reported.

It is easier to add later and can't be removed later. If we do want 
something like this, then it should be a common property for i2c 
devices/buses.

Rob
