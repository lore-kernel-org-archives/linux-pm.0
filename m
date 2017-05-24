From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V4 00/17] thermal: cpu_cooling: improve interaction with
 cpufreq core
Date: Tue, 23 May 2017 19:41:49 -0700
Message-ID: <20170524024148.GA5004@localhost.localdomain>
References: <cover.1493115651.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33961 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760192AbdEXCly (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2017 22:41:54 -0400
Content-Disposition: inline
In-Reply-To: <cover.1493115651.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linaro-kernel@lists.linaro.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Punit Agrawal <punit.agrawal@arm.com>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Tue, Apr 25, 2017 at 03:57:07PM +0530, Viresh Kumar wrote:
> Hi Guys,
>=20
> The cpu_cooling driver is designed to use CPU frequency scaling to avoid
> high thermal states for a platform. But it wasn't glued really well with
> cpufreq core. For example clipped-cpus is copied from the policy
> structure and its much better to use the policy->cpus (or related_cpus)
> fields directly as they may have got updated. Not that things were
> broken before this series, but they can be optimized a bit more.
>=20
> This series tries to improve interactions between cpufreq core and
> cpu_cooling driver and does some fixes/cleanups to the cpu_cooling
> driver.
>=20
> I have tested it on ARM 32 (exynos) and 64 bit (hikey) boards (haven't
> tested the power specific bits).
>=20
> Lukasz from ARM has been very generous in testing and finding out few
> bugs in the earlier versions and getting those fixed.  He has
> successfully tested the new version on his ARM big LITTLE Juno board.
>=20
> Pushed here as well:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git thermal/cool=
ing
>=20
> V3->V4:


Took this version into my -linus branch for the next merge window.
Including the patch to remove the checkpatch warning. But please send
an extra patch to fix the style pointed on patch 8.


--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZJPLjAAoJEA6VkvSQfF5TJ0YP/A3UjzaaqAjz/wmPdoCCuYQL
RGoioI/6+uIhmmDUe7/Mlq6fTeOiRxSR9fz148m7KIdT49CeYk8E6b8/MlgCaVx7
H1bUJvNCqXOX+XglTGZ+A16EtqX7aiWyGsRsVJDqM4OdoMWbOT0miwDUFoHIQd84
fUorBe3nM8MxWHaYJB4/BCd1JWn+sE/Jv3wC7rASZkV+hZkAWtrEzCXWYwr8WhMD
3wpa/Hzyy1aXSPBS9CapXZBlQHeAaT+LBR+5fJHVrznGPDWMyykOgs9uVpHziU3V
6ELJC/56qoAP3DnG19yy14I5pHwcI+D6QlFt7YVx5fMUAfto/xGyfeBEhd92plDo
tM1lMAXC0rTB08JDiJbdLFILav0YR3YZIPvDOtIfkguMDlHNIS148EbaDEDgVMad
N9BIo70hCx5aIN2uscaujM1zZukcZ7h1jpwRVXizcQQwaPH4B5Xce7HYc7y4R0Sh
QnMbi3Du5aRABbVtX9FO9vPit4r5zk1KcVv7UJpkHAzEdlyrnA6vTBT9qGA5Ryp2
VEl/ZTEx7YY144s/IYgUP0jPbi31VrrxiogwYn3QQJXgQWxbzBU83FZU8ACjJkBk
KYo60aitvuO3/6SVjbTQWODe4aIauCcyWKZBDmyO4EC9OzSrvPHMwEA7pU/atZXc
36FQ9N3JBhSDtFDKG0Eo
=UpBs
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
