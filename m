From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7 05/10] i2c: core: call of_i2c_setup_smbus_alert in
 i2c_register_adapter
Date: Mon, 19 Jun 2017 17:28:11 +0200
Message-ID: <20170619152811.svoxmxybyoy6l4hc@ninjato>
References: <1497535178-12001-1-git-send-email-preid@electromag.com.au>
 <1497535178-12001-6-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vnowmshfru3jtffk"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:53724 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752899AbdFSP2N (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Jun 2017 11:28:13 -0400
Content-Disposition: inline
In-Reply-To: <1497535178-12001-6-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, jdelvare@suse.com, jglauber@cavium.com, david.daney@cavium.com, peda@axentia.se, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org


--vnowmshfru3jtffk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2017 at 09:59:33PM +0800, Phil Reid wrote:
> Add a call to of_i2c_setup_smbus_alert when a i2c adapter is registered
> so the the smbalert driver can be registered.
>=20
> Signed-off-by: Phil Reid <preid@electromag.com.au>

CCing Benjamin

> ---
>  drivers/i2c/i2c-core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index d2402bb..626471b 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -40,6 +40,7 @@
>  #include <linux/gpio.h>
>  #include <linux/hardirq.h>
>  #include <linux/i2c.h>
> +#include <linux/i2c-smbus.h>
>  #include <linux/idr.h>
>  #include <linux/init.h>
>  #include <linux/irqflags.h>
> @@ -2045,6 +2046,9 @@ static int i2c_register_adapter(struct i2c_adapter =
*adap)
>  		dev_warn(&adap->dev,
>  			 "Failed to create compatibility class link\n");
>  #endif
> +	res =3D of_i2c_setup_smbus_alert(adap);
> +	if (res)
> +		goto out_list;
> =20
>  	i2c_init_recovery(adap);
> =20
> --=20
> 1.8.3.1
>=20

--vnowmshfru3jtffk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllH7YsACgkQFA3kzBSg
Kba4QhAAkmrmp/tUJpOFlGU3XMCXnLq6Syf4LIG6lqb3uLeEekbHu8quJBq7PvcP
U2uSLJ6gh1zgrI4jIij/ow/pAKJYOqWWZM5vywraY6+dOmUltW3JHuTXzIwiZx28
cATEZRzBTOyq3mESSY3kpV0lPi5+P0Yw1Ab1sCIm3n56KaV9U8oLqZZqFCLjIElO
BwSPYLRipro4P9KQwHjHOkAa6uE89gi2egMYNudMoTVld05k60riyaBKa+/fcvM9
B/3h1R+cr0C7/Vg2KkWLVK3LmVkwI+NpQ7aElAIUGpT6WRdj8+0gJr66N3ZCMTLy
SQQ5HatT23uDTA0fqIQoimFITsdUyeKgE2Gf3VjWT05d25RegFTKgaM2+MC91TUF
adI0y/mm0WCnYSH9IvJ93BK53Ue2FnJX4JZya1u4EO89gDQnLGwAhGOJ81TyAJOG
FJCMIRvpol8N+wnSZ41RAeVktSG+MpEwBd5AEc3Q6UfhvSiQwPPLohQx2pPC3G62
OB6BbAIsHTeke/pX5L1K3eM84mZGF6E4oG2OWl/6MTnPoSGNyoZNpJztPUKe6Z5w
LS+dOH6MH/uzyz23anT4XWp7gczXsPf2ha9j/LN4eUZ2ozrt/3QvGqJrlY0sxtae
G7uwg4aIZ3Qnrye68pBEMOL4ZhNvqDI8mSuN2JI/uMngAM14t9U=
=ZKr3
-----END PGP SIGNATURE-----

--vnowmshfru3jtffk--
