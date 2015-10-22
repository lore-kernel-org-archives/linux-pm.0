From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/16] PM / OPP: Add 'supply-names' binding
Date: Fri, 23 Oct 2015 01:39:42 +0900
Message-ID: <20151022163942.GX8232@sirena.org.uk>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
 <2b87b162eabd1570ae2311e1ef8655acda72f678.1441972771.git.viresh.kumar@linaro.org>
 <55F72C97.2030306@kernel.org>
 <20151016002243.GA23912@codeaurora.org>
 <20151016060227.GS19018@linux>
 <20151016191658.GA16437@codeaurora.org>
 <20151017041055.GZ19018@linux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LmcuB6YxSMQAV95c"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:60000 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965048AbbJVXeT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2015 19:34:19 -0400
Content-Disposition: inline
In-Reply-To: <20151017041055.GZ19018@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, lee.jones@linaro.org, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, open list <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>


--LmcuB6YxSMQAV95c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2015 at 09:40:55AM +0530, Viresh Kumar wrote:

> Okay here is the problem statement:

> We have two supplies for a device and the device node will have
> something like:

> name1-supply =3D <&supply1>;
> name2-supply =3D <&supply2>;

> And the OPP node needs to have voltages for both of them:

> opp-microvolt =3D <X1 Y1 Z1>, <X2 Y2 Z2>;

> Where XYZ(1) are for supply1 and XYZ(2) are for supply2.

> Now we need to identify the supplies for which the values are present
> here and their order as well. How do we do that?

> The way I am suggesting is to add a property in opp node which will
> keep "name1" and "name2" in it.

When we start doing this we also start having to worry about things like
the sequencing of the updates between the various supplies and end up in
full on power sequencing (or at least baking some sequencing into the DT
which will doubtless need extending at some point).  I'm not sure that's
a place we want to end up just yet, I think it's safer to just have a
little bit of code in the kernel that glues things together in the cases
where this is needed. =20

--LmcuB6YxSMQAV95c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWKRFOAAoJECTWi3JdVIfQxx4IAIY1m5byAsOBC5SOE7OOONSG
2aft2M/qrZF99jfNtX2N3jFK0q+cb0Cb7m+gT1JalpKyIUEVtaoIrPgn7d4R9E/Y
f/hb5xOsGUVVM/96X6533BAz1Q3cgnYswKEcgN4kqz3gTNASBckKq/ntTaiajWGY
HKFrl9MjDaIHc+Jr78xPSFR0ci1mgd+/5HG+52IKX6Vb92i19UVf7CrWRExg4SV7
v0KP5LaZvK6+vstvXoMUb5Nd53VjhOIJPhx/HHXrTmlQ1V2zVTzAIUkBmAVFkZnX
Lu88RIoM2GyfZOsIvxckYIjNLtarJ9Bze3uKcpSeRbyNxwT0sE/ey+SvdG4r350=
=kqLR
-----END PGP SIGNATURE-----

--LmcuB6YxSMQAV95c--
