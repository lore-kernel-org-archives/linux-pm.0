From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [RFC PATCH 3/5] thermal: Add support for the thermal sensor on
 A23/33
Date: Wed, 29 Jun 2016 15:42:09 +0200
Message-ID: <20160629134209.GE6095@lukather>
References: <20160628101325.2522-1-icenowy@aosc.xyz>
 <20160628101325.2522-3-icenowy@aosc.xyz>
 <20160628114640.GE5550@lukather> <60021467122182@web19j.yandex.ru>
 <20160629121021.GD6095@lukather>
 <1112501467207099@web30g.yandex.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3459195704307295037=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1112501467207099@web30g.yandex.ru>
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


--===============3459195704307295037==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WlEyl6ow+jlIgNUh"
Content-Disposition: inline


--WlEyl6ow+jlIgNUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 29, 2016 at 09:31:39PM +0800, Icenowy Zheng wrote:
> However, sun8iw3/5 ths is not even a GPADC... It's a specified IP,
> only used as an ADC suitable for temperature sensor.

It doesn't matter. It's the same IP, labelled differently.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--WlEyl6ow+jlIgNUh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXc9AxAAoJEBx+YmzsjxAgp/IP/jQa7fDmZqGh+u6mIm2hXDm3
RmcbTls4tOJ4/s7mL+uroQYIgKG1eYYzdcrWynJ3w+K692fZNbKn/gnxvUM46fM0
a1gEILtd1zCoVrvfBUxEe0OuiFlO2JNOyXtrLhwgswogHA0OjEbszJlq6eDTK9VL
1YKY5e875LrCHB4rV+wOIMTEPXdW++7O158dpct/kqT4LdjJlk/9P8ova9wi4Vld
BP57maIDwIlBvtd1DqDFbr9as1vbLew5q8s7wxGtZ/n8N1FpBm8vwobGygWRLJaV
JuuY4SD8jO6qxmv6OXA+o23GBcwQe4eh7PGek/NTtnAavDlnxA/qHPkfb5thupjJ
caddJ2MvTA5Z0VmvqElWMpkycUnmQVZSreWnpGXiFhQ6eLDj2KSx9LVP9gFniQpA
28h6s0TRrUsbQy3X0Kd8dcXkUZbz+7dG1yxjB9rlzZhTYHlAhI/iVM1ZK1OMl3Ah
fu05GRyEEudEo3cf09BhTlnhJzpdx7WJrl0y5ILmVOBFQR6jRrYeODi/PDAtTRKU
AEU1FlWgNHH3ngkeyAzg2zo8wT1bX8T6aMOWIxGjiNei/ploXhPyTxl/xqhfDuEQ
JbwnxrRtY5OqBqugw64wOlOu40d2dEmufrLKmZinLhQxhrgrvQNkjuHlFAh2O8c8
wUw9Mb2oVPwSnA3/z4hA
=603y
-----END PGP SIGNATURE-----

--WlEyl6ow+jlIgNUh--


--===============3459195704307295037==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3459195704307295037==--
