From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH (2.6.25) 1/2] hibernation: clean up Kconfig
Date: Thu, 08 Nov 2007 19:11:36 +0100
Message-ID: <1194545496.4793.28.camel@johannes.berg>
References: <20071107135758.100171000@sipsolutions.net>
	<200711072317.48023.rjw@sisk.pl>
	<1194533053.6294.42.camel@johannes.berg>
	<20071108092149.e27c5ba3.akpm@linux-foundation.org>
	<1194543003.4793.19.camel@johannes.berg>
	<20071108100618.40e6c0af.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2716671042634868658=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071108100618.40e6c0af.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--===============2716671042634868658==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-iuGcRNwDjosqqmwiwwfX"


--=-iuGcRNwDjosqqmwiwwfX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> I assume this was against 2.6.23.  Please, it's not very useful to prepar=
e
> patches against such an old kernel.  Even if the receiver were to fix te
> patch up, there isn't much confidence that it will actually work at
> compile-time and runtime.

No, it wasn't, I diffed it against -rc1. I tested the Kconfig changes
with "make ARCH=3Dx86_64 menuconfig" and "make ARCH=3Di386 menuconfig". As
far as I understand, the new x86 arch depends on being called as
ARCH=3Di386 or ARCH=3Dx86_64. I may have misunderstood how the x86
architecture works but hoped Rafael would know more and tell me if I was
wrong.

joahnnes

--=-iuGcRNwDjosqqmwiwwfX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARzNRV6Vg1VMiehFYAQKaVA/8CBLMwrg8Vn0N1uCBXR3WgC5AwPDaM1+F
OrCXtu+ysYNSCUUTjx7ZLGO2vmMpD6hXFO/DPdHovCSFW6CKGtLk6GxrHGK793Tg
T4pjA3u9tH3ukwC87f/h7MQuXbDgjzo7Ns/iojSKuFhN393vbPbxg57LjO2AGgKJ
EH8qefiQggbeBOupR+OHUPK6FD2s0TF8NhuTgNTsGVzKbb2D2hbbhR1LsjCcEwi5
Cnk8zUzvJHi0IVQSy/XSafEoCnMUKJ3DZ/aGMmAz+N1fVBOWkZuvC7InKSd3UCxC
WO4i1UW1InUTFWrsneW3OC5TnhkHUCquFPIdxJ5h1e+QIk/ZhwhFnb25JEPeX/8g
RZ1MYLwPaqbPZa7eUSLQUC2IfCVQgeRx69kRHFXzylXC2Ekh54DpRQ1TBHrxGtXd
dbPaoJ+gjDr6OL5Lr8xSrmOU5fpBV6r5pLAfnruK6iyrAh5W91VppUikA7C98iMg
bT7TUYyQ4cJmGhOf1/20SnIZGx3Bgf9JAHuxSyast2hKyAaKb2a6U1IcxUNUcJFJ
2c5nJ+nCjPq6VOiAXHkANPso8mpybqQpK8AYC/2gRPCjVqpJrIBxqrdTDdO94QDO
qi3Q/Obyav8ghii/jBELOjaIxo2ymGkLsYDja3gbUYqqLrPuIaWGh+zx097Dyw4I
qf+UgWkRajQ=
=vqsE
-----END PGP SIGNATURE-----

--=-iuGcRNwDjosqqmwiwwfX--


--===============2716671042634868658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2716671042634868658==--
