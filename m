From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V4 1/9] PM / OPP: Allow OPP table to be used for
 power-domains
Date: Sun, 30 Apr 2017 21:49:17 +0900
Message-ID: <20170430124917.4m3d237pik7q47f3@sirena.org.uk>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
 <e772e67a5445319bb8e0f312846ace666adc097f.1490001099.git.viresh.kumar@linaro.org>
 <0a7146f9-72f1-317c-3aab-770a72462968@arm.com>
 <20170413053736.GM5910@vireshk-i7>
 <3adbef6a-7b43-528f-e88f-c2121d30a5d3@arm.com>
 <20170417052758.GF28191@vireshk-i7>
 <95aa4b97-4e1a-13bb-f4d8-982b778012ba@arm.com>
 <9cd9287c-392b-d3ca-db7d-75c49287448e@codeaurora.org>
 <20170426135532.ryrh276znet5yvks@sirena.org.uk>
 <c66322f5-e2eb-5556-a5a5-14998a2f195d@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5s2qhlmcbzxkspgo"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:59148 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968631AbdD3Mtb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Apr 2017 08:49:31 -0400
Content-Disposition: inline
In-Reply-To: <c66322f5-e2eb-5556-a5a5-14998a2f195d@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rajendra Nayak <rnayak@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, lina.iyer@linaro.org, devicetree@vger.kernel.org


--5s2qhlmcbzxkspgo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 27, 2017 at 10:42:49AM +0100, Sudeep Holla wrote:
> On 26/04/17 14:55, Mark Brown wrote:

> > As I'm getting fed up of saying: if the values you are setting are not
> > voltages and do not behave like voltages then the hardware should not be
> > represented as a voltage regulator since if they are represented as
> > voltage regulators things will expect to be able to control them as
> > voltage regulators.  This hardware is quite clearly providing OPPs
> > directly, I would expect this to be handled in the OPP code somehow.

> I agree with you that we need to be absolutely sure on what it actually
> represents.

> But as more and more platform are pushing such power controls to
> dedicated M3 or similar processors, we need abstraction. Though we are
> controlling hardware, we do so indirectly. Since there were discussions
> around device tree representing hardware vs platform, I tend to think,
> we are moving towards platform(something similar to ACPI).

I don't think there's a meaningful hardware/platform distinction here -
in terms of what DT is describing the platform bit is just what the
hardware (the microcontrollers) happen to do, DT doesn't much care about
that though.

--5s2qhlmcbzxkspgo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkF3UwACgkQJNaLcl1U
h9A9Twf/d7T9kMvGk9pgxGFwCY5EKoRJj0SXzXCOkPPSpnRA5S+mbYeiZjVQKnKv
n0RwnqXwcUAg73N2ip0w5U/0rnKWjXcHqZFz82sWMzBKYnAkCtmRzktdcw9Aq8PA
pXAVtW7ODoU9n77lONm5d0mSrzr/hcg36sNkgF/OTkrI/yklqpL4Al5vYbPXJZRu
OT4PlBHHe2qqKg7jmJAAnWGfNlg4Vk13Kq0WtGCfPrqidOhMDEDN2x1iVguivSQN
cABjEqVRST9SqMvppthhwOxYU83SO+ZSvTnkcuswIpcCKJ9oJbvNnho9Or3dPT7S
IRBH0Z7lUZHASeqfYkvcxitjy4rf5Q==
=H0Iz
-----END PGP SIGNATURE-----

--5s2qhlmcbzxkspgo--
