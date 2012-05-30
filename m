From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [linux-pm] [RFC] the generic thermal layer enhancement
Date: Wed, 30 May 2012 13:30:27 +0300
Message-ID: <20120530103006.GA3261@besouro>
References: <1338367742.1472.128.camel@rui.sh.intel.com>
 <1338367860.1472.129.camel@rui.sh.intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1338367860.1472.129.camel@rui.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "Brown, Len" <len.brown@intel.com>, amit.kachhap@linaro.org, Jean Delvare <jdelvare@suse.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hello Rui,

Now I copied Amit, for real :-)

I like your proposal, some comments as follow.

On Wed, May 30, 2012 at 04:51:00PM +0800, Zhang Rui wrote:
> On =E4=B8=89, 2012-05-30 at 16:49 +0800, Zhang Rui wrote:
> > Hi, all,
> >=20
> > It is great to see more and more users of the generic thermal layer=
=2E
> > But as we know, the original design of the generic thermal layer co=
mes
> > from ACPI thermal management, and some of its implementation seems =
to be
> > too ACPI specific nowadays.


Good. We have also basic OMAP support, on top of Amit's work. I sent
recently a very basic support.  I will be pushing them, while they evol=
ve.

> >=20
> > Recently I'm thinking of enhance the generic thermal layer so that =
it
> > works well for more platforms.

As you said, for non-ACPI support, the "generic" layer needs some
extension and refactoring to be more generic :-).

> >=20
> > Below are some thoughts of mine, after reading the patches from Ami=
t
> > Daniel Kachhap, and ACPI 3.0 thermal model. Actually, I have starte=
d
> > coding some RFC patches. But I do really want to get feedback from =
you
> > before going on.

OK.

> >=20
> > G1. supporting multiple cooling states for active cooling devices.
> >=20
> >     The current active cooling device supports two cooling states o=
nly,
> >     please refer to the code below, in driver/thermal/thermal_sys.c
> >                 case THERMAL_TRIP_ACTIVE:
> >                         ...
> >                         if (temp >=3D trip_temp)
> >                                 cdev->ops->set_cur_state(cdev, 1);
> >                         else
> >                                 cdev->ops->set_cur_state(cdev, 0);
> >                         break;
> >=20
> >     This is an ACPI specific thing, as our ACPI FAN used to support
> >     ON/OFF only.
> >     I think it is reasonable to support multiple active cooling sta=
tes
> >     as they are common on many platforms, and note that this is als=
o
> >     true for ACPI 3.0 FAN device (_FPS).
> >=20
> > G2. introduce cooling states range for a certain trip point
> >=20
> >     This problem comes with the first one.
> >     If the cooling devices support multiple cooling states, and sur=
ely
> >     we may want only several cooling states for a certain trip poin=
t,
> >     and other cooling states for other active trip points.
> >     To do this, we should be able to describe the cooling device
> >     behavior for a certain trip point, rather than for the entire
> >     thermal zone.

=46or G1+G2, I agree with your proposal. I had some discussion with Ami=
t
regarding this. In his series of patches we increase / decrease the coo=
ling
device state linearly and steadily.

But if we would have what you are saying, we could bind cooling device
set of states with trip points.

> >=20
> > G3. kernel thermal passive cooling algorithm
> >=20
> >     Currently, tc1 and tc2 are hard requirements for kernel passive
> >     cooling. But non-ACPI platforms do not have this information
> >     (please correct me if I'm wrong).
> >     Say, for the patches here
> >     http://marc.info/?l=3Dlinux-acpi&m=3D133681581305341&w=3D2
>=20
> Sorry, forgot to cc Amit, the author of this patch set.
>=20
> thanks,
> rui
> >     They just want to slow down the processor when current temperat=
ure
> >     is higher than the trip point and speed up the processor when t=
he
> >     temperature is lower than the trip point.
> >=20
> >     According to Matthew, the platform drivers are responsible to
> >     provide proper tc1 and tc2 values to use kernel passive cooling=
=2E
> >     But I'm just wondering if we can use something instead.
> >     Say, introduce .get_trend() in thermal_zone_device_ops.
> >     And we set cur_state++ or cur_state-- based on the value return=
ed
> >     by .get_trend(), instead of using tc1 and tc2.

I fully support this option and could cook up something on this.
The TC1 and TC2 should go inside the .get_trend()=C2=A0callbacks for AC=
PI.
Should probably go away from the registration function that we have
currently.

We could have generic trending computation though. Based on timestampin=
g
and temperature reads, and make it available for zones that want to use=
d it.

> >=20
> > G4. Multiple passive trip points
> >=20
> >     I get this idea also from the patches at
> >     http://marc.info/?l=3Dlinux-acpi&m=3D133681581305341&w=3D2
> >=20
> >     IMO, they want to get an acceptable performance at a tolerable
> >     temperature.
> >     Say, a platform with four P-states. P3 is really low.
> >     And I'm okay with the temperature at 60C, but 80C? No.
> >     With G2 resolved, we can use processor P0~P2 for Passive trip p=
oint
> >     0 (50C), and P3 for Passive trip point 1 (70C). And then the
> >     temperature may be jumping at around 60C or even 65C, without
> >     entering P3.

Yeah, I guess we need to solve G1+G2 first to allow this. But I also ag=
ree
that ideally, there should be possibility to have multiple passive trip=
 points.

> >=20
> >     Further more, IMO, this also works for ACPI platforms.
> >     Say, we can easily change p-state to cool the system, but using
> >     t-state is definitely what we do not want to see. The current
> >     implementation does not expose this difference to the generic
> >     thermal layer, but if we can have two passive trip points, and =
use
> >     p-state for the first one only... (this works if we start polli=
ng
> >     after entering passive cooling mode, without hardware notificat=
ion)
> >=20
> > G5. unify active cooling and passive cooling code
> >=20
> >     If G4 and G5 are resolved, a new problem to me is that there is=
 no
> >     difference between passive cooling and active cooling except th=
e
> >     cooling policy.

OK...

> >     Then we can share the same code for both active and passive coo=
ling.
> >     maybe something like:
> >=20
> >     case THERMAL_TRIP_ACTIVE:
> >     case THERMAL_TRIP_PASSIVE:
> >          ...
> >          tz->ops->get_trend();

Would the get_trend take into account if we are cooling with active or =
passive
cooling device?

> >          if (trend =3D=3D HEATING)
> >                  cdev->ops->set_cur_state(cdev, cur_state++);
> >          else if (trend =3D=3D COOLING)
> >                  cdev->ops->set_cur_state(cdev, cur_state--);
> >          break;

I believe we should have something for temperature stabilization there =
as well.

Besides, if we go with this generic policy, then the zone update would =
be much
simpler no?

> >=20
> > Here are the gaps in my point of view, I'd like to get your ideas a=
bout
> > which are reasonable and which are not.

Here are some other thoughts:
G6. Another point is, would it make sense to allow for policy extension=
? Meaning,
the zone update would call a callback to request for update from the zo=
ne
device driver?

G7. How do we solve cooling devices being shared between different ther=
mal zones?
Should we have a better cooling device constraint management?

G8. On same topic as G7, how are we currently making sure that thermal =
constraints
don't get overwritten by, let's say, userspace APIs? I guess the generi=
c CPU cooling
propose by Amit suffers of an issue. If user sets cpufreq governor to u=
serspace
and sets the frequency to its maximum, say in a busy loop, the thermal =
cooling
could potentially be ruined.

G9. Is there any possibility to have multiple sensors per thermal zone?

G10. Do we want to represent other sensing stimuli other that temperatu=
re? Say,
current sensing?

G11. Do we want to allow for cross zoning policies? Sometimes a policy =
may use
temperature from different thermal zone in order to better represent wh=
at
is going on in its thermal zone.

> >=20
> > Any comments are appreciated! Thanks!


Thanks to you for starting this up! The above are points that come to m=
y mind now.
I will keep updating the list if something else come to my mind.

> >=20
> > -rui
> >=20
> > _______________________________________________
> > linux-pm mailing list
> > linux-pm@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/linux-pm
>=20
>=20
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-pm

All best,

---
Eduardo Valentin
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
