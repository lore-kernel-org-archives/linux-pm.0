From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 03/14] power: max17047_battery: The temp alert values
 are 8-bit 2's complement
Date: Mon, 1 May 2017 13:37:09 +0200
Message-ID: <20170501113709.vl53kwiibex7zkte@earth>
References: <20170414183259.24382-1-hdegoede@redhat.com>
 <20170414183259.24382-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jqdnxibeslj57nyk"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57708 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967590AbdEALhN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 07:37:13 -0400
Content-Disposition: inline
In-Reply-To: <20170414183259.24382-3-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org


--jqdnxibeslj57nyk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 14, 2017 at 08:32:48PM +0200, Hans de Goede wrote:
> The temp alert values are 8-bit 2's complement, so sign-extend them
> before reporting them back to the caller.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks, queued.

-- Sebastian

--jqdnxibeslj57nyk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHHeUACgkQ2O7X88g7
+ppAAQ//R7VlDVMz7C5uDhCR6WtJkxBCMlURsX/8Jf7u73J3WEuuko2uwbCfhwr7
ggXtm/YoA1Bfb1o7EZXbA3BGOELPPuCDnBM9trHr2YCcY5FkF5SIKmrDJ7OjNmmq
+XJXbjEZWJpFkzOzbTF8ClBEOSoBMb22mVKJmjtaQF1vu8/3x+UhxNWMU3b/fU2f
ZLPDfQkU0bN2SXyLdardLT5xhJt3iaYvC9ap5m4a9nzjZ0rQo+i5geROr/+XIVjm
3SHbg4ImWBtN3IbxjZ11y8IDg6ZxYhXXjTi0wJE7N+40fNSHCLqQTqoF7VlRGAYb
FlvlvSSo9KZ1PUbzhKCf1LLta/Y1kE8goeyvsh5P4wjeHCCktp+9usX8ff37/LD/
H8Ql/Yy32o1j0wp/wnUb/ai6lAQFSau53aW7bAGhV6rQShgyL12RKVh78Mae4AD1
ABZ5XjMNkgE3upm/aA2g7UGu0Z21b71Ksj3YEFhNX5cQMyGSPdj9mNRba2lRg8er
W6gKsylnUubRbK6+3DwZkRqB2hMTEBULPy5PG2/vpkyAkco78R9atgb6wAIAmeFE
w/nH5ApeXLGNP4mhgg2OJhXt/WKwjzn4m1D+RBXRkd8ZpKK3kaCnOQo2tMEq4yy2
pnOKbd4Z7qpMIWYjPQGPT38qv6HNxlkkc8cN+8EgsN31ABXja2A=
=6O9e
-----END PGP SIGNATURE-----

--jqdnxibeslj57nyk--
