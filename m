From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v3 3/3] power: wm831x_power: Support USB charger current
 limit management
Date: Wed, 26 Jul 2017 14:08:23 +0200
Message-ID: <20170726120822.xbj3bzsoxmfgzkn4@earth>
References: <cover.1500968744.git.baolin.wang@linaro.org>
 <c6dbaa6b4417eb9213032404b90330c924613ed0.1500968745.git.baolin.wang@linaro.org>
 <20170725095931.qmxtn766wam7vufe@earth>
 <CAMz4ku+ya_wMWoH7-rr7f=XpmRVkWBR0bh_3oq7HLNc9B04eQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5qdzr4umjjjiacgb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMz4ku+ya_wMWoH7-rr7f=XpmRVkWBR0bh_3oq7HLNc9B04eQw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jun Li <jun.li@nxp.com>, Peter Chen <peter.chen@freescale.com>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, NeilBrown <neilb@suse.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--5qdzr4umjjjiacgb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 26, 2017 at 11:05:25AM +0800, Baolin Wang wrote:
> On 25 July 2017 at 17:59, Sebastian Reichel
> <sebastian.reichel@collabora.co.uk> wrote:
> > On Tue, Jul 25, 2017 at 04:00:01PM +0800, Baolin Wang wrote:
> >> Integrate with the newly added USB charger interface to limit the curr=
ent
> >> we draw from the USB input based on the input device configuration
> >> identified by the USB stack, allowing us to charge more quickly from h=
igh
> >> current inputs without drawing more current than specified from others.
> >>
> >> Signed-off-by: Mark Brown <broonie@kernel.org>
> >> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> >> ---
> >>  Documentation/devicetree/bindings/mfd/wm831x.txt |    1 +
> >>  drivers/power/supply/wm831x_power.c              |   58 +++++++++++++=
+++++++++
> >>  2 files changed, 59 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/mfd/wm831x.txt b/Docume=
ntation/devicetree/bindings/mfd/wm831x.txt
> >> index 9f8b743..4e3bc07 100644
> >> --- a/Documentation/devicetree/bindings/mfd/wm831x.txt
> >> +++ b/Documentation/devicetree/bindings/mfd/wm831x.txt
> >> @@ -31,6 +31,7 @@ Required properties:
> >>      ../interrupt-controller/interrupts.txt
> >>
> >>  Optional sub-nodes:
> >> +  - usb-phy : Contains a phandle to the USB PHY.
> >>    - regulators : Contains sub-nodes for each of the regulators suppli=
ed by
> >>      the device. The regulators are bound using their names listed bel=
ow:
> >>
> >> diff --git a/drivers/power/supply/wm831x_power.c b/drivers/power/suppl=
y/wm831x_power.c
> >> index 7082301..d3948ab 100644
> >> --- a/drivers/power/supply/wm831x_power.c
> >> +++ b/drivers/power/supply/wm831x_power.c
> >> @@ -13,6 +13,7 @@
> >>  #include <linux/platform_device.h>
> >>  #include <linux/power_supply.h>
> >>  #include <linux/slab.h>
> >> +#include <linux/usb/phy.h>
> >>
> >>  #include <linux/mfd/wm831x/core.h>
> >>  #include <linux/mfd/wm831x/auxadc.h>
> >> @@ -31,6 +32,8 @@ struct wm831x_power {
> >>       char usb_name[20];
> >>       char battery_name[20];
> >>       bool have_battery;
> >> +     struct usb_phy *usb_phy;
> >> +     struct notifier_block usb_notify;
> >>  };
> >>
> >>  static int wm831x_power_check_online(struct wm831x *wm831x, int suppl=
y,
> >> @@ -125,6 +128,43 @@ static int wm831x_usb_get_prop(struct power_suppl=
y *psy,
> >>       POWER_SUPPLY_PROP_VOLTAGE_NOW,
> >>  };
> >>
> >> +/* In milliamps */
> >> +static const unsigned int wm831x_usb_limits[] =3D {
> >> +     0,
> >> +     2,
> >> +     100,
> >> +     500,
> >> +     900,
> >> +     1500,
> >> +     1800,
> >> +     550,
> >> +};
> >> +
> >> +static int wm831x_usb_limit_change(struct notifier_block *nb,
> >> +                                unsigned long limit, void *data)
> >> +{
> >> +     struct wm831x_power *wm831x_power =3D container_of(nb,
> >> +                                                      struct wm831x_p=
ower,
> >> +                                                      usb_notify);
> >> +     unsigned int i, best;
> >> +
> >> +     /* Find the highest supported limit */
> >> +     best =3D 0;
> >> +     for (i =3D 0; i < ARRAY_SIZE(wm831x_usb_limits); i++) {
> >> +             if (limit >=3D wm831x_usb_limits[i] &&
> >> +                 wm831x_usb_limits[best] < wm831x_usb_limits[i])
> >> +                     best =3D i;
> >> +     }
> >> +
> >> +     dev_dbg(wm831x_power->wm831x->dev,
> >> +             "Limiting USB current to %umA", wm831x_usb_limits[best]);
> >> +
> >> +     wm831x_set_bits(wm831x_power->wm831x, WM831X_POWER_STATE,
> >> +                     WM831X_USB_ILIM_MASK, best);
> >> +
> >> +     return 0;
> >> +}
> >> +
> >>  /*********************************************************************
> >>   *           Battery properties
> >>   ********************************************************************=
*/
> >> @@ -607,6 +647,19 @@ static int wm831x_power_probe(struct platform_dev=
ice *pdev)
> >>               }
> >>       }
> >>
> >> +     power->usb_phy =3D devm_usb_get_phy_by_phandle(&pdev->dev,
> >> +                                                  "usb-phy", 0);
> >> +     if (!IS_ERR(power->usb_phy)) {
> >> +             power->usb_notify.notifier_call =3D wm831x_usb_limit_cha=
nge;
> >> +             ret =3D usb_register_notifier(power->usb_phy,
> >> +                                         &power->usb_notify);
> >> +             if (ret) {
> >> +                     dev_err(&pdev->dev, "Failed to register notifier=
: %d\n",
> >> +                             ret);
> >> +                     goto err_bat_irq;
> >> +             }
> >> +     }
> >
> > No error handling for power->usb_phy? I think you should bail out
> > for all errors except for "not defined in DT". Especially I would
> > expect probe defer handling in case the power supply driver is
> > loaded before the phy driver.
>=20
> Make sense. So I think I need to change like below:
>=20
> power->usb_phy =3D devm_usb_get_phy_by_phandle(&pdev->dev, "usb-phy", 0);
> if (!IS_ERR(power->usb_phy)) {
>         power->usb_notify.notifier_call =3D wm831x_usb_limit_change;
>         ret =3D usb_register_notifier(power->usb_phy, &power->usb_notify);
>         if (ret) {
>                 dev_err(&pdev->dev, "Failed to register notifier: %d\n", =
ret);
>                 goto err_bat_irq;
>         }
> } else if (PTR_ERR(power->usb_phy) !=3D -ENODEV &&
> PTR_ERR(power->usb_phy) !=3D -EINVAL) {
>        ret =3D PTR_ERR(power->usb_phy);
>        dev_err(&pdev->dev, "Failed to find USB phy: %d\n", ret);
>        goto err_bat_irq;
> }
>=20
> The return value -EINVAL means the platform device does not have a
> device node and -ENODEV  means we did not set the 'usb-phy' phandle,
> other errors we should bail out including -PROBE_DEFER. Is it OK for
> you?

Yes, but I think the following is better, which avoids
spamming the log with probe defer messages.=20

power->usb_phy =3D devm_usb_get_phy_by_phandle(&pdev->dev, "usb-phy", 0);
ret =3D PTR_ERR_OR_ZERO(power->usb_phy);

switch (ret) {
case 0:
    power->usb_notify.notifier_call =3D wm831x_usb_limit_change;
    ret =3D usb_register_notifier(power->usb_phy, &power->usb_notify);
    if (ret) {
        dev_err(&pdev->dev, "Failed to register notifier: %d\n", ret);
        goto err_bat_irq;
    }
    break;
case -EINVAL:
case -ENODEV:
    /* ignore missing usb-phy, it's optional */
    power->usb_phy =3D NULL;
    break;
default:
    dev_err(&pdev->dev, "Failed to find USB phy: %d\n", ret);
    /* fall-through */
case -EPROBE_DEFER:
    goto err_bat_irq;
    break;
}

-- Sebastian

--5qdzr4umjjjiacgb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAll4hjQACgkQ2O7X88g7
+prd7g//QdcIGx/QoU2Km40OD9uq+VQlSMyID/6n8RrBTntsYRrz9Nbgywpxa8vf
qe12XeZ/LYHoENAWyGHc7MoUbedd2+1yxAraQXrAGA7G3t7D2hMW3hgLBu0eqmOV
U8IDS4aogfANYve24f4kZHH/zypZwTJCxHuBWbZvckDeTjRl5TjumCzzD6GPEcBB
kSUurJ4DyenJA68DFSGod5J1nQGLNjViD9BaRgAFmxgYzpxuQapAzjJRNb2mAkbQ
kSZMBsiMopvm8rMZl5heV3SFuX9IjUOJchPIe1iee5CEkr9V6TZfoOLWW8GqsFLk
Z0pWSd8e8h1RisdbUpszOMxYfqHHwc3rU109rfCmRa3O9RpHT+Bla6VzT6EGNVPS
cJZm1V1NxQPCgC6bbNlDPvRFUCLpG1ETGFUXeqKgc1ckEqV7ZrGXp3tG1sDh3qQL
0YmyKIDYwQdrfkvyZFuPMo6r8+s1ub4fZir0GizKeAIt1K99ZTyX0PLAnAG7CGid
tBptNq2TxVOrDrGTVDThoAR4xgiaXfBgZPq3W4WWvNfZDNDDJF0z+q58GSUZX4Ah
q4VE3k01+aUldR3rNeX7c/9tEXveTghNUlIvhH+ujRFXOPWKKYk2KioJHUMWMOQA
1+iqhi6LyheD7iczoA9JpPu2Md3I8iqY3k28wisk17xbkd6Jbhk=
=ND7J
-----END PGP SIGNATURE-----

--5qdzr4umjjjiacgb--
