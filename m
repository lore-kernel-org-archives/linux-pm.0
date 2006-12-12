From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC 0/3] experimental G5 powermac
	suspend	implementation
Date: Tue, 12 Dec 2006 14:36:03 +0100
Message-ID: <1165930563.22338.32.camel@johannes.berg>
References: <20061211230208.526233000@sipsolutions.net> >
	<1165926068.22338.15.camel@johannes.berg>
	<20061212132240.GE5190@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1389577309=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20061212132240.GE5190@ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org, Michael Buesch <mb@bu3sch.de>, Torrance <torrance123@gmail.com>
List-Id: linux-pm@vger.kernel.org


--===============1389577309==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-vTjyKeZZ4i6HmVbUdyyu"


--=-vTjyKeZZ4i6HmVbUdyyu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-12-12 at 13:22 +0000, Pavel Machek wrote:

> Clock do not tick while suspended; I guess you need to copy time
> suspend/resume from i386 or something.

Well the RTC of course ticks but the system clock obviously doesn't.
Yes, I'll have to look at the time suspend/resume code. Do you know
where to find it?

johannes

--=-vTjyKeZZ4i6HmVbUdyyu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFfrBD/ETPhpq3jKURAt1lAJ4+5VxDHHZRT5VC+9rgd2k2wVS/2QCgmRAf
1a0kJBBZXqz4P8W05kY8GL0=
=OnQd
-----END PGP SIGNATURE-----

--=-vTjyKeZZ4i6HmVbUdyyu--


--===============1389577309==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1389577309==--
