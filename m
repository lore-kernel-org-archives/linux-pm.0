From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/3][RFC] Introduce the in-kernel hibernation encryption
Date: Mon, 25 Jun 2018 13:59:13 +0200
Message-ID: <20180625115913.GD17001@amd>
References: <cover.1529486870.git.yu.c.chen@intel.com>
 <20180621085332.GA21807@amd>
 <CAJZ5v0izS8CNzhsd_bjB40xTkZxaxh13NtHsJi9LYXEr84MoMA@mail.gmail.com>
 <20180621191443.GB14623@amd>
 <CAJZ5v0gHPRa-9btfCCYEDDphZrEy8DTrXjsn57MoKMAu7sKMEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="JwB53PgKC5A7+0Ej"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gHPRa-9btfCCYEDDphZrEy8DTrXjsn57MoKMAu7sKMEA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>, "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--JwB53PgKC5A7+0Ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



> > Well, AFAICT in this case userland has the key and encrypted data are
> > on disk. That does not seem to be improvement.
>=20
> Not really.
>=20
> With the encryption in the kernel, if the kernel is careful enough,
> use space will not be able to read the image even if it knows the
> passphrase, unless it can also add itself to the initramfs image
> loaded by the restore kernel, which (at least) can be made way more
> difficult than simply reading the plain-text image data via an I/F
> readily provided by the kernel.

I still do not see the improvement. If you are root, you can modify
the initramfs and decrypt the data.

Please explain in the changelog how this is better than existing solution.

> >> Besides, the user space part of what you are calling uswsusp has not
> >> been actively maintained for years now and honestly I don't know how
> >> many users of it there are.
> >
> > I'd assume distros want progress bars so they still use it?
>=20
> I'd rather not speak for distros, but if hibernation images are
> written to fast storage, progress bars are not that useful any more.
> They are not used on Windows any more, for one.
>=20
> > Anyway, there's solution for encrypted hibernation.
>=20
> Which is suboptimal and you know it.

If this is better, please explain how in the changelog.

> > If Intel wants to invent different solution for that, and put it into k=
ernel, they
> > should explain what the advantages are, relative to existing solution.
>=20
> I'm not sure what "they" is supposed to mean here, but the advantages
> are quite clear to me: better security and reduced syscall overhead.

Better security against which attack?

Syscall overhead is not a problem for hibernation, and you know it.

		    	  	      		       Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--JwB53PgKC5A7+0Ej
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsw2REACgkQMOfwapXb+vL5WgCdEZn9n38yd3VV3SBZCeMULHhV
O2YAnjoj7kfQr0rzXiX99zLDo1lPSv1v
=oRsa
-----END PGP SIGNATURE-----

--JwB53PgKC5A7+0Ej--
