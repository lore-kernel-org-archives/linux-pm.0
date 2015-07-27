From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [RFT/RFC] power_supply: bq2415x_charger: Initialize workqueue
 before scheduling it
Date: Mon, 27 Jul 2015 16:48:00 +0200
Message-ID: <20150727144800.GD28038@pali>
References: <1436834053-2084-1-git-send-email-k.kozlowski@samsung.com>
 <201507252349.06519@pali>
 <20150727142229.GD12993@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35768 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668AbbG0OsF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2015 10:48:05 -0400
Content-Disposition: inline
In-Reply-To: <20150727142229.GD12993@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 27 July 2015 16:22:29 Sebastian Reichel wrote:
> Hi,
>=20
> On Sat, Jul 25, 2015 at 11:49:06PM +0200, Pali Roh=C3=A1r wrote:
> > On Tuesday 14 July 2015 02:34:13 Krzysztof Kozlowski wrote:
> > > The driver during probe registers a power supply notifier
> > > (with bq2415x_notifier_call() callback) and calls it manually rig=
ht
> > > after. The notifier callback function schedules driver's workqueu=
e
> > > (bq->work).
> > >=20
> > > However the workqueue was initialized after these two events (aft=
er
> > > registering power supply notifier and calling manually the callba=
ck).
> > >=20
> > > When power supply core notified the driver (executing its
> > > bq2415x_notifier_call() callback) the scheduled workqueue could b=
e
> > > still uninitialized.
> > >=20
> > > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > > Reported-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > >=20
> > > ---
> > >=20
> > > I don't have the hardware, please test. Additionally I could not =
find
> > > the commit which introduced the issue so I did not cc-stable.
> > > ---
> > >  drivers/power/bq2415x_charger.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/power/bq2415x_charger.c
> > > b/drivers/power/bq2415x_charger.c index e98dcb661cc9..527ed0f1879=
6
> > > 100644
> > > --- a/drivers/power/bq2415x_charger.c
> > > +++ b/drivers/power/bq2415x_charger.c
> > > @@ -1601,6 +1601,7 @@ static int bq2415x_probe(struct i2c_client
> > > *client, bq->reported_mode =3D BQ2415X_MODE_OFF;
> > >  	bq->autotimer =3D 0;
> > >  	bq->automode =3D 0;
> > > +	INIT_DELAYED_WORK(&bq->work, bq2415x_timer_work);
> > >=20
> > >  	if (np || ACPI_HANDLE(bq->dev)) {
> > >  		ret =3D device_property_read_u32(bq->dev,
> > > @@ -1677,7 +1678,6 @@ static int bq2415x_probe(struct i2c_client
> > > *client, dev_info(bq->dev, "automode not supported\n");
> > >  	}
> > >=20
> > > -	INIT_DELAYED_WORK(&bq->work, bq2415x_timer_work);
> > >  	bq2415x_set_autotimer(bq, 1);
> > >=20
> > >  	dev_info(bq->dev, "driver registered\n");
> >=20
> > Looks like this is really problem. I sent alternative patch to mail=
ing=20
> > list which should fix this problem too plus allows to load=20
> > bq2415x_charger.ko in n900 qemu.
>=20
> I have not yet reviewed your patch (just skipped over it), but the
> qemu changes are a bit intrusive for -rc. I suggest to apply this
> patch for 4.2-rc. The extended patch can then be added in 4.3.
>=20
> -- Sebastian

I'm not sure if this patch is enough... as timer_work should be called
after that init bq2415x_set_autotimer call.

I'm ok with postponing my patch later for 4.3. So if you think apply
this one for 4.2...

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
