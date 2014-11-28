From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 00/26] thermal: cpu_cooling: Fixes and cleanups
Date: Fri, 28 Nov 2014 09:26:01 -0400
Message-ID: <20141128132559.GA23674@developer>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:52423 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbaK1N0M (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 08:26:12 -0500
Received: by mail-qa0-f41.google.com with SMTP id f12so4495817qad.0
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2014 05:26:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, rui.zhang@intel.com, Amit Daniel Kachhap <amit.daniel@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Hongbo Zhang <hongbo.zhang@linaro.com>, Kyungmin Park <kyungmin.park@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Shawn Guo <shawn.guo@linaro.org>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello Viresh,

On Fri, Nov 28, 2014 at 03:13:54PM +0530, Viresh Kumar wrote:
> Hi Eduardo,
>=20
> As you know I got into fixing cpu_cooling.c due to some cpufreq issues yo=
u and
> Lukasz were struggling with. I found some issues in cpu_cooling then and =
here
> are the fixes/cleanups.
>=20

Ok. No problem. As I mentioned before, good to have a review in the code
by someone with extra experience with cpufreq.=20

Well, I don't think there was an issue with cpufreq itself. The struggle
is with sequencing, specially during booting. The Linux booting sequencing,
when it comes to builtin module dependency and probing, does not help
much. So, we need to do some tricks with the APIs.


> Sorry for the long list. Haven't broken them into smaller sets as most of=
 the
> patches are very small, easy to review and inter-dependent. Only few of t=
hem
> should take more time to review. If this doesn't work out, let me know an=
d I
> will try to send separate inter-dependent sets.
>=20

I am fine with this approach, because now you are dealing with a single
target: refactoring cpu cooling code.


> Just apply whatever looks fine and I will update/resend the ones left in =
V2 if
> at required.

sure, I will have a look.

>=20
> First few are updates to platform drivers. Exynos fails to register after=
 few
> patches in this series as it doesn't handle -EPROBE_DEFER properly (repor=
ted
> that in reply to your patch as well). Others weren't setting clip_cpus pr=
operly
> and are fixed.

OK.=20

About Exynos, at which point/patch Exynos starts to fail?

As I mentioned in the thread about cpu cooling vs. cpufreq, I prefer to
update all users of the updated [of_]cpufreq_cooling_register API, if
you don't mind.=20

Can you please elaborate a little more about how this failure is
happening?

>=20
> Next ones are cleanups of cpu_cooling.c to get things properly organized.
>=20
> Let me know if I screwed it up completely.
>=20

hehehe.. Ok. I will let you know.

> Tested-on: Exynos5250 (Dual ARM Cortex A15).
> Rebased-over: v3.18-rc6
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
> Viresh Kumar (26):
>   thermal: db8500: pass cpu_present_mask to cpufreq_cooling_register()
>   thermal: imx: pass cpu_present_mask to cpufreq_cooling_register()
>   thermal: exynos: pass cpu_present_mask to cpufreq_cooling_register()
>   thermal: exynos: Handle -EPROBE_DEFER properly
>   cpu_cooling: random comment fixups
>   cpu_cooling: fix doc comment over struct cpufreq_cooling_device
>   cpu_cooling: Add comment to clarify relation between cooling state and
>     frequency
>   cpu_cooling: Pass variable instead of its type to sizeof()
>   cpu_cooling: no need to set cpufreq_state to zero
>   cpu_cooling: no need to set cpufreq_dev to NULL
>   cpu_cooling: propagate error returned by idr_alloc()
>   cpu_cooling: Don't match min/max frequencies for all CPUs on cooling
>     register
>   cpu_cooling: don't iterate over all allowed_cpus to update cpufreq
>     policy
>   cpu_cooling: Don't check is_cpufreq_valid()
>   cpu_cooling: do error handling at the bottom in
>     __cpufreq_cooling_register()
>   cpu_cooling: Drop useless locking around idr_alloc/idr_remove
>   cpu_cooling: Merge cpufreq_apply_cooling() into
>     cpufreq_set_cur_state()
>   cpu_cooling: Merge get_cpu_frequency() into cpufreq_set_cur_state()
>   cpu_cooling: find max level during device registration
>   cpu_cooling: get_property() doesn't need to support GET_MAXL anymore
>   cpu_cooling: create list of cpufreq_cooling_devices
>   cpu_cooling: use cpufreq_dev_list instead of cpufreq_dev_count
>   cpu_cooling: Pass 'cpufreq_dev' to get_property()
>   cpu_cooling: Store frequencies in descending order
>   cpu_cooling: Use cpufreq_dev->freq_table for finding level/freq
>   cpu_cooling: update copyright tags
>=20
>  drivers/thermal/cpu_cooling.c                   | 405 +++++++++---------=
------
>  drivers/thermal/db8500_cpufreq_cooling.c        |   5 +-
>  drivers/thermal/imx_thermal.c                   |   4 +-
>  drivers/thermal/samsung/exynos_thermal_common.c |  11 +-
>  drivers/thermal/samsung/exynos_tmu.c            |   4 +-
>  5 files changed, 153 insertions(+), 276 deletions(-)
>=20
> --=20
> 2.0.3.693.g996b0fd
>=20

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUeHfZAAoJEMLUO4d9pOJWI0YH/1JSUxp6K3Aal7ovbpHpAYOd
3EsD0ZEcVIbNfL+d64m9qnTxpt9Q3feIw97BiI7zoc6j4lbx6YVOzu0kjIIezNJk
wJIlGIj3PYWeLdatSqNSM66NxQWM7Dwou7fCfm2FJ6aVIvJYlL+L5Tjb6x8uNByG
kAp8jqn8nCDt5wI8YNVxkafwfFB2QgnCU9uY2CF3pEeAyj3aJ/zvFgVimvU80oii
Doj2fvM6YmXnjOXQzMi4hD+4Llxt9AhpSz8SsJ0psFyX/TY8iOx+iyrdX0sD+mti
JfLRxBUmtPYV18dvEUvLDFwuYbW7c2KBMh58QI189BV1vIFBnzNiqveEO53XCKo=
=9z50
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
