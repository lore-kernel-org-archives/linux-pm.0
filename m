From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Thu, 7 May 2015 12:02:33 +0100
Message-ID: <20150507110233.GR15510@sirena.org.uk>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <20150504121209.GM15510@sirena.org.uk>
 <CAKohponRXiWbgT26=tO83jJgbteBf38ggE7mKvLCv+wFMW1cvA@mail.gmail.com>
 <20150505105714.GA22845@sirena.org.uk>
 <CAKohpo=09ZhXxh5Cm7Ww9Gy-AYRp9=j82tup6atVN+aOF8twdA@mail.gmail.com>
 <20150505171252.GI22845@sirena.org.uk>
 <CAKohpo=kJs076afzERPMqjELgwpN6nR2yoyEjW6XY7YSEbRuCA@mail.gmail.com>
 <20150507055231.GB32399@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="licyFknwe5IHJaJi"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:54444 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbbEGLDB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2015 07:03:01 -0400
Content-Disposition: inline
In-Reply-To: <20150507055231.GB32399@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Rob Herring <rob.herring@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Nishanth Menon <nm@ti.com>, Mike Turquette <mike.turquette@linaro.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, "olof@lixom.net" <olof@lixom.net>, Sudeep Holla <Sudeep.Holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Viswanath Puttagunta <viswanath.puttagunta@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Abraham <ta.omasab@gmail.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kevin Hilman <khilman@linaro.org>, santosh


--licyFknwe5IHJaJi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 06, 2015 at 10:52:31PM -0700, Stephen Boyd wrote:

> If you look at the cpufreq/clock/pmic code on our codeaurora.org
> tree you'll see that it's used to pass a value with uA units
> through the regulator_set_optimum_mode() API. The call to
> regulator_set_optimum_mode() is here[1], and the place where we
> parse the OPP table from DT is here[2]. My understanding is that

I'm not looking for anyone to explain this to me in e-mail, what I'm
looking for is for the binding document to be clear so someone can tell
what the binding means by reading the documentation for the binding.

--licyFknwe5IHJaJi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVS0ZGAAoJECTWi3JdVIfQe3cH/3O1Wd+4JIBVbJWoc/3q/yiw
uEj28NlVWpcMHsyxL0XceY+MhqWlwBuWJquqBbZH0A9z7aDDLCbwbEpYmJ8QUkOm
BkfYFrkzkGq0IjLTwc/Ne/u8iBHw4ygkTi8povYd6+qwyFRJ2HWTGMXPd/HjyZTe
c+fHgpdDAo9uXAZvc32vE8xzphnX7GuhrHO9LfqZSwH9jdBudNJ6KIwm7Xgj9YVa
qmsxrqbp7EpiZRgYdhPUrAjOYq4EHf1WZPeq/qAjLWp0DsBQ5tKTDAIz6ps3IL6u
4dQipQayQyWPdy3wXdf052biMWh2t5XEVO/qEeS9O8LrLXe/vO78DcTGUhK5a0g=
=392P
-----END PGP SIGNATURE-----

--licyFknwe5IHJaJi--
