From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 2/7] power: supply: bq24190_charger: Add support for
 bq24192i
Date: Thu, 23 Mar 2017 12:12:37 +0100
Message-ID: <20170323111237.k6crwrhwgtto24di@earth>
References: <20170322145536.30570-1-hdegoede@redhat.com>
 <20170322145536.30570-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kywxgngqupaqdb5j"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753281AbdCWLUz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Mar 2017 07:20:55 -0400
Content-Disposition: inline
In-Reply-To: <20170322145536.30570-3-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>, Tony Lindgren <tony@atomide.com>


--kywxgngqupaqdb5j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 22, 2017 at 03:55:31PM +0100, Hans de Goede wrote:
> The bq24192 and bq24192i are mostly identical to the bq24190, TI even
> published a single datasheet for all 3 of them. The difference
> between the bq24190 and bq24192[i] is the way charger-type detection
> is done, the bq24190 is to be directly connected to the USB a/b lines,
> where as the the bq24192[i] has a gpio which should be driven high/low
> externally depending on the type of charger connected, from a register
> level access pov there is no difference.
>=20
> The differences between the bq24192 and bq24192i are:
> 1) Lower default charge rate on the bq24192i
> 2) Pre-charge-current can be max 640 mA on the bq24192i
>=20
> On x86/ACPI systems the code which instantiates the i2c client may not
> know the exact variant being used, so instead of coding the model-id
> in the i2c_id struct and bailing if it does not match, check the reported
> model-id matches one of the supported variants.
>=20
> This commit only adds support for the bq24192i as I don't
> have a bq24192 to test with, adding support for the bq24192 should
> be as simple as also accepting its model-id in the model-id test.
>=20
> Cc: Liam Breck <kernel@networkimprov.net>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Improve commit msg
> -Drop model-id from bq24190_i2c_ids table and bdi struct
> -Only add support for the bq24192i and not for the bq24192
> ---

Thanks, queued.

-- Sebastian

--kywxgngqupaqdb5j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljTraUACgkQ2O7X88g7
+prZBg/9EZiOWd3k5qvVVpXWYC8oXlKRE+aTN2MVvOBQqS13yX/HjZxNf6DgB/OE
UNsySCGgkjCq/GRXzaDn9LDK/qQWJtAIQloWAlfmz1bF2/NfF0gbJW6+NX3Cnk7d
r1rQ6aNLRHgMT5PBYjdA5CM/6IyfXUA5RjCJKofqsDcwatEj3GVNVzehjCMtL7r6
CKu0E2VsksbNQJGRKloHeIoCX3Xm++JXeR3Lo1xANVmL24yQqPpGiWyxLL5W4hIc
qEbMSDVxnCG3sz8EovE3JYP6L7Yv0cEIBqAtTeWEhNR5DXTxunh648s51MpjKQ4b
iWPqR08eIUaQzvEAaNr2VW9uTK92CVqXk0vrB2h2+ivOfExfBnSZFsItiZ9AIaVP
+KdqTn51j9QZ8a0yd26fk6Fq058wsTwk2rS9xTeHrlylFLZKei4nZng/AiNXBMRu
c0KmlDpj4K+qEf63WYokPtEnSOu6rlHEF4fjggbfcFuDXCB6GmPSB/maUhEnnP7y
nWmnmrDcgAi4G3Tkh806R+OFD6MDh8WVpcfsEbcKO4TVzId6x08bQusjxgp5pIZY
8F/QeiG7ZChdfgCSNs/N1GdWFZYkCs73UMeSWHQObPXWlLFZPjL5fN5GStb/uuOO
8Gf9VeYiqiPAf/IKVIgqaOqUsZuBHte09+88A8v6/3Yv1Ye9i8s=
=jzts
-----END PGP SIGNATURE-----

--kywxgngqupaqdb5j--
