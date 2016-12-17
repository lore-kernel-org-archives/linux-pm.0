From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4] dt-bindings: power: supply: bq24735: reverse the
 polarity of ac-detect
Date: Sat, 17 Dec 2016 15:50:51 +0100
Message-ID: <20161217145050.5w7fkumgjipqdmbn@earth>
References: <1481881440-13464-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6pyfoagjgcpud5dn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1481881440-13464-1-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jon Hunter <jonathanh@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--6pyfoagjgcpud5dn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 16, 2016 at 10:44:00AM +0100, Peter Rosin wrote:
> The ACOK pin on the bq24735 is active-high, of course meaning that when
> AC is OK the pin is high. However, all Tegra dts files have incorrectly
> specified active-high even though the signal is inverted on the Tegra
> boards. This has worked since the Linux driver has also inverted the
> meaning of the GPIO. Fix this situation by simply specifying in the
> bindings what everybody else agrees on; that the ti,ac-detect-gpios is
> active on AC adapter absence.
>=20
> Signed-off-by: Peter Rosin <peda@axentia.se>

Thanks for your patch. We are currently in the merge
window and your patch will appear in linux-next once
4.10-rc1 has been tagged by Linus Torvalds.

Until then I queued it into this branch:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/log=
/?h=3Dfor-next-next

-- Sebastian

--6pyfoagjgcpud5dn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhVUMcACgkQ2O7X88g7
+prBLQ/9FamJiewo5l1chf3Cng/EqtbI5AtxAWwhlDneB1Iwl3+3fAK50Np9bjZp
usFVevkf9bycdRnOitenjJvcwGEl+hwL6yw+FLsGQH6nCBNEf5huk37Fxkfbu70s
j3irNao5OkJOagVF/wW82Hwp6b2/CkUuwqCaP1mKv5WJa6Kc1+1n+75A76y0Dmje
tbEMFDTzma6hh5/579cuebeWUCwuW1rzRlETjGx893IOA2VYHsJtHbeGNCUUckf/
YDwP9F2A+ZSAJnSiexVCvwx7h02q1680/siynlp+5KwXLvaekmN30U7yjdlVhHMw
ObGSMo1Zt8Qu82XL7LiBeUShUScgmksQXJF3f1kBYovXGMowObvCuboqkJq/AEZB
aw0JaLmdG+nrSwumJQu7/YvziyNccCDy3ZC5i5pGD+bCX8NhETc1EWlr5TFV1sWT
AUDcYWvd5K8Z3CSwe399w3zPcXt0BUIIGW/3Kxs6JaQfAnBbhXvOWxRedvP8ljZC
DudrKjBoef9dAyWD0ugGkkO/02+Y6pdtkfkcRA9MxnCdUuS9O/8kxO0icMiXXDx0
Kpd042fIFnTeBfvjbbPS1nklMkNLQRAXNkxlPzPMRgyacEiQE5Gf5i7jidFzbF2v
gAja+Z7lJSzSqcOApq2NSeZPCsFLA6IT6/Eq5D7MGIFPyTk8A14=
=T56F
-----END PGP SIGNATURE-----

--6pyfoagjgcpud5dn--
