From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH] DRM / i915: Fix resume regression on MSI
 Wind U100 w/o KMS
Date: Tue, 12 Jan 2010 14:33:21 -0800
Message-ID: <878wc3j6mm.fsf__43890.514833811$1263338301$gmane$org@pollan.anholt.net>
References: <201001090045.33784.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1813026037390091867=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001090045.33784.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Zhenyu Wang <zhenyuw@linux.intel.com>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

--===============1813026037390091867==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Transfer-Encoding: quoted-printable

On Sat, 9 Jan 2010 00:45:33 +0100, "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>=20
> Commit cbda12d77ea590082edb6d30bd342a67ebc459e0 (drm/i915: implement
> new pm ops for i915), among other things, removed the .suspend and
> .resume pointers from the struct drm_driver object in i915_drv.c,
> which broke resume without KMS on my MSI Wind U100.
>=20
> Fix this by reverting that part of commit cbda12d77ea59.
>=20
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Applied, with a little comment for the next poor person having to figure
out the difference between these two suspend/resume paths.

(And yes, I'd love to see the stealth mode die sometime soonish.  It's
not like attaching intelfb didn't make the user-mode 2D driver fail
frequently, so it's not a great "feature" for us to be maintaining
support for.  From what I understand most distros blacklisted the
intelfb driver anyway.)

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAktM+LEACgkQHUdvYGzw6vesswCeLTaBN2l2S9rNp3o9iGb5KAdx
NTMAoI1JZ40C+9GuZzrEualWRbkCWror
=lIez
-----END PGP SIGNATURE-----
--=-=-=--

--===============1813026037390091867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1813026037390091867==--
