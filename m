From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v2] pm_ops: add system quiesce/activate hooks
Date: Thu, 12 Apr 2007 10:39:38 +0200
Message-ID: <1176367178.7052.4.camel@johannes.berg>
References: <1175810054.3489.34.camel@johannes.berg>
	<1176306867.19348.4.camel@johannes.berg> <461D494D.3080808@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0610542878=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <461D494D.3080808@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Cc: linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============0610542878==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-0wLECe469NHxn0sl3KHG"


--=-0wLECe469NHxn0sl3KHG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-04-12 at 00:47 +0400, Dmitry Krivoschekov wrote:

> I doubt your reasoning is cogent enough. If you add such a global thing,
> you should prove it, or clearly explain what is the thing for.
> I don't believe that it's not possible to solve that decrementer case
> without this change. Can't you add appropriate platform_device which
> would register early enough, to meet that timing requirement when it
> gets suspended?

I think Ben explained that.

> >  static struct pm_ops pmac_pm_ops =3D {
> >  	.pm_disk_mode	=3D PM_DISK_SHUTDOWN,
> >  	.prepare	=3D pmac_pm_prepare,
> > +	.quiesce	=3D pm_default_quiesce,
> >  	.enter		=3D pmac_pm_enter,
> > +	.activate	=3D pm_default_activate,
> >  	.finish		=3D pmac_pm_finish,
> >  	.valid		=3D pmac_pm_valid,
> >  };
>=20
> So, where is that callbacks that are so desirable for powermac?

If you'd looked at the current pmac_pm_valid, you'd see that it allows
nothing. Currently, pm_ops are totally broken on powermac. The callback
that is so desirable for powermac will be added when I actually make
powermac use the pm_ops infrastructure which currently isn't possible
due to this problem.

johannes

--=-0wLECe469NHxn0sl3KHG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGHfBK/ETPhpq3jKURAi7aAJ9xO/lp3RO86ANuZQNJByn2Yz61TwCgp1cO
iYrtnfQXtHzaGKnmS9+Q2Xs=
=Xnj4
-----END PGP SIGNATURE-----

--=-0wLECe469NHxn0sl3KHG--


--===============0610542878==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0610542878==--
