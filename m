From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: shrinking memory for suspend?
Date: Mon, 30 Apr 2007 17:09:18 +0200
Message-ID: <1177945758.5102.96.camel@johannes.berg>
References: <1177943076.5102.83.camel@johannes.berg>
	<200704301710.43329.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8232098201299821420=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704301710.43329.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============8232098201299821420==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-a+SqAao5zfiUGzpYytVd"


--=-a+SqAao5zfiUGzpYytVd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

> I don't think it's related to the freezing of user space.  You can alloca=
te
> memory with all of the user space frozen just fine.  I'd say it's related=
 to
> the freezing of kernel threads, rather.

Ah, true, of course.

> > Why do we freeze userspace anyway?
>=20
> Well, let me quote Linus:
>=20
> "I _do_ realize the IO request queue issues, and that we cannot actually =
do=20
> s2ram with some devices in the middle of a DMA. So we want to be able to=20
> avoid *that*, there's no question about that. And I suspect that stopping=
=20
> user threads and then waiting for a sync is practically one of the easier=
=20
> ways to do so."

Hmm, yeah. Does this apply to kernel threads too? Actually, I guess
device drivers should wait for suspend and reject commands to devices
that are suspended already? Can it actually happen that we schedule to
userspace while calling all the suspend issues etc?

johannes

--=-a+SqAao5zfiUGzpYytVd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGNgae/ETPhpq3jKURAqgOAJ975v9QZnTIbCGQwaApGtE7iKk9QACgn58c
seK5QO0ltdyfuFJVT9LNSHo=
=A62C
-----END PGP SIGNATURE-----

--=-a+SqAao5zfiUGzpYytVd--


--===============8232098201299821420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8232098201299821420==--
