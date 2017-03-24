From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 5/8] regulator: anatop: fix min dropout for bypass mode
Date: Fri, 24 Mar 2017 12:54:38 +0000
Message-ID: <20170324125438.5wy3r2mr3g5eaxvy@sirena.org.uk>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
 <cd944a7223cfe68788c299082a5f262e8bea2136.1490199005.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2818595801705483939=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cd944a7223cfe68788c299082a5f262e8bea2136.1490199005.git.leonard.crestez@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>, Irina Tirdea <irina.tirdea@nxp.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Octavian Purdila <octavian.purdila@nxp.com>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Robin Gong <yibin.gong@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============2818595801705483939==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dz6kxsv2xorkot4i"
Content-Disposition: inline


--dz6kxsv2xorkot4i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 22, 2017 at 06:53:07PM +0200, Leonard Crestez wrote:

> +	if (anatop_reg->bypass)
> +		anatop_reg->rdesc.min_dropout_uV = 0;
> +	else
> +		anatop_reg->rdesc.min_dropout_uV = LDO_MIN_DROPOUT_UV;

No, this is completely broken - you can't expect to randomly change hthe
regulator description at runtime behind the back of the framework and
expect things to work.  If there is a need to do this we need an
interface for getting the current value and a way to notify of changes.

That said I would not expect the dropout voltage to be considered at
all when the regulator is bypassed, since the regulator is not
regulating it doesn't need any headroom.

--dz6kxsv2xorkot4i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljVFw0ACgkQJNaLcl1U
h9AvYAf/TpiB7ItJL+A3pg4IFaSeA1CIu8UWkP7BjIJTWd0ocWsAd80stAe7gPKW
uUA/vu2waeiSVN/jkXqqKwyYTOVmCbj+0bY0wzgxlEXHsrHRPhYLv4JxufgvH0tc
L2J7JxG5YBsWfrDLgHXcAzWdZq5nzyhZiDyP/IRX0u8loiTzU0WlWoxpb48VfyWi
UsTKLZq7UeSVFipZmn1lEOp6w5z3PIb67XAQkgYSHUO6xKIECNSZ7ZiGGbsdh3PU
mQlxRL1X1R6zvW/DNHVwhSp8JcQ13AS0dtXPNKl1fFhbhE7e/kjr/aIJdZOJh/Xi
stL9akOic9UCC1eSKfhwlyxX/ytYjg==
=MXDG
-----END PGP SIGNATURE-----

--dz6kxsv2xorkot4i--


--===============2818595801705483939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2818595801705483939==--
