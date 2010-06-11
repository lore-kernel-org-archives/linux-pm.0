From: mark gross <640e9920@gmail.com>
Subject: Re: PM QoS dynamic resource manager
Date: Fri, 11 Jun 2010 06:55:52 -0700
Message-ID: <20100611135552.GA10117@gvim.org>
References: <alpine.DEB.2.00.1005211533530.25765@pchidamb-lnx.qualcomm.com>
	<20100525145223.GA4974@gvim.org>
	<AANLkTikLgu2c1GPE3glHLlaznOM59SVeCj2NHzDjyjZR@mail.gmail.com>
	<20100608033333.GA23066@gvim.org>
	<AANLkTinGBvZm870CsjocsCV1SmQ-FCCbJLtKWR1juB1Q@mail.gmail.com>
	<4C0ECC38.2000003@codeaurora.org> <20100609030525.GD26668@gvim.org>
	<AANLkTimu7-8CZUbA2lNuYauZDoOuiBJI_v3cSIF9qqul@mail.gmail.com>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTimu7-8CZUbA2lNuYauZDoOuiBJI_v3cSIF9qqul@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mike Chan <mike@android.com>
Cc: linux-pm@lists.linux-foundation.org, mark gross <640e9920@gmail.com>, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 09, 2010 at 05:53:53PM -0700, Mike Chan wrote:
> On Tue, Jun 8, 2010 at 8:05 PM, mark gross <640e9920@gmail.com> wrote:
> > On Tue, Jun 08, 2010 at 04:03:20PM -0700, Bryan Huntsman wrote:
> >> >>http://lkml.org/lkml/2010/4/22/213 =A0(I guess the details are in the
> >> >>archives) =A0I'm happy to re-visit it.
> >> >>
> >> >
> >> >Interesting patch, it looks like having a "system wide bus" doesn't
> >> >easily apply to msm and tegra platforms.
> >> >An example of some things I would like to be able to control are i2c
> >> >and memory bus.
> >> >
> >> >I'm tempted to suggest adding two types memory and i2c but I'm not
> >> >sure how future proof this will be given the growing complexity in the
> >> >embedded hardware road-map.
> >> >What about the possibility of registering not one but several buses?
> >> >You could add a bus qos param, with a type enum, or bind to some
> >> >platform_driver or bus_driver
> >> >
> >> >Then there's the issue of having to deal with platform specific buses,
> >> >do you add this type to pm qos with only one user? Or have some
> >> >platform bus types defined somewhere. The generic code of min / max
> >> >for resource X can be useful so everyone doesn't spin their own
> >> >resource framework in their own architecture.
> >> >
> >> >-- Mike
> >>
> >> Mike, one idea I'm exploring is having platform-specific busses with
> >> QoS constraints specified via runtime_pm as part of the LDM. =A0Adding
> >> dynamic class creation within pm_qos, or a type enum as you suggest,
> >> would work. =A0However, I think this kind of behavior would fit nicely
> >> within runtime_pm.
> >>
> >
> > Something like that is what Kevin Hilman was thinking too. =A0It would
> > bring a qos concept to the LDM for each bus driver object. =A0Picking w=
hat
> > qos parameters to use (I recommend latency and bandwidth) and how "loca=
l"
> > the parameters effect of these bus_qos interfaces are.
> >
> =

> Are you thinking of having a (possible) pm qos constraint for each
> struct device_driver? Or struct bus_type ? This would probably work if

I'm thinking ever struct bus_type at the moment, but really this is
somehting hat has been getting handwaving at so far.

> for something like i2c. I'm not sure how this would work for memory
> bus. If you did not want to tie memory bus performance to cpu speeds,
> since (at least from what I"ve seen in omap / msm / tegra) there's no
> device_driver for a memory bus clock, but I could be wrong so someone
> correct me if I'm mistaken.

it hasn't been thought out yet by me yet, WRT dependency expressions
that have more global scope than a given bus like what I think you are
talking about.

--mgross

> =

> Typically I've seen (on msm / tegra / omap) if cpu is running at
> frequency X, then set mem bus clock to Y. Which leads to a bunch of
> hacks with drivers requesting frequency X, when really they need the
> faster memory speed.
> =

> Perhaps both per bus-type pm qos parameter as well as a new global
> memory bus (per cpu for numa systems?) parameter.
> =

> I'm worried about trying to over-engineer a solution here for
> non-existing (or non-interested) customers. Ideally something that
> will fit our needs with Android on msm / omap / tegra platforms but
> still flexible enough for non-SOC.
> =

> -- Mike
> =

> > They are not the same as the more global system wide pm_qos parameters,
> > and they would be unlikely things ever exposed to usermode.
> >
> =

> I don't think we care about exposing this to userspace for our needs.
> =

> > Yes I think something like this is inevitable and will happen. =A0But we
> > need some good applications to roll out the idea with. =A0(I think.)
> >
> =

> =

> =

> > --mgross
> >
> >
