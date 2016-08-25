From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v8 00/11] power: act8945a_charger: Improvements
Date: Thu, 25 Aug 2016 09:59:35 +0100
Message-ID: <20160825085935.GH22076@sirena.org.uk>
References: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7575142902590356206=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wenyou Yang <wenyou.yang@atmel.com>
Cc: devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-pm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Kumar Gala <galak@codeaurora.org>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============7575142902590356206==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+E165xXSMiO4rFaE"
Content-Disposition: inline


--+E165xXSMiO4rFaE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 25, 2016 at 03:19:48PM +0800, Wenyou Yang wrote:
> This patch series is to improve the implementation of act8945a-charger
> driver, such as regard the act8945-charger as a sub-device, improve
> the way to check the status, fix the power supply type property,
> add the status change update, and add more properties: capacity level
> property and max current property.

I don't know why you're copying me on this series but can you please
either stop or let me know what you're looking for me to do with it?
It's quite large, is getting resent regularly with frequent replies and
I'm never quite sure why it's there.

--+E165xXSMiO4rFaE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXvrN2AAoJECTWi3JdVIfQbf8H/0tbDEoLn+WNe9KsmcI0HM1L
ToBlyDkG+Zgr6vBw5XOlGQd8uC5ZPSEOLJqRiiMukhmfY1tXuflGkaURP2Zhstag
qAA16mJO6e5c6LpP30MHHtBNIO+vdgjcYTDV8Yz4UrPmYRJqPGR7c9gIc+cZIoFb
dvEy4HSmCo6xOWPOLJa/Qi9h8MHZrwMl4tvu1YxWh7Hp9CRfikwsQy1baHGzDofb
16LW6+77nVvL5sUNDDD5xUF0XS0x9EKpD2kHHJ4tMlxA5+p3V/R7uZXcf+eeoC5J
jtznTpePFipWYn+CaeezrvlKufv2/NvLcfc7O5YlNnaKcj2IwgWGyc68xv6tVjE=
=029Y
-----END PGP SIGNATURE-----

--+E165xXSMiO4rFaE--


--===============7575142902590356206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7575142902590356206==--
