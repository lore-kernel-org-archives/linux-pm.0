From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 6/7] power: act8945a_charger: Add max current property
Date: Tue, 23 Aug 2016 04:43:51 +0200
Message-ID: <20160823024351.akwvobxzvwwhzwsq@earth>
References: <1471848557-27278-1-git-send-email-wenyou.yang@atmel.com>
 <1471848557-27278-7-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bldsedwe2jgypeub"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1471848557-27278-7-git-send-email-wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--bldsedwe2jgypeub
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 22, 2016 at 02:49:16PM +0800, Wenyou Yang wrote:
> [...]
>
> -	chglev_pin =3D of_get_named_gpio_flags(np,
> -				"active-semi,chglev-gpios", 0, &flags);
> -
> -	if (gpio_is_valid(chglev_pin)) {
> -		gpio_set_value(chglev_pin,
> -			       ((flags =3D=3D OF_GPIO_ACTIVE_LOW) ? 0 : 1));
> +	charger->chglev_gpio =3D gpiod_get(dev->parent,
> +					 "active-semi,chglev", GPIOD_IN);
> +	if (PTR_ERR(charger->chglev_gpio) =3D=3D -EPROBE_DEFER) {
> +		dev_info(dev, "probe retry requested for gpio \"chglev\"\n");

missing return? You need to return EPROBE_DEFER in probe().

> +	} else if (IS_ERR(charger->chglev_gpio)) {
> +		dev_err(dev, "unable to claim gpio \"chglev\"\n");
> +		charger->chglev_gpio =3D NULL;
>  	}
> =20
> [...]

-- Sebastian

--bldsedwe2jgypeub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXu7hnAAoJENju1/PIO/qaNf0QAJkqB322VSL1w2gXMfjxB/5b
udW6ZrJFVdSUN5DLg/A+AhWmNcVxNtlYocnjvgGYIoMB1t7BGkEx/vL3nar2pCSS
b/4jljKrr2k3kw9yM10a1bkic3kuh7Ku8pQu3fkm0EVWB2iVZJhBIOpgNV+A9epz
PEp77glTzY3BOD+EWk5R7hSHVsyN41+d/AfyMKkUrJdJdSy9rfMQi/A5YDm9UgCX
LuMxwD1Ao6Ik3m0lJfiU0Fm/UpzaubhOgss1eNJYAjmloyIZAtwmrwsce38iNWPG
tz6/FS2Zycw4zTfdqjRdoRWgJkiacDFwNmnSfMO+loluIwq89HfTF9Yw43dEOoig
em0IU0PgVdFNfczDgpSYFeSe7I2XnQrXSioDhscF0DdwWZ8wI91TLCmGAN3HkSSn
2sPiIRql2yESazacsZzdu7qKiOvmdqmo1rm9bPjYFg/1WsGusSKEc8B10dLKR60b
YLxE2PNAJg24zOb1SLgC1vRbBhIKwmw+2VQTBR8JjWAWJmt5FbfWXqcl+BCoxpj9
KlMoH+0M5UGHXn4/pJoh9pB547l5Lk2HbFt0iVa2A5idr9H1tXyLxL8hfmRBVp68
Mi6ZkWVwJfipiGIzdmhnoVffL7m/uacP2mX5H3IvjF1f8GwWLnQjN55hGysHZb7W
6beZLd5LhTyJ/Z3z0eDu
=U2Q+
-----END PGP SIGNATURE-----

--bldsedwe2jgypeub--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
