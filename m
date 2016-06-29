From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [RFC PATCH 3/5] thermal: Add support for the thermal sensor on
 A23/33
Date: Wed, 29 Jun 2016 14:10:21 +0200
Message-ID: <20160629121021.GD6095@lukather>
References: <20160628101325.2522-1-icenowy@aosc.xyz>
 <20160628101325.2522-3-icenowy@aosc.xyz>
 <20160628114640.GE5550@lukather> <60021467122182@web19j.yandex.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5696923692927816473=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <60021467122182@web19j.yandex.ru>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Icenowy Zheng <icenowy@aosc.xyz>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "emilio@elopez.com.ar" <emilio@elopez.com.ar>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "wens@csie.org" <wens@csie.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org


--===============5696923692927816473==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ytoMbUMiTKPMT3hY"
Content-Disposition: inline


--ytoMbUMiTKPMT3hY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 28, 2016 at 09:56:22PM +0800, Icenowy Zheng wrote:
> The reason for a dedicate driver is:
> 1. This IP have only thermal function, so it's not suitable to use a
> driver at drivers/input/touchscreen/.

That's not a problem, and it's being worked on [1].

> 2. Control Register are quite different.

That's not a problem either, there's just a bit that you don't need to
set in the control 1 register, and that's pretty much it. It doesn't
justify a whole new driver.

> 3. This IP uses AUDIO PLL (PLL2) as its clock!

It's listed as the input, but all the rest of the documentation refers
only to 24MHz, which seems to indicate that it's only running on the
oscillator, which would make much more sense.

Thanks,
Maxime

1: http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/439487.h=
tml

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--ytoMbUMiTKPMT3hY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXc7qtAAoJEBx+YmzsjxAg+gAQAKuIc+HZO+maeW9Ukek80wGz
6Z+szxNy/rnxw2yv7uB/RNBPeCovY1huC6TTwrpXeKrUnpynRTHt5++CcL0Ps+4Y
YB+DrTssXiKc9YVHSoCcsZrZrlf85M2Y0jmL8IT6ZOfIdLBKQWc3ODNrgnDRqKu0
X0mgEI6oTM32XkVXqAR+1n6xKpx1TF9A7WJqFJHAdJ1QxhAzuTvZ8uiAd7BNUREM
wYfX4/toqj3WuZutpqx+3gRjDLQSmu5GGdcvoXT5nhMH7FxObrBEpLZVydzL4O4n
aKuM0d5aUJkWJwPDehRCASzcMnqkXZlIj0ve4kPsd6YcA2sW/LN9qjDQY5i/Dwfe
A0gv+uyVEzeWyEeR/sxWsO/joAG1GxbqPopuqhurHahZoCkd5WoJtOSk+JHY92ib
2C0Nep4dsGXuM+44AARe8LKKMtEbdQDJVIYTijheZ7bJ0BQnvUBr/DFdH/Bs6Qow
+fhjXVrpghXhzmKCktbRTpnB96+Hj07hha6iB1pSpB810IhF4v+BXjSvTRBEbpZf
ifMjFKXAtyEW4nozTlL9RhD7dsQnrQG58Zs3b/OTWTKbaRZh17G/c9XPd6XQEUii
Z9dUXWd1LFKsNC+B2nFgWtHtIHgn+xWiW+Cud0FrNuSsP6GliOVb2kEbssd5v2ZN
/Ae9RO6SDMjTiz7o9zaS
=Mevt
-----END PGP SIGNATURE-----

--ytoMbUMiTKPMT3hY--


--===============5696923692927816473==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5696923692927816473==--
