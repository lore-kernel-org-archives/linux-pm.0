From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [PATCH v4 5/4] thermal: rcar_gen3_thermal: restrict to 64BIT
Date: Wed, 7 Dec 2016 09:51:51 +0100
Message-ID: <20161207085150.GA1724@katana>
References: <20161201220442.22057-1-wsa+renesas@sang-engineering.com>
 <20161202204422.21832-1-wsa+renesas@sang-engineering.com>
 <20161207003956.GA12562@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161207003956.GA12562@localhost.localdomain>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-pm@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2016 at 04:39:57PM -0800, Eduardo Valentin wrote:
> On Fri, Dec 02, 2016 at 09:44:22PM +0100, Wolfram Sang wrote:
> > COMPILE_TEST triggers problems on 32 bit machines, so limit this driver
> > to 64BIT for now. This is no loss because the hardware is only available
> > on 64 bit SoCs anyhow. After we obtained more data from the hardware
> > engineers, we will refactor the code to be usable with COMPILE_TEST.
> >=20
>=20
> Don't you want to fold this one into patch 2 and mention the limitation
> on that patch's commit log?

Yeah, will do with V3. Didn't want to resend before the next review.


--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYR82mAAoJEBQN5MwUoCm2KEEQAKdujVFlj86XUFBTQfpEEYgO
vZldEEEcMadnFDTrPtTt4Pt9Kcs8UozQ+oDYy1uv20HZ+YteI6h0yCTgyuS3sLR3
W/WVxc246T3QTyCZrNkswnm3tBYLXgMOqn4vgPKf5dDgge8XBPG3rBj7U9vkA3lS
DrUwlBi7c4j1IsH3HtCOHdMRvGaJ/otnrnb4GL8E1DmX0N8e/8McSwyB/PZQfoBr
nTVLmYsxbGJdpktrz0ByAAP1X9glO688e5R8Hs1EqBt2p3/1Bbv2H3BL2xlSmb8f
5N3bky7KBFuAQU3k5u30jJ2Mz0prHZCUBnk6t9+FmBGxi1sDA5iTd9OABu+PUCJO
tn9LOt6nXVLsQFfeoUP8M1Hlgu1Iwq0pbWWw/LssM11uk8cboUft8j6IScC7h4mA
BZ3peNFphyZM0s5Jmqkb+nMFR7agtGAW2ciMAdh5QDzVd12nJeZXKUNHWgz68sXO
ZI/orThS6TMudtCvrKf6/2t4azwct2ZIcWIxBPb3SHVvfrXcRR86g4IMXUjnjCeo
ZvJQsqZeWt9Brt0zLhXmR6WYRXnVZs36zXvWQ3eONAecu1VSOQQc4vUl4fhpJurh
/0j7RM2TiHqCyHwjD+mG3rJyrK4pADBBM/A0RlCKXl6WIJn7TlakQOOLAQXrztLx
Iype87xSYku8bsEI55x5
=61OM
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
