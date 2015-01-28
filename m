From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC V2] OPP: Redefine bindings to overcome shortcomings
Date: Wed, 28 Jan 2015 20:06:00 +0000
Message-ID: <20150128200600.GR21293@sirena.org.uk>
References: <cbe949d7a69c3b16a3e9d6e5429eb81d3ae9d8b9.1422009157.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7284111937237183172=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cbe949d7a69c3b16a3e9d6e5429eb81d3ae9d8b9.1422009157.git.viresh.kumar@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: nm@ti.com, rob.herring@linaro.org, kesavan.abhilash@gmail.com, linaro-kernel@lists.linaro.org, catalin.marinas@arm.com, linux-pm@vger.kernel.org, sboyd@codeaurora.org, santosh.shilimkar@oracle.com, Rafael Wysocki <rjw@rjwysocki.net>, olof@lixom.net, devicetree@vger.kernel.org, mike.turquette@linaro.org, Sudeep.Holla@arm.com, grant.likely@linaro.org, ta.omasab@gmail.com, arnd.bergmann@linaro.org, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
List-Id: linux-pm@vger.kernel.org


--===============7284111937237183172==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Cs0fHyJFdv98avw5"
Content-Disposition: inline


--Cs0fHyJFdv98avw5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 23, 2015 at 04:14:50PM +0530, Viresh Kumar wrote:

> +- opp-listN:
> +  List of nodes defining performance points. Following belong to the nodes
> +  within the opp-lists.

Why is there the N here?  It doesn't correspond to the examples...

> +  Required properties:
> +  - opp-khz: Frequency in kHz
> +  - opp-microvolt: voltage in micro Volts

I thought the goal here was to specify ranges?

> +- oppN:
> +  Operating performance point node per device. Devices using it should have its
> +  phandle in their "operating-points-v2" property.
> +
> +  Required properties:
> +  - compatible: allow OPPs to express their compatibility.
> +  - opp-list: phandle to opp-list defined above.

I don't understand what that compatible property is intended to mean and
I expect other readers might be similarly confused - is it a standard
compatbile property meaning this noe corresponds to some sort of device?

There also appears to be no code matching these bindings...

--Cs0fHyJFdv98avw5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUyUEnAAoJECTWi3JdVIfQMrIH/3wp7SZiW6k2SVgumUWp0APZ
a+Ybjr8gplR9gD02G0ooleKjBug+CsESEs3RByv6/Q/NOG6CluJTMJBSo3xMFKAy
2sAlZ3lgRkMv6Fv3PqBECB2guyuoRjS0MyyjN0LzO+i4jRKnz4vNyLyLp7FRzG5y
zg8i2+/gdtuNSlC6UcrByPN8BvC1qSjFJyR7rkitvvp10eRCiz5aUVA25wQTxwGS
dYqyCGpFTzpixzYvVWPw27Thq5YGdznPGKnLvO/1sNbJFqEEzlPd/6KSOlzz28fP
PzDeFy2WoZxQCzVEkAbvVGRNFc+4bUS13JrBMzwSpH2xqOPBa54J09wlgCBAKgM=
=kOGF
-----END PGP SIGNATURE-----

--Cs0fHyJFdv98avw5--


--===============7284111937237183172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7284111937237183172==--
