From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Fri, 8 May 2015 11:58:57 +0100
Message-ID: <20150508105857.GB22845@sirena.org.uk>
References: <CAKohponRXiWbgT26=tO83jJgbteBf38ggE7mKvLCv+wFMW1cvA@mail.gmail.com>
 <20150505105714.GA22845@sirena.org.uk>
 <CAKohpo=09ZhXxh5Cm7Ww9Gy-AYRp9=j82tup6atVN+aOF8twdA@mail.gmail.com>
 <20150505171252.GI22845@sirena.org.uk>
 <CAKohpo=kJs076afzERPMqjELgwpN6nR2yoyEjW6XY7YSEbRuCA@mail.gmail.com>
 <20150507055231.GB32399@codeaurora.org>
 <20150507110233.GR15510@sirena.org.uk>
 <20150507211855.GA2455@codeaurora.org>
 <20150507221842.GW22845@sirena.org.uk>
 <CAKohpomU8wm0T=A7EkosdOjXbP8q2Cb726Hsjh08KTKYjoz3-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="laBhmkiQtYGknO4U"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:56200 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbbEHK7Z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 06:59:25 -0400
Content-Disposition: inline
In-Reply-To: <CAKohpomU8wm0T=A7EkosdOjXbP8q2Cb726Hsjh08KTKYjoz3-A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Rafael Wysocki <rjw@rjwysocki.net>, Rob Herring <rob.herring@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Nishanth Menon <nm@ti.com>, Mike Turquette <mike.turquette@linaro.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, "olof@lixom.net" <olof@lixom.net>, Sudeep Holla <Sudeep.Holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Viswanath Puttagunta <viswanath.puttagunta@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Abraham <ta.omasab@gmail.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kevin Hilman <khilman@linaro.org>, santosh


--laBhmkiQtYGknO4U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 08, 2015 at 12:17:44PM +0530, Viresh Kumar wrote:

> Thanks Mark. I have reworded it as:
>=20
> - opp-microamp: Current drawn by the device in micro Amperes. It is used =
to set
>   the most efficient regulator operating mode.
>=20
>   Should only be set if opp-microvolt is set for the OPP.
>=20
>   Entries for multiple regulators must be present in the same order as
>   regulators are specified in device's DT node. If this property isn't re=
quired
>   for few regulators, then this should be marked as zero for them. If it =
isn't
>   required for any regulator, then this property need not be present.

> Please let me know if this looks fine now.

That should be fine, microamperes is usually one word.

--laBhmkiQtYGknO4U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVTJbwAAoJECTWi3JdVIfQ4ZUH/0827Tk+IkaZuV7pkqOgRkRT
w09VJXpZANXGr5OFBuEwTUOJQn37Sh5L8Rnvt22jiWnZOD0cdFVqZC+dWIZkdFXf
aflaDgosK+hb381FRzN4di+r1DQLVcH1Gtnr6IHf31T+5LJf0D9mBxZaFzOF+lc1
d8tkps3NOVm/HFrJi30CdZ26ZLU5oUSoF+eGBvB6dOwkPxWK2SDLuHGXgkWxj74p
e28G57VnXbDdNxmY0vk+eIdOOLtNUlTvenIRHfMSDDKC6UG7QWhyPqQGMOSfJTRT
kWFi4reCtgq8GiAzXxd8UFXMpGiu6JXZTQ0lZlmJzZtWmZhNtU5PGeBc/5TyKYk=
=0S5J
-----END PGP SIGNATURE-----

--laBhmkiQtYGknO4U--
