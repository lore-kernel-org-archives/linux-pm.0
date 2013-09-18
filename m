From: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2 06/16] hwmon: tmp102: expose to thermal fw via DT nodes
Date: Wed, 18 Sep 2013 10:17:51 -0400
Message-ID: <5239B60F.6060805@ti.com>
References: <523643D4.30208@roeck-us.net> <1379457245-17810-1-git-send-email-eduardo.valentin@ti.com> <20130918110649.GA9050@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eQqh0HifVpMjiCS7wIV3Hh6eDBxE1j7WA"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130918110649.GA9050-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--eQqh0HifVpMjiCS7wIV3Hh6eDBxE1j7WA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 18-09-2013 07:06, Guenter Roeck wrote:
> On Tue, Sep 17, 2013 at 06:34:05PM -0400, Eduardo Valentin wrote:
>> This patch adds to tmp102 temperature sensor the possibility
>> to expose itself as thermal zone device, registered on the
>> thermal framework.
>>
>> The thermal zone is built only if a device tree node
>> describing a thermal zone for this sensor is present
>> inside the tmp102 DT node. Otherwise, the driver behavior
>> will be the same.
>>
>> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
>> Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
>> Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
>> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Signed-off-by: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
>> ---
>>  drivers/hwmon/tmp102.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> ---
>>
>> Guenter,
>>
>> Here is a version without the warnings, as requested.
>>
>> Eduardo
>>
>> diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
>> index d7b47ab..dc96598 100644
>> --- a/drivers/hwmon/tmp102.c
>> +++ b/drivers/hwmon/tmp102.c
>> @@ -27,6 +27,8 @@
>>  #include <linux/mutex.h>
>>  #include <linux/device.h>
>>  #include <linux/jiffies.h>
>> +#include <linux/thermal.h>
>> +#include <linux/of.h>
>> =20
>>  #define	DRIVER_NAME "tmp102"
>> =20
>> @@ -50,6 +52,7 @@
>> =20
>>  struct tmp102 {
>>  	struct device *hwmon_dev;
>> +	struct thermal_zone_device *tz;
>>  	struct mutex lock;
>>  	u16 config_orig;
>>  	unsigned long last_update;
>> @@ -93,6 +96,15 @@ static struct tmp102 *tmp102_update_device(struct i=
2c_client *client)
>>  	return tmp102;
>>  }
>> =20
>> +static int tmp102_read_temp(void *dev, long *temp)
>> +{
>> +	struct tmp102 *tmp102 =3D tmp102_update_device(to_i2c_client(dev));
>> +
>> +	*temp =3D tmp102->temp[0];
>> +
>> +	return 0;
>> +}
>> +
>>  static ssize_t tmp102_show_temp(struct device *dev,
>>  				struct device_attribute *attr,
>>  				char *buf)
>> @@ -204,6 +216,12 @@ static int tmp102_probe(struct i2c_client *client=
,
>>  		goto fail_remove_sysfs;
>>  	}
>> =20
>> +	tmp102->tz =3D thermal_zone_of_sensor_register(&client->dev, 0,
>> +						     &client->dev,
>> +						     tmp102_read_temp, NULL);
>> +	if (IS_ERR(tmp102->tz))
>> +		tmp102->tz =3D NULL;
>> +
>>  	dev_info(&client->dev, "initialized\n");
>> =20
>>  	return 0;
>> @@ -220,6 +238,8 @@ static int tmp102_remove(struct i2c_client *client=
)
>>  {
>>  	struct tmp102 *tmp102 =3D i2c_get_clientdata(client);
>> =20
>> +	/* thermal zone life cycle is not our responsibility */
>=20
> This comment does not provide any value. Please drop it from both drive=
rs.
> Sorry I missed that earlier.

Yeah, I even forgot to drop it myself. No problem, I am resending both
without it.

>=20
>> +	thermal_zone_of_sensor_unregister(&client->dev, tmp102->tz);
>>  	hwmon_device_unregister(tmp102->hwmon_dev);
>>  	sysfs_remove_group(&client->dev.kobj, &tmp102_attr_group);
>> =20
>> --=20
>> 1.8.2.1.342.gfa7285d
>>
>>
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--eQqh0HifVpMjiCS7wIV3Hh6eDBxE1j7WA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlI5thUACgkQCXcVR3XQvP0lngEAhQICzdeYzsSzgPXFWiX29Mgz
PvrAgBBLlAE5f1dNcG4BAPh1HwdOljoSiVPK+iWS6ZgYzojrhdesgU0q398L3LRg
=Vzxg
-----END PGP SIGNATURE-----

--eQqh0HifVpMjiCS7wIV3Hh6eDBxE1j7WA--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
