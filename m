From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V3 02/19] memory: tegra: Add MC flush support
Date: Fri, 17 Jul 2015 11:57:55 +0200
Message-ID: <20150717095754.GG3057@ulmo>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-3-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hcut4fGOf7Kh6EdG"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38506 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757252AbbGQJ6D (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jul 2015 05:58:03 -0400
Content-Disposition: inline
In-Reply-To: <1436791197-32358-3-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Terje =?utf-8?Q?Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>, Vince Hsu <vinceh@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org


--hcut4fGOf7Kh6EdG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2015 at 01:39:40PM +0100, Jon Hunter wrote:
> The Tegra memory controller implements a flush feature to flush pending
> accesses and prevent further accesses from occurring. This feature is
> used when powering down IP blocks to ensure the IP block is in a good
> state. The flushes are organised by software groups and IP blocks are
> assigned in hardware to the different software groups. Add helper
> functions for requesting a handle to an MC flush for a given
> software group and enabling/disabling the MC flush itself.
>=20
> This is based upon a change by Vince Hsu <vinceh@nvidia.com>.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/memory/tegra/mc.c | 110 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/memory/tegra/mc.h |   2 +
>  include/soc/tegra/mc.h    |  34 ++++++++++++++
>  3 files changed, 146 insertions(+)

Do we know if this is actually necessary? I remember having a discussion
with Arnd Bergmann a while ago, and the Linux driver model kind of
assumes that by the time a device is disabled all outstanding accesses
will have stopped.

Do we have a way to determine that this even makes a difference? Can we
trigger a case where not doing this would cause breakage and see that
adding this fixes that particular issue?

Thierry

--hcut4fGOf7Kh6EdG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVqNGfAAoJEN0jrNd/PrOhfSIP/2GokJxt6q4xhScox9PHM2+H
vX8uyfBHo4U3jx494uJ+AWvl0TORJ8/0J8PmLIbdi6TIeH5+cLG88qbaQslP6fpv
rnxf+4Ci8Vnidd2jZ4+an2dP9u+EyDeXgf9P/fRmbHaeMJf6rvJRuDRIqcsQ5HnL
0mzjEDn3J5S9yZTKC0EQPX4vYuRzVMdVkh0GXEi3sAkH6IFDpBMde/or9jJyqOHO
H4ulIIrLQBsoERbwabguASDcFPejmx68/6HwDY3m21BNy37OkTRW6DyCMki0x/Un
lzJfIdrCo/QZMjn3vzR/eQBZjdJeCobzNkHmC3jm/Ed8cH2MlcBViqrE9Gmn+SGT
IpSgxE7Cj468yt5erBctRz0aWVehtBirTPGWwJnUSnhYDgDVfAhS9kPqHucb/miA
sNKqYCPm55ZqnYxXU7wwNITPYs4lUMgXvkl1shsmSIqxAA0z7DSrnbLZ3lukYlw1
LGxr7N6mLW9tCSes1cC7HyZ7bfTdxCDqVdfdLH1Q7QHrX0+mfnumSaUyjNEW9JTG
G0w4l9O9Pgs/6eGyBAY+JQU+PH0Ogm579A1HSTg238CdkPZoDHat0SBYZKbh4PND
eutu5UPrhNh1NzlO5zGRyUO+bV/DwE4THYkXBGVcDyvoe/5VJEPJEsDujGzQlCgW
yG8aFjXm2sYu83htqlxj
=4TS/
-----END PGP SIGNATURE-----

--hcut4fGOf7Kh6EdG--
