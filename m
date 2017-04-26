From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V4 1/9] PM / OPP: Allow OPP table to be used for
 power-domains
Date: Wed, 26 Apr 2017 14:55:32 +0100
Message-ID: <20170426135532.ryrh276znet5yvks@sirena.org.uk>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
 <e772e67a5445319bb8e0f312846ace666adc097f.1490001099.git.viresh.kumar@linaro.org>
 <0a7146f9-72f1-317c-3aab-770a72462968@arm.com>
 <20170413053736.GM5910@vireshk-i7>
 <3adbef6a-7b43-528f-e88f-c2121d30a5d3@arm.com>
 <20170417052758.GF28191@vireshk-i7>
 <95aa4b97-4e1a-13bb-f4d8-982b778012ba@arm.com>
 <9cd9287c-392b-d3ca-db7d-75c49287448e@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7x23rnxpubex2hak"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:41108 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3000769AbdDZNz4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Apr 2017 09:55:56 -0400
Content-Disposition: inline
In-Reply-To: <9cd9287c-392b-d3ca-db7d-75c49287448e@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, lina.iyer@linaro.org, devicetree@vger.kernel.org


--7x23rnxpubex2hak
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 26, 2017 at 10:02:39AM +0530, Rajendra Nayak wrote:
> > On 17/04/17 06:27, Viresh Kumar wrote:

> >>> If we are looking this power-domains with performance as just some
> >>> *advanced regulators*, I don't like the complexity added.

> + Mark

> I don;t see any public discussions on why we ruled out using regulators to
> support this but maybe there were some offline discussions on this.

> Mark, this is a long thread, so just summarizing here to give you the context.

> At qualcomm, we have an external M3 core (running its own firmware) which controls
> a few voltage rails (including AVS on those). The devices vote for the voltage levels
> (or performance levels) they need by passing an integer value to the M3 (not actual
> voltage values). Since that didn't fit well with the existing regulator apis it was

As I'm getting fed up of saying: if the values you are setting are not
voltages and do not behave like voltages then the hardware should not be
represented as a voltage regulator since if they are represented as
voltage regulators things will expect to be able to control them as
voltage regulators.  This hardware is quite clearly providing OPPs
directly, I would expect this to be handled in the OPP code somehow.

--7x23rnxpubex2hak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkAps4ACgkQJNaLcl1U
h9DNzQf7B0hYfmz0bgG7ThEhi7SFkdE0hhq5GhCGeSKSRiMZnnkLLJw8iUnwM9Te
S4oEibgntrrLimnHb33fIuHPO3kEWLcgR4dDKA/W+CGVx5YVZ/C0YEMo8alJmgdM
PWlr7lcAt8NtSTumIR9DhZzd46LmkqmUrbwEK33GsPCaf0yFcsHf8tx4e54g5VG3
IRxuytrcQ80KqR+44OcVK/m4MEhIGLXLuri4OqdN3LZSjJkDH1Frz46gG8ixGG4Z
o8eS43qSMM+S4Y9b0KOpeuH7xkRp6XzQT3dI8XWf/EdiO+qqZqMyd1DawT547SyG
iSN3t05B1ExZu2x9WN1Cz4mvhx801Q==
=nfTy
-----END PGP SIGNATURE-----

--7x23rnxpubex2hak--
