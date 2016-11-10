From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v5 2/5] driver core: Functional dependencies tracking support
Date: Thu, 10 Nov 2016 09:14:32 +0200
Message-ID: <2305706.WydXUuMppH@avalon>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <CAJZ5v0goccDKSkSAj8+v+PG2gt7ESJuUSbyY8YuW7OwCS_KHXg@mail.gmail.com> <CAB=NE6Xdu5AniWsaJGf3pbYCydahwkStqBV+2xbc8S-Zw+2qiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAB=NE6Xdu5AniWsaJGf3pbYCydahwkStqBV+2xbc8S-Zw+2qiA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lars-Peter Clausen <lars@metafoo.de>, Grant Likely <grant.likely@secretlab.ca>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrzej Hajda <a.hajda@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Luis,

On Wednesday 09 Nov 2016 16:59:30 Luis R. Rodriguez wrote:
> On Wed, Nov 9, 2016 at 4:43 PM, Rafael J. Wysocki wrote:
> > On Mon, Nov 7, 2016 at 10:22 PM, Luis R. Rodriguez wrote:
> >> On Thu, Oct 27, 2016 at 05:25:51PM +0200, Greg Kroah-Hartman wrote=
:
> >>> On Wed, Oct 26, 2016 at 01:19:02PM +0200, Lukas Wunner wrote:
> >>>> Hi Rafael,
> >>>>=20
> >>>> sorry for not responding to v5 of your series earlier, just send=
ing
> >>>> this out now in the hope that it reaches you before your travels=
.
> >>>>=20
> >>>> On Mon, Oct 10, 2016 at 02:51:04PM +0200, Rafael J. Wysocki wrot=
e:
> >>>>> - Modify device_links_check_suppliers(),
> >>>>> device_links_driver_bound(),
> >>>>>=20
> >>>>>   device_links_no_driver(), device_links_driver_cleanup(),
> >>>>>   device_links_busy(), and device_links_unbind_consumers() to w=
alk
> >>>>>   link lists under device_links_lock (to make the new "driver
> >>>>>   presence tracking" mechanism work reliably).
> >>>>
> >>>> This change might increase boot time if drivers return -EPROBE_D=
EFER.
> >>>=20
> >>> "might"?  Please verify this before guessing....
> >>>=20
> >>> And don't make this more complex than needed before actually dete=
rmining
> >>> a real issue.
> >>=20
> >> As clarified by Rafael at Plumbers, this functional dependencies
> >> framework assumes your driver / subsystem supports deferred probe,=

> >=20
> > It isn't particularly clear what you mean by "support" here.
>=20
> I noted some folks had reported issues, and you acknowledged that if
> deferred probe was used in some drivers and if this created an issue
> the same issue would be seen with this framework. AFAICT there are tw=
o
> possible issues to consider:
>=20
> 1) the one Geert Uytterhoeven noted. Again I'll note what he had ment=
ioned
> [0].
>=20
>   "Some drivers / subsystems don=E2=80=99t support deferred probe yet=
, such failures
> usually don=E2=80=99t blow up, but cause subtle malfunctioning. Examp=
le, an
> Ethernet phy could not get its interrupt as the primary IRQ chip had =
not
> been probed yet, it reverted to polling though. Sub-optimal." [0]
>=20
> [0]
> https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2016-Augu=
st/003
> 425.html
>=20
> Geert can you provide more details?

This is a more global issue. In many cases drivers depend on optional=20=

resources. They are able to operate in a degraded mode (reduced feature=
 set,=20
reduced performances, ...) when those resources are not present. They c=
an=20
easily determine at probe time whether those resources are present, but=
 have=20
no way to know, in case they're absent, whether they will be present at=
 some=20
point in the near future (due to another driver probing the device prov=
iding=20
the resource for instance) or if they will never be present (for instan=
ce=20
because the required driver is missing). In the first case it would mak=
e sense=20
to defer probe, in the latter case deferring probe forever for missing=20=

optional resources would prevent the device from being probed successfu=
lly at=20
all.

The functional dependencies tracking patch series isn't meant to addres=
s this=20
issue. I can imagine a framework that would notify drivers of optional=20=

resource availability after probe time, but it would come at a high cos=
t for=20
drivers as switching between modes of operation at runtime based on the=
=20
availability of such resources would be way more complex than a mechani=
sm=20
based on probe deferral.

> 2) Since deferred probe relies on late_initcall() if your driver must=

> load earlier than this deferred probe can create an issue. Andrzej ha=
d
> you identified a driver that ran into this and had issues ? If not
> this seems like a semantics thing we should consider in extending the=

> documentation for drivers so that driver writers are aware of this
> limitation. I would suppose candidates for this would be anything not=

> using module_init() or late_initcall() on their inits and have a
> probe.
>=20
> >> if it does not support its not clear what will happen....
> >=20
> > I don't see any problems here, but if you see any, please just say
> > what they are.
> >=20
> >> We have no explicit semantics to check if a driver / subsystem
> >> supports deferred probe.
> >=20
> > That's correct, but then do we need it?
>=20
> We can determine this by reviewing the two items above.

--=20
Regards,

Laurent Pinchart
