From: Todd E Brandt <todd.e.brandt@linux.intel.com>
Subject: Re: [PATCH 1/3] mfd/axp20x: change battery cell name to fuel gauge
Date: Wed, 21 Jan 2015 11:16:29 -0800
Message-ID: <20150121191629.GA15525@linux.intel.com>
References: <20150107212450.GB3440@linux.intel.com>
 <20150120114725.GI13701@x1>
Reply-To: todd.e.brandt@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30062 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753297AbbAUTRL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 21 Jan 2015 14:17:11 -0500
Content-Disposition: inline
In-Reply-To: <20150120114725.GI13701@x1>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, jacob.jun.pan@linux.intel.com, sameo@linux.intel.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, david.woodhouse@intel.com, todd.e.brandt@intel.com

On Tue, Jan 20, 2015 at 11:47:25AM +0000, Lee Jones wrote:
> On Wed, 07 Jan 2015, Todd E Brandt wrote:
>=20
> > mfd/axp20x: change battery cell name to fuel gauge
> >=20
> > Name changes to the battery cell structure to a
> > more generic cell type: fuel gauge.
> >=20
> > Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>
> > ----
> >  drivers/mfd/axp20x.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> > index b1b580a..e75717e 100644
> > --- a/drivers/mfd/axp20x.c
> > +++ b/drivers/mfd/axp20x.c
> > @@ -87,7 +87,7 @@ static struct resource axp20x_pek_resources[] =3D=
 {
> >  	},
> >  };
> > =20
> > -static struct resource axp288_battery_resources[] =3D {
> > +static struct resource axp288_fuel_gauge_resources[] =3D {
> >  	{
> >  		.start =3D AXP288_IRQ_QWBTU,
> >  		.end   =3D AXP288_IRQ_QWBTU,
> > @@ -236,7 +236,7 @@ static const struct i2c_device_id axp20x_i2c_id=
[] =3D {
> >  };
> >  MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);
> > =20
> > -static const struct acpi_device_id axp20x_acpi_match[] =3D {
> > +static struct acpi_device_id axp20x_acpi_match[] =3D {
>=20
> Why have you dropped the cost qualifier here?

That's a bug, I shouldn't have removed the const qualifier, I'll submit=
 a
v2 patch with this change removed. Thanks for the catch.

>=20
> [...]
>=20
> --=20
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
