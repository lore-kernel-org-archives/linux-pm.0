From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] PM / Domains: export __pm_genpd_add_device symbol
Date: Tue, 17 Nov 2015 16:56:46 +0000
Message-ID: <20151117165646.GU31303@sirena.org.uk>
References: <1447775249-26252-1-git-send-email-Maruthi.Bayyavarapu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XSEVMyPRvc8xgDhM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447775249-26252-1-git-send-email-Maruthi.Bayyavarapu@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
Cc: rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--XSEVMyPRvc8xgDhM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2015 at 09:17:29PM +0530, Maruthi Srinivas Bayyavarapu wrot=
e:
> Drivers which can be built as loadable module needs symbol
> - pm_genpd_add_device to add devices to genpd.
> Those drivers create platform devices, which comes under a powerdomain.

> +EXPORT_SYMBOL_GPL(__pm_genpd_add_device);
> =20
>  /**
>   * pm_genpd_remove_device - Remove a device from an I/O PM domain.

Don't we also need to export _remove_device()?

--XSEVMyPRvc8xgDhM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWS1xOAAoJECTWi3JdVIfQQlMH+wccfE0yq/NjOSP0/7EEP7/U
SyBcoC+hqITtB6YyvGbG4Sf23zGuNIrkLfvfn/FKjxrp668LAh542HVNK6klGtbg
22eiXaTr8y7KCwDOMCJDs/hN4hd1bvxUFZqlcMWrJEm9bjQDS9GnJxZYrB5jccE2
2y4gLdXc4kjZkTQJNoerHRMnn1rsnkLFOpNToFlL3qRwBNfcPehx9cfewxi7x3AK
0t3wTxKfeZAmMUh0QByZ9tyWDyB/EWRHs65laYJOpyVBYbNZL3BGuaGzzjkchj55
vaQ5lsqniunxqVTttqaIz2lDN11GmHZBViY9TT//ZJZNB7quOakGsTaFOu8KX74=
=7Jr4
-----END PGP SIGNATURE-----

--XSEVMyPRvc8xgDhM--
