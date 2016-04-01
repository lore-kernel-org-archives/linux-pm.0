From: Stephane Gasparini <stephane.gasparini@linux.intel.com>
Subject: Re: [PATCH] x86: Calculate MHz using APERF/MPERF for cpuinfo and scaling_cur_freq
Date: Fri, 1 Apr 2016 10:16:42 +0200
Message-ID: <9222CD56-C603-449C-A049-E518DAFA6883@linux.intel.com>
References: <6e0c25e64e0fb65a42dfc63ad5f660302e07cd87.1459485198.git.len.brown@intel.com> <52f711be59539723358bea1aa3c368910a68b46d.1459485198.git.len.brown@intel.com> <20160401080328.GC3448@twins.programming.kicks-ass.net>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160401080328.GC3448@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Len Brown <lenb@kernel.org>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org


=E2=80=94
Steph




> On Apr 1, 2016, at 10:03 AM, Peter Zijlstra <peterz@infradead.org> wr=
ote:
>=20
> On Fri, Apr 01, 2016 at 12:37:00AM -0400, Len Brown wrote:
>> diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/=
aperfmperf.c
>> new file mode 100644
>> index 0000000..9380102
>> --- /dev/null
>> +++ b/arch/x86/kernel/cpu/aperfmperf.c
>> @@ -0,0 +1,76 @@
>> +/*
>> + * x86 APERF/MPERF KHz calculation
>> + * Used by /proc/cpuinfo and /sys/.../cpufreq/scaling_cur_freq
>> + *
>> + * Copyright (C) 2015 Intel Corp.
>> + * Author: Len Brown <len.brown@intel.com>
>> + *
>> + * This file is licensed under GPLv2.
>> + */
>> +
>> +#include <linux/jiffies.h>
>> +#include <linux/math64.h>
>> +#include <linux/percpu.h>
>> +#include <linux/smp.h>
>> +
>> +struct aperfmperf_sample {
>> +	unsigned int khz;
>> +	unsigned long jiffies;
>> +	unsigned long long aperf;
>> +	unsigned long long mperf;
>> +};
>> +
>> +static DEFINE_PER_CPU(struct aperfmperf_sample, samples);
>> +
>> +/*
>> + * aperfmperf_snapshot_khz()
>> + * On the current CPU, snapshot APERF, MPERF, and jiffies
>> + * unless we already did it within 100ms
>> + * calculate kHz, save snapshot
>> + */
>> +static void aperfmperf_snapshot_khz(void *dummy)
>> +{
>> +	unsigned long long aperf, aperf_delta;
>> +	unsigned long long mperf, mperf_delta;
>> +	unsigned long long numerator;
>=20
> 	u64 is less typing ;-)
>=20
>> +	struct aperfmperf_sample *s =3D &get_cpu_var(samples);
>> +
>> +	/* Cache KHz for 100 ms */
>> +	if (time_before(jiffies, s->jiffies + HZ/10))
>> +		goto out;
>=20
> This puts in a lower bound, but afaict there is no upper bound. Both
> users appear to be userspace controlled.
>=20
> That is; if userspace doesn't request a freq reading we can go withou=
t
> reading this for a very long time.
>=20
>> +
>> +	rdmsrl(MSR_IA32_APERF, aperf);
>> +	rdmsrl(MSR_IA32_MPERF, mperf);
>> +
>> +	aperf_delta =3D aperf - s->aperf;
>> +	mperf_delta =3D mperf - s->mperf;
>=20
> That means these delta's can be arbitrarily large, in fact the MSRs c=
an
> have wrapped however many times.

64 bits is 18 446 744 073 709 551 615

so even assuming a 10 GHz frequency if my math are good this is more th=
an
58 years before the MSR wrap around, assuming the device ran always at =
max
freq.



>=20
>> +
>> +	/*
>> +	 * There is no architectural guarantee that MPERF
>> +	 * increments faster than we can read it.
>> +	 */
>> +	if (mperf_delta =3D=3D 0)
>> +		goto out;
>> +
>> +	numerator =3D cpu_khz * aperf_delta;
>=20
> And since delta can be any 64bit value as per the msr range, this
> multiplication can overflow.
>=20
>> +	s->khz =3D div64_u64(numerator, mperf_delta);
>> +	s->jiffies =3D jiffies;
>> +	s->aperf =3D aperf;
>> +	s->mperf =3D mperf;
>> +
>> +out:
>> +	put_cpu_var(samples);
>> +}
>> +
>> +unsigned int aperfmperf_khz_on_cpu(int cpu)
>> +{
>> +	if (!cpu_khz)
>> +		return 0;
>> +
>> +	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
>> +		return 0;
>=20
> You could do the jiffy compare here; avoiding the IPI.
>=20
>> +
>> +	smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, 1);
>> +
>> +	return per_cpu(samples.khz, cpu);
>> +}
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
