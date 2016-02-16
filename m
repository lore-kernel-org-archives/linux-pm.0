From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] PM / OPP: Initialize regulator pointer to an error value
Date: Tue, 16 Feb 2016 01:56:16 +0000
Message-ID: <20160216015616.GH18327@sirena.org.uk>
References: <1455544758-7718-1-git-send-email-jonathanh@nvidia.com>
 <743509d913cbc0e725bea52281be03b009e02bb5.1455553501.git.viresh.kumar@linaro.org>
 <17646703.2nZXD4icYj@wuerfel>
 <20160216010059.GH6334@vireshk-i7>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CEUtFxTsmBsHRLs3"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:53217 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbcBPB4m (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 20:56:42 -0500
Content-Disposition: inline
In-Reply-To: <20160216010059.GH6334@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Jon Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--CEUtFxTsmBsHRLs3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 16, 2016 at 06:30:59AM +0530, Viresh Kumar wrote:

> - And so I left the regulator pointer to NULL in OPP core.
> - But then I realized that its not safe to call many regulator core
>   APIs with NULL regulator, as those caused the crashes reported by
>   multiple people now.
> - clk APIs guarantee that they return early when NULL clk is passed to
>   them.
> - Do we need to do the same for regulator core as well ?

No, NULL is explicitly not something you can substitute in,
essentially all the users are just not bothering to implement error
checking and we don't want to encourage that.  The set of use cases
where we legitimately have optional supplies is very small, much smaller
than clocks, because it makes the electrical engineering a lot harder.

--CEUtFxTsmBsHRLs3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWwoG/AAoJECTWi3JdVIfQa+cH/jRzO97INSqEf0+rYcLc/TPI
HqUkp+lqmo5dswDTRLtIhajxRL4K23uKP8Q7rxLlystsmOSjiavUs3LIcfjNkx97
/JdH3z4LwaVsUIZifb/C3q5PB6dyoqUaS9fqit06u6iGXoUAv93jtfAtrkKkiAbG
mKNvEI32c8nAbi0BSpv5c5Pw2tVVmEikI3l2EgQarkwOt+18KQZqC3ugo2kgHKgE
63ZDD10TIuDme1gYwvH+xfJ6fuhs4ptGWjYztxr1oaoYUjW0tS6i+lrPtVlKGVm9
HzIHPVjWHB0B8ql76jCChqqUUEU8A63lmyveiFPrYi073ZjJDbpL62odvvo8WuQ=
=bYWH
-----END PGP SIGNATURE-----

--CEUtFxTsmBsHRLs3--
