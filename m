From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v2 10/11] dt-bindings: misc: add bindings for
 cros_ec_throttler
Date: Tue, 12 Jun 2018 19:00:37 -0700
Message-ID: <20180613020037.GK88063@google.com>
References: <20180607181214.30338-1-mka@chromium.org>
 <20180607181214.30338-11-mka@chromium.org>
 <20180612191011.GA26266@rob-hp-laptop>
 <20180612204018.GB99983@rodete-desktop-imager.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180612204018.GB99983@rodete-desktop-imager.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Rob Herring <robh@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 12, 2018 at 01:40:22PM -0700, Brian Norris wrote:
> Hi Rob,
> 
> On Tue, Jun 12, 2018 at 01:10:11PM -0600, Rob Herring wrote:
> > On Thu, Jun 07, 2018 at 11:12:13AM -0700, Matthias Kaehlcke wrote:
> > > The cros_ec_throttler monitors events from the Chrome OS Embedded
> > > Controller to throttle the system if needed, using the mechanisms
> > > provided by the throttler core.
> > > 
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > > Changes in v2:
> > > - patch added to series
> > > 
> > >  Documentation/devicetree/bindings/misc/cros_ec_throttler.txt | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/misc/cros_ec_throttler.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/misc/cros_ec_throttler.txt b/Documentation/devicetree/bindings/misc/cros_ec_throttler.txt
> > > new file mode 100644
> > > index 000000000000..7316dcc0ef75
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/misc/cros_ec_throttler.txt
> > > @@ -0,0 +1,4 @@
> > > +* cros_ec_throttler driver
> > 
> > Bindings are for h/w, not drivers.
> 
> (OK, sure, don't call this "driver". And maybe this could use some more
> description about what kind of events are emitted by this sort of
> device.)
> 
> > I continue to fail to see why this needs to be in DT. There are other 
> > ways to instantiate drivers.
> 
> This is mostly relevant to:
> [PATCH v2 08/11] dt-bindings: PM / OPP: add opp-throttlers property
> 
> so it's probably good to take a look at that one too.
> 
> The primary purpose is to have a target to point at when determining who
> is the source of throttling. This is similar to other CrOS EC subdevices
> (e.g., PWM) where we technically don't require a subnode (the EC
> firmware can its own PWM hardware without DT), but it is important that,
> e.g., a backlight device has something to point at when it's using a PWM
> attached to the EC. So we have a PWM subnode.
> 
> In this case, we're a little vague about what exactly the hardware is
> here, but there *is* hardware that's emitting "throttle" events (hint:
> here, it's related to sensing too high of system current). This is all
> abstracted by firmware, which simply tells us we need to scale back our
> power usage.
> 
> So, what do you think of patch 8? Should OPPs have phandles to such a
> throttler? If so, should the phandle just point at the main EC device
> (see mfd/cros-ec.txt), or is it reasonable to have a subnode to
> represent something more specific?
>
> Or maybe this is entirely on the wrong track. But this is the resulting
> proposal after your comments on v1, so it's probably best we have a
> clearer overall review of what makes sense here, so we don't just go in
> cycles on new proposals that get rejected.

I also think we need to clarify if this is the right direction. Since
Rob proposed the OPP hints and didn't object when I replied with the
opp-throttlers example I assumed he was ok with it.
