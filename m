From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] regulator: core: Don't spew backtraces on duplicate
 sysfs
Date: Wed, 3 Jun 2015 13:20:05 +0100
Message-ID: <20150603122005.GL14071@sirena.org.uk>
References: <1433209679-31389-1-git-send-email-sboyd@codeaurora.org>
 <1433209679-31389-2-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i7ycZtlzmcz6MFrW"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:40585 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756095AbbFCMUT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2015 08:20:19 -0400
Content-Disposition: inline
In-Reply-To: <1433209679-31389-2-git-send-email-sboyd@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andy Gross <agross@codeaurora.org>, linux-pm@vger.kernel.org, David Collins <collinsd@codeaurora.org>


--i7ycZtlzmcz6MFrW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 01, 2015 at 06:47:54PM -0700, Stephen Boyd wrote:
> We don't consider a failure to add the sysfs node as a problem,
> so use sysfs_create_link_nowarn() so that we don't print a

Applied, thanks.

--i7ycZtlzmcz6MFrW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbvD0AAoJECTWi3JdVIfQEIoH/2bGggvEbeGIjy4Zd2ikc/L9
G7UNDQRRzDN3NrqvP0+dOF5gQeDBKb3pIma5vF+b989KhWH78Tsr4X2KmPaPW5An
NP8lnMuWRZ0e+u8GqAt/W4SakPl4dr0jyrPMAVke39XnaISjotIAgZlaQ/Ddlpgg
PR+tEqzZ3NIoWqzP1a4HmDFzQZdTvR3H1enHO/fiej1PvyANkEm5EINx2NMXsytl
IK9fq7+RZrVCZI0G2xAsMrxKMfAGjuMSObQdz4p7xlHj489JPm5u9Gp1zqG2eLkW
lIv5PAul+Ip/pzUsKpFzjykozYwRGSB/HwGA2oJXWZ2WHhC1xgeeJ03XxXiCpXM=
=iAt+
-----END PGP SIGNATURE-----

--i7ycZtlzmcz6MFrW--
