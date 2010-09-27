From: Andrey Rahmatullin <wrar@altlinux.org>
Subject: Re: [TuxOnIce-devel] Swsusp patches applied to
	suspend-2.6#linux-next
Date: Mon, 27 Sep 2010 14:00:00 +0600
Message-ID: <20100927080000.GA7032__29802.3682008081$1285574507$gmane$org@wrars-comp.wrarsdomain>
References: <1285566238-10966-1-git-send-email-nigel@tuxonice.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0615665045990726618=="
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


--===============0615665045990726618==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline


--3MwIy2ne0vdjdPXF
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
Works here.

--=20
WBR, wRAR (ALT Linux Team)

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBCAAGBQJMoE8AAAoJEOih81koZvPByRcH/0p+Z0mB2viGwS8KLednRRVx
t4Woi5+s3PM/i2Tc7wKVG3qEgYSxqzj7Qrm+kaYX7dq/udtv+f486/30ZKBA3IJW
L5Ibxyz3QZ0FEBzsj19xJgRkP/Q6ffR6+1ffNGo6BUMJtSeRgoiMfB595cs5fyab
BhNWG3Cn2szZvCC61lyvIEYjyxyGb/tVNg3u+GHUxoXcEgoMmupTpTJ3A1q3Vv1W
WyshvhlDgo0tq6J6OW4tQ22i/VyzF3Ox0pO5QsBfbW9hkXIIRP5o9hYLPzHTtp0Z
dJ5+3BDKwdSM8zrD4eN+yysYRBwT46/uRdDlV2YlcJHTceAEl3ghPHQU56NijbE=
=fh0k
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--

--===============0615665045990726618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0615665045990726618==--
