From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] power: supply: New driver for LEGO MINDSTORMS EV3
 battery
Date: Tue, 11 Apr 2017 18:02:05 +0200
Message-ID: <20170411160205.yqr6z5nwh5xn5zdb@earth>
References: <1491251029-23256-1-git-send-email-david@lechnology.com>
 <1491251029-23256-3-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fqkalhwbzwhan7m7"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1491251029-23256-3-git-send-email-david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--fqkalhwbzwhan7m7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Driver looks fine. One minor thing, though:

On Mon, Apr 03, 2017 at 03:23:48PM -0500, David Lechner wrote:
> [...]
>
> +	batt->psy = power_supply_register(dev, &lego_ev3_battery_desc, &psy_cfg);
> +	err = PTR_ERR_OR_ZERO(batt->psy);
> +	if (err) {
> +		dev_err(dev, "failed to register power supply\n");
> +		return err;
> +	}

There is devm_power_supply_register() and it makes sense to use it,
since that means you can drop the remove function completly :)

> +	return 0;
> +}
> +
> +static int lego_ev3_battery_remove(struct platform_device *pdev)
> +{
> +	struct lego_ev3_battery *batt = platform_get_drvdata(pdev);
> +
> +	power_supply_unregister(batt->psy);
> +
> +	return 0;
> +}

-- Sebastian

--fqkalhwbzwhan7m7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljs/foACgkQ2O7X88g7
+pqDYQ/+NhaQdXYfOEVQWaQkXUKJ2r6YdW/BX0j6pB13Cp2JNTRwSl4JGDluA9Oo
DVa2mBcofZmLuy1ubr/VOqc3cwBHPg2gvsw8Yeb6VjPakiBq9x4MI8vhfjZhUpi5
Cs5XsBoi8+feeUuUdP/MlpC7dA+smv1i7Gy+DLXamatXcmJl5CS8dA4onLppsmr+
afGYdKIFYzVBRty+Tgl96PydFSwL6MtHp0LhB2zt5L4OupWO2h90dSLGCtIvNPoF
TcPH52xt0V0MFPmUidOQnHtOvUqdIEJk1yJOkTpnpCh4aPE7N+nElI3s/fGnIRDL
h3QjPPNc9ek3Ul4P8YO1j6oQx/DlcyBeH4moroLQykB9fXB0G3EKvpwzdACqAiZD
PMRdfp1XVpWM7vVE0hEZ4iXDGYgx8CsmTMDOrK+mWT08LeK0If3dCew95EjNI+XA
lu6dAcFsgK9jarHuKaRkle4IOB95JtbH04gXWAOzNcaLyKWgc8VrzimJmEqdVPAZ
DDmkvqFg2a/28k17QrOe0fztO94tqhK7U7DHLPP2X9lB27xkvu9aalCJOXJevy3m
zKBtzppPEEcpAGUj60rvqIrjqhGpu6CqUcjcZXarCbePwG+qp1mIhppeJrHR0omz
pHDwn80PzNrsKxmNE7YOzGYAhxnWTvaV68djHyXzpm3/8lz4yg4=
=Ytsm
-----END PGP SIGNATURE-----

--fqkalhwbzwhan7m7--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
