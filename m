From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 11/12] powermac: disallow pmu sleep notifiers from
	aborting sleep
Date: Thu, 08 Feb 2007 14:08:13 +0100
Message-ID: <1170940093.4385.40.camel@johannes.berg>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124615.015873000@sipsolutions.net>
	<jetzxxk2bh.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0910747126=="
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <jetzxxk2bh.fsf@sykes.suse.de>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Mime-version: 1.0
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Andreas Schwab <schwab@suse.de>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--===============0910747126==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kh4fsVQc73uA6iUXXnaL"


--=-kh4fsVQc73uA6iUXXnaL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-02-07 at 23:52 +0100, Andreas Schwab wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:
>=20
> > Tracing through the code, no current PMU sleep notifier can abort sleep=
.
> > Since no new PMU sleep notifiers should be added, this patch simplifies=
 the
> > code and removes the ability to abort sleep.
>=20
> There is a use of PBOOK_SLEEP_OK left in
> arch/powerpc/platforms/powermac/time.c.

Ouch. Yeah, the patch was done assuming my time resume patch is applied.

I found another one though, in dmasound.

johannes

--=-kh4fsVQc73uA6iUXXnaL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFyyC9/ETPhpq3jKURAnGRAJ0S/3NOcKKrrWPqVtTaKp3PzFU4XwCcD6cu
e4Owi7xYOVz2EsJ7KGTmIAQ=
=cS92
-----END PGP SIGNATURE-----

--=-kh4fsVQc73uA6iUXXnaL--


--===============0910747126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
--===============0910747126==--
