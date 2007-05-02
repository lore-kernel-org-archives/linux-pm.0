From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: shrinking memory for suspend?
Date: Wed, 02 May 2007 16:02:01 +0200
Message-ID: <1178114521.13233.56.camel@johannes.berg>
References: <1177943076.5102.83.camel@johannes.berg>
	<20070502112929.GD11316@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7924965244505354362=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070502112929.GD11316@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============7924965244505354362==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-GAiY+BB39xVsiUrWWiXL"


--=-GAiY+BB39xVsiUrWWiXL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-05-02 at 13:29 +0200, Pavel Machek wrote:

> It makes the device driver's job easier. But I guess we should stop
> doing the freeze for suspend-to-RAM. Some auditing required, but OTOH
> we'll be one step closer to runtime power management on such drivers.

*shrug*. We've never done it on powerbooks and it always seemed to work
just fine...

johannes

--=-GAiY+BB39xVsiUrWWiXL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGOJnZ/ETPhpq3jKURAhmxAJ9SzP3NmrIhzehyk4Qkx9eeS1VN1gCgoHnU
fgSOMF8nPYHOJ1HCVuscag8=
=7izo
-----END PGP SIGNATURE-----

--=-GAiY+BB39xVsiUrWWiXL--


--===============7924965244505354362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7924965244505354362==--
