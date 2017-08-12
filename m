From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2] power: supply: Fix power_supply_am_i_supplied to
 return -ENODEV when apropriate
Date: Sat, 12 Aug 2017 14:04:44 -0400
Message-ID: <20170812180444.mkonvh3fd4tqwcmk@earth>
References: <20170806162352.12906-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uo5a2v7oc5jp7sdv"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50641 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752231AbdHLSEs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Aug 2017 14:04:48 -0400
Content-Disposition: inline
In-Reply-To: <20170806162352.12906-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-pm@vger.kernel.org


--uo5a2v7oc5jp7sdv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 06, 2017 at 06:23:52PM +0200, Hans de Goede wrote:
> Commit 2848e039c562 ("power: supply: Make power_supply_am_i_supplied retu=
rn
> -ENODEV if there are no suppliers") was supposed to make
> power_supply_am_i_supplied() return -ENODEV when there are no supplies
> which supply the supply passed to it.
>=20
> But instead it will only return -ENODEV when there are no supplies at
> all as data->count++; is incremented on every call of the iterator, rather
> then only when __power_supply_is_supplied_by returns true. This commit
> fixes this.
>=20
> Fixes: 2848e039c562 ("power: supply: Make power_supply_am_i_supplied ...")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thanks, queued.

-- Sebastian

> ---
> Changes in v2:
> -Resend as a standalone patch rather then as part of an unrelated patch-s=
et,
>  no changes
> ---
>  drivers/power/supply/power_supply_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 0aacc721ebda..3f92574222de 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -314,11 +314,12 @@ static int __power_supply_am_i_supplied(struct devi=
ce *dev, void *_data)
>  	struct power_supply *epsy =3D dev_get_drvdata(dev);
>  	struct psy_am_i_supplied_data *data =3D _data;
> =20
> -	data->count++;
> -	if (__power_supply_is_supplied_by(epsy, data->psy))
> +	if (__power_supply_is_supplied_by(epsy, data->psy)) {
> +		data->count++;
>  		if (!epsy->desc->get_property(epsy, POWER_SUPPLY_PROP_ONLINE,
>  					&ret))
>  			return ret.intval;
> +	}
> =20
>  	return 0;
>  }
> --=20
> 2.13.3
>=20

--uo5a2v7oc5jp7sdv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmPQzsACgkQ2O7X88g7
+ppa6g//auoxkg4dK3yiXdLk00S7dih92DokQyr7Ng2um8pzb7//VI+N3pdVM4Ic
1TRIvnqCgl+y3YxZxjcxz6sqNs3mdnqJHsEXvLGf4Md7+6irpi0yD3Wfq/t/vWsJ
dJoobQczw4I6j+zQRxnPruMdOZpjhuMlnvWIJZtfFFA6uoh4+boAdwKGckaWKFgW
pRIDf8flcuSvNyQOg+wUMXi1ZeWPcRsTunSK5MwtayHy0s79vUYYpOzTmLDxp45g
+Rdj5kcc6WAuvXpCeCKZgxBQXocpOeas9ktFQvGdVgKzaDaTfbEvIUuA1XTCnW9C
ERBiGbxZlEbWCeCJ2iLHjHGqrS4eWjr+ou3T7SawpexLPgca/2maysc717Q/dLH+
KiVjjJiyAjxGUXx10w4XHA/e2jrJN7hlqFzecynR/vAfBrtgf8bJoRg2jP/lZXoL
F/jZ/Nrc9mD3ioqQSatJk0D4yTYQu5aDaxMCWbX/+taZZh9zSLKxUpMgZx9XCKFu
fBVHDdCoreiUHOYI52TnLLPZ7+WxSDsDfaC0J9IahFrIpWLRV93YJ4p6dSdgAQ4n
dQeRu8AvF1TIRFiR5F0W8OAKA15/uPmLfF4UgirZvdoH3TU1ay3ts2kmMmZpIbhJ
GhUpAXyRlG87sYz2VWZBNfPPUS6rGxLgdEUz3hbvpyefwb2pOcM=
=PT7y
-----END PGP SIGNATURE-----

--uo5a2v7oc5jp7sdv--
