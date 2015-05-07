From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Thu, 7 May 2015 23:18:42 +0100
Message-ID: <20150507221842.GW22845@sirena.org.uk>
References: <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <20150504121209.GM15510@sirena.org.uk>
 <CAKohponRXiWbgT26=tO83jJgbteBf38ggE7mKvLCv+wFMW1cvA@mail.gmail.com>
 <20150505105714.GA22845@sirena.org.uk>
 <CAKohpo=09ZhXxh5Cm7Ww9Gy-AYRp9=j82tup6atVN+aOF8twdA@mail.gmail.com>
 <20150505171252.GI22845@sirena.org.uk>
 <CAKohpo=kJs076afzERPMqjELgwpN6nR2yoyEjW6XY7YSEbRuCA@mail.gmail.com>
 <20150507055231.GB32399@codeaurora.org>
 <20150507110233.GR15510@sirena.org.uk>
 <20150507211855.GA2455@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+E8tZd0NUIRz5HKc"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:55309 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbbEGWTF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2015 18:19:05 -0400
Content-Disposition: inline
In-Reply-To: <20150507211855.GA2455@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Rob Herring <rob.herring@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Nishanth Menon <nm@ti.com>, Mike Turquette <mike.turquette@linaro.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, "olof@lixom.net" <olof@lixom.net>, Sudeep Holla <Sudeep.Holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Viswanath Puttagunta <viswanath.puttagunta@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Abraham <ta.omasab@gmail.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kevin Hilman <khilman@linaro.org>, santosh


--+E8tZd0NUIRz5HKc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 07, 2015 at 02:18:55PM -0700, Stephen Boyd wrote:
> On 05/07, Mark Brown wrote:

> > I'm not looking for anyone to explain this to me in e-mail, what I'm
> > looking for is for the binding document to be clear so someone can tell
> > what the binding means by reading the documentation for the binding.

> Ok. Perhaps the simplest thing to do then is to reuse wording
> from the regulator_set_load() API documentation? That's the only
> usage of this value I'm aware of. Something like:

> 	The current load of the device when using this OPP. Used
> 	to set the most efficient regulator operating mode.

> We don't need any sort of min/max for this property either, so a
> single value should be all that's required.

That makes sense to me.  Perhaps "current drawn by the device" rather
than "current load of the device" since current is sadly overloaded :/

--+E8tZd0NUIRz5HKc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVS+TBAAoJECTWi3JdVIfQA/AH/ApKBMqEOU22yQpC5elWPn0r
sb+leNW3TK3PU/ieHDH4veGJE5DkWLvV0tnl8BjjyYXDfkEo3G2V5Sgx1RTq4413
jwlKqP8FUrPfHZ5dKfsV38EQZOF/sD5Ocanv+5qFZt6DUsAtCUc37MEDKAFDBfNr
TpEjAMBczgxnzJG+eJHl4Wcis9VaDYFfR2znZUf8CoNTH015BdZijdcX6ul6ERdK
kDl4ovxgvVRhHDtXndxKAqLl8Ti46RtJkqXlH1HQT/epybTBe4OtkFrHcAdjOfwp
Zf0KBwDn2icyD1Vp86VdtXYjFVZeBn82hfIh0TS/E6rEWaeXG/ElBL3i2YdzRys=
=bi+q
-----END PGP SIGNATURE-----

--+E8tZd0NUIRz5HKc--
