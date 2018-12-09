From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 2/5] devfreq: add support for suspend/resume of a
 devfreq device
Date: Sun, 9 Dec 2018 10:00:07 +0100
Message-ID: <20181209090007.GD7561@amd>
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181203143131eucas1p217f22ac6d19682a54a57658a06980914@eucas1p2.samsung.com>
 <1543847475-7600-3-git-send-email-l.luba@partner.samsung.com>
 <5C06124B.5030409@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0/kgSOzhNoDC5T3a"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5C06124B.5030409@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Lukasz Luba <l.luba@partner.samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net, len.brown@intel.com, gregkh@linuxfoundation.org, keescook@chromium.org, anton@enomsg.org, ccross@android.com, tony.luck@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org, krzk@kernel.org, m.szyprowski@samsung.com, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org


--0/kgSOzhNoDC5T3a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-12-04 14:36:11, Chanwoo Choi wrote:
> Hi Lukasz,
>=20
> Looks good to me. But, I add the some comments.
> If you will fix it, feel free to add my tag:
> Reviewed-by: Chanwoo choi <cw00.choi@samsung.com>
>=20
> On 2018=EB=85=84 12=EC=9B=94 03=EC=9D=BC 23:31, Lukasz Luba wrote:
> > The patch prepares devfreq device for handling suspend/resume
> > functionality.  The new fields will store needed information during this
>=20
> nitpick. Remove unneeded space. There are two spaces between '.' and 'The=
 new'.=20

Yes. And that's because two spaces are okay at that place.

https://www.writersdigest.com/online-editor/how-many-spaces-after-a-period

Please don't cause unneeded noise on the list with trivial
comments. If the patch is okay, apply the patch, no need to find
trivial nit everywhere.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0/kgSOzhNoDC5T3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwM2ZcACgkQMOfwapXb+vKjzQCcCsUqmaYo8aPuD0m/JrfCBl2z
ZaUAnjMt+1X+vuWarQhgVM/LXGeYdeLw
=2woN
-----END PGP SIGNATURE-----

--0/kgSOzhNoDC5T3a--
