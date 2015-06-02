From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/6] Support CPR on MSM8916
Date: Tue, 2 Jun 2015 11:53:28 +0100
Message-ID: <20150602105328.GJ14071@sirena.org.uk>
References: <1433209679-31389-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jtcAeju3WzRmRF+o"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:38945 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507AbbFBKxo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jun 2015 06:53:44 -0400
Content-Disposition: inline
In-Reply-To: <1433209679-31389-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andy Gross <agross@codeaurora.org>, linux-pm@vger.kernel.org, David Collins <collinsd@codeaurora.org>


--jtcAeju3WzRmRF+o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 01, 2015 at 06:47:53PM -0700, Stephen Boyd wrote:

> Stephen Boyd (6):
>   regulator: core: Don't spew backtraces on duplicate sysfs
>   regulator: core: Print at debug level on debugfs creation failure

These two patches don't seem to be tied to the rest of the series at all
(they certainly trigger already for some systems).

--jtcAeju3WzRmRF+o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbYsnAAoJECTWi3JdVIfQBa0H/3UrwvOn1Fe+dceWi/11pIps
PD3pbtrdGO+G4O6X4RmQ5iU/rGVJnIcCeLR2DZll+uv4vE2/Lk0V+LZ1xazc5n9a
DIgRe0uM+kxKbJyVbiajPksvoTdX73PbegohiQ0WQQ/qlZJsLKYmu/vk9hCwXrFZ
z0k507FC4oos2cFJOe1R5Z1qPrxZkGsMX0FDqSD42HqOicSNEtJifRiZG8lDj2f3
2Tgg2Tj+ll+4wlBGRLR6EXxEvVemqHvxcmwVrsh1i2fcxOQOF1xxE2OhkjEx+COG
DhIeGg0p9+5eDDQawf/NM04/FS4C2Jyqjf1mOL6iJJ43TfVm7Vu7ylKia7D0Qa4=
=GSLE
-----END PGP SIGNATURE-----

--jtcAeju3WzRmRF+o--
