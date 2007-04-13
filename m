From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v2] pm_ops: add system quiesce/activate hooks
Date: Fri, 13 Apr 2007 08:52:49 +0200
Message-ID: <1176447170.7052.70.camel@johannes.berg>
References: <1175810054.3489.34.camel@johannes.berg>
	<1176377017.5764.15.camel@localhost.localdomain>
	<200704121703.16206.rjw@sisk.pl>
	<200704120932.41497.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0110980046=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704120932.41497.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============0110980046==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-8M1QZTB8y8o6XzkgInE3"


--=-8M1QZTB8y8o6XzkgInE3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-04-12 at 09:32 -0700, David Brownell wrote:

> Makes sense to me.  Though I'd rather see pm_set_ops() patch the default
> hooks than expect all platforms to change ... that would shrink the size
> of the patch adding these, as well as the potential cost of removing them=
.

I was thinking about that, but wasn't sure if we could do that. I like
interfaces that don't change global variables they are passed. But if I
document it properly I can change the patch to do this easily.

johannes

--=-8M1QZTB8y8o6XzkgInE3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGHyjB/ETPhpq3jKURAnfLAKCifwCZ6O5/Prb8C09hcnkYYwHSbgCdETsG
bb68iyLTfadv7pOVOyC5IjM=
=aou5
-----END PGP SIGNATURE-----

--=-8M1QZTB8y8o6XzkgInE3--


--===============0110980046==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0110980046==--
