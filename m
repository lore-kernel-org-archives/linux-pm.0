From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH V5 5/7] ARM: sun8i: Use - instead of @ for DT OPP entries
Date: Fri, 21 Apr 2017 09:35:56 +0200
Message-ID: <20170421073556.wg7txb6q6ddng2yb@lukather>
References: <cover.1492685450.git.viresh.kumar@linaro.org>
 <2eb4a6e227f7edfb51ebf3723d5df7e652c703b4.1492685450.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eiido53kagollhar"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:37029 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036001AbdDUHgI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Apr 2017 03:36:08 -0400
Content-Disposition: inline
In-Reply-To: <2eb4a6e227f7edfb51ebf3723d5df7e652c703b4.1492685450.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: arm@kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, Krzysztof Kozlowski <krzk@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org


--eiido53kagollhar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 20, 2017 at 04:25:09PM +0530, Viresh Kumar wrote:
> Compiling the DT file with W=3D1, DTC warns like follows:
>=20
> Warning (unit_address_vs_reg): Node /opp_table0/opp@1000000000 has a
> unit name, but no reg property
>=20
> Fix this by replacing '@' with '-' as the OPP nodes will never have a
> "reg" property.
>=20
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Rob Herring <robh@kernel.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--eiido53kagollhar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJY+bZcAAoJEBx+YmzsjxAg+ZYP/1ZJpPWHTvsiNzZo1ndQyoPl
6rG65QtNlwW3me7/a+BEdqp3CcMkj8agU/HLbGwPCwAIGkhCuf54z16pBQzo0i6k
3/rxUPXeOD86vuXEDuzszav50bUxCw/cesX/zZi+akCwCvgkZfHxgZSzvjLA+36W
wny2QcVg+1LISJkqNqG5sBf+QMudslqBjjIszzSPADZmZEHOax6S4NTHxjgWg608
cTWfEy4S6C3w8FgKTwUbrZMOxOWR2AGgtvnlwA6Uh/a2mGtqPZk5hksi35pdkuAy
YWU4O0jnXgp6lcuswWTgcCAJKXNTNWY1JRSIc4v1lbj/FCEzoBfKqUzIZp89kpHy
NBHvyCoC0Yrx+qCRe+i+77+LTI3Pa8G3HFz5PLmGaccbSvtY0SgrlelmTf4wbQpO
FwD54AGXhBa5JAcXLh4iB1COcJuvNJPqmh4P4upFW1eo/LUA0h0cw4nYuZPHBnzg
v9ZEbdn65yerOR2M9fPknMOBjdarblk4Iuiw2XQ9n5TKs3eMHASNzhMy3JmjlATs
Bm3+/hyumg+9eyGkRgM5FHBdLXeiRa2DLHZ4ZnWPfri6owjDZY/4C9PC5wG/GQSZ
Xi8sjAeCDuPlFVnrRVBxxgX+uVwG08sedQ1o/TIvalHi/TjE0psZc41T7akvnQeb
3QH/ZTnb8OUNT1in5XcL
=1O9K
-----END PGP SIGNATURE-----

--eiido53kagollhar--
