From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 6/8] regulator: core: Add regulator_is_bypass function
Date: Fri, 24 Mar 2017 12:55:06 +0000
Message-ID: <20170324125506.5cxiykpq2tzzkltb@sirena.org.uk>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
 <e74c2f4d2b452cbe01aa2a48edde5c024212ffcb.1490199005.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mxjbbgni576g7z4k"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e74c2f4d2b452cbe01aa2a48edde5c024212ffcb.1490199005.git.leonard.crestez-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Robin Gong <yibin.gong-3arQi8VN3Tc@public.gmane.org>, Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>, Irina Tirdea <irina.tirdea-3arQi8VN3Tc@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Octavian Purdila <octavian.purdila-3arQi8VN3Tc@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--mxjbbgni576g7z4k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 22, 2017 at 06:53:08PM +0200, Leonard Crestez wrote:

>  /**
> + * regulator_is_bypass - Determine if the regulator is in bypass mode

Bypass is a verb so this should be regulator_is_bypassed()

--mxjbbgni576g7z4k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljVFyoACgkQJNaLcl1U
h9Cp4gf/amxDv6E7U6vF/bSis4X66YACCr46vlRbpd1JmHhuCUMkZCWo6WHq384O
AHOp0BzJsAWQ383h5U7zNPOfS+zhAiH9x99T1ZITRHkUWXH6QuISoqAjMb6lsI2N
Y/kC7iY+FIilp+U5qPy5XIUj2aishnNKd2tq69HKHnsEHBl1Lxua1PwO7Kc3ZDWx
iAXrS4F6eJINhEDlQji//mSYsHb91vCLlfnQD1QKvNCs7+SAgZGJ9rIbgAAhBdyo
t/OKQxu0g4UJKEg0TpEy9Eq6vkSRLlXI744njppaVOzflITDbxw8eu8r0zQ5ScVK
fSv5M920sFZMXgbqhzz8cXJj/WhU5w==
=45TB
-----END PGP SIGNATURE-----

--mxjbbgni576g7z4k--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
