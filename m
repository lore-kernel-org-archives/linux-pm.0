From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: act8945a_charger: fix of_irq_get() error
 check
Date: Mon, 17 Jul 2017 15:23:53 +0200
Message-ID: <20170717132353.kes73qjxfh2quy2l@earth>
References: <20170716175244.300670810@cogentembedded.com>
 <c0a5fce5-4185-249b-e206-4964d41ab05a@cogentembedded.com>
 <20170717105003.riv7fe44jzmkffg3@earth>
 <9f7d4b95-dcea-d8bf-8bf4-6551d4ab7b58@cogentembedded.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l4zzoanpx7ohxfym"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751373AbdGQNX5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Jul 2017 09:23:57 -0400
Content-Disposition: inline
In-Reply-To: <9f7d4b95-dcea-d8bf-8bf4-6551d4ab7b58@cogentembedded.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-pm@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>


--l4zzoanpx7ohxfym
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 17, 2017 at 03:00:26PM +0300, Sergei Shtylyov wrote:
> Hello!
>=20
> On 07/17/2017 01:50 PM, Sebastian Reichel wrote:
>=20
> > > Forgot to mention that this patch is against Linus' repo as Sebastian=
's repo
> > > lags behind at 4.10-rc1...
> >=20
> > You are supposed to use my for-next branch [0] and not master :) That
> > one was 4.12-rc1 + power supply patches until a few hours ago and
> > now is 4.13-rc1. So if you based on current master from Linus it
> > should be ok. I will start reviewing patches for the v4.14 cycle
> > shortly.
>=20
> I first tried to use 'fixes' but that one was at 4.8-rc1, then
> switched to back to 'master'. Since this patch is a bug fix, I
> didn't consider for-next.

Right, I did not check carefully enough. I often do not have to
send any fixes, so that branch tends to get stale.

-- Sebastian

--l4zzoanpx7ohxfym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllsumcACgkQ2O7X88g7
+prBaQ//d2Gm3RN7oL1FyjW/SxbGXfw3VVMxkeRL+4x/pBz/TsbjBtU2TftmY305
UelQkMBEwcWhel1GnSShIXQocN57PSqDB/vwyCX8A/wzJy2orfTcuOR9D0Hw1Erf
AIT8gDF7jNV84Ri7g8HazJH3T00Seje7e/S3Hk0mkwWP7x5xt5YhVp0xUZrW3Dpx
agJjKddm4W6lMH2wlgUK1oYCbPN50f0JTYeUBjOUprmRT4dai1J2ZbFKLho6v5NJ
tTVSaRCMzMKbYr6eiDzf0maFnOeewGriUez+fIHO1HgcDzoeNs1UKgZ6ptqXqpCg
sJbbzq01tzzw+immpxtebgtFtQM49QvUvbvnaeb+8TnXH1NLsa/RWjstTNLu8/EL
t+N0TCegbg0/XYkaOshoeXAY7NvQGsGbFeQUbKp5PfhJvv7MUZu4TXZqWS++wnl+
C1umRaIpnwnncV7a3aqQyHtPLSKwjnisldusy6ybvXiX0RoPsI6PkYmNejko6Gc3
9G4zBxLIpbqM1lz/qeTzAoGmXb2BK7ndjXEyhCSSzigud3ZT8HRkSxIQDBIqTt9b
2FQbM/hHmGDwdYD/W0mMsrp5aUL8FVKJe5DKM/TfdOIxN6LJSMx4FnUJZlcC/haq
faqLDGPw1fdKOt7/iJqx3nydedbeGRjn5+Tkpluim1lcCXz6GXg=
=q4fB
-----END PGP SIGNATURE-----

--l4zzoanpx7ohxfym--
