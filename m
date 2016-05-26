From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] PM / devfreq: exynos-nocp: Checking for IS_ERR instead
 of NULL
Date: Thu, 26 May 2016 09:39:07 +0300
Message-ID: <20160526063907.GM11011@mwanda>
References: <20160518103707.GA9436@mwanda>
 <57459BD4.1030201@samsung.com>
 <alpine.DEB.2.10.1605251710500.3644@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1605251710500.3644@hadrien>
Sender: kernel-janitors-owner@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, May 25, 2016 at 05:11:33PM +0200, Julia Lawall wrote:
>=20
>=20
> On Wed, 25 May 2016, Chanwoo Choi wrote:
>=20
> > On 2016=EB=85=84 05=EC=9B=94 18=EC=9D=BC 19:37, Dan Carpenter wrote=
:
> > > The platform_get_resource() function returns NULL on error, it ne=
ver
> > > returns error pointers.
> > >
> > > Fixes: 0179a913875a ('PM / devfreq: event: Add new Exynos NoC pro=
be driver')
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > >
> > > diff --git a/drivers/devfreq/event/exynos-nocp.c b/drivers/devfre=
q/event/exynos-nocp.c
> > > index 6b6a5f3..03b35d5 100644
> > > --- a/drivers/devfreq/event/exynos-nocp.c
> > > +++ b/drivers/devfreq/event/exynos-nocp.c
> > > @@ -220,8 +220,8 @@ static int exynos_nocp_parse_dt(struct platfo=
rm_device *pdev,
> > >
> > >  	/* Maps the memory mapped IO to control nocp register */
> > >  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > -	if (IS_ERR(res))
> > > -		return PTR_ERR(res);
> > > +	if (!res)
> > > +		return -ENXIO;
> > >
> > >  	base =3D devm_ioremap_resource(dev, res);
> > >  	if (IS_ERR(base))
> >
> > Looks good to me.
>=20
> I believe that there is no need for the test at all.
> devm_ioremap_resource should make the test.

True.  The static checker warning here is just that "res" isn't an erro=
r
pointer, not that we dereference it.

I'll resend.

regards,
dan carpenter

--
To unsubscribe from this list: send the line "unsubscribe kernel-janito=
rs" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
