From: NeilBrown <neil@brown.name>
Subject: Re: [bug report] twl4030_charger: use runtime_pm to keep usb phy active while charging.
Date: Wed, 12 Oct 2016 15:39:06 +1100
Message-ID: <87twci18r9.fsf@notabene.neil.brown.name>
References: <20161011113025.GA13807@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51379 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750889AbcJLEjP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Oct 2016 00:39:15 -0400
In-Reply-To: <20161011113025.GA13807@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 11 2016, Dan Carpenter wrote:

> Hello NeilBrown,
>
> The patch e57c4a67d712: "twl4030_charger: use runtime_pm to keep usb
> phy active while charging." from Jul 30, 2015, leads to the following
> static checker warning:
>
> 	drivers/power/supply/twl4030_charger.c:521 twl4030_charger_enable_usb()
> 	error: 'bci->transceiver' dereferencing possible ERR_PTR()
>
> drivers/power/supply/twl4030_charger.c
>    468  static int twl4030_charger_enable_usb(struct twl4030_bci *bci, bo=
ol enable)
>    469  {
>    470          int ret;
>    471=20=20
>    472          if (bci->usb_mode =3D=3D CHARGE_OFF)
>    473                  enable =3D false;
>    474          if (enable && !IS_ERR_OR_NULL(bci->transceiver)) {
>                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> We assume that ->transceiver can be NULL.
>
>    475=20=20
>    476                  twl4030_charger_update_current(bci);
>    477=20=20
>    478                  /* Need to keep phy powered */
>    479                  if (!bci->usb_enabled) {
>    480                          pm_runtime_get_sync(bci->transceiver->dev=
);
>    481                          bci->usb_enabled =3D 1;

This is the only time we set usb_enabled to 1, so bci->transceiver but
be non-NULL when usb_enabled.


>    482                  }
>    483=20=20
>    484                  if (bci->usb_mode =3D=3D CHARGE_AUTO)
>    485                          /* forcing the field BCIAUTOUSB (BOOT_BCI=
[1]) to 1 */
>    486                          ret =3D twl4030_clear_set_boot_bci(0, TWL=
4030_BCIAUTOUSB);
>    487=20=20
>    488                  /* forcing USBFASTMCHG(BCIMFSTS4[2]) to 1 */
>    489                  ret =3D twl4030_clear_set(TWL_MODULE_MAIN_CHARGE,=
 0,
>    490                          TWL4030_USBFASTMCHG, TWL4030_BCIMFSTS4);
>    491                  if (bci->usb_mode =3D=3D CHARGE_LINEAR) {
>    492                          twl4030_clear_set_boot_bci(TWL4030_BCIAUT=
OAC|TWL4030_CVENAC, 0);
>    493                          /* Watch dog key: WOVF acknowledge */
>    494                          ret =3D twl_i2c_write_u8(TWL_MODULE_MAIN_=
CHARGE, 0x33,
>    495                                                 TWL4030_BCIWDKEY);
>    496                          /* 0x24 + EKEY6: off mode */
>    497                          ret =3D twl_i2c_write_u8(TWL_MODULE_MAIN_=
CHARGE, 0x2a,
>    498                                                 TWL4030_BCIMDKEY);
>    499                          /* EKEY2: Linear charge: USB path */
>    500                          ret =3D twl_i2c_write_u8(TWL_MODULE_MAIN_=
CHARGE, 0x26,
>    501                                                 TWL4030_BCIMDKEY);
>    502                          /* WDKEY5: stop watchdog count */
>    503                          ret =3D twl_i2c_write_u8(TWL_MODULE_MAIN_=
CHARGE, 0xf3,
>    504                                                 TWL4030_BCIWDKEY);
>    505                          /* enable MFEN3 access */
>    506                          ret =3D twl_i2c_write_u8(TWL_MODULE_MAIN_=
CHARGE, 0x9c,
>    507                                                 TWL4030_BCIMFKEY);
>    508                           /* ICHGEOCEN - end-of-charge monitor (cu=
rrent < 80mA)
>    509                            *                      (charging contin=
ues)
>    510                            * ICHGLOWEN - current level monitor (ch=
arge continues)
>    511                            * don't monitor over-current or heat sa=
ve
>    512                            */
>    513                          ret =3D twl_i2c_write_u8(TWL_MODULE_MAIN_=
CHARGE, 0xf0,
>    514                                                 TWL4030_BCIMFEN3);
>    515                  }
>    516          } else {
>    517                  ret =3D twl4030_clear_set_boot_bci(TWL4030_BCIAUT=
OUSB, 0);
>    518                  ret |=3D twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE,=
 0x2a,
>    519                                          TWL4030_BCIMDKEY);
>    520                  if (bci->usb_enabled) {
>    521                          pm_runtime_mark_last_busy(bci->transceive=
r->dev);
>                                                           ^^^^^^^^^^^^^^^=
^^^^^^
> But we dereference it here.  Possibly checking ->usb_enabled prevents
> a crash?

Yes it does (see above).
Can we get smatch to parse:

#invariant ! (IS_ERR_OR_NULL(bci->transceiver) && bci->usb_enabled)

validate it, and use it to validate other code ? :-)

Thanks,
NeilBrown

>
>    522                          pm_runtime_put_autosuspend(bci->transceiv=
er->dev);
>    523                          bci->usb_enabled =3D 0;
>    524                  }
>    525                  bci->usb_cur =3D 0;
>    526          }
>    527=20=20
>    528          return ret;
>    529  }
>
> regards,
> dan carpenter

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJX/b5qAAoJEDnsnt1WYoG5pwsP/Rtk2MFSMMWy0XPsH8qKz6Fr
QYGz3c8xWS5FMu8zn2APYW6s+hrF2nUCJY2I6+AtA2Y7SLL0hAHO4VcV+NLJjGkR
dPnzrvdqbFxtNgPFO733vTOLUnJO7wO6GEnqsSWLZBFVC6kp31lUHZsnAS+Xtt7A
O8Op8tfMDQE94EdVOlzqsXN3Gi0xesnXsXm1kfXayD5PeZTmYXldsF3abK4SZbW+
TLyJvKvDK6sUANq0OnfqDh3fPckPTZ/0hQ1X06hIz8b96aR+U9xO81f1ASzrodkx
GjXI62RJOHIeriXGysYgh/4w8a+qdWXR7f1NTME3mkHqF7OGTGK52GvPAdjCCRKL
xYH1DXn9ltghxc/hnus/CTWUzul1TcO1Gs/ID77JCXlJmT9isuXCo0cNuoVWwW/E
ZjWiM/baKdVwGS1Mk4w+xDBXJTd3hBrzLe/qHM7HAH8DI4+Dp7z8CcDogC80O/Eh
Fd6UB7nGyt1MikbDsSRDlgmdUzegE8Xx8WH6lDkLi8TBeyBt0QtHTQ5El9omSTua
CFFjtP4dAZpWQpnEpqdmw0zuqA9uQWIUz8CBCCaNn1wEzDg1IDotucGAYDdb937a
/hnpSKL9yeeKA6XzRqXTkvM3FaI5emVpwAD8Y1GpFyxY44DyF5F3zEnXZ6iGJiMt
9/U78zhsXVS2B5vkVQki
=31Hf
-----END PGP SIGNATURE-----
--=-=-=--
