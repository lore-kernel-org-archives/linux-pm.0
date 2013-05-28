From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/1] Thermal: spear: Fix compilation error
Date: Tue, 28 May 2013 10:13:34 +0800
Message-ID: <1369707214.1913.1.camel@rzhang1-mobl4>
References: <1369128041-23403-1-git-send-email-sachin.kamat@linaro.org>
	 <519E314A.80401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33542 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758557Ab3E1CNh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 27 May 2013 22:13:37 -0400
In-Reply-To: <519E314A.80401@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Sachin Kamat <sachin.kamat@linaro.org>, linux-pm@vger.kernel.org, Vincenzo Frascino <vincenzo.frascino@st.com>, Viresh Kumar <viresh.kumar@linaro.org>

On Thu, 2013-05-23 at 11:10 -0400, Eduardo Valentin wrote:
> On 21-05-2013 05:20, Sachin Kamat wrote:
> > Fixes the following compilation error introduced by commit 253e3ae1=
70
> > (Thermal: spear_thermal: convert to devm_ioremap_resource).

As this commit has not been in upstream yet.
I'll merge these two patches together, instead of two separate patches.
Refreshed patch applied in thermal -next.

thanks,
rui
> > drivers/thermal/spear_thermal.c: In function =E2=80=98spear_thermal=
_probe=E2=80=99:
> > drivers/thermal/spear_thermal.c:123:46: error: =E2=80=98dev=E2=80=99=
 undeclared
> > (first use in this function)
> > stdev->thermal_base =3D devm_ioremap_resource(dev, res);
> >=20
> > While at it also remove the error message as devm_ioremap_resource(=
)
> > provides its own error messages.
> >=20
> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> > Cc: Vincenzo Frascino <vincenzo.frascino@st.com>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
>=20
> Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>
>=20
> > ---
> > Compile tested and based on linux-next (20130521).
>=20
> Also compiled tested on same linux-next.
>=20
> Tested-by: Eduardo Valentin <eduardo.valentin@ti.com>

> > ---
> >  drivers/thermal/spear_thermal.c |    6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spea=
r_thermal.c
> > index fa30918..813add6 100644
> > --- a/drivers/thermal/spear_thermal.c
> > +++ b/drivers/thermal/spear_thermal.c
> > @@ -120,11 +120,9 @@ static int spear_thermal_probe(struct platform=
_device *pdev)
> > =20
> >  	/* Enable thermal sensor */
> >  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	stdev->thermal_base =3D devm_ioremap_resource(dev, res);
> > -	if (IS_ERR(stdev->thermal_base)) {
> > -		dev_err(&pdev->dev, "ioremap failed\n");
> > +	stdev->thermal_base =3D devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(stdev->thermal_base))
> >  		return PTR_ERR(stdev->thermal_base);
> > -	}
> > =20
> >  	stdev->clk =3D devm_clk_get(&pdev->dev, NULL);
> >  	if (IS_ERR(stdev->clk)) {
> >=20
>=20
>=20


