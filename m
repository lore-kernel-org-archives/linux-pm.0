From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] arm64: Enable OPP
Date: Fri, 9 May 2014 18:11:20 +0100
Message-ID: <20140509171120.GS12304@sirena.org.uk>
References: <1399653631-4938-1-git-send-email-broonie@kernel.org>
 <CAGo_u6rGEWwywQ5JKh1ROhkOjrkWrM35PdWAooed26oak=1irA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WjrKmzek8eDUsx7N"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:39476 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757136AbaEIRLh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 May 2014 13:11:37 -0400
Content-Disposition: inline
In-Reply-To: <CAGo_u6rGEWwywQ5JKh1ROhkOjrkWrM35PdWAooed26oak=1irA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "menon.nishanth@gmail.com" <menon.nishanth@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linaro Kernel <linaro-kernel@lists.linaro.org>


--WjrKmzek8eDUsx7N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 09, 2014 at 12:02:12PM -0500, menon.nishanth@gmail.com wrote:
> On Fri, May 9, 2014 at 11:40 AM, Mark Brown <broonie@kernel.org> wrote:

> > Some of the generic drivers used on ARM class systems use OPP so allow it
> > to be selected in Kconfig. No code is required for this, it is not clear
> > to me why there is config for this option.

> If you mean why we have ARCH_HAS_OPP,
> http://lists-archives.com/linux-kernel/27401148-pm-hide-opp-configuration-when-socs-do-not-provide-an-implementation.html

That's for the user visible symbol but OPP is also enableable via select
- the fix here may be to remove both the visibility check and the
dependency.

--WjrKmzek8eDUsx7N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTbQw0AAoJELSic+t+oim92coP/2iEsPS0CREfAOTLWjHXHdHd
V9dWKBMuJeWC2IvvMXBKwf6y0YxWADoePRdd7+REWm6bu20E2xf2Wjw1LMZE33hK
gItSXIyKMEPxvn+18BGQVgQ9kF6nhYGuiJxBMWM0B0bF5wXbPL7ot6kYfrZCH7Ro
asu16/+IekYmZKpjyas4K6UM3guB1MDZEMO67n0zvatOpNWbzdZqZ6vlbVaJllbJ
37ppzTG+u27GyuDIn31NssHdf98N0l6WJX+gWDmu+SI3NWULZpvznFy+MeDCzrxz
K/L3BMqe+nr1Po/TLmhSatD/ZpbgCwvxWqC09n+GViWDyXmnyAruUHl8XMCP2TTg
fm3XnX/DGabN81NfHyu+12lNYwom2OXSyBja88KLhXW3nODCX/Yfc7yjYDpZ3Eok
0JqazMTYpbuv8zcDVPPov+ZOTO8fGnce0rshc8r2WlBWnPY5MUK7ArSWmNQMidEf
ca4ZK/grUPqmhDUN6aGYU4GxRW3R6H0LMDsO8MTBxdl4fPXLwunv59LI7aFo8ywX
B0gXCCz05dJeSRgZWHivrbHSDMeFh9a/99q3ShxYsB+6pxHjazm9lxItxJJo2aGq
cbowYd49YKFQZTFaeFc/oI8fbopk1z2i+r7wI5e/LhL5mBDdRMdLAEo820+GE1eo
GoZqLWCQ081/YdMYEKUV
=FTUu
-----END PGP SIGNATURE-----

--WjrKmzek8eDUsx7N--
