From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] OPP: Redefine bindings to overcome shortcomings
Date: Thu, 4 Dec 2014 17:18:49 +0000
Message-ID: <20141204171849.GX7712@sirena.org.uk>
References: <52c403454c3b8fc201abe7ac74cf657638479311.1417691389.git.viresh.kumar@linaro.org>
 <1417692868.9037.4.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JBABWuYasNt1mk88"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:48335 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932254AbaLDRTR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Dec 2014 12:19:17 -0500
Content-Disposition: inline
In-Reply-To: <1417692868.9037.4.camel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, nm@ti.com, rob.herring@linaro.org, kesavan.abhilash@gmail.com, linaro-kernel@lists.linaro.org, catalin.marinas@arm.com, linux-pm@vger.kernel.org, sboyd@codeaurora.org, santosh.shilimkar@oracle.com, Rafael Wysocki <rjw@rjwysocki.net>, olof@lixom.net, devicetree@vger.kernel.org, mike.turquette@linaro.org, Sudeep.Holla@arm.com, grant.likely@linaro.org, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org


--JBABWuYasNt1mk88
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 04, 2014 at 12:34:28PM +0100, Lucas Stach wrote:
> Am Donnerstag, den 04.12.2014, 16:44 +0530 schrieb Viresh Kumar:

> > +  - voltage-tolerance: Specify the CPU voltage tolerance in percentage.

> This is extremely ill defined. It doesn't say in which direction the
> tolerance is to be applied. Can you go below or above the OPP specified
> voltage? For now everyone just assumes that it has to work both ways.
> Also with this binding the tolerance is applied for all OPPs, where is
> very much depends on the individual OPP.

Almost all specifications for voltages are done as either min/typ/max or
+/- a target voltage.

> If you are going to redefine OPPs anyway I would really like to see this
> property die and rather have a min/max voltage per OPP. That way you can
> properly express the OPP constraints. Most OPPs will likely allow a much
> higher voltage than their minimal specified one, except when you go over
> thermal limits with a high clock/voltage combination.

If you've got a minimum and maximum you also need to specify a target,
generally it's going to be better to go for the target voltage which may
not be the midpoint and is unlikely to be one of the bounds.  I do think
it's sensible to have the option of doing both to more closely match
datasheets.

> > +  - clock-latency: Specify the possible maximum transition latency for clock,
> > +    in unit of nanoseconds.

> Why do we need this? This is property of the clock. We should be able to
> handle this completely internally in the kernel. I don't know if the
> clock API has something like this right now, but it should be a trivial
> addition.

Or have it be part of the clock binding at any rate.

--JBABWuYasNt1mk88
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUgJd4AAoJECTWi3JdVIfQO2cH/A4xkox0tV1u0JGW0NZZ64CB
iG9m41Xnvtdio2GQH7wyCZ6Q+w3Uz6JdKHq/LPG/EqVNzop7aa5F4v+MFD5pyAlx
iTauzhvWV+FtrAek6SkOm/f96J5K2edYHVPygAmsXbjuID2u4dJ4TjdUB+tvT+vq
DnrvlZZJkhtG6TgHekKBhGe1lyoDJagC4T6ZmIhewtBSZvnY8bRR7U2eQFqzz+lT
If5B55ybdhHOvdDQ50DKc1F/4AYZzX0m79eK4YkYV1NxRVnbbzbzhKAzpI0HfZg6
PgbYIN1PJoGvvOD4UB9u8MxS2dvgCuFx9zXJyEoXadxS6WEDW9BaArXlQLPGsM8=
=Yk1q
-----END PGP SIGNATURE-----

--JBABWuYasNt1mk88--
