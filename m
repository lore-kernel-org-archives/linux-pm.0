From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RESEND v2] power: reset: keystone: Enable COMPILE_TEST
Date: Fri, 15 Apr 2016 16:27:52 +0200
Message-ID: <20160415142752.GC24087@earth>
References: <1459298988-20530-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459298988-20530-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 30, 2016 at 09:49:48AM +0900, Krzysztof Kozlowski wrote:
> Enable the COMPILE_TEST to get build coverage, except on platforms
> !HAS_IOMEM (required by selected MFD_SYSCON).
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Thanks, queued.

-- Sebastian

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXEPpoAAoJENju1/PIO/qaVJAP/A8595OGtmHyve252cFs5oXf
U9yj2iyfNpB0PRYglXZRuul6VU4FWH7TNIe35IrXbV9uy6R7P9yrpo9sym4uBFlm
gRAAilZ43hJazPnUiOyDkS5UR3mW2m2xIN5493nqybvWBRzJ45PuYS9Wo5YkiVVy
mMRZy/TW4O98O3+kOiptR0+iasojIngTEVGS1EH58TyBe3SRtMHdXiaVgYb6sEQX
JIi13uMjDN27hNdSjheiL1pMILTetfsPxeXHhQxD98N3WSKMz2tRh+lBT69x6g45
bvVroc+yPncSDyjtmfaP5ixiNwWwxubL9pEz5gpZC1ZM4NPi5/4LUTg/nF57C6/d
pTmjZ93ciwxDZsDcRZq/j6V4FaX43Zl6mGdA31P1fCMDGamgY2IJBG3Lk8aaCjSg
5J+MBXUHlTPpUmTekfv5dH5XH0Mgxp9XwtXL1eOS86uFj+9Z++psrRk9Qr9XoCs9
UKLDN6z9SM7vpyzUcBwHulT+dwDYutn6MIOV+2SYYWOlXLyXdiChMpJ6qR14hmRV
fEnoPYif/KZv7h5JBP71AWbGBdZ9UhXuwDEC6dO5aBBcPwsGbAI8PhkE4D3ZghtC
fx3sjvf+VU1l5ZzqZeNfu8aAPcuso3DnRkNvqn8TgBiiD6w/lhurEfo/ScfvNvYI
FBRP2ZfMGNZ1j5ofA+L0
=+AYC
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
