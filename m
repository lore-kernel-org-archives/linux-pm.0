From: Alexander Dahl <post@lespocky.de>
Subject: no hwmon entries in sysfs for thermal on raspberry pi 1b
Date: Fri, 8 Dec 2017 20:53:10 +0100
Message-ID: <20171208195308.b7mq43ejegmzjlbi@falbala.home.lespocky.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4shk57tj2l6imnyj"
Return-path: <linux-hwmon-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-hwmon-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--4shk57tj2l6imnyj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hei hei,

I have v4.15-rc2 vanilla running on the original Raspberry Pi 1B aka
bcm2835 (not rev2, not the 1B+ or plus), compiled with ptxdist /
DistroKit, using bcm2835-rpi-b.dts from arch/arm/boot/dts as device
tree file. I try to get temperature values from the SoC with
lm-sensors (for using it in some other project). After reading an
issue report on the lm-sensors github project [1] I checked my kernel
config. The following is set:

    CONFIG_HWMON=3Dy
    CONFIG_THERMAL_HWMON=3Dy
    CONFIG_THERMAL=3Dy
    CONFIG_THERMAL_OF=3Dy
    CONFIG_BCM2835_THERMAL=3Dy

There's one thermal zone in sysfs and I get some temperature which I
suppose is the temp of the SoC in m=B0C:

    root@DistroKit:~ cat /sys/class/thermal/thermal_zone0/temp=20
    42236

However, there's nothing below /sys/class/hwmon and I'm wondering why.
There's a thermal zone named 'cpu-thermal' defined and active in DT.

I tried to read some driver code and as far as I understood
thermal_add_hwmon_sysfs() must be called somewhere to get entries for
hwmon in sysfs, and this is done in thermal_zone_device_register(), so
probably a thermal zone must be present somehow, but it seems to be,
at least I can read temp values from it.

What piece am I missing? Is it some kind of configuration I did wrong?

Greets
Alex

[1] https://github.com/groeck/lm-sensors/issues/30

--=20
=BBWith the first link, the chain is forged. The first speech censured,=20
the first thought forbidden, the first freedom denied, chains us all=20
irrevocably.=AB (Jean-Luc Picard, quoting Judge Aaron Satie)
*** GnuPG-FP: C28E E6B9 0263 95CF 8FAF  08FA 34AD CD00 7221 5CC6 ***

--4shk57tj2l6imnyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEwo7muQJjlc+Prwj6NK3NAHIhXMYFAloq7Z0ACgkQNK3NAHIh
XMYsvxAAtp/y7loGAtTSGS5bNR7IhTzx7reoufTsXITYh4Eu4faNKfVzoi3fnhNw
ydkBVxwf8WZ+1FeeqsUBG2LJX6dakXzutW3kG0jdXkD/pc0c5PrW4mpgIozWUgmD
fXWhSsQ3aVQ+3Q7Dcna/MDAUfVeYC/ad+t40dTasNIJo3ZtlBv1t118nzMeiDq6V
xv/p5eMZN0nvlRGqCbXi3DZ5TP1wDHSGAVhKDt5LnGixAHJg8SxyKvr4Q5qGo7uc
mJxnuvMgHaNFLFViqBtvuqySve1Mo++pqdfzNRhTsUIM/XFSewiwduNTIoDPzr9r
X6W+cNTkRbmHK7e3yyGFD4yDKev1XJeGvr7A9tkRCof4K4eURM44E8y5gbbsb71A
7YBoy0D0T95H++C5hxey1zZaLvpp/cIrcQer3dCHh0lamsYbE0U7jYS2lMb4D9AE
bTz2RgwZP2QiDhgjrMgG3YSXvrYIOc16VH+Tr7l7IFhknj8peXPraawuGcmX4RBR
hRnGSqlim7e+WHDuEACirtw9eVJJvfZmHzsT5pHy0iizb0tEPW0c4wZIJSE7fkJ/
nYSpMnf6wZJrXRWHV3pj7R5wXOE65/PYOz76vLdo+7F7Q7rUlMerc4yqzZ8Lc9Ab
5NaxctkFkcu4E+llDfdSUKuifXSdnZYAxcNeSsvhfK9hDCbnfag=
=TfKg
-----END PGP SIGNATURE-----

--4shk57tj2l6imnyj--
