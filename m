From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to
	RAM pathway
Date: Tue, 03 Jul 2007 16:21:14 +0200
Message-ID: <1183472474.3722.13.camel__24387.3172476471$1183472587$gmane$org@johannes.berg>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707031608.06348.nigel@nigel.suspend2.net>
	<1183447184.10386.102.camel@localhost.localdomain>
	<200707031456.40890.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6045927968253940185=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707031456.40890.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-pm@vger.kernel.org


--===============6045927968253940185==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Mz28YY/RV4IJaS/b/uyT"


--=-Mz28YY/RV4IJaS/b/uyT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-07-03 at 14:56 +0200, Rafael J. Wysocki wrote:

> Still, can you please read this post from Alan Stern:
>=20
> https://lists.linux-foundation.org/pipermail/linux-pm/2007-June/012847.ht=
ml
>=20
> ?  I don't think I'm able to repeat the arguments given in there in a
> convincing way.

As I read it, Alan basically has two objections:
 (1) drivers shouldn't need to worry about this
 (2) suspend should be transparent to userspace

His proposed solution (freezing tasks when they cross the kernel
boundary) helps for the s-t-r case, but in fact doesn't solve (1)
because devices can be suspended at runtime and then you certainly do
not want to freeze tasks that try to access the device.

(2) is related but not identical, what if you have a device suspended at
runtime and some tasks tries to access it; should the task block until
you wake up that device?

I think the core of the discussion isn't appreciated by everybody here
yet---we need to solve both run-time and suspend-to-ram-time device
suspend, not just one of them.

johannes

--=-Mz28YY/RV4IJaS/b/uyT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGilta/ETPhpq3jKURAgI9AJ9B8nRTt64gNILc3I8TuoO8uT3h3QCfT9Ld
yFDHbsAbYvE/WyS7jvRjWcA=
=jpMN
-----END PGP SIGNATURE-----

--=-Mz28YY/RV4IJaS/b/uyT--


--===============6045927968253940185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6045927968253940185==--
