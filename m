From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 12/15] thermal: rcar-thermal: Enable driver compilation
 with COMPILE_TEST
Date: Thu, 12 Dec 2013 10:01:44 -0400
Message-ID: <52A9C1C8.2030907@ti.com>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1385515117-23664-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <5903007.OehDdPcG2U@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5raGqgdR5u0RLIaPJTFhI1IiunJVJ6Toe"
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <5903007.OehDdPcG2U@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--5raGqgdR5u0RLIaPJTFhI1IiunJVJ6Toe
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11-12-2013 08:50, Laurent Pinchart wrote:
> Hi Zhang and Eduardo,
>=20
> Could you please pick this patch up for v3.14 ?

Yes Laurent, I can pick it.

>=20
> On Wednesday 27 November 2013 02:18:34 Laurent Pinchart wrote:
>> This helps increasing build testing coverage.
>>
>> Cc: Zhang Rui <rui.zhang@intel.com>
>> Cc: Eduardo Valentin <eduardo.valentin@ti.com>
>> Cc: linux-pm@vger.kernel.org
>> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard=
=2Ecom>
>> Acked-by: Simon Horman <horms@verge.net.au>

Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

>> ---
>>  drivers/thermal/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index f35a1f7..661cafc 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -121,7 +121,7 @@ config SPEAR_THERMAL
>>
>>  config RCAR_THERMAL
>>  	tristate "Renesas R-Car thermal driver"
>> -	depends on ARCH_SHMOBILE
>> +	depends on ARCH_SHMOBILE || COMPILE_TEST
>>  	help
>>  	  Enable this to plug the R-Car thermal sensor driver into the Linux=

>>  	  thermal framework.


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--5raGqgdR5u0RLIaPJTFhI1IiunJVJ6Toe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlKpwcwACgkQCXcVR3XQvP1mkQD/ePDH+zoxcQvLP5VXDLT4EG90
Wf12up6SQozBlbzRmOkA/1rlnd7iOZSTb72xVMm+gs1reG9PbWFBNd91Zd9niQuU
=fEZC
-----END PGP SIGNATURE-----

--5raGqgdR5u0RLIaPJTFhI1IiunJVJ6Toe--
