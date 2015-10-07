From: Neil Brown <neilb@suse.de>
Subject: Re: [PATCH 3/4] power:bq27x00: don't fill system log by missing battery
Date: Thu, 08 Oct 2015 09:50:26 +1100
Message-ID: <871td68f9p.fsf@notabene.neil.brown.name>
References: <cover.1444243358.git.hns@goldelico.com> <73cb8d96728805597ecb50e7e7b51bf6272b6d61.1444243358.git.hns@goldelico.com> <201510080023.14795@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54908 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169AbbJGWuf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 7 Oct 2015 18:50:35 -0400
In-Reply-To: <201510080023.14795@pali>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar@gmail.com>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pali Roh=C3=A1r <pali.rohar@gmail.com> writes:

> On Wednesday 07 October 2015 20:42:38 H. Nikolaus Schaller wrote:
>> From: NeilBrown <neilb@suse.de>
>>=20
>> Print message that battery is not calibrated only during debug build
>> but not during normal operation.
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>>  drivers/power/bq27x00_battery.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/power/bq27x00_battery.c
>> b/drivers/power/bq27x00_battery.c index 8287261f..709d1e4 100644
>> --- a/drivers/power/bq27x00_battery.c
>> +++ b/drivers/power/bq27x00_battery.c
>> @@ -491,7 +491,7 @@ static void bq27x00_update(struct
>> bq27x00_device_info *di) if (cache.flags >=3D 0) {
>>  		if (!is_bq27500 && !is_bq27425 && !is_bq27742 && !is_bq27510
>>  				&& (cache.flags & BQ27000_FLAG_CI)) {
>> -			dev_info(di->dev, "battery is not calibrated! ignoring=20
> capacity
>> values\n"); +			dev_dbg(di->dev, "battery is not calibrated!
>> ignoring capacity values\n"); cache.capacity =3D -ENODATA;
>>  			cache.energy =3D -ENODATA;
>>  			cache.time_to_empty =3D -ENODATA;
>
> Hi! I think that better approach would be to use WARN_ONCE or similar=20
> macro. Still use INFO level, just warn about this problem only once...

Why do you need any warning?
The status of whether the battery is calibrated is trivially determined
From=20the sysfs attributes (several of which will return ENODATA).
So if some app is being used to report battery status, then it can
easily report "not calibrated", and if no such app is being used, who
will care to know?

I'm not exactly against a once-only warning (though not with WARN_ONCE,
maybe dev_info_once()) but I don't think that it brings any value at
all.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWFaGyAAoJEDnsnt1WYoG5RzEP/2opcGDT33RhHqOky7m+64jH
4f+Osvwr6BCDR9cpTU0erd5MkRooY0lTSyZ4Or5DlMyQn2v80fSEdiIhgj8gGMTH
lpjd2nvkHQJZ0jV5y/9WdFBJQTru8jX1CpvKrmKpjB9esNMYUSyoIHT9kCAdtyjw
xmveDlm2tMQQnPopYzAJBuC6uIF1iI9tQLtdYQBS4MCuSzbZFHpFOYI2dXyZJLmA
0jqYIyU2WHLxPp/z5qdLyVgzaKxWNlB+VWcoTOrbGGq+jcrI4VmiuyRE3VVe5Fd2
pCOzwNMR6Q5UNu65+KXyvTaP6rTo2Z1n46HuQuc4/SoWy/ojSijguhsDi7fK56qn
TZ+zk1YFp4DcNV0q4tEXIyW+zVmODb7I2ee8OI9kUE+9Pl3IODWhagzlk1mwthVn
H6H27/81Fi3Ixn/qKE9beyvdUFnYAl/SE/fXOzu43ZRqCTLwR3unUzVSi50RyPR+
GAVziwrH7tMGBUhAl8JnxoamBgvYNDlYrpN1srnopQQPayEFd+P0EJERLZRgUV+d
d7wNjoT6CsI6bmoWD4I/yrNcrYCwUb950UxkjwOE+m5sY+uPBijjKcghs0dUBizA
z2ia6WDxNXCVuIxQ/wz4VLYnyuKh6ryDgvDjFe/HTGVp/uaaJd5V65Bp699FhZqC
jp5kTPUfxhEOXqoIeS9o
=pCRV
-----END PGP SIGNATURE-----
--=-=-=--
