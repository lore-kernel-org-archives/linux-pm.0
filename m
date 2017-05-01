From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 1/5] power: supply: bq27xxx: Pass of_node along to allow
 device-tree supply
Date: Mon, 01 May 2017 20:40:00 +0200
Message-ID: <1493664000.4951.5.camel@paulk.fr>
References: <20170430203801.32357-1-contact@paulk.fr>
         <CAKvHMgSijN8vQUePoTKRC5nqaW-Shh4_9ZKiKq0Uae3ZLkiDSA@mail.gmail.com>
         <1493635591.6493.10.camel@paulk.fr>
         <CAKvHMgQKBSbzbS3sG3A+Yi3X5J=iMxLYDvK1YJjCPXmq_GimZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-bUl0ijswPrll+msSJAFm"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gagarine.paulk.fr ([109.190.93.129]:54243 "EHLO
        gagarine.paulk.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751123AbdEASku (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 14:40:50 -0400
In-Reply-To: <CAKvHMgQKBSbzbS3sG3A+Yi3X5J=iMxLYDvK1YJjCPXmq_GimZQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>


--=-bUl0ijswPrll+msSJAFm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le lundi 01 mai 2017 =C3=A0 11:30 -0700, Liam Breck a =C3=A9crit=C2=A0:
> On Mon, May 1, 2017 at 3:46 AM, Paul Kocialkowski <contact@paulk.fr> wrot=
e:
> > Le dimanche 30 avril 2017 =C3=A0 15:03 -0700, Liam Breck a =C3=A9crit :
> > > [dropped some CCs]
> > >=20
> > >=20
> > > On Sun, Apr 30, 2017 at 1:37 PM, Paul Kocialkowski <contact@paulk.fr>
> > > wrote:
> > > > This passes the of_node from the bq27xxx i2c battery driver to the
> > > > common code, so that it can be registered and provide external supp=
lies
> > > > linked with device-tree.
> > > >=20
> > > > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > > > ---
> > > > =C2=A0drivers/power/supply/bq27xxx_battery.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0| 5 ++++-
> > > > =C2=A0drivers/power/supply/bq27xxx_battery_i2c.c | 1 +
> > > > =C2=A0include/linux/power/bq27xxx_battery.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0| 1 +
> > > > =C2=A03 files changed, 6 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/power/supply/bq27xxx_battery.c
> > > > b/drivers/power/supply/bq27xxx_battery.c
> > > > index 398801a21b86..6ef95442a918 100644
> > > > --- a/drivers/power/supply/bq27xxx_battery.c
> > > > +++ b/drivers/power/supply/bq27xxx_battery.c
> > > > @@ -1351,7 +1351,10 @@ static void bq27xxx_external_power_changed(s=
truct
> > > > power_supply *psy)
> > > > =C2=A0int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
> > > > =C2=A0{
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct power_supply=
_desc *psy_desc;
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct power_supply_conf=
ig psy_cfg =3D { .drv_data =3D di, };
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct power_supply_conf=
ig psy_cfg =3D {};
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0psy_cfg.drv_data =3D di;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0psy_cfg.of_node =3D di->=
of_node;
> > >=20
> > > I don't think you need di->of_node, just the following -- we do this
> > > to obtain data from devicetree via power_supply_get_battery_info()
> > > https://patchwork.kernel.org/patch/9692335/
> > >=20
> > > struct power_supply_config psy_cfg =3D {
> > > =C2=A0 .drv_data =3D di,
> > > =C2=A0 .of_node =3D di->dev->of_node,
> > > };
> >=20
> > That's a good point, thanks! Should I prepare v2 with this or rebase on=
 top
> > of
> > the series you mentioned previously?
>=20
> Looks like Sebastian will queue my series this week (actually he just
> did, but there's a later rev coming, so wait for that).

Good to know!

> Also it would be nice to have docs in the DT binding on linking an
> external power supply to fuel gauge. If you write up an example, I can
> incorporate it into the docs patch in my series. Or you can file it as
> a separate patch...

Hooking up external suppliers is handled by the supply core code and is alr=
eady
described at: Documentation/devicetree/bindings/power/supply/power_supply.t=
xt

I don't think there's a need to add this in every supply's dt documentation=
.

> > > There is some (gcc?) bug on armv7 or omap which causes separate
> > > assignments to corrupt the stack.
> >=20
> > That's weird, but definitely good to know.
> >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0INIT_DELAYED_WORK(&=
di->work, bq27xxx_battery_poll);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_init(&di->loc=
k);
> > > > diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c
> > > > b/drivers/power/supply/bq27xxx_battery_i2c.c
> > > > index c68fbc3fe50a..38a0422a4192 100644
> > > > --- a/drivers/power/supply/bq27xxx_battery_i2c.c
> > > > +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
> > > > @@ -96,6 +96,7 @@ static int bq27xxx_battery_i2c_probe(struct i2c_c=
lient
> > > > *client,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0di->chip =3D id->dr=
iver_data;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0di->name =3D name;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0di->bus.read =3D bq=
27xxx_battery_i2c_read;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0di->of_node =3D client->=
dev.of_node;
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D bq27xxx_bat=
tery_setup(di);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> > > > diff --git a/include/linux/power/bq27xxx_battery.h
> > > > b/include/linux/power/bq27xxx_battery.h
> > > > index b312bcef53da..94637b77ecbf 100644
> > > > --- a/include/linux/power/bq27xxx_battery.h
> > > > +++ b/include/linux/power/bq27xxx_battery.h
> > > > @@ -63,6 +63,7 @@ struct bq27xxx_device_info {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const char *name;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct bq27xxx_acce=
ss_methods bus;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct bq27xxx_reg_=
cache cache;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct device_node *of_n=
ode;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int charge_design_f=
ull;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long last_=
update;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct delayed_work=
 work;
> > > > --
> > > > 2.12.2
> > > >=20
> >=20
> > --
> > Paul Kocialkowski, developer of free digital technology and hardware su=
pport
> >=20
> > Website: https://www.paulk.fr/
> > Coding blog: https://code.paulk.fr/
> > Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=20
Paul Kocialkowski, developer of free digital technology and hardware suppor=
t

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-bUl0ijswPrll+msSJAFm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlkHgQAACgkQhP3B6o/u
lQy0ow/+PxYhlISlabyz231JoiLnry983BOdA2S7Eyj/5DCPEou1iObK+03q3z5r
+JHFqtSmC7GSP+3beYF9ucDOIbRhdmR4j+auPE3C3sWFPlvvvV6Ia0KgyPYPEdQk
HBMIIbfdAq+lALgtSLtG2dFCtRfChfLNwpN4fK9/KavAIyBTOMTqQyWp8UhY5C6k
8Fnp1NhYHMnKPGIXJ14Fe6lBX3X1hbUTG/b33XSXjkmgujA9qJwEAcohl5wSc2av
3z13doA7ezLayuSmaoYpGcQB9H8KK1yguViYvaKZ//Or0JXGEyO2MurEb1aEvp4x
IWbIP35D8x4rlyQPpn0iqquhlLzhexd6UMBz2fdadVsRsB2rUPXui2RNjSIeSRGw
lnzNy2FKlvZcYbKqHwUtXOVqVbP9McnEY79bcAOTRw3w9Ufnyh01Gmjid2UaG1Jb
ceQHZrvbepCRFcZXqSViMwaxL2Kh61fsGqDM/AC62o/a2vTnMG0zHl5cU83LhHXn
Oov7OSV1VIhXnc38Y3fo6Sw7DEQvI8+nztUEF1w0FYFwK4txh2htHsRRIaDTP9aJ
qq179WdDbtfm5cSJMTxSgkuy3S8IEJ/Et/iWPWeq9qTpKgJQ2uaIW2vRtQzuz1Pr
oMUki600YY3YDTQRPVvHtHXZVu8jWEX+FnEeCet6RrcGaEq1YQg=
=ox3P
-----END PGP SIGNATURE-----

--=-bUl0ijswPrll+msSJAFm--
