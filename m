From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 02/12] powermac: support G5 CPU hotplug
Date: Wed, 14 Feb 2007 20:11:36 +0100
Message-ID: <1171480296.6093.0.camel@johannes.berg>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124610.392302000@sipsolutions.net>
	<1170940494.4385.51.camel@johannes.berg>
	<20070214144556.GC25910@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1401525160=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070214144556.GC25910@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--===============1401525160==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-TRf2EKv4GHGAT4HlgM1I"


--=-TRf2EKv4GHGAT4HlgM1I
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-02-14 at 15:45 +0100, Pavel Machek wrote:

> Can you disable timer interrupt on the interrupt controller, instead?

No, it's not actually an external interrupt, the "timer interrupt" on
powerpc is the decrementer exception which is built into the CPU.

In any case, the soft-irq disable stuff I already posted a bit later
provides the same with no more runtime overhead than we already have.

johannes

--=-TRf2EKv4GHGAT4HlgM1I
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF017o/ETPhpq3jKURAjt9AKC1L3dZDIYIaue8Os66b7nx4dTa2gCeInjI
p63Mh9pQwNrbH4YKP5+oFpM=
=Ztey
-----END PGP SIGNATURE-----

--=-TRf2EKv4GHGAT4HlgM1I--


--===============1401525160==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1401525160==--
