From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/15] Add support for OLPC XO 1.75 Embedded Controller
Date: Sun, 21 Oct 2018 23:45:54 +0200
Message-ID: <20181021214554.i2mb5yn2doabyt5a@earth.universe>
References: <20181010172300.317643-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4634300731478293321=="
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20181010172300.317643-1-lkundrak@v3.sk>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, devel@driverdev.osuosl.org, Eric Miao <eric.y.miao@gmail.com>, James Cameron <quozl@laptop.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, Andy Shevchenko <andy@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============4634300731478293321==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jnox64lrvnzk7wym"
Content-Disposition: inline


--jnox64lrvnzk7wym
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 10, 2018 at 07:22:45PM +0200, Lubomir Rintel wrote:
> Hi.
>=20
> This patchset adds support for the Embedded Controller on an OLPC XO
> 1.75 machine. OLPC XO 1.75 is a MMP2 based ARM laptop. It plugs into
> the existing OLPC platform infrastructure, currently used by the x86
> based models.
>=20
> The EC operates in SPI master mode, meaning the SOC is the SPI slave. It
> uses extra handshake signal to signal readiness of SOC to accept data
> from EC and to initiate a transaction if SOC wishes to submit data.
>=20
> The SPI slave support for MMP2 was submitted separately:
> https://lore.kernel.org/lkml/20181010170936.316862-1-lkundrak@v3.sk/T/#t
>=20
> THe "power: supply: olpc_battery: correct the temperature" patch was
> already sent out separately, but I'm including it because the last
> commit of the set depends on it.
>=20
> Tested to work on an OLPC XO 1.75 and also tested not to break x86
> support with an OLPC XO 1 machine. I don't have a XO 1.5, but it's
> unlikely this breaks it when XO 1 works.
>=20
> Thanks in advance for reviews and feedback of any kind.

I reviewed the power-supply related patches (1, 10, 12-15) and think
they are fine apart from the things found by Andy Shevchenko.

-- Sebastian

--jnox64lrvnzk7wym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvM848ACgkQ2O7X88g7
+pqfnA//TKs8BES/kjdXsbsj0Q2N00S/gqI2yAJfPVzPjGUx8CwKBsRzW1yiQa5L
PLupI4oHdeRkThPP8o3aS1kLwHuJXxDt9VWCNQl98LpoTPs9iTDGfraFfSlVSFYG
arjQBKbPBt1wLt2hsEOgiipPA9nNZM+rFcO3nzYbTKgmf+wQ+bpKettsf/3qDeNV
3ZPj2LK/WX3jY0cnIw2y1vuR5PJj4eBsPwWC+FeOj63JJBtCHfY6jvfMv0rcOOz3
u9AQQJdhd23BK5xWT8qrOQ0OPLWvr9sFpImAvUjwT52okULTzCUJsFUR+X3iWHBg
FtHSUjwzf4tMVHQFsQmUGOdjrzXNnAOFs+OV3r/MHRNPc/eHHSE1GfPlgE3o0MBp
dFFs60geDQStMBxkGnCi1ILoU2pzOkBG/t0Hzd0rWGHWJPYApZIv5yJ8b/EBO+nJ
+e5/dXhe3d6lpdr6mECRoMXnpeGZAmhX95LLi6CdyMb9BfZVP2PVugBeD3pIaGwH
sEj21DXPTFM1lhgKFjD884E2CQEEpnxRhbcLCnpDmFjkt20h8irChVqq3NPaCphX
+4DgSj3ZRE9EgNNWgAA2K4UoJFupeGxk9EatMxMpxWybnoYgwyBg+SFZeh/v7LJt
9LC2H1BGBA0eP1A6UUc+ETcV9Qj2C/BGVbbKUfR7hLCxrx8WDaQ=
=Xjo8
-----END PGP SIGNATURE-----

--jnox64lrvnzk7wym--

--===============4634300731478293321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============4634300731478293321==--
