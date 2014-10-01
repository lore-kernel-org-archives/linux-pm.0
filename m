From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 00/15] power_supply: Fixes & cleanups
Date: Wed, 1 Oct 2014 17:08:29 +0200
Message-ID: <20141001150829.GB969@earth.universe>
References: <cover.1409831636.git.viresh.kumar@linaro.org>
 <CAKohponEJ+dC5Y4R1-e=YyHTknhrOu-DyPM63oCagfqqOzxA3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:33175 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751330AbaJAPIe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 1 Oct 2014 11:08:34 -0400
Content-Disposition: inline
In-Reply-To: <CAKohponEJ+dC5Y4R1-e=YyHTknhrOu-DyPM63oCagfqqOzxA3g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Anton Vorontsov <anton@enomsg.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 01, 2014 at 08:49:30AM +0530, Viresh Kumar wrote:
> On 4 September 2014 17:30, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > I was required to work on a battery driver and found some
> > fixes/cleanups while going through the core.
> >
> > First two are fixes and rest are cleanups. Please see if they
> > make any sense at all.
> >
> > Pushed here: git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linu=
x.git battery/fixes
>=20
> Ping!!

I merged the patchset two weeks ago to the battery-2.6 tree [0], so
they should be in linux-next already.

[0] git://git.infradead.org/battery-2.6.git master

-- Sebastian

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJULBjtAAoJENju1/PIO/qafhQQAJXv4fKkrOxpWBtWXw52bZ39
Hg5MNCbaZPoACdMhAorgZA0qbxZXfQQwDVsEK+pzeBYSHY8WBSQIiJMNCmicAmK1
IkR/U7YFJ68SEZ6tBOlL0xNdpdmhEK1agRFtV0LtPFT7gomDnoS8Kb4Sd/LwffqQ
e2wk1gX1I4iWg2zeOOeC48/cI03NS9SRr2b2hyqkfoE5hg+QG2jxaWMQq1gEyDbV
499tqxtj1H4MICrziFaCAOmIOB9tNoQ4Affi8n9yL9Mg0qmE0wjCaHF/0iKZvDE0
cIPO/0SyLty9WYcL4QOezmUBU7sSPUvtiAmmf2v7Z2/RP3L4m61tpG18XYpQvWGp
LjTQPd/aFvfPO6ZPXgD34BZqviRJA3dQWZVpgi1TwVG/X5pmYQVjr+1gryfiAcoe
hHExfHuIjszRsde49Gy3vmRTECS9Dg9mbEaBAGUpfe2eP7TUqJt+FOQ4cP5mnCxH
aRgW8HZcdCKwOzyFnCBWXgRy2793VjcqdC0JM+UKccR5C8zHvMGOgdbbpsxwbVJK
9gcNrL8g4srwf87vg0ZLboSbS6H2xI8UjHh0m7l2VU2QoFAsuBPmpX8xDwtLAV/X
oVhD1K8cKwQbOZxw09Q2AKEsvw4GYhVrN6btjgJIy2Dd9Xtji/7GGPnTgAkkqHuH
cNFTx/q84/MtPLDv0jhs
=UXji
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
