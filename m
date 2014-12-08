From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V2 00/26] thermal: cpu_cooling: Fixes and cleanups
Date: Mon, 8 Dec 2014 16:01:52 -0400
Message-ID: <20141208200150.GA13589@developer>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:35153 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbaLHUKa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Dec 2014 15:10:30 -0500
Received: by mail-qa0-f49.google.com with SMTP id s7so3826236qap.22
        for <linux-pm@vger.kernel.org>; Mon, 08 Dec 2014 12:10:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, rui.zhang@intel.com, amit.daniel@samsung.com, javi.merino@arm.com, Chanwoo Choi <cw00.choi@samsung.com>, Hongbo Zhang <hongbo.zhang@linaro.com>, Kyungmin Park <kyungmin.park@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Shawn Guo <shawn.guo@linaro.org>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 04, 2014 at 09:41:42AM +0530, Viresh Kumar wrote:
> Hi Eduardo,
>=20
> Here is the second iteration of my cpu_cooling cleanups to make it work/l=
ook
> better. As discussed earlier I picked one of your patches as mine were de=
pendent
> on it. Have done some fixes to your patch as well.
>=20
> First few are updates to platform drivers to fix mask present in clip_cpu=
s.
> Next ones are cleanups of cpu_cooling.c to get things properly organized.
>=20
> Tested-on: Exynos5250 (Dual ARM Cortex A15).
> Rebased-over: v3.18-rc7
> Pushed here: git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.=
git
> thermal/cpu-cooling-fixes
>=20
> Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Hongbo Zhang <hongbo.zhang@linaro.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Lukasz Majewski <l.majewski@samsung.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
>=20
> V1->V2:
> - Dropped: cpu_cooling: Drop useless locking around idr_alloc/idr_remove
> - Fixed $Subject of patches to prefix with: "thermal: " before "cpu_cooli=
ng:"
> - Fixed some stupid mistakes highlighted by Eduardo and Javi.
>   - s/ERR_PTR(cpufreq_dev->id)/ERR_PTR(ret)
>   - s/sizeof(*cool_dev)/sizeof(*cpufreq_dev)
>=20


The series is good to me. The comments in the list regarding kerneldoc I
ammended myself. I also tested them and could not spot any problems. For
this reason, I will be attempting to send this series in a second round
for 3.19.

However, this series depend on your rework in cpufreq side. Is that
going in for 3.19?

Cheers,

> - Rebased over rc7 and that changed lots of things.
>   - list of cooling devices was already present in rc7, so my patch to do=
 the
>     same is gone.
>   - Other modifications done as well to fit with latest updates.
>=20
> Eduardo Valentin (1):
>   thermal: cpu_cooling: check for the readiness of cpufreq layer
>=20
> Viresh Kumar (25):
>   thermal: db8500: pass cpu_present_mask to cpufreq_cooling_register()
>   thermal: imx: pass cpu_present_mask to cpufreq_cooling_register()
>   thermal: exynos: pass cpu_present_mask to cpufreq_cooling_register()
>   thermal: cpu_cooling: random comment fixups
>   thermal: cpu_cooling: fix doc comment over struct
>     cpufreq_cooling_device
>   thermal: cpu_cooling: Add comment to clarify relation between cooling
>     state and frequency
>   thermal: cpu_cooling: Pass variable instead of its type to sizeof()
>   thermal: cpu_cooling: no need to set cpufreq_state to zero
>   thermal: cpu_cooling: no need to set cpufreq_dev to NULL
>   thermal: cpu_cooling: no need to initialze 'ret'
>   thermal: cpu_cooling: propagate error returned by idr_alloc()
>   thermal: cpu_cooling: Don't match min/max frequencies for all CPUs on
>     cooling register
>   thermal: cpu_cooling: don't iterate over all allowed_cpus to update
>     cpufreq policy
>   thermal: cpu_cooling: Don't check is_cpufreq_valid()
>   thermal: cpu_cooling: do error handling at the bottom in
>     __cpufreq_cooling_register()
>   thermal: cpu_cooling: initialize 'cpufreq_val' on registration
>   thermal: cpu_cooling: Merge cpufreq_apply_cooling() into
>     cpufreq_set_cur_state()
>   thermal: cpu_cooling: remove unnecessary wrapper get_cpu_frequency()
>   thermal: cpu_cooling: find max level during device registration
>   thermal: cpu_cooling: get_property() doesn't need to support GET_MAXL
>     anymore
>   thermal: cpu_cooling: use cpufreq_dev_list instead of
>     cpufreq_dev_count
>   thermal: cpu_cooling: Pass 'cpufreq_dev' to get_property()
>   thermal: cpu_cooling: Store frequencies in descending order
>   thermal: cpu_cooling: Use cpufreq_dev->freq_table for finding
>     level/freq
>   thermal: cpu_cooling: update copyright tags
>=20
>  drivers/thermal/cpu_cooling.c                      | 360 ++++++++-------=
------
>  drivers/thermal/db8500_cpufreq_cooling.c           |  10 +-
>  drivers/thermal/imx_thermal.c                      |   9 +-
>  drivers/thermal/samsung/exynos_thermal_common.c    |  12 +-
>  drivers/thermal/samsung/exynos_tmu.c               |   5 +-
>  drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   6 -
>  6 files changed, 148 insertions(+), 254 deletions(-)
>=20
> --=20
> 2.0.3.693.g996b0fd
>=20

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUhgOmAAoJEMLUO4d9pOJWSAwH/07H/Jp9/GgAwfv+3iAa5RUZ
jaIGAztTtb5W/XmlGGTF5voaM8TsqJBYf/XV8M51L3KL4COcB5+JCzBpXrjd/tT5
I6/dsxq+ylRLQ1rHEknzWQ/fjL1z4c22bWRiAOpyauwY1r8zehCF+CXZmAydyinA
E+3/9jSuxtzgJKd9/6OKcNur8N+xUJoaqpvpK+3cf4NBVXHc2jc3YdLxoss2Ys3J
k822FApMXWPTyxQWixB5dRAzbr0oEG0mltFJ//bvNKf6g0FhlfevOgQ+5psp2lps
hh2ILE9n0fKVZScA5slZ97X0Eo77etuU9H4A6sCLF2TW5onU6gLE41zouZjKRBo=
=FU2u
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
