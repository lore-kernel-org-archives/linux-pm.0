From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] drivers: base: power: Fix GFP_KERNEL in spinlock context
Date: Fri, 15 Dec 2017 09:45:15 +0100
Message-ID: <20171215084515.GB8221@amd>
References: <1513086342-3581-1-git-send-email-shrikant.maurya@techveda.org>
 <CAMuHMdUrhV9RkUnXkTbSWaRY33iQrANwbKBE5KAPQseNgxOofg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43481 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753744AbdLOIpR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Dec 2017 03:45:17 -0500
Content-Disposition: inline
In-Reply-To: <CAMuHMdUrhV9RkUnXkTbSWaRY33iQrANwbKBE5KAPQseNgxOofg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: shrikant.maurya@techveda.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Greg KH <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Suniel Mahesh <sunil.m@techveda.org>, Karthik Tummala <karthik@techveda.org>, raghu@techveda.org


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2017-12-12 15:58:00, Geert Uytterhoeven wrote:
> Hi Shrikant,
>=20
> On Tue, Dec 12, 2017 at 2:45 PM,  <shrikant.maurya@techveda.org> wrote:
> > From: Shrikant Maurya <shrikant.maurya@techveda.org>
> >
> > As reported by Jia-Ju Bai (https://lkml.org/lkml/2017/12/11/872):
> > API's are using GFP_KERNEL to allocate memory which may sleep.
> >
> > To ensure atomicity such allocations must be avoided in critical
> > sections under spinlock.
> > Fixed by replacing GFP_KERNEL to GFP_ATOMIC.
> >
> > Reported-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> > Signed-off-by: Shrikant Maurya <shrikant.maurya@techveda.org>
> > Signed-off-by: Suniel Mahesh <sunil.m@techveda.org>
> > Signed-off-by: Raghu Bharadwaj <raghu@techveda.org>
> > Signed-off-by: Karthik Tummala <karthik@techveda.org>
>=20
> Can't the call to device_init_wakeup() in isp116x_start() just be moved
> below the spinlock release?
>=20
> > --- a/drivers/base/power/wakeup.c
> > +++ b/drivers/base/power/wakeup.c
> > @@ -92,11 +92,11 @@ struct wakeup_source *wakeup_source_create(const ch=
ar *name)
> >  {
> >         struct wakeup_source *ws;
> >
> > -       ws =3D kmalloc(sizeof(*ws), GFP_KERNEL);
> > +       ws =3D kmalloc(sizeof(*ws), GFP_ATOMIC);
>=20
> With GFP_ATOMIC, allocation failure is much more likely to occur.
> So IMHO it's better to fix the isp116x, than to impose this burden on
> every user.
>=20
> >         if (!ws)
> >                 return NULL;
> >
> > -       wakeup_source_prepare(ws, name ? kstrdup_const(name, GFP_KERNEL=
) : NULL);
> > +       wakeup_source_prepare(ws, name ? kstrdup_const(name, GFP_ATOMIC=
) : NULL);
> >         return ws;

NAK. This will silently replace name with NULL if memory is low.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlozi5sACgkQMOfwapXb+vJSMQCeLb9Hi6zQwi3h6a+wk7VFlggt
S40AnA3K9ziiYXdYMLMpjRpJPp0RsPuj
=hnyF
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
