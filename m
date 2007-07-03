From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 14:54:41 +1000
Message-ID: <200707031454.42078.nigel__19538.0526049577$1183438777$gmane$org@nigel.suspend2.net>
References: <20070703042916.GA17240@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2581047010211976610=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070703042916.GA17240@srcf.ucam.org>
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
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============2581047010211976610==
Content-Type: multipart/signed; boundary="nextPart42282587.HUo68dgbAY";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart42282587.HUo68dgbAY
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 03 July 2007 14:29:18 Matthew Garrett wrote:
> Suspend to RAM on a machine with / on a fuse filesystem turns out to be=20
> a screaming nightmare - either the suspend fails because syslog (for=20
> instance) can't be frozen, or the machine deadlocks for some other=20
> reason I haven't tracked down. We could "fix" fuse, or alternatively we=20
> could do what we do for suspend to RAM on other platforms (PPC and APM)=20
> and just not use the freezer.
>=20
> Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>

Note, though, that this won't help at all when people use the "suspend-to-r=
am=20
instead of powering down after writing a hibernation image" feature in=20
(uswsusp | tuxonice). Fuse is just a broken idea in the first place, but=20
given that it exists, we still need to find the underlying cause.

Regards,

Nigel

--nextPart42282587.HUo68dgbAY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGidaSN0y+n1M3mo0RAkUJAKC/o1YA3g7emTgVnlIHw3ehNAhtZQCfRTcD
ADtLzGVAQzzxgGczvXVX+io=
=MUPf
-----END PGP SIGNATURE-----

--nextPart42282587.HUo68dgbAY--

--===============2581047010211976610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2581047010211976610==--
