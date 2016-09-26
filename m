From: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
Subject: Re: [PATCH 1/2] power: supply: max17042_battery: use VF SOC register for capacity property
Date: Mon, 26 Sep 2016 15:13:23 +0200
Message-ID: <87d1jqx0r0.fsf@machinist.wiedmeyer.de>
References: <20160926111615.GB8140@kozik-lap>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20160926111615.GB8140@kozik-lap>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Krzysztof Kozlowski writes:

> On Sun, Sep 25, 2016 at 11:10:10PM +0200, Wolfgang Wiedmeyer wrote:
>> The capacity property uses the RepSOC register to report the current sta=
te
>> of charge. This register did not provide a reliable SOC value during my
>> testing with the max17047 variant on a Galaxy S3 (Trats2/GT-I9300). The
>> reported value did not change or even stayed zero in some cases.
>> However, the VF SOC register provided an accurate SOC value at all times.
>> It uses the voltage fuel gauge to determine the SOC.
>>=20
>> Signed-off-by: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
>> ---
>>  drivers/power/max17042_battery.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_b=
attery.c
>> index da7a75f..20cb1fd 100644
>> --- a/drivers/power/max17042_battery.c
>> +++ b/drivers/power/max17042_battery.c
>> @@ -246,7 +246,7 @@ static int max17042_get_property(struct power_supply=
 *psy,
>>  		val->intval =3D data * 625 / 8;
>>  		break;
>>  	case POWER_SUPPLY_PROP_CAPACITY:
>> -		ret =3D regmap_read(map, MAX17042_RepSOC, &data);
>> +		ret =3D regmap_read(map, MAX17042_VFSOC, &data);
>>  		if (ret < 0)
>>  			return ret;
>
> The RepSOC is for ModelGauge m3 which requires current sense resistor. I
> don't remember whether the resistor is present on Trats2. If not, then
> m1 is used. However in both cases (m1 and m3) the battery
> characteristics (cell information) should be loaded which in case of DT
> driver is not supported.
>
> Overall, I am not sure whether your change is correct. It might fix this
> particular scenario because:
> 1. We are not providing the cell information,
> 2. We mre not providing the SNS resistor value so we are in m1 mode (if
> there is no SNS resistor).  but it might break other applications where
> SNS is present and cell configuration is provided. Unless you tested it
> in such?

I'm not able to test other applications than the Galaxy S3.

> Probably this should be based on Device Tree property describing what is
> configured (e.g. missing model data). Maybe existing maxim,rsns-microohm
> could be used - in case of lack of it, fall back to reading VFSOC?

Ok, I'll include a check if maxim,rsns-microohm exists and do the
fallback to VFSOC if it's not there.

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

iQIcBAEBCgAGBQJX6R7zAAoJEFgWokwQdX/EY6UQAKDgZLlwRvs7dY8WDWGRkrsV
K8mSWNWhoquGf71uwOmlSV21sqKLeQKTnqsdZohaR0qThHCYkdVqNIT/vgrYL5RC
rrT3qvKRV4wNKaijWEz2TS2tQ7OftFbzdTKPK+B2mcM1jTFz9sk2VmHTFb9nh98j
6IGkNW9pYG7bwX1aI/dlq7GdhAdvA2/6/YxWtGmM1oVgy2ko4RbUqRnLNmSGfoBB
TFK5nb6Jo/zM0P6nm27KYR71/h1TehHE3gBAizbZByjKYXEoF89hf1PLVyQsUyZX
Ow7V/SjGfFb9yUWhTKtgBd0mO/oFz3sp1amspcYNgV5rdC4zZ/LsLQI7vcUWtYK/
PwrWwTedFU/DJ2fdnOJp67lisqIat0dhlP4jPnwZEzY3vtzUzLrgyqdmFpLOQfvN
M6G6/HuN9bbwPePrrg+pO8Afk9v/yrEXvDKdrE6d36jnFmGa1wih0W0mMIWqyyJ9
QQ6IHOPC2OMjCAwTt60z7XMAKhtuwSoC4dORL9UZXBTPXcy6PRL6oz23F2mh3rO2
PpFXEygtv2wqYOn+38yh/nACrCtE/vsvGbgR7iwF7MoHWY1SceihEsFMRhUnM4Rz
9uLq6qkbO8nub8aieyyG4pKxcg3MAi9tcSSa4hxrHyOMpyUls24LJjf49m8woy+D
VuTdV+eaNW89TnhmgVFH
=vX2D
-----END PGP SIGNATURE-----
--=-=-=--
