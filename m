From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/4] cpufreq: mediatek: add Mediatek cpufreq driver
Date: Wed, 11 Mar 2015 12:46:20 +0000
Message-ID: <20150311124620.GC28806@sirena.org.uk>
References: <1425458956-20665-4-git-send-email-pi-cheng.chen@linaro.org>
 <CAKohpo=c2t4_2hdPP-vQM7xewK5SXaHBGNA9PhvTwDv3++pSTg@mail.gmail.com>
 <CALx668VypyWbVuph0ir0SRt4kqASvYzwBuyc_r5tFeoHi+HieA@mail.gmail.com>
 <CAKohpomxXTP6NdPoSmB=eq2sFqqgskS5vYtDNAT6a0VL5K6dCg@mail.gmail.com>
 <CALx668VFRdeWcK_gKhJrJehnaH5uDpA0m2OfHLqPVUq8oocXaw@mail.gmail.com>
 <CAKohpokT7fSniPGX2BfM61AtMoMCxEP8WDtbZ34bozUXscEWyg@mail.gmail.com>
 <20150311105307.GW28806@sirena.org.uk>
 <CAKohpom4riOhzc3hK8B2tiSwGx0zG96C7QNeQB0yZaPMd_OpLw@mail.gmail.com>
 <1426074142.30734.7.camel@pengutronix.de>
 <CAKohponaQYYgYFAbpY3KZjt4+QhjBsqQtEpG5QpdMH0p__YUEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3l764Q7zY5HuAgsB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKohponaQYYgYFAbpY3KZjt4+QhjBsqQtEpG5QpdMH0p__YUEQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lucas Stach <l.stach@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Chen Fan <fan.chen@mediatek.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Howard Chen <ibanezchen@gmail.com>, "Joe.C" <yingjoe.chen@mediatek.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, Pawel Moll <pawel.moll@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Eddie Huang <eddie.huang@mediatek.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>Linux Kernel Mailing List <l>
List-Id: linux-pm@vger.kernel.org


--3l764Q7zY5HuAgsB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 11, 2015 at 05:16:42PM +0530, Viresh Kumar wrote:

> I think until the time we revive the voltage-domain stuff we need to support
> mediatek's driver. And probably a virtual regulator is the best approach
> unless someone else comes up with another idea.

Why not just write a custom cpufreq driver if it's too hard to abstract?

--3l764Q7zY5HuAgsB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVADkbAAoJECTWi3JdVIfQRnMH/iGMkf3/S0DoSz9venn5GInN
QLnusP6YSaztjFkp9a28fKtF3OMNmBFI2h92BweNyQy1SMpaKFVerQTuHajBYK9J
g4Xhoe5KjvZoZZD5OmMYpjrakmp4QEkSBvBMRFD/65HL+IHEsSc31vXstg3HZbJ+
akEkvPzni/4C9xY+7Z5NWhleahJ0Wm2VXCOFqRpo/fpjxAkwpQ1PYsnZDfZP5vLj
FjNLIc6k6iVxTFWb6eEtn0SJfx+fBwQc4mj34tNzER5yJem7O/NCXMAPmI/dhapn
U7k9FqZpCu52MxgDT+8K/F+zdCmq6oAWankEymK8ycQnGA6RwKKBB06UqF/l60E=
=H1aC
-----END PGP SIGNATURE-----

--3l764Q7zY5HuAgsB--
