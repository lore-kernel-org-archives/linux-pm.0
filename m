From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v5 00/11] power: supply: bq27xxx: implement individual
 chip revision support
Date: Thu, 12 Jan 2017 03:54:42 +0100
Message-ID: <20170112025442.kdxt77bm344fme7k@earth>
References: <1482369743-79764-1-git-send-email-chris@lapa.com.au>
 <1484099088-452-1-git-send-email-chris@cpdesign.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7mu2ryhzdjjajbvy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484099088-452-1-git-send-email-chris@cpdesign.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Lapa <chris@lapa.com.au>
Cc: pali.rohar@gmail.com, afd@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--7mu2ryhzdjjajbvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 11, 2017 at 12:44:37PM +1100, Chris Lapa wrote:
> This patch series correctly renames the patch subject prefix to
> 'power: supply: bq27xxx'.
>=20
> It also fixes up the deprecation of the BQ27500 and BQ27510 definitions.
>=20
> Otherwise the patch content is the same functionally as the v4 series.
>=20
> Chris Lapa (11):
>   power: supply: bq27xxx: rename BQ27500 allow for deprecation in
>     future.
>   power: supply: bq27xxx: rename BQ27510 allow for deprecation in
>     future.
>   power: supply: bq27xxx: adds specific support for bq27500/1 revision.
>   power: supply: bq27xxx: adds specific support for bq27510-g1 revision.
>   power: supply: bq27xxx: adds specific support for bq27510-g2 revision.
>   power: supply: bq27xxx: adds specific support for bq27510-g3 revision.
>   power: supply: bq27xxx: adds specific support for bq27520-g1 revision.
>   power: supply: bq27xxx: adds specific support for bq27520-g2 revision.
>   power: supply: bq27xxx: adds specific support for bq27520-g3 revision.
>   power: supply: bq27xxx: adds specific support for bq27520-g4 revision.
>   power: supply: bq27xxx: adds device tree binding documentation.

Thanks, queued into power-supply's for-next branch.

-- Sebastian

--7mu2ryhzdjjajbvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlh27/AACgkQ2O7X88g7
+pr96Q//f7X0WYV4N26Vtac+tqCpT7ujZxAze1wsvyeXfCgzH+ANBhAUCyusBxHr
ox0zeDwIgm1GEBUodNEBaPz1Vq1cWVl9OgO/oZUnxhrbf5YHOvpmJxK3qKT1hL0c
Prg88dZY8SApCkiP7HXMEtLJzrNf3kOgUHbz+dnaXL2y2j6AQdJZgzFcvcAgNMcZ
FAdhoNU70asRmqERICQg37ySH/jlGyZJovXfUMuRvZR4PpwWl32toLnJJ236VAad
OlLyshGlON+N7JGJuuuBjLjvcPVMvfrs4ZrNAZhJhDsgmjfINK3NKmvB038n7+Je
eQK/i8qscQ6iwhaqkRujK95cBFi6UkyHW9U4C5evVRHvajJhJFdit+bzlHnM1Miv
HZtQJIwQqeJPhWcgm3xoSg5NG+tnmlB8DtZByVVAnCuPf08LrA6z1Gt9/F77dCam
HeHBd8BD4ayr3w7A8ZfQuBfxNvVq+fx6fjE+SAKTGWi902xtRm90UPUgM+MXSoBj
2IwPk2JYewmg7qQC9+ee8evX4NWsvlJ1foysH/ZXXlKcOSMD1TtUB7mfAltWL2JE
MygPecRB443wI/wj0+t2zg9PzdfYT03z3OE8Rydt7XpSn0XdvwoNk50+uSpjKn+n
0BOrg41nkRaih/s+ZGr43WnQZnNLARHbACU6iUNt4hNDUXqjVzs=
=DFFB
-----END PGP SIGNATURE-----

--7mu2ryhzdjjajbvy--
