From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V3 05/19] memory: tegra: add flush operation for Tegra124
 memory clients
Date: Fri, 17 Jul 2015 12:05:47 +0200
Message-ID: <20150717100546.GJ3057@ulmo>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-6-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IJFRpmOek+ZRSQoz"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:34728 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbbGQKFy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jul 2015 06:05:54 -0400
Content-Disposition: inline
In-Reply-To: <1436791197-32358-6-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Terje =?utf-8?Q?Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>, Vince Hsu <vinceh@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org


--IJFRpmOek+ZRSQoz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2015 at 01:39:43PM +0100, Jon Hunter wrote:
> From: Vince Hsu <vinceh@nvidia.com>
>=20
> This patch adds the hot reset register table and flush related callback
> functions for Tegra124.
>=20
> Signed-off-by: Vince Hsu <vinceh@nvidia.com>
> [jonathanh@nvidia.com: Removed tegra_mc_ops and added
>  metastable_flush_reads.]
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/memory/tegra/tegra124.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)

Same comments as for Tegra114.

Thierry

--IJFRpmOek+ZRSQoz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVqNN6AAoJEN0jrNd/PrOhhEkQAITRq/7AnE9HfumycAc1CA6a
QkMRKHkzQLlta12+FsvwOEBL34QltyaQxHE0WDmv2bbzmFyQPnkpU8PA9Kimc4NH
SaqNzC9EhxEPPeOJOuNSWhDo+XVgIYPZNqp/UC35DVktC3PhduiRfQCiC/7BFCuE
4HrUYaqv+YfQhXckQNElJfsx+5zl7eyYJeJD8m2r2sQvN17ZPBKU2bP4kPyh20Kh
D487ZqKLpJQ7MJw/3kKBKXhaimA+i3ALWSGDsLTYrZ694Ah0Ye1nk1HfcUk/lwEE
Nsh5zPMTl1o27Hn6bqgi3/okqCvsXgbHUog3hW5oomuLk6U1l8A4Dys6UscD/JIQ
9XTzYQtMQHam7ArskgltOB6R8vXRPFwFZfwN/eum+ZoUkcV9OKtnrZaw/hY9c1LF
NCcg9+qOndZQZCZcGvqUTKpAF8Q3xD0FYbY163U1OXeCm5u6N1iBxEGQOntLmEyd
HNyXu2EhdG8ePpokyAIpP73ryJWyR/ykY6AXOkEkV1PNkD82Y88cGSQdLlBlp2Fm
KFJRsmsbTpa8QhMB0nL6fc26gUyarFRMu4/rdHBSid2JX0XkJ3MFAAxdoz9pfIfC
5vAb2CGeNl8FSfihnhqHMPV2Vrf1G1CzuFuZBZoqdshCdQvOj6OtHVI8z99ETBBQ
ZknrMJAtG2DJrdS4tpCW
=sqi7
-----END PGP SIGNATURE-----

--IJFRpmOek+ZRSQoz--
