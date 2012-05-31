From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [linux-pm] [RFC] the generic thermal layer enhancement
Date: Thu, 31 May 2012 10:20:52 +0800
Message-ID: <1338430852.1472.175.camel@rui.sh.intel.com>
References: <1338367742.1472.128.camel@rui.sh.intel.com>
	 <1338367860.1472.129.camel@rui.sh.intel.com>
	 <20120530103006.GA3261@besouro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20120530103006.GA3261@besouro>
Sender: linux-acpi-owner@vger.kernel.org
To: eduardo.valentin@ti.com
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "Brown, Len" <len.brown@intel.com>, amit.kachhap@linaro.org, Jean Delvare <jdelvare@suse.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi, Eduardo,

On =E4=B8=89, 2012-05-30 at 13:30 +0300, Eduardo Valentin wrote:
> > >=20
> > > G1. supporting multiple cooling states for active cooling devices=
=2E
> > >=20
> > >     The current active cooling device supports two cooling states=
 only,
> > >     please refer to the code below, in driver/thermal/thermal_sys=
=2Ec
> > >                 case THERMAL_TRIP_ACTIVE:
> > >                         ...
> > >                         if (temp >=3D trip_temp)
> > >                                 cdev->ops->set_cur_state(cdev, 1)=
;
> > >                         else
> > >                                 cdev->ops->set_cur_state(cdev, 0)=
;
> > >                         break;
> > >=20
> > >     This is an ACPI specific thing, as our ACPI FAN used to suppo=
rt
> > >     ON/OFF only.
> > >     I think it is reasonable to support multiple active cooling s=
tates
> > >     as they are common on many platforms, and note that this is a=
lso
> > >     true for ACPI 3.0 FAN device (_FPS).
> > >=20
> > > G2. introduce cooling states range for a certain trip point
> > >=20
> > >     This problem comes with the first one.
> > >     If the cooling devices support multiple cooling states, and s=
urely
> > >     we may want only several cooling states for a certain trip po=
int,
> > >     and other cooling states for other active trip points.
> > >     To do this, we should be able to describe the cooling device
> > >     behavior for a certain trip point, rather than for the entire
> > >     thermal zone.
>=20
> For G1+G2, I agree with your proposal. I had some discussion with Ami=
t
> regarding this. In his series of patches we increase / decrease the c=
ooling
> device state linearly and steadily.
>=20
> But if we would have what you are saying, we could bind cooling devic=
e
> set of states with trip points.
>=20
Great.
But further more, IMO, with G3/G4 solved, this patch set can use passiv=
e
trip points instead of active trip points for processors, right?

> > >=20
> > > G3. kernel thermal passive cooling algorithm
> > >=20
> > >     Currently, tc1 and tc2 are hard requirements for kernel passi=
ve
> > >     cooling. But non-ACPI platforms do not have this information
> > >     (please correct me if I'm wrong).
> > >     Say, for the patches here
> > >     http://marc.info/?l=3Dlinux-acpi&m=3D133681581305341&w=3D2
> >=20
> > Sorry, forgot to cc Amit, the author of this patch set.
> >=20
> > thanks,
> > rui
> > >     They just want to slow down the processor when current temper=
ature
> > >     is higher than the trip point and speed up the processor when=
 the
> > >     temperature is lower than the trip point.
> > >=20
> > >     According to Matthew, the platform drivers are responsible to
> > >     provide proper tc1 and tc2 values to use kernel passive cooli=
ng.
> > >     But I'm just wondering if we can use something instead.
> > >     Say, introduce .get_trend() in thermal_zone_device_ops.
> > >     And we set cur_state++ or cur_state-- based on the value retu=
rned
> > >     by .get_trend(), instead of using tc1 and tc2.
>=20
> I fully support this option and could cook up something on this.
> The TC1 and TC2 should go inside the .get_trend() callbacks for ACPI.
> Should probably go away from the registration function that we have
> currently.
>=20
> We could have generic trending computation though. Based on timestamp=
ing
> and temperature reads, and make it available for zones that want to u=
sed it.
>=20
Agreed.
I already have this patch in hand.

> > >=20
> > > G4. Multiple passive trip points
> > >=20
> > >     I get this idea also from the patches at
> > >     http://marc.info/?l=3Dlinux-acpi&m=3D133681581305341&w=3D2
> > >=20
> > >     IMO, they want to get an acceptable performance at a tolerabl=
e
> > >     temperature.
> > >     Say, a platform with four P-states. P3 is really low.
> > >     And I'm okay with the temperature at 60C, but 80C? No.
> > >     With G2 resolved, we can use processor P0~P2 for Passive trip=
 point
> > >     0 (50C), and P3 for Passive trip point 1 (70C). And then the
> > >     temperature may be jumping at around 60C or even 65C, without
> > >     entering P3.
>=20
> Yeah, I guess we need to solve G1+G2 first to allow this.

yes.

>  But I also agree
> that ideally, there should be possibility to have multiple passive tr=
ip points.
>=20

I think this is still an open question for Amit.

As I mentioned above, the idea comes from Amit's patch set, and what I'=
m
doing here is to try to make the passive cooling implementation works
well on exynos platforms.
As we know, in his patch set, MONITOR_ZONE and WARN_ZONE are mapped to
active trip points. But actually, with G2/G3/G4 solved, they SHOULD be
passive trip points as all the cooling devices are processors, right?

So, my question, and probably this is also the question from Matthew,
would be:
Why we need two passive trip points?
What if we use all p-state for MONITOR_ZONE and discard the WARN_ZONE?

I'd like to see Amit's explanation on this. :)

> > >=20
> > >     Further more, IMO, this also works for ACPI platforms.
> > >     Say, we can easily change p-state to cool the system, but usi=
ng
> > >     t-state is definitely what we do not want to see. The current
> > >     implementation does not expose this difference to the generic
> > >     thermal layer, but if we can have two passive trip points, an=
d use
> > >     p-state for the first one only... (this works if we start pol=
ling
> > >     after entering passive cooling mode, without hardware notific=
ation)
> > >=20
> > > G5. unify active cooling and passive cooling code
> > >=20
> > >     If G4 and G5 are resolved, a new problem to me is that there =
is no
> > >     difference between passive cooling and active cooling except =
the
> > >     cooling policy.
>=20
> OK...
>=20
> > >     Then we can share the same code for both active and passive c=
ooling.
> > >     maybe something like:
> > >=20
> > >     case THERMAL_TRIP_ACTIVE:
> > >     case THERMAL_TRIP_PASSIVE:
> > >          ...
> > >          tz->ops->get_trend();
>=20
> Would the get_trend take into account if we are cooling with active o=
r passive
> cooling device?
>=20
YES.
We need this as a hint for active/passive cooling management.
But how it actually works depends on the implementation of
the .get_trend callback in the platform driver.

Say, for active trip points,
=2Eget_trend can always return HEATING, so that fan will start to run
faster and faster when the temperature keeps higher than the trip point=
=2E
Or it can return COOLING when cur_temperature < last_temperature, so
that the fan will slow down when the temperature is dropping, but still
higher than the trip point.

> > >          if (trend =3D=3D HEATING)
> > >                  cdev->ops->set_cur_state(cdev, cur_state++);
> > >          else if (trend =3D=3D COOLING)
> > >                  cdev->ops->set_cur_state(cdev, cur_state--);
> > >          break;
>=20
> I believe we should have something for temperature stabilization ther=
e as well.
>=20
> Besides, if we go with this generic policy, then the zone update woul=
d be much
> simpler no?
>=20
Agree with Durga.

> > >=20
> > > Here are the gaps in my point of view, I'd like to get your ideas=
 about
> > > which are reasonable and which are not.
>=20
> Here are some other thoughts:
> G6. Another point is, would it make sense to allow for policy extensi=
on? Meaning,
> the zone update would call a callback to request for update from the =
zone
> device driver?
>=20
I'm not against this idea. But do we really have a request for such a
case?
And BTW, if we really have such a request, I think the first thing to d=
o
is to investigate if this is a general request that should be
implemented in the generic thermal layer, rather than go to the zone
device driver directly?

> G7. How do we solve cooling devices being shared between different th=
ermal zones?
> Should we have a better cooling device constraint management?
>=20
Maybe we just need a simple Arbitrator in kernel?

When changing a cooling device state, it can only override the cur_stat=
e
value for the current cooling device instance!
And the code should parse all the cooling device instance of this
cooling device, and choose the deepest cooling state.

what do you think?

> G8. On same topic as G7, how are we currently making sure that therma=
l constraints
> don't get overwritten by, let's say, userspace APIs?

what kind of userspace APIs can change this?

> I guess the generic CPU cooling
> propose by Amit suffers of an issue. If user sets cpufreq governor to=
 userspace
> and sets the frequency to its maximum, say in a busy loop, the therma=
l cooling
> could potentially be ruined.
>=20
that's true, but I don't think that's the case we need to cover.

Setting cpufreq governor to "Userspace" means user needs to be
responsible for the p-state controlling. If the system overheats, that'=
s
the thing that the user needs to worry about.

> G9. Is there any possibility to have multiple sensors per thermal zon=
e?
>=20
I do not think we need to consider this situation, until there is such
an requirement.

> G10. Do we want to represent other sensing stimuli other that tempera=
ture? Say,
> current sensing?
>=20
what do you mean by "current sensing"?

> G11. Do we want to allow for cross zoning policies? Sometimes a polic=
y may use
> temperature from different thermal zone in order to better represent =
what
> is going on in its thermal zone.
>=20
Good question. This bothered me a lot actually.

Each zone device just represents a certain part of the overall system,
and these different zones may interact with each other.
But the current implementation does not take care of this.
Unfortunately I do not have any ideas about this yet. :)

> > >=20
> > > Any comments are appreciated! Thanks!
>=20
>=20
> Thanks to you for starting this up! The above are points that come to=
 my mind now.
> I will keep updating the list if something else come to my mind.
>=20
They are all good points, thank you for your valuable feedback, Eduardo=
!

-rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
