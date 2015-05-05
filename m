From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Tue, 5 May 2015 18:12:52 +0100
Message-ID: <20150505171252.GI22845@sirena.org.uk>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <20150504121209.GM15510@sirena.org.uk>
 <CAKohponRXiWbgT26=tO83jJgbteBf38ggE7mKvLCv+wFMW1cvA@mail.gmail.com>
 <20150505105714.GA22845@sirena.org.uk>
 <CAKohpo=09ZhXxh5Cm7Ww9Gy-AYRp9=j82tup6atVN+aOF8twdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="v0UO8vuVPXJ4JTyq"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:51550 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932497AbbEERNR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 May 2015 13:13:17 -0400
Content-Disposition: inline
In-Reply-To: <CAKohpo=09ZhXxh5Cm7Ww9Gy-AYRp9=j82tup6atVN+aOF8twdA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Rob Herring <rob.herring@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Nishanth Menon <nm@ti.com>, Mike Turquette <mike.turquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, "olof@lixom.net" <olof@lixom.net>, Sudeep Holla <Sudeep.Holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Viswanath Puttagunta <viswanath.puttagunta@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Abraham <ta.omasab@gmail.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kevin Hilman <khilman@linaro.org>, santosh


--v0UO8vuVPXJ4JTyq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2015 at 05:13:33PM +0530, Viresh Kumar wrote:
> On 5 May 2015 at 16:27, Mark Brown <broonie@kernel.org> wrote:

> > No, it doesn't - you're not answering the question about what this is
> > for.

> I don't know how this information will be used finally. Probably the
> platform driver will do the configuration based on the volt-cur pair.

I don't think we should be defining a binding without understanding what
it is supposed to mean. =20

>  - opp-microamp: current in micro Amperes. It can contain entries for mul=
tiple
> -  regulators.
> +  regulators. This can be referenced (along with voltage and freqency) w=
hile
> +  programming the regulator.

This still doesn't say what the value is supposed to mean which means
it's not possible for someone to write generic code which handles the
binding - saying that people can reference the value doesn't tell them
how to interpret it.  A limit?  A nominal constant draw value?  A value
to regulate to?  Those are all different things expressed as a current.

--v0UO8vuVPXJ4JTyq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVSPoUAAoJECTWi3JdVIfQaAcH/1csXdJjh1PCxKLq90jlOIfR
F936bn9idfw8ojWyLPEQi3z8DUaFwwK4fkKaj4bOA7H8cevtamCfqTByXQo4V9zx
MHdrO9l4CtlWv4dBa+unnVbCtMCzsyW7KYba8DKJuaoX2Nxl9R5TcB/vBnmhGrmg
jBDw4w7hQOgNb4Uzj/SensRUgmOe+74fFUxvmu4fNdl6qAIbaOn03VhdPdbLLrnt
LiLyeUlSp9eMhvYp7B4ITTU5KUNi5VkRm/akWVWUDgKXqD/2Y8ng6hqOvrksttCo
OOm973yS4767qjKZrO4PA4zHoMt2U0jMwq8N8v7RHupDLeT/BnHod4zcYaDvYlU=
=hI/C
-----END PGP SIGNATURE-----

--v0UO8vuVPXJ4JTyq--
