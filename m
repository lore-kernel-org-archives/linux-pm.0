From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Wed, 13 May 2015 12:03:57 +0100
Message-ID: <20150513110357.GD3066@sirena.org.uk>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <20150512214224.16410.15922@quantum>
 <20150513085528.GA6994@linux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="52aklQ8BZHJhx2Z3"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:37029 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933242AbbEMMQx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2015 08:16:53 -0400
Content-Disposition: inline
In-Reply-To: <20150513085528.GA6994@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Michael Turquette <mike.turquette@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com


--52aklQ8BZHJhx2Z3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2015 at 02:25:28PM +0530, Viresh Kumar wrote:
> On 12-05-15, 14:42, Michael Turquette wrote:
> > Quoting Viresh Kumar (2015-04-30 05:07:59)
>=20
> > Why should this new binding exist?

> The answer to this particular query is perhaps simple, i.e. we have
> unsolved problems that we wanted to solve in a generic way.

> But probably the bigger question is "Should we really put the OPPs
> (new or old bindings) in DT".

And also is trying to do this in a completely generic manner the right
way of going about things - do we really understand the problem area
well enough to create a completely generic solution for all cases,
bearing in mind that once things go into a DT binding they become an ABI?

--52aklQ8BZHJhx2Z3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUy+aAAoJECTWi3JdVIfQH8QH/A0s+0zmXE1+H98e/OZRP4ga
D7Gj/TDfBadRsr/ALoJy6sxPtf81ZXR1hMmQNw9MTH7ZcyMeV+Bk4mLZpyF3UyPT
3aPxArOx7k8S8izu47Qkk/X0te8SB5bVg3qCvdUxTJhLlmg6qkTZVV+wg+hK/Ll9
BU00eGSo+HpKvJvV5rrxfs0HBAHUcDrLUtz9KXKgT+ZA/WXSDtcTKnkHWxfd6nCW
RB/YaNVWcs3VCLdOiyApYyZpeo4wE+Ju6q/GXpsD4BkL8JX0+O1153kPCWELXmS3
rsFJ4t9NF28PQI73lWSkhEqrmbuwkSq0Gb/sadHxYFpHX1Mqny9bl1wFQ0NLwKg=
=hp71
-----END PGP SIGNATURE-----

--52aklQ8BZHJhx2Z3--
