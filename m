From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 02/12] powermac: support G5 CPU hotplug
Date: Fri, 09 Feb 2007 16:36:22 +0100
Message-ID: <1171035382.4520.7.camel@johannes.berg>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124610.392302000@sipsolutions.net>
	<1170940494.4385.51.camel@johannes.berg>
	<1170973463.2620.373.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2129415972=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1170973463.2620.373.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--===============2129415972==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-nqCFb1BSS6H2DfgtGVAw"


--=-nqCFb1BSS6H2DfgtGVAw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-02-09 at 09:24 +1100, Benjamin Herrenschmidt wrote:

> Or we can just mark interrupts as soft-disabled ?

The power4 nap function enables both so we'd have to change some things
around there. Probably a better idea though.

johannes

--=-nqCFb1BSS6H2DfgtGVAw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFzJT2/ETPhpq3jKURAlVTAJ4iXUg9xA6jU5z+3mTTitXdGp7fbQCaAjlz
tlrdpQFZl7NhgkEZUXrGjs0=
=V17U
-----END PGP SIGNATURE-----

--=-nqCFb1BSS6H2DfgtGVAw--


--===============2129415972==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============2129415972==--
