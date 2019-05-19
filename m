From: Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH V2 3/3] soc: fsl: add RCPM driver
Date: Sun, 19 May 2019 23:38:44 +0200
Message-ID: <20190519213844.GH31403@amd>
References: <20190517033946.30763-1-ran.wang_1@nxp.com>
 <20190517033946.30763-3-ran.wang_1@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OpLPJvDmhXTZE4Lg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190517033946.30763-3-ran.wang_1@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ran Wang <ran.wang_1@nxp.com>
Cc: Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--OpLPJvDmhXTZE4Lg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> +
> +struct rcpm {
> +	unsigned int wakeup_cells;
> +	void __iomem *ippdexpcr_base;
> +	bool	little_endian;
> +};

Inconsistent whitespace


> +static int rcpm_pm_prepare(struct device *dev)
> +{
> +	struct device_node *np =3D dev->of_node;
> +	struct wakeup_source *ws;
> +	struct rcpm *rcpm;
> +	u32 value[RCPM_WAKEUP_CELL_MAX_SIZE + 1], tmp;
> +	int i, ret;
> +
> +	rcpm =3D dev_get_drvdata(dev);
> +	if (!rcpm)
> +		return -EINVAL;
> +
> +	/* Begin with first registered wakeup source */
> +	ws =3D wakeup_source_get_next(NULL);
> +	while (ws) {

while (ws =3D wakeup_source_get_next(NULL)) ?


> +static int rcpm_probe(struct platform_device *pdev)
> +{
> +	struct device	*dev =3D &pdev->dev;
> +	struct resource *r;
> +	struct rcpm		*rcpm;
> +	int ret;

Whitespace.

								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OpLPJvDmhXTZE4Lg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzhzOQACgkQMOfwapXb+vI6ywCfVCMHtkjXb3a+eeg4lf0cWVnK
ltAAn0s9Rg5VoedxYnGb5y+G2Eo0Kxic
=n8eU
-----END PGP SIGNATURE-----

--OpLPJvDmhXTZE4Lg--
