From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/5] gadget: Introduce the notifier functions
Date: Thu, 1 Oct 2015 18:43:08 +0100
Message-ID: <20151001174308.GL12635@sirena.org.uk>
References: <cover.1443057229.git.baolin.wang@linaro.org>
 <e58e4f26028c37877d02907831cf4ae411eaf984.1443057231.git.baolin.wang@linaro.org>
 <20151001172932.GG4469@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yQDbd2FCF2Yhw41T"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:34708 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbbJARwl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 1 Oct 2015 13:52:41 -0400
Content-Disposition: inline
In-Reply-To: <20151001172932.GG4469@saruman.tx.rr.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, sojka@merica.cz, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, device-mainlining@lists.linuxfoundation.org


--yQDbd2FCF2Yhw41T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 01, 2015 at 12:29:32PM -0500, Felipe Balbi wrote:

> Frankly, I wanted all of this to be decided in userland with the
> kernel just providing notification and basic safety checks (we don't
> want to allow a bogus userspace daemon frying anybody's devices).

What's the advantage of pushing this to userspace?  By the time we
provide enough discoverability to enable userspace to configure itself
it seems like we'd have enough information to do the job anyway.

--yQDbd2FCF2Yhw41T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWDXCnAAoJECTWi3JdVIfQmFEH/0qoAywAYV0Ujl6TxyWZbX33
SqtvVnNf57Aq0/iKAtXr+Jp45Qxpx93vxLUrJal2DIguUDRGMvoLy9Qc1wMmxQ3K
o7mWvcBQj2ERorGFOOOq+iRG/46+7C+K/3+CvUy6AWWLyoCQW6s+cBp3XPZnhAKu
damSBQ2ImV5g4ofqg/Z5cFmHELiiS52dbOL8UAApu++xHPv1H3ZOAjSxyy48xoro
wWK6QTTF8WVZKCvHDHcGwigWDPP15bZbi7ZeAtuDDkAuiajAi+4RRkeu2ys6f+5N
fmyKtaW/TLlZtSg1Q7p+VhAOUy4RmOT/cJ3xlB17+/Dzhwh6+GZ/NhpQOh7MM1c=
=/4BT
-----END PGP SIGNATURE-----

--yQDbd2FCF2Yhw41T--
