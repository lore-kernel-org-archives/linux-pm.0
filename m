From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/4] cpufreq: mediatek: add Mediatek cpufreq driver
Date: Wed, 11 Mar 2015 10:53:07 +0000
Message-ID: <20150311105307.GW28806@sirena.org.uk>
References: <1425458956-20665-1-git-send-email-pi-cheng.chen@linaro.org>
 <1425458956-20665-4-git-send-email-pi-cheng.chen@linaro.org>
 <CAKohpo=c2t4_2hdPP-vQM7xewK5SXaHBGNA9PhvTwDv3++pSTg@mail.gmail.com>
 <CALx668VypyWbVuph0ir0SRt4kqASvYzwBuyc_r5tFeoHi+HieA@mail.gmail.com>
 <CAKohpomxXTP6NdPoSmB=eq2sFqqgskS5vYtDNAT6a0VL5K6dCg@mail.gmail.com>
 <CALx668VFRdeWcK_gKhJrJehnaH5uDpA0m2OfHLqPVUq8oocXaw@mail.gmail.com>
 <CAKohpokT7fSniPGX2BfM61AtMoMCxEP8WDtbZ34bozUXscEWyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zN/UJhV2gvyhY9D2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKohpokT7fSniPGX2BfM61AtMoMCxEP8WDtbZ34bozUXscEWyg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Pi-Cheng Chen <pi-cheng.chen@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Chen Fan <fan.chen@mediatek.com>, Mike Turquette <mturquette@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Howard Chen <ibanezchen@gmail.com>, "Joe.C" <yingjoe.chen@mediatek.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Eddie Huang <eddie.huang@mediatek.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Petazzoni <thomas.petazzoni@free-electr>
List-Id: linux-pm@vger.kernel.org


--zN/UJhV2gvyhY9D2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 10, 2015 at 08:20:43AM +0530, Viresh Kumar wrote:

Please don't send upstream e-mail to my work account, I use this address
pretty consistently for upstream.  Upstream mail to my work account
frequently ends up unread.

> On 6 March 2015 at 11:19, Pi-Cheng Chen <pi-cheng.chen@linaro.org> wrote:
> > On 5 March 2015 at 17:55, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> > About putting
> > those stuff into regulator driver, I think you mean creating a
> > "virtual regulator
> > device" and put all the voltage controlling complex into the driver, right?
> > Maybe it's a good idea in this case, but I am sure if this kind of
> > virtual regulator is acceptable.

> @Mark: Is this allowed to create virtual regulator for a CPU ?

I don't really know what the above means or what problem it's supposed
to solve.

--zN/UJhV2gvyhY9D2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVAB6SAAoJECTWi3JdVIfQF98H+wfuLk8ih7hLPb0M82LgRRu0
zuTsLDbhahppU75QlvKU7OSRHF9JbC3KzXNbGOSonEtrEE1Zmec1eXKVEfrWQxpP
2cLPMMtI6r3yu1IMqkTtDm1qSFzdwDnMa9Z0VGNTz5ESFiMiU3CJw+nKoPnvfQ2w
m8bkNkZgapkpkEwVBPpdS9C//r3BYfl2kAuCZmXqTiIXiv1XGis4LYBOYpKzLCum
W+NaC51XbG5esIxvWW+oUOnwQcqoU70H6yAe+Lz/EEmyh3Dnib7YCuYdjTjlvGQt
mhOlu4KAgEVT4hHoayTufUi025P4UzEo1MeMeli9x6uh7iBjOHputLuDc6U/sSA=
=FmP6
-----END PGP SIGNATURE-----

--zN/UJhV2gvyhY9D2--
