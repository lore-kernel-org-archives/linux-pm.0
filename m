From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC 07/10] powermac: support G5 CPU hotplug
Date: Wed, 07 Feb 2007 13:23:08 +0100
Message-ID: <1170850988.6798.31.camel@johannes.berg>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185837.640324000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0186008279=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070205185837.640324000@sipsolutions.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linuxppc-dev@ozlabs.org
Cc: Torrance <torrance123@gmail.com>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--===============0186008279==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/Vyw/k4wGB0BAb05OPNU"


--=-/Vyw/k4wGB0BAb05OPNU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-02-05 at 19:30 +0100, Johannes Berg wrote:

> This patch allows "hotplugging" of CPUs on G5 machines. CPUs that are
> disabled are put into an idle loop with interrupts hard-disabled, to wake
> them up again we kick them just like when bringing them up.

testing with forced preemption revealed that the preempt count is messed
up. Will resend with the fix. The hardirq count is still strange...

johannes

--=-/Vyw/k4wGB0BAb05OPNU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFycSs/ETPhpq3jKURAuExAJ4hTToa16FXWkg1+kMcHRoc84lRmwCeKWL+
cYNXlPKJBenJLgR3abzuj4Q=
=J8VI
-----END PGP SIGNATURE-----

--=-/Vyw/k4wGB0BAb05OPNU--


--===============0186008279==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0186008279==--
