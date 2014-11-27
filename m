From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 0/7] cpufreq: Register cooling device after policy is
 usable
Date: Thu, 27 Nov 2014 11:33:41 -0400
Message-ID: <20141127153339.GA22851@developer>
References: <cover.1416980447.git.viresh.kumar@linaro.org>
 <20141126175429.GA1826@developer>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:46327 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbaK0Pdv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Nov 2014 10:33:51 -0500
Received: by mail-qa0-f50.google.com with SMTP id w8so3381796qac.37
        for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2014 07:33:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141126175429.GA1826@developer>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, l.majewski@samsung.com


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2014 at 01:54:31PM -0400, Eduardo Valentin wrote:
> Hello Viresh,
>=20
> Thanks for providing a proposal.
>=20
> On Wed, Nov 26, 2014 at 11:22:55AM +0530, Viresh Kumar wrote:
> > Hi Rafael/Eduardo,
> >=20
> > Currently there is no callback for cpufreq drivers which is called once=
 the
> > policy is ready to be used. There are some requirements where such a ca=
llback is
> > required.
> >=20
> > One of them is registering a cooling device with the help of
> > of_cpufreq_cooling_register(). This routine tries to get 'struct cpufre=
q_policy'
> > for CPUs which isn't yet initialed at the time ->init() is called and s=
o we face
> > issues while registering the cooling device.
> >=20
> > Because we can't register cooling device from ->init(), we need a callb=
ack that
> > is called after the policy is ready to be used and hence ->usable() cal=
lback.
> >=20
> > The first patch fixes few formatting issues, so that the third patch do=
esn't
> > throw any checkpatch warnings. Second one fixes a potential bug in cpuf=
req-dt
> > driver. Third one introduces ->usable() callback which will be used in =
the
> > fourth patch.
> >=20
> > Last three are fixes for cooling core, which may be applied separately =
by
> > Eduardo if he wants. Sent them in this series as they were sort of conn=
ected
> > with cpufreq in general.
> >=20
> > Let me know if it still doesn't work properly.
>=20
> For the series, the last three patches somehow breaks things. I didn't
> not investigate the reason now, because, well, I think we should take
> one thing at a time.

It turns out that I could not reproduce the issue I saw. So, I am
assuming that was an issue in my environment.

Can you still post them separately? =20


>=20
> For the patches 1 to 4, I tried then and they do the trick. Now the
> sequencing is correct between cpufreq-dt and cpu cooling. That means I
> can also improve the thermal code by accepting the following patches:
> https://patchwork.kernel.org/patch/5326991/
> https://patchwork.kernel.org/patch/5387161/
>=20
> on top of the four first patches.
>=20
> Cheers,
>=20
> Eduardo Valentin
>=20
> >=20
> > --
> > viresh
> >=20
> > Viresh Kumar (7):
> >   cpufreq: Fix formatting issues in 'struct cpufreq_driver'
> >   cpufreq-dt: pass 'policy->related_cpus' to
> >     of_cpufreq_cooling_register()
> >   cpufreq: Introduce ->usable() callback for cpufreq drivers
> >   cpufreq-dt: register cooling device from ->usable() callback
> >   cpu_cooling: Don't match min/max frequencies for all CPUs on cooling
> >     register
> >   cpu_cooling: don't iterate over all allowed_cpus to update cpufreq
> >     policy
> >   cpu_cooling: No need to check is_cpufreq_valid()
> >=20
> >  drivers/cpufreq/cpufreq-dt.c  | 51 +++++++++++++++++++++++++----------=
-----
> >  drivers/cpufreq/cpufreq.c     |  5 ++++
> >  drivers/thermal/cpu_cooling.c | 44 ++++-------------------------------
> >  include/linux/cpufreq.h       | 54 +++++++++++++++++++++++------------=
--------
> >  4 files changed, 70 insertions(+), 84 deletions(-)
> >=20
> > --=20
> > 2.0.3.693.g996b0fd
> >=20



--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUd0RLAAoJEMLUO4d9pOJWoeAH/3LDupG2175gXzAcMOWF6Nl4
rWk0ybg+tOQBzlj6UHGx/GHzmfpf1dkY8NPizayGEnn88IZgMiy6STVP8xaVT7EN
G/Xw8g9mj1A3hmAS9vGIjr92+ooFvfIRjfCeDeUiGLE/VbH4SMfdpnEDkrhq0p/6
awzUykCUGYKKVIhvFrCF02TGX689QogG6nUUBcra7l98wRD5CmQziEN8pazswpFJ
DlqZqCzToZwdqXNt417QnGegR7GEp23fT2gRgO1Rp4MJH6Ztx6MKPzHiEGC1SctA
SQZkZUgcj48sQMl5VB5fRZHZKkeWLH9dimD+gdY8/KwEvTZfnlYluuho7EACxHc=
=fxNV
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
