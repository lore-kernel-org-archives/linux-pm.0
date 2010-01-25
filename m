From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH] PM / i915: Skip kernel VT switch during
 suspend/resume if KMS is used
Date: Mon, 25 Jan 2010 09:22:11 -0800
Message-ID: <87k4v63xrw.fsf__40541.397201787$1264447322$gmane$org@pollan.anholt.net>
References: <201001240055.59479.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5282237686177891695=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001240055.59479.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============5282237686177891695==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Transfer-Encoding: quoted-printable

On Sun, 24 Jan 2010 00:55:59 +0100, "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>=20
> If a non-KMS graphics driver is used, the kernel carries out a VT
> switch during suspend/resume to avoid possible problems with freezing
> X at a wrong time and to cause X to repaint everything after resume.
>=20
> This is not necessary any more if the KMS is used, so skip the kernel
> VT switch during suspend/resume for i915 in the KMS mode.
>=20
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>=20
> Hi,
>=20
> I've been testing this patch for over a week and haven't seen a single pr=
oblem
> related to it during this time.
>=20
> Are there any objections to it?
>=20
> Rafael

Love it!

Acked-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAktd00MACgkQHUdvYGzw6vdJxgCeLFdnO9dl9KMH8Lh+3k3ti8iq
shgAn0mj5xFmLxtaXnYFyHpDoH67cDAa
=DG7D
-----END PGP SIGNATURE-----
--=-=-=--

--===============5282237686177891695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5282237686177891695==--
