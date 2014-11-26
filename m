From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 0/7] cpufreq: Register cooling device after policy is
 usable
Date: Wed, 26 Nov 2014 13:54:31 -0400
Message-ID: <20141126175429.GA1826@developer>
References: <cover.1416980447.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:39134 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbaKZRyl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 12:54:41 -0500
Received: by mail-qc0-f178.google.com with SMTP id b13so2665501qcw.23
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2014 09:54:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <cover.1416980447.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, l.majewski@samsung.com


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Viresh,

Thanks for providing a proposal.

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
> Let me know if it still doesn't work properly.

For the series, the last three patches somehow breaks things. I didn't
not investigate the reason now, because, well, I think we should take
one thing at a time.

For the patches 1 to 4, I tried then and they do the trick. Now the
sequencing is correct between cpufreq-dt and cpu cooling. That means I
can also improve the thermal code by accepting the following patches:
https://patchwork.kernel.org/patch/5326991/
https://patchwork.kernel.org/patch/5387161/

on top of the four first patches.

Cheers,

Eduardo Valentin

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

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdhPMAAoJEMLUO4d9pOJWAD8IAIp+8cKq8CTboi+3I0AJ7Bax
5Vb+S+ykAIWZSLQLDVUiWYSymHNDE7XnaPWh7RSGqzAY4rlzpIZ0AC44v3L/xs9L
X0B8UUgZBqKzRJsdxUf1uRXn+oCAvTcqQ5cpdeupSMZSGPt2yWV89dtOgNQJJxhW
qy9XGWoLuglrtQ2A4ZdBNrKgSOnhOO0mm0OE98nNK/4hkbsHovx0ryQLQ4cmZFqZ
f2ppo4WEZwctiq0KlVusFcVCoBytTOZuixgrAnN9KXE7cIh28B81NDRZlUVNUSRW
DWPb92CC/oa1CX+Mgo4eo9hXPv1iTWEJOIV9DpIhUCUL7GnhL8mykOl+LLJmOUg=
=rj94
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
