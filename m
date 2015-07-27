From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2] power: max17042_battery: add HEALTH and TEMP_*
 properties support
Date: Mon, 27 Jul 2015 03:22:36 +0200
Message-ID: <20150727012235.GA24229@earth>
References: <1432438918-31002-1-git-send-email-ramakrishna.pallala@intel.com>
 <CAJKOXPeUvdC5LwRLgsFfxz2=SZwkjq2soGius+j6kb76Ea940A@mail.gmail.com>
 <CAJKOXPepZ9gKtnKk7Z4BFjUk=_kv6j010dZWhhu9bf_OuVmrgQ@mail.gmail.com>
 <20150724144651.GE27569@earth>
 <D854C92F57B1B347B57E531E78D05EAD578B35A6@BGSMSX104.gar.corp.intel.com>
 <55B57C85.4070309@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60584 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755079AbbG0BWj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 26 Jul 2015 21:22:39 -0400
Content-Disposition: inline
In-Reply-To: <55B57C85.4070309@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: "Pallala, Ramakrishna" <ramakrishna.pallala@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 27, 2015 at 09:34:13AM +0900, Krzysztof Kozlowski wrote:
>>> [...]
>>
>> I missed this email (may be overlooked it). To have the
>> interrupts enabled we need the config registers(0x1Dh) bit's
>> BIT(9), BIT(4) and BIT92) should be 1 and  BIT(8) should be 0.
>>=20
>> Can you dump the status(00h), Talrt(02H) Temp(08h) and
>> config(1Dh) registers values and share?
>=20
> Thanks for responding. The issue was in BIT(8) which was set to default
> value of 0x1. This would mean to use external sensor but the board does
> not have it.
>=20
> This is a DT platform and there is no initial config data so all
> registers are set to default values.
>=20
> Anyway everything seems to work as expected, thanks for explanation.

So I guess the bit should be set to 0 during probe. Maybe with a
boolean DT property "maxim,has-external-sensor" for setting it
to 1.

-- Sebastian

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVtYfbAAoJENju1/PIO/qaNxoQAJs8dWhHKcogy14UU+jQLySn
U7OHKKPH4te/C81nG2/rAkdvnwGt0ioS1tS3YT7V+GPblxLg/NgQTs6UMKZO9khZ
MvXrBhkiJegsi2vF1vzu3oqrI40nM7zUyiu6t9AXvhWD0lCpGQsw1aKqgUJq4QTl
MGomE2gT5A6mVw93mHrjNHoa6/xESlN7wm4BvNlWiW3Sd+2vrjm2clAPbTKpAg46
Q7zHrKg7NswtjxbjZXunCiAnqjnewOjJVP+vv4/P+oKASilzeYzj6WfoFObDfAZi
1B8CtcwVx+9bUNbvfTSVHuXsyFbNAezC2YmZoBDRW8AbzjSclSBElfxKdNhELRb4
0TCDLTSMx9BbYWxKTOul0fWsQ6Fmwqr0nA5AvJjhXxnSDMTLLBujijpkWulsIQnN
s2qdK/i7QhDmpbx5jr7/q5rnqvgZqqubkCpSYF4U+2yGLPz9Z2qylo0dklj7+Pfb
F++ddjtE6N70OKq4pzoOAyRIH1NxXTEc2GE9x+4w3Ra9pQfcm6BDkLT9Uxs6t9b0
+HCc6+8z4UMvgVCLpK6fufZth4TlWxAEYEsrfLM//tNcqaXxkLfxnFksYFyNu2YN
k50EyhmOSw7bvnEn0eokfCBc9eT0i7q6yDBBxSdVcvNHwGtxV3IYZw45s+9UIIEo
VyCXsocPkvlgFZwuO2IW
=UvSR
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
