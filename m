From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/4] cpufreq: mediatek: add Mediatek cpufreq driver
Date: Wed, 11 Mar 2015 12:45:55 +0000
Message-ID: <20150311124555.GB28806@sirena.org.uk>
References: <1425458956-20665-1-git-send-email-pi-cheng.chen@linaro.org>
 <1425458956-20665-4-git-send-email-pi-cheng.chen@linaro.org>
 <CAKohpo=c2t4_2hdPP-vQM7xewK5SXaHBGNA9PhvTwDv3++pSTg@mail.gmail.com>
 <CALx668VypyWbVuph0ir0SRt4kqASvYzwBuyc_r5tFeoHi+HieA@mail.gmail.com>
 <CAKohpomxXTP6NdPoSmB=eq2sFqqgskS5vYtDNAT6a0VL5K6dCg@mail.gmail.com>
 <CALx668VFRdeWcK_gKhJrJehnaH5uDpA0m2OfHLqPVUq8oocXaw@mail.gmail.com>
 <CAKohpokT7fSniPGX2BfM61AtMoMCxEP8WDtbZ34bozUXscEWyg@mail.gmail.com>
 <20150311105307.GW28806@sirena.org.uk>
 <CAKohpom4riOhzc3hK8B2tiSwGx0zG96C7QNeQB0yZaPMd_OpLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5qKznMjKMQvXoTz3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKohpom4riOhzc3hK8B2tiSwGx0zG96C7QNeQB0yZaPMd_OpLw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Chen Fan <fan.chen@mediatek.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Howard Chen <ibanezchen@gmail.com>, "Joe.C" <yingjoe.chen@mediatek.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, Pawel Moll <pawel.moll@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Eddie Huang <eddie.huang@mediatek.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kumar
List-Id: linux-pm@vger.kernel.org


--5qKznMjKMQvXoTz3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 11, 2015 at 04:33:49PM +0530, Viresh Kumar wrote:

> On mediatek platform, they need to configure two regulators in order to change
> DVFS state of the big cluster. The generic cpufreq-dt driver and earlier OPP
> bindings have support for a single regulator only and so what Pi-cheng tried
> to do is,
> - Configure one of the regulators using cpufreq-dt
> - And other one using cpufreq frequency change notifiers

> This looks awkward..

> What I suggested was to create another virtual regulator for CPU which will
> eventually configure both the regulators. And so the question that such
> virtual regulators are allowed or not.

Ugh, no - that's a hideous bodge which is only going to create trouble
later.  Remember, DT is an ABI and should describe the hardware so if
we're doing bodges that are visible there to shoehorn things onto our
implementation that's bad.  The concerns that Pi-Cheng had about what
happens if the PMIC gets changed definitely seem relevant here too.

--5qKznMjKMQvXoTz3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVADkCAAoJECTWi3JdVIfQ+LQH/0PaXaOriaHMAntbv8Cmikro
3q7S/3alsiqF507W3WX79Chn+OGyFs4CjqB/Lk5RaR3lqfI55F+Op/MBat0sSkpN
OYa07sEJ5zkPNBsc1z9RCp6I7mcHHGVAIfgP+NibitafxltofZJsA11Jku2zilMM
Ga2otIruxlTju9lZEDRci8Y+TSMBeTvOhoCuAeww31WeQeOekGUzdM5/wSRJIQFL
7y0ICqwbhy4cYglS2m2GPFjPwSCOi+WgDo9SnVZFbn65Jv0Cgq1Pr/hxQRmu2kH/
HaJj411TVoLoa0CT7Rt5RkSqdmf5CbdZ3UOLvXBazxY2wCcIy0X7BD61uv9L/ew=
=cqDt
-----END PGP SIGNATURE-----

--5qKznMjKMQvXoTz3--
