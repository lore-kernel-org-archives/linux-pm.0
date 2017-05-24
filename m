From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V4 00/17] thermal: cpu_cooling: improve interaction with
 cpufreq core
Date: Tue, 23 May 2017 21:03:08 -0700
Message-ID: <20170524040306.GA3501@localhost.localdomain>
References: <cover.1493115651.git.viresh.kumar@linaro.org>
 <20170524024148.GA5004@localhost.localdomain>
 <20170524035352.GO6510@vireshk-i7>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36760 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751698AbdEXEDN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 May 2017 00:03:13 -0400
Content-Disposition: inline
In-Reply-To: <20170524035352.GO6510@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linaro-kernel@lists.linaro.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Punit Agrawal <punit.agrawal@arm.com>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Viresh,

On Wed, May 24, 2017 at 09:23:52AM +0530, Viresh Kumar wrote:
> On 23-05-17, 19:41, Eduardo Valentin wrote:
> > Hey,
> >=20
> > On Tue, Apr 25, 2017 at 03:57:07PM +0530, Viresh Kumar wrote:
> > > Hi Guys,
> > >=20
> > > The cpu_cooling driver is designed to use CPU frequency scaling to av=
oid
> > > high thermal states for a platform. But it wasn't glued really well w=
ith
> > > cpufreq core. For example clipped-cpus is copied from the policy
> > > structure and its much better to use the policy->cpus (or related_cpu=
s)
> > > fields directly as they may have got updated. Not that things were
> > > broken before this series, but they can be optimized a bit more.
> > >=20
> > > This series tries to improve interactions between cpufreq core and
> > > cpu_cooling driver and does some fixes/cleanups to the cpu_cooling
> > > driver.
> > >=20
> > > I have tested it on ARM 32 (exynos) and 64 bit (hikey) boards (haven't
> > > tested the power specific bits).
> > >=20
> > > Lukasz from ARM has been very generous in testing and finding out few
> > > bugs in the earlier versions and getting those fixed.  He has
> > > successfully tested the new version on his ARM big LITTLE Juno board.
> > >=20
> > > Pushed here as well:
> > >=20
> > > git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git thermal/=
cooling
> > >=20
> > > V3->V4:
> >=20
> >=20
> > Took this version into my -linus branch for the next merge window.
> > Including the patch to remove the checkpatch warning. But please send
> > an extra patch to fix the style pointed on patch 8.
>=20
> Thanks Eduardo.
>=20
> But I am not sure what's left there to be fixed :(
>=20
> There were two warnings with patch 8, s/kmalloc/kmalloc_array and line
> over 80 columns and both were fixed by the patch I sent separately.

You are right, you are done here. This was probably a bug in my script
showing old checkpatch results on patch 8, somehow.

Sorry for the noise.

>=20
> --=20
> viresh

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZJQXzAAoJEA6VkvSQfF5TVlsQAJ4Qk9LBNfBq/flaOpL0gdTc
/uCpVsitw0lfXr2TmVFvVv7s57LisVvzI+cnIMpm5yOdRxeyl9NUO0YBKDYJykKB
taNbr9QGEBAmZxqCYBffi/odbCiSz+q7Zkvb0U6gDBu9mmtHwesSPVTFCY909OcP
BBkm9H5cwreScEIwHoUbeNIqC/Wk7TntKzaBROelHO0ZewHoNF4LI1zVpILabTbY
3mZVnexbNRvI4I4HCTYlI/oxZbiNL2wR4ROpukQX8ujKwVMuDJDcLYVWE/rUTCRT
1wjmUXCsSbpvpS2PO6YOMRTaln+rKKaUiz1voqJPtRlb9gQRlGZE7/s4QRi3xlec
3tzDlFI+OWCGd20h/g6NFYR1i38rqkVlEKPfqy0w4tNuVKlU2jhKWMcjXeTMzNKw
7EoOUO5f95/ov1u0nZlTAe/c6yXsmecG7nSW8loUnOnbtnYijxvIEOlkadjlKql7
BoHY/bWpBzKtffwj7ipqPegKMozYZJ7NZ1EIsgQX6Wink4BHYBV5JVfxPVWBGwsn
1yKr/8Dncxq6aiMlRYm8TnjAMOWu63zhujBRotPhipjOWqNKKN9EExqNH9wOB0fk
UQf74ID3irOTDQGMupT/XCfvPtwNIU0IkyRJzzJIHRqL32gzLChYBnfETYLSpHS2
Z5PHGAr5WS7c8vci9nRX
=w3wp
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
