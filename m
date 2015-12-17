From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: rcar: disable runtime PM correctly in slave mode
Date: Thu, 17 Dec 2015 20:39:07 +0100
Message-ID: <20151217193907.GC1530@katana>
References: <1450292718-11951-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450292718-11951-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 16, 2015 at 08:05:18PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> When we also are I2C slave, we need to disable runtime PM because the
> address detection mechanism needs to be active all the time. However, we
> can reenable runtime PM once the slave instance was unregistered. So,
> use pm_runtime_get_sync/put to achieve this, since it has proper
> refcounting. pm_runtime_allow/forbid is like a global knob controllable
> from userspace which is unsuitable here.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-current, thanks!


--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWcw9aAAoJEBQN5MwUoCm2AVcP+wdMLl83gMeg0K6RDiCYm817
71luAhK+f5L9xAq0sjs67m24F+G3igkE4UuDHtKWDKnc6j4oSpj8BoYbIGJikFLh
oqDCwK0dOuXPjnVok6Rp+XF0/VFrD34uhudvbZBP9e3aKygBtZY2C9hDbQdTP5gS
/p6mCLaCKQwAcFhfmHUW2PuUeeoy7r9Pt2fE5tnUV+AB2aTd2IEfJOkI9phDgUO4
92ddu2j8il1YM2RFxjt6Z7QzlcTu/+NCuShzng+PUXj0aHHT9EsrRPzyO0ZEEcuT
C95NkOhYnNdOQnHesDE8APb4fkMpM48ODKppch9u1ePPS+VijZBSmlw/PffrW5yW
fTxXJJlXz81qvDB3sI+RT+9NNT02IRAfUG6Vh3BTsopvxBzHSo21mRDkWtzx3Kw0
heRVMi+uBK7uktwWteXOvXszrz2UKpBUDpANP6hnZpZQLwDcApNapDbZR+f7FIQd
0D4r8/VWNOfKr/gQMZE8pclvkcbN4oV1bG5B0+hNAvRSVVVl+gxHU0jBwqKs0WO6
bvKyHVT36O0kOsKE0KO13ARvnwosk8CE2MqMKLQjkSDqGwvQ8TVxpNFMkS5knI1p
3TvQUtzHi/h2USam1m7haGAQ5PxUggNwte0Rk4pgcdIW8UNuO1hxMTrmMI6nOJm7
ytkmdGlo8ShCRkCwPxq3
=Mssd
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--
