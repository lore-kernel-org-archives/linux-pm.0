From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/16] PM / OPP: Add 'supply-names' binding
Date: Thu, 3 Mar 2016 00:30:21 +0900
Message-ID: <20160302153021.GR18327@sirena.org.uk>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
 <2b87b162eabd1570ae2311e1ef8655acda72f678.1441972771.git.viresh.kumar@linaro.org>
 <55F72C97.2030306@kernel.org>
 <CAKohpo=fcab=eisbwMw=wvbmuXVY5iw_CSe3QK1Ax_i-56JAzA@mail.gmail.com>
 <20160302025016.GS18327@sirena.org.uk>
 <20160302102831.GE2891@vireshk-i7>
 <20160302112410.GN18327@sirena.org.uk>
 <CAGo_u6ofNVVDDGm3_M2G3A6hbzf1hQuXqHm8DyyqzTuk5OKsdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="e6u5m98m4rclINw9"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:53976 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbcCBPaa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2016 10:30:30 -0500
Content-Disposition: inline
In-Reply-To: <CAGo_u6ofNVVDDGm3_M2G3A6hbzf1hQuXqHm8DyyqzTuk5OKsdQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Dave Gerlach <d-gerlach@ti.com>, Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rob Herring <rob.herring@linaro.org>


--e6u5m98m4rclINw9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 02, 2016 at 09:26:03AM -0600, Nishanth Menon wrote:

> We do have a real need to control multiple regulators around an OPP
> change. this logic is valid for more than CPU device -> it is valid
> for devices like DSP, GPU etc in the SoC as well across multiple
> families in the OMAP generation SoCs. The logic by itself it not too
> complicated. a voltage plane for a device has two regulators that need
> to be controlled in tandem for a given target frequency. by allowing
> dev_pm_opp_set_rate to control "n" regulators it actually does
> simplify the problem down for a generic solution -> DVFS for devices
> triggered from cpufreq or via devfreq.

That's n regulators that need to be changed in arbitrary orders
(together with some other number of clocks).

--e6u5m98m4rclINw9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW1wcHAAoJECTWi3JdVIfQpP4H/iAHt0wuYitUM5QxQRqSkXuW
gMzInk7S6TpTqK7OhTA6gWHwVLe2giVrSjBH+gIENX4ZZG1wdX/HiDEtlNOPSBQ1
NiygN7v3//mXtkGFHL0UjToeCDqGZkJzPtBx9Xdm762WD4PAyEr9w9KhXm35pykF
5+D4fIwcsg8GotP8nigMORNGn5uEsiINylYFpV6lvoorio0v6yitjMHgEyuinWbN
Oo/vje86p6wSGkYLUqDnVz2/AajE1+2Jvy9V8EVkIn2i84OLIYHnUVO3ifjNpnU7
9b7hh+E5jxrhohPo6m4pFC0KOAIo2D/jKeCAGJo+hPUfj0miFeqaF4yUgY307Ns=
=i2Xk
-----END PGP SIGNATURE-----

--e6u5m98m4rclINw9--
