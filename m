From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v2] pm_ops: add system quiesce/activate hooks
Date: Fri, 13 Apr 2007 14:58:00 +0200
Message-ID: <1176469080.7052.105.camel@johannes.berg>
References: <1175810054.3489.34.camel@johannes.berg>
	<1176454756.7052.98.camel@johannes.berg>
	<1176455273.5764.74.camel@localhost.localdomain>
	<200704131347.30001.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1118463249=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704131347.30001.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============1118463249==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Mu1R88yNAnStUfm/XWKm"


--=-Mu1R88yNAnStUfm/XWKm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-13 at 13:47 +0200, Rafael J. Wysocki wrote:

> Well, I didn't like them, because they should refer to the local CPU only=
 (the
> other ones are supposed to be disabled at that point).  Also, since we ar=
e
> going to do some things apart from disabling the (local) IRQs in there, I
> thought some other names would be better.

True.

>   Still, if that's confusing, I'm not
> going to fight either. :-)

Well it seemed to me that Dmitry's question might have been due to a
slight confusion here. Then again, the docs are there and clearly
describe what to do... I've clarified the description again and will
resend in a minute.

Do we want the patch that munges pm_ops when registering or the one that
modifies all current users?

johannes

--=-Mu1R88yNAnStUfm/XWKm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGH35Y/ETPhpq3jKURAo1HAJ0QUxcshQXSnY3LGz+fpjxFj525rwCgm1F8
5+6M+y9/X1l7YmHyR4OG+4Q=
=rOKK
-----END PGP SIGNATURE-----

--=-Mu1R88yNAnStUfm/XWKm--


--===============1118463249==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1118463249==--
