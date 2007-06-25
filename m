From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC/RFT][PATCH -mm 1/4] PM: Introduce set_target
	method in pm_ops
Date: Mon, 25 Jun 2007 23:28:06 +0200
Message-ID: <1182806886.6644.4.camel__31540.2862070643$1182848305$gmane$org@johannes.berg>
References: <200706242239.05678.rjw@sisk.pl> <200706242240.40476.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2987917411278841932=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706242240.40476.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


--===============2987917411278841932==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-iFdJk4Krnt1acqwwI3oo"


--=-iFdJk4Krnt1acqwwI3oo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2007-06-24 at 22:40 +0200, Rafael J. Wysocki wrote:

> + * @set_target: Tell the platform which system sleep state is going to b=
e
> + *	entered.  The information passed to @set_target should be disregarded
> + *	by the platform as soon as @finish() is executed and if	@prepare()
> + *	fails.
> + *	This callback is optional.  However, if it is implemented, the
> + *	argument passed to @prepare(), @enter and @finish() must be ignored.

I don't understand the point in mandating that then the argument to
enter() is to be ignored, why bother? It doesn't look as though we can
possibly do anything with the semantics here that would mean the state
set by set_target is different to the state passed to enter(), can we?

johannes

--=-iFdJk4Krnt1acqwwI3oo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGgDNl/ETPhpq3jKURAuJbAJ9zYP1R2qiqbOPgGJ603QoLXMdajACgqVmf
VmagcPbeGDoXqcyKWOjrdzw=
=/rIH
-----END PGP SIGNATURE-----

--=-iFdJk4Krnt1acqwwI3oo--


--===============2987917411278841932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2987917411278841932==--
