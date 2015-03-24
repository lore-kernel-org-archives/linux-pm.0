From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/7] ARM: dts: enable regulator support for i.MX23/i.MX28
Date: Tue, 24 Mar 2015 10:01:13 -0700
Message-ID: <20150324170113.GO17265@sirena.org.uk>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
 <1426984203-9133-6-git-send-email-stefan.wahren@i2se.com>
 <20150323060706.GB4946@pengutronix.de>
 <1469391177.549604.1427133274978.JavaMail.open-xchange@oxbaltgw02.schlund.de>
 <20150323183740.GI14954@sirena.org.uk> <55110813.7010708@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5784214920177159485=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <55110813.7010708@i2se.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: fabio.estevam@freescale.com, mark.rutland@arm.com, marex@denx.de, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, dbaryshkov@gmail.com, viresh.kumar@linaro.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-pm@vger.kernel.org, rjw@rjwysocki.net, lgirdwood@gmail.com, sre@kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, kernel@pengutronix.de, galak@codeaurora.org, sebastien.szymanski@armadeus.com, shawn.guo@linaro.org, dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============5784214920177159485==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jozmn01XJZjDjM3N"
Content-Disposition: inline


--jozmn01XJZjDjM3N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 24, 2015 at 07:45:39AM +0100, Stefan Wahren wrote:
> Am 23.03.2015 um 19:37 schrieb Mark Brown:

> > This might be the sort of thing normally handled by a system controller,
> > I have to say I had assumed this had all been discussed in the previous
> > iterations of this seriee.

> sorry, but i missed this important fact.

> If you speak of system controller, do you mean the usage of
> drivers/mfd/syscon.c ?

Yes.

--jozmn01XJZjDjM3N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEZhYAAoJECTWi3JdVIfQvcwH+QFCd7pZyEIoNm6PX7a1fADG
OO/gKNZjlegdPIhtha/6u5pGCdwXs6v0PNHT4NDCFLJlKDgCHSxKKbN8aA7x3FVW
ZFNpva9VMZ08llrExAth7n0ptKHbfhUxrnDSSKmCHkYLbb2H8cJ/wY6QIv8Ltou3
ZKlr/eQUG0VncwM8Scp4tkdVN1AXlpmehRy/H/IvOAQBOPhW4f0uJdeI//iprIHA
8gSyV75O3wLJgUeSuguIGvO1x2BbQW8yXRB1z/c+ZYn5ZGV34wNuZLJteHwhXbsw
bTLcteRDpuargfziJrj4srm49qIzxpCO/LIjqnoMuA50LBAy0GpQGlChvicyKXw=
=ZnWV
-----END PGP SIGNATURE-----

--jozmn01XJZjDjM3N--


--===============5784214920177159485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5784214920177159485==--
