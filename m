From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] add firmware disk state and clean up
Date: Tue, 20 Mar 2007 11:45:20 +0100
Message-ID: <1174387520.3770.22.camel@johannes.berg>
References: <20070320015846.636692000@sipsolutions.net>
	<20070320084744.984025000@sipsolutions.net>
	<20070320093105.GD3922@elf.ucw.cz>
	<1174383407.3770.3.camel@johannes.berg>
	<20070320094352.GF3922@elf.ucw.cz>
	<1174385865.3770.20.camel@johannes.berg>
	<20070320102551.GB19283@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1655585949=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070320102551.GB19283@elf.ucw.cz>
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
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Ben Dooks <ben@simtec.co.uk>, Nicolas Pitre <nico@cam.org>, Dirk Behme <dirk.behme@de.bosch.com>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--===============1655585949==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-rhlpbYg1h2PgotaO5lWZ"


--=-rhlpbYg1h2PgotaO5lWZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-03-20 at 11:25 +0100, Pavel Machek wrote:

> The person doing the conversion should add the state,
> sorry... ... actually it makes sense, but I'd prefer not to have it,
> yet.

That's ok. The patch is here for that person to implement it ;)

> create static inline pm_valid_only_mem() somewhere in header, then
> share it around the code?

Actually, it can't be inline if it is to be assigned to a function
pointer, but it an be an exported function. Will do that.


> I'd keep the c99 syntax here.

I prefer the c99 syntax as well, but at least this gives compile errors
when somebody adds a new state. Then again, I suppose when they add a
new state they'll want to test it and quickly notice that they need to
do something to make it accessible.

johannes

--=-rhlpbYg1h2PgotaO5lWZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF/7tA/ETPhpq3jKURAsYDAKCpFP9Xmt3sgKMjq4vxHF1ObDQBXQCfXVDv
dsS+YHwXqHOkK4dAgPKgPMI=
=xn9e
-----END PGP SIGNATURE-----

--=-rhlpbYg1h2PgotaO5lWZ--


--===============1655585949==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1655585949==--
