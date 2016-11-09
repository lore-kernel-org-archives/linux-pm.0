From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V3 1/9] PM / OPP: Reword binding supporting multiple
 regulators per device
Date: Wed, 9 Nov 2016 14:58:28 +0000
Message-ID: <20161109145828.p6vvsd5bygkzjcmh@sirena.org.uk>
References: <cover.1477463128.git.viresh.kumar@linaro.org>
 <28119b44689921f3c3cc00be49bff2bb99b32162.1477463128.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nq5mj7svi2m7hpuy"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:45210 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752922AbcKIO6v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Nov 2016 09:58:51 -0500
Content-Disposition: inline
In-Reply-To: <28119b44689921f3c3cc00be49bff2bb99b32162.1477463128.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, Viresh Kumar <vireshk@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, devicetree@vger.kernel.org


--nq5mj7svi2m7hpuy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 26, 2016 at 12:02:56PM +0530, Viresh Kumar wrote:

> +  Entries for multiple regulators shall be provided in the same field separated
> +  by angular brackets <>. The OPP binding doesn't provide any provisions to
> +  relate the values to their power supplies or the order in which the supplies
> +  need to be configured.

I don't understand how this works.  If we have an unordered list of
values to set for regulators how will we make sense of them?

> -			cpu-supply = <&cpu_supply0>, <&cpu_supply1>, <&cpu_supply2>;
> +			vcc0-supply = <&cpu_supply0>;
> +			vcc1-supply = <&cpu_supply1>;
> +			vcc2-supply = <&cpu_supply2>;

This change doesn't seem to correspond to the documentation change.

--nq5mj7svi2m7hpuy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYIzmUAAoJECTWi3JdVIfQhnoH/35XCH+XfJQZIj+eUgucnc6F
xIj3sX9k+ZhnByX5bcT3pztmkKzn8RA65XfRzcaY5D0jtsZgx8GEwiaHStFalURG
cvp5fw/F9UrAd8cby1e0zbglm/QtvWLfx3WKxMuY/F0ulma0kpD8vUskVV0R+AWK
oEUyNhCcJlR5aLDRT2H/rjbpTNi6O2nGHb/SWfpneoMF9YLKjiTHOehrncdk0/Nh
vguKBEaepD7xDzYftdYGI5ldn0xcT2FYXuIoLIzG8/mvb+DQo4PaNQTiEDR2jWN+
Td1gGGX/iFz2/fI6teOyefTSKG4ya79LDmef5WDcPpyJ2tBNfeNbkDXaMd/p78Q=
=ZVcX
-----END PGP SIGNATURE-----

--nq5mj7svi2m7hpuy--
