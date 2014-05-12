From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH 4/5] intel_pstate: Remove C0 tracking
Date: Mon, 12 May 2014 05:27:25 +0300
Message-ID: <5370318D.2010309@semaphore.gr>
References: <1399579047-5792-1-git-send-email-dirk.j.brandewie@intel.com>	<1399579047-5792-5-git-send-email-dirk.j.brandewie@intel.com> <CADmjqpOnzRrB8gJsmHWG=4bvhERLovnKyP0Pcki_uVJ3qpfD0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADmjqpOnzRrB8gJsmHWG=4bvhERLovnKyP0Pcki_uVJ3qpfD0g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, dirk.brandewie@gmail.com, Dirk Brandewie <dirk.j.brandewie@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 12/05/2014 05:14 =CF=80=CE=BC, Stratos Karafotis wrote:
> From: Dirk Brandewie <dirk.j.brandewie@intel.com>
>=20
> Commit fcb6a15c intel_pstate: Take core C0 time into account for core=
 busy
> introduced a regression referenced below.  The issue with "lockup"
> after suspend that this commit was addressing is now dealt with in th=
e
> suspend path.
>=20
> References:
>    https://bugzilla.kernel.org/show_bug.cgi?id=3D66581
>    https://bugzilla.kernel.org/show_bug.cgi?id=3D75121
>=20
> Reported-by: Doug Smythies <dsmythies@telus.net>
> Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>=20
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_p=
state.c
> index bb20881..4c26faf 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -59,7 +59,6 @@ struct sample {
>         int32_t core_pct_busy;
>         u64 aperf;
>         u64 mperf;
> -       unsigned long long tsc;
>         int freq;
>  };
>=20
> @@ -100,7 +99,6 @@ struct cpudata {
>=20
>         u64     prev_aperf;
>         u64     prev_mperf;
> -       unsigned long long prev_tsc;
>         struct sample sample;
>  };
>=20
> @@ -561,46 +559,37 @@ static inline void intel_pstate_calc_busy(struc=
t
> cpudata *cpu,
>                                         struct sample *sample)
>  {
>         int32_t core_pct;
> -       int32_t c0_pct;
>=20
>         core_pct =3D div_fp(int_tofp((sample->aperf)),
>                         int_tofp((sample->mperf)));
>         core_pct =3D mul_fp(core_pct, int_tofp(100));
>         FP_ROUNDUP(core_pct);
>=20
> -       c0_pct =3D div_fp(int_tofp(sample->mperf), int_tofp(sample->t=
sc));
> -
>         sample->freq =3D fp_toint(
>                 mul_fp(int_tofp(cpu->pstate.max_pstate * 1000), core_=
pct));
>=20
> -       sample->core_pct_busy =3D mul_fp(core_pct, c0_pct);
> +       sample->core_pct_busy =3D core_pct;
>  }
>=20
>  static inline void intel_pstate_sample(struct cpudata *cpu)
>  {
>         u64 aperf, mperf;
> -       unsigned long long tsc;
>=20
>         rdmsrl(MSR_IA32_APERF, aperf);
>         rdmsrl(MSR_IA32_MPERF, mperf);
> -       tsc =3D native_read_tsc();
>=20
>         aperf =3D aperf >> FRAC_BITS;
>         mperf =3D mperf >> FRAC_BITS;
> -       tsc =3D tsc >> FRAC_BITS;
>=20
>         cpu->sample.aperf =3D aperf;
>         cpu->sample.mperf =3D mperf;
> -       cpu->sample.tsc =3D tsc;
>         cpu->sample.aperf -=3D cpu->prev_aperf;
>         cpu->sample.mperf -=3D cpu->prev_mperf;
> -       cpu->sample.tsc -=3D cpu->prev_tsc;
>=20
>         intel_pstate_calc_busy(cpu, &cpu->sample);
>=20
>         cpu->prev_aperf =3D aperf;
>         cpu->prev_mperf =3D mperf;
> -       cpu->prev_tsc =3D tsc;
>  }
>=20
>  static inline void intel_pstate_set_sample_time(struct cpudata *cpu)
> --
> 1.9.0
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

With this patch, my CPU (Core i7-3770 @ 3.90GHz) seems to never use low=
est
frequencies. Even on an idle system I get always ~2GHz. Normally,
on an idle system it used to be 1.6GHz.
On very small loads (mp3 decoding) the CPU goes up to 2.7G GHz (it used=
 to
be 1.6GHz)

Reverting, this patch on my local build, the problem is resolved.


Thanks,
Stratos Karafotis
