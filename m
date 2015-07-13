From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2] power/reset: zx: Register restart handler
Date: Mon, 13 Jul 2015 14:00:19 +0200
Message-ID: <20150713120019.GB9128@earth>
References: <1436171730-21175-1-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38210 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098AbbGMMAY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 13 Jul 2015 08:00:24 -0400
Content-Disposition: inline
In-Reply-To: <1436171730-21175-1-git-send-email-jun.nie@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jun Nie <jun.nie@linaro.org>
Cc: haojian.zhuang@linaro.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, shawn.guo@linaro.org, wan.zhijun@zte.com.cn, jason.liu@linaro.org


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 06, 2015 at 04:35:30PM +0800, Jun Nie wrote:
> Register with kernel restart handler instead of setting arm_pm_restart
> directly.
>=20
> [...]
>
> +static void __iomem *base;
> +static void __iomem *pcu_base;
> +
> +static int zx_restart_handler(struct notifier_block *this,
> +			      unsigned long mode, void *cmd)
> +{
> +	writel_relaxed(1, base + 0xb0);
> +	writel_relaxed(1, pcu_base + 0x34);
> +
> +	while (1)
> +		cpu_do_idle();

mdelay(some_time);
pr_emerg("Unable to restart system\n");

> +
> +	return NOTIFY_DONE;
> +}
> +
>
> [...]
>
> +static int zx_reboot_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np =3D pdev->dev.of_node;
> +	int err;
> +
> +	base =3D of_iomap(np, 0);
> +	if (!base) {
> +		WARN(1, "failed to map base address");
> +		return -ENODEV;
> +	}
> +
> +	np =3D of_find_compatible_node(NULL, NULL, "zte,zx296702-pcu");
> +	pcu_base =3D of_iomap(np, 0);
> +	if (!pcu_base) {
> +		iounmap(base);
> +		WARN(1, "failed to map pcu_base address");
> +		return -ENODEV;
> +	}
> +
> +	err =3D register_restart_handler(&zx_restart_nb);
> +	if (err)
> +		dev_err(&pdev->dev, "Register restart handler failed(err=3D%d)\n",
> +			err);
> +
> +	return err;
> +}
> +
> +static const struct of_device_id zx_reboot_of_match[] =3D {
> +	{ .compatible =3D "zte,sysctrl" },
> +	{}
> +};

Where's the DT Binding Documentation?

> [...]

-- Sebastian

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVo6hQAAoJENju1/PIO/qa24cQAIZP1afm8saDvcZk80o+axMm
6AwYKAUlOGlpb41EprRdDcRBCvfey0KuPvsOm13lzIMthyIvJmtzzJs3162InUv9
V98qaYXmzNP9Nah/rZe2ldM2HwJvcn9q7zJHkq/TwEx9eDKzwAzdyg/ja1uC3geM
xNuzgodF4c/WlUF82ISpmeaMbGQuaJsWWDsdD2tjGYKZi5G4tzJgjv1qddyql5fR
Kb3ZlzbSTIl7sNxhzwEx1KnI6IYg8NEmqp22s4rmEv1oyjzgLZZehPOOcTl0tPqZ
73I/zOZO1koRiLRmRJxFtjHoS9+iJ57isSPh1MeMqVqIAFh8JuF/pKCVZ3w0eVPd
i3wrx9EbNd7PRCK+pMFC4qvUh9cUv37TMfyru3eIyqbwfjAtZ+Bdl2PaYlyiJOL/
SF+4dsXKjEn+gRmU5bougwWC7pKH8NlvIvSe/TAz3odZXYl1a/pbeVBAEBqV4BVa
nsrONe26ffh8h2rSAYoGrZ5TVfTOb8S9XraxtlNVgwJ+Oz6pK4yO3ADeWNSLsMUP
+hknU+lD7k2Fdz70bW4RgSzJaERXOydNJOiJUiIMh3tdngzx5KViTFHSyIPW/QD0
NDn9Rcb6MZWfYFYx1vuYe1fb8bLvJqGE3LMVGTKE2J0QJCL23+JJ79ZJlLc/pUpJ
FWwS1FzTxXU3Ink0B0O4
=zrYZ
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
