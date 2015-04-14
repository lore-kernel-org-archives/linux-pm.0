From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v8 00/18] Tegra124 CL-DVFS / DFLL clocksource + cpufreq
Date: Tue, 14 Apr 2015 16:43:41 +0200
Message-ID: <20150414144339.GA30495@ulmo.nvidia.com>
References: <1425213881-5262-1-git-send-email-mikko.perttunen@kapsi.fi>
 <20150311100741.GK19577@ulmo.nvidia.com>
 <20150410211157.14369.51754@quantum>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33566 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753637AbbDNOnq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Apr 2015 10:43:46 -0400
Content-Disposition: inline
In-Reply-To: <20150410211157.14369.51754@quantum>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@linaro.org>
Cc: Mikko Perttunen <mikko.perttunen@kapsi.fi>, swarren@wwwdotorg.org, gnurou@gmail.com, pdeschrijver@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, pwalmsley@nvidia.com, vinceh@nvidia.com, pgaikwad@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tuomas.tynkkynen@iki.fi


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2015 at 02:11:57PM -0700, Michael Turquette wrote:
> Quoting Thierry Reding (2015-03-11 03:07:43)
> > Hi Mike,
> >=20
> > Have you had a chance to look at these changes to the Tegra clock
> > driver? If you're fine with it, I'd like to take these patches through
> > the Tegra tree because the rest of the series depends on them. I can
> > provide a stable branch in case we need to base other Tegra clock
> > changes on top of this.
>=20
> Hi Thierry,
>=20
> Clock patches (and corresponding DT binding descriptions and changes to
> DTS) look fine to me. Please add:
>=20
> Acked-by: Michael Turquette <mturquette@linaro.org>
>=20
> I did have a question about the beahvior of clk_put in one of Mikko's
> patches but it should not gate this series. I'm just trying to find out
> if we have a bug in the framework or if the Tegra driver is a special
> case.
>=20
> Also I do not think a stable branch is necessary.

Given how this didn't work at all for v4.1, why don't we try to do this
the conventional way for v4.2? What I propose is that I collect all the
patches that I've had in these branches into a single branch that I can
send you shortly after v4.1-rc1. Then you can pull that into the clock
tree when you're happy and I can pull that into the Tegra tree again if
needed to resolve dependencies.

One problem that I foresee is that the EMC clock driver relies on some
symbols exported by the EMC driver, so it will fail to build on its own
if merged into the clock tree. Usually I'd say we can solve this by
merging a stable branch from the Tegra tree into the clock tree, but if
any of the ARM SoC maintainers then decides that, for whatever reason,
the Tegra pull request isn't good enough, you'd need to either redo the
clock tree or we slip in the changes via the clock tree anyway.

Perhaps a solution would be to implement stubs for the API exposed by
the EMC driver and merge that through the clock tree, which should give
us a tree that can be built but be a no-op at runtime. Then we can add
the actual code to enable EMC scaling in the Tegra tree by providing a
real implementation. That way we only have the Tegra tree depend on the
clock tree.

How does that sound?

Thierry

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVLSeXAAoJEN0jrNd/PrOhjDsP/27ccjBHE2q8PxIKRWfrKu3k
oRLRgpPrg/0e9VHlPCShN+EiGYhOsdPggbKnLBa4q0yBKb/mImpXedfQbLSEKw01
SIWxEw8g/ChXBdx9C81cJ6IQIP14uru3QaGB+i6DVCsmzbB9SFVym1IgmhAYFpg7
aED105ZF0GpHoZPPSaJBcEA6tjdZS18O8yD8JPuVqZMmSpPnswBj9BmqkJDCsia8
j01HbYdlzntEE5p7CvJAvBtF4oyO6BtCj60ZKDHNn7DGx9Azkr3FM8xgibyd/3qK
4gIjcXGsjZ/SalUNHsJ5UaAZLEw749txmbpUsaXF303KOf+p91MEp52jmuI/fmFl
uAp/2WlRcRyor+z2vkGf78vpOFtUcuXVDEstJd/JR5Kb/NwxlZEY1HSp0oQGdRMV
B48ijHgFG0lcCzsOb1PdeCUlkRnkS5gEWfGhzBaX2XqASUke+KQ+UAshn7usJ8tM
cJFchaBL7cFoGlzOE1rXZ12zA1tDcSMW9MdiBBuEzIjkkYJ78+uluiceuA2cpRbg
Snaft/Y/Oo95AMB3d89t3TkO6dISt36j32EeaJMZdQAGOf6c/SbnAWwbLgyCoji4
U/bFBoZyskvLmMsxA8//NOYoyzExHrztaCF+Oo9tU0nc7UUFxP+i5pKc5TAOkyIM
5Zb1VtHwxrr3nZGNZhKw
=Ei45
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
