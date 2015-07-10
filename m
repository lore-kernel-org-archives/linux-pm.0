From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 1/2] power: reset: at91: add sama5d3 reset function
Date: Fri, 10 Jul 2015 08:58:56 +0200
Message-ID: <20150710065856.GZ28632@lukather>
References: <1436436947-11210-1-git-send-email-josh.wu@atmel.com>
 <20150710060350.GA3127@piout.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3cI6DWK3Xt33P8nt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150710060350.GA3127@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Josh Wu <josh.wu@atmel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, Guenter Roeck <linux@roeck-us.net>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Fabian Frederick <fabf@skynet.be>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--3cI6DWK3Xt33P8nt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2015 at 08:03:50AM +0200, Alexandre Belloni wrote:
> >  static const struct of_device_id at91_reset_of_match[] =3D {
> >  	{ .compatible =3D "atmel,at91sam9260-rstc", .data =3D at91sam9260_res=
tart },
> >  	{ .compatible =3D "atmel,at91sam9g45-rstc", .data =3D at91sam9g45_res=
tart },
> > +	{ .compatible =3D "atmel,sama5d3-rstc", .data =3D sama5d3_restart },
> >  	{ /* sentinel */ }
> >  };
> > =20
> > @@ -181,17 +189,21 @@ static int at91_reset_of_probe(struct platform_de=
vice *pdev)
> >  		return -ENODEV;
> >  	}
> > =20
> > -	for_each_matching_node(np, at91_ramc_of_match) {
> > -		at91_ramc_base[idx] =3D of_iomap(np, 0);
> > -		if (!at91_ramc_base[idx]) {
> > -			dev_err(&pdev->dev, "Could not map ram controller address\n");
> > -			return -ENODEV;
> > +	match =3D of_match_node(at91_reset_of_match, pdev->dev.of_node);
> > +	at91_restart_nb.notifier_call =3D match->data;
> > +
> > +	if (match->data !=3D sama5d3_restart) {
>=20
> This doesn't scale well. I would create a structure with a pointer to
> the restart function and a boolean or a bitfield to store whether the
> workaround is needed. Use that structure in your match data. Then, you
> won't need to reorder anything.

Maybe it simply doesn't need to scale (yet).

You have a single exception here. Maybe you will have only this one in
the future, maybe you won't, but for now, that solution looks a bit
overkill.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--3cI6DWK3Xt33P8nt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVn20wAAoJEBx+YmzsjxAg/AoP/R0Ma7O+2SQUrB0QLzgSeJdj
BdzXNNkoo43uOMpcSmmnH2cMv/BaHrZV1HrhYNTCktMYCHo35ak0uFtXzND0bHGJ
vihWdUlvYnGUpBnhLFr0L/XeoYrx4+ntC6KNpZzowVUW6KLPqPgP/tgEx3jIYXg+
Vk6yOu4hCuXpUIJSTaxrgsfzpWICqpc11L07UFxAWoBwPFz5oLXIQvgOdr2AP3+S
ITZl125JheYzd3qN/JkLoCzW38OZKCSbknfvf3woN8gls94Z2JiPR1Z3VOwwQi9j
l8YLx/39+Vj01sJ1d9ZU9NDoEjuOsx7dDsGG5APQZ+GzLb+x//B1Cna37pKpGRc0
MRn4l/q+NVNBLnRg3Y59NGjBQd9G56TMci43ILtP8u4rNr8tn4LdgdrddrZLnIKw
iqBBxOGkCZfY9MrdznYyi4NPr5PjIBVJ4wMWkBX4ht6alx6aI+1tzkbEYwresWsU
M4zegyfVmyAy6CULlu6E3IRtnYu1zwguz3ykrUqUpYKZsUKYqaX84gYDiU0h6cvI
MRV2SDfjaZZH++zg4c2XtIIG2ZJorsPZ3Y4LNzAGsEECXSIYlu7xP6Q4mKPcCeG3
EngJ+O2kLbrwZFKG5IbMuw115tXOimq2LVzcOXVxb4im27LOFpn+3wxfZXuFfeDO
51dpAg8WpiZmuDmKgkq/
=MtPD
-----END PGP SIGNATURE-----

--3cI6DWK3Xt33P8nt--
