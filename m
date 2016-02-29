From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V6 10/10] ARM64: tegra: Add audio PM domain device node
 for Tegra210
Date: Mon, 29 Feb 2016 08:30:09 +0100
Message-ID: <20160229073009.GJ23745@ulmo>
References: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
 <1456501724-28477-11-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tKy6e3LXpfmanBFM"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37766 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbcB2HaW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Feb 2016 02:30:22 -0500
Content-Disposition: inline
In-Reply-To: <1456501724-28477-11-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org


--tKy6e3LXpfmanBFM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 26, 2016 at 03:48:44PM +0000, Jon Hunter wrote:
> Add the audio power-domain for tegra210. Note that this also removes the
> existing "#power-domain-cells" which was incorrectly included by
> commit e53095857166 ("arm64: tegra: Add Tegra210 support").
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>=20
> ---
>=20
> So far I have only added the audio power-domain for tegra210 as this is
> what I have been testing with to date. However, once this series is
> accepted then we can begin to add more.
>=20
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

I'm slightly reluctant to apply this, since the domain isn't used
anywhere. I'm assuming it will be used by the audio driver that you've
been working on, but if that's not going to be merged this cycle, we'd
end up with an unused label. Not that that's invalid in any way, but my
rule of thumb has been not to introduce labels until they are used.

Therefore I suggest we postpone this to the series that adds audio
support.

Thierry

--tKy6e3LXpfmanBFM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW0/OBAAoJEN0jrNd/PrOhIe8P/2JF2h+IvQ0KK1HTEIHVifjU
PXdDwwUTexXdeeKjSUVtQLuDrUuXG2wS0yOC8bq0Wx8DaiLTvi6tmpADDNm5vUWx
F66saIskmbl5GEo4ihDl/UgYYP2QOmcHOeMuLQeL6AfXUjWNwWoBZi811PtjSs73
gZhJN6Va2+Dl14CnE4yvlk4oGVvtMOsfLW/mxJO0mZSrvOis4hOIqw4nNSKI2tMv
hY6FjtFV+UawkljYxapiV3z5jAm9L4GQFt/yEbUnY7QQcjJkvbtJYyPmXZEi12ED
Fe3A7hOOaenyTQ/ARN5QM32HXeAmV3h4Ng/E864wNuH1O4AET9mK3qp1vICea3p2
bpGZxGWmn7wu3sOqyYLHweDsBh9ibuCshqaj++QefoWC6WcrWa1an3Kj7FIpCOzG
Wi6CrfGX5CNgmXz7YfrH72+itQK6oDg+eeUsfV/Xsl6GXqEV1tqXnXOcEKXtmqDV
IK6H+aUOHT/r0LTTrbczQVNKe5ens5Cs5kWNGIB2QknoDJ4FKJLwj89oSoSc8pY3
8gfiLrg6RPW6w9uJF1rATHFB+V9CP6HDCbONy+AlOVjLhCJvYX7gJsMPZj4XquFy
oamx3PqKaQv9uj/QHYHR9VT1HIcmYzRiq+M4Y54cIXIbvoNuVFkyz1PPwYMgrZM6
YzImLA6nSRBqoUETUXLu
=kQyj
-----END PGP SIGNATURE-----

--tKy6e3LXpfmanBFM--
