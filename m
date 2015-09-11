From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] clk: tegra: dfll: Properly protect OPP list
Date: Fri, 11 Sep 2015 13:35:34 +0200
Message-ID: <20150911113531.GA16323@ulmo>
References: <1441893321-4563-1-git-send-email-thierry.reding@gmail.com>
 <20150910175144.GB15099@codeaurora.org>
 <20150911023527.GS5266@linux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150911023527.GS5266@linux>
Sender: linux-clk-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Alexandre Courbot <gnurou@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, Tuomas Tynkkynen <ttynkkynen@nvidia.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2015 at 08:05:27AM +0530, Viresh Kumar wrote:
> On 10-09-15, 10:51, Stephen Boyd wrote:
> > Don't we already have an rcu_read_lock() at the beginning of this
> > function? I don't understand why we need to nest them in the same
> > function.
>=20
> +1

My bad, I wasn't looking closely enough. The second hunk can be dropped.

Thierry

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJV8ryBAAoJEN0jrNd/PrOh+KQP/2aIuBcTDy14pEduRd8+uCQo
MrBUvw1C1PO0GiZXiNPGQzaDDs/3O2NnV9gs7oZo73AjHbLpeadjWiVx99b3etjm
c5YlFdbyk34yhUdkw0us/Ux6W9bQKNhIl+TLiBtRjibYEYnv069Iv2iu4a8EJkVI
PYH50CdpEBXsB71bfmAmV/gM8kB+wTirZfrAx7Esa6+hFvoHoxSGM2wicRFWb1/Z
xuOo2ImWdEfs9Gyqg/Vn5dmb6aXQXdCKuujepnSLeCMwbN0tsFyd8hx6vqxeHGmG
wEt/3hVXXNGEUyhgGHjdPsvJOwRlNbiKBcx6M3jyxe5M8KcKjbKovOqaffJS+nWz
FIcfveK52OttVf3SD8Hsazng2P//Ro9VyZLq+egJyRvPbfSk0DCGgFQojCf/GZqJ
fPVpWsO4eYPqLxnr+fa4AklCdj2ySe9G89QexLlIw/J44qqBg50uKzoJLQIOMQMf
h+uV6GTA0sS6IBt+wsS/MyQd3PzOMLKvzFBNX1ZmupSiEUwKGzqhulGqC/CwpcmB
8lvCzuV7dDZr9OqylCVwxLqmBENF1UEzY8Ng7m4pOJ0Wemc+TGHEOKs6pyYz18hu
KqH//wZHfzPEWgil736s0YD3CCuitKdkUENCwPtbD1TWsjGtgr7O7r+AqoXkGhqD
yax2xlK7OEMfzA82U2fs
=9/vW
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
