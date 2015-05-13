From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Wed, 13 May 2015 16:07:39 +0100
Message-ID: <20150513150739.GW2761@sirena.org.uk>
References: <20150507221842.GW22845@sirena.org.uk>
 <CAKohpomU8wm0T=A7EkosdOjXbP8q2Cb726Hsjh08KTKYjoz3-A@mail.gmail.com>
 <555000B6.2010107@ti.com>
 <20150512052033.GC32300@linux>
 <20150512190134.16410.89041@quantum>
 <5552510B.9010306@ti.com>
 <20150512194134.GC3066@sirena.org.uk>
 <55525B29.2080307@ti.com>
 <20150513115422.GQ3066@sirena.org.uk>
 <CAGo_u6o5nw8C3uwLGmP+kbCOG5twmXgC2ATb5Gv-dL3G-grDSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1gsfN/+pS0/2Ta7u"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:37731 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933623AbbEMPID (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2015 11:08:03 -0400
Content-Disposition: inline
In-Reply-To: <CAGo_u6o5nw8C3uwLGmP+kbCOG5twmXgC2ATb5Gv-dL3G-grDSg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Michael Turquette <mike.turquette@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Rafael Wysocki <rjw@rjwysocki.net>, Rob Herring <rob.herring@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, "olof@lixom.net" <olof@lixom.net>, Sudeep Holla <Sudeep.Holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Viswanath Puttagunta <viswanath.puttagunta@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Abraham <ta.omasab@gmail.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kevin Hilman <khilman@linaro.org>


--1gsfN/+pS0/2Ta7u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2015 at 09:24:57AM -0500, Nishanth Menon wrote:

> - opp-microamp: The maximum current drawn by the device in microamperes
>   considering system specific parameters (such as transients, process,
> aging, etc.)
>   as necessary,  at an  ambient temperature of 25C. This may be used to set
>   the most efficient regulator operating mode.

Why specify the temperature?  That 25C is going to be terribly
inefficient for my snowplow engine control system (or whatever).

--1gsfN/+pS0/2Ta7u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVU2i7AAoJECTWi3JdVIfQqEEH/jqxwPpVRGLjw/eBd6nvovgY
410P21/MnYlGPQ3/Kupjaux9c5ZBcqoHkfH26AKO38B+AtRcXCbGnv+Zu27Np6E/
OgHm88oCUeEefBFHia1JBmTcsvtFLDnU3RSFJ1vQktMEPZ/n1Fv/yObFjMnRfKwx
GT40T3vdcV+ueE0NONzRjodaWyDDBDOxLR6EwO/J9ecOC1XJ42XmI/gwlBGan/r8
TT4xlQyA8HCWV4IIzdolyBrQZChBtFPjlqxegOnBsJh7vtuaI7Wx2KoIDolBhtUc
V1AVkhO2tg2mIzXcB4LoULc1BxyJnYB161ZLXhvqzqIY+tQQkaGTS1eTtVU6QoM=
=s7v2
-----END PGP SIGNATURE-----

--1gsfN/+pS0/2Ta7u--
