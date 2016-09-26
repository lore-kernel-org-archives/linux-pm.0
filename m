From: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
Subject: Re: [PATCH 2/2] power: supply: max17042_battery: add technology property support
Date: Mon, 26 Sep 2016 14:56:44 +0200
Message-ID: <87eg46x1ir.fsf@machinist.wiedmeyer.de>
References: <20160926105510.GA8140@kozik-lap>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20160926105510.GA8140@kozik-lap>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Krzysztof Kozlowski writes:

> On Sun, Sep 25, 2016 at 11:10:11PM +0200, Wolfgang Wiedmeyer wrote:
>> This patch reports the battery technology as Li-ion.
>>=20
>> Signed-off-by: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
>> ---
>>  drivers/power/max17042_battery.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>=20
>> diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_b=
attery.c
>> index 20cb1fd..43cb5df 100644
>> --- a/drivers/power/max17042_battery.c
>> +++ b/drivers/power/max17042_battery.c
>> @@ -92,6 +92,7 @@ static enum power_supply_property max17042_battery_pro=
ps[] =3D {
>>  	POWER_SUPPLY_PROP_TEMP_MIN,
>>  	POWER_SUPPLY_PROP_TEMP_MAX,
>>  	POWER_SUPPLY_PROP_HEALTH,
>> +	POWER_SUPPLY_PROP_TECHNOLOGY,
>>  	POWER_SUPPLY_PROP_CURRENT_NOW,
>>  	POWER_SUPPLY_PROP_CURRENT_AVG,
>>  };
>> @@ -296,6 +297,9 @@ static int max17042_get_property(struct power_supply=
 *psy,
>>  		if (ret < 0)
>>  			return ret;
>>  		break;
>> +	case POWER_SUPPLY_PROP_TECHNOLOGY:
>> +		val->intval =3D POWER_SUPPLY_TECHNOLOGY_LION;
>
> How can you be sure it is always Li-Ion? For wearables and mobiles, rathe=
r yes, but
> the driver is also used in other devices. Technically, specs are saying
> it might be used also with Li-Poly applications.

I suppose that there is no way to detect this. Would it be ok if I add
an optional Device Tree property that allows to specify if it's Li-Ion
or Li-Poly? If the property is not supplied, then "unknown" is returned.

Thanks,
Wolfgang

=2D-=20
Website: https://fossencdi.org
Jabber: wolfgang@wiedmeyer.de
OpenPGP: 0F30 D1A0 2F73 F70A 6FEE  048E 5816 A24C 1075 7FC4
Key download: https://wiedmeyer.de/keys/ww.asc

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJX6RsMAAoJEFgWokwQdX/EZyEP/0v1RdtgBGsyXe4TSHVMLoXd
L2KfGErbr0J5KetZX0kwaNAC8a7bltjLA4spu0r7xGgkHsFktImPSbvlnlwqAJ1c
+7zKTprtUIVMOKDfQ8HwTOTeZ1ojVsc9bO7NhiHulfYMIkRdLEzGjLGNDYQ/QOo7
T07B7qGaJiBWLWIoIvCnFxOt9TGtxXJnwwuHFTkLmZiGlnwPqszdt+YyQL6+XK0N
u+U3J9hr7w1l8gVXuUOKhBbG3P+fKfut8Au2Kj8/pT3OCnT6qUSlnOps0TDICEay
A+5oMI4kHnlMXuLH5jmWCpDXMBZMm1tpxXzPMCU+YDH6Z0oxyrFhoDBkXFW5uZGm
QevN/MCqTLHManmoaUTHWpPE40SbFTGUHftEt+jMt9vWWLcn889337IFI2jwuxlp
4vwgW5yZQZvmDbTolgz3C5dV5ADDwA3BHRLqsMa8z847KrH2xoeHA4AjiFNcd0UQ
/xKQExn4HxAq0FxrJyl4mlImgUv/inwXUO+uDOWFr/55eI9Lm5YK4geWIuvrKP3U
9EzIHnYImqk/KrO66R/PjfiJWMhvjB7JEv+VVq8S08MnMnaM1jx5yBJtBmk5vZy6
k2Mv8uMLVl024A3GgYZyu5NQ5lGxEUGqSdMg26HQb172Xxh34ADYo80ej2lAEXT8
PkOteN+nfZDUJ6HPdk8J
=5apq
-----END PGP SIGNATURE-----
--=-=-=--
