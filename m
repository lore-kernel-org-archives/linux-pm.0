From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 1/7] mfd: Add support for DA9150 combined charger &
 fuel-gauge device
Date: Wed, 10 Sep 2014 10:51:19 +0100
Message-ID: <20140910095119.GO30307@lee--X1>
References: <cover.1409145187.git.Adam.Thomson.Opensource@diasemi.com>
 <d6c7de200c9447dbafa74ee76739da943a0b73b2.1409145187.git.Adam.Thomson.Opensource@diasemi.com>
 <53FF16BC.9050701@gmail.com>
 <2E89032DDAA8B9408CB92943514A0337AB5144B5@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:53507 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbaIJJv0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Sep 2014 05:51:26 -0400
Received: by mail-ig0-f176.google.com with SMTP id hn18so6180460igb.15
        for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2014 02:51:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337AB5144B5@SW-EX-MBX01.diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Joe Perches <joe@perches.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>

On Tue, 09 Sep 2014, Opensource [Adam Thomson] wrote:
> On August 28, 2014 12:47, Varka Bhadram wrote:
>=20
> > On 08/28/2014 04:18 PM, Adam Thomson wrote:
> >=20
> > (...)
> >=20
> > > +static int da9150_probe(struct i2c_client *client,
> > > +			const struct i2c_device_id *id)
> > > +{
> > > +	struct da9150 *da9150;
> > > +	int ret;
> > > +
> > > +	da9150 =3D devm_kzalloc(&client->dev, sizeof(struct da9150), GF=
P_KERNEL);
> > > +	if (da9150 =3D=3D NULL)
> > > +		return -ENOMEM;
> >=20
> > da9150 =3D devm_kzalloc(&client->dev, sizeof(*da9150), GFP_KERNEL);
> > if (!da9150)
> > 	return -ENOMEM;
>=20
> Ok, no real difference, but can change it.

Not functionally, but we like to do things as succinctly as possible.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
