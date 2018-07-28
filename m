From: Francisco Jerez <currojerez@riseup.net>
Subject: Re: [PATCH 4/4] cpufreq: intel_pstate: enable boost for Skylake Xeon
Date: Fri, 27 Jul 2018 22:34:03 -0700
Message-ID: <87bmarhqk4.fsf@riseup.net>
References: <20180605214242.62156-1-srinivas.pandruvada@linux.intel.com> <20180605214242.62156-5-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180605214242.62156-5-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net, mgorman@techsingularity.net
Cc: peterz@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, juri.lelli@redhat.com, viresh.kumar@linaro.org, ggherdovich@suse.cz, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Chris Wilson <chris@chris-wilson.co.uk>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Eero Tamminen <eero.t.tamminen@intel.com>
List-Id: linux-pm@vger.kernel.org

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> writes:

> Enable HWP boost on Skylake server and workstations.
>

Please revert this series, it led to significant energy usage and
graphics performance regressions [1].  The reasons are roughly the ones
we discussed by e-mail off-list last April: This causes the intel_pstate
driver to decrease the EPP to zero when the workload blocks on IO
frequently enough, which for the regressing benchmarks detailed in [1]
is a symptom of the workload being heavily IO-bound, which means they
won't benefit at all from the EPP boost since they aren't significantly
CPU-bound, and they will suffer a decrease in parallelism due to the
active CPU core using a larger fraction of the TDP in order to achieve
the same work, causing the GPU to have a lower power budget available,
leading to a decrease in system performance.

You may want to give a shot to my previous suggestion of using [2] in
order to detect whether the system is IO-bound, which you can use as an
indicator that the optimization implemented in this series cannot
possibly improve performance and can be expected to hurt energy usage.

Thanks.

[1] https://bugs.freedesktop.org/show_bug.cgi?id=3D107410
[2] https://patchwork.kernel.org/patch/10312259/

> Reported-by: Mel Gorman <mgorman@techsingularity.net>
> Tested-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index 70bf63bb4e0e..01c8da1f99db 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1794,6 +1794,12 @@ static const struct x86_cpu_id intel_pstate_cpu_ee=
_disable_ids[] =3D {
>  	{}
>  };
>=20=20
> +static const struct x86_cpu_id intel_pstate_hwp_boost_ids[] __initconst =
=3D {
> +	ICPU(INTEL_FAM6_SKYLAKE_X, core_funcs),
> +	ICPU(INTEL_FAM6_SKYLAKE_DESKTOP, core_funcs),
> +	{}
> +};
> +
>  static int intel_pstate_init_cpu(unsigned int cpunum)
>  {
>  	struct cpudata *cpu;
> @@ -1824,6 +1830,10 @@ static int intel_pstate_init_cpu(unsigned int cpun=
um)
>  			intel_pstate_disable_ee(cpunum);
>=20=20
>  		intel_pstate_hwp_enable(cpu);
> +
> +		id =3D x86_match_cpu(intel_pstate_hwp_boost_ids);
> +		if (id)
> +			hwp_boost =3D true;
>  	}
>=20=20
>  	intel_pstate_get_cpu_pstates(cpu);
> --=20
> 2.13.6

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCW1wASwAKCRCDmTidfVK/
WzinAP9iSIhkNZ+g1+eSnElRAH+Q8VZaIfmYeGtnPPGKS/ab/gD+KOvBXL2PzEQ2
Pt5N+XU+g7bHe0OT8uoxtAR77Xk0YUY=
=7by0
-----END PGP SIGNATURE-----
--==-=-=--
