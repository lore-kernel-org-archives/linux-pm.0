From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [linux-pm] [RFC] the generic thermal layer enhancement
Date: Thu, 31 May 2012 14:06:07 +0300
Message-ID: <20120531110607.GB3673@besouro>
References: <1338367742.1472.128.camel@rui.sh.intel.com>
 <1338367860.1472.129.camel@rui.sh.intel.com>
 <20120530103006.GA3261@besouro>
 <4D68720C2E767A4AA6A8796D42C8EB5912C976@BGSMSX101.gar.corp.intel.com>
 <20120530111729.GC3261@besouro>
 <1338435161.1472.205.camel@rui.sh.intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1338435161.1472.205.camel@rui.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: eduardo.valentin@ti.com, "R, Durgadoss" <durgadoss.r@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "Brown, Len" <len.brown@intel.com>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>, jean.pihet@newoldbits.com, Jean Delvare <jdelvare@suse.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

hello,

On Thu, May 31, 2012 at 11:32:41AM +0800, Zhang Rui wrote:
> On =E4=B8=89, 2012-05-30 at 14:17 +0300, Eduardo Valentin wrote:
> > Hello Durga,
> >=20
> > On Wed, May 30, 2012 at 11:05:18AM +0000, R, Durgadoss wrote:
> > > Hi Eduardo,
> > >=20
> > > >=20
> > > > For G1+G2, I agree with your proposal. I had some discussion wi=
th Amit
> > > > regarding this. In his series of patches we increase / decrease=
 the cooling
> > > > device state linearly and steadily.
> > > >=20
> > > > But if we would have what you are saying, we could bind cooling=
 device
> > > > set of states with trip points.
> > >=20
> > > True, We want to bind the levels of cooling with the trips points=
 a thermal zone has.
> > > But we might not get a 1-1 mapping always.
> >=20
> > Just to make sure we are all taking the same thing.
> >=20
> > In this case a cooling device would have 1-N states. And this set c=
ould
> > be partitioned and each partition would be assigned to a specific t=
rip point
> > of a thermal zone, right?
> >=20
> yep.
> BTW, Overlaps should be possible and we should handle this as well.
> >=20
> >=20
> > >=20
> > > >=20
> > > > I fully support this option and could cook up something on this=
=2E
> > > > The TC1 and TC2 should go inside the .get_trend() callbacks for=
 ACPI.
> > > > Should probably go away from the registration function that we =
have
> > > > currently.
> > >=20
> > > I realize I just said the same thing :-)
> >=20
> > Cool :-)
> >=20
> > >=20
> > > >=20
> > > > We could have generic trending computation though. Based on tim=
estamping
> > > > and temperature reads, and make it available for zones that wan=
t to used it.
> > >=20
> > > Agree, but I would like this go into the platform thermal drivers=
=2E And then when
> > > those drivers notify the framework they can specify the trend als=
o. This sort of
> > > notification is not there, but that is what I am implementing the=
se days..
> > > Hope to submit this patch in a week's time..
> >=20
> > Nice, I actually have something being cooked for the same thing. We=
 should probably
> > align to avoid work duplication...
> >=20
> Hah, seems a lot of work is in progress in this area.
>=20
> > >=20
> > > > > >     case THERMAL_TRIP_ACTIVE:
> > > > > >     case THERMAL_TRIP_PASSIVE:
> > > > > >          ...
> > > > > >          tz->ops->get_trend();
> > > >=20
> > > > Would the get_trend take into account if we are cooling with ac=
tive or passive
> > > > cooling device?
> > >=20
> > > To me, it does not matter. It is up to the framework to decide an=
d throttle,
> > > the respective cooling devices according to the trend.
> >=20
> > OK. For me it doesn't really matter as well. Having a simplified zo=
ne update is better.
> >=20
> > >=20
> > > >=20
> > > > > >          if (trend =3D=3D HEATING)
> > > > > >                  cdev->ops->set_cur_state(cdev, cur_state++=
);
> > > > > >          else if (trend =3D=3D COOLING)
> > > > > >                  cdev->ops->set_cur_state(cdev, cur_state--=
);
> > > > > >          break;
> > > >=20
> > > > I believe we should have something for temperature stabilizatio=
n there as well.
> > > >=20
> > > > Besides, if we go with this generic policy, then the zone updat=
e would be much
> > > > simpler no?
> > >=20
> > > Yes, and that=E2=80=99s what we want too  :-)
> >=20
> > Nice!
> >=20
> > >=20
> > > > Here are some other thoughts:
> > > > G6. Another point is, would it make sense to allow for policy e=
xtension? Meaning,
> > > > the zone update would call a callback to request for update fro=
m the zone
> > > > device driver?
> > > >=20
> > > > G7. How do we solve cooling devices being shared between differ=
ent thermal
> > > > zones?
> > > > Should we have a better cooling device constraint management?
> > >=20
> > > This is another thing that was haunting me for quite some time.
> > > And What I have in mind is a mapping kind of thing in the platfor=
m layer,
> > > that will provide details about which cooling device is shared wi=
th whom.
> > > The framework can then use this and figure out the association am=
ong various devices.
> > > I am testing it out, and will submit once it comes to a good shap=
e.
> >=20
> > Right, I am not sure we want to go in this direction?
> >=20
> > Maybe a better way would be to have sort of pm/thermal contraint fr=
amework, which
> > would map these per device, at LDM level?
> >=20
> > I am copying Jean-Pihet, he has been working in this front. Jean, a=
ny thoughts?
> >=20
> Durga and I are investigating how to introduce some concepts like
> "influence/weight" to generic thermal layer. :)

What do you mean here? Describing the cooling devices effectiveness on =
each zone and
derive algorithms to act accordingly?

>=20
> thanks,
> rui
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
