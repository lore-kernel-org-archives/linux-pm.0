From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] PM / devfreq: tegra: Register governor on module init
Date: Mon, 30 Mar 2015 17:08:30 +0200
Message-ID: <20150330150828.GA18428@ulmo.nvidia.com>
References: <1040887254.91981427710975821.JavaMail.weblogic@epmlwas08a>
 <1427720078-28836-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1427720078-28836-1-git-send-email-tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 30, 2015 at 02:54:38PM +0200, Tomeu Vizoso wrote:
[...]
> +static int __init tegra_devfreq_init(void)
> +{
> +	int ret = 0;
> +
> +	ret = devfreq_add_governor(&tegra_devfreq_governor);
> +	if (ret) {
> +		pr_err("%s: failed to add governor: %d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	return platform_driver_register(&tegra_devfreq_driver);

Shouldn't you remove the governor on driver registration failure?

Thierry

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVGWbpAAoJEN0jrNd/PrOh1kIQAI90FcZyPJLdpfehccV+ABid
nuVXlO1cMxvEF1Y/jdC3EGb2PXJ3oKWAyttBWYVjGZ48SxBAboAcOY0bAPWep/Sr
fXg9eTkPzcHsxilR2tKxct0XTQSeAq4M3nPyotyt5V9zQWA7rHvH6aXXzNz3pqTg
aIQj2jpKEmL2t17eHDddCVdsW5YTjq2UqnZIwHHAC9GiPBiPJbrDV4LZHmP9Ghfy
vZYClnuScGnC3cFBvgPZK/Ib/YotNaBPscUPipmtlxaJPB1e/avypLLg6LsVNrYT
OBNUQeGiVSZ0vJVwnDCPKCO9hds1SyBXzkr7KpPq1ECc2mdMNdl2gqb/KeOQGgiF
1xvULOkdcnIqouUBMovfbYLoiXZkM7zyu7mE+K76t99Y0jHjrN6eluslCIUrOxlA
mqp0jfp7aoJM+ZURFJoUJrwHYp6djsgtm9gnbbHP233HD8U6UHKC3qerndSCCYnH
4rfBHgW4oDbcD1HEd2GxT8f6gFiLX2H4tJ2PU1S9bov392adwWtG426/xQQXyDT+
T62Ep3Wz9FmtFidkSmjHeiUep7m4eCv+pRFBhudF4rxHffbljniYBG5yK/44ghXQ
jvyGHckYTEaQQq23lRILT4qp/eFlFTchu7wmgyVd49TWUOKKzJ+xw0yNE7C3605r
I31HSQwu+Kjq/JDAjmRX
=j47x
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
