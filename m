From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v11 05/10] power: bq27xxx_battery: Make error reporting
 consistent
Date: Thu, 23 Mar 2017 11:11:55 +0100
Message-ID: <20170323101154.eixbsbeyjywwozws@earth>
References: <20170320094335.19224-1-liam@networkimprov.net>
 <20170320094335.19224-6-liam@networkimprov.net>
 <6e387ba3-c5ce-ef88-d5ab-560b190e8352@ti.com>
 <CAKvHMgSvUo+7CdsCRyHFgTEBKbZq7LeQokkGFs1P+6_4oPLqvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uo4kxg5bzdpkz4v7"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751617AbdCWKMB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Mar 2017 06:12:01 -0400
Content-Disposition: inline
In-Reply-To: <CAKvHMgSvUo+7CdsCRyHFgTEBKbZq7LeQokkGFs1P+6_4oPLqvg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>


--uo4kxg5bzdpkz4v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 20, 2017 at 10:59:18AM -0700, Liam Breck wrote:
> On Mon, Mar 20, 2017 at 9:57 AM, Andrew F. Davis <afd@ti.com> wrote:
> > On 03/20/2017 04:43 AM, Liam Breck wrote:
> >> From: Liam Breck <kernel@networkimprov.net>
> >>
> >> Previously errors were reported in a mix of styles via both dev_err() =
& dev_dbg().
> >> Report all errors with dev_err() and include error code in message.
> >> Report register ID separately in dev_dbg() message.
> >>
> >> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> >> ---
> >>  drivers/power/supply/bq27xxx_battery.c | 35 ++++++++++++++++++-------=
---------
> >>  1 file changed, 19 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/su=
pply/bq27xxx_battery.c
> >> index 398801a..2e2a3a8 100644
> >> --- a/drivers/power/supply/bq27xxx_battery.c
> >> +++ b/drivers/power/supply/bq27xxx_battery.c
> >> @@ -794,11 +794,17 @@ MODULE_PARM_DESC(poll_interval,
> >>  static inline int bq27xxx_read(struct bq27xxx_device_info *di, int re=
g_index,
> >>                              bool single)
> >>  {
> >> -     /* Reports EINVAL for invalid/missing registers */
> >> +     int ret;
> >> +
> >>       if (!di || di->regs[reg_index] =3D=3D INVALID_REG_ADDR)
> >>               return -EINVAL;
> >>
> >> -     return di->bus.read(di, di->regs[reg_index], single);
> >> +     ret =3D di->bus.read(di, di->regs[reg_index], single);
> >> +     if (ret < 0)
> >> +             dev_dbg(di->dev, "failed to read register 0x%02x (index =
%d)\n",
> >> +                     di->regs[reg_index], reg_index);
> >> +
> >
> > If we print out the error code here we don't have to do that in each of
> > the below printouts.
>=20
> This is a dev_dbg, the below are dev_err, and I think you want error
> code in dev_err. BTW the above addresses your request to learn which
> register was in play in the event of a DM read/write failure.

Just make it dev_err and also print ret. Then we can remove all
other prints. That will result in some information-loss (name
of the register), but

1. it's not that important anyways. If you read battery voltage file
   in sysfs, then obviously reading voltage fails and so on.
2. the error should be very unlikely on productive systems, since
   it basically mean the i2c/1-wire transaction failed.

-- Sebastian

> > Otherwise looks good:
> > Acked-by: Andrew F. Davis <afd@ti.com>
> >
> >> +     return ret;
> >>  }
> >>
> >>  /*
> >> @@ -815,7 +821,7 @@ static int bq27xxx_battery_read_soc(struct bq27xxx=
_device_info *di)
> >>               soc =3D bq27xxx_read(di, BQ27XXX_REG_SOC, false);
> >>
> >>       if (soc < 0)
> >> -             dev_dbg(di->dev, "error reading State-of-Charge\n");
> >> +             dev_err(di->dev, "error %d reading state-of-charge\n", s=
oc);
> >>
> >>       return soc;
> >>  }
> >> @@ -830,8 +836,7 @@ static int bq27xxx_battery_read_charge(struct bq27=
xxx_device_info *di, u8 reg)
> >>
> >>       charge =3D bq27xxx_read(di, reg, false);
> >>       if (charge < 0) {
> >> -             dev_dbg(di->dev, "error reading charge register %02x: %d=
\n",
> >> -                     reg, charge);
> >> +             dev_err(di->dev, "error %d reading charge\n", charge);
> >>               return charge;
> >>       }
> >>
> >> @@ -883,7 +888,7 @@ static int bq27xxx_battery_read_dcap(struct bq27xx=
x_device_info *di)
> >>               dcap =3D bq27xxx_read(di, BQ27XXX_REG_DCAP, false);
> >>
> >>       if (dcap < 0) {
> >> -             dev_dbg(di->dev, "error reading initial last measured di=
scharge\n");
> >> +             dev_err(di->dev, "error %d reading design capacity\n", d=
cap);
> >>               return dcap;
> >>       }
> >>
> >> @@ -905,7 +910,7 @@ static int bq27xxx_battery_read_energy(struct bq27=
xxx_device_info *di)
> >>
> >>       ae =3D bq27xxx_read(di, BQ27XXX_REG_AE, false);
> >>       if (ae < 0) {
> >> -             dev_dbg(di->dev, "error reading available energy\n");
> >> +             dev_err(di->dev, "error %d reading available energy\n", =
ae);
> >>               return ae;
> >>       }
> >>
> >> @@ -927,7 +932,7 @@ static int bq27xxx_battery_read_temperature(struct=
 bq27xxx_device_info *di)
> >>
> >>       temp =3D bq27xxx_read(di, BQ27XXX_REG_TEMP, false);
> >>       if (temp < 0) {
> >> -             dev_err(di->dev, "error reading temperature\n");
> >> +             dev_err(di->dev, "error %d reading temperature\n", temp);
> >>               return temp;
> >>       }
> >>
> >> @@ -947,7 +952,7 @@ static int bq27xxx_battery_read_cyct(struct bq27xx=
x_device_info *di)
> >>
> >>       cyct =3D bq27xxx_read(di, BQ27XXX_REG_CYCT, false);
> >>       if (cyct < 0)
> >> -             dev_err(di->dev, "error reading cycle count total\n");
> >> +             dev_err(di->dev, "error %d reading cycle count total\n",=
 cyct);
> >>
> >>       return cyct;
> >>  }
> >> @@ -962,8 +967,7 @@ static int bq27xxx_battery_read_time(struct bq27xx=
x_device_info *di, u8 reg)
> >>
> >>       tval =3D bq27xxx_read(di, reg, false);
> >>       if (tval < 0) {
> >> -             dev_dbg(di->dev, "error reading time register %02x: %d\n=
",
> >> -                     reg, tval);
> >> +             dev_err(di->dev, "error %d reading time\n", tval);
> >>               return tval;
> >>       }
> >>
> >> @@ -983,8 +987,7 @@ static int bq27xxx_battery_read_pwr_avg(struct bq2=
7xxx_device_info *di)
> >>
> >>       tval =3D bq27xxx_read(di, BQ27XXX_REG_AP, false);
> >>       if (tval < 0) {
> >> -             dev_err(di->dev, "error reading average power register  =
%02x: %d\n",
> >> -                     BQ27XXX_REG_AP, tval);
> >> +             dev_err(di->dev, "error %d reading average power\n", tva=
l);
> >>               return tval;
> >>       }
> >>
> >> @@ -1054,7 +1057,7 @@ static int bq27xxx_battery_read_health(struct bq=
27xxx_device_info *di)
> >>
> >>       flags =3D bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
> >>       if (flags < 0) {
> >> -             dev_err(di->dev, "error reading flag register:%d\n", fla=
gs);
> >> +             dev_err(di->dev, "error %d reading flags\n", flags);
> >>               return flags;
> >>       }
> >>
> >> @@ -1147,7 +1150,7 @@ static int bq27xxx_battery_current(struct bq27xx=
x_device_info *di,
> >>
> >>       curr =3D bq27xxx_read(di, BQ27XXX_REG_AI, false);
> >>       if (curr < 0) {
> >> -             dev_err(di->dev, "error reading current\n");
> >> +             dev_err(di->dev, "error %d reading current\n", curr);
> >>               return curr;
> >>       }
> >>
> >> @@ -1236,7 +1239,7 @@ static int bq27xxx_battery_voltage(struct bq27xx=
x_device_info *di,
> >>
> >>       volt =3D bq27xxx_read(di, BQ27XXX_REG_VOLT, false);
> >>       if (volt < 0) {
> >> -             dev_err(di->dev, "error reading voltage\n");
> >> +             dev_err(di->dev, "error %d reading voltage\n", volt);
> >>               return volt;
> >>       }
> >>
> >>

--uo4kxg5bzdpkz4v7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljTn2gACgkQ2O7X88g7
+prgMw/+J8fXDnn2tNRXkuF/fEFq6a0WQ9cWZehpxcCfE233eo+KGB/yf22uHF93
qLcuwUDOq9c97Us0baRxsn7niEBh0eqERLjgM6SpcF0AYtZ0xDvyOWhPgPmtW+Ti
CSG8rI+s9BcKobEUXp/d9rs2EAOTCbs7aA+AqTW4LIwnjV6fOcKmkoVB9O4zGFOa
qX1jBmERQGGva5uh55qQzNH2nln5pETVurOyHadMrIbhEwutatN7gePUc/UCO+0D
oqDcB1S8l4gn6E2Lg9vMaEDgHnrf5qcoOZoHfpmj5O6/65b4S/zNljivOF/kHhuH
EkS7pq6y/64e5ZZBsSTCEjV9hu5LqYc2jlXvkLwGJVT6KsyKqXxNZ6RfGZDSlYOL
BgKASypnF2JNwL6mSosMAfrAvvIKrA6eF0JeoltlGsLI4CAh+EDuzFWLmgywNDtv
DiOXQIPpG7mH3ZFaA8/kWpwKP1LRELeJVKKnV+BvkwxIINnTdiYsTpn8klfMGwdQ
mithEhpRe7fz4pV4/Td8E1zP3nEd7CbNLqYCj9S4IG1dIS86OSkTPIvjptfP3WcX
UdPz4ebjfhrSVomuOOvqWVtdhYzCayTATD5bOuf9bfL0uKdhXV7voKxlkvr+V1ZL
W5TnzAa3a4wtCet0682PLsSycgmQe12Cpa/8xrwdx8qHQlILMBk=
=1YgM
-----END PGP SIGNATURE-----

--uo4kxg5bzdpkz4v7--
