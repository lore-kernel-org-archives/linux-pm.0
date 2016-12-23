From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/2] power: supply: bq24735: poll register if no
 ac-detect gpio
Date: Fri, 23 Dec 2016 02:38:48 +0100
Message-ID: <20161223013848.oiuutehq6zcel4y4@earth>
References: <1482355793-16190-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mv23swo7d3vnlpk2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1482355793-16190-1-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--mv23swo7d3vnlpk2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 21, 2016 at 10:29:51PM +0100, Peter Rosin wrote:
> My patch [1] "power: supply: bq24735-charger: allow chargers to share the
> ac-detect gpio" is perhaps a bit hard to digest. And while I still think
> some way of sharing the ac-detect gpio is worthwhile, I thought of another
> way to solve the problem at hand. Instead of polling a shared gpio, it's
> as simple as polling the chip for what it is outputting on the ACOK pin.
> And the code is already there! It just needs a tweak to allow this mode of
> operation.
>=20
> This appears to work just fine for me, and the difference is in the noise
> since my shared gpio pin happens to be on an expander on the i2c bus, so
> I end up with i2c traffic for each poll either way.
>=20
> Cheers,
> peda
>=20
> [1] https://lkml.org/lkml/2016/12/13/786

Thanks for your patchset. We are currently in the merge
window and your patches will appear in linux-next once
4.10-rc1 has been tagged by Linus Torvalds.

Until then I queued it into this branch:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/log=
/?h=3Dfor-next-next

-- Sebastian

--mv23swo7d3vnlpk2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhcgCgACgkQ2O7X88g7
+praEg//ZNclJCKKFHk23FWnCI9C2Y12dHWP4dabEzc1s10pt54DSqlrlH7hzbyo
Qh46r87fOE/nPb24sbvsg2pSXFVSTT28FdZcphksC24Dwbn0imwKs6LI286qA8Xd
9KD6Itrtse9n6GQu3gKkgUQYQ75QNCTgEy7H88FLa+8zfaADRjaICWrgMwWTpI6a
wckGBPMwgrT63Y8fNMcvwmA+rlzmPqAXVpgiGBdw23eC+GJVD/gFzx1JyHPusP4l
4pGst4GOndfqrGRIZNG4zrF64ZLaoZ8aAs6FgS/kwXLa1ENbvK1Gs1OltTIPwoKJ
N7k9NY+pAqi8z1Dk2NHJO5Jf4VWJhNzvqy7PVi5Bpddwc96Qbb0Ct2mIFMSz/xwe
GY4/UMlF6L4oGJBNoXded/LtvjiVPmduCDo+If/zYBWDQml1S0ALqfyBjSPt+dob
5PJbkodZILwVUAynTRs28mpnZwFK2UzmB9E8gg1ofP6rsJ4MujKEzr8Xaofq092V
+1KzumZk2Hppkv28732FJh3n8KPeYSKvJAhb33RQIgKneYUd0ioO8NwifIwezzL+
pRBnutaVy5ZvFndzlyp7VPfIm0dGAj+KXqzrRapSTDiMC6ft2P1RTD0VmF4kTg+y
FVK8qY4nF//5ZkAC1QqxC1xE8EO9Kd5aTp/vp+TAZU0+a7GaTvQ=
=dJP2
-----END PGP SIGNATURE-----

--mv23swo7d3vnlpk2--
