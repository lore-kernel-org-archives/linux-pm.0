From: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/7] arm: dts: add dra7 IVA thermal data
Date: Tue, 1 Oct 2013 21:26:31 -0400
Message-ID: <524B7647.9050208@ti.com>
References: <1380652344-18819-1-git-send-email-eduardo.valentin@ti.com> <1380652344-18819-3-git-send-email-eduardo.valentin@ti.com> <20131001223337.GA11451@kahuna>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6pqVNbPwKseJBULfT3TQs8lHgS5ktBjh2"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131001223337.GA11451@kahuna>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--6pqVNbPwKseJBULfT3TQs8lHgS5ktBjh2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01-10-2013 18:33, Nishanth Menon wrote:
> On 14:32-20131001, Eduardo Valentin wrote:
> minor comments follow
>> This patch changes a dtsi file to contain the thermal data
> s/changes/introduces?
>> for IVA domain on DRA7 and later SoCs. This data will
>> enable a thermal shutdown at 125C.
>>
>> This thermal data can be reused across TI SoC devices.
> is'nt it just DRA7 that reuses this - based on dtsi name?

For now, yes, but the file is intended to be reusable. just like the
file with cpu thermal zone is reusable on omap4/5/dra devices.

>>
>> Signed-off-by: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/dra7-iva-thermal.dtsi | 28 ++++++++++++++++++++++++=
++++
>>  1 file changed, 28 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/dra7-iva-thermal.dtsi
>>
>> diff --git a/arch/arm/boot/dts/dra7-iva-thermal.dtsi b/arch/arm/boot/d=
ts/dra7-iva-thermal.dtsi
>> new file mode 100644
>> index 0000000..fea0cea
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/dra7-iva-thermal.dtsi
>> @@ -0,0 +1,28 @@
>> +/*
>> + * Device Tree Source for DRA7 SoC IVA thermal
>> + *
>> + * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.=
com/
>> + * Contact: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
>> + *
>> + * This file is licensed under the terms of the GNU General Public Li=
cense
>> + * version 2.  This program is licensed "as is" without any warranty =
of any
>> + * kind, whether express or implied.
>> + */
>> +
>> +#include <dt-bindings/thermal/thermal.h>
>> +
>> +iva_thermal: iva_thermal {
>> +	polling-delay-passive =3D <250>; /* milliseconds */
>> +	polling-delay =3D <1000>; /* milliseconds */
>> +
>> +		/* sensor       ID */
> ^^ double tab here?
>> +	thermal-sensors =3D <&bandgap     4>;
> space after bandgap is good enough?

Those tabulation were intentional, to hint that 4 means sensor id.

>> +
>> +	trips {
>> +		iva_crit: iva_crit {
>> +			temperature =3D <125000>; /* milliCelsius */
>> +			hysteresis =3D <2000>; /* milliCelsius */
>> +			type =3D THERMAL_TRIP_CRITICAL;
>> +		};
>> +	};
>> +};
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--6pqVNbPwKseJBULfT3TQs8lHgS5ktBjh2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlJLdkcACgkQCXcVR3XQvP0h9gD+MOsSs0efkzK+Eml5snVILD76
7scvGupqFQv89A61pzIBAOGPCcZA0bSemUhIBUxx97q3cs3GWtzd0wscYcVKlHRg
=9IZC
-----END PGP SIGNATURE-----

--6pqVNbPwKseJBULfT3TQs8lHgS5ktBjh2--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
