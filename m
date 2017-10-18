From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH/RFC 4/5] regulator: bd9571mwv: Add support for backup mode
Date: Wed, 18 Oct 2017 12:02:38 +0100
Message-ID: <20171018110238.hjv7huiievhr5obs@sirena.co.uk>
References: <1507649178-31473-1-git-send-email-geert+renesas@glider.be>
 <1507649178-31473-5-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zapjcrzcces6oi4c"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1507649178-31473-5-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: Marek Vasut <marek.vasut+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--zapjcrzcces6oi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 10, 2017 at 05:26:17PM +0200, Geert Uytterhoeven wrote:

> Backup mode is not enabled automatically, as e.g. on Renesas
> Salvator-X(S) boards enabling backup mode changes the role of the ACC
> switch from a power switch to a wake-up switch.  Hence enabling it
> prevents the board from being powered off using the ACC switch, which
> may confuse the user.

This sounds an awful lot like the standard power/wakeup, though the
power change is a bit unexpected there.  I'm also wondering if it makes
sense to just only enable the wakeup mode when suspending which
preserves the power off functionality while also keeping the wakeup
support.

--zapjcrzcces6oi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnnNM0ACgkQJNaLcl1U
h9DF1gf/Y+ciNkMOKMiwWYRyVf3P/Uud6ZaqmTpZ9HSnGSxCClelttJ83ycD5apN
qKCt8WT9yn08Sko5sKLjVIWe9vRR/iRyKQQ4nl2XgEiNLdmIVJxVc2gH79BirhsT
nf23fFI9D9nLTroAjLDFH6FV9uZKHYqwQIWjQzrkmBF+OVXuDg/LnBPmLdyYNxcn
QKw9VFFcOLmiEBvyL6fV6HPaHDd9QK01fzcTWfqeT88dxJM5Xf6dHbfXgGe+QagP
u3lgtYW711xrIqMbLVsz5Fc7o1w1aiDa61u/+genCPGo9PJEk3LbQCNEhbUNNEnf
Hn9WeU6Hlg5609xD/TX9qXsEftTMlA==
=1+yz
-----END PGP SIGNATURE-----

--zapjcrzcces6oi4c--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
