From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/6] regulator: core: Print at debug level on debugfs
 creation failure
Date: Wed, 3 Jun 2015 19:39:25 +0100
Message-ID: <20150603183925.GU14071@sirena.org.uk>
References: <1433209679-31389-1-git-send-email-sboyd@codeaurora.org>
 <1433209679-31389-3-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5kA4nwuSW3j1l9NB"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:41001 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756688AbbFCSjh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2015 14:39:37 -0400
Content-Disposition: inline
In-Reply-To: <1433209679-31389-3-git-send-email-sboyd@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andy Gross <agross@codeaurora.org>, linux-pm@vger.kernel.org, David Collins <collinsd@codeaurora.org>


--5kA4nwuSW3j1l9NB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 01, 2015 at 06:47:55PM -0700, Stephen Boyd wrote:

> The downside of this approach is that whoever gets to debugfs first
> the others who come later to not have any debugfs attributes associated
> with them.

Right, and we do it silently which I'm really not sure about (either
way).  Let me think...

--5kA4nwuSW3j1l9NB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVb0ncAAoJECTWi3JdVIfQgyEH/i0U1fRgK3Im1G8R6t2bgbsW
m4+EPIh7RWbcU44m8Pkc0soTQ5RPilkFl0g780zAaiFCuY0RWdIy2QLZ9DgL9Vh7
EzlDgDMzRD1PIo5ioJVShualj4q+4iXY55P11iLtskww0O/9KiRrr/FfDtJoZ705
dvGb+NetO0K465sZ9jU8BZZLTD3wf5gmjgmju7ComU6XWg3hRr0uEy4BTIceIYA5
0JCypjmw8QDbfGkQsngH6Tf3TxovaXiWyqWl01StnzV41UWHc3i/JAcP4jhYv8aD
0j4iurZyFYgiNiSblMcGKuvLwX334FX3Dd7X77jcHZy6/N9sgs9AaZ+XT9mtbhE=
=qkim
-----END PGP SIGNATURE-----

--5kA4nwuSW3j1l9NB--
