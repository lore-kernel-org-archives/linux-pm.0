From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] power: supply: Add fwnode pointer to
 power_supply_config struct
Date: Tue, 22 May 2018 18:15:32 +0200
Message-ID: <20180522161532.qqmyknk6f3scwzpg@earth.universe>
References: <cover.1527000797.git.Adam.Thomson.Opensource@diasemi.com>
 <c398d1fcc81017b9cc694a00d2c1f655874dfeac.1527000797.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="piqsyxv6m4f4ofuj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c398d1fcc81017b9cc694a00d2c1f655874dfeac.1527000797.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com
List-Id: linux-pm@vger.kernel.org


--piqsyxv6m4f4ofuj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 22, 2018 at 04:16:23PM +0100, Adam Thomson wrote:
> To allow users of the power supply framework to be hw description
> agnostic, this commit adds the ability to pass a fwnode pointer,
> via the power_supply_config structure, to the initialisation code
> of the core, instead of explicitly specifying of_ndoe. If that
> fwnode pointer is provided then it will automatically resolve down
> to of_node on platforms which support it, otherwise it will be NULL.
>=20
> In the future, when ACPI support is added, this can be modified to
> accommodate ACPI without the need to change calling code which
> already provides the fwnode handle in this manner.
>=20
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>  drivers/power/supply/power_supply_core.c | 4 +++-
>  include/linux/power_supply.h             | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index ecd68c2..f57ab0a 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -19,6 +19,7 @@
>  #include <linux/err.h>
>  #include <linux/of.h>
>  #include <linux/power_supply.h>
> +#include <linux/property.h>
>  #include <linux/thermal.h>
>  #include "power_supply.h"
> =20
> @@ -874,7 +875,8 @@ static void psy_unregister_cooler(struct power_supply=
 *psy)
>  	psy->desc =3D desc;
>  	if (cfg) {
>  		psy->drv_data =3D cfg->drv_data;
> -		psy->of_node =3D cfg->of_node;
> +		psy->of_node =3D
> +			cfg->fwnode ? to_of_node(cfg->fwnode) : cfg->of_node;
>  		psy->supplied_to =3D cfg->supplied_to;
>  		psy->num_supplicants =3D cfg->num_supplicants;
>  	}
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 0c9a572..b21c4bd9 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -199,6 +199,8 @@ enum power_supply_notifier_events {
>  /* Run-time specific power supply configuration */
>  struct power_supply_config {
>  	struct device_node *of_node;
> +	struct fwnode_handle *fwnode;
> +
>  	/* Driver private data */
>  	void *drv_data;
> =20
> --=20
> 1.9.1
>=20

--piqsyxv6m4f4ofuj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlsEQh0ACgkQ2O7X88g7
+prbag/+MdsWV2EBxYN+umd8vzZNmSS9/RdlMu/Nrmu3PAbA95P/N/IIRS5+VB1Y
1+WT+Dt9kAwHPc9N/VuD61WxHlNo0ofmuPFEDb0lNdu2diYEpwWm2J2kr1jvCwPd
5xQxi6Lq1Ktig77YyALo4SoMmBb7ANUz5CCrrsUML9lAYuZqvejwtyyzLwjpeAVv
HWxN3z9mRLg7a017goNyBXYJnKhTHXgeOJlnKGbdkJ6ziP/8uAhkgANM3b5CJQyf
OC8vyYJkBvKT63Ai46RHW6X7tWnkwfcgXzkQVCmyHn/krrHLz9wLctpPNXTboB7p
dRJVUS0LcT1NWDWmQ9yWHpAvkdYLw1sWll6cfEm1MLmYbfRS6kFExbGk6Yt6h8mU
MSk8H4Nm74z29MpP7L434JzWs173pQ2zhwXA6IqAppw8kQ0F6ADlq61Cmnd0Fklv
SQXHeHTtpzz1NBf95KBbAuAHp6T5cXJrQA5BzkaaOztoMCTp1hOVbzqKEBr9iaLq
Rkfr/l5ci81iqGH2SkFsKtMQnWB0M3BNBtjMfON+7zap5p6cKTn1g0RDjUGeTefE
WV+syOHSpkOk8I66cmEiLTR80uT2TQXBG4E21wVILUMW0atyqH5VPRdY8RPSlK6C
sv7jXTTSjpnr02o547tHj/J/31HcEUB3U8jJ0IKUqkXwqLL4kcM=
=0taw
-----END PGP SIGNATURE-----

--piqsyxv6m4f4ofuj--
