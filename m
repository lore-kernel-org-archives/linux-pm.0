From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] base: fix a missing check of clk_prepare
Date: Mon, 11 Feb 2019 14:24:06 +0100
Message-ID: <20190211132406.GB11067@amd>
References: <20181226024700.72318-1-kjlu@umn.edu>
 <CAJZ5v0iK+ASbadEjj+9vgCV+1ycjp8Hs2GbEmT3dGSqjLVGbPA@mail.gmail.com>
 <20181231172556.GA14092@amd>
 <CAJZ5v0hOKXkZbpchv9+23uTgZyeq_3oQHznPKR3-+X43JakGeg@mail.gmail.com>
 <20190101202119.GA13097@amd>
 <CAJZ5v0iJCaCju7sgCF9u7PYxmHF0jQDy95_QEVt8q+R2NX5zAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iJCaCju7sgCF9u7PYxmHF0jQDy95_QEVt8q+R2NX5zAA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: kjlu@umn.edu, pakki001@umn.edu, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-01-01 22:05:39, Rafael J. Wysocki wrote:
> On Tue, Jan 1, 2019 at 9:21 PM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > On Tue 2019-01-01 21:13:01, Rafael J. Wysocki wrote:
> > > On Mon, Dec 31, 2018 at 6:25 PM Pavel Machek <pavel@ucw.cz> wrote:
> > > >
> > > > On Wed 2018-12-26 10:37:54, Rafael J. Wysocki wrote:
> > > > > On Wed, Dec 26, 2018 at 3:47 AM Kangjie Lu <kjlu@umn.edu> wrote:
> > > > > >
> > > > > > clk_prepare() could fail, so let's check its status, and if it =
fails,
> > > > > > issue an error message.
> > > > > >
> > > > > > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> > > > > > ---
> > > > > >  drivers/base/power/clock_ops.c | 4 +++-
> > > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/base/power/clock_ops.c b/drivers/base/powe=
r/clock_ops.c
> > > > > > index 5a42ae4078c2..cb6144fb24e2 100644
> > > > > > --- a/drivers/base/power/clock_ops.c
> > > > > > +++ b/drivers/base/power/clock_ops.c
> > > > > > @@ -65,7 +65,9 @@ static void pm_clk_acquire(struct device *dev=
, struct pm_clock_entry *ce)
> > > > > >         if (IS_ERR(ce->clk)) {
> > > > > >                 ce->status =3D PCE_STATUS_ERROR;
> > > > > >         } else {
> > > > > > -               clk_prepare(ce->clk);
> > > > > > +               if (clk_prepare(ce->clk))
> > > > > > +                       dev_err(dev, "clk_prepare failed.\n");
> > > > >
> > > > > I'm not sure that this is useful.  The code continues regardless =
of
> > > > > the error anyway and it should at least set ce->status to
> > > > > PCE_STATUS_ERROR in the failing case.
> > > >
> > > > Maybe this is not complete fix, but dev_err() is preferable to sile=
nt
> > > > failure.
> > >
> > > Preferable to you I suppose?
> >
> > Preferable to the poor person trying to figure out why his machine
> > does not work?
>=20
> Not really, unless that person knows what the message means.
>=20
> Honestly, what would you do if you saw that message?

Grep it in the kernel sources. Having something to grep for
(vs. machine that fails to work properly) is quite important.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxhd3YACgkQMOfwapXb+vKzLwCffEdNUlOcZCUYak6EBr4/f/6G
IF4AoJiVgIYSQSyZqeIcHTmllY4ulRhZ
=KhsR
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
