From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: 2.6.21 suspend-to-disk regression
Date: Mon, 30 Apr 2007 16:21:23 +0200
Message-ID: <1177942883.5102.79.camel@johannes.berg>
References: <f129n6$mro$1@sea.gmane.org> <200704291832.15959.rjw@sisk.pl>
	<200704301434.10008.marcus@better.se> <200704301621.11826.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4604218731328220914=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704301621.11826.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Pavel Machek <pavel@ucw.cz>, Marcus Better <marcus@better.se>
List-Id: linux-pm@vger.kernel.org


--===============4604218731328220914==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-jBPsYHTYIMiuxWhFYnCm"


--=-jBPsYHTYIMiuxWhFYnCm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-04-30 at 16:21 +0200, Rafael J. Wysocki wrote:

> Ugh, we seem to have a problem with the code ordering in which
> platform_finish() goes before device_resume(), at least in the hibernatio=
n
> (aka s2disk) case.
>=20
> This is the second report confirming that the change of this ordering has=
 fixed
> the a suspend problem, but the change of this ordering is intrusive, so I=
 was
> afraid to do it before 2.6.21.  Can we try to change it now?

I don't care about that ordering at all; ACPI is the only user of
hibernation_ops (which are still part of pm_ops now.)

johannes

--=-jBPsYHTYIMiuxWhFYnCm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGNftj/ETPhpq3jKURArRQAJ91iwb0CNI87OvyJN93FkCs8W7ckwCdE+f/
gz43XZWNjln4DZh9FD9Qp2E=
=Qs0d
-----END PGP SIGNATURE-----

--=-jBPsYHTYIMiuxWhFYnCm--


--===============4604218731328220914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4604218731328220914==--
