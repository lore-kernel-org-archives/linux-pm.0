From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 2/8] power_supply: sysfs: Use power_supply_*() API for
 accessing function attrs
Date: Wed, 15 Oct 2014 12:49:59 +0200
Message-ID: <1413370199.26771.4.camel@AMDC1943>
References: <1413289246-31650-1-git-send-email-k.kozlowski@samsung.com>
 <1413289246-31650-3-git-send-email-k.kozlowski@samsung.com>
 <20141015103217.GB14266@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20141015103217.GB14266@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>, Guenter Roeck <linux@roeck-us.net>, Myungjoo Ham <myungjoo.ham@samsung.com>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On =C5=9Bro, 2014-10-15 at 12:32 +0200, Pavel Machek wrote:
> On Tue 2014-10-14 14:20:40, Krzysztof Kozlowski wrote:
> > Replace direct calls to power supply function attributes with wrapp=
ers.
> > Wrappers provide safe access access in case of unregistering the po=
wer
> > supply (.e.g by removing the driver). Replace:
> >  - get_property -> power_supply_get_property
> >  - set_property -> power_supply_set_property
> >  - property_is_writeable -> power_supply_property_is_writeable
> >=20
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>=20
> Acked-by: Pavel Machek <pavel@ucw.cz>

Thanks for looking at patches.


> > @@ -76,7 +76,7 @@ static ssize_t power_supply_show_property(struct =
device *dev,
> >  	if (off =3D=3D POWER_SUPPLY_PROP_TYPE) {
> >  		value.intval =3D psy->type;
> >  	} else {
> > -		ret =3D psy->get_property(psy, off, &value);
> > +		ret =3D power_supply_get_property(psy, off, &value);
> > =20
>=20
> One thing.. Your power_supply_get_property (and friends) check for ps=
y
> =3D=3D NULL. Is it neccessary / good idea? As far as I can tell, it s=
hould
> not really be NULL...

It is not necessary. I thought it would be a good behavior of such
exported function. You're right that this shouldn't be NULL especially
because previously it was dereferenced.

Other existing power supply exported functions don't check this so mayb=
e
I shouldn't introduce inconsistency.

I'll remove the check and re-spin. I'll found ugly typos in commit
message anyway.

Best regards,
Krzysztof
