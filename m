From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v11 04/10] power: power_supply: Add
 power_supply_battery_info and API
Date: Wed, 29 Mar 2017 15:50:10 +0200
Message-ID: <20170329135010.3oo3xhnt5ossw55h@earth>
References: <20170320094335.19224-1-liam@networkimprov.net>
 <20170320094335.19224-5-liam@networkimprov.net>
 <CAKvHMgTpRLx+8NHsjcaGpqN=W-7ujBoiXtRwm9A+JGbcNANS-w@mail.gmail.com>
 <20170323101727.y53vc74fskqxdw34@earth>
 <CAKvHMgSzM+XRPLCsM-nUHqf6AnSPzc+ABg8pMerHW_A5=K2Dvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bpgoa7zcp6d7b45f"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932219AbdC2NuY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Mar 2017 09:50:24 -0400
Content-Disposition: inline
In-Reply-To: <CAKvHMgSzM+XRPLCsM-nUHqf6AnSPzc+ABg8pMerHW_A5=K2Dvw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>


--bpgoa7zcp6d7b45f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 25, 2017 at 04:19:24PM -0700, Liam Breck wrote:
> >> > +               dev_warn(&psy->dev, "%s currently only supports devi=
cetree\n",
> >> > +                        __func__);
> >> > +               return -ENXIO;
> >> > +       }
> >> > +
> >> > +       battery_np =3D of_parse_phandle(psy->of_node, "monitored-bat=
tery", 0);
>=20
> Does that change? If not, will psy->dev work in device_property_read_* ?

Oh right, we don't have a device for usage with device_property_read_*.
Then don't mind for now. We can think about this once ACPI/platform based
init is required. Probably simple-battery should get a real driver
at that point.

-- Sebastian

--bpgoa7zcp6d7b45f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljbu48ACgkQ2O7X88g7
+pp6sA//XVK3YBnWQ6d1xsA93EcX5FaSN2ECLDGlIq60xYUDPnap6wgHJTiuuiic
valtsByDklKlW3DeyZpL/7aq4o9wRBZmI7SBhH/yyQax1W309xI1h9pIIeLMB+OP
kL1dFWD/hDBJvq7D0qvwsr110xeFBQRurOEp4qqY+CCHxGuJ0fT1PZaNz7JxppkF
kPlJnqtLvKMA6Z9H5oJPwEj0MRAE8rBJpOQp9ussBnsDz9hNKkR5Yb8IqhPIM2H4
NPsAwZSw9nf3BVycrDE/GbZX4JyWQZUKml38cc1YB0evaGTou8jhDMlnfyXp2bfT
b0vwlomrrCNreMJHu0dqpcucxmQITgeajFsvvTY/Asn0A1KILObZ5Cs7Zr+ISqFs
/QYU0I9I8NYKPC+iEAEk7whgkX27HQLQh+pfFGPiic04PWCWn26/Prv5tzz123lN
pQ9Bsyu/RanxkhD907qUfeUCmnvTkg4S0feCgziu/WAU37QXvxJOAP2qaQKIsUm3
LqLp7Rd3ZwgU/J9OyICakYB9PbxgzRHBoYVdAXCv8k1ajeYGduzgiHIfYG9HXESr
NLF1+IYf8L0VGJEeO/8M3283Vut1Kj5Rodf0bObDZ8gnYem1rkrK0ULZAomf6NRC
UeejR0qXSLeJcj8EXbLsObZbAKVCBcQWhTZ5RNcjvAcRXcZA8vA=
=PC3W
-----END PGP SIGNATURE-----

--bpgoa7zcp6d7b45f--
