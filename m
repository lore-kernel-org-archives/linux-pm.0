From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V4 00/17] thermal: cpu_cooling: improve interaction with
 cpufreq core
Date: Thu, 27 Apr 2017 09:26:08 -0700
Message-ID: <20170427162604.GB18276@localhost.localdomain>
References: <cover.1493115651.git.viresh.kumar@linaro.org>
 <ead65416-4833-6f36-81bd-c1673bb71514@arm.com>
 <20170426104752.GE1928@vireshk-i7>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34175 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932146AbdD0Q0K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Apr 2017 12:26:10 -0400
Content-Disposition: inline
In-Reply-To: <20170426104752.GE1928@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linaro-kernel@lists.linaro.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Punit Agrawal <punit.agrawal@arm.com>


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 26, 2017 at 04:17:52PM +0530, Viresh Kumar wrote:
> On 26-04-17, 11:41, Lukasz Luba wrote:
> > Hi Viresh,
> >=20
> > I went through the v4 code and it looks good to me.
> > Feel free to add for the v4 series
> > Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
>=20
> Thanks a lot for testing and reviewing the series.
>=20
> @Eduardo: Will you be able to pick it for 4.12 ?

I feel like this is late for 4.12 given that we are already -rc8.=20
Besides, it has gone through a couple of cycles of broken interactions
with IPA (now fixed).

So, I would prefer we give this series a bit more of testing time on
linux-next. I can pull it and put into linux-next after the coming
merge window is closed.

>=20
> --=20
> viresh

Thanks,

Eduardo=20

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZAhuWAAoJEA6VkvSQfF5T4HcQAI6lxvM98Mhtt57iWviTPzBX
6E4g5sQvdWMyKWPLbqBPSN3+wd+zBQWEdzL6UfeM5a/hutc4xvhqXXTrHvTwpQh3
81jmZKSsxod+A4K4RvQT2al4glSHni60wrEjLlj/xHeysIVPkvr/0MTqq9udmqQN
s/Gk+H0pAaNhrbvhxtBDXm4aghsrBc861c4AxVvW1rkeFgEm+EJUDjuJsGJXHJUA
+Wy1w8NvvXAnKNWxOI/Q8IxAH35uRWcAvckrp1ahaGgD6nabkESd3s1Fvo/35Xv+
HDeRi0XOHrCkkmJl5c/rDJObUzTzCQamP2z45SMcuIlL9dv+vNQibLazKHrCoCfg
ulrqAARatPikB+cN9LnlghpV/xQMDm1NixcYu+MhRp+SkRjlQkq5RIiBloTw2M05
t3JzdrD63ylWXZETX3MX6TLXIR4O+R37yl4IXknHctuz8XGlC/5FlQpKyHDVWiA8
j71/1wtCY/pm7LLsWS9pmyBOOwPCDt9quq+drpkPfanV7Y5rXDbzd2qDvyDIt5pR
+Mkt7nA2kT8cYmb8M+VsnOtbXpvvEL3sH6ih9XS+aj48GDCiXnivFiOuFIoQRp3t
3Cvz/JkkLhxDDtFf7jyqLOr5HAS2ZZ5wJkLVzAFBdBQGQt4T6wGSYgb30y8YuAoq
l85l/h1eT1GITvt3e1Wc
=BDNl
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
