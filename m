From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 1/2] Documentation: Add sbs-manager device tree node
 documentation
Date: Fri, 1 Jul 2016 00:52:17 +0200
Message-ID: <20160630225217.GA11555@earth>
References: <1bFnWI-0000MX-9R>
 <1467317142-14063-1-git-send-email-karl-heinz@schneider-inet.de>
 <1467317142-14063-2-git-send-email-karl-heinz@schneider-inet.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1467317142-14063-2-git-send-email-karl-heinz@schneider-inet.de>
Sender: linux-i2c-owner@vger.kernel.org
To: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Rosin <peda@axentia.se>, Phil Reid <preid@electromag.com.au>
List-Id: linux-pm@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 30, 2016 at 10:05:41PM +0200, Karl-Heinz Schneider wrote:
> This patch adds device tree documentation for the sbs-manager
>=20
> Reviewed-by: Phil Reid <preid@electromag.com.au>
> Signed-off-by: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
> ---
>  .../devicetree/bindings/power/sbs,sbs-manager.txt  | 52 ++++++++++++++++=
++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/sbs,sbs-manag=
er.txt
>=20
> diff --git a/Documentation/devicetree/bindings/power/sbs,sbs-manager.txt =
b/Documentation/devicetree/bindings/power/sbs,sbs-manager.txt
> new file mode 100644
> index 0000000..1d7e5ee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/sbs,sbs-manager.txt
> @@ -0,0 +1,52 @@
> +Binding for sbs-manager
> +
> +Required properties:
> +- compatible: should be "lltc,ltc1760" or use "sbs,sbs-manager" as fallb=
ack.
> +- reg: integer, i2c address of the device. Should be <0xa>.
> +
> +From OS view the device is basically an i2c-mux used to communicate with=
 up to
> +four smart battery devices at address 0xb. The driver actually implement=
s this
> +behaviour. So standard i2c-mux nodes can be used to register up to four =
slave
> +batteries. Channels will be numerated as 1, 2, 4 and 8.

I think it's better to use channel 1-4 and do the translation in the
driver's channel select method. It means one does not have to worry
about anybody accidently configuring channel 3 and it also maps
nicely to the datasheet talking about BAT1-BAT4.

-- Sebastian

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXdaKeAAoJENju1/PIO/qahvcP/3vmy11A4NUBox5Frmp8o76I
UidXT3yiypDzsqHfr+TPk+yCg42lsmPaJDBxHwReY6Sz//4Tdwx2wEE4R1UoWZN8
VGUsUZ6BVhYIrO0Nac3EaXnWlW14CVjuLEgiu3kP9SIbAarx+AyC3Dw+vi/B+FjR
ym5d5RpI+7CiWYE6A/yVG36aBquHsb8SZBrNkUA7uboXohjHmuRDkCJH7/knukcj
TwbunXrWeG/J+yPtR57Q3PVNOg45Y5KPFe7loXittqXSoCE7TE+tmLgS+gBu8lOB
ouYJt2xpFOSVU0nkyYprVkZqFaJOC29exV4IiYjHaSlovQpsEC7svgW6Z5YRSsdL
Qm+MQ4JLH7OgLlEEQO9Z9SgtVB9PUVmtaYHbE6ssUMRlEowWTlAbVGD08WS99ZI/
XNqpvd3ZsnRJYWieY6WAElKnRXWlr/KwJXgTTqMuWkiuuNDrPADhCJRAqd1dnNl7
YCE6jgCYk30rDuOgiZsmdKZb1qqCZboC72yJS4RDu6/LCeSU3az0ymQDxcwoR743
i5QrNX+RhiI9MYX7Pb1iqxQaOBMgG65azRK57OAfEZ3Zsd448+SHXSN1JWzLnqUo
u9BjCU4JOHVVgyf6dza9/e3qRJBYHHwWvragSTjGnABj5YQH/51MFAC2b9JGQmv7
NUyIGhRlC7uoFNA9Hx/F
=8sli
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
