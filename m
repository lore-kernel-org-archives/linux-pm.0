From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Power Mangement Interfaces
Date: Wed, 04 Apr 2007 23:49:59 +0200
Message-ID: <1175723399.7388.47.camel@johannes.berg>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200703310957.49409.david-b@pacbell.net>
	<1175703359.7388.10.camel@johannes.berg>
	<200704041144.15300.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1208619850=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704041144.15300.david-b@pacbell.net>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============1208619850==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-fUywl7CwFSXeos32d4+H"


--=-fUywl7CwFSXeos32d4+H
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-04-04 at 11:44 -0700, David Brownell wrote:

> I'm not sure I understand the question.  ACPI has a special "acpi_device"
> node (not backed by any "real" device, PNPACPI etc) with a driver that
> hooks up to the input subsystem.  Same is true for a couple other fixed
> function buttons.  I'd expect non-ACPI platforms would do something very
> similar, except using platform_device and looking less cryptic.

No, the thing is more: how would we represent the lid as a device in
sysfs? Currently, our PMU only has a sysdev because it doesn't need
more. Would you suggest doing a PMU-bus and than hanging "lid" off of
that?

johannes

--=-fUywl7CwFSXeos32d4+H
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGFB2H/ETPhpq3jKURAh0JAKChoD+1BqUChBkHtaknVCndIROhAgCgqCLy
1ONym62CJccjrpyDKAe0kGk=
=BAl2
-----END PGP SIGNATURE-----

--=-fUywl7CwFSXeos32d4+H--


--===============1208619850==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1208619850==--
