From: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
Subject: Re: [PATCH 2/3] regulator: max77693: Also manipulate the fast charge current
Date: Tue, 27 Sep 2016 15:50:42 +0200
Message-ID: <878tudwixy.fsf@machinist.wiedmeyer.de>
References: <20160927080357.GA4394@kozik-lap>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20160927080357.GA4394@kozik-lap>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, cw00.choi@samsung.com, b.zolnierkie@samsung.com, broonie@kernel.org, lgirdwood@gmail.com, lee.jones@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Krzysztof Kozlowski writes:

> On Tue, Sep 27, 2016 at 01:31:09AM +0200, Wolfgang Wiedmeyer wrote:
>> For MAX77693, the fast charge current also needs to be manipulated for
>> proper charging. The fast charge current is only set in the case of
>> the MAX77693 type, as the MAX77843 properly manipulates the fast
>> charge current.
>
> Are you sure it has to be manipulated? Some time I didn't dig into this.
> Now I looked at the datasheet and it says that usually there is no need
> for changing the charge current during the operation. Maxim recommends
> to setting it to a maximum safe value for the battery. The device will
> manage charge current on its own.
>
> However I agree that the charge current should be set... maybe once, to
> a maximum value appropriate for battery. Probably this should be done
> by max77693_charger in max77693_dt_init().

When charging is disabled (e.g. by removing the USB cable) the charge
current is not reset to zero. So if I expose the current by the
CURRENT_NOW property, it incorrectly reports the current that was set
when charging was enabled, although there is no charging going on
anymore. So I felt the need to update the charge current every time the
charger gets enabled or disabled.
Initially, the charge current is set to zero, so I think it needs to be
set at least at the beginning to enable charging.

Thanks,
Wolfgang

> Best regards,
> Krzysztof
>
>
>> The fast charge current is set to the next possible value below the
>> maximum input current.
>
>
>>=20
>> Signed-off-by: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
>> ---
>>  drivers/regulator/max77693-regulator.c | 45 +++++++++++++++++++++++++++=
++++---
>>  1 file changed, 42 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/drivers/regulator/max77693-regulator.c b/drivers/regulator/=
max77693-regulator.c
>> index cfbb951..e2f7584 100644
>> --- a/drivers/regulator/max77693-regulator.c
>> +++ b/drivers/regulator/max77693-regulator.c
>> @@ -54,14 +54,19 @@ struct chg_reg_data {
>>  	unsigned int linear_mask;
>>  	unsigned int uA_step;
>>  	unsigned int min_sel;
>> +
>> +	bool set_fast;
>> +	unsigned int fast_reg;
>> +	unsigned int fast_mask;
>>  };
>>=20=20
>>  /*
>>   * MAX77693 CHARGER regulator - Min : 20mA, Max : 2580mA, step : 20mA
>>   * 0x00, 0x01, 0x2, 0x03	=3D 60 mA
>>   * 0x04 ~ 0x7E			=3D (60 + (X - 3) * 20) mA
>> - * Actually for MAX77693 the driver manipulates the maximum input curre=
nt,
>> - * not the fast charge current (output). This should be fixed.
>> + * Actually for MAX77693 the driver manipulates the maximum input curre=
nt
>> + * and the fast charge current (output) because the fast charge current
>> + * is not set.
>>   *
>>   * On MAX77843 the calculation formula is the same (except values).
>>   * Fortunately it properly manipulates the fast charge current.
>> @@ -100,6 +105,8 @@ static int max77693_chg_set_current_limit(struct reg=
ulator_dev *rdev,
>>  	const struct chg_reg_data *reg_data =3D rdev_get_drvdata(rdev);
>>  	unsigned int chg_min_uA =3D rdev->constraints->min_uA;
>>  	int sel =3D 0;
>> +	unsigned int data;
>> +	int ret;
>>=20=20
>>  	while (chg_min_uA + reg_data->uA_step * sel < min_uA)
>>  		sel++;
>> @@ -110,7 +117,35 @@ static int max77693_chg_set_current_limit(struct re=
gulator_dev *rdev,
>>  	/* the first four codes for charger current are all 60mA */
>>  	sel +=3D reg_data->min_sel;
>>=20=20
>> -	return regmap_write(rdev->regmap, reg_data->linear_reg, sel);
>> +	ret =3D regmap_write(rdev->regmap, reg_data->linear_reg, sel);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (reg_data->set_fast) {
>> +		/* disable fast charge if minimum value */
>> +		if (sel =3D=3D reg_data->min_sel)
>> +			data =3D 0;
>> +		else {
>> +			/*
>> +			 * set the fast charge current to the closest value
>> +			 * below the input current
>> +			 */
>> +			ret =3D regmap_read(rdev->regmap, reg_data->fast_reg,
>> +					  &data);
>> +			if (ret < 0)
>> +				return ret;
>> +
>> +			sel *=3D reg_data->uA_step / 1000; /* convert to mA */
>> +			data &=3D ~reg_data->fast_mask;
>> +			data |=3D sel * 10 / 333; /* 0.1A/3 steps */
>> +		}
>> +
>> +		ret =3D regmap_write(rdev->regmap, reg_data->fast_reg, data);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>>  }
>>  /* end of CHARGER regulator ops */
>>=20=20
>> @@ -197,6 +232,9 @@ static const struct chg_reg_data max77693_chg_reg_da=
ta =3D {
>>  	.linear_mask	=3D CHG_CNFG_09_CHGIN_ILIM_MASK,
>>  	.uA_step	=3D 20000,
>>  	.min_sel	=3D 3,
>> +	.set_fast	=3D true,
>> +	.fast_reg	=3D MAX77693_CHG_REG_CHG_CNFG_02,
>> +	.fast_mask	=3D CHG_CNFG_02_CC_MASK,
>>  };
>>=20=20
>>  #define	max77843_regulator_desc_esafeout(num)	{			\
>> @@ -237,6 +275,7 @@ static const struct chg_reg_data max77843_chg_reg_da=
ta =3D {
>>  	.linear_mask	=3D MAX77843_CHG_FAST_CHG_CURRENT_MASK,
>>  	.uA_step	=3D MAX77843_CHG_FAST_CHG_CURRENT_STEP,
>>  	.min_sel	=3D 2,
>> +	.set_fast	=3D false,
>>  };
>>=20=20
>>  static int max77693_pmic_probe(struct platform_device *pdev)
>> --=20
>> 2.8.0.rc3
>>=20


=2D-=20
Website: https://fossencdi.org
OpenPGP: 0F30 D1A0 2F73 F70A 6FEE  048E 5816 A24C 1075 7FC4
Key download: https://wiedmeyer.de/keys/ww.asc

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJX6nkyAAoJEFgWokwQdX/E+3EP/Az8xN0utUa2xhRWwkWnkxoS
AxqgFJuCR88p6BigI4TP8OUv9Is1emQdMdIN/sOmbcPQxOXzCco1OzxNgBZYG3yT
g6jDmFf1aNSghx7wtDTXxq4LM7oazWgUQsHlTxGDFKawPXl7sqPDNwnE7YYnRXgv
xOTqY1RUpnBMLWJ1z2PRBTFOIJ7cV9Fl/3Sy8ph8BvFNZJnCmJeQ9KGGOFS7Fxdr
tBjQTagbqlbHacPp/a6Hyj8DY9Li2PJgRrVioYiNs7tyj4qrxzf8LVes87X1MJvj
fRNHEWM9aNGbquAso1pWgIRSTKmxWzKUWz/N9IZYckL0+J8CSld8RXC9zHoMtB8P
RszLIDpFbB/LwThPuQsoEmj0XVcio66KVa7zuEUi5lAXVmhMbgH9K4D6WkWFyR8F
6h6MNJDm52TbTSCed4skifaUY0D53JmVmZYtXlQIsLR/CsZpSlOK4TGITUuWwxRi
Kjek0TzmiTnjEvPQ24b7ezfSvac0imZJSMR5HPEJDsnwQbyki3lP8C4MB2MiQrLO
DrrcWG4Wo60GMfrdkDJj+u0CzbFaSL3bILFUdut/eknmC08Xe/Mt9yiuIqMFHSJM
NmgAJyiLFtdRgIIO6rQnRje9qysMl/zrUsCWE5M88nOY8s4F2rRvhRRt+ncafhZd
DhjCnYy6xD4NlAf0PpqW
=vNGN
-----END PGP SIGNATURE-----
--=-=-=--
