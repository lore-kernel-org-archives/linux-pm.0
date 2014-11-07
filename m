From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/5] regulator: rt5033: Add RT5033 Regulator device driver
Date: Fri, 7 Nov 2014 10:27:52 +0000
Message-ID: <20141107102752.GC8509@sirena.org.uk>
References: <1415328727-16245-1-git-send-email-beomho.seo@samsung.com>
 <1415328727-16245-3-git-send-email-beomho.seo@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wrbmJCjDMpeEYJph"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415328727-16245-3-git-send-email-beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, jonghwa3.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, geunsik.lim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--wrbmJCjDMpeEYJph
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 07, 2014 at 11:52:04AM +0900, Beomho Seo wrote:

> +static int rt5033_regulator_dt_parse_data(struct device *dev)
> +{
> +	int ret;
> +	struct device_node *np;
> +
> +	np = of_get_child_by_name(dev->parent->of_node, "regulators");
> +	if  (!np) {
> +		dev_err(dev, "Failed to get child node for regulators\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = of_regulator_match(dev, np, rt5033_regulator_matches,
> +					ARRAY_SIZE(rt5033_regulator_matches));
> +	if (ret < 0)
> +		return ret;

Please convert this to use regulators_node in the descriptor to match
the regulators, then you don't need any specific code.

--wrbmJCjDMpeEYJph
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUXJ6oAAoJECTWi3JdVIfQUkoH/ifR7qwAjlZHw8+a1r4K0rQF
100JcX1rnNiWYQx5zXGCcFPkFz2YRKhSgE4Qxis50AjeZD3kAyylg4W7u6C3IQqs
aoXGfeRk/G8KhuFVwrvN36LOcLiF3vPj1iAgMYVZCoDSnX586eW8570zrTXv55xu
eBkLj8esRI/2Zc565QDdpNVTa91JpB960jXsvKk2M2uBy+aLsWGWnEqOQEbMd3zI
FmaxjkI16TD91xB8ExH4PFDGjeYTo3/Rvsc53S/NanoMot2D1rlUZTSeqiAbP3DC
tA2oLNjfqbJ4RM29dgUzwIRe3j03hKYMsKnUzNODt1MoHj3QQ3/gf5HZ3L0PK6c=
=GEe3
-----END PGP SIGNATURE-----

--wrbmJCjDMpeEYJph--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
