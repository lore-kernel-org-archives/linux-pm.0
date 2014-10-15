From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RFT PATCH] power: bq2415x_charger: Properly handle ENODEV from
 power_supply_get_by_phandle
Date: Wed, 15 Oct 2014 16:09:57 +0200
Message-ID: <1413382197.9555.0.camel@AMDC1943>
References: <1413275573-23014-1-git-send-email-k.kozlowski@samsung.com>
 <20141015090512.GA26651@earth.universe> <1413371491.26771.15.camel@AMDC1943>
 <20141015135806.GA5152@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20141015135806.GA5152@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On =C5=9Bro, 2014-10-15 at 15:58 +0200, Sebastian Reichel wrote:
> Hi,
>=20
> On Wed, Oct 15, 2014 at 01:11:31PM +0200, Krzysztof Kozlowski wrote:
> > > [...] I guess something as the following is needed:
> > >=20
> > > if (IS_ERR_OR_NULL(bq->notify_psy)) {
> > >     if (bq->notify_psy)
> > >         dev_err(&client->dev, "no 'ti,usb-charger-detection' prop=
erty\n");
> > >     ret =3D PTR_ERR(bq->notify_psy);
> > >     goto error_2;
> > > }
> >=20
> > So you do not want to defer the probe? What if notified charger wil=
l
> > come online after this probe?
>=20
> No, but resources must be freed fore the EPROBE_DEFER case, too.
> You are right, though, that my snipped does not setup the
> EPROBE_DEFER return value correctly.
>=20
> > Second idea - now I think my change is not compatible with bindings
> > (documentation) and could break booting of existing boards which do=
 not
> > provide the "ti,usb-charger-detection" property. For example
> > arch/arm/boot/dts/omap3-n900.dts
> >
> > The "ti,usb-charger-detection" property is marked as optional but m=
y
> > patch actually makes it required.
> >=20
> > It should be rather like this:
> >=20
> > if (IS_ERR(bq->notify_psy)) {
> >     bq->notify_psy =3D NULL;
> >     dev_info(&client->dev, "no 'ti,usb-charger-detection' property =
\n");
> > } else if (!bq->notify_psy) {
> >     ret =3D -EPROBE_DEFER;
> >     goto error_2;
> > }
> >
> > What do you think?
>=20
> I thing the dev_info call should include the error code returned,
> since its not propagated further:
>=20
> dev_info(&client->dev, "no 'ti,usb-charger-detection' property (err=3D=
%d)\n",
>          PTR_ERR(by->notify_psy));
>=20
> Apart from that it looks fine to me. Can you send a v2?

Sure, I'll send fixed version.

Best regards,
Krzysztof
>=20
> > [...]
>=20
> -- Sebastian
