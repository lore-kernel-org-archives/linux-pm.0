From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RFT PATCH] power: bq2415x_charger: Properly handle ENODEV from
 power_supply_get_by_phandle
Date: Wed, 15 Oct 2014 13:11:31 +0200
Message-ID: <1413371491.26771.15.camel@AMDC1943>
References: <1413275573-23014-1-git-send-email-k.kozlowski@samsung.com>
 <20141015090512.GA26651@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
In-reply-to: <20141015090512.GA26651@earth.universe>
Sender: stable-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On =C5=9Bro, 2014-10-15 at 11:05 +0200, Sebastian Reichel wrote:
> Hi Krzysztof,
>=20
> On Tue, Oct 14, 2014 at 10:32:53AM +0200, Krzysztof Kozlowski wrote:
> > The power_supply_get_by_phandle() on error returns ENODEV or NULL.
> > The driver later expects obtained pointer to power supply to be
> > valid or NULL. If it is not NULL then it dereferences it in
> > bq2415x_notifier_call() which would lead to dereferencing ENODEV-va=
lue
> > pointer.
> >=20
> > Properly handle the power_supply_get_by_phandle() error case and ab=
ort probe.
> >=20
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Fixes: faffd234cf85 ("bq2415x_charger: Add DT support")
> > Cc: <stable@vger.kernel.org>
>=20
> That looks valid, but I guess this should change one more thing:
>=20
> > ---
> >  drivers/power/bq2415x_charger.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/power/bq2415x_charger.c b/drivers/power/bq2415=
x_charger.c
> > index e384844a1ae1..d9c457217b6a 100644
> > --- a/drivers/power/bq2415x_charger.c
> > +++ b/drivers/power/bq2415x_charger.c
> > @@ -1579,8 +1579,13 @@ static int bq2415x_probe(struct i2c_client *=
client,
> >  	if (np) {
> >  		bq->notify_psy =3D power_supply_get_by_phandle(np, "ti,usb-charg=
er-detection");
> > =20
> > -		if (!bq->notify_psy)
> > +		if (!bq->notify_psy) {
> >  			return -EPROBE_DEFER;
>=20
> this also needs to goto error_2. I guess something as the following
> is needed:
>=20
> if (IS_ERR_OR_NULL(bq->notify_psy)) {
>     if (bq->notify_psy)
>         dev_err(&client->dev, "no 'ti,usb-charger-detection' property=
\n");
>     ret =3D PTR_ERR(bq->notify_psy);
>     goto error_2;
> }

So you do not want to defer the probe? What if notified charger will
come online after this probe?

Second idea - now I think my change is not compatible with bindings
(documentation) and could break booting of existing boards which do not
provide the "ti,usb-charger-detection" property. For example
arch/arm/boot/dts/omap3-n900.dts

The "ti,usb-charger-detection" property is marked as optional but my
patch actually makes it required.

It should be rather like this:

if (IS_ERR(bq->notify_psy)) {
    bq->notify_psy =3D NULL;
    dev_info(&client->dev, "no 'ti,usb-charger-detection' property \n")=
;
} else if (!bq->notify_psy) {
    ret =3D -EPROBE_DEFER;
    goto error_2;
}

What do you think?

Krzysztof

> > +		} else if (IS_ERR(bq->notify_psy)) {
> > +			dev_err(&client->dev, "no 'ti,usb-charger-detection' property\n=
");
> > +			ret =3D PTR_ERR(bq->notify_psy);
> > +			goto error_2;
> > +		}
> >  	}
> >  	else if (pdata->notify_device)
> >  		bq->notify_psy =3D power_supply_get_by_name(pdata->notify_device=
);
>=20
> -- Sebastian
