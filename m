From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] introduce /sys/power/disk_powerdown_mode
Date: Wed, 21 Mar 2007 13:32:55 +0100
Message-ID: <1174480375.4230.12.camel@johannes.berg>
References: <1174468981.3769.8.camel@johannes.berg>
	<20070321122954.GO4520@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1670310300=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070321122954.GO4520@elf.ucw.cz>
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
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============1670310300==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-r3G0c+NBtN3vF5sHw1+/"


--=-r3G0c+NBtN3vF5sHw1+/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-03-21 at 13:29 +0100, Pavel Machek wrote:

> Does it really need to be this complex? Maybe we can disply change
> /sys/power/disk format? Is the change required at all?

Dunno. Does anything ever read it? Maybe the whole change isn't
necessary since this thing exists only as a hack for ACPI anyway, but if
anybody starts using it with an actual choice being able to see the
choices would imho be useful.

johannes

--=-r3G0c+NBtN3vF5sHw1+/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGASX3/ETPhpq3jKURAm8AAKCVAdIkTuMagTz89fTU8kSfB5gdVQCfcmDw
yq+Jy3j5FU06yifipJul8/4=
=QJWF
-----END PGP SIGNATURE-----

--=-r3G0c+NBtN3vF5sHw1+/--


--===============1670310300==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1670310300==--
