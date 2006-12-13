From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [linux-pm] [RFC 0/3] experimental G5 powermac suspend
	implementation
Date: Wed, 13 Dec 2006 13:37:27 +0100
Message-ID: <1166013447.7273.3.camel@johannes.berg>
References: <20061211230208.526233000@sipsolutions.net>
	<1165926068.22338.15.camel@johannes.berg>
	<20061212132240.GE5190@ucw.cz>
	<1165930563.22338.32.camel@johannes.berg>
	<1165932463.22338.37.camel@johannes.berg>
	<20061212173421.GA31090@iram.es>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1517451464=="
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20061212173421.GA31090@iram.es>
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
To: Gabriel Paubert <paubert@iram.es>
Cc: linuxppc-dev@ozlabs.org, Pavel Machek <pavel@suse.cz>, linux-pm@lists.osdl.org, Michael Buesch <mb@bu3sch.de>, Torrance <torrance123@gmail.com>
List-Id: linux-pm@vger.kernel.org


--===============1517451464==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-an/5wNr5OlSu7oLhnO+V"


--=-an/5wNr5OlSu7oLhnO+V
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-12-12 at 18:34 +0100, Gabriel Paubert wrote:

> Timer is also restored from RTC on wakeup on powerbooks, so=20
> there is already something under arch/powerpc...

Right :) Sending a patch in a minute.

johannes

--=-an/5wNr5OlSu7oLhnO+V
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFf/QG/ETPhpq3jKURAiMKAJ0ZoACDOrqNabpFVhxfWOI+LbPIzgCfXIGg
IRyxbEHa/s6ehr1fe3Y1Q2c=
=80dL
-----END PGP SIGNATURE-----

--=-an/5wNr5OlSu7oLhnO+V--


--===============1517451464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
--===============1517451464==--
