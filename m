From: Andrey Rahmatullin <wrar@altlinux.org>
Subject: Re: [TuxOnIce-devel] Swsusp patches applied to
	suspend-2.6#linux-next
Date: Mon, 27 Sep 2010 12:59:46 +0600
Message-ID: <20100927065946.GR7007@wrars-comp.wrarsdomain>
References: <1285566238-10966-1-git-send-email-nigel@tuxonice.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3302568350740532480=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1285566238-10966-1-git-send-email-nigel@tuxonice.net>
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
To: Nigel Cunningham <nigel@tuxonice.net>
Cc: Linux PM <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org


--===============3302568350740532480==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JKGvNdIvrY8Ovf7Z"
Content-Disposition: inline


--JKGvNdIvrY8Ovf7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 27, 2010 at 03:43:35PM +1000, Nigel Cunningham wrote:
> Hi again Rafael.
>=20
> As discussed, here are the patches, modified to apply against your current
> linux-next tree. A new first patch splits compression support out into its
> own file, removing the need to have two versions of the load_image and
> save_image routines, minimising the changes to the remainder of the
> patches and making things cleaner than would otherwise be the case.
>=20
> On my laptop, single-threaded compression actually slows writing down from
> 175MB/s to around 100-120MB/s (depending on how well the image compresses=
).
> Reading speed improves from 218MB/s to around 245MB/s. I expect that
> multithreaded writing would bring the writing (and reading) speeds back
> up. It's on my swsusp to do list :)
Can I test this patchset by just building for-rafael branch?

--=20
WBR, wRAR (ALT Linux Team)

--JKGvNdIvrY8Ovf7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBCAAGBQJMoEDiAAoJEOih81koZvPBl2sH/21DTU2gd+94cJz9RItfSv8z
PGoMGXWCfOlxzJZCMfrWLSKjHe49jzhSC5F1/pAavYN9NDVjmPQm7IzP9KeFFSZO
tkkc2+yrlUzaTXZLUbzCr6FammsvkKqCBt1cICj1u+PNAQjm+iwRr3sFnt1Ti9go
hVDIDPT6+xvOqQI9NiYmv5d22f8aoJ6wtXf8q9jSrZz3eQskjmxc7a8vQEI/lfZa
etIuLkQ0BBbi3bEb11SPqqlbAJZJJgICiedmLDhERD1v5hXOamakLBtQlRbwCHB7
bS7euD5oza/3/nzDtRJFteeDVabDbAHdtzcoFWPFOslbsLs2ZX+HNJSgDJlVCmc=
=ArQv
-----END PGP SIGNATURE-----

--JKGvNdIvrY8Ovf7Z--

--===============3302568350740532480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3302568350740532480==--
