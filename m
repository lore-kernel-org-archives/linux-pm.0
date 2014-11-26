From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 0/7] cpufreq: Register cooling device after policy is
 usable
Date: Wed, 26 Nov 2014 14:01:56 -0400
Message-ID: <20141126180154.GF1826@developer>
References: <cover.1416980447.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z0eOaCaDLjvTGF2l"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:47409 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455AbaKZSCR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 13:02:17 -0500
Received: by mail-qc0-f176.google.com with SMTP id i17so2467814qcy.21
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2014 10:02:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <cover.1416980447.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, l.majewski@samsung.com


--z0eOaCaDLjvTGF2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Viresh,

On Wed, Nov 26, 2014 at 11:22:55AM +0530, Viresh Kumar wrote:
> Hi Rafael/Eduardo,
>=20
> Currently there is no callback for cpufreq drivers which is called once t=
he
> policy is ready to be used. There are some requirements where such a call=
back is
> required.
>=20
> One of them is registering a cooling device with the help of
> of_cpufreq_cooling_register(). This routine tries to get 'struct cpufreq_=
policy'
> for CPUs which isn't yet initialed at the time ->init() is called and so =
we face
> issues while registering the cooling device.
>=20
> Because we can't register cooling device from ->init(), we need a callbac=
k that
> is called after the policy is ready to be used and hence ->usable() callb=
ack.
>=20
> The first patch fixes few formatting issues, so that the third patch does=
n't
> throw any checkpatch warnings. Second one fixes a potential bug in cpufre=
q-dt
> driver. Third one introduces ->usable() callback which will be used in the
> fourth patch.
>=20
> Last three are fixes for cooling core, which may be applied separately by
> Eduardo if he wants. Sent them in this series as they were sort of connec=
ted
> with cpufreq in general.
>=20

Thanks for taking the time to review that code. In fact, it is good to
have it under the eyes of someone with cpufreq experience. But, from my
smoke testing, looks like they introduce regressions.=20

Would you mind splitting them from this series and sending a separate
trhead? They do not help anyway to the original purpose of this series.


BR, Eduardo Valentin

> Let me know if it still doesn't work properly.
>=20
> --
> viresh
>=20
> Viresh Kumar (7):
>   cpufreq: Fix formatting issues in 'struct cpufreq_driver'
>   cpufreq-dt: pass 'policy->related_cpus' to
>     of_cpufreq_cooling_register()
>   cpufreq: Introduce ->usable() callback for cpufreq drivers
>   cpufreq-dt: register cooling device from ->usable() callback
>   cpu_cooling: Don't match min/max frequencies for all CPUs on cooling
>     register
>   cpu_cooling: don't iterate over all allowed_cpus to update cpufreq
>     policy
>   cpu_cooling: No need to check is_cpufreq_valid()
>=20
>  drivers/cpufreq/cpufreq-dt.c  | 51 +++++++++++++++++++++++++------------=
---
>  drivers/cpufreq/cpufreq.c     |  5 ++++
>  drivers/thermal/cpu_cooling.c | 44 ++++-------------------------------
>  include/linux/cpufreq.h       | 54 +++++++++++++++++++++++--------------=
------
>  4 files changed, 70 insertions(+), 84 deletions(-)
>=20
> --=20
> 2.0.3.693.g996b0fd
>=20

--z0eOaCaDLjvTGF2l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdhWIAAoJEMLUO4d9pOJWdKIH/i24cWvYmuPALJf1qOrn0oUR
yl/By1twle1leUPVEfj5k6BAvo7NJGG2MgaECx9S2U6o8DX250CYgYFy/IpTVrp+
9mN+afegWP4v10CKd4yU6Z3Dhor/ouAs9a8galXk//FtcFw3VjPSEf34m602OSA8
Iuw3CY0HQWrL+P+9lULKbqaYXOTnHmTCXGsyqqbU8U2VoqsHzfIFhv1FWrGvl8Zr
6NI/U0KILMT7wfppMXkVbcQPX41znQnVu1SY93PSao43BU5u68jEzkc5o6FGW12h
odPFYKphrA6XyP11l3sHHDqRblP51QDFEUYg2+uZPidtf5/liGux1AR+MxUgq7w=
=XsEe
-----END PGP SIGNATURE-----

--z0eOaCaDLjvTGF2l--
