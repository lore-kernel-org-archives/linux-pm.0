From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: Re: Hibernate after alarm wakes from STR
Date: Wed, 11 Jul 2007 20:14:23 +1000
Message-ID: <200707112014.28958.nigel__43064.3786130988$1184148907$gmane$org@nigel.suspend2.net>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200707111314.04221.nigel@nigel.suspend2.net>
	<200707111209.05163.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4910723834316359573=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707111209.05163.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, rtc-linux@googlegroups.com, linux-acpi@vger.kernel.org, nigel@suspend2.net, Richard Hughes <hughsient@gmail.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============4910723834316359573==
Content-Type: multipart/signed; boundary="nextPart3504830.SIZFe8B9Pj";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3504830.SIZFe8B9Pj
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 11 July 2007 20:09:04 Rafael J. Wysocki wrote:
> On Wednesday, 11 July 2007 05:14, Nigel Cunningham wrote:
> > On Wednesday 11 July 2007 11:59:48 Matthew Garrett wrote:
> > > On Wed, Jul 11, 2007 at 11:39:37AM +1000, Nigel Cunningham wrote:
> > >=20
> > > > Yeah, that is a bit confusing. At the moment, I'm doing the suspend=
 to=20
ram=20
> > > > platform dependent preparation and cleanup in this scenario. That's=
=20
> > > > definitely the right thing to do in the case where we write an imag=
e,=20
then=20
> > > > suspend to ram, wake and continue working without running running o=
ut=20
of=20
> > > > battery (writing the image is redundant in that case). Where we end=
 up=20
> > > > properly powering down after suspending to ram, I believe we don't =
run=20
the=20
> > > > pm_ops->finish after doing the atomic restore when resuming the ima=
ge.
> > >=20
> > > I'm not convinced this can work terribly well. It's not unlikely that=
=20
> > > hardware will need different state stored over different types of=20
> > > suspend. Can you separate out the saving of kernel memory and userspa=
ce=20
> > > memory, then resume/suspend/save the new kernel state without touchin=
g=20
> > > the userspace state?
> >=20
> > Yeah, we could redo and resave the atomic copy, but it doesn't seem to =
be=20
> > necessary at the moment; it has been working reliably, regardless of wh=
ich=20
> > combination of events occurs. If/when I come across a case where we hav=
e=20
> > problems, I'll give resaving the atomic copy a go.
> >=20
> > (Thinks some more). Ah, I think we're already doing the right thing, if=
=20
I'm=20
> > recalling the order of actions right. If I'm remembering correctly, pri=
or=20
to=20
> > the atomic copy, we do hibernation prep, then after the atomic copy,=20
> > hibernation cleanup. Then, if suspending to ram, we do the=20
prep/enter/cleanup=20
> > after the image has finished writing. If we lose power from suspend to=
=20
ram,=20
> > it doesn't matter because we're just doing a normal resume then, with t=
he=20
> > hibernation cleanup post atomic restore machine the prep that was done=
=20
prior=20
> > to the atomic copy.
> >=20
> > To summarise:
> >=20
> > Hibernate + STR + full wake.
> >  Hibernation prep
> >  (Atomic copy)
> >  Hibernation cleanup
> >  STR prep
> >  STR enter
> >  STR cleanup	=09
> >  Remove hibernation image
> >=20
> > Hibernate + STR + poweroff + hibernate resume:
> >=20
> >  Hibernation prep
> >  (Atomic copy)
> >  Hibernation cleanup
> >  STR prep
> >  STR enter
> >  <power out> or <STR wake + power off> (STR prep/enter no longer matter=
s)
> >  (Fresh boot)
> >  Atomic restore
> >  Hibernation cleanup (matching prep at start)
> >  Remove hibernation image
>=20
> Yes, I think that this is the right ordering, but for some graphics adapt=
ers
> we need to do some tricks from the user space before 'STR prep' and after
> 'STR cleanup', which is theoretically possible with uswsusp.

Yeah. I haven't done it yet, but intend to implement that using userui.

Regards,

Nigel
=2D-=20
Nigel Cunningham
Christian Reformed Church of Cobden
103 Curdie Street, Cobden 3266, Victoria, Australia
Ph. +61 3 5595 1185 / +61 417 100 574
Communal Worship: 11 am Sunday.

--nextPart3504830.SIZFe8B9Pj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGlK2EN0y+n1M3mo0RAsVtAJ94GBiXwMH48KrwiAILdRuQyizPSgCfQSLu
wgJKkz7+dlTc39Yuh1RTjB0=
=1H3P
-----END PGP SIGNATURE-----

--nextPart3504830.SIZFe8B9Pj--

--===============4910723834316359573==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4910723834316359573==--
