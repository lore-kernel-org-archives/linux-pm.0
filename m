From: Johannes Berg <johannes@sipsolutions.net>
Subject: RE: Power event notification patch
Date: Thu, 05 Jul 2007 15:22:53 +0200
Message-ID: <1183641773.3818.42.camel@johannes.berg>
References: <67670A5CEA5C374B8E7B16D7DC55F9530124744C@bgsmsx413.gar.corp.intel.com>
	<1183641177.3818.40.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3168376137140391170=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183641177.3818.40.camel@johannes.berg>
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
To: "V, Sankara Narayanan" <sankara.narayanan.v@intel.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============3168376137140391170==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-sZQQdO+ZYcxqnjy/8S6R"


--=-sZQQdO+ZYcxqnjy/8S6R
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-07-05 at 15:13 +0200, Johannes Berg wrote:

> No, as far as I know it'll actually tell applications *before* telling
> the kernel.

Huh, looks like I was wrong, it only specifically tells gnome-keyring,
gnome-network-manager and gnome-screensaver. But it could very well
broadcast something too.

johannes

--=-sZQQdO+ZYcxqnjy/8S6R
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGjPCt/ETPhpq3jKURAn0CAJ4wwfxARyJiq8R4Yb2c00/TFmYD3ACdEDaH
8u26itAQdjdgKlvARk7HLmE=
=wcsC
-----END PGP SIGNATURE-----

--=-sZQQdO+ZYcxqnjy/8S6R--


--===============3168376137140391170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3168376137140391170==--
