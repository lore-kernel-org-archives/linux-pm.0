From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] remove software_suspend() and fix compile
	w/	SOFTWARE_SUSPEND disabled
Date: Sun, 25 Mar 2007 20:18:32 +0200
Message-ID: <1174846713.20440.32.camel@johannes.berg>
References: <1174571192.32051.5.camel@johannes.berg>
	<20070325163417.GB9958@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0193598627=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070325163417.GB9958@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============0193598627==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-KygkxdLXs/GhrVmbA0jN"


--=-KygkxdLXs/GhrVmbA0jN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2007-03-25 at 16:34 +0000, Pavel Machek wrote:

> > @@ -60,7 +60,7 @@ acpi_system_write_sleep(struct file *fil
> >  	state =3D simple_strtoul(str, NULL, 0);
> >  #ifdef CONFIG_SOFTWARE_SUSPEND
> >  	if (state =3D=3D 4) {
> > -		error =3D software_suspend();
> > +		error =3D pm_suspend(PM_SUSPEND_DISK);
> >  		goto Done;
> >  	}
>=20
> Is enter_state and pm_suspend equivalent? Why the change?

Yeah, except that enter_state() has more argument checking. The change
was just because I didn't see much point in having two entry points for
the same thing and killed off software_suspend() completely. Don't
really care.

johannes

--=-KygkxdLXs/GhrVmbA0jN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGBrz4/ETPhpq3jKURArF3AJsEMax890HeorXVOYu/UHHLAH8KrgCeLbhX
eXBrDdKgdkii0gNKKE/8EuU=
=v4ov
-----END PGP SIGNATURE-----

--=-KygkxdLXs/GhrVmbA0jN--


--===============0193598627==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0193598627==--
