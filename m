From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: [PATCH (2.6.25) 1/2] hibernation: clean up Kconfig
Date: Thu, 08 Nov 2007 19:21:15 +0100
Message-ID: <1194546075.4793.34.camel@johannes.berg>
References: <20071107135758.100171000@sipsolutions.net>
	<200711072317.48023.rjw@sisk.pl>
	<1194533053.6294.42.camel@johannes.berg>
	<20071108092149.e27c5ba3.akpm@linux-foundation.org>
	<1194543003.4793.19.camel@johannes.berg>
	<20071108100618.40e6c0af.akpm@linux-foundation.org>
	<1194545496.4793.28.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7989142400283369333=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1194545496.4793.28.camel@johannes.berg>
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


--===============7989142400283369333==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Fxs+GwkwhlcTvDleuKru"


--=-Fxs+GwkwhlcTvDleuKru
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> No, it wasn't, I diffed it against -rc1. I tested the Kconfig changes
> with "make ARCH=3Dx86_64 menuconfig" and "make ARCH=3Di386 menuconfig". A=
s
> far as I understand, the new x86 arch depends on being called as
> ARCH=3Di386 or ARCH=3Dx86_64. I may have misunderstood how the x86
> architecture works but hoped Rafael would know more and tell me if I was
> wrong.

ok, so Christoph Hellwig and others tell me "it's being worked on".
Please ignore these patches, I'll send new ones once that architecture
has worked out how it wants to work.

johannes

--=-Fxs+GwkwhlcTvDleuKru
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARzNTmqVg1VMiehFYAQKVGQ//UBIbchx9QwX8ELGEuciQwcMegeGa+jOP
Uw3X0sOwYc5Ah2sl5vBYsA0IJQ1mYzrhWhuvNgFOtYqdUnlJC577qZJ5/8FZM8KW
2RZ/+Xs1oy8eXyqNa1/ZRXq9lN4G3PkUowZ4PheOztoRErI1j9pAIRUdhvYJdcIA
LJ49bxCD2JzQlW/RKfguaPHHFVA1yf5BBsWKMIlK6wfFKgv+f4zL1S8c5HXCtHBW
MtoVxQr8MQSQ79DMvM9YQSriX6DC3CoeBsWEin4syYwhjGt9BWNha3OxLh8EDi4v
Y4KEsv3whdoeZyi0OW7hJahOEKVE30Wk2AxueufB42xndi2MuTtJzI0LfJ2Wces3
iYD+rZE1FIeZBe+hQ15JA5CJgyU8EHuLLt+AAwXgt6ltv/64Ja6Az5NTrZpTREs1
dReiC1jDz9Vt1IQTdxPZ+KNneBIeCGD+k+I04g2DO1/HbHcrwl3BG24SxmFRau/r
Bv9FFrOHtA9Xiww6XL2LPghIpdI9CrTW9S7oPTkl/XwV2Y/oxn1EfX88hMoKz4xk
s0dF4bOvkyqXSrBZr1KaYP/l/pzU2v9Y1vuXxCiJxz/fAVemUjzo6voKZFp6vut5
2pkGrI6jbLWk+BZhuLOy0Bum4j/pbnZuGZZiAFbGaCHPK1SF6oa7XhEdujEdq6G3
9MELhXun8gA=
=M3Bf
-----END PGP SIGNATURE-----

--=-Fxs+GwkwhlcTvDleuKru--


--===============7989142400283369333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7989142400283369333==--
